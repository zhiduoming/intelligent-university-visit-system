USE uni_tour;

START TRANSACTION;

SET @campus_sh = (
    SELECT c.id
    FROM campus c
             JOIN university u ON c.university_id = u.id
    WHERE u.name = '北京邮电大学'
      AND c.name = '沙河校区'
      AND c.is_deleted = 0
      AND u.is_deleted = 0
    LIMIT 1
);

SELECT IF(@campus_sh IS NULL, 1 / 0, @campus_sh) AS campus_check;

DELETE FROM poi
WHERE campus_id = @campus_sh
  AND name IN (
               '学生活动中心', '图书馆', '教工食堂', '风味餐厅', '学生餐厅',
               'S1智慧教学楼', 'S3工程试验楼', '雁北宿舍楼', '雁南宿舍楼',
               '体育场', 'S教学综合楼', 'N教学综合楼'
    );

INSERT INTO poi
(campus_id, name, category, suggested_duration, intro, hot_score, data_status, is_deleted)
VALUES
    (@campus_sh, '学生活动中心', 1, 30, '社团活动与学生事务集中区域。', 88, 1, 0),
    (@campus_sh, '图书馆', 2, 60, '学习与文献检索核心场所。', 95, 1, 0),
    (@campus_sh, '教工食堂', 3, 35, '教职工就餐区域。', 72, 1, 0),
    (@campus_sh, '风味餐厅', 3, 40, '多窗口风味餐饮区域。', 84, 1, 0),
    (@campus_sh, '学生餐厅', 3, 40, '学生日常就餐主区域。', 90, 1, 0),
    (@campus_sh, 'S1智慧教学楼', 2, 45, '教学与课程活动主要楼宇。', 87, 1, 0),
    (@campus_sh, 'S3工程试验楼', 2, 45, '实验教学与工程实践楼宇。', 85, 1, 0),
    (@campus_sh, '雁北宿舍楼', 3, 20, '学生住宿生活区域。', 78, 1, 0),
    (@campus_sh, '雁南宿舍楼', 3, 20, '学生住宿生活区域。', 79, 1, 0),
    (@campus_sh, '体育场', 4, 30, '跑步与体育活动场地。', 83, 1, 0),
    (@campus_sh, 'S教学综合楼', 2, 50, '综合教学与课程组织区域。', 86, 1, 0),
    (@campus_sh, 'N教学综合楼', 2, 50, '综合教学与课程组织区域。', 86, 1, 0);

COMMIT;
