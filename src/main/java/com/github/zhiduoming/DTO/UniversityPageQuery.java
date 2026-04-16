package com.github.zhiduoming.DTO;

import lombok.Data;

@Data
public class UniversityPageQuery {
    private Integer page = 1;
    private Integer size = 10;
    private String keyword;
    private String province;

    //保证page传递的安全
    public int safePage() {
        return (page == null || page < 1) ? 1 : page;
    }

    //如果一次性查的记录数太多，就进行限制，一次性最多查50条记录
    public int safeSize() {
        if (size == null || size < 1) {
            return 10;
        }
        return Math.min(size, 50);
    }
}
