package com.github.zhiduoming.common;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@Slf4j
@RestControllerAdvice
public class GlobalExceptionHandler {

    /**
     * 处理可预期的业务异常，并把具体错误信息返回给前端。
     */
    @ExceptionHandler(RuntimeException.class)
    public Result handleRuntimeException(RuntimeException e) {
        log.warn("业务异常：{}", e.getMessage());
        return Result.error(e.getMessage());
    }

    /**
     * 兜底处理未捕获异常，避免直接暴露系统错误细节。
     */
    @ExceptionHandler(Exception.class)
    public Result handleException(Exception e){
        log.error("系统异常",e);
        return Result.error("系统繁忙，请稍后重试");
    }
}
