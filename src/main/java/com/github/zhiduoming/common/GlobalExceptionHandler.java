package com.github.zhiduoming.common;

import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.multipart.MaxUploadSizeExceededException;
import org.springframework.web.servlet.resource.NoResourceFoundException;

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
     * 静态资源不存在属于普通 404，不应该按系统异常打 ERROR 日志。
     */
    @ResponseStatus(HttpStatus.NOT_FOUND)
    @ExceptionHandler(NoResourceFoundException.class)
    public Result handleNoResourceFoundException(NoResourceFoundException e) {
        log.debug("静态资源不存在：{}", e.getResourcePath());
        return Result.error("资源不存在");
    }

    /**
     * 上传文件超过配置限制时返回明确提示。
     */
    @ExceptionHandler(MaxUploadSizeExceededException.class)
    public Result handleMaxUploadSizeExceededException(MaxUploadSizeExceededException e) {
        log.warn("上传文件超过大小限制：{}", e.getMessage());
        return Result.error("上传图片不能超过 10MB");
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
