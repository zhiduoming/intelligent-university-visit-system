package com.github.zhiduoming.interceptor;

import com.github.zhiduoming.utils.JwtUtils;
import io.jsonwebtoken.Claims;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.jspecify.annotations.NonNull;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

@Component
public class LoginCheckInterceptor implements HandlerInterceptor {

    /**
     * 在进入业务接口前校验 JWT，并把 userId 放入 request 作用域。
     */
    @Override
    public boolean preHandle(HttpServletRequest request,
                             @NonNull HttpServletResponse response,
                             @NonNull Object handler) throws Exception {
        if ("OPTIONS".equalsIgnoreCase(request.getMethod())) {
            return true;
        }

        String authorization = request.getHeader("Authorization");

        if (authorization == null || !authorization.startsWith("Bearer ")) {
            responseNotLogin(response);
            return false;
        }

        String token =authorization.substring(7);

        try{
            Claims claims = JwtUtils.parseToken(token);
            Long userId = Long.valueOf(claims.get("userId").toString());
            request.setAttribute("userId",userId);
            return true;
        }catch (Exception e){
            responseNotLogin(response);
            return false;
        }
    }

    /**
     * 返回统一的未登录响应。
     */
    private void responseNotLogin(HttpServletResponse response) throws Exception {
        response.setStatus(HttpServletResponse.SC_OK);
        response.setContentType("application/json;charset=UTF-8");
        response.getWriter().write("{\"code\":0,\"msg\":\"NOT_LOGIN\",\"data\":null}");
    }
}
