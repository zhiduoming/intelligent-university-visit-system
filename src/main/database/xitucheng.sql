START TRANSACTION;

-- 找到“北京邮电大学沙河校区”的 campus_id
SET @campus_sh = (
    SELECT id
    FROM campus
    WHERE name = '北京邮电大学沙河校区'
    LIMIT 1
);

-- 可选：先清理这些同名数据，避免重复插入
DELETE FROM poi
WHERE campus_id = @campus_sh
  AND name IN (
               '学生活动中心','图书馆','教工食堂','风味餐厅','学生餐厅',
               'S1智慧教学楼','S3工程试验楼','雁北宿舍楼','雁南宿舍楼',
               '体育场','S教学综合楼','N教学综合楼'
    );

INSERT INTO poi
(campus_id, name, category, suggested_duration, intro, hot_score, data_status, create_time, update_time, is_deleted)
VALUES
    (1, '学生活动中心', 1, 30, '社团活动与学生事务集中区域。', 88, 1, NOW(), NOW(), 0),
    (1, '图书馆',       2, 60, '学习与文献检索核心场所。',       95, 1, NOW(), NOW(), 0),
    (1, '教工食堂',     3, 35, '教职工就餐区域。',               72, 1, NOW(), NOW(), 0),
    (1, '风味餐厅',     3, 40, '多窗口风味餐饮区域。',           84, 1, NOW(), NOW(), 0),
    (1, '学生餐厅',     3, 40, '学生日常就餐主区域。',           90, 1, NOW(), NOW(), 0),
    (1, 'S1智慧教学楼', 2, 45, '教学与课程活动主要楼宇。',       87, 1, NOW(), NOW(), 0),
    (1, 'S3工程试验楼', 2, 45, '实验教学与工程实践楼宇。',       85, 1, NOW(), NOW(), 0),
    (1, '雁北宿舍楼',   3, 20, '学生住宿生活区域。',             78, 1, NOW(), NOW(), 0),
    (1, '雁南宿舍楼',   3, 20, '学生住宿生活区域。',             79, 1, NOW(), NOW(), 0),
    (1, '体育场',       4, 30, '跑步与体育活动场地。',           83, 1, NOW(), NOW(), 0),
    (1, 'S教学综合楼',  2, 50, '综合教学与课程组织区域。',       86, 1, NOW(), NOW(), 0),
    (1, 'N教学综合楼',  2, 50, '综合教学与课程组织区域。',       86, 1, NOW(), NOW(), 0);

COMMIT;
