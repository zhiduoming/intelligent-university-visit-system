package com.github.zhiduoming.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class PageController {

    /**
     * 访问根路径时转发到静态首页。
     */
    @GetMapping("/")
    public String index() {
        return "forward:/index.html";
    }
}
