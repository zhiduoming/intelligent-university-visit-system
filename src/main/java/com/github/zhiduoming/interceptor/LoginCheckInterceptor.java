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
        if (isPublicReviewList(request)) {
            attachUserIfPresent(request);
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

    /**
     * 公开评价列表允许游客浏览；如果请求带了合法 JWT，则补充当前用户 ID，
     * 让列表能返回 likedByCurrentUser 这类“可选登录态”字段。
     */
    private void attachUserIfPresent(HttpServletRequest request) {
        String authorization = request.getHeader("Authorization");
        if (authorization == null || !authorization.startsWith("Bearer ")) {
            return;
        }
        String token = authorization.substring(7);
        try {
            Claims claims = JwtUtils.parseToken(token);
            Long userId = Long.valueOf(claims.get("userId").toString());
            request.setAttribute("userId", userId);
        } catch (Exception ignored) {
            request.removeAttribute("userId");
        }
    }

    /**
     * 评价列表属于公开浏览能力；发布评价、点赞、回复仍然需要登录。
     */
    private boolean isPublicReviewList(HttpServletRequest request) {
        return "GET".equalsIgnoreCase(request.getMethod())
                && request.getRequestURI().matches("^/api/v1/universities/\\d+/reviews$");
    }
}
