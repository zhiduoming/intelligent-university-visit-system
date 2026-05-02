USE uni_tour;

ALTER TABLE users
    ADD COLUMN profile_completed TINYINT NOT NULL DEFAULT 0 COMMENT '资料是否完善:0否/1是'
        AFTER current_uni_id;
