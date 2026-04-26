USE uni_tour;

START TRANSACTION;

SET @campus_hd = (
    SELECT c.id
    FROM campus c
             JOIN university u ON c.university_id = u.id
    WHERE u.name = '北京邮电大学'
      AND c.name = '西土城校区'
      AND c.is_deleted = 0
      AND u.is_deleted = 0
    LIMIT 1
);

SELECT IF(@campus_hd IS NULL, 1 / 0, @campus_hd) AS campus_check;

DELETE FROM poi
WHERE campus_id = @campus_hd
  AND name IN (
               '科学会堂', '教一楼', '教二楼', '教三楼', '教四楼',
               '体育场', '体育馆', '时光广场', '综合食堂', '学生活动中心',
               '学生食堂', '明光楼', '科研楼', '家属区', '行政办公楼',
               '学苑风味餐厅', '物美超市'
    );

INSERT INTO poi
(campus_id, name, category, suggested_duration, intro, hot_score, data_status, is_deleted)
VALUES
    (@campus_hd, '科学会堂', 1, 30, '会议讲座与活动举办场地。', 88, 1, 0),
    (@campus_hd, '教一楼', 2, 40, '课程教学楼。', 84, 1, 0),
    (@campus_hd, '教二楼', 2, 40, '课程教学楼。', 84, 1, 0),
    (@campus_hd, '教三楼', 2, 40, '课程教学楼。', 84, 1, 0),
    (@campus_hd, '教四楼', 2, 40, '课程教学楼。', 84, 1, 0),
    (@campus_hd, '体育场', 4, 30, '跑步与户外体育活动场地。', 82, 1, 0),
    (@campus_hd, '体育馆', 4, 35, '室内体育与赛事活动场地。', 83, 1, 0),
    (@campus_hd, '时光广场', 1, 20, '校园公共活动与休闲节点。', 80, 1, 0),
    (@campus_hd, '综合食堂', 3, 40, '校内综合就餐区域。', 90, 1, 0),
    (@campus_hd, '学生活动中心', 1, 30, '社团与学生事务活动区域。', 86, 1, 0),
    (@campus_hd, '学生食堂', 3, 40, '学生日常就餐区域。', 89, 1, 0),
    (@campus_hd, '明光楼', 2, 35, '教学与办公综合楼宇。', 78, 1, 0),
    (@campus_hd, '科研楼', 2, 45, '科研与实验相关楼宇。', 85, 1, 0),
    (@campus_hd, '家属区', 3, 20, '校园生活配套区域。', 68, 1, 0),
    (@campus_hd, '行政办公楼', 2, 25, '行政事务办理与办公区域。', 76, 1, 0),
    (@campus_hd, '学苑风味餐厅', 3, 40, '风味餐饮就餐区域。', 87, 1, 0),
    (@campus_hd, '物美超市', 3, 20, '日常购物与生活补给点。', 81, 1, 0);

COMMIT;
