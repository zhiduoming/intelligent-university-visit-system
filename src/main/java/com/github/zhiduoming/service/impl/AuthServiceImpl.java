package com.github.zhiduoming.service.impl;

import com.github.zhiduoming.common.RedisKeyConstants;
import com.github.zhiduoming.dto.ForgotPasswordDTO;
import com.github.zhiduoming.dto.LoginDTO;
import com.github.zhiduoming.dto.RegisterDTO;
import com.github.zhiduoming.vo.CaptchaVO;
import com.github.zhiduoming.vo.LoginVO;
import com.github.zhiduoming.mapper.UserMapper;
import com.github.zhiduoming.pojo.User;
import com.github.zhiduoming.service.AuthService;
import com.github.zhiduoming.utils.JwtUtils;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import java.security.SecureRandom;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.TimeUnit;

@Service
public class AuthServiceImpl implements AuthService {

    private static final String CAPTCHA_SOURCE = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789";
    private static final int CAPTCHA_LENGTH = 4;
    private static final long CAPTCHA_TTL_SECONDS = 300L;
    private static final SecureRandom RANDOM = new SecureRandom();



    private static final String PHONE_PATTERN = "^1[3-9]\\d{9}$";

    private final UserMapper userMapper;

    private final BCryptPasswordEncoder passwordEncoder;

    private final StringRedisTemplate stringRedisTemplate;

    //采用构造注入法
    public AuthServiceImpl(UserMapper userMapper, BCryptPasswordEncoder passwordEncoder, StringRedisTemplate stringRedisTemplate) {
        this.userMapper = userMapper;
        this.passwordEncoder = passwordEncoder;
        this.stringRedisTemplate = stringRedisTemplate;
    }

    /**
     * 生成注册时所需验证码并将其保存在 Redis
     *
     */

    @Override
    public CaptchaVO generateRegisterCaptcha() {
        String captchaId = UUID.randomUUID().toString();
        String code = randomCaptchaCode();

        stringRedisTemplate.opsForValue().set(
                RedisKeyConstants.registerCaptchaKey(captchaId),
                code,
                CAPTCHA_TTL_SECONDS,
                TimeUnit.SECONDS
        );
        return new CaptchaVO(captchaId,code,CAPTCHA_TTL_SECONDS);
    }

    /**
     * 校验注册参数，完成用户名查重和密码加密后写入数据库。
     */
    @Override
    public void register(RegisterDTO dto) {
        //1.校验参数
        if (dto == null) {
            throw new RuntimeException("请求参数不能为空");
        }

        if (dto.getUsername() == null || dto.getUsername().trim().isEmpty()) {
            throw new RuntimeException("用户名不能为空");
        }
        String username = dto.getUsername().trim();
        String phone = normalizePhone(dto.getPhone(), true);

        if (dto.getPassword() == null || dto.getPassword().length() < 6) {
            throw new RuntimeException("密码长度不能少于6位");
        }

        checkRegisterCaptcha(dto.getCaptchaId(), dto.getCaptchaCode());

        //2.根据用户名去数据库查重
        User exists = userMapper.selectByUsername(username);
        if (exists != null) {
            throw new RuntimeException("用户名已存在");
        }
        if (userMapper.selectByPhone(username) != null) {
            throw new RuntimeException("用户名已被占用");
        }
        if (userMapper.selectByPhone(phone) != null) {
            throw new RuntimeException("手机号已绑定其他账号");
        }
        if (userMapper.selectByUsername(phone) != null) {
            throw new RuntimeException("手机号已被其他账号作为用户名使用");
        }

        //3.获取对应的密码并进行加密
        String encodedPassword = passwordEncoder.encode(dto.getPassword());


        User user = new User();
        user.setUsername(username);
        user.setPhone(phone);
        user.setPassword(encodedPassword);
        user.setNickname(dto.getNickname() == null || dto.getNickname().trim().isEmpty()
                ? username
                : dto.getNickname().trim());

        user.setRole(0);
        user.setIdentityType(0);
        user.setStatus(1);
        user.setIsDeleted(0);
        userMapper.insert(user);

    }

    /**
     * 校验账号密码，登录成功后签发 JWT。账号可以是用户名或手机号。
     */
    @Override
    public LoginVO login(LoginDTO dto) {
        //校验参数
        if (dto == null) {
            throw new RuntimeException("请求参数不能为空");
        }
        if (dto.getUsername() == null || dto.getUsername().trim().isEmpty()) {
            throw new RuntimeException("账号不能为空");
        }
        if (dto.getPassword() == null || dto.getPassword().isEmpty()) {
            throw new RuntimeException("密码不能为空");
        }
        String loginAccount = dto.getUsername().trim();
        User user = userMapper.selectByUsernameOrPhone(loginAccount);

        //检验用户名是否存在、用户状态是否合法
        if (user == null || user.getStatus() == null || user.getStatus() != 1) {
            throw new RuntimeException("账号或密码错误");
        }
        //检验密码是否正确
        if (!passwordEncoder.matches(dto.getPassword(), user.getPassword())) {
            throw new RuntimeException("账号或密码错误");
        }
        //生成自定义信息放入 Payload
        Map<String,Object > claims = new HashMap<>();
        claims.put("userId",user.getId());
        claims.put("username",user.getUsername());
        //生成 jwt 令牌
        String token = JwtUtils.generateToken(claims);
        return new LoginVO(
                user.getId(),
                user.getUsername(),
                user.getPhone(),
                user.getNickname(),
                token
        );
    }

    /**
     * 用户名和绑定手机号都匹配时，允许用户重置密码。
     */
    @Override
    public void resetPassword(ForgotPasswordDTO dto) {
        if (dto == null) {
            throw new RuntimeException("请求参数不能为空");
        }
        if (dto.getUsername() == null || dto.getUsername().trim().isEmpty()) {
            throw new RuntimeException("用户名不能为空");
        }
        String username = dto.getUsername().trim();
        String phone = normalizePhone(dto.getPhone(), true);
        if (dto.getNewPassword() == null || dto.getNewPassword().length() < 6) {
            throw new RuntimeException("新密码长度不能少于6位");
        }

        User user = userMapper.selectByUsername(username);
        if (user == null || user.getStatus() == null || user.getStatus() != 1) {
            throw new RuntimeException("用户名或手机号不匹配");
        }
        if (user.getPhone() == null || !phone.equals(user.getPhone())) {
            throw new RuntimeException("用户名或手机号不匹配");
        }

        String encodedPassword = passwordEncoder.encode(dto.getNewPassword());
        int rows = userMapper.updatePasswordByUsernameAndPhone(username, phone, encodedPassword);
        if (rows == 0) {
            throw new RuntimeException("密码重置失败，请确认账号状态");
        }
    }

    private String normalizePhone(String phone, boolean required) {
        if (phone == null || phone.trim().isEmpty()) {
            if (required) {
                throw new RuntimeException("手机号不能为空");
            }
            return null;
        }
        String normalized = phone.trim();
        if (!normalized.matches(PHONE_PATTERN)) {
            throw new RuntimeException("手机号格式不正确");
        }
        return normalized;
    }
    private String randomCaptchaCode() {
        StringBuilder builder = new StringBuilder(CAPTCHA_LENGTH);
        for (int i = 0; i < CAPTCHA_LENGTH; i++) {
            builder.append(CAPTCHA_SOURCE.charAt(RANDOM.nextInt(CAPTCHA_SOURCE.length())));
        }
        return builder.toString();
    }
    private void checkRegisterCaptcha(String captchaId, String captchaCode) {
        if (captchaId == null || captchaId.trim().isEmpty()) {
            throw new RuntimeException("验证码标识不能为空");
        }
        if (captchaCode == null || captchaCode.trim().isEmpty()) {
            throw new RuntimeException("验证码不能为空");
        }

        String key = RedisKeyConstants.registerCaptchaKey(captchaId.trim());
        String cachedCode = stringRedisTemplate.opsForValue().get(key);

        if (cachedCode == null) {
            throw new RuntimeException("验证码已过期，请重新获取");
        }
        if (!cachedCode.equalsIgnoreCase(captchaCode.trim())) {
            throw new RuntimeException("验证码不正确");
        }

        stringRedisTemplate.delete(key);
    }

}
