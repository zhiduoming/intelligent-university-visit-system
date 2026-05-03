package com.github.zhiduoming.service.impl;

import com.github.zhiduoming.dto.UpdateProfileDTO;
import com.github.zhiduoming.mapper.UniversityMapper;
import com.github.zhiduoming.mapper.UserMapper;
import com.github.zhiduoming.pojo.User;
import com.github.zhiduoming.service.UserService;
import com.github.zhiduoming.vo.UniversityDetailVO;
import com.github.zhiduoming.vo.UniversityListVO;
import com.github.zhiduoming.vo.UserVO;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {

    private final UserMapper userMapper;
    private final UniversityMapper universityMapper;

    public UserServiceImpl(UserMapper userMapper, UniversityMapper universityMapper) {
        this.userMapper = userMapper;
        this.universityMapper = universityMapper;
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

        Long targetUniId = resolveUniversityId("目标高校", dto.getTargetUniId(), dto.getTargetUniName());
        Long currentUniId = resolveUniversityId("当前高校", dto.getCurrentUniId(), dto.getCurrentUniName());

        if (identityType == 1 && targetUniId == null) {
            throw new RuntimeException("高中生需要填写目标高校");
        }
        if ((identityType == 2 || identityType == 3) && currentUniId == null) {
            throw new RuntimeException("在校生或校友需要填写当前就读高校");
        }

        User updateUser = new User();
        updateUser.setId(userId);
        updateUser.setNickname(resolveNickname(dto.getNickname(), user));
        updateUser.setIdentityType(identityType);
        updateUser.setHighSchool(trimToNull(dto.getHighSchool()));
        updateUser.setTargetUniId(targetUniId);
        updateUser.setCurrentUniId(currentUniId);
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
                user.getPhone(),
                user.getNickname(),
                user.getAvatarUrl(),
                user.getRole(),
                user.getIdentityType(),
                user.getHighSchool(),
                user.getTargetUniId(),
                resolveUniversityName(user.getTargetUniId()),
                user.getCurrentUniId(),
                resolveUniversityName(user.getCurrentUniId()),
                user.getProfileCompleted()
        );
    }

    /**
     * 支持前端提交高校名称，同时保留高校 ID 提交能力以兼容旧请求。
     */
    private Long resolveUniversityId(String fieldName, Long universityId, String universityName) {
        String trimmedName = trimToNull(universityName);
        if (trimmedName == null) {
            if (universityId != null) {
                checkUniversityExists(fieldName, universityId);
            }
            return universityId;
        }

        List<UniversityListVO> universities = universityMapper.selectUniversitiesByExactName(trimmedName);
        if (universities == null || universities.isEmpty()) {
            throw new RuntimeException(fieldName + "不存在，请输入高校库中的完整名称或简称");
        }
        if (universities.size() > 1) {
            throw new RuntimeException(fieldName + "名称不唯一，请输入完整高校名称");
        }
        return universities.get(0).getId();
    }

    /**
     * 校验旧请求传入的高校 ID 是否真实存在。
     */
    private void checkUniversityExists(String fieldName, Long universityId) {
        UniversityDetailVO university = universityMapper.selectUniversityById(universityId);
        if (university == null) {
            throw new RuntimeException(fieldName + "不存在");
        }
    }

    /**
     * 将用户表中保存的高校 ID 转成人能读懂的高校名称。
     */
    private String resolveUniversityName(Long universityId) {
        if (universityId == null) {
            return null;
        }
        UniversityDetailVO university = universityMapper.selectUniversityById(universityId);
        return university == null ? null : university.getName();
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
