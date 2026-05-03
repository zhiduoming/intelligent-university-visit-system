package com.github.zhiduoming.common;

public class RedisKeyConstants {
    public static final String UNIVERSITY_DETAIL_KEY_PREFIX = "unitour:university:detail:";
    public static final String REGISTER_CAPTCHA_KEY_PREFIX = "unitour:auth:register-captcha:";


    private RedisKeyConstants() {
    }
    public static String universityDetailKey(Long universityId) {
        return UNIVERSITY_DETAIL_KEY_PREFIX + universityId;
    }

    public static String registerCaptchaKey(String captchaId) {
        return REGISTER_CAPTCHA_KEY_PREFIX + captchaId;
    }


}
