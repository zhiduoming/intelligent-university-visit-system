package com.github.zhiduoming.config;

import com.github.zhiduoming.interceptor.LoginCheckInterceptor;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    private final LoginCheckInterceptor loginCheckInterceptor;


    public WebConfig(LoginCheckInterceptor loginCheckInterceptor) {
        this.loginCheckInterceptor = loginCheckInterceptor;
    }

    /**
     * 注册登录拦截器，并放行认证接口、公开浏览接口和静态资源。
     */
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(loginCheckInterceptor)
                .addPathPatterns("/**")
                .excludePathPatterns(
                        "/api/v1/auth/register",
                        "/api/v1/auth/login",
                        "/api/v1/universities",
                        "/api/v1/universities/*",
                        "/api/v1/campuses/**",
                        "/universities/**",
                        "/campuses/**",
                        "/",
                        "/index.html",
                        "/universities.html",
                        "/campus-pois.html",
                        "/auth-center.html",
                        "/reviews.html",
                        "/wishes.html",
                        "/open-day.html",
                        "/css/**",
                        "/js/**",
                        "/images/**",
                        "/favicon.ico"
                );

    }
}
