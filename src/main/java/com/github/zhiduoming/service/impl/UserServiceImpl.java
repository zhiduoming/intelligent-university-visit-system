package com.github.zhiduoming.service.impl;

import com.github.zhiduoming.dto.UpdateProfileDTO;
import com.github.zhiduoming.mapper.UserMapper;
import com.github.zhiduoming.pojo.User;
import com.github.zhiduoming.service.UserService;
import com.github.zhiduoming.vo.UserVO;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {

    private final UserMapper userMapper;

    public UserServiceImpl(UserMapper userMapper) {
        this.userMapper = userMapper;
    }

    /**
     * 按用户 ID 查询当前用户，并转换成前端返回对象。
     */
    @Override
    public UserVO getCurrentUser(Long userId) {
        //调用 Mapper 层返回 User 对象
        User user = userMapper.selectById(userId);
        //判断用户状态
        checkUserAvailable(user);

        return buildUserVO(user);

    }

    /**
     * 校验资料完善请求，并更新用户身份、学校和完善状态。
     */
    @Override
    public UserVO updateProfile(Long userId, UpdateProfileDTO dto) {
        if (dto == null) {
            throw new RuntimeException("请求参数不能为空");
        }

        User user = userMapper.selectById(userId);
        checkUserAvailable(user);

        Integer identityType = dto.getIdentityType();
        if (identityType == null) {
            throw new RuntimeException("身份类型不能为空");
        }
        if (identityType < 1 || identityType > 4) {
            throw new RuntimeException("身份类型不合法");
        }

        if (identityType == 1 && dto.getTargetUniId() == null) {
            throw new RuntimeException("高中生需要填写目标高校");
        }
        if ((identityType == 2 || identityType == 3) && dto.getCurrentUniId() == null) {
            throw new RuntimeException("在校生或校友需要填写当前就读高校");
        }

        User updateUser = new User();
        updateUser.setId(userId);
        updateUser.setNickname(resolveNickname(dto.getNickname(), user));
        updateUser.setIdentityType(identityType);
        updateUser.setHighSchool(trimToNull(dto.getHighSchool()));
        updateUser.setTargetUniId(dto.getTargetUniId());
        updateUser.setCurrentUniId(dto.getCurrentUniId());
        updateUser.setProfileCompleted(1);

        int rows = userMapper.updateProfile(updateUser);
        if (rows != 1) {
            throw new RuntimeException("资料更新失败");
        }

        User latestUser = userMapper.selectById(userId);
        checkUserAvailable(latestUser);
        return buildUserVO(latestUser);
    }

    /**
     * 统一校验用户是否存在且状态可用。
     */
    private void checkUserAvailable(User user) {
        if (user == null || user.getStatus() == null || user.getStatus() != 1) {
            throw new RuntimeException("用户不存在或已被禁用");
        }
    }

    /**
     * 将数据库实体转换成返回给前端的用户视图对象。
     */
    private UserVO buildUserVO(User user) {
        return new UserVO(
                user.getId(),
                user.getUsername(),
                user.getNickname(),
                user.getAvatarUrl(),
                user.getRole(),
                user.getIdentityType(),
                user.getHighSchool(),
                user.getTargetUniId(),
                user.getCurrentUniId(),
                user.getProfileCompleted()
        );
    }

    /**
     * 处理资料更新时的昵称回填逻辑，避免把昵称更新成空字符串。
     */
    private String resolveNickname(String nickname, User user) {
        String trimmedNickname = trimToNull(nickname);
        if (trimmedNickname != null) {
            return trimmedNickname;
        }
        if (user.getNickname() != null && !user.getNickname().trim().isEmpty()) {
            return user.getNickname().trim();
        }
        return user.getUsername();
    }

    /**
     * 将空白字符串转成 null，便于统一保存。
     */
    private String trimToNull(String value) {
        if (value == null) {
            return null;
        }
        String trimmedValue = value.trim();
        return trimmedValue.isEmpty() ? null : trimmedValue;
    }

}
