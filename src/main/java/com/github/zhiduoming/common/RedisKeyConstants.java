package com.github.zhiduoming.common;

public class RedisKeyConstants {
    public static final String UNIVERSITY_DETAIL_KEY_PREFIX = "unitour:university:detail:";

    private RedisKeyConstants() {
    }

    public static String universityDetailKey(Long universityId) {
        return UNIVERSITY_DETAIL_KEY_PREFIX + universityId;
    }
}
