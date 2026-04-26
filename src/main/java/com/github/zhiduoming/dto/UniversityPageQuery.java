package com.github.zhiduoming.dto;

import lombok.Data;

@Data
public class UniversityPageQuery {
    private Integer page = 1;
    private Integer size = 10;
    private String keyword;
    private String province;
    private String city;

    /**
     * 对页码做兜底，避免出现小于 1 或空值的情况。
     */
    public int safePage() {
        return (page == null || page < 1) ? 1 : page;
    }

    /**
     * 对每页条数做限制，避免一次查询过多记录。
     */
    public int safeSize() {
        if (size == null || size < 1) {
            return 10;
        }
        return Math.min(size, 50);
    }
}
