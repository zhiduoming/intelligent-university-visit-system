package com.github.zhiduoming.mapper;

import com.github.zhiduoming.pojo.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface UserMapper {

    /**
     * 按用户名查询用户，供注册查重和登录校验使用。
     */
    User selectByUsername(@Param("username") String username);

    /**
     * 按手机号查询用户，供注册查重和忘记密码校验使用。
     */
    User selectByPhone(@Param("phone") String phone);

    /**
     * 按用户名或手机号查询用户，供登录校验使用。
     */
    User selectByUsernameOrPhone(@Param("loginAccount") String loginAccount);

    /**
     * 新增用户记录。
     */
    void insert(User user);

    /**
     * 按用户 ID 查询当前用户信息。
     */
    User selectById(@Param("id") Long userId);

    /**
     * 更新用户资料完善相关字段。
     */
    int updateProfile(User user);

    /**
     * 用户名和手机号都匹配时更新密码。
     */
    int updatePasswordByUsernameAndPhone(@Param("username") String username,
                                         @Param("phone") String phone,
                                         @Param("password") String password);
}
