USE uni_tour;

START TRANSACTION;

INSERT INTO university
(id, name, short_name, description, logo_url, official_website, is_985, is_211, is_double_first_class,
 school_type, education_level, tags, province, city, is_deleted)
VALUES
    (1, '北京邮电大学', '北邮',
     '信息与通信特色高校，V1 重点完善校区、POI、评价和评分数据。',
     'https://www.bupt.edu.cn', 'https://www.bupt.edu.cn',
     0, 1, 1, '理工', '本科', '两电一邮,双一流,211', '北京', '北京', 0),
    (2, '北京航空航天大学', '北航',
     '航空航天特色高校，V1 重点完善校区、POI、评价和评分数据。',
     'https://www.buaa.edu.cn', 'https://www.buaa.edu.cn',
     1, 1, 1, '理工', '本科', '国防七子,985,211,双一流', '北京', '北京', 0),
    (3, '清华大学', '清华', '占位数据，后续补充多维画像。', NULL, NULL,
     1, 1, 1, '综合', '本科', 'C9,985,211,双一流', '北京', '北京', 0),
    (4, '北京大学', '北大', '占位数据，后续补充多维画像。', NULL, NULL,
     1, 1, 1, '综合', '本科', 'C9,985,211,双一流', '北京', '北京', 0),
    (5, '上海交通大学', '上交', '占位数据，后续补充多维画像。', NULL, NULL,
     1, 1, 1, '综合', '本科', 'C9,985,211,双一流', '上海', '上海', 0),
    (6, '浙江大学', '浙大', '占位数据，后续补充多维画像。', NULL, NULL,
     1, 1, 1, '综合', '本科', 'C9,985,211,双一流', '浙江', '杭州', 0),
    (7, '南京大学', '南大', '占位数据，后续补充多维画像。', NULL, NULL,
     1, 1, 1, '综合', '本科', 'C9,985,211,双一流', '江苏', '南京', 0),
    (8, '电子科技大学', '电子科大', '占位数据，后续补充多维画像。', NULL, NULL,
     1, 1, 1, '理工', '本科', '两电一邮,985,211,双一流', '四川', '成都', 0),
    (9, '西安电子科技大学', '西电', '占位数据，后续补充多维画像。', NULL, NULL,
     0, 1, 1, '理工', '本科', '两电一邮,211,双一流', '陕西', '西安', 0),
    (10, '深圳大学', '深大', '占位数据，后续补充多维画像。', NULL, NULL,
     0, 0, 0, '综合', '本科', '地方重点,热门城市', '广东', '深圳', 0);

INSERT INTO campus
(id, university_id, name, address, province, city, lat, lng, description, main_gate, hot_score, data_status, is_deleted)
VALUES
    (1, 1, '西土城校区', '北京市海淀区西土城路10号', '北京', '北京', 39.968200, 116.353700,
     '北邮老校区，历史与科研氛围浓厚，周边生活便利。', '西土城路校门', 95, 1, 0),
    (2, 1, '沙河校区', '北京市昌平区沙河高教园', '北京', '北京', 40.164100, 116.280300,
     '北邮新校区，空间开阔，宿舍和运动空间较新。', '沙河校区南门', 88, 1, 0),
    (3, 2, '学院路校区', '北京市海淀区学院路37号', '北京', '北京', 39.981900, 116.348400,
     '北航主校区，教学科研核心区，区位优势明显。', '学院路校门', 96, 1, 0),
    (4, 2, '沙河校区', '北京市昌平区沙河高教园', '北京', '北京', 40.163500, 116.280900,
     '北航新校区，教学与生活功能完善。', '沙河校区东门', 89, 1, 0);

INSERT INTO campus
(university_id, name, address, province, city, lat, lng, description, main_gate, hot_score, data_status, is_deleted)
SELECT u.id,
       '主校区',
       CONCAT(u.city, '（地址待完善）'),
       u.province,
       u.city,
       NULL,
       NULL,
       '占位校区数据，后续补充。',
       '待完善',
       0,
       0,
       0
FROM university u
WHERE u.id >= 3;

INSERT INTO users
(id, username, password, nickname, avatar_url, role, identity_type, high_school,
 target_uni_id, current_uni_id, profile_completed, status, is_deleted)
VALUES
    (1, 'xiaochen', '123456', '小陈', NULL, 0, 2, '北京市第四中学', NULL, 1, 1, 1, 0),
    (2, 'user01', '123456', '测试01', NULL, 0, 1, '人大附中', 1, NULL, 1, 1, 0),
    (3, 'user02', '123456', '测试02', NULL, 0, 1, '衡水中学', 1, NULL, 1, 1, 0),
    (4, 'user03', '123456', '测试03', NULL, 0, 2, '成都七中', NULL, 1, 1, 1, 0),
    (5, 'user04', '123456', '测试04', NULL, 0, 2, '华师一附中', NULL, 2, 1, 1, 0),
    (6, 'admin01', '123456', '管理员', NULL, 9, 2, NULL, NULL, 1, 1, 1, 0);

INSERT INTO university_review
(id, user_id, university_id, campus_id, content,
 dormitory_score, canteen_score, location_score, study_score, culture_score, club_score, employment_score,
 campus_score, overall_score, is_anonymous, is_deleted)
VALUES
    (1, 2, 1, 2,
     '沙河校区空间大，宿舍和运动场地体验不错，去市区时间成本较高。适合能接受通勤距离、看重校园空间的同学。',
     5, 4, 3, 4, 4, 4, 5, 5, 4.25, 0, 0),
    (2, 3, 1, 1,
     '西土城校区位置更方便，周边生活成熟，学习和科研氛围更浓，但校园面积和住宿条件不如新校区。',
     3, 4, 5, 5, 4, 4, 5, 3, 4.13, 0, 0),
    (3, 4, 1, NULL,
     '北邮信息通信和计算机氛围很强，就业方向清晰。不同校区生活体验差异明显，报考前要看清专业所在校区。',
     4, 4, 4, 5, 4, 4, 5, 4, 4.25, 1, 0),
    (4, 5, 2, 3,
     '学院路校区区位很好，航空航天特色明显，学习压力偏高，但资源集中，适合目标明确的同学。',
     4, 4, 5, 5, 4, 4, 5, 4, 4.38, 0, 0);

COMMIT;
