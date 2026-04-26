package com.github.zhiduoming.mapper;

import com.github.zhiduoming.pojo.User;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UserMapper {

    /**
     * 按用户名查询用户，供注册查重和登录校验使用。
     */
    User selectByUsername(String username);

    /**
     * 新增用户记录。
     */
    void insert(User user);

    /**
     * 按用户 ID 查询当前用户信息。
     */
    User selectById(Long userId);

    /**
     * 更新用户资料完善相关字段。
     */
    int updateProfile(User user);
}
