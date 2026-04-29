package com.github.zhiduoming.service.impl;

import com.github.zhiduoming.dto.LoginDTO;
import com.github.zhiduoming.dto.RegisterDTO;
import com.github.zhiduoming.vo.LoginVO;
import com.github.zhiduoming.mapper.UserMapper;
import com.github.zhiduoming.pojo.User;
import com.github.zhiduoming.service.AuthService;
import com.github.zhiduoming.utils.JwtUtils;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;


@Service
public class AuthServiceImpl implements AuthService {

    private final UserMapper userMapper;

    private final BCryptPasswordEncoder passwordEncoder;

    //采用构造注入法
    public AuthServiceImpl(UserMapper userMapper, BCryptPasswordEncoder passwordEncoder) {
        this.userMapper = userMapper;
        this.passwordEncoder = passwordEncoder;
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

        if (dto.getPassword() == null || dto.getPassword().length() < 6) {
            throw new RuntimeException("密码长度不能少于6位");
        }

        //2.根据用户名去数据库查重
        User exists = userMapper.selectByUsername(username);
        if (exists != null) {
            throw new RuntimeException("用户名已存在");
        }

        //3.获取对应的密码并进行加密
        String encodedPassword = passwordEncoder.encode(dto.getPassword());


        User user = new User();
        user.setUsername(username);
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
     * 校验用户名密码，登录成功后签发 JWT。
     */
    @Override
    public LoginVO login(LoginDTO dto) {
        //校验参数
        if (dto == null) {
            throw new RuntimeException("请求参数不能为空");
        }
        if (dto.getUsername() == null || dto.getUsername().trim().isEmpty()) {
            throw new RuntimeException("用户名不能为空");
        }
        if (dto.getPassword() == null || dto.getPassword().isEmpty()) {
            throw new RuntimeException("密码不能为空");
        }
        String username = dto.getUsername().trim();
        User user = userMapper.selectByUsername(username);

        //检验用户名是否存在、用户状态是否合法
        if (user == null || user.getStatus() == null || user.getStatus() != 1) {
            throw new RuntimeException("用户名或密码错误");
        }
        //检验密码是否正确
        if (!passwordEncoder.matches(dto.getPassword(), user.getPassword())) {
            throw new RuntimeException("用户名或密码错误");
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
                user.getNickname(),
                token
        );
    }
}
