USE uni_tour;

-- UniTour 演示种子数据：补充高校画像与校区信息。
-- 说明：本文件用于本地开发和项目演示，不等同于权威高校数据库。

INSERT INTO university
(name, short_name, description, logo_url, official_website, is_985, is_211, is_double_first_class,
 school_type, education_level, tags, province, city, is_deleted)
VALUES
    ('北京邮电大学', '北邮',
     '信息与通信特色鲜明的理工类高校，适合重点观察通信、计算机、电子信息相关专业，以及西土城与沙河两个校区在生活便利度、通勤和学习氛围上的差异。',
     'https://www.bupt.edu.cn', 'https://www.bupt.edu.cn', 0, 1, 1, '理工', '本科',
     '两电一邮,信息通信,计算机,211,双一流', '北京', '北京', 0),
    ('北京航空航天大学', '北航',
     '航空航天和工程技术特色突出的研究型大学，学院路校区区位成熟，沙河校区空间更开阔，适合对比科研资源、生活环境和通勤成本。',
     'https://www.buaa.edu.cn', 'https://www.buaa.edu.cn', 1, 1, 1, '理工', '本科',
     '国防七子,航空航天,985,211,双一流', '北京', '北京', 0),
    ('清华大学', '清华',
     '综合实力突出的研究型大学，工科、理科和交叉学科资源集中，校园空间大，学习氛围强，适合从学业强度、科研机会和校园生活节奏进行观察。',
     'https://www.tsinghua.edu.cn', 'https://www.tsinghua.edu.cn', 1, 1, 1, '综合', '本科',
     'C9,985,211,双一流,强基计划', '北京', '北京', 0),
    ('北京大学', '北大',
     '以文理基础学科和综合学科生态见长的研究型大学，燕园人文氛围浓厚，适合关注通识教育、学术自由度、校园文化和城市资源。',
     'https://www.pku.edu.cn', 'https://www.pku.edu.cn', 1, 1, 1, '综合', '本科',
     'C9,985,211,双一流,综合研究型', '北京', '北京', 0),
    ('上海交通大学', '上交',
     '工程、医学、经管等学科实力突出的综合性大学，闵行校区面积大、学习生活功能完整，徐汇校区区位成熟，适合对比不同校区的学习和生活体验。',
     'https://www.sjtu.edu.cn', 'https://www.sjtu.edu.cn', 1, 1, 1, '综合', '本科',
     'C9,985,211,双一流,工科强校', '上海', '上海', 0),
    ('浙江大学', '浙大',
     '学科覆盖面广的综合性大学，多校区分布明显，紫金港校区生活与教学资源集中，适合观察大体量高校的校区差异和学习资源分布。',
     'https://www.zju.edu.cn', 'https://www.zju.edu.cn', 1, 1, 1, '综合', '本科',
     'C9,985,211,双一流,综合研究型', '浙江', '杭州', 0),
    ('南京大学', '南大',
     '基础学科和人文理科传统深厚的综合性大学，鼓楼校区城市区位成熟，仙林校区承载更多本科教学和生活场景。',
     'https://www.nju.edu.cn', 'https://www.nju.edu.cn', 1, 1, 1, '综合', '本科',
     'C9,985,211,双一流,基础学科', '江苏', '南京', 0),
    ('电子科技大学', '电子科大',
     '电子信息领域特色鲜明的理工类高校，清水河校区空间开阔，适合关注电子信息、计算机相关专业的学习强度、实验条件和就业去向。',
     'https://www.uestc.edu.cn', 'https://www.uestc.edu.cn', 1, 1, 1, '理工', '本科',
     '两电一邮,电子信息,985,211,双一流', '四川', '成都', 0),
    ('西安电子科技大学', '西电',
     '电子信息、通信、网络安全等方向特色明显，南校区承担大量本科生活和教学场景，适合与北邮、电子科大做同类院校对比。',
     'https://www.xidian.edu.cn', 'https://www.xidian.edu.cn', 0, 1, 1, '理工', '本科',
     '两电一邮,电子信息,211,双一流', '陕西', '西安', 0),
    ('深圳大学', '深大',
     '位于深圳的综合性大学，城市产业资源丰富，适合关注城市机会、实习便利度、就业导向和校园生活成本。',
     'https://www.szu.edu.cn', 'https://www.szu.edu.cn', 0, 0, 0, '综合', '本科',
     '地方重点,热门城市,深圳,就业资源', '广东', '深圳', 0),
    ('复旦大学', '复旦',
     '综合性研究型大学，文理医经管等学科资源丰富，上海城市资源突出，适合关注学术氛围、综合平台和城市实习机会。',
     'https://www.fudan.edu.cn', 'https://www.fudan.edu.cn', 1, 1, 1, '综合', '本科',
     'C9,985,211,双一流,上海', '上海', '上海', 0),
    ('中国科学技术大学', '中科大',
     '理科和前沿交叉学科特色鲜明的研究型大学，学术训练强度高，适合关注科研氛围、基础学科培养和学习压力。',
     'https://www.ustc.edu.cn', 'https://www.ustc.edu.cn', 1, 1, 1, '理工', '本科',
     'C9,985,211,双一流,基础学科', '安徽', '合肥', 0),
    ('哈尔滨工业大学', '哈工大',
     '工程技术和航天领域特色突出的理工类高校，形成哈尔滨、威海、深圳多校区格局，适合对比不同城市校区的资源和就业环境。',
     'https://www.hit.edu.cn', 'https://www.hit.edu.cn', 1, 1, 1, '理工', '本科',
     'C9,国防七子,985,211,双一流', '黑龙江', '哈尔滨', 0),
    ('中国人民大学', '人大',
     '人文社科、经济管理和法学特色突出的综合性大学，适合关注社科资源、实习机会、校园文化和北京区位优势。',
     'https://www.ruc.edu.cn', 'https://www.ruc.edu.cn', 1, 1, 1, '综合', '本科',
     '985,211,双一流,人文社科', '北京', '北京', 0),
    ('北京理工大学', '北理工',
     '工程技术、车辆、信息和国防特色明显的理工类高校，中关村校区区位成熟，良乡校区承载较多本科生活场景。',
     'https://www.bit.edu.cn', 'https://www.bit.edu.cn', 1, 1, 1, '理工', '本科',
     '国防七子,985,211,双一流', '北京', '北京', 0),
    ('同济大学', '同济',
     '建筑、土木、交通、设计等方向特色鲜明的综合性大学，上海区位优势明显，适合关注专业特色与城市资源结合。',
     'https://www.tongji.edu.cn', 'https://www.tongji.edu.cn', 1, 1, 1, '综合', '本科',
     '985,211,双一流,建筑土木', '上海', '上海', 0),
    ('华中科技大学', '华科',
     '工科、医学和综合学科实力突出的研究型大学，校园规模较大，适合观察学习资源、生活配套和武汉城市环境。',
     'https://www.hust.edu.cn', 'https://www.hust.edu.cn', 1, 1, 1, '综合', '本科',
     '985,211,双一流,工科,医学', '湖北', '武汉', 0),
    ('武汉大学', '武大',
     '综合性研究型大学，校园景观和人文氛围突出，学科覆盖面广，适合关注校园体验、基础学科和城市生活。',
     'https://www.whu.edu.cn', 'https://www.whu.edu.cn', 1, 1, 1, '综合', '本科',
     '985,211,双一流,综合研究型', '湖北', '武汉', 0),
    ('中山大学', '中大',
     '华南地区综合性研究型大学，多校区分布明显，适合关注广州、珠海、深圳等不同城市校区的学习生活差异。',
     'https://www.sysu.edu.cn', 'https://www.sysu.edu.cn', 1, 1, 1, '综合', '本科',
     '985,211,双一流,华南', '广东', '广州', 0),
    ('南开大学', '南开',
     '文理基础和经济管理传统较强的综合性大学，八里台校区历史氛围浓厚，津南校区空间更开阔。',
     'https://www.nankai.edu.cn', 'https://www.nankai.edu.cn', 1, 1, 1, '综合', '本科',
     '985,211,双一流,文理基础', '天津', '天津', 0)
ON DUPLICATE KEY UPDATE
    short_name = VALUES(short_name),
    description = VALUES(description),
    logo_url = VALUES(logo_url),
    official_website = VALUES(official_website),
    is_985 = VALUES(is_985),
    is_211 = VALUES(is_211),
    is_double_first_class = VALUES(is_double_first_class),
    school_type = VALUES(school_type),
    education_level = VALUES(education_level),
    tags = VALUES(tags),
    province = VALUES(province),
    city = VALUES(city),
    is_deleted = 0;

-- 将旧的“主校区/待完善”占位校区替换为更具体的主校区。
UPDATE campus c
    JOIN university u ON c.university_id = u.id
SET c.name = '清华园校区',
    c.address = '北京市海淀区清华园1号',
    c.description = '学校主体校区，教学、科研、图书馆、体育和生活资源集中，校园空间较大。',
    c.main_gate = '清华大学西门',
    c.hot_score = 98,
    c.data_status = 1
WHERE u.name = '清华大学' AND c.name = '主校区';

UPDATE campus c
    JOIN university u ON c.university_id = u.id
SET c.name = '燕园校区',
    c.address = '北京市海淀区颐和园路5号',
    c.description = '学校主体校区，人文氛围浓厚，教学楼、图书馆和生活区分布紧凑。',
    c.main_gate = '北京大学东门',
    c.hot_score = 98,
    c.data_status = 1
WHERE u.name = '北京大学' AND c.name = '主校区';

UPDATE campus c
    JOIN university u ON c.university_id = u.id
SET c.name = '闵行校区',
    c.address = '上海市闵行区东川路800号',
    c.description = '面积较大的主力校区，教学、生活、运动和科研空间完整，承担大量本科培养场景。',
    c.main_gate = '闵行校区思源门',
    c.hot_score = 95,
    c.data_status = 1
WHERE u.name = '上海交通大学' AND c.name = '主校区';

UPDATE campus c
    JOIN university u ON c.university_id = u.id
SET c.name = '紫金港校区',
    c.address = '浙江省杭州市西湖区余杭塘路866号',
    c.description = '浙大重要主校区之一，生活配套和教学资源集中，校园规模大。',
    c.main_gate = '紫金港校区东门',
    c.hot_score = 96,
    c.data_status = 1
WHERE u.name = '浙江大学' AND c.name = '主校区';

UPDATE campus c
    JOIN university u ON c.university_id = u.id
SET c.name = '仙林校区',
    c.address = '江苏省南京市栖霞区仙林大道163号',
    c.description = '本科教学和生活场景较集中的校区，空间开阔，学习和生活功能完整。',
    c.main_gate = '仙林校区南门',
    c.hot_score = 92,
    c.data_status = 1
WHERE u.name = '南京大学' AND c.name = '主校区';

UPDATE campus c
    JOIN university u ON c.university_id = u.id
SET c.name = '清水河校区',
    c.address = '四川省成都市高新区西源大道2006号',
    c.description = '电子科大主力校区之一，空间开阔，理工科教学和生活场景集中。',
    c.main_gate = '清水河校区南门',
    c.hot_score = 92,
    c.data_status = 1
WHERE u.name = '电子科技大学' AND c.name = '主校区';

UPDATE campus c
    JOIN university u ON c.university_id = u.id
SET c.name = '南校区',
    c.address = '陕西省西安市长安区西沣路兴隆段266号',
    c.description = '西电重要本科教学和生活校区，校园空间较大，学习生活功能完整。',
    c.main_gate = '南校区北门',
    c.hot_score = 90,
    c.data_status = 1
WHERE u.name = '西安电子科技大学' AND c.name = '主校区';

UPDATE campus c
    JOIN university u ON c.university_id = u.id
SET c.name = '粤海校区',
    c.address = '广东省深圳市南山区南海大道3688号',
    c.description = '深大核心校区之一，靠近深圳产业资源，城市实习和生活便利度较高。',
    c.main_gate = '粤海校区南门',
    c.hot_score = 91,
    c.data_status = 1
WHERE u.name = '深圳大学' AND c.name = '主校区';

-- 补充更多校区。使用 NOT EXISTS 保证脚本可重复执行，不会产生同名重复校区。
INSERT INTO campus
(university_id, name, address, province, city, lat, lng, description, main_gate, hot_score, data_status, is_deleted)
SELECT u.id, '徐汇校区', '上海市徐汇区华山路1954号', '上海', '上海', NULL, NULL,
       '历史较久、区位成熟的校区，周边城市资源丰富，适合观察老校区生活便利度。', '徐汇校区正门', 90, 1, 0
FROM university u
WHERE u.name = '上海交通大学'
  AND NOT EXISTS (SELECT 1 FROM campus c WHERE c.university_id = u.id AND c.name = '徐汇校区');

INSERT INTO campus
(university_id, name, address, province, city, lat, lng, description, main_gate, hot_score, data_status, is_deleted)
SELECT u.id, '玉泉校区', '浙江省杭州市西湖区浙大路38号', '浙江', '杭州', NULL, NULL,
       '工科传统较强的老校区，生活便利度较高，适合与紫金港校区进行体验对比。', '玉泉校区正门', 88, 1, 0
FROM university u
WHERE u.name = '浙江大学'
  AND NOT EXISTS (SELECT 1 FROM campus c WHERE c.university_id = u.id AND c.name = '玉泉校区');

INSERT INTO campus
(university_id, name, address, province, city, lat, lng, description, main_gate, hot_score, data_status, is_deleted)
SELECT u.id, '鼓楼校区', '江苏省南京市鼓楼区汉口路22号', '江苏', '南京', NULL, NULL,
       '历史底蕴较强的老校区，城市区位成熟，适合观察人文氛围和生活便利度。', '鼓楼校区校门', 89, 1, 0
FROM university u
WHERE u.name = '南京大学'
  AND NOT EXISTS (SELECT 1 FROM campus c WHERE c.university_id = u.id AND c.name = '鼓楼校区');

INSERT INTO campus
(university_id, name, address, province, city, lat, lng, description, main_gate, hot_score, data_status, is_deleted)
SELECT u.id, '沙河校区', '四川省成都市成华区建设北路二段4号', '四川', '成都', NULL, NULL,
       '电子科大老校区，城市生活便利度较高，适合与清水河校区对比。', '沙河校区校门', 85, 1, 0
FROM university u
WHERE u.name = '电子科技大学'
  AND NOT EXISTS (SELECT 1 FROM campus c WHERE c.university_id = u.id AND c.name = '沙河校区');

INSERT INTO campus
(university_id, name, address, province, city, lat, lng, description, main_gate, hot_score, data_status, is_deleted)
SELECT u.id, '北校区', '陕西省西安市雁塔区太白南路2号', '陕西', '西安', NULL, NULL,
       '西电老校区，区位较成熟，适合与南校区对比生活便利度和校园空间。', '北校区校门', 84, 1, 0
FROM university u
WHERE u.name = '西安电子科技大学'
  AND NOT EXISTS (SELECT 1 FROM campus c WHERE c.university_id = u.id AND c.name = '北校区');

INSERT INTO campus
(university_id, name, address, province, city, lat, lng, description, main_gate, hot_score, data_status, is_deleted)
SELECT u.id, '丽湖校区', '广东省深圳市南山区学苑大道1066号', '广东', '深圳', NULL, NULL,
       '较新的校园空间，环境开阔，适合与粤海校区对比城市距离和校园生活节奏。', '丽湖校区校门', 86, 1, 0
FROM university u
WHERE u.name = '深圳大学'
  AND NOT EXISTS (SELECT 1 FROM campus c WHERE c.university_id = u.id AND c.name = '丽湖校区');

INSERT INTO campus
(university_id, name, address, province, city, lat, lng, description, main_gate, hot_score, data_status, is_deleted)
SELECT u.id, '邯郸校区', '上海市杨浦区邯郸路220号', '上海', '上海', NULL, NULL,
       '复旦主要校区之一，教学、图书馆和生活资源集中，周边高校和城市资源丰富。', '邯郸校区正门', 95, 1, 0
FROM university u
WHERE u.name = '复旦大学'
  AND NOT EXISTS (SELECT 1 FROM campus c WHERE c.university_id = u.id AND c.name = '邯郸校区');

INSERT INTO campus
(university_id, name, address, province, city, lat, lng, description, main_gate, hot_score, data_status, is_deleted)
SELECT u.id, '江湾校区', '上海市杨浦区淞沪路2005号', '上海', '上海', NULL, NULL,
       '空间相对开阔，承载部分院系和科研教学场景，适合观察不同校区资源分布。', '江湾校区校门', 86, 1, 0
FROM university u
WHERE u.name = '复旦大学'
  AND NOT EXISTS (SELECT 1 FROM campus c WHERE c.university_id = u.id AND c.name = '江湾校区');

INSERT INTO campus
(university_id, name, address, province, city, lat, lng, description, main_gate, hot_score, data_status, is_deleted)
SELECT u.id, '西校区', '安徽省合肥市黄山路443号', '安徽', '合肥', NULL, NULL,
       '中科大重要教学科研校区之一，学术氛围浓，适合观察理工科高强度学习环境。', '西校区校门', 92, 1, 0
FROM university u
WHERE u.name = '中国科学技术大学'
  AND NOT EXISTS (SELECT 1 FROM campus c WHERE c.university_id = u.id AND c.name = '西校区');

INSERT INTO campus
(university_id, name, address, province, city, lat, lng, description, main_gate, hot_score, data_status, is_deleted)
SELECT u.id, '东校区', '安徽省合肥市金寨路96号', '安徽', '合肥', NULL, NULL,
       '中科大传统校区之一，区位成熟，学习和生活配套较集中。', '东校区校门', 88, 1, 0
FROM university u
WHERE u.name = '中国科学技术大学'
  AND NOT EXISTS (SELECT 1 FROM campus c WHERE c.university_id = u.id AND c.name = '东校区');

INSERT INTO campus
(university_id, name, address, province, city, lat, lng, description, main_gate, hot_score, data_status, is_deleted)
SELECT u.id, '一校区', '黑龙江省哈尔滨市南岗区西大直街92号', '黑龙江', '哈尔滨', NULL, NULL,
       '哈工大传统主校区，工科氛围浓厚，城市冬季气候和生活体验具有明显特征。', '一校区正门', 93, 1, 0
FROM university u
WHERE u.name = '哈尔滨工业大学'
  AND NOT EXISTS (SELECT 1 FROM campus c WHERE c.university_id = u.id AND c.name = '一校区');

INSERT INTO campus
(university_id, name, address, province, city, lat, lng, description, main_gate, hot_score, data_status, is_deleted)
SELECT u.id, '深圳校区', '广东省深圳市南山区西丽深圳大学城', '广东', '深圳', NULL, NULL,
       '位于深圳的校区，城市产业资源和实习机会更突出，适合与哈尔滨本部对比。', '深圳校区校门', 89, 1, 0
FROM university u
WHERE u.name = '哈尔滨工业大学'
  AND NOT EXISTS (SELECT 1 FROM campus c WHERE c.university_id = u.id AND c.name = '深圳校区');

INSERT INTO campus
(university_id, name, address, province, city, lat, lng, description, main_gate, hot_score, data_status, is_deleted)
SELECT u.id, '中关村校区', '北京市海淀区中关村大街59号', '北京', '北京', NULL, NULL,
       '人大核心校区，区位成熟，人文社科氛围和城市资源突出。', '中关村校区东门', 94, 1, 0
FROM university u
WHERE u.name = '中国人民大学'
  AND NOT EXISTS (SELECT 1 FROM campus c WHERE c.university_id = u.id AND c.name = '中关村校区');

INSERT INTO campus
(university_id, name, address, province, city, lat, lng, description, main_gate, hot_score, data_status, is_deleted)
SELECT u.id, '中关村校区', '北京市海淀区中关村南大街5号', '北京', '北京', NULL, NULL,
       '北理工传统校区，区位成熟，工程技术和国防特色资源集中。', '中关村校区校门', 91, 1, 0
FROM university u
WHERE u.name = '北京理工大学'
  AND NOT EXISTS (SELECT 1 FROM campus c WHERE c.university_id = u.id AND c.name = '中关村校区');

INSERT INTO campus
(university_id, name, address, province, city, lat, lng, description, main_gate, hot_score, data_status, is_deleted)
SELECT u.id, '良乡校区', '北京市房山区良乡高教园区', '北京', '北京', NULL, NULL,
       '承载较多本科生活和教学场景，校园空间更开阔，适合与中关村校区对比。', '良乡校区校门', 84, 1, 0
FROM university u
WHERE u.name = '北京理工大学'
  AND NOT EXISTS (SELECT 1 FROM campus c WHERE c.university_id = u.id AND c.name = '良乡校区');

INSERT INTO campus
(university_id, name, address, province, city, lat, lng, description, main_gate, hot_score, data_status, is_deleted)
SELECT u.id, '四平路校区', '上海市杨浦区四平路1239号', '上海', '上海', NULL, NULL,
       '同济传统主校区，建筑、土木、设计等专业氛围明显，城市区位成熟。', '四平路校区正门', 92, 1, 0
FROM university u
WHERE u.name = '同济大学'
  AND NOT EXISTS (SELECT 1 FROM campus c WHERE c.university_id = u.id AND c.name = '四平路校区');

INSERT INTO campus
(university_id, name, address, province, city, lat, lng, description, main_gate, hot_score, data_status, is_deleted)
SELECT u.id, '嘉定校区', '上海市嘉定区曹安公路4800号', '上海', '上海', NULL, NULL,
       '空间较开阔，承载部分工程和交通相关教学科研场景，适合对比通勤与校园空间。', '嘉定校区校门', 84, 1, 0
FROM university u
WHERE u.name = '同济大学'
  AND NOT EXISTS (SELECT 1 FROM campus c WHERE c.university_id = u.id AND c.name = '嘉定校区');

INSERT INTO campus
(university_id, name, address, province, city, lat, lng, description, main_gate, hot_score, data_status, is_deleted)
SELECT u.id, '主校区', '湖北省武汉市洪山区珞喻路1037号', '湖北', '武汉', NULL, NULL,
       '校园规模大，教学、科研、医疗和生活资源集中，适合观察大体量综合高校体验。', '主校区南大门', 93, 1, 0
FROM university u
WHERE u.name = '华中科技大学'
  AND NOT EXISTS (SELECT 1 FROM campus c WHERE c.university_id = u.id AND c.name = '主校区');

INSERT INTO campus
(university_id, name, address, province, city, lat, lng, description, main_gate, hot_score, data_status, is_deleted)
SELECT u.id, '珞珈山校区', '湖北省武汉市武昌区八一路299号', '湖北', '武汉', NULL, NULL,
       '武大主体校区，校园景观和人文氛围突出，教学生活资源集中。', '珞珈山校区校门', 96, 1, 0
FROM university u
WHERE u.name = '武汉大学'
  AND NOT EXISTS (SELECT 1 FROM campus c WHERE c.university_id = u.id AND c.name = '珞珈山校区');

INSERT INTO campus
(university_id, name, address, province, city, lat, lng, description, main_gate, hot_score, data_status, is_deleted)
SELECT u.id, '广州校区南校园', '广东省广州市海珠区新港西路135号', '广东', '广州', NULL, NULL,
       '中大传统校区之一，人文氛围和城市生活便利度较突出。', '南校园校门', 92, 1, 0
FROM university u
WHERE u.name = '中山大学'
  AND NOT EXISTS (SELECT 1 FROM campus c WHERE c.university_id = u.id AND c.name = '广州校区南校园');

INSERT INTO campus
(university_id, name, address, province, city, lat, lng, description, main_gate, hot_score, data_status, is_deleted)
SELECT u.id, '珠海校区', '广东省珠海市香洲区唐家湾', '广东', '珠海', NULL, NULL,
       '空间开阔，承载部分院系和本科生活场景，适合与广州校区对比城市和校园体验。', '珠海校区校门', 86, 1, 0
FROM university u
WHERE u.name = '中山大学'
  AND NOT EXISTS (SELECT 1 FROM campus c WHERE c.university_id = u.id AND c.name = '珠海校区');

INSERT INTO campus
(university_id, name, address, province, city, lat, lng, description, main_gate, hot_score, data_status, is_deleted)
SELECT u.id, '八里台校区', '天津市南开区卫津路94号', '天津', '天津', NULL, NULL,
       '南开传统校区，历史氛围浓厚，城市区位成熟，生活便利度较高。', '八里台校区校门', 91, 1, 0
FROM university u
WHERE u.name = '南开大学'
  AND NOT EXISTS (SELECT 1 FROM campus c WHERE c.university_id = u.id AND c.name = '八里台校区');

INSERT INTO campus
(university_id, name, address, province, city, lat, lng, description, main_gate, hot_score, data_status, is_deleted)
SELECT u.id, '津南校区', '天津市津南区海河教育园区同砚路38号', '天津', '天津', NULL, NULL,
       '空间较新的校区，生活和教学功能集中，适合与八里台校区对比。', '津南校区校门', 84, 1, 0
FROM university u
WHERE u.name = '南开大学'
  AND NOT EXISTS (SELECT 1 FROM campus c WHERE c.university_id = u.id AND c.name = '津南校区');

-- 修正已存在的北邮、北航校区地址，使用官方招生章程或官网页面可确认的信息。
UPDATE campus c
    JOIN university u ON c.university_id = u.id
SET c.address = '北京市海淀区西土城路10号',
    c.province = '北京',
    c.city = '北京',
    c.description = '北邮西土城路校区位于北京市海淀区西土城路10号，区位成熟，周边生活和交通便利。',
    c.main_gate = NULL,
    c.hot_score = 95,
    c.data_status = 1
WHERE u.name = '北京邮电大学' AND c.name = '西土城校区';

UPDATE campus c
    JOIN university u ON c.university_id = u.id
SET c.address = '北京市昌平区沙河镇南丰路1号',
    c.province = '北京',
    c.city = '北京',
    c.description = '北邮沙河校区位于北京市昌平区沙河高教园区，校园空间较开阔，承载大量本科教学和生活场景。',
    c.main_gate = NULL,
    c.hot_score = 88,
    c.data_status = 1
WHERE u.name = '北京邮电大学' AND c.name = '沙河校区';

UPDATE campus c
    JOIN university u ON c.university_id = u.id
SET c.address = '北京市海淀区学院路37号',
    c.province = '北京',
    c.city = '北京',
    c.description = '北航学院路校区位于北京市海淀区学院路37号，区位成熟，教学科研资源集中。',
    c.main_gate = NULL,
    c.hot_score = 96,
    c.data_status = 1
WHERE u.name = '北京航空航天大学' AND c.name = '学院路校区';

UPDATE campus c
    JOIN university u ON c.university_id = u.id
SET c.address = '北京市昌平区沙河高教园南三街9号',
    c.province = '北京',
    c.city = '北京',
    c.description = '北航沙河校区位于北京市昌平区沙河高教园南三街9号，校园空间更开阔，承载较多本科教学生活场景。',
    c.main_gate = NULL,
    c.hot_score = 89,
    c.data_status = 1
WHERE u.name = '北京航空航天大学' AND c.name = '沙河校区';

-- 对本文件维护的 20 所高校，未由官方来源确认的 main_gate 不写入，避免伪造“正门/南门”等细节。
UPDATE campus c
    JOIN university u ON c.university_id = u.id
SET c.main_gate = NULL
WHERE u.name IN (
    '北京邮电大学', '北京航空航天大学', '清华大学', '北京大学', '上海交通大学',
    '浙江大学', '南京大学', '电子科技大学', '西安电子科技大学', '深圳大学',
    '复旦大学', '中国科学技术大学', '哈尔滨工业大学', '中国人民大学', '北京理工大学',
    '同济大学', '华中科技大学', '武汉大学', '中山大学', '南开大学'
);

-- POI 补充：只写入官方页面中明确出现或可由现有项目数据确认的点位名称。
-- category: 1 景观/活动, 2 教学科研/图书馆, 3 生活餐饮/宿舍, 4 体育运动

INSERT INTO poi
(campus_id, name, category, suggested_duration, intro, hot_score, data_status, is_deleted)
SELECT c.id, '图书馆', 2, 45, '沙河校区已建成的学习与文献服务场所。', 92, 1, 0
FROM campus c JOIN university u ON c.university_id = u.id
WHERE u.name = '北京邮电大学' AND c.name = '沙河校区'
  AND NOT EXISTS (SELECT 1 FROM poi p WHERE p.campus_id = c.id AND p.name = '图书馆');

INSERT INTO poi
(campus_id, name, category, suggested_duration, intro, hot_score, data_status, is_deleted)
SELECT c.id, '图书馆', 2, 45, '玉泉校区图书馆，学习与文献资源场所。', 90, 1, 0
FROM campus c JOIN university u ON c.university_id = u.id
WHERE u.name = '浙江大学' AND c.name = '玉泉校区'
  AND NOT EXISTS (SELECT 1 FROM poi p WHERE p.campus_id = c.id AND p.name = '图书馆');

INSERT INTO poi
(campus_id, name, category, suggested_duration, intro, hot_score, data_status, is_deleted)
SELECT c.id, '邵逸夫科学馆', 2, 35, '玉泉校区教学科研相关楼宇。', 84, 1, 0
FROM campus c JOIN university u ON c.university_id = u.id
WHERE u.name = '浙江大学' AND c.name = '玉泉校区'
  AND NOT EXISTS (SELECT 1 FROM poi p WHERE p.campus_id = c.id AND p.name = '邵逸夫科学馆');

INSERT INTO poi
(campus_id, name, category, suggested_duration, intro, hot_score, data_status, is_deleted)
SELECT c.id, '邵逸夫体育馆', 4, 30, '玉泉校区体育活动场馆。', 83, 1, 0
FROM campus c JOIN university u ON c.university_id = u.id
WHERE u.name = '浙江大学' AND c.name = '玉泉校区'
  AND NOT EXISTS (SELECT 1 FROM poi p WHERE p.campus_id = c.id AND p.name = '邵逸夫体育馆');

INSERT INTO poi
(campus_id, name, category, suggested_duration, intro, hot_score, data_status, is_deleted)
SELECT c.id, '永谦活动中心', 1, 30, '玉泉校区文化与学生活动场所。', 82, 1, 0
FROM campus c JOIN university u ON c.university_id = u.id
WHERE u.name = '浙江大学' AND c.name = '玉泉校区'
  AND NOT EXISTS (SELECT 1 FROM poi p WHERE p.campus_id = c.id AND p.name = '永谦活动中心');

INSERT INTO poi
(campus_id, name, category, suggested_duration, intro, hot_score, data_status, is_deleted)
SELECT c.id, '竺可桢国际教育大楼', 2, 30, '玉泉校区教学与国际教育相关楼宇。', 82, 1, 0
FROM campus c JOIN university u ON c.university_id = u.id
WHERE u.name = '浙江大学' AND c.name = '玉泉校区'
  AND NOT EXISTS (SELECT 1 FROM poi p WHERE p.campus_id = c.id AND p.name = '竺可桢国际教育大楼');

INSERT INTO poi
(campus_id, name, category, suggested_duration, intro, hot_score, data_status, is_deleted)
SELECT c.id, '图书馆', 2, 45, '江湾校区图书馆，学习与文献服务场所。', 88, 1, 0
FROM campus c JOIN university u ON c.university_id = u.id
WHERE u.name = '复旦大学' AND c.name = '江湾校区'
  AND NOT EXISTS (SELECT 1 FROM poi p WHERE p.campus_id = c.id AND p.name = '图书馆');

INSERT INTO poi
(campus_id, name, category, suggested_duration, intro, hot_score, data_status, is_deleted)
SELECT c.id, '食堂', 3, 30, '江湾校区生活配套与日常就餐场所。', 84, 1, 0
FROM campus c JOIN university u ON c.university_id = u.id
WHERE u.name = '复旦大学' AND c.name = '江湾校区'
  AND NOT EXISTS (SELECT 1 FROM poi p WHERE p.campus_id = c.id AND p.name = '食堂');

INSERT INTO poi
(campus_id, name, category, suggested_duration, intro, hot_score, data_status, is_deleted)
SELECT c.id, '法学楼', 2, 35, '江湾校区教学科研楼宇。', 84, 1, 0
FROM campus c JOIN university u ON c.university_id = u.id
WHERE u.name = '复旦大学' AND c.name = '江湾校区'
  AND NOT EXISTS (SELECT 1 FROM poi p WHERE p.campus_id = c.id AND p.name = '法学楼');

INSERT INTO poi
(campus_id, name, category, suggested_duration, intro, hot_score, data_status, is_deleted)
SELECT c.id, '生命科学院楼', 2, 35, '江湾校区教学科研楼宇。', 84, 1, 0
FROM campus c JOIN university u ON c.university_id = u.id
WHERE u.name = '复旦大学' AND c.name = '江湾校区'
  AND NOT EXISTS (SELECT 1 FROM poi p WHERE p.campus_id = c.id AND p.name = '生命科学院楼');

INSERT INTO poi
(campus_id, name, category, suggested_duration, intro, hot_score, data_status, is_deleted)
SELECT c.id, '田径运动场', 4, 30, '江湾校区室外体育活动场地。', 80, 1, 0
FROM campus c JOIN university u ON c.university_id = u.id
WHERE u.name = '复旦大学' AND c.name = '江湾校区'
  AND NOT EXISTS (SELECT 1 FROM poi p WHERE p.campus_id = c.id AND p.name = '田径运动场');

INSERT INTO poi
(campus_id, name, category, suggested_duration, intro, hot_score, data_status, is_deleted)
SELECT c.id, '粤海校区北馆（汇典楼）', 2, 45, '深圳大学图书馆粤海校区北馆。', 88, 1, 0
FROM campus c JOIN university u ON c.university_id = u.id
WHERE u.name = '深圳大学' AND c.name = '粤海校区'
  AND NOT EXISTS (SELECT 1 FROM poi p WHERE p.campus_id = c.id AND p.name = '粤海校区北馆（汇典楼）');

INSERT INTO poi
(campus_id, name, category, suggested_duration, intro, hot_score, data_status, is_deleted)
SELECT c.id, '粤海校区南馆（汇智楼）', 2, 45, '深圳大学图书馆粤海校区南馆。', 86, 1, 0
FROM campus c JOIN university u ON c.university_id = u.id
WHERE u.name = '深圳大学' AND c.name = '粤海校区'
  AND NOT EXISTS (SELECT 1 FROM poi p WHERE p.campus_id = c.id AND p.name = '粤海校区南馆（汇智楼）');

INSERT INTO poi
(campus_id, name, category, suggested_duration, intro, hot_score, data_status, is_deleted)
SELECT c.id, '丽湖校区中央图书馆（启明楼）', 2, 45, '深圳大学图书馆丽湖校区中央图书馆。', 88, 1, 0
FROM campus c JOIN university u ON c.university_id = u.id
WHERE u.name = '深圳大学' AND c.name = '丽湖校区'
  AND NOT EXISTS (SELECT 1 FROM poi p WHERE p.campus_id = c.id AND p.name = '丽湖校区中央图书馆（启明楼）');
