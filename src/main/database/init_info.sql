-- UniTour fresh database seed.
-- Run order for a new local database:
--   1. schema.sql
--   2. init_info.sql
-- Earlier incremental alter and seed scripts have been merged into this file.

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
    (3, '清华大学', '清华', '初始化骨架数据，稍后由本脚本下方的演示数据覆盖。', NULL, NULL,
     1, 1, 1, '综合', '本科', 'C9,985,211,双一流', '北京', '北京', 0),
    (4, '北京大学', '北大', '初始化骨架数据，稍后由本脚本下方的演示数据覆盖。', NULL, NULL,
     1, 1, 1, '综合', '本科', 'C9,985,211,双一流', '北京', '北京', 0),
    (5, '上海交通大学', '上交', '初始化骨架数据，稍后由本脚本下方的演示数据覆盖。', NULL, NULL,
     1, 1, 1, '综合', '本科', 'C9,985,211,双一流', '上海', '上海', 0),
    (6, '浙江大学', '浙大', '初始化骨架数据，稍后由本脚本下方的演示数据覆盖。', NULL, NULL,
     1, 1, 1, '综合', '本科', 'C9,985,211,双一流', '浙江', '杭州', 0),
    (7, '南京大学', '南大', '初始化骨架数据，稍后由本脚本下方的演示数据覆盖。', NULL, NULL,
     1, 1, 1, '综合', '本科', 'C9,985,211,双一流', '江苏', '南京', 0),
    (8, '电子科技大学', '电子科大', '初始化骨架数据，稍后由本脚本下方的演示数据覆盖。', NULL, NULL,
     1, 1, 1, '理工', '本科', '两电一邮,985,211,双一流', '四川', '成都', 0),
    (9, '西安电子科技大学', '西电', '初始化骨架数据，稍后由本脚本下方的演示数据覆盖。', NULL, NULL,
     0, 1, 1, '理工', '本科', '两电一邮,211,双一流', '陕西', '西安', 0),
    (10, '深圳大学', '深大', '初始化骨架数据，稍后由本脚本下方的演示数据覆盖。', NULL, NULL,
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
       '初始化骨架校区，稍后由本脚本下方的演示数据覆盖。',
       '待完善',
       0,
       0,
       0
FROM university u
WHERE u.id >= 3;

-- Expand the base dataset to the current demo scope: 20 universities, logos, campuses, and selected POIs.

-- UniTour 演示种子数据：补充高校画像与校区信息。
-- 说明：本文件用于本地开发和项目演示，不等同于权威高校数据库。

INSERT INTO university
(name, short_name, description, logo_url, official_website, is_985, is_211, is_double_first_class,
 school_type, education_level, tags, province, city, is_deleted)
VALUES
    ('北京邮电大学', '北邮',
     '北京邮电大学是教育部直属、国家“双一流”“211 工程”重点建设高校，长期深耕信息通信领域，拥有“信息黄埔”的鲜明行业声誉。学校以信息科技为核心特色，信息与通信工程、计算机科学、电子科学、网络空间安全等方向实力突出，专业建设紧密对接通信、互联网、人工智能、集成电路和网络安全等前沿产业。西土城校区区位成熟、学习生活便利，沙河校区空间开阔、教学与住宿功能集中，两个校区共同承载了北邮工科训练强、竞赛科研活跃、就业导向清晰的校园气质。学校在强势工科之外，也推进管理、人文、艺术等多学科协调发展，社团活动、科创项目和文体生活较为丰富。整体来看，北邮是一所以信息技术人才培养见长、行业认可度高、深造和就业竞争力突出的特色型重点高校。',
     'https://www.bupt.edu.cn', 'https://www.bupt.edu.cn', 0, 1, 1, '理工', '本科',
     '两电一邮,信息通信,计算机,211,双一流', '北京', '北京', 0),
    ('北京航空航天大学', '北航',
     '北京航空航天大学是工业和信息化部直属高校，也是国家“双一流”“985 工程”“211 工程”重点建设高校，在航空航天、力学、仪器、控制、计算机、材料和交通运输等领域具有鲜明优势。学校兼具国防科技底色和综合研究型大学平台，科研项目密集、工程实践氛围浓厚，学生能够较早接触高水平实验室、学科竞赛和创新训练。学院路校区位于北京核心教育科研区域，区位成熟、资源集中；沙河校区空间更开阔，承担大量本科教学和生活场景，校园秩序感与学习强度都比较突出。北航的培养体系强调理工基础、工程能力和国家重大需求导向，毕业生在航空航天、信息技术、高端制造、互联网和科研院所等方向认可度较高，是典型的高强度、高资源、高发展预期的理工强校。',
     'https://www.buaa.edu.cn', 'https://www.buaa.edu.cn', 1, 1, 1, '理工', '本科',
     '国防七子,航空航天,985,211,双一流', '北京', '北京', 0),
    ('清华大学', '清华',
     '清华大学是国家“双一流”“985 工程”“211 工程”重点建设高校，也是国内综合实力最强的研究型大学之一。学校以工科传统起家，同时在理科、管理、人文社科、建筑、医学和交叉学科等方向形成完整而高水平的学科生态，科研平台、师资力量和国际交流资源都处于国内顶尖层级。清华园校园空间开阔，学习氛围强、学业要求高，学生在课程训练、科研项目、创新创业、竞赛实践和社团活动中都有较多选择，但也需要面对较高的时间管理和自我驱动要求。学校强调厚基础、强实践和跨学科能力培养，毕业生在深造、科研、产业、公共事务和创业等方向都有很强竞争力。对于希望接受高强度训练并争取顶级发展平台的学生而言，清华代表了极高的综合资源上限。',
     'https://www.tsinghua.edu.cn', 'https://www.tsinghua.edu.cn', 1, 1, 1, '综合', '本科',
     'C9,985,211,双一流,强基计划', '北京', '北京', 0),
    ('北京大学', '北大',
     '北京大学是国家“双一流”“985 工程”“211 工程”重点建设高校，拥有深厚的人文传统、理科基础和综合学科生态。学校在数学、物理、化学、生命科学、中文、历史、哲学、法学、经济、管理、医学等领域长期保持高水平实力，既适合追求基础学术训练的学生，也适合希望在社科、人文、医学和交叉方向深入发展的学生。燕园校园人文气息浓厚，学术自由度和课程选择空间较大，讲座、社团、学术讨论和公共议题参与都很活跃。北京区位带来丰富的科研机构、实习机会和文化资源，但也意味着学生需要更强的自我规划能力。整体来看，北大是一所学术底蕴深、学科覆盖广、思想氛围开放且发展路径多元的综合研究型大学。',
     'https://www.pku.edu.cn', 'https://www.pku.edu.cn', 1, 1, 1, '综合', '本科',
     'C9,985,211,双一流,综合研究型', '北京', '北京', 0),
    ('上海交通大学', '上交',
     '上海交通大学是国家“双一流”“985 工程”“211 工程”重点建设高校，也是国内工程、医学、管理和综合科研实力突出的高水平大学。学校在船舶海洋、机械、电子信息、计算机、材料、临床医学、管理科学等方向优势明显，学科布局既保留传统工科强项，也持续向人工智能、生物医药、集成电路和交叉创新延伸。闵行校区面积大、教学科研和生活功能完整，适合长期学习生活；徐汇校区历史底蕴深厚、城市区位成熟，能体现老交大的校园传统。上海产业资源、医疗资源和国际化环境为实习、科研合作和就业发展提供了明显加成。上交整体培养风格务实、工程实践和科研创新并重，毕业生在高端制造、信息技术、金融咨询、医疗健康和继续深造方向都有较强竞争力。',
     'https://www.sjtu.edu.cn', 'https://www.sjtu.edu.cn', 1, 1, 1, '综合', '本科',
     'C9,985,211,双一流,工科强校', '上海', '上海', 0),
    ('浙江大学', '浙大',
     '浙江大学是国家“双一流”“985 工程”“211 工程”重点建设高校，学科覆盖面广、综合实力强，是典型的大体量综合研究型大学。学校在工学、农学、医学、理学、管理、人文社科和信息技术等方向都有较完整布局，计算机、控制、光电、材料、农学、临床医学等领域具有较高影响力。浙大多校区格局明显，紫金港校区承载大量本科教学和生活场景，校园空间完整、生活配套成熟，也能体现大平台大学的资源密度。杭州的数字经济、互联网产业和创新创业环境，为学生实习、竞赛、科研转化和就业提供了较强城市支撑。浙大的特点是选择面宽、资源总量大、路径分化明显，适合目标明确、愿意主动争取科研和实践机会的学生。',
     'https://www.zju.edu.cn', 'https://www.zju.edu.cn', 1, 1, 1, '综合', '本科',
     'C9,985,211,双一流,综合研究型', '浙江', '杭州', 0),
    ('南京大学', '南大',
     '南京大学是国家“双一流”“985 工程”“211 工程”重点建设高校，以深厚的基础学科传统和综合研究实力著称。学校在天文、地质、物理、化学、中文、历史、哲学、数学、计算机、环境科学等方向具有鲜明优势，人文理科气质浓厚，学术训练扎实。鼓楼校区历史底蕴深、城市区位成熟，能感受到老校区的学术传统；仙林校区空间更完整，承载大量本科教学、住宿和日常校园生活。南大学生整体学习自驱力较强，讲座、科研训练和学术讨论氛围明显，校园生活相对沉稳内敛。学校适合重视学术深度、基础能力和长期发展潜力的学生，毕业生在深造、科研、互联网、金融、公共部门等方向都有较好认可度。',
     'https://www.nju.edu.cn', 'https://www.nju.edu.cn', 1, 1, 1, '综合', '本科',
     'C9,985,211,双一流,基础学科', '江苏', '南京', 0),
    ('电子科技大学', '电子科大',
     '电子科技大学是教育部直属、国家“双一流”“985 工程”“211 工程”重点建设高校，是电子信息领域特色极为鲜明的理工强校。学校以电子科学与技术、信息与通信工程、计算机科学、光学工程、网络空间安全等方向见长，专业设置和科研平台紧密服务电子信息产业链。清水河校区空间开阔、教学科研和生活功能较完整，校园节奏偏理工、学习和竞赛氛围较强；沙河等校区则承载部分学院和科研资源。成都的信息产业、电子制造、软件和新经济环境，为学生实习就业提供了现实支撑。电子科大的培养特点是专业集中度高、行业指向明确、工程训练扎实，毕业生在通信、芯片、互联网、网络安全、智能硬件和科研深造方向认可度较高。',
     'https://www.uestc.edu.cn', 'https://www.uestc.edu.cn', 1, 1, 1, '理工', '本科',
     '两电一邮,电子信息,985,211,双一流', '四川', '成都', 0),
    ('西安电子科技大学', '西电',
     '西安电子科技大学是教育部直属、国家“双一流”“211 工程”重点建设高校，是“两电一邮”成员之一，在电子信息、通信工程、计算机、网络空间安全、雷达与信号处理等方向具有深厚积累。学校长期服务电子信息和国防科技领域，工科底色鲜明，专业训练偏硬核，实验实践、学科竞赛和科研项目资源较丰富。南校区承担大量本科教学和住宿生活，空间开阔、功能分区明确；北校区历史底蕴更强，科研和部分学院资源集中。西安高校资源密集、生活成本相对友好，也适合学生在稳定环境中长期沉淀专业能力。西电整体特点是学科特色集中、行业认可度高、就业方向明确，尤其适合目标指向电子信息、通信、网络安全和军工相关领域的学生。',
     'https://www.xidian.edu.cn', 'https://www.xidian.edu.cn', 0, 1, 1, '理工', '本科',
     '两电一邮,电子信息,211,双一流', '陕西', '西安', 0),
    ('深圳大学', '深大',
     '深圳大学是深圳经济特区快速发展背景下成长起来的综合性大学，虽然不是传统 985、211 高校，但依托深圳城市产业和财政资源，近年在学科建设、科研平台和人才培养上发展很快。学校在计算机、电子信息、建筑、设计、管理、医学、传播等方向具备较强现实吸引力，尤其适合希望紧贴互联网、人工智能、金融科技、先进制造和创新创业环境的学生。校园地处深圳核心城市资源圈，实习机会、企业交流、创业氛围和就业便利度是重要优势。深大的校园生活相对开放、多元，城市节奏也会影响学生的实践导向和职业规划。整体来看，深大更适合看重城市平台、产业机会和个人主动性的学生，发展上限与深圳资源连接能力高度相关。',
     'https://www.szu.edu.cn', 'https://www.szu.edu.cn', 0, 0, 0, '综合', '本科',
     '地方重点,热门城市,深圳,就业资源', '广东', '深圳', 0),
    ('复旦大学', '复旦',
     '复旦大学是国家“双一流”“985 工程”“211 工程”重点建设高校，也是国内人文社科、理科、医学和综合研究实力突出的高水平大学。学校在新闻传播、经济管理、法学、中文、历史、哲学、数学、生命科学、临床医学、公共卫生等方向具有广泛影响力，学科生态开放且资源密集。邯郸、江湾、枫林、张江等校区承载不同学院和生活场景，既有老校区的人文气息，也有面向医学、科研和新兴学科的功能空间。上海的国际化环境、金融服务、传媒文化、医疗资源和科技产业为学生实习与就业提供了强支撑。复旦学生发展路径多元，既适合深耕学术，也适合走向金融、咨询、传媒、医疗、公共事务和互联网等领域。',
     'https://www.fudan.edu.cn', 'https://www.fudan.edu.cn', 1, 1, 1, '综合', '本科',
     'C9,985,211,双一流,上海', '上海', '上海', 0),
    ('中国科学技术大学', '中科大',
     '中国科学技术大学是中国科学院所属、国家“双一流”“985 工程”“211 工程”重点建设高校，以理科基础、前沿科学和高强度科研训练著称。学校在物理、数学、化学、天文、地球与空间科学、生命科学、计算机、量子信息、人工智能和交叉科学等方向具有突出优势，科研氛围浓厚，本科阶段就能接触较高水平的学术训练。中科大校园规模相对克制，学习节奏紧、课程要求高，学生整体自驱力强，适合愿意投入基础学科、前沿研究和长期深造的群体。合肥综合性城市资源不如一线城市密集，但大科学装置、科研院所和新兴科技产业为学校形成了独特生态。中科大的核心价值在于扎实学术训练、科研导向和深造质量，是典型的研究型人才培养高地。',
     'https://www.ustc.edu.cn', 'https://www.ustc.edu.cn', 1, 1, 1, '理工', '本科',
     'C9,985,211,双一流,基础学科', '安徽', '合肥', 0),
    ('哈尔滨工业大学', '哈工大',
     '哈尔滨工业大学是工业和信息化部直属、国家“双一流”“985 工程”“211 工程”重点建设高校，也是“国防七子”代表高校之一。学校以航天、机械、材料、控制、计算机、土木、环境和仪器等工程技术方向见长，长期服务国家重大工程和国防科技任务，工程训练体系扎实。哈工大形成哈尔滨、威海、深圳多校区格局，不同校区在城市资源、气候环境、产业连接和校园生活上差异明显：哈尔滨校区底蕴深厚，深圳校区区位和产业优势突出，威海校区生活环境更具海滨特点。学校学习风格务实严谨，科研项目和竞赛实践密度较高。整体来看，哈工大适合目标明确、愿意接受扎实工科训练并面向航天、高端制造、信息技术和科研院所发展的学生。',
     'https://www.hit.edu.cn', 'https://www.hit.edu.cn', 1, 1, 1, '理工', '本科',
     'C9,国防七子,985,211,双一流', '黑龙江', '哈尔滨', 0),
    ('中国人民大学', '人大',
     '中国人民大学是教育部直属、国家“双一流”“985 工程”“211 工程”重点建设高校，以人文社会科学、经济管理、法学、新闻传播、马克思主义理论和公共管理等方向见长。学校学科特色集中而鲜明，课程训练强调理论基础、现实问题意识和政策社会理解能力，北京区位带来丰富的智库、机关、媒体、金融机构和律所资源。人大校园规模相对紧凑，学习氛围较强，讲座、论坛、社团和公共议题讨论活跃，学生实习和职业规划意识普遍较早。相比综合工科强校，人大更适合对社会科学、公共治理、商业金融、法律实务和传媒传播有明确兴趣的学生。毕业生在公务公共部门、金融咨询、法律、媒体、学术深造和企事业单位中具有较强认可度。',
     'https://www.ruc.edu.cn', 'https://www.ruc.edu.cn', 1, 1, 1, '综合', '本科',
     '985,211,双一流,人文社科', '北京', '北京', 0),
    ('北京理工大学', '北理工',
     '北京理工大学是工业和信息化部直属、国家“双一流”“985 工程”“211 工程”重点建设高校，也是“国防七子”重要成员。学校在兵器科学、车辆工程、机械、光电、信息、控制、计算机、材料和航空航天相关方向具有鲜明优势，工程实践和国防科技特色突出。中关村校区区位成熟，周边高校和科研机构密集；良乡校区承载较多本科教学与生活场景，空间更开阔、功能更完整。北理工整体学习氛围务实，学生在科研训练、工程项目、创新竞赛和产业实习中有较多机会。北京的科研院所、央企军工、互联网和高端制造资源，也为学生就业和深造提供了强支撑。学校适合希望在工程技术、智能装备、信息科技和国防相关领域发展的学生。',
     'https://www.bit.edu.cn', 'https://www.bit.edu.cn', 1, 1, 1, '理工', '本科',
     '国防七子,985,211,双一流', '北京', '北京', 0),
    ('同济大学', '同济',
     '同济大学是国家“双一流”“985 工程”“211 工程”重点建设高校，以建筑、土木、交通、城乡规划、环境、设计和工程管理等方向特色鲜明，同时在医学、汽车、信息、理学和人文社科等领域持续发展。学校的专业气质和城市建设、工程实践、设计创新联系紧密，学生能够较多接触真实项目、行业资源和国际交流机会。四平路校区历史氛围浓厚，嘉定校区空间开阔且承载汽车、交通、机械等工程资源，校区体验差异明显。上海的设计、建筑、交通、咨询、汽车和国际化资源为学生提供了较强实践平台。同济整体适合对城市、建筑、工程系统、交通规划和设计创新有明确兴趣的学生，其毕业生在相关行业中具有较高辨识度和认可度。',
     'https://www.tongji.edu.cn', 'https://www.tongji.edu.cn', 1, 1, 1, '综合', '本科',
     '985,211,双一流,建筑土木', '上海', '上海', 0),
    ('华中科技大学', '华科',
     '华中科技大学是国家“双一流”“985 工程”“211 工程”重点建设高校，是工科、医学和综合学科实力突出的研究型大学。学校在机械、光电、能源、电气、计算机、自动化、公共卫生、临床医学、管理等方向具有明显优势，科研平台和工程实践资源丰富。同济医学院为学校医学与生命健康方向提供了强支撑，形成理工医结合的综合优势。华科校园规模大、树木覆盖率高，学习生活功能完整，学生整体学习氛围务实紧凑，竞赛、科研和就业导向都比较明显。武汉作为中部科教重镇，高校资源密集、生活成本相对友好，也提供较多实习和就业机会。华科适合希望在强工科、医学健康、信息技术和综合平台中发展的学生。',
     'https://www.hust.edu.cn', 'https://www.hust.edu.cn', 1, 1, 1, '综合', '本科',
     '985,211,双一流,工科,医学', '湖北', '武汉', 0),
    ('武汉大学', '武大',
     '武汉大学是国家“双一流”“985 工程”“211 工程”重点建设高校，兼具综合学科实力、深厚人文传统和鲜明校园景观。学校在测绘、遥感、法学、新闻传播、图书情报、马克思主义理论、水利、地球科学、生命科学、医学、计算机等方向具有较强优势，学科覆盖面广。珞珈山校园环境优美，历史建筑、人文氛围和公共活动空间辨识度很高，校园体验在全国高校中较具代表性。武大学生发展路径较多元，既有学术深造、科研训练，也有传媒、法律、金融、互联网、公共部门等职业方向。武汉城市高校资源密集，生活便利度较高。整体来看，武大适合重视综合平台、人文氛围、校园体验和多方向发展可能性的学生。',
     'https://www.whu.edu.cn', 'https://www.whu.edu.cn', 1, 1, 1, '综合', '本科',
     '985,211,双一流,综合研究型', '湖北', '武汉', 0),
    ('中山大学', '中大',
     '中山大学是国家“双一流”“985 工程”“211 工程”重点建设高校，是华南地区综合实力突出的研究型大学。学校在医学、生命科学、管理、中文、历史、哲学、数学、海洋科学、生态学、公共卫生和信息相关方向都有较强积累，学科覆盖面广。中大多校区、多城市办学特征明显，广州、珠海、深圳等校区在城市资源、专业分布、生活节奏和校园氛围上差异较大，需要结合具体学院判断真实体验。广州医学和综合学科资源深厚，深圳校区连接新兴产业，珠海校区空间开阔且具有滨海环境特点。中大整体适合希望在华南地区发展、重视综合平台和医学人文理工多学科资源的学生，毕业生在深造、医疗健康、公共部门、金融和科技产业中都有较好去向。',
     'https://www.sysu.edu.cn', 'https://www.sysu.edu.cn', 1, 1, 1, '综合', '本科',
     '985,211,双一流,华南', '广东', '广州', 0),
    ('南开大学', '南开',
     '南开大学是国家“双一流”“985 工程”“211 工程”重点建设高校，拥有深厚的文理基础、经济管理和化学学科传统。学校在经济学、数学、化学、历史、中文、哲学、政治学、统计、工商管理和生命科学等方向具有较强实力，学术风格相对沉稳扎实。八里台校区历史底蕴浓厚，校园尺度适中，城市区位成熟；津南校区空间更开阔，承载更多新的教学生活功能，不同校区体验差异需要结合学院具体判断。南开整体学习氛围较稳，学生在学术深造、金融经济、公共管理、教育科研和企事业单位就业方面都有较成熟路径。天津生活成本和城市节奏相对适中，适合希望在较稳定环境中接受综合型大学训练的学生。',
     'https://www.nankai.edu.cn', 'https://www.nankai.edu.cn', 1, 1, 1, '综合', '本科',
     '985,211,双一流,文理基础', '天津', '天津', 0),
    ('西安交通大学', '西安交大',
     '西安交通大学是教育部直属、国家“双一流”“985 工程”“211 工程”重点建设高校，也是 C9 高校成员之一，具有深厚的工科传统和鲜明的“西迁精神”底色。学校在动力工程、电气工程、机械、材料、管理、医学、信息、数学和工程教育等方向实力突出，科研平台和工程实践资源丰富。兴庆校区历史底蕴深厚，雁塔校区医学资源集中，曲江校区承载部分科研和研究生培养，中国西部科技创新港则体现大尺度科研平台和产学研融合特征，多校区差异非常明显。学校实行书院制培养，学生生活组织和学业支持体系较有特色。西安交大整体风格务实、强度较高，适合希望接受扎实工科或医学训练，并面向能源、电气、制造、信息、医疗、科研院所和高端产业发展的学生。',
     '/images/university-logos/21.png', 'https://www.xjtu.edu.cn', 1, 1, 1, '综合', '本科',
     'C9,985,211,双一流,西迁精神,工科强校', '陕西', '西安', 0),
    ('南京航空航天大学', '南航',
     '南京航空航天大学是工业和信息化部直属、国家“双一流”“211 工程”重点建设高校，也是“国防七子”成员之一，航空航天特色鲜明。学校在航空宇航科学与技术、力学、控制科学与工程、机械、电子信息、民航交通、材料和计算机等方向具有较强实力，专业建设紧密对接航空航天、民航、高端制造和国防科技需求。明故宫校区历史氛围和城市区位突出，将军路校区承载大量本科生活和教学场景，天目湖校区空间更新、功能更集中，多校区体验差异较大。南航学生工程实践、学科竞赛和科研训练机会较多，校园生活兼具理工强度和南京城市便利度。整体来看，南航适合对航空航天、飞行器、控制、民航和智能制造方向有兴趣，并希望在特色行业中形成专业竞争力的学生。',
     '/images/university-logos/22.png', 'https://www.nuaa.edu.cn', 0, 1, 1, '理工', '本科',
     '国防七子,航空航天,211,双一流,工信部', '江苏', '南京', 0),
    ('南京理工大学', '南理工',
     '南京理工大学是工业和信息化部直属、国家“双一流”“211 工程”重点建设高校，也是“国防七子”成员之一，源于哈军工分建体系，工程技术和国防科技底色鲜明。学校在兵器科学与技术、光学工程、化学工程、材料、机械、控制、电子信息、计算机和安全工程等方向具有较强实力，科研和工程实践资源与国防军工、高端制造联系紧密。孝陵卫校区位于南京主城，历史积淀、生活便利度和校园景观兼具；江阴校区空间更新、功能完整，承载新的教学生活场景。南理工整体学习风格务实，工程训练和项目实践较多，适合目标明确、愿意在装备制造、电子信息、材料化工、智能控制和国防相关领域发展的学生。学校就业行业辨识度较高，在长三角和军工体系中具有稳定认可度。',
     '/images/university-logos/23.png', 'https://www.njust.edu.cn', 0, 1, 1, '理工', '本科',
     '国防七子,兵器科学,211,双一流,工信部', '江苏', '南京', 0)
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

UPDATE university
SET logo_url = CASE name
    WHEN '北京邮电大学' THEN '/images/university-logos/1.jpg'
    WHEN '北京航空航天大学' THEN '/images/university-logos/2.jpg'
    WHEN '清华大学' THEN '/images/university-logos/3.jpg'
    WHEN '北京大学' THEN '/images/university-logos/4.jpg'
    WHEN '上海交通大学' THEN '/images/university-logos/5.jpg'
    WHEN '浙江大学' THEN '/images/university-logos/6.jpg'
    WHEN '南京大学' THEN '/images/university-logos/7.jpg'
    WHEN '电子科技大学' THEN '/images/university-logos/8.jpg'
    WHEN '西安电子科技大学' THEN '/images/university-logos/9.jpg'
    WHEN '深圳大学' THEN '/images/university-logos/10.jpg'
    WHEN '复旦大学' THEN '/images/university-logos/11.jpg'
    WHEN '中国科学技术大学' THEN '/images/university-logos/12.jpg'
    WHEN '哈尔滨工业大学' THEN '/images/university-logos/13.jpg'
    WHEN '中国人民大学' THEN '/images/university-logos/14.jpg'
    WHEN '北京理工大学' THEN '/images/university-logos/15.jpg'
    WHEN '同济大学' THEN '/images/university-logos/16.jpg'
    WHEN '华中科技大学' THEN '/images/university-logos/17.jpg'
    WHEN '武汉大学' THEN '/images/university-logos/18.jpg'
    WHEN '中山大学' THEN '/images/university-logos/19.jpg'
    WHEN '南开大学' THEN '/images/university-logos/20.jpg'
    WHEN '西安交通大学' THEN '/images/university-logos/21.png'
    WHEN '南京航空航天大学' THEN '/images/university-logos/22.png'
    WHEN '南京理工大学' THEN '/images/university-logos/23.png'
    ELSE logo_url
END
WHERE name IN (
    '北京邮电大学',
    '北京航空航天大学',
    '清华大学',
    '北京大学',
    '上海交通大学',
    '浙江大学',
    '南京大学',
    '电子科技大学',
    '西安电子科技大学',
    '深圳大学',
    '复旦大学',
    '中国科学技术大学',
    '哈尔滨工业大学',
    '中国人民大学',
    '北京理工大学',
    '同济大学',
    '华中科技大学',
    '武汉大学',
    '中山大学',
    '南开大学',
    '西安交通大学',
    '南京航空航天大学',
    '南京理工大学'
);

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
SELECT u.id, '兴庆校区', '陕西省西安市碑林区咸宁西路28号', '陕西', '西安', NULL, NULL,
       '西安交大传统主校区，本科教学、钱学森图书馆、书院生活和综合服务资源集中，适合观察老牌研究型大学的日常学习半径。', NULL, 96, 1, 0
FROM university u
WHERE u.name = '西安交通大学'
  AND NOT EXISTS (SELECT 1 FROM campus c WHERE c.university_id = u.id AND c.name = '兴庆校区');

INSERT INTO campus
(university_id, name, address, province, city, lat, lng, description, main_gate, hot_score, data_status, is_deleted)
SELECT u.id, '雁塔校区', '陕西省西安市雁塔区雁塔西路76号', '陕西', '西安', NULL, NULL,
       '医学和财经相关学习生活场景更集中，周边城市生活成熟，适合与兴庆校区对比专业分布和生活便利度。', NULL, 88, 1, 0
FROM university u
WHERE u.name = '西安交通大学'
  AND NOT EXISTS (SELECT 1 FROM campus c WHERE c.university_id = u.id AND c.name = '雁塔校区');

INSERT INTO campus
(university_id, name, address, province, city, lat, lng, description, main_gate, hot_score, data_status, is_deleted)
SELECT u.id, '曲江校区', '陕西省西安市雁塔区雁翔路99号', '陕西', '西安', NULL, NULL,
       '位于曲江片区，科研机构和新兴学科平台较集中，校园环境相对安静，适合观察科研型校区体验。', NULL, 86, 1, 0
FROM university u
WHERE u.name = '西安交通大学'
  AND NOT EXISTS (SELECT 1 FROM campus c WHERE c.university_id = u.id AND c.name = '曲江校区');

INSERT INTO campus
(university_id, name, address, province, city, lat, lng, description, main_gate, hot_score, data_status, is_deleted)
SELECT u.id, '中国西部科技创新港', '陕西省西咸新区沣西新城', '陕西', '西安', NULL, NULL,
       '创新港以科研、教育、转孵化和综合服务为主要功能，空间规模大，研究生教育和科研平台特征明显。', NULL, 90, 1, 0
FROM university u
WHERE u.name = '西安交通大学'
  AND NOT EXISTS (SELECT 1 FROM campus c WHERE c.university_id = u.id AND c.name = '中国西部科技创新港');

INSERT INTO campus
(university_id, name, address, province, city, lat, lng, description, main_gate, hot_score, data_status, is_deleted)
SELECT u.id, '明故宫校区', '江苏省南京市秦淮区御道街29号', '江苏', '南京', NULL, NULL,
       '南航传统校区，航空航天学科氛围浓，教学科研和校史文化资源集中，城市区位成熟。', NULL, 92, 1, 0
FROM university u
WHERE u.name = '南京航空航天大学'
  AND NOT EXISTS (SELECT 1 FROM campus c WHERE c.university_id = u.id AND c.name = '明故宫校区');

INSERT INTO campus
(university_id, name, address, province, city, lat, lng, description, main_gate, hot_score, data_status, is_deleted)
SELECT u.id, '将军路校区', '江苏省南京市江宁区将军大道29号', '江苏', '南京', NULL, NULL,
       '南航重要本科教学和生活校区，校园空间更开阔，学生发展、教学科研和生活服务点位较集中。', NULL, 90, 1, 0
FROM university u
WHERE u.name = '南京航空航天大学'
  AND NOT EXISTS (SELECT 1 FROM campus c WHERE c.university_id = u.id AND c.name = '将军路校区');

INSERT INTO campus
(university_id, name, address, province, city, lat, lng, description, main_gate, hot_score, data_status, is_deleted)
SELECT u.id, '天目湖校区', '江苏省常州市溧阳市滨河东路29号', '江苏', '常州', NULL, NULL,
       '南航位于溧阳的校区，空间较新，承载民航和通用航空相关学习生活场景。', NULL, 84, 1, 0
FROM university u
WHERE u.name = '南京航空航天大学'
  AND NOT EXISTS (SELECT 1 FROM campus c WHERE c.university_id = u.id AND c.name = '天目湖校区');

INSERT INTO campus
(university_id, name, address, province, city, lat, lng, description, main_gate, hot_score, data_status, is_deleted)
SELECT u.id, '南京校区', '江苏省南京市玄武区孝陵卫200号', '江苏', '南京', NULL, NULL,
       '南理工传统主校区，兵器科学与工程技术特色鲜明，教学、科研、图书馆、体育和校园文化资源集中。', NULL, 91, 1, 0
FROM university u
WHERE u.name = '南京理工大学'
  AND NOT EXISTS (SELECT 1 FROM campus c WHERE c.university_id = u.id AND c.name = '南京校区');

INSERT INTO campus
(university_id, name, address, province, city, lat, lng, description, main_gate, hot_score, data_status, is_deleted)
SELECT u.id, '江阴校区', '江苏省江阴市福星路8号', '江苏', '无锡', NULL, NULL,
       '南理工江阴校区是学校跨城市办学的重要组成，校园空间较新，适合与南京校区对比学习生活节奏。', NULL, 84, 1, 0
FROM university u
WHERE u.name = '南京理工大学'
  AND NOT EXISTS (SELECT 1 FROM campus c WHERE c.university_id = u.id AND c.name = '江阴校区');

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

-- 对本文件维护的高校，未由官方来源确认的 main_gate 不写入，避免伪造“正门/南门”等细节。
UPDATE campus c
    JOIN university u ON c.university_id = u.id
SET c.main_gate = NULL
WHERE u.name IN (
    '北京邮电大学', '北京航空航天大学', '清华大学', '北京大学', '上海交通大学',
    '浙江大学', '南京大学', '电子科技大学', '西安电子科技大学', '深圳大学',
    '复旦大学', '中国科学技术大学', '哈尔滨工业大学', '中国人民大学', '北京理工大学',
    '同济大学', '华中科技大学', '武汉大学', '中山大学', '南开大学',
    '西安交通大学', '南京航空航天大学', '南京理工大学'
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

-- Detailed Beijing University of Posts and Telecommunications POIs.

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
               '西门', '东门', '南门', '北门', '主楼', '教一楼', '教二楼', '教三楼',
               '教四楼', '教五楼', '教六楼', '教七楼', '第一实验楼', '第二实验楼',
               '第三实验楼', '第四实验楼', '第五实验楼', '第六实验楼', '第七实验楼',
               '第八实验楼', '第九实验楼', '第十实验楼', '图书馆', '行政办公楼',
               '科研楼', '未来学习大楼', '逸夫楼', '综合服务楼', '体育馆', '风雨操场',
               '标准田径场', '篮球场', '排球场', '网球场', '羽毛球场', '乒乓球场',
               '学生 1 公寓', '学生 2 公寓', '学生 3 公寓', '学生 4 公寓', '学生 5 公寓',
               '学生 6 公寓', '学生 7 公寓', '学生 8 公寓', '学生 9 公寓', '学生 10 公寓',
               '学生 11 公寓', '学生 12 公寓', '学生 13 公寓', '学生 14 公寓', '学生 15 公寓',
               '学生 16 公寓', '学一食堂', '学二食堂', '学三食堂', '清真食堂', '教工食堂',
               '风味餐厅', '校医院', '师生服务中心', '后勤服务中心', '菜鸟驿站',
               '校园快递中心', '校园超市', '教育超市', '时光广场', '校训石广场',
               '摩斯码路景观区', '中心绿地', '北湖景观区',
               '科学会堂', '体育场', '综合食堂', '学生活动中心', '学生食堂', '明光楼',
               '家属区', '学苑风味餐厅', '物美超市'
    );

INSERT INTO poi
(campus_id, name, category, suggested_duration, intro, hot_score, data_status, is_deleted)
VALUES
    (@campus_hd, '西门', 1, 15, '西土城路校区西侧出入口。', 84, 1, 0),
    (@campus_hd, '东门', 1, 15, '西土城路校区东侧出入口。', 82, 1, 0),
    (@campus_hd, '南门', 1, 15, '西土城路校区南侧出入口。', 82, 1, 0),
    (@campus_hd, '北门', 1, 15, '西土城路校区北侧出入口。', 80, 1, 0),
    (@campus_hd, '主楼', 2, 35, '西土城路校区核心教学办公楼宇。', 88, 1, 0),
    (@campus_hd, '教一楼', 2, 35, '课程教学和日常学习楼宇。', 86, 1, 0),
    (@campus_hd, '教二楼', 2, 35, '课程教学和日常学习楼宇。', 86, 1, 0),
    (@campus_hd, '教三楼', 2, 35, '课程教学和日常学习楼宇。', 86, 1, 0),
    (@campus_hd, '教四楼', 2, 35, '课程教学和日常学习楼宇。', 86, 1, 0),
    (@campus_hd, '教五楼', 2, 35, '课程教学和日常学习楼宇。', 84, 1, 0),
    (@campus_hd, '教六楼', 2, 35, '课程教学和日常学习楼宇。', 84, 1, 0),
    (@campus_hd, '教七楼', 2, 35, '课程教学和日常学习楼宇。', 84, 1, 0),
    (@campus_hd, '第一实验楼', 2, 40, '实验教学和科研实践相关楼宇。', 86, 1, 0),
    (@campus_hd, '第二实验楼', 2, 40, '实验教学和科研实践相关楼宇。', 86, 1, 0),
    (@campus_hd, '第三实验楼', 2, 40, '实验教学和科研实践相关楼宇。', 85, 1, 0),
    (@campus_hd, '第四实验楼', 2, 40, '实验教学和科研实践相关楼宇。', 85, 1, 0),
    (@campus_hd, '第五实验楼', 2, 40, '实验教学和科研实践相关楼宇。', 85, 1, 0),
    (@campus_hd, '第六实验楼', 2, 40, '实验教学和科研实践相关楼宇。', 84, 1, 0),
    (@campus_hd, '第七实验楼', 2, 40, '实验教学和科研实践相关楼宇。', 84, 1, 0),
    (@campus_hd, '第八实验楼', 2, 40, '实验教学和科研实践相关楼宇。', 84, 1, 0),
    (@campus_hd, '第九实验楼', 2, 40, '实验教学和科研实践相关楼宇。', 83, 1, 0),
    (@campus_hd, '第十实验楼', 2, 40, '实验教学和科研实践相关楼宇。', 83, 1, 0),
    (@campus_hd, '图书馆', 2, 60, '西土城路校区学习、自习和文献服务核心点位。', 94, 1, 0),
    (@campus_hd, '行政办公楼', 2, 25, '行政办公和校务服务相关楼宇。', 82, 1, 0),
    (@campus_hd, '科研楼', 2, 45, '科研与实验相关楼宇。', 88, 1, 0),
    (@campus_hd, '未来学习大楼', 2, 45, '教学创新、研讨和学习支持相关空间。', 88, 1, 0),
    (@campus_hd, '逸夫楼', 2, 35, '教学科研和学术活动相关楼宇。', 84, 1, 0),
    (@campus_hd, '综合服务楼', 3, 30, '校园事务办理和综合服务相关楼宇。', 82, 1, 0),
    (@campus_hd, '体育馆', 4, 35, '室内体育教学、训练和赛事活动场馆。', 84, 1, 0),
    (@campus_hd, '风雨操场', 4, 30, '适合雨雪天气下开展体育活动的运动空间。', 80, 1, 0),
    (@campus_hd, '标准田径场', 4, 30, '跑步、体测和户外体育活动空间。', 84, 1, 0),
    (@campus_hd, '篮球场', 4, 25, '篮球运动和课余体育活动场地。', 82, 1, 0),
    (@campus_hd, '排球场', 4, 25, '排球运动和体育课活动场地。', 78, 1, 0),
    (@campus_hd, '网球场', 4, 25, '网球运动和日常锻炼场地。', 78, 1, 0),
    (@campus_hd, '羽毛球场', 4, 25, '羽毛球运动和日常锻炼场地。', 78, 1, 0),
    (@campus_hd, '乒乓球场', 4, 25, '乒乓球运动和日常锻炼场地。', 78, 1, 0),
    (@campus_hd, '学生 1 公寓', 3, 20, '学生住宿生活楼宇。', 80, 1, 0),
    (@campus_hd, '学生 2 公寓', 3, 20, '学生住宿生活楼宇。', 80, 1, 0),
    (@campus_hd, '学生 3 公寓', 3, 20, '学生住宿生活楼宇。', 80, 1, 0),
    (@campus_hd, '学生 4 公寓', 3, 20, '学生住宿生活楼宇。', 80, 1, 0),
    (@campus_hd, '学生 5 公寓', 3, 20, '学生住宿生活楼宇。', 80, 1, 0),
    (@campus_hd, '学生 6 公寓', 3, 20, '学生住宿生活楼宇。', 80, 1, 0),
    (@campus_hd, '学生 7 公寓', 3, 20, '学生住宿生活楼宇。', 80, 1, 0),
    (@campus_hd, '学生 8 公寓', 3, 20, '学生住宿生活楼宇。', 80, 1, 0),
    (@campus_hd, '学生 9 公寓', 3, 20, '学生住宿生活楼宇。', 80, 1, 0),
    (@campus_hd, '学生 10 公寓', 3, 20, '学生住宿生活楼宇。', 80, 1, 0),
    (@campus_hd, '学生 11 公寓', 3, 20, '学生住宿生活楼宇。', 80, 1, 0),
    (@campus_hd, '学生 12 公寓', 3, 20, '学生住宿生活楼宇。', 80, 1, 0),
    (@campus_hd, '学生 13 公寓', 3, 20, '学生住宿生活楼宇。', 80, 1, 0),
    (@campus_hd, '学生 14 公寓', 3, 20, '学生住宿生活楼宇。', 80, 1, 0),
    (@campus_hd, '学生 15 公寓', 3, 20, '学生住宿生活楼宇。', 80, 1, 0),
    (@campus_hd, '学生 16 公寓', 3, 20, '学生住宿生活楼宇。', 80, 1, 0),
    (@campus_hd, '学一食堂', 3, 35, '西土城路校区日常就餐点位。', 86, 1, 0),
    (@campus_hd, '学二食堂', 3, 35, '西土城路校区日常就餐点位。', 86, 1, 0),
    (@campus_hd, '学三食堂', 3, 35, '西土城路校区日常就餐点位。', 85, 1, 0),
    (@campus_hd, '清真食堂', 3, 30, '满足清真餐饮需求的生活餐饮点位。', 82, 1, 0),
    (@campus_hd, '教工食堂', 3, 35, '教职工日常就餐点位。', 78, 1, 0),
    (@campus_hd, '风味餐厅', 3, 35, '风味餐饮和多样化就餐点位。', 84, 1, 0),
    (@campus_hd, '校医院', 3, 20, '基础医疗与健康服务点位。', 78, 1, 0),
    (@campus_hd, '师生服务中心', 3, 25, '校园事务办理和师生服务点位。', 82, 1, 0),
    (@campus_hd, '后勤服务中心', 3, 25, '校园后勤保障和生活服务相关点位。', 80, 1, 0),
    (@campus_hd, '菜鸟驿站', 3, 20, '学生日常取寄快递点位。', 82, 1, 0),
    (@campus_hd, '校园快递中心', 3, 20, '校园快递和物流服务点位。', 82, 1, 0),
    (@campus_hd, '校园超市', 3, 20, '日常购物和生活补给点位。', 82, 1, 0),
    (@campus_hd, '教育超市', 3, 20, '学习用品和生活物资补给点位。', 80, 1, 0),
    (@campus_hd, '时光广场', 1, 25, '校园公共活动和休闲景观点位。', 84, 1, 0),
    (@campus_hd, '校训石广场', 1, 25, '体现学校精神和校园文化的公共广场。', 82, 1, 0),
    (@campus_hd, '摩斯码路景观区', 1, 25, '体现信息通信特色的校园景观空间。', 82, 1, 0),
    (@campus_hd, '中心绿地', 1, 25, '西土城路校区中心公共绿地和休闲空间。', 80, 1, 0),
    (@campus_hd, '北湖景观区', 1, 30, '西土城路校区水系景观和休闲点位。', 80, 1, 0);

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
               '南校门', '北校门', '东校门', '西校门', '图书馆', '教学实验综合楼（N 楼，S 楼）',
               '公共教学楼（S1 楼，S2 楼，S3 楼）', '智慧教学楼', '综合办公楼',
               '网络空间安全学院楼', '数字媒体与设计艺术学院楼', '工程训练中心',
               '学生活动中心', '体育馆（在建）', '东体育场', '西体育场', '风雨操场',
               '篮球场', '排球场', '网球场', '羽毛球场', '乒乓球场', '雁北园学生公寓',
               '雁南园学生公寓', '留学生公寓', '北区食堂', '南区食堂', '风味餐厅',
               '教工餐厅', '校医院', '师生综合服务大厅', '共享自习室', '共享研讨室',
               '快递中心', '校园超市', '咖啡店', '理发店', '洗衣房', '打印店',
               '健身房', '甲子钟广场', '中心绿地', '景观湖', '友谊林', '下沉广场',
               '教工食堂', '学生餐厅', 'S1智慧教学楼', 'S3工程试验楼', '雁北宿舍楼',
               '雁南宿舍楼', '体育场', 'S教学综合楼', 'N教学综合楼'
    );

INSERT INTO poi
(campus_id, name, category, suggested_duration, intro, hot_score, data_status, is_deleted)
VALUES
    (@campus_sh, '南校门', 1, 15, '沙河校区南侧出入口。', 84, 1, 0),
    (@campus_sh, '北校门', 1, 15, '沙河校区北侧出入口。', 82, 1, 0),
    (@campus_sh, '东校门', 1, 15, '沙河校区东侧出入口。', 82, 1, 0),
    (@campus_sh, '西校门', 1, 15, '沙河校区西侧出入口。', 80, 1, 0),
    (@campus_sh, '图书馆', 2, 60, '沙河校区学习、自习和文献服务核心点位。', 96, 1, 0),
    (@campus_sh, '教学实验综合楼（N 楼，S 楼）', 2, 50, '课程教学、实验教学和自习活动综合楼宇。', 90, 1, 0),
    (@campus_sh, '公共教学楼（S1 楼，S2 楼，S3 楼）', 2, 45, '公共课程教学和日常上课楼宇组团。', 89, 1, 0),
    (@campus_sh, '智慧教学楼', 2, 45, '智慧教学、研讨学习和课程活动相关楼宇。', 88, 1, 0),
    (@campus_sh, '综合办公楼', 2, 30, '行政办公和校务服务相关楼宇。', 82, 1, 0),
    (@campus_sh, '网络空间安全学院楼', 2, 40, '网络空间安全学院教学科研相关楼宇。', 88, 1, 0),
    (@campus_sh, '数字媒体与设计艺术学院楼', 2, 40, '数字媒体与设计艺术学院教学科研相关楼宇。', 86, 1, 0),
    (@campus_sh, '工程训练中心', 2, 45, '工程实践、实验训练和动手能力培养空间。', 86, 1, 0),
    (@campus_sh, '学生活动中心', 1, 30, '学生事务、社团活动和校园公共活动相关空间。', 88, 1, 0),
    (@campus_sh, '体育馆（在建）', 4, 25, '规划和建设中的室内体育活动场馆。', 74, 1, 0),
    (@campus_sh, '东体育场', 4, 30, '东侧户外体育活动空间。', 84, 1, 0),
    (@campus_sh, '西体育场', 4, 30, '西侧户外体育活动空间。', 84, 1, 0),
    (@campus_sh, '风雨操场', 4, 30, '适合雨雪天气下开展体育活动的运动空间。', 80, 1, 0),
    (@campus_sh, '篮球场', 4, 25, '篮球运动和课余体育活动场地。', 82, 1, 0),
    (@campus_sh, '排球场', 4, 25, '排球运动和体育课活动场地。', 78, 1, 0),
    (@campus_sh, '网球场', 4, 25, '网球运动和日常锻炼场地。', 78, 1, 0),
    (@campus_sh, '羽毛球场', 4, 25, '羽毛球运动和日常锻炼场地。', 78, 1, 0),
    (@campus_sh, '乒乓球场', 4, 25, '乒乓球运动和日常锻炼场地。', 78, 1, 0),
    (@campus_sh, '雁北园学生公寓', 3, 20, '沙河校区学生住宿生活区域。', 84, 1, 0),
    (@campus_sh, '雁南园学生公寓', 3, 20, '沙河校区学生住宿生活区域。', 84, 1, 0),
    (@campus_sh, '留学生公寓', 3, 20, '留学生住宿生活区域。', 80, 1, 0),
    (@campus_sh, '北区食堂', 3, 35, '沙河校区北区日常就餐点位。', 88, 1, 0),
    (@campus_sh, '南区食堂', 3, 35, '沙河校区南区日常就餐点位。', 88, 1, 0),
    (@campus_sh, '风味餐厅', 3, 35, '风味餐饮和多样化就餐点位。', 85, 1, 0),
    (@campus_sh, '教工餐厅', 3, 35, '教职工日常就餐点位。', 78, 1, 0),
    (@campus_sh, '校医院', 3, 20, '基础医疗与健康服务点位。', 78, 1, 0),
    (@campus_sh, '师生综合服务大厅', 3, 25, '校园事务办理和师生服务点位。', 84, 1, 0),
    (@campus_sh, '共享自习室', 2, 35, '共享学习和安静自习空间。', 84, 1, 0),
    (@campus_sh, '共享研讨室', 2, 35, '小组讨论、课程研讨和项目协作空间。', 84, 1, 0),
    (@campus_sh, '快递中心', 3, 20, '校园快递和物流服务点位。', 84, 1, 0),
    (@campus_sh, '校园超市', 3, 20, '日常购物和生活补给点位。', 82, 1, 0),
    (@campus_sh, '咖啡店', 3, 20, '咖啡饮品和轻食休闲点位。', 78, 1, 0),
    (@campus_sh, '理发店', 3, 20, '日常理发和生活服务点位。', 76, 1, 0),
    (@campus_sh, '洗衣房', 3, 20, '学生日常洗衣服务点位。', 78, 1, 0),
    (@campus_sh, '打印店', 3, 20, '打印复印和学习资料服务点位。', 78, 1, 0),
    (@campus_sh, '健身房', 4, 30, '室内健身和力量训练空间。', 80, 1, 0),
    (@campus_sh, '甲子钟广场', 1, 25, '沙河校区公共活动和校园文化景观点位。', 84, 1, 0),
    (@campus_sh, '中心绿地', 1, 25, '沙河校区中心公共绿地和休闲空间。', 82, 1, 0),
    (@campus_sh, '景观湖', 1, 30, '沙河校区水系景观和休闲点位。', 82, 1, 0),
    (@campus_sh, '友谊林', 1, 25, '校园公共景观和休闲区域。', 80, 1, 0),
    (@campus_sh, '下沉广场', 1, 25, '公共活动、通行和休闲空间。', 80, 1, 0);

-- Detailed POIs for key engineering universities.

SET @campus_xidian_south = (
    SELECT c.id FROM campus c JOIN university u ON c.university_id = u.id
    WHERE u.name = '西安电子科技大学' AND c.name = '南校区' AND c.is_deleted = 0 AND u.is_deleted = 0 LIMIT 1
);

SELECT IF(@campus_xidian_south IS NULL, 1 / 0, @campus_xidian_south) AS campus_check;

DELETE FROM poi
WHERE campus_id = @campus_xidian_south
  AND name IN (
               '东门', '北门', '西门', '巨构 A 楼', '巨构 B 楼', '巨构 C 楼', '巨构 D 楼',
               '巨构 E 楼', '巨构 F 楼', '巨构 G 楼', '信远一区', '信远二区', '网络安全大楼',
               '工程训练中心', '图书馆', '礼仪广场', '校园观光塔', '全心全意为人民服务雕塑',
               '逐日工程', '樱花大道', '丁香公寓', '海棠公寓', '竹园公寓', '丁香食堂',
               '海棠食堂', '竹园食堂', '商业街', '校医院', '北田径场', '南田径场',
               '远望谷体育馆', '大学生活动中心', '游泳馆', '创新创业大楼', '行政办公楼',
               '后勤服务中心', '风雨操场', '湖心湖景区', '情人坡', '校园超市', '快递中心',
               '巨构教学楼', '竹园餐厅', '海棠餐厅', '丁香餐厅', '体育馆', '田径场',
               '信远楼', '行政楼', '学生宿舍区'
    );

INSERT INTO poi
(campus_id, name, category, suggested_duration, intro, hot_score, data_status, is_deleted)
VALUES
    (@campus_xidian_south, '东门', 1, 15, '南校区东侧主要出入口，连接西沣路方向和校外生活服务。', 84, 1, 0),
    (@campus_xidian_south, '北门', 1, 15, '南校区北侧主要出入口，靠近学生生活入口和雷甘路方向。', 86, 1, 0),
    (@campus_xidian_south, '西门', 1, 15, '南校区西侧出入口，靠近西太公路方向。', 78, 1, 0),
    (@campus_xidian_south, '巨构 A 楼', 2, 35, '巨构教学楼组的一部分，承担课程教学和日常学习活动。', 90, 1, 0),
    (@campus_xidian_south, '巨构 B 楼', 2, 35, '巨构教学楼组的一部分，教学和自习动线集中。', 90, 1, 0),
    (@campus_xidian_south, '巨构 C 楼', 2, 35, '巨构教学楼组的一部分，靠近礼仪广场和图书馆动线。', 90, 1, 0),
    (@campus_xidian_south, '巨构 D 楼', 2, 35, '巨构教学楼组的中部楼宇，连接礼仪广场和主教学轴线。', 91, 1, 0),
    (@campus_xidian_south, '巨构 E 楼', 2, 35, '巨构教学楼组的一部分，承担大量本科课程教学。', 90, 1, 0),
    (@campus_xidian_south, '巨构 F 楼', 2, 35, '巨构教学楼组的一部分，靠近东侧教学生活区域。', 89, 1, 0),
    (@campus_xidian_south, '巨构 G 楼', 2, 35, '巨构教学楼组东侧楼宇，教学和通行识别度高。', 89, 1, 0),
    (@campus_xidian_south, '信远一区', 2, 35, '信远楼相关教学科研区域之一。', 84, 1, 0),
    (@campus_xidian_south, '信远二区', 2, 35, '信远楼相关教学科研区域之一。', 84, 1, 0),
    (@campus_xidian_south, '网络安全大楼', 2, 40, '网络空间安全相关教学科研楼宇。', 88, 1, 0),
    (@campus_xidian_south, '工程训练中心', 2, 45, '工程实践、实验训练和动手能力培养相关空间。', 88, 1, 0),
    (@campus_xidian_south, '图书馆', 2, 60, '南校区核心学习与文献服务场所，自习和资料查阅需求集中。', 96, 1, 0),
    (@campus_xidian_south, '礼仪广场', 1, 25, '南校区中轴公共广场，连接教学区和校园景观节点。', 89, 1, 0),
    (@campus_xidian_south, '校园观光塔', 1, 25, '南校区校园景观识别点，适合观察校园空间结构。', 82, 1, 0),
    (@campus_xidian_south, '全心全意为人民服务雕塑', 1, 20, '南校区思想文化景观节点。', 80, 1, 0),
    (@campus_xidian_south, '逐日工程', 1, 25, '校园公共艺术和文化展示点位。', 80, 1, 0),
    (@campus_xidian_south, '樱花大道', 1, 25, '南校区季节性校园景观步道。', 84, 1, 0),
    (@campus_xidian_south, '丁香公寓', 3, 20, '南校区学生住宿生活区之一，靠近丁香餐饮配套。', 85, 1, 0),
    (@campus_xidian_south, '海棠公寓', 3, 20, '南校区学生住宿生活区之一，靠近海棠餐饮配套。', 85, 1, 0),
    (@campus_xidian_south, '竹园公寓', 3, 20, '南校区学生住宿生活区之一，靠近竹园餐饮配套。', 85, 1, 0),
    (@campus_xidian_south, '丁香食堂', 3, 35, '丁香生活区日常就餐点位。', 88, 1, 0),
    (@campus_xidian_south, '海棠食堂', 3, 35, '海棠生活区日常就餐点位。', 89, 1, 0),
    (@campus_xidian_south, '竹园食堂', 3, 35, '竹园生活区日常就餐点位。', 89, 1, 0),
    (@campus_xidian_south, '商业街', 3, 25, '校园日常购物、餐饮和生活服务集中区域。', 86, 1, 0),
    (@campus_xidian_south, '校医院', 3, 20, '基础医疗与健康服务点位。', 78, 1, 0),
    (@campus_xidian_south, '北田径场', 4, 30, '北侧体育运动区，承担跑步和球类活动。', 85, 1, 0),
    (@campus_xidian_south, '南田径场', 4, 30, '南侧体育运动区，承担跑步、训练和户外活动。', 84, 1, 0),
    (@campus_xidian_south, '远望谷体育馆', 4, 35, '室内体育教学、训练和赛事活动场馆。', 86, 1, 0),
    (@campus_xidian_south, '大学生活动中心', 1, 30, '学生事务、社团活动和校园公共活动相关空间。', 87, 1, 0),
    (@campus_xidian_south, '游泳馆', 4, 35, '游泳教学、训练和体育活动场馆。', 82, 1, 0),
    (@campus_xidian_south, '创新创业大楼', 2, 35, '创新创业实践、项目孵化和学生团队活动相关空间。', 84, 1, 0),
    (@campus_xidian_south, '行政办公楼', 2, 25, '行政办公和校务服务相关楼宇。', 80, 1, 0),
    (@campus_xidian_south, '后勤服务中心', 3, 25, '校园后勤保障和生活服务相关点位。', 78, 1, 0),
    (@campus_xidian_south, '风雨操场', 4, 30, '适合雨雪天气下开展体育活动的运动空间。', 80, 1, 0),
    (@campus_xidian_south, '湖心湖景区', 1, 30, '南校区水系与公共景观区域。', 84, 1, 0),
    (@campus_xidian_south, '情人坡', 1, 25, '南校区休闲景观点位，适合观察校园公共生活氛围。', 82, 1, 0),
    (@campus_xidian_south, '校园超市', 3, 20, '日常购物和生活补给点位。', 84, 1, 0),
    (@campus_xidian_south, '快递中心', 3, 20, '学生日常取寄快递的生活服务点位。', 85, 1, 0);

SET @campus_xidian_north = (
    SELECT c.id FROM campus c JOIN university u ON c.university_id = u.id
    WHERE u.name = '西安电子科技大学' AND c.name = '北校区' AND c.is_deleted = 0 AND u.is_deleted = 0 LIMIT 1
);

SELECT IF(@campus_xidian_north IS NULL, 1 / 0, @campus_xidian_north) AS campus_check;

DELETE FROM poi
WHERE campus_id = @campus_xidian_north
  AND name IN (
               '东门', '北门', '南门', '西南门', '东南门', '主楼（主教学楼）', '逸夫图书馆',
               '科技楼（东科技楼、西科技楼）', '会议中心', '西大楼', '阶梯教室（X 型教学楼）',
               '东大楼', '红楼（办公楼）', '教辅楼', '王诤雕塑', '中心花园', '文化长廊',
               '石凳读书区', '田径场', '篮球场', '排球场', '羽毛球场', '游泳馆',
               '学生活动中心', '校医院', '东区食堂（西军电餐厅）', '西区食堂', '清真餐厅',
               '东区宿舍', '西区宿舍（96 号楼等）', '研究生公寓', '快递中心', '校园超市',
               '商业街', '一站式服务大厅', '西军电文库', '老校门遗址', '林荫道花园',
               '图书馆', '主教学楼', '阶梯教室楼', '科技楼', '北校区餐厅', '运动场'
    );

INSERT INTO poi
(campus_id, name, category, suggested_duration, intro, hot_score, data_status, is_deleted)
VALUES
    (@campus_xidian_north, '东门', 1, 15, '北校区东侧出入口，连接太白南路周边城市生活空间。', 83, 1, 0),
    (@campus_xidian_north, '北门', 1, 15, '北校区北侧出入口，靠近主教学和办公区域动线。', 82, 1, 0),
    (@campus_xidian_north, '南门', 1, 15, '北校区南侧出入口，连接周边生活和通勤方向。', 80, 1, 0),
    (@campus_xidian_north, '西南门', 1, 15, '北校区西南侧出入口，靠近生活服务和宿舍区域。', 78, 1, 0),
    (@campus_xidian_north, '东南门', 1, 15, '北校区东南侧出入口，连接校园东南侧通勤动线。', 78, 1, 0),
    (@campus_xidian_north, '主楼（主教学楼）', 2, 40, '北校区课程教学和校园识别度较高的核心楼宇。', 88, 1, 0),
    (@campus_xidian_north, '逸夫图书馆', 2, 55, '北校区主要学习、自习和文献服务场所。', 90, 1, 0),
    (@campus_xidian_north, '科技楼（东科技楼、西科技楼）', 2, 40, '科研办公和实验教学相关楼宇组团。', 84, 1, 0),
    (@campus_xidian_north, '会议中心', 1, 30, '学术会议、报告和校园活动相关空间。', 82, 1, 0),
    (@campus_xidian_north, '西大楼', 2, 35, '教学科研与办公相关楼宇。', 82, 1, 0),
    (@campus_xidian_north, '阶梯教室（X 型教学楼）', 2, 35, '大课教学、讲座和考试相关教学空间。', 84, 1, 0),
    (@campus_xidian_north, '东大楼', 2, 35, '北校区东侧教学科研楼宇。', 81, 1, 0),
    (@campus_xidian_north, '红楼（办公楼）', 2, 30, '北校区办公和校务相关楼宇。', 80, 1, 0),
    (@campus_xidian_north, '教辅楼', 2, 30, '教学辅助、办公和服务相关楼宇。', 78, 1, 0),
    (@campus_xidian_north, '王诤雕塑', 1, 20, '体现西电办学传统和通信电子特色的校园文化点位。', 84, 1, 0),
    (@campus_xidian_north, '中心花园', 1, 25, '北校区公共休闲景观空间。', 82, 1, 0),
    (@campus_xidian_north, '文化长廊', 1, 25, '校园文化展示和步行休闲点位。', 80, 1, 0),
    (@campus_xidian_north, '石凳读书区', 1, 20, '户外阅读、自习和休息空间。', 79, 1, 0),
    (@campus_xidian_north, '田径场', 4, 30, '跑步、体测和户外体育活动空间。', 82, 1, 0),
    (@campus_xidian_north, '篮球场', 4, 30, '篮球运动和课余体育活动场地。', 80, 1, 0),
    (@campus_xidian_north, '排球场', 4, 25, '排球运动和体育课活动场地。', 78, 1, 0),
    (@campus_xidian_north, '羽毛球场', 4, 25, '羽毛球运动和日常锻炼场地。', 78, 1, 0),
    (@campus_xidian_north, '游泳馆', 4, 35, '游泳教学、训练和体育活动场馆。', 80, 1, 0),
    (@campus_xidian_north, '学生活动中心', 1, 30, '学生事务、社团活动和校园公共活动相关空间。', 82, 1, 0),
    (@campus_xidian_north, '校医院', 3, 20, '基础医疗与健康服务点位。', 76, 1, 0),
    (@campus_xidian_north, '东区食堂（西军电餐厅）', 3, 35, '东区主要餐饮点位之一，服务教学区和宿舍区日常就餐。', 84, 1, 0),
    (@campus_xidian_north, '西区食堂', 3, 35, '西区日常就餐点位。', 83, 1, 0),
    (@campus_xidian_north, '清真餐厅', 3, 30, '满足清真餐饮需求的生活餐饮点位。', 80, 1, 0),
    (@campus_xidian_north, '东区宿舍', 3, 20, '北校区东区学生住宿生活区域。', 81, 1, 0),
    (@campus_xidian_north, '西区宿舍（96 号楼等）', 3, 20, '北校区西区学生住宿生活区域。', 81, 1, 0),
    (@campus_xidian_north, '研究生公寓', 3, 20, '研究生日常住宿生活区域。', 80, 1, 0),
    (@campus_xidian_north, '快递中心', 3, 20, '取寄快递和日常物流服务点位。', 82, 1, 0),
    (@campus_xidian_north, '校园超市', 3, 20, '日常购物和生活补给点位。', 82, 1, 0),
    (@campus_xidian_north, '商业街', 3, 25, '餐饮、购物和生活服务集中区域。', 82, 1, 0),
    (@campus_xidian_north, '一站式服务大厅', 3, 25, '学生事务和校园服务集中办理点位。', 80, 1, 0),
    (@campus_xidian_north, '西军电文库', 2, 35, '与西军电历史传承相关的文献和文化资源点位。', 82, 1, 0),
    (@campus_xidian_north, '老校门遗址', 1, 25, '北校区历史记忆和校园文化点位。', 83, 1, 0),
    (@campus_xidian_north, '林荫道花园', 1, 25, '北校区步行休闲和校园景观空间。', 80, 1, 0);

SET @campus_buaa_xueyuan = (
    SELECT c.id FROM campus c JOIN university u ON c.university_id = u.id
    WHERE u.name = '北京航空航天大学' AND c.name = '学院路校区' AND c.is_deleted = 0 AND u.is_deleted = 0 LIMIT 1
);

SELECT IF(@campus_buaa_xueyuan IS NULL, 1 / 0, @campus_buaa_xueyuan) AS campus_check;

DELETE FROM poi
WHERE campus_id = @campus_buaa_xueyuan
  AND name IN (
               '北大门', '南大门', '东大门', '西大门', '新主楼', '老主楼', '学知楼',
               '五号楼', '六号楼', '七号楼', '八号楼', '第一实验楼', '第二实验楼',
               '工程训练中心', '行政办公楼', '图书馆', '晨兴音乐厅', '思源楼',
               '航空航天博物馆', '校史馆', '综合体育馆', '游泳馆', '天行网球馆',
               '标准田径场', '篮球场', '排球场', '网球场', '羽毛球场', '乒乓球场',
               '学生 1 公寓', '学生 2 公寓', '学生 3 公寓', '学生 4 公寓', '学生 5 公寓',
               '学生 6 公寓', '学生 7 公寓', '学生 8 公寓', '学生 9 公寓', '学生 10 公寓',
               '学生 11 公寓', '学生 12 公寓', '学生 13 公寓', '学生 15 公寓', '学生 16 公寓',
               '学生 17 公寓', '学生 18 公寓', '学生 19 公寓', '学生 20 公寓', '学生 21 公寓',
               '大运村公寓', '合一楼（学一食堂，学四食堂，清真食堂）',
               '北区食堂（学三食堂，学五食堂，学六食堂）', '学二食堂', '教工食堂',
               '校医院', '师生服务中心', '后勤服务中心', '菜鸟驿站', '校园快递中心',
               '校园超市', '教育超市', '求是广场', '中心绿地', '北湖景观区', '南湖景观区',
               '主楼', '体育馆', '中央绿地', '一号教学楼', '学生食堂', '运动场', '柏彦大厦', '学生公寓区'
    );

INSERT INTO poi
(campus_id, name, category, suggested_duration, intro, hot_score, data_status, is_deleted)
VALUES
    (@campus_buaa_xueyuan, '北大门', 1, 15, '学院路校区北侧出入口。', 84, 1, 0),
    (@campus_buaa_xueyuan, '南大门', 1, 15, '学院路校区南侧出入口。', 84, 1, 0),
    (@campus_buaa_xueyuan, '东大门', 1, 15, '学院路校区东侧出入口。', 82, 1, 0),
    (@campus_buaa_xueyuan, '西大门', 1, 15, '学院路校区西侧出入口。', 82, 1, 0),
    (@campus_buaa_xueyuan, '新主楼', 2, 45, '学院路校区重要教学科研与办公楼宇，航空航天和工科资源可感知度高。', 94, 1, 0),
    (@campus_buaa_xueyuan, '老主楼', 2, 40, '学院路校区传统教学科研楼宇。', 91, 1, 0),
    (@campus_buaa_xueyuan, '学知楼', 2, 35, '课程教学、学术活动和日常学习相关楼宇。', 86, 1, 0),
    (@campus_buaa_xueyuan, '五号楼', 2, 35, '学院路校区教学科研楼宇。', 84, 1, 0),
    (@campus_buaa_xueyuan, '六号楼', 2, 35, '学院路校区教学科研楼宇。', 84, 1, 0),
    (@campus_buaa_xueyuan, '七号楼', 2, 35, '学院路校区教学科研楼宇。', 84, 1, 0),
    (@campus_buaa_xueyuan, '八号楼', 2, 35, '学院路校区教学科研楼宇。', 84, 1, 0),
    (@campus_buaa_xueyuan, '第一实验楼', 2, 40, '实验教学和科研实践相关楼宇。', 86, 1, 0),
    (@campus_buaa_xueyuan, '第二实验楼', 2, 40, '实验教学和科研实践相关楼宇。', 86, 1, 0),
    (@campus_buaa_xueyuan, '工程训练中心', 2, 45, '工程实践、实验训练和动手能力培养空间。', 88, 1, 0),
    (@campus_buaa_xueyuan, '行政办公楼', 2, 25, '行政办公和校务服务相关楼宇。', 82, 1, 0),
    (@campus_buaa_xueyuan, '图书馆', 2, 60, '学院路校区学习、自习和文献服务核心点位。', 93, 1, 0),
    (@campus_buaa_xueyuan, '晨兴音乐厅', 1, 30, '演出、讲座和校园文化活动场所。', 84, 1, 0),
    (@campus_buaa_xueyuan, '思源楼', 2, 30, '教学、办公和综合服务相关楼宇。', 82, 1, 0),
    (@campus_buaa_xueyuan, '航空航天博物馆', 1, 45, '展示航空航天特色和学科传统的校园文化点位。', 93, 1, 0),
    (@campus_buaa_xueyuan, '校史馆', 1, 35, '展示北航办学历史和校园文化的点位。', 86, 1, 0),
    (@campus_buaa_xueyuan, '综合体育馆', 4, 35, '室内体育教学、训练和赛事活动场馆。', 86, 1, 0),
    (@campus_buaa_xueyuan, '游泳馆', 4, 35, '游泳教学、训练和体育活动场馆。', 82, 1, 0),
    (@campus_buaa_xueyuan, '天行网球馆', 4, 35, '网球训练、教学和课余运动场馆。', 80, 1, 0),
    (@campus_buaa_xueyuan, '标准田径场', 4, 30, '跑步、体测和户外体育活动空间。', 84, 1, 0),
    (@campus_buaa_xueyuan, '篮球场', 4, 25, '篮球运动和课余体育活动场地。', 82, 1, 0),
    (@campus_buaa_xueyuan, '排球场', 4, 25, '排球运动和体育课活动场地。', 78, 1, 0),
    (@campus_buaa_xueyuan, '网球场', 4, 25, '网球运动和日常锻炼场地。', 78, 1, 0),
    (@campus_buaa_xueyuan, '羽毛球场', 4, 25, '羽毛球运动和日常锻炼场地。', 78, 1, 0),
    (@campus_buaa_xueyuan, '乒乓球场', 4, 25, '乒乓球运动和日常锻炼场地。', 78, 1, 0),
    (@campus_buaa_xueyuan, '学生 1 公寓', 3, 20, '学院路校区学生住宿生活楼宇。', 80, 1, 0),
    (@campus_buaa_xueyuan, '学生 2 公寓', 3, 20, '学院路校区学生住宿生活楼宇。', 80, 1, 0),
    (@campus_buaa_xueyuan, '学生 3 公寓', 3, 20, '学院路校区学生住宿生活楼宇。', 80, 1, 0),
    (@campus_buaa_xueyuan, '学生 4 公寓', 3, 20, '学院路校区学生住宿生活楼宇。', 80, 1, 0),
    (@campus_buaa_xueyuan, '学生 5 公寓', 3, 20, '学院路校区学生住宿生活楼宇。', 80, 1, 0),
    (@campus_buaa_xueyuan, '学生 6 公寓', 3, 20, '学院路校区学生住宿生活楼宇。', 80, 1, 0),
    (@campus_buaa_xueyuan, '学生 7 公寓', 3, 20, '学院路校区学生住宿生活楼宇。', 80, 1, 0),
    (@campus_buaa_xueyuan, '学生 8 公寓', 3, 20, '学院路校区学生住宿生活楼宇。', 80, 1, 0),
    (@campus_buaa_xueyuan, '学生 9 公寓', 3, 20, '学院路校区学生住宿生活楼宇。', 80, 1, 0),
    (@campus_buaa_xueyuan, '学生 10 公寓', 3, 20, '学院路校区学生住宿生活楼宇。', 80, 1, 0),
    (@campus_buaa_xueyuan, '学生 11 公寓', 3, 20, '学院路校区学生住宿生活楼宇。', 80, 1, 0),
    (@campus_buaa_xueyuan, '学生 12 公寓', 3, 20, '学院路校区学生住宿生活楼宇。', 80, 1, 0),
    (@campus_buaa_xueyuan, '学生 13 公寓', 3, 20, '学院路校区学生住宿生活楼宇。', 80, 1, 0),
    (@campus_buaa_xueyuan, '学生 15 公寓', 3, 20, '学院路校区学生住宿生活楼宇。', 80, 1, 0),
    (@campus_buaa_xueyuan, '学生 16 公寓', 3, 20, '学院路校区学生住宿生活楼宇。', 80, 1, 0),
    (@campus_buaa_xueyuan, '学生 17 公寓', 3, 20, '学院路校区学生住宿生活楼宇。', 80, 1, 0),
    (@campus_buaa_xueyuan, '学生 18 公寓', 3, 20, '学院路校区学生住宿生活楼宇。', 80, 1, 0),
    (@campus_buaa_xueyuan, '学生 19 公寓', 3, 20, '学院路校区学生住宿生活楼宇。', 80, 1, 0),
    (@campus_buaa_xueyuan, '学生 20 公寓', 3, 20, '学院路校区学生住宿生活楼宇。', 80, 1, 0),
    (@campus_buaa_xueyuan, '学生 21 公寓', 3, 20, '学院路校区学生住宿生活楼宇。', 80, 1, 0),
    (@campus_buaa_xueyuan, '大运村公寓', 3, 20, '学生住宿和生活配套相关公寓区域。', 80, 1, 0),
    (@campus_buaa_xueyuan, '合一楼（学一食堂，学四食堂，清真食堂）', 3, 35, '学院路校区餐饮综合点位，包含学一、学四和清真餐饮。', 88, 1, 0),
    (@campus_buaa_xueyuan, '北区食堂（学三食堂，学五食堂，学六食堂）', 3, 35, '学院路校区北区餐饮综合点位。', 88, 1, 0),
    (@campus_buaa_xueyuan, '学二食堂', 3, 35, '学院路校区日常就餐点位。', 86, 1, 0),
    (@campus_buaa_xueyuan, '教工食堂', 3, 35, '教职工日常就餐点位。', 78, 1, 0),
    (@campus_buaa_xueyuan, '校医院', 3, 20, '基础医疗与健康服务点位。', 78, 1, 0),
    (@campus_buaa_xueyuan, '师生服务中心', 3, 25, '校园事务办理和师生服务点位。', 82, 1, 0),
    (@campus_buaa_xueyuan, '后勤服务中心', 3, 25, '校园后勤保障和生活服务相关点位。', 80, 1, 0),
    (@campus_buaa_xueyuan, '菜鸟驿站', 3, 20, '学生日常取寄快递点位。', 82, 1, 0),
    (@campus_buaa_xueyuan, '校园快递中心', 3, 20, '校园快递和物流服务点位。', 82, 1, 0),
    (@campus_buaa_xueyuan, '校园超市', 3, 20, '日常购物和生活补给点位。', 82, 1, 0),
    (@campus_buaa_xueyuan, '教育超市', 3, 20, '学习用品和生活物资补给点位。', 80, 1, 0),
    (@campus_buaa_xueyuan, '求是广场', 1, 25, '学院路校区公共活动和校园文化景观点位。', 84, 1, 0),
    (@campus_buaa_xueyuan, '中心绿地', 1, 25, '学院路校区中心公共绿地和休闲空间。', 82, 1, 0),
    (@campus_buaa_xueyuan, '北湖景观区', 1, 30, '学院路校区水系景观和休闲点位。', 80, 1, 0),
    (@campus_buaa_xueyuan, '南湖景观区', 1, 30, '学院路校区水系景观和休闲点位。', 80, 1, 0);

SET @campus_buaa_shahe = (
    SELECT c.id FROM campus c JOIN university u ON c.university_id = u.id
    WHERE u.name = '北京航空航天大学' AND c.name = '沙河校区' AND c.is_deleted = 0 AND u.is_deleted = 0 LIMIT 1
);

SELECT IF(@campus_buaa_shahe IS NULL, 1 / 0, @campus_buaa_shahe) AS campus_check;

DELETE FROM poi
WHERE campus_id = @campus_buaa_shahe
  AND name IN (
               '北校门', '南校门', '东校门', '西校门', '教学楼 0', '教学楼 1', '教学楼 2',
               '教学楼 3', '教学楼 4', '教学楼 5', '基础教学实验楼', '工程训练中心',
               '行政楼', '沙河图书馆', '综合体育馆', '东体育场', '西体育场', '风雨操场',
               '篮球场', '排球场', '网球场', '羽毛球场', '乒乓球场', '学生 1 公寓',
               '学生 2 公寓', '学生 3 公寓', '学生 4 公寓', '学生 5 公寓', '学生 6 公寓',
               '学生 7 公寓', '学生 8 公寓', '学生 9 公寓', '学生 10 公寓', '学生 11 公寓',
               '留学生公寓', '东区食堂（东区第一食堂，东区第二食堂，东区第三食堂）',
               '西区食堂（西区第一食堂，西区第二食堂，西区第三食堂，西区清真食堂）',
               '校医院', '师生综合服务大厅', '共享自习室', '共享研讨室', '快递中心',
               '校园超市', '咖啡店', '理发店', '洗衣房', '打印店', '健身房',
               '泗水湖', '友谊林', '下沉广场', '中心绿地',
               '图书馆', '教学楼组', '实验楼组', '学生食堂', '体育场', '学生公寓区',
               '综合服务楼', '重点实验室组团', '校园商业服务区'
    );

INSERT INTO poi
(campus_id, name, category, suggested_duration, intro, hot_score, data_status, is_deleted)
VALUES
    (@campus_buaa_shahe, '北校门', 1, 15, '沙河校区北侧出入口。', 84, 1, 0),
    (@campus_buaa_shahe, '南校门', 1, 15, '沙河校区南侧出入口。', 84, 1, 0),
    (@campus_buaa_shahe, '东校门', 1, 15, '沙河校区东侧出入口。', 82, 1, 0),
    (@campus_buaa_shahe, '西校门', 1, 15, '沙河校区西侧出入口。', 80, 1, 0),
    (@campus_buaa_shahe, '教学楼 0', 2, 35, '沙河校区课程教学楼宇。', 86, 1, 0),
    (@campus_buaa_shahe, '教学楼 1', 2, 35, '沙河校区课程教学楼宇。', 86, 1, 0),
    (@campus_buaa_shahe, '教学楼 2', 2, 35, '沙河校区课程教学楼宇。', 86, 1, 0),
    (@campus_buaa_shahe, '教学楼 3', 2, 35, '沙河校区课程教学楼宇。', 86, 1, 0),
    (@campus_buaa_shahe, '教学楼 4', 2, 35, '沙河校区课程教学楼宇。', 86, 1, 0),
    (@campus_buaa_shahe, '教学楼 5', 2, 35, '沙河校区课程教学楼宇。', 86, 1, 0),
    (@campus_buaa_shahe, '基础教学实验楼', 2, 40, '基础课程教学和实验教学相关楼宇。', 88, 1, 0),
    (@campus_buaa_shahe, '工程训练中心', 2, 45, '工程实践、实验训练和动手能力培养空间。', 88, 1, 0),
    (@campus_buaa_shahe, '行政楼', 2, 25, '行政办公和校务服务相关楼宇。', 80, 1, 0),
    (@campus_buaa_shahe, '沙河图书馆', 2, 60, '沙河校区学习、自习和文献服务核心点位。', 92, 1, 0),
    (@campus_buaa_shahe, '综合体育馆', 4, 35, '室内体育教学、训练和赛事活动场馆。', 86, 1, 0),
    (@campus_buaa_shahe, '东体育场', 4, 30, '东侧户外体育活动空间。', 84, 1, 0),
    (@campus_buaa_shahe, '西体育场', 4, 30, '西侧户外体育活动空间。', 84, 1, 0),
    (@campus_buaa_shahe, '风雨操场', 4, 30, '适合雨雪天气下开展体育活动的运动空间。', 80, 1, 0),
    (@campus_buaa_shahe, '篮球场', 4, 25, '篮球运动和课余体育活动场地。', 82, 1, 0),
    (@campus_buaa_shahe, '排球场', 4, 25, '排球运动和体育课活动场地。', 78, 1, 0),
    (@campus_buaa_shahe, '网球场', 4, 25, '网球运动和日常锻炼场地。', 78, 1, 0),
    (@campus_buaa_shahe, '羽毛球场', 4, 25, '羽毛球运动和日常锻炼场地。', 78, 1, 0),
    (@campus_buaa_shahe, '乒乓球场', 4, 25, '乒乓球运动和日常锻炼场地。', 78, 1, 0),
    (@campus_buaa_shahe, '学生 1 公寓', 3, 20, '沙河校区学生住宿生活楼宇。', 80, 1, 0),
    (@campus_buaa_shahe, '学生 2 公寓', 3, 20, '沙河校区学生住宿生活楼宇。', 80, 1, 0),
    (@campus_buaa_shahe, '学生 3 公寓', 3, 20, '沙河校区学生住宿生活楼宇。', 80, 1, 0),
    (@campus_buaa_shahe, '学生 4 公寓', 3, 20, '沙河校区学生住宿生活楼宇。', 80, 1, 0),
    (@campus_buaa_shahe, '学生 5 公寓', 3, 20, '沙河校区学生住宿生活楼宇。', 80, 1, 0),
    (@campus_buaa_shahe, '学生 6 公寓', 3, 20, '沙河校区学生住宿生活楼宇。', 80, 1, 0),
    (@campus_buaa_shahe, '学生 7 公寓', 3, 20, '沙河校区学生住宿生活楼宇。', 80, 1, 0),
    (@campus_buaa_shahe, '学生 8 公寓', 3, 20, '沙河校区学生住宿生活楼宇。', 80, 1, 0),
    (@campus_buaa_shahe, '学生 9 公寓', 3, 20, '沙河校区学生住宿生活楼宇。', 80, 1, 0),
    (@campus_buaa_shahe, '学生 10 公寓', 3, 20, '沙河校区学生住宿生活楼宇。', 80, 1, 0),
    (@campus_buaa_shahe, '学生 11 公寓', 3, 20, '沙河校区学生住宿生活楼宇。', 80, 1, 0),
    (@campus_buaa_shahe, '留学生公寓', 3, 20, '留学生住宿生活区域。', 80, 1, 0),
    (@campus_buaa_shahe, '东区食堂（东区第一食堂，东区第二食堂，东区第三食堂）', 3, 35, '沙河校区东区餐饮综合点位。', 88, 1, 0),
    (@campus_buaa_shahe, '西区食堂（西区第一食堂，西区第二食堂，西区第三食堂，西区清真食堂）', 3, 35, '沙河校区西区餐饮综合点位。', 88, 1, 0),
    (@campus_buaa_shahe, '校医院', 3, 20, '基础医疗与健康服务点位。', 78, 1, 0),
    (@campus_buaa_shahe, '师生综合服务大厅', 3, 25, '校园事务办理和师生服务点位。', 84, 1, 0),
    (@campus_buaa_shahe, '共享自习室', 2, 35, '共享学习和安静自习空间。', 84, 1, 0),
    (@campus_buaa_shahe, '共享研讨室', 2, 35, '小组讨论、课程研讨和项目协作空间。', 84, 1, 0),
    (@campus_buaa_shahe, '快递中心', 3, 20, '校园快递和物流服务点位。', 84, 1, 0),
    (@campus_buaa_shahe, '校园超市', 3, 20, '日常购物和生活补给点位。', 82, 1, 0),
    (@campus_buaa_shahe, '咖啡店', 3, 20, '咖啡饮品和轻食休闲点位。', 78, 1, 0),
    (@campus_buaa_shahe, '理发店', 3, 20, '日常理发和生活服务点位。', 76, 1, 0),
    (@campus_buaa_shahe, '洗衣房', 3, 20, '学生日常洗衣服务点位。', 78, 1, 0),
    (@campus_buaa_shahe, '打印店', 3, 20, '打印复印和学习资料服务点位。', 78, 1, 0),
    (@campus_buaa_shahe, '健身房', 4, 30, '室内健身和力量训练空间。', 80, 1, 0),
    (@campus_buaa_shahe, '泗水湖', 1, 30, '沙河校区水系景观和休闲点位。', 82, 1, 0),
    (@campus_buaa_shahe, '友谊林', 1, 25, '校园公共景观和休闲区域。', 80, 1, 0),
    (@campus_buaa_shahe, '下沉广场', 1, 25, '公共活动、通行和休闲空间。', 80, 1, 0),
    (@campus_buaa_shahe, '中心绿地', 1, 25, '沙河校区中心公共绿地和休闲空间。', 82, 1, 0);

SET @campus_xjtu_xingqing = (
    SELECT c.id FROM campus c JOIN university u ON c.university_id = u.id
    WHERE u.name = '西安交通大学' AND c.name = '兴庆校区' AND c.is_deleted = 0 AND u.is_deleted = 0 LIMIT 1
);

SELECT IF(@campus_xjtu_xingqing IS NULL, 1 / 0, @campus_xjtu_xingqing) AS campus_check;

DELETE FROM poi
WHERE campus_id = @campus_xjtu_xingqing
  AND name IN ('钱学森图书馆', '思源学生活动中心', '宪梓堂', '主楼群', '四大发明广场',
               '腾飞塔', '梧桐道', '学生食堂', '体育场', '学生宿舍区', '西迁博物馆', '教学二楼',
               '南门', '北门', '东门', '西门', '东南门', '主楼群（陕西省文物保护单位）',
               '教一楼', '教二楼', '教三楼', '教四楼', '教五楼', '教六楼',
               '第一实验楼', '第二实验楼', '第三实验楼', '第四实验楼', '第五实验楼',
               '第六实验楼', '第七实验楼', '第八实验楼', '行政办公楼', '科研楼',
               '逸夫科学馆', '工程训练中心', '大学生活动中心', '综合体育馆', '游泳馆',
               '标准田径场', '东南球场', '篮球场', '排球场', '网球场', '羽毛球场',
               '乒乓球场', '南洋书院宿舍（东 7 - 东 9 舍）', '彭康书院宿舍',
               '励志书院宿舍', '崇实书院宿舍', '文治书院宿舍', '宗濂书院宿舍',
               '留学生宿舍（西七、西八、西十三舍）', '康桥苑（学生食堂、调剂食堂、教工食堂）',
               '梧桐苑（风味小吃、学生自选食堂、调剂食堂、西餐厅、民族餐厅）',
               '教学二区餐车', '校医院', '师生服务中心', '后勤服务中心', '菜鸟驿站',
               '校园快递中心', '校园超市', '教育超市', '思源广场', '中心绿地',
               '时间广场', '梧桐大道景观区', '北湖景观区', '樱花大道景观区');

INSERT INTO poi
(campus_id, name, category, suggested_duration, intro, hot_score, data_status, is_deleted)
VALUES
    (@campus_xjtu_xingqing, '南门', 1, 15, '兴庆校区南侧主要出入口。', 86, 1, 0),
    (@campus_xjtu_xingqing, '北门', 1, 15, '兴庆校区北侧出入口。', 84, 1, 0),
    (@campus_xjtu_xingqing, '东门', 1, 15, '兴庆校区东侧出入口。', 84, 1, 0),
    (@campus_xjtu_xingqing, '西门', 1, 15, '兴庆校区西侧出入口。', 84, 1, 0),
    (@campus_xjtu_xingqing, '东南门', 1, 15, '兴庆校区东南侧出入口。', 82, 1, 0),
    (@campus_xjtu_xingqing, '主楼群（陕西省文物保护单位）', 2, 45, '兴庆校区传统教学科研楼宇组团，体现老校区空间秩序。', 93, 1, 0),
    (@campus_xjtu_xingqing, '教一楼', 2, 35, '课程教学和日常学习楼宇。', 86, 1, 0),
    (@campus_xjtu_xingqing, '教二楼', 2, 35, '课程教学和日常学习楼宇。', 86, 1, 0),
    (@campus_xjtu_xingqing, '教三楼', 2, 35, '课程教学和日常学习楼宇。', 85, 1, 0),
    (@campus_xjtu_xingqing, '教四楼', 2, 35, '课程教学和日常学习楼宇。', 85, 1, 0),
    (@campus_xjtu_xingqing, '教五楼', 2, 35, '课程教学和日常学习楼宇。', 84, 1, 0),
    (@campus_xjtu_xingqing, '教六楼', 2, 35, '课程教学和日常学习楼宇。', 84, 1, 0),
    (@campus_xjtu_xingqing, '第一实验楼', 2, 40, '实验教学和科研实践相关楼宇。', 86, 1, 0),
    (@campus_xjtu_xingqing, '第二实验楼', 2, 40, '实验教学和科研实践相关楼宇。', 86, 1, 0),
    (@campus_xjtu_xingqing, '第三实验楼', 2, 40, '实验教学和科研实践相关楼宇。', 85, 1, 0),
    (@campus_xjtu_xingqing, '第四实验楼', 2, 40, '实验教学和科研实践相关楼宇。', 85, 1, 0),
    (@campus_xjtu_xingqing, '第五实验楼', 2, 40, '实验教学和科研实践相关楼宇。', 84, 1, 0),
    (@campus_xjtu_xingqing, '第六实验楼', 2, 40, '实验教学和科研实践相关楼宇。', 84, 1, 0),
    (@campus_xjtu_xingqing, '第七实验楼', 2, 40, '实验教学和科研实践相关楼宇。', 83, 1, 0),
    (@campus_xjtu_xingqing, '第八实验楼', 2, 40, '实验教学和科研实践相关楼宇。', 83, 1, 0),
    (@campus_xjtu_xingqing, '钱学森图书馆', 2, 60, '兴庆校区核心图书馆和学习空间，也是交大校园文化的重要点位。', 96, 1, 0),
    (@campus_xjtu_xingqing, '行政办公楼', 2, 25, '行政办公和校务服务相关楼宇。', 82, 1, 0),
    (@campus_xjtu_xingqing, '科研楼', 2, 40, '科研办公和学术研究相关楼宇。', 86, 1, 0),
    (@campus_xjtu_xingqing, '逸夫科学馆', 2, 40, '科学教育、学术活动和教学科研相关楼宇。', 86, 1, 0),
    (@campus_xjtu_xingqing, '工程训练中心', 2, 45, '工程实践、实验训练和动手能力培养空间。', 86, 1, 0),
    (@campus_xjtu_xingqing, '大学生活动中心', 1, 35, '学生事务、社团活动和校园公共活动集中空间。', 90, 1, 0),
    (@campus_xjtu_xingqing, '综合体育馆', 4, 35, '室内体育教学、训练和赛事活动场馆。', 86, 1, 0),
    (@campus_xjtu_xingqing, '游泳馆', 4, 35, '游泳教学、训练和体育活动场馆。', 84, 1, 0),
    (@campus_xjtu_xingqing, '标准田径场', 4, 30, '跑步、体测和户外体育活动空间。', 84, 1, 0),
    (@campus_xjtu_xingqing, '东南球场', 4, 25, '东南侧球类运动和课余体育活动场地。', 82, 1, 0),
    (@campus_xjtu_xingqing, '篮球场', 4, 25, '篮球运动和课余体育活动场地。', 82, 1, 0),
    (@campus_xjtu_xingqing, '排球场', 4, 25, '排球运动和体育课活动场地。', 78, 1, 0),
    (@campus_xjtu_xingqing, '网球场', 4, 25, '网球运动和日常锻炼场地。', 78, 1, 0),
    (@campus_xjtu_xingqing, '羽毛球场', 4, 25, '羽毛球运动和日常锻炼场地。', 78, 1, 0),
    (@campus_xjtu_xingqing, '乒乓球场', 4, 25, '乒乓球运动和日常锻炼场地。', 78, 1, 0),
    (@campus_xjtu_xingqing, '南洋书院宿舍（东 7 - 东 9 舍）', 3, 20, '南洋书院相关学生住宿生活区域。', 84, 1, 0),
    (@campus_xjtu_xingqing, '彭康书院宿舍', 3, 20, '彭康书院学生住宿生活区域。', 83, 1, 0),
    (@campus_xjtu_xingqing, '励志书院宿舍', 3, 20, '励志书院学生住宿生活区域。', 82, 1, 0),
    (@campus_xjtu_xingqing, '崇实书院宿舍', 3, 20, '崇实书院学生住宿生活区域。', 82, 1, 0),
    (@campus_xjtu_xingqing, '文治书院宿舍', 3, 20, '文治书院学生住宿生活区域。', 82, 1, 0),
    (@campus_xjtu_xingqing, '宗濂书院宿舍', 3, 20, '宗濂书院学生住宿生活区域。', 82, 1, 0),
    (@campus_xjtu_xingqing, '留学生宿舍（西七、西八、西十三舍）', 3, 20, '留学生住宿生活区域。', 80, 1, 0),
    (@campus_xjtu_xingqing, '康桥苑（学生食堂、调剂食堂、教工食堂）', 3, 35, '兴庆校区综合餐饮服务点位。', 88, 1, 0),
    (@campus_xjtu_xingqing, '梧桐苑（风味小吃、学生自选食堂、调剂食堂、西餐厅、民族餐厅）', 3, 35, '风味餐饮和多样化就餐服务点位。', 88, 1, 0),
    (@campus_xjtu_xingqing, '教学二区餐车', 3, 20, '教学区便捷餐饮补给点位。', 78, 1, 0),
    (@campus_xjtu_xingqing, '校医院', 3, 20, '基础医疗与健康服务点位。', 80, 1, 0),
    (@campus_xjtu_xingqing, '师生服务中心', 3, 25, '校园事务办理和师生服务点位。', 84, 1, 0),
    (@campus_xjtu_xingqing, '后勤服务中心', 3, 25, '校园后勤保障和生活服务相关点位。', 82, 1, 0),
    (@campus_xjtu_xingqing, '菜鸟驿站', 3, 20, '学生日常取寄快递点位。', 82, 1, 0),
    (@campus_xjtu_xingqing, '校园快递中心', 3, 20, '校园快递和物流服务点位。', 82, 1, 0),
    (@campus_xjtu_xingqing, '校园超市', 3, 20, '日常购物和生活补给点位。', 82, 1, 0),
    (@campus_xjtu_xingqing, '教育超市', 3, 20, '学习用品和生活物资补给点位。', 80, 1, 0),
    (@campus_xjtu_xingqing, '思源广场', 1, 25, '兴庆校区公共活动和校园文化广场。', 90, 1, 0),
    (@campus_xjtu_xingqing, '中心绿地', 1, 25, '兴庆校区中心公共绿地和休闲空间。', 84, 1, 0),
    (@campus_xjtu_xingqing, '时间广场', 1, 25, '校园公共活动和文化景观空间。', 82, 1, 0),
    (@campus_xjtu_xingqing, '梧桐大道景观区', 1, 25, '兴庆校区代表性步行景观空间。', 86, 1, 0),
    (@campus_xjtu_xingqing, '北湖景观区', 1, 30, '兴庆校区水系景观和休闲点位。', 84, 1, 0),
    (@campus_xjtu_xingqing, '樱花大道景观区', 1, 30, '季节性校园景观和步行休闲点位。', 84, 1, 0);

SET @campus_xjtu_yanta = (
    SELECT c.id FROM campus c JOIN university u ON c.university_id = u.id
    WHERE u.name = '西安交通大学' AND c.name = '雁塔校区' AND c.is_deleted = 0 AND u.is_deleted = 0 LIMIT 1
);

SELECT IF(@campus_xjtu_yanta IS NULL, 1 / 0, @campus_xjtu_yanta) AS campus_check;

DELETE FROM poi
WHERE campus_id = @campus_xjtu_yanta
  AND name IN ('雁塔校区图书馆', '医学教学楼', '财经主楼', '学生公寓区', '学生食堂', '校医院', '体育场', '师生服务点',
               '南门', '北门', '东门', '西门', '行政楼（爬山虎楼）', '基础教学楼',
               '医学实验楼', '病理楼', '微免楼', '药学楼', '护理楼', '图书馆',
               '医学博物馆', '校史馆', '体育馆', '游泳馆', '篮球场', '排球场',
               '网球场', '学生宿舍 1-10 舍', '研究生公寓', '留学生公寓',
               '清真食堂', '教工食堂', '风味餐厅', '医学部事务中心', '快递收发中心',
               '校园超市', '咖啡店', '打印店', '水杉林景观区', '中心绿地',
               '喷泉广场', '医学部文化广场');

INSERT INTO poi
(campus_id, name, category, suggested_duration, intro, hot_score, data_status, is_deleted)
VALUES
    (@campus_xjtu_yanta, '南门', 1, 15, '雁塔校区南侧主要出入口。', 82, 1, 0),
    (@campus_xjtu_yanta, '北门', 1, 15, '雁塔校区北侧出入口。', 80, 1, 0),
    (@campus_xjtu_yanta, '东门', 1, 15, '雁塔校区东侧出入口。', 80, 1, 0),
    (@campus_xjtu_yanta, '西门', 1, 15, '雁塔校区西侧出入口。', 80, 1, 0),
    (@campus_xjtu_yanta, '行政楼（爬山虎楼）', 2, 25, '雁塔校区行政办公和校务管理楼宇。', 82, 1, 0),
    (@campus_xjtu_yanta, '基础教学楼', 2, 35, '医学部基础课程教学和学习楼宇。', 84, 1, 0),
    (@campus_xjtu_yanta, '医学实验楼', 2, 40, '医学实验教学和科研实践相关楼宇。', 86, 1, 0),
    (@campus_xjtu_yanta, '病理楼', 2, 35, '病理学教学科研相关楼宇。', 82, 1, 0),
    (@campus_xjtu_yanta, '微免楼', 2, 35, '微生物和免疫学教学科研相关楼宇。', 82, 1, 0),
    (@campus_xjtu_yanta, '药学楼', 2, 35, '药学教学科研相关楼宇。', 82, 1, 0),
    (@campus_xjtu_yanta, '护理楼', 2, 35, '护理学教学科研相关楼宇。', 82, 1, 0),
    (@campus_xjtu_yanta, '图书馆', 2, 50, '雁塔校区学习、自习和文献服务点位。', 86, 1, 0),
    (@campus_xjtu_yanta, '医学博物馆', 1, 40, '医学教育、学科历史和校园文化展示点位。', 84, 1, 0),
    (@campus_xjtu_yanta, '校史馆', 1, 35, '展示学校办学历史和校园文化的点位。', 84, 1, 0),
    (@campus_xjtu_yanta, '体育馆', 4, 35, '室内体育教学、训练和赛事活动场馆。', 80, 1, 0),
    (@campus_xjtu_yanta, '游泳馆', 4, 35, '游泳教学、训练和体育活动场馆。', 78, 1, 0),
    (@campus_xjtu_yanta, '体育场', 4, 30, '户外体育活动空间。', 78, 1, 0),
    (@campus_xjtu_yanta, '篮球场', 4, 25, '篮球运动和课余体育活动场地。', 78, 1, 0),
    (@campus_xjtu_yanta, '排球场', 4, 25, '排球运动和体育课活动场地。', 76, 1, 0),
    (@campus_xjtu_yanta, '网球场', 4, 25, '网球运动和日常锻炼场地。', 76, 1, 0),
    (@campus_xjtu_yanta, '学生宿舍 1-10 舍', 3, 20, '雁塔校区学生住宿生活区域。', 80, 1, 0),
    (@campus_xjtu_yanta, '研究生公寓', 3, 20, '研究生住宿生活区域。', 78, 1, 0),
    (@campus_xjtu_yanta, '留学生公寓', 3, 20, '留学生住宿生活区域。', 78, 1, 0),
    (@campus_xjtu_yanta, '学生食堂', 3, 35, '雁塔校区日常就餐点位。', 82, 1, 0),
    (@campus_xjtu_yanta, '清真食堂', 3, 30, '满足清真餐饮需求的生活餐饮点位。', 78, 1, 0),
    (@campus_xjtu_yanta, '教工食堂', 3, 35, '教职工日常就餐点位。', 76, 1, 0),
    (@campus_xjtu_yanta, '风味餐厅', 3, 35, '风味餐饮和多样化就餐点位。', 80, 1, 0),
    (@campus_xjtu_yanta, '校医院', 3, 25, '医学和健康服务相关点位。', 80, 1, 0),
    (@campus_xjtu_yanta, '医学部事务中心', 3, 25, '医学部事务办理和师生服务点位。', 78, 1, 0),
    (@campus_xjtu_yanta, '快递收发中心', 3, 20, '校园快递和物流服务点位。', 78, 1, 0),
    (@campus_xjtu_yanta, '校园超市', 3, 20, '日常购物和生活补给点位。', 78, 1, 0),
    (@campus_xjtu_yanta, '咖啡店', 3, 20, '咖啡饮品和轻食休闲点位。', 76, 1, 0),
    (@campus_xjtu_yanta, '打印店', 3, 20, '打印复印和学习资料服务点位。', 76, 1, 0),
    (@campus_xjtu_yanta, '水杉林景观区', 1, 30, '校园特色林地景观和休闲点位。', 78, 1, 0),
    (@campus_xjtu_yanta, '中心绿地', 1, 25, '雁塔校区中心公共绿地和休闲空间。', 78, 1, 0),
    (@campus_xjtu_yanta, '喷泉广场', 1, 25, '校园公共活动和景观休闲点位。', 78, 1, 0),
    (@campus_xjtu_yanta, '医学部文化广场', 1, 25, '医学部公共活动和文化展示广场。', 80, 1, 0);

SET @campus_xjtu_qujiang = (
    SELECT c.id FROM campus c JOIN university u ON c.university_id = u.id
    WHERE u.name = '西安交通大学' AND c.name = '曲江校区' AND c.is_deleted = 0 AND u.is_deleted = 0 LIMIT 1
);

SELECT IF(@campus_xjtu_qujiang IS NULL, 1 / 0, @campus_xjtu_qujiang) AS campus_check;

DELETE FROM poi
WHERE campus_id = @campus_xjtu_qujiang
  AND name IN ('西二楼', '机械制造系统工程国家重点实验室', '前沿科学与技术研究院', '软件学院',
               '梧桐道', '樱花路', '银杏林', '曲江校区食堂', '学生公寓区',
               '南门', '北门', '东门', '西门', '西一楼（陕西省院士活动中心）',
               '西三楼', '西四楼', '西五楼', '国际电介质中心', '曲江国际会展中心',
               '人居环境与建筑工程学院楼', '研究生教学楼', '科研实验楼', '图书阅览中心',
               '行政办公楼', '体育馆', '体育场', '篮球场', '排球场', '网球场',
               '羽毛球场', '乒乓球场', '研究生公寓 1-6 栋', '专家公寓', '学生食堂',
               '清真食堂', '教工食堂', '校医院', '师生服务中心', '后勤服务中心',
               '快递中心', '校园超市', '曲江景园', '中心绿地', '景观湖', '校区石门',
               '旗杆广场', '西迁精神文化墙', '创新研究院集群楼');

INSERT INTO poi
(campus_id, name, category, suggested_duration, intro, hot_score, data_status, is_deleted)
VALUES
    (@campus_xjtu_qujiang, '南门', 1, 15, '曲江校区南侧主要出入口。', 82, 1, 0),
    (@campus_xjtu_qujiang, '北门', 1, 15, '曲江校区北侧出入口。', 80, 1, 0),
    (@campus_xjtu_qujiang, '东门', 1, 15, '曲江校区东侧出入口。', 80, 1, 0),
    (@campus_xjtu_qujiang, '西门', 1, 15, '曲江校区西侧出入口。', 80, 1, 0),
    (@campus_xjtu_qujiang, '西一楼（陕西省院士活动中心）', 2, 35, '院士活动、科研办公和学术交流相关楼宇。', 86, 1, 0),
    (@campus_xjtu_qujiang, '西二楼', 2, 35, '曲江校区管理和科研办公相关楼宇。', 84, 1, 0),
    (@campus_xjtu_qujiang, '西三楼', 2, 35, '教学科研和办公相关楼宇。', 84, 1, 0),
    (@campus_xjtu_qujiang, '西四楼', 2, 35, '教学科研和办公相关楼宇。', 84, 1, 0),
    (@campus_xjtu_qujiang, '西五楼', 2, 35, '教学科研和办公相关楼宇。', 84, 1, 0),
    (@campus_xjtu_qujiang, '国际电介质中心', 2, 45, '电介质相关科研平台和学术研究空间。', 88, 1, 0),
    (@campus_xjtu_qujiang, '曲江国际会展中心', 1, 40, '会议、展览和大型活动相关空间。', 84, 1, 0),
    (@campus_xjtu_qujiang, '人居环境与建筑工程学院楼', 2, 40, '人居环境与建筑工程相关教学科研楼宇。', 86, 1, 0),
    (@campus_xjtu_qujiang, '机械制造系统工程国家重点实验室', 2, 45, '先进制造相关科研平台点位。', 90, 1, 0),
    (@campus_xjtu_qujiang, '研究生教学楼', 2, 40, '研究生课程教学、自习和培养相关楼宇。', 84, 1, 0),
    (@campus_xjtu_qujiang, '科研实验楼', 2, 45, '科研实验、项目研究和实验实践相关楼宇。', 86, 1, 0),
    (@campus_xjtu_qujiang, '图书阅览中心', 2, 50, '曲江校区学习、自习和文献阅览点位。', 84, 1, 0),
    (@campus_xjtu_qujiang, '行政办公楼', 2, 25, '行政办公和校务服务相关楼宇。', 80, 1, 0),
    (@campus_xjtu_qujiang, '体育馆', 4, 35, '室内体育教学、训练和赛事活动场馆。', 80, 1, 0),
    (@campus_xjtu_qujiang, '体育场', 4, 30, '户外体育活动和跑步空间。', 80, 1, 0),
    (@campus_xjtu_qujiang, '篮球场', 4, 25, '篮球运动和课余体育活动场地。', 78, 1, 0),
    (@campus_xjtu_qujiang, '排球场', 4, 25, '排球运动和体育课活动场地。', 76, 1, 0),
    (@campus_xjtu_qujiang, '网球场', 4, 25, '网球运动和日常锻炼场地。', 76, 1, 0),
    (@campus_xjtu_qujiang, '羽毛球场', 4, 25, '羽毛球运动和日常锻炼场地。', 76, 1, 0),
    (@campus_xjtu_qujiang, '乒乓球场', 4, 25, '乒乓球运动和日常锻炼场地。', 76, 1, 0),
    (@campus_xjtu_qujiang, '研究生公寓 1-6 栋', 3, 20, '曲江校区研究生住宿生活区域。', 80, 1, 0),
    (@campus_xjtu_qujiang, '专家公寓', 3, 20, '专家住宿生活相关区域。', 76, 1, 0),
    (@campus_xjtu_qujiang, '学生食堂', 3, 35, '曲江校区日常就餐点位。', 80, 1, 0),
    (@campus_xjtu_qujiang, '清真食堂', 3, 30, '满足清真餐饮需求的生活餐饮点位。', 76, 1, 0),
    (@campus_xjtu_qujiang, '教工食堂', 3, 35, '教职工日常就餐点位。', 76, 1, 0),
    (@campus_xjtu_qujiang, '校医院', 3, 20, '基础医疗与健康服务点位。', 76, 1, 0),
    (@campus_xjtu_qujiang, '师生服务中心', 3, 25, '校园事务办理和师生服务点位。', 78, 1, 0),
    (@campus_xjtu_qujiang, '后勤服务中心', 3, 25, '校园后勤保障和生活服务相关点位。', 76, 1, 0),
    (@campus_xjtu_qujiang, '快递中心', 3, 20, '校园快递和物流服务点位。', 78, 1, 0),
    (@campus_xjtu_qujiang, '校园超市', 3, 20, '日常购物和生活补给点位。', 78, 1, 0),
    (@campus_xjtu_qujiang, '曲江景园', 1, 30, '曲江校区公共景观和休闲点位。', 80, 1, 0),
    (@campus_xjtu_qujiang, '中心绿地', 1, 25, '曲江校区中心公共绿地和休闲空间。', 80, 1, 0),
    (@campus_xjtu_qujiang, '景观湖', 1, 30, '曲江校区水系景观和休闲点位。', 80, 1, 0),
    (@campus_xjtu_qujiang, '校区石门', 1, 20, '曲江校区标识性景观和通行节点。', 78, 1, 0),
    (@campus_xjtu_qujiang, '旗杆广场', 1, 25, '校园公共活动和仪式空间。', 78, 1, 0),
    (@campus_xjtu_qujiang, '西迁精神文化墙', 1, 25, '展示西迁精神和校园文化的景观空间。', 82, 1, 0),
    (@campus_xjtu_qujiang, '创新研究院集群楼', 2, 45, '创新研究院相关科研办公和学术研究楼宇。', 86, 1, 0);

SET @campus_xjtu_iharbour = (
    SELECT c.id FROM campus c JOIN university u ON c.university_id = u.id
    WHERE u.name = '西安交通大学' AND c.name = '中国西部科技创新港' AND c.is_deleted = 0 AND u.is_deleted = 0 LIMIT 1
);

SELECT IF(@campus_xjtu_iharbour IS NULL, 1 / 0, @campus_xjtu_iharbour) AS campus_check;

DELETE FROM poi
WHERE campus_id = @campus_xjtu_iharbour
  AND name IN ('涵英楼', '图书资料中心', '科研平台区', '学院区', '综合服务中心', '学生公寓区', '创新港食堂', '运动场',
               '南校门', '北校门', '东校门', '西校门', '涵英楼（5 号巨构）',
               '躬行楼（3 号巨构）', '泓理楼（4 号巨构）', '力行楼', '泓润楼',
               '泓德楼', '教学实验综合楼', '工程训练中心', '学术交流中心',
               '高等工程教育博物馆', '图书馆', '智慧教室', '学术报告厅', '体育馆',
               '游泳馆', '东体育场', '西体育场', '风雨操场', '篮球场', '排球场',
               '网球场', '羽毛球场', '乒乓球场', '和园（A 区）学生公寓',
               '慧园（B 区）学生公寓', '朗园（C 区）学生公寓', '研究生公寓',
               '留学生公寓', '专家公寓', '和园食堂', '慧园食堂', '朗园食堂',
               '清真食堂', '教工食堂', '风味餐厅', '校医院', '事务中心',
               '快递中心', '洗衣中心', '校园超市', '咖啡店', '理发店', '打印店',
               '健身房', '学镇湖景观区', '中心绿地', '下沉广场', '西迁大道景观带',
               '创新港文化广场');

INSERT INTO poi
(campus_id, name, category, suggested_duration, intro, hot_score, data_status, is_deleted)
VALUES
    (@campus_xjtu_iharbour, '南校门', 1, 15, '创新港南侧主要出入口。', 82, 1, 0),
    (@campus_xjtu_iharbour, '北校门', 1, 15, '创新港北侧出入口。', 80, 1, 0),
    (@campus_xjtu_iharbour, '东校门', 1, 15, '创新港东侧出入口。', 80, 1, 0),
    (@campus_xjtu_iharbour, '西校门', 1, 15, '创新港西侧出入口。', 80, 1, 0),
    (@campus_xjtu_iharbour, '涵英楼（5 号巨构）', 2, 40, '创新港教学科研和综合服务相关巨构楼宇。', 88, 1, 0),
    (@campus_xjtu_iharbour, '躬行楼（3 号巨构）', 2, 40, '创新港教学科研和实验实践相关巨构楼宇。', 88, 1, 0),
    (@campus_xjtu_iharbour, '泓理楼（4 号巨构）', 2, 40, '创新港教学科研和学术活动相关巨构楼宇。', 88, 1, 0),
    (@campus_xjtu_iharbour, '力行楼', 2, 35, '教学科研和课程学习相关楼宇。', 84, 1, 0),
    (@campus_xjtu_iharbour, '泓润楼', 2, 35, '教学科研和课程学习相关楼宇。', 84, 1, 0),
    (@campus_xjtu_iharbour, '泓德楼', 2, 35, '教学科研和课程学习相关楼宇。', 84, 1, 0),
    (@campus_xjtu_iharbour, '教学实验综合楼', 2, 45, '课程教学、实验教学和自习活动综合楼宇。', 86, 1, 0),
    (@campus_xjtu_iharbour, '工程训练中心', 2, 45, '工程实践、实验训练和动手能力培养空间。', 86, 1, 0),
    (@campus_xjtu_iharbour, '学术交流中心', 2, 35, '学术会议、交流和报告活动相关空间。', 84, 1, 0),
    (@campus_xjtu_iharbour, '高等工程教育博物馆', 1, 40, '展示工程教育历史和校园文化的特色点位。', 86, 1, 0),
    (@campus_xjtu_iharbour, '图书馆', 2, 60, '创新港学习、自习和文献服务核心点位。', 88, 1, 0),
    (@campus_xjtu_iharbour, '智慧教室', 2, 35, '智慧教学、研讨学习和课程活动空间。', 84, 1, 0),
    (@campus_xjtu_iharbour, '学术报告厅', 2, 35, '学术报告、讲座和校园活动空间。', 84, 1, 0),
    (@campus_xjtu_iharbour, '体育馆', 4, 35, '室内体育教学、训练和赛事活动场馆。', 82, 1, 0),
    (@campus_xjtu_iharbour, '游泳馆', 4, 35, '游泳教学、训练和体育活动场馆。', 80, 1, 0),
    (@campus_xjtu_iharbour, '东体育场', 4, 30, '东侧户外体育活动空间。', 80, 1, 0),
    (@campus_xjtu_iharbour, '西体育场', 4, 30, '西侧户外体育活动空间。', 80, 1, 0),
    (@campus_xjtu_iharbour, '风雨操场', 4, 30, '适合雨雪天气下开展体育活动的运动空间。', 78, 1, 0),
    (@campus_xjtu_iharbour, '篮球场', 4, 25, '篮球运动和课余体育活动场地。', 78, 1, 0),
    (@campus_xjtu_iharbour, '排球场', 4, 25, '排球运动和体育课活动场地。', 76, 1, 0),
    (@campus_xjtu_iharbour, '网球场', 4, 25, '网球运动和日常锻炼场地。', 76, 1, 0),
    (@campus_xjtu_iharbour, '羽毛球场', 4, 25, '羽毛球运动和日常锻炼场地。', 76, 1, 0),
    (@campus_xjtu_iharbour, '乒乓球场', 4, 25, '乒乓球运动和日常锻炼场地。', 76, 1, 0),
    (@campus_xjtu_iharbour, '和园（A 区）学生公寓', 3, 20, '创新港和园学生住宿生活区域。', 80, 1, 0),
    (@campus_xjtu_iharbour, '慧园（B 区）学生公寓', 3, 20, '创新港慧园学生住宿生活区域。', 80, 1, 0),
    (@campus_xjtu_iharbour, '朗园（C 区）学生公寓', 3, 20, '创新港朗园学生住宿生活区域。', 80, 1, 0),
    (@campus_xjtu_iharbour, '研究生公寓', 3, 20, '研究生住宿生活区域。', 78, 1, 0),
    (@campus_xjtu_iharbour, '留学生公寓', 3, 20, '留学生住宿生活区域。', 78, 1, 0),
    (@campus_xjtu_iharbour, '专家公寓', 3, 20, '专家住宿生活相关区域。', 76, 1, 0),
    (@campus_xjtu_iharbour, '和园食堂', 3, 35, '创新港和园日常就餐点位。', 82, 1, 0),
    (@campus_xjtu_iharbour, '慧园食堂', 3, 35, '创新港慧园日常就餐点位。', 82, 1, 0),
    (@campus_xjtu_iharbour, '朗园食堂', 3, 35, '创新港朗园日常就餐点位。', 82, 1, 0),
    (@campus_xjtu_iharbour, '清真食堂', 3, 30, '满足清真餐饮需求的生活餐饮点位。', 78, 1, 0),
    (@campus_xjtu_iharbour, '教工食堂', 3, 35, '教职工日常就餐点位。', 76, 1, 0),
    (@campus_xjtu_iharbour, '风味餐厅', 3, 35, '风味餐饮和多样化就餐点位。', 80, 1, 0),
    (@campus_xjtu_iharbour, '校医院', 3, 20, '基础医疗与健康服务点位。', 76, 1, 0),
    (@campus_xjtu_iharbour, '事务中心', 3, 25, '校园事务办理和师生服务点位。', 78, 1, 0),
    (@campus_xjtu_iharbour, '快递中心', 3, 20, '校园快递和物流服务点位。', 80, 1, 0),
    (@campus_xjtu_iharbour, '洗衣中心', 3, 20, '学生日常洗衣服务点位。', 78, 1, 0),
    (@campus_xjtu_iharbour, '校园超市', 3, 20, '日常购物和生活补给点位。', 80, 1, 0),
    (@campus_xjtu_iharbour, '咖啡店', 3, 20, '咖啡饮品和轻食休闲点位。', 76, 1, 0),
    (@campus_xjtu_iharbour, '理发店', 3, 20, '日常理发和生活服务点位。', 76, 1, 0),
    (@campus_xjtu_iharbour, '打印店', 3, 20, '打印复印和学习资料服务点位。', 76, 1, 0),
    (@campus_xjtu_iharbour, '健身房', 4, 30, '室内健身和力量训练空间。', 78, 1, 0),
    (@campus_xjtu_iharbour, '学镇湖景观区', 1, 30, '创新港水系景观和休闲点位。', 82, 1, 0),
    (@campus_xjtu_iharbour, '中心绿地', 1, 25, '创新港中心公共绿地和休闲空间。', 80, 1, 0),
    (@campus_xjtu_iharbour, '下沉广场', 1, 25, '公共活动、通行和休闲空间。', 78, 1, 0),
    (@campus_xjtu_iharbour, '西迁大道景观带', 1, 30, '体现西迁精神和校园文化的步行景观带。', 84, 1, 0),
    (@campus_xjtu_iharbour, '创新港文化广场', 1, 25, '创新港公共活动和文化展示广场。', 82, 1, 0);

SET @campus_nuaa_ming = (
    SELECT c.id FROM campus c JOIN university u ON c.university_id = u.id
    WHERE u.name = '南京航空航天大学' AND c.name = '明故宫校区' AND c.is_deleted = 0 AND u.is_deleted = 0 LIMIT 1
);

SELECT IF(@campus_nuaa_ming IS NULL, 1 / 0, @campus_nuaa_ming) AS campus_check;

DELETE FROM poi
WHERE campus_id = @campus_nuaa_ming
  AND name IN (
               '西大门', '北门', '南门', '小西门', 'A1教学楼', 'A2教学楼', 'A3教学楼',
               'A5教学楼', 'A6教学楼', 'A7教学楼', 'A8机械楼', 'A9机械楼',
               'A19航空宇航楼', 'A21教学楼', '逸夫科学馆', '图书馆', '行政办公楼',
               '荟萃楼', '综合楼', '档案馆', '航空学院楼', '能源与动力学院楼',
               '航空航天馆', '工程实训中心', '体育馆', '田径场', '篮球场', '排球场',
               '网球场', '羽毛球场', '大学生活动中心', '校医院', 'B16学生宿舍',
               'B17学生宿舍', '第一食堂', '第二食堂', '东华湖', '御园景观区',
               '科技一条街', '校园超市', '菜鸟驿站', '快递中心',
               '教学主楼', '办公大楼', '校史馆', '行政楼', '食堂餐厅', '学生宿舍区', '运动场'
    );

INSERT INTO poi
(campus_id, name, category, suggested_duration, intro, hot_score, data_status, is_deleted)
VALUES
    (@campus_nuaa_ming, '西大门', 1, 15, '明故宫校区西侧主要出入口。', 86, 1, 0),
    (@campus_nuaa_ming, '北门', 1, 15, '明故宫校区北侧出入口。', 82, 1, 0),
    (@campus_nuaa_ming, '南门', 1, 15, '明故宫校区南侧出入口。', 82, 1, 0),
    (@campus_nuaa_ming, '小西门', 1, 15, '明故宫校区西侧辅助出入口。', 78, 1, 0),
    (@campus_nuaa_ming, 'A1教学楼', 2, 35, '明故宫校区课程教学楼宇。', 87, 1, 0),
    (@campus_nuaa_ming, 'A2教学楼', 2, 35, '明故宫校区课程教学楼宇。', 87, 1, 0),
    (@campus_nuaa_ming, 'A3教学楼', 2, 35, '明故宫校区课程教学楼宇。', 86, 1, 0),
    (@campus_nuaa_ming, 'A5教学楼', 2, 35, '明故宫校区课程教学楼宇。', 86, 1, 0),
    (@campus_nuaa_ming, 'A6教学楼', 2, 35, '明故宫校区课程教学楼宇。', 86, 1, 0),
    (@campus_nuaa_ming, 'A7教学楼', 2, 35, '明故宫校区课程教学楼宇。', 86, 1, 0),
    (@campus_nuaa_ming, 'A8机械楼', 2, 40, '机械相关教学科研楼宇。', 88, 1, 0),
    (@campus_nuaa_ming, 'A9机械楼', 2, 40, '机械相关教学科研楼宇。', 88, 1, 0),
    (@campus_nuaa_ming, 'A19航空宇航楼', 2, 45, '航空宇航相关教学科研楼宇。', 92, 1, 0),
    (@campus_nuaa_ming, 'A21教学楼', 2, 35, '明故宫校区课程教学楼宇。', 86, 1, 0),
    (@campus_nuaa_ming, '逸夫科学馆', 2, 40, '教学科研和学术活动相关楼宇。', 88, 1, 0),
    (@campus_nuaa_ming, '图书馆', 2, 60, '明故宫校区学习、自习和文献服务核心点位。', 91, 1, 0),
    (@campus_nuaa_ming, '行政办公楼', 2, 25, '行政办公和校务服务相关楼宇。', 82, 1, 0),
    (@campus_nuaa_ming, '荟萃楼', 2, 30, '教学科研和综合服务相关楼宇。', 82, 1, 0),
    (@campus_nuaa_ming, '综合楼', 2, 30, '综合教学、办公和服务楼宇。', 82, 1, 0),
    (@campus_nuaa_ming, '档案馆', 2, 30, '档案资料保存和校史资料服务点位。', 80, 1, 0),
    (@campus_nuaa_ming, '航空学院楼', 2, 40, '航空学院教学科研相关楼宇。', 90, 1, 0),
    (@campus_nuaa_ming, '能源与动力学院楼', 2, 40, '能源与动力学院教学科研相关楼宇。', 88, 1, 0),
    (@campus_nuaa_ming, '航空航天馆', 1, 45, '展示航空航天特色和学科文化的校园点位。', 93, 1, 0),
    (@campus_nuaa_ming, '工程实训中心', 2, 45, '工程实践、实验训练和动手能力培养空间。', 89, 1, 0),
    (@campus_nuaa_ming, '体育馆', 4, 35, '室内体育教学、训练和赛事活动场馆。', 84, 1, 0),
    (@campus_nuaa_ming, '田径场', 4, 30, '跑步、体测和户外体育活动空间。', 83, 1, 0),
    (@campus_nuaa_ming, '篮球场', 4, 25, '篮球运动和课余体育活动场地。', 80, 1, 0),
    (@campus_nuaa_ming, '排球场', 4, 25, '排球运动和体育课活动场地。', 78, 1, 0),
    (@campus_nuaa_ming, '网球场', 4, 25, '网球运动和日常锻炼场地。', 78, 1, 0),
    (@campus_nuaa_ming, '羽毛球场', 4, 25, '羽毛球运动和日常锻炼场地。', 78, 1, 0),
    (@campus_nuaa_ming, '大学生活动中心', 1, 30, '学生事务、社团和校园公共活动相关空间。', 84, 1, 0),
    (@campus_nuaa_ming, '校医院', 3, 20, '基础医疗与健康服务点位。', 78, 1, 0),
    (@campus_nuaa_ming, 'B16学生宿舍', 3, 20, '明故宫校区学生住宿生活楼宇。', 80, 1, 0),
    (@campus_nuaa_ming, 'B17学生宿舍', 3, 20, '明故宫校区学生住宿生活楼宇。', 80, 1, 0),
    (@campus_nuaa_ming, '第一食堂', 3, 35, '明故宫校区日常就餐点位。', 84, 1, 0),
    (@campus_nuaa_ming, '第二食堂', 3, 35, '明故宫校区日常就餐点位。', 83, 1, 0),
    (@campus_nuaa_ming, '东华湖', 1, 30, '明故宫校区水系景观和休闲点位。', 84, 1, 0),
    (@campus_nuaa_ming, '御园景观区', 1, 30, '明故宫校区公共景观和休闲区域。', 82, 1, 0),
    (@campus_nuaa_ming, '科技一条街', 3, 25, '校园生活服务和商业配套集中区域。', 82, 1, 0),
    (@campus_nuaa_ming, '校园超市', 3, 20, '日常购物和生活补给点位。', 82, 1, 0),
    (@campus_nuaa_ming, '菜鸟驿站', 3, 20, '学生日常取寄快递点位。', 82, 1, 0),
    (@campus_nuaa_ming, '快递中心', 3, 20, '校园快递和物流服务点位。', 82, 1, 0);

SET @campus_nuaa_jiangjun = (
    SELECT c.id FROM campus c JOIN university u ON c.university_id = u.id
    WHERE u.name = '南京航空航天大学' AND c.name = '将军路校区' AND c.is_deleted = 0 AND u.is_deleted = 0 LIMIT 1
);

SELECT IF(@campus_nuaa_jiangjun IS NULL, 1 / 0, @campus_nuaa_jiangjun) AS campus_check;

DELETE FROM poi
WHERE campus_id = @campus_nuaa_jiangjun
  AND name IN (
               '北门', '西门', '小西门', '东区正门', '南区小门', '一号教学楼', '二号教学楼',
               '三号教学楼', '四号教学楼', '五号教学楼', '六号教学楼', '七号教学楼',
               'D1教学楼', 'D2教学楼', 'D3教学楼', '综合楼', '行政办公楼', '图书馆',
               '大学生活动中心', '工程训练中心', '科创大厦', '民航科研楼', '人文学院楼',
               '自动化学院楼', '电子信息学院楼', '材料科学学院楼', '航空学院楼',
               '航天学院楼', '民航学院楼', '经管学院楼', '长空学院楼', '理学院楼',
               '艺术学院楼', '留学生公寓楼', '御风园', '砚湖', '樱花广场', '艺体广场',
               '中心绿地', '中天桥', '西操场', '东操场', '中心运动场', '东区体育馆',
               '西区体育中心', '游泳馆', '风雨操场', '篮球场', '排球场', '网球场',
               '羽毛球场', '慧园宿舍', '博园宿舍', '怡园宿舍', '馨园宿舍', '和园宿舍',
               '一食堂', '二食堂', '三食堂', '四食堂', '清真食堂', '五食堂', '六食堂',
               '校医院', '校园商业街', '师生服务中心', '后勤服务中心', '菜鸟驿站',
               '校园快递中心', '校园超市', '校巴停靠点',
               '学生发展中心', '学生工作楼', '教学楼', '体育场馆', '食堂餐厅', '学生宿舍区',
               '师生服务大厅', '东区生活服务区'
    );

INSERT INTO poi
(campus_id, name, category, suggested_duration, intro, hot_score, data_status, is_deleted)
VALUES
    (@campus_nuaa_jiangjun, '北门', 1, 15, '将军路校区北侧出入口。', 84, 1, 0),
    (@campus_nuaa_jiangjun, '西门', 1, 15, '将军路校区西侧出入口。', 82, 1, 0),
    (@campus_nuaa_jiangjun, '小西门', 1, 15, '将军路校区西侧辅助出入口。', 78, 1, 0),
    (@campus_nuaa_jiangjun, '东区正门', 1, 15, '将军路校区东区主要出入口。', 82, 1, 0),
    (@campus_nuaa_jiangjun, '南区小门', 1, 15, '将军路校区南区辅助出入口。', 78, 1, 0),
    (@campus_nuaa_jiangjun, '一号教学楼', 2, 35, '将军路校区课程教学楼宇。', 87, 1, 0),
    (@campus_nuaa_jiangjun, '二号教学楼', 2, 35, '将军路校区课程教学楼宇。', 87, 1, 0),
    (@campus_nuaa_jiangjun, '三号教学楼', 2, 35, '将军路校区课程教学楼宇。', 86, 1, 0),
    (@campus_nuaa_jiangjun, '四号教学楼', 2, 35, '将军路校区课程教学楼宇。', 86, 1, 0),
    (@campus_nuaa_jiangjun, '五号教学楼', 2, 35, '将军路校区课程教学楼宇。', 86, 1, 0),
    (@campus_nuaa_jiangjun, '六号教学楼', 2, 35, '将军路校区课程教学楼宇。', 86, 1, 0),
    (@campus_nuaa_jiangjun, '七号教学楼', 2, 35, '将军路校区课程教学楼宇。', 86, 1, 0),
    (@campus_nuaa_jiangjun, 'D1教学楼', 2, 35, '将军路校区课程教学楼宇。', 85, 1, 0),
    (@campus_nuaa_jiangjun, 'D2教学楼', 2, 35, '将军路校区课程教学楼宇。', 85, 1, 0),
    (@campus_nuaa_jiangjun, 'D3教学楼', 2, 35, '将军路校区课程教学楼宇。', 85, 1, 0),
    (@campus_nuaa_jiangjun, '综合楼', 2, 30, '综合教学、办公和服务楼宇。', 84, 1, 0),
    (@campus_nuaa_jiangjun, '行政办公楼', 2, 25, '行政办公和校务服务相关楼宇。', 82, 1, 0),
    (@campus_nuaa_jiangjun, '图书馆', 2, 60, '将军路校区学习、自习和文献服务核心点位。', 92, 1, 0),
    (@campus_nuaa_jiangjun, '大学生活动中心', 1, 30, '学生事务、社团活动和校园公共活动相关空间。', 88, 1, 0),
    (@campus_nuaa_jiangjun, '工程训练中心', 2, 45, '工程实践、实验训练和动手能力培养空间。', 89, 1, 0),
    (@campus_nuaa_jiangjun, '科创大厦', 2, 40, '科技创新、科研实践和项目孵化相关楼宇。', 88, 1, 0),
    (@campus_nuaa_jiangjun, '民航科研楼', 2, 40, '民航相关科研和教学楼宇。', 88, 1, 0),
    (@campus_nuaa_jiangjun, '人文学院楼', 2, 35, '人文学院教学科研相关楼宇。', 82, 1, 0),
    (@campus_nuaa_jiangjun, '自动化学院楼', 2, 40, '自动化学院教学科研相关楼宇。', 86, 1, 0),
    (@campus_nuaa_jiangjun, '电子信息学院楼', 2, 40, '电子信息学院教学科研相关楼宇。', 86, 1, 0),
    (@campus_nuaa_jiangjun, '材料科学学院楼', 2, 40, '材料科学学院教学科研相关楼宇。', 84, 1, 0),
    (@campus_nuaa_jiangjun, '航空学院楼', 2, 40, '航空学院教学科研相关楼宇。', 89, 1, 0),
    (@campus_nuaa_jiangjun, '航天学院楼', 2, 40, '航天学院教学科研相关楼宇。', 89, 1, 0),
    (@campus_nuaa_jiangjun, '民航学院楼', 2, 40, '民航学院教学科研相关楼宇。', 88, 1, 0),
    (@campus_nuaa_jiangjun, '经管学院楼', 2, 35, '经济与管理学院教学科研相关楼宇。', 82, 1, 0),
    (@campus_nuaa_jiangjun, '长空学院楼', 2, 35, '长空学院教学和学生培养相关楼宇。', 84, 1, 0),
    (@campus_nuaa_jiangjun, '理学院楼', 2, 35, '理学院教学科研相关楼宇。', 82, 1, 0),
    (@campus_nuaa_jiangjun, '艺术学院楼', 2, 35, '艺术学院教学和活动相关楼宇。', 80, 1, 0),
    (@campus_nuaa_jiangjun, '留学生公寓楼', 3, 20, '留学生住宿生活区域。', 80, 1, 0),
    (@campus_nuaa_jiangjun, '御风园', 1, 25, '将军路校区公共景观和休闲区域。', 82, 1, 0),
    (@campus_nuaa_jiangjun, '砚湖', 1, 30, '将军路校区水系景观和休闲点位。', 84, 1, 0),
    (@campus_nuaa_jiangjun, '樱花广场', 1, 25, '将军路校区季节性景观和公共活动空间。', 83, 1, 0),
    (@campus_nuaa_jiangjun, '艺体广场', 1, 25, '艺术、体育和公共活动相关广场。', 80, 1, 0),
    (@campus_nuaa_jiangjun, '中心绿地', 1, 25, '将军路校区中心公共绿地。', 82, 1, 0),
    (@campus_nuaa_jiangjun, '中天桥', 1, 20, '校内步行连接和景观识别点位。', 78, 1, 0),
    (@campus_nuaa_jiangjun, '西操场', 4, 30, '西区户外体育活动空间。', 82, 1, 0),
    (@campus_nuaa_jiangjun, '东操场', 4, 30, '东区户外体育活动空间。', 82, 1, 0),
    (@campus_nuaa_jiangjun, '中心运动场', 4, 35, '校区大型体育活动和体测训练空间。', 84, 1, 0),
    (@campus_nuaa_jiangjun, '东区体育馆', 4, 35, '东区室内体育教学和运动场馆。', 82, 1, 0),
    (@campus_nuaa_jiangjun, '西区体育中心', 4, 35, '西区体育教学、训练和活动场馆。', 82, 1, 0),
    (@campus_nuaa_jiangjun, '游泳馆', 4, 35, '游泳教学、训练和体育活动场馆。', 80, 1, 0),
    (@campus_nuaa_jiangjun, '风雨操场', 4, 30, '适合雨雪天气下开展体育活动的运动空间。', 80, 1, 0),
    (@campus_nuaa_jiangjun, '篮球场', 4, 25, '篮球运动和课余体育活动场地。', 80, 1, 0),
    (@campus_nuaa_jiangjun, '排球场', 4, 25, '排球运动和体育课活动场地。', 78, 1, 0),
    (@campus_nuaa_jiangjun, '网球场', 4, 25, '网球运动和日常锻炼场地。', 78, 1, 0),
    (@campus_nuaa_jiangjun, '羽毛球场', 4, 25, '羽毛球运动和日常锻炼场地。', 78, 1, 0),
    (@campus_nuaa_jiangjun, '慧园宿舍', 3, 20, '将军路校区学生住宿生活区域。', 83, 1, 0),
    (@campus_nuaa_jiangjun, '博园宿舍', 3, 20, '将军路校区学生住宿生活区域。', 83, 1, 0),
    (@campus_nuaa_jiangjun, '怡园宿舍', 3, 20, '将军路校区学生住宿生活区域。', 83, 1, 0),
    (@campus_nuaa_jiangjun, '馨园宿舍', 3, 20, '将军路校区学生住宿生活区域。', 83, 1, 0),
    (@campus_nuaa_jiangjun, '和园宿舍', 3, 20, '将军路校区学生住宿生活区域。', 83, 1, 0),
    (@campus_nuaa_jiangjun, '一食堂', 3, 35, '将军路校区日常就餐点位。', 87, 1, 0),
    (@campus_nuaa_jiangjun, '二食堂', 3, 35, '将军路校区日常就餐点位。', 86, 1, 0),
    (@campus_nuaa_jiangjun, '三食堂', 3, 35, '将军路校区日常就餐点位。', 86, 1, 0),
    (@campus_nuaa_jiangjun, '四食堂', 3, 35, '将军路校区日常就餐点位。', 85, 1, 0),
    (@campus_nuaa_jiangjun, '清真食堂', 3, 30, '满足清真餐饮需求的生活餐饮点位。', 82, 1, 0),
    (@campus_nuaa_jiangjun, '五食堂', 3, 35, '将军路校区日常就餐点位。', 85, 1, 0),
    (@campus_nuaa_jiangjun, '六食堂', 3, 35, '将军路校区日常就餐点位。', 84, 1, 0),
    (@campus_nuaa_jiangjun, '校医院', 3, 20, '基础医疗与健康服务点位。', 78, 1, 0),
    (@campus_nuaa_jiangjun, '校园商业街', 3, 25, '餐饮、购物和生活服务集中区域。', 84, 1, 0),
    (@campus_nuaa_jiangjun, '师生服务中心', 3, 25, '校园事务办理和师生服务点位。', 82, 1, 0),
    (@campus_nuaa_jiangjun, '后勤服务中心', 3, 25, '校园后勤保障和生活服务相关点位。', 80, 1, 0),
    (@campus_nuaa_jiangjun, '菜鸟驿站', 3, 20, '学生日常取寄快递点位。', 82, 1, 0),
    (@campus_nuaa_jiangjun, '校园快递中心', 3, 20, '校园快递和物流服务点位。', 82, 1, 0),
    (@campus_nuaa_jiangjun, '校园超市', 3, 20, '日常购物和生活补给点位。', 82, 1, 0),
    (@campus_nuaa_jiangjun, '校巴停靠点', 3, 15, '校内外通勤和校区交通换乘点位。', 80, 1, 0);

SET @campus_nuaa_tianmu = (
    SELECT c.id FROM campus c JOIN university u ON c.university_id = u.id
    WHERE u.name = '南京航空航天大学' AND c.name = '天目湖校区' AND c.is_deleted = 0 AND u.is_deleted = 0 LIMIT 1
);

SELECT IF(@campus_nuaa_tianmu IS NULL, 1 / 0, @campus_nuaa_tianmu) AS campus_check;

DELETE FROM poi
WHERE campus_id = @campus_nuaa_tianmu
  AND name IN (
               '西校门', '南校门', '东校门', '东北校门', '西北校门', '巡天楼', '牧星楼',
               '一号基础教学实验楼', '二号基础教学实验楼', '工程培训中心', '行政楼',
               '明慧图书馆', '尚德楼', '知行楼', '笃行楼', '健翔体育中心', '东体育场',
               '西体育场', '风雨操场', '篮球场', '排球场', '网球场', '羽毛球场',
               '乒乓球场', '飞行员训练场', '南山苑宿舍', '东篱苑宿舍', '职工公寓',
               '南山苑餐厅', '东篱苑餐厅', '校医院', '泗水湖', '友谊林', '师生服务大厅',
               '快递中心', '校园超市', '罗森便利店',
               '南山苑', 'B1教学楼', '食堂餐厅', '体育场馆', '学生宿舍区', '通用航空教学区'
    );

INSERT INTO poi
(campus_id, name, category, suggested_duration, intro, hot_score, data_status, is_deleted)
VALUES
    (@campus_nuaa_tianmu, '西校门', 1, 15, '天目湖校区西侧出入口。', 80, 1, 0),
    (@campus_nuaa_tianmu, '南校门', 1, 15, '天目湖校区南侧出入口。', 80, 1, 0),
    (@campus_nuaa_tianmu, '东校门', 1, 15, '天目湖校区东侧出入口。', 80, 1, 0),
    (@campus_nuaa_tianmu, '东北校门', 1, 15, '天目湖校区东北侧出入口。', 78, 1, 0),
    (@campus_nuaa_tianmu, '西北校门', 1, 15, '天目湖校区西北侧出入口。', 78, 1, 0),
    (@campus_nuaa_tianmu, '巡天楼', 2, 35, '天目湖校区教学科研相关楼宇。', 84, 1, 0),
    (@campus_nuaa_tianmu, '牧星楼', 2, 35, '天目湖校区教学科研相关楼宇。', 84, 1, 0),
    (@campus_nuaa_tianmu, '一号基础教学实验楼', 2, 40, '基础课程教学和实验教学楼宇。', 85, 1, 0),
    (@campus_nuaa_tianmu, '二号基础教学实验楼', 2, 40, '基础课程教学和实验教学楼宇。', 85, 1, 0),
    (@campus_nuaa_tianmu, '工程培训中心', 2, 45, '工程实践、训练和实验教学相关空间。', 86, 1, 0),
    (@campus_nuaa_tianmu, '行政楼', 2, 25, '行政办公和校务服务相关楼宇。', 80, 1, 0),
    (@campus_nuaa_tianmu, '明慧图书馆', 2, 60, '天目湖校区学习、自习和文献服务核心点位。', 88, 1, 0),
    (@campus_nuaa_tianmu, '尚德楼', 2, 35, '天目湖校区教学办公相关楼宇。', 83, 1, 0),
    (@campus_nuaa_tianmu, '知行楼', 2, 35, '天目湖校区教学科研相关楼宇。', 83, 1, 0),
    (@campus_nuaa_tianmu, '笃行楼', 2, 35, '天目湖校区教学科研相关楼宇。', 83, 1, 0),
    (@campus_nuaa_tianmu, '健翔体育中心', 4, 35, '体育教学、训练和活动场馆。', 84, 1, 0),
    (@campus_nuaa_tianmu, '东体育场', 4, 30, '东侧户外体育活动空间。', 80, 1, 0),
    (@campus_nuaa_tianmu, '西体育场', 4, 30, '西侧户外体育活动空间。', 80, 1, 0),
    (@campus_nuaa_tianmu, '风雨操场', 4, 30, '适合雨雪天气下开展体育活动的运动空间。', 80, 1, 0),
    (@campus_nuaa_tianmu, '篮球场', 4, 25, '篮球运动和课余体育活动场地。', 78, 1, 0),
    (@campus_nuaa_tianmu, '排球场', 4, 25, '排球运动和体育课活动场地。', 76, 1, 0),
    (@campus_nuaa_tianmu, '网球场', 4, 25, '网球运动和日常锻炼场地。', 76, 1, 0),
    (@campus_nuaa_tianmu, '羽毛球场', 4, 25, '羽毛球运动和日常锻炼场地。', 76, 1, 0),
    (@campus_nuaa_tianmu, '乒乓球场', 4, 25, '乒乓球运动和日常锻炼场地。', 76, 1, 0),
    (@campus_nuaa_tianmu, '飞行员训练场', 4, 35, '飞行训练和航空特色实践相关场地。', 84, 1, 0),
    (@campus_nuaa_tianmu, '南山苑宿舍', 3, 20, '天目湖校区学生住宿生活区域。', 82, 1, 0),
    (@campus_nuaa_tianmu, '东篱苑宿舍', 3, 20, '天目湖校区学生住宿生活区域。', 82, 1, 0),
    (@campus_nuaa_tianmu, '职工公寓', 3, 20, '教职工住宿生活相关区域。', 76, 1, 0),
    (@campus_nuaa_tianmu, '南山苑餐厅', 3, 35, '天目湖校区日常就餐点位。', 83, 1, 0),
    (@campus_nuaa_tianmu, '东篱苑餐厅', 3, 35, '天目湖校区日常就餐点位。', 83, 1, 0),
    (@campus_nuaa_tianmu, '校医院', 3, 20, '基础医疗与健康服务点位。', 76, 1, 0),
    (@campus_nuaa_tianmu, '泗水湖', 1, 30, '天目湖校区水系景观和休闲点位。', 82, 1, 0),
    (@campus_nuaa_tianmu, '友谊林', 1, 25, '天目湖校区公共景观和休闲区域。', 80, 1, 0),
    (@campus_nuaa_tianmu, '师生服务大厅', 3, 25, '校园事务办理和师生服务点位。', 81, 1, 0),
    (@campus_nuaa_tianmu, '快递中心', 3, 20, '校园快递和物流服务点位。', 80, 1, 0),
    (@campus_nuaa_tianmu, '校园超市', 3, 20, '日常购物和生活补给点位。', 80, 1, 0),
    (@campus_nuaa_tianmu, '罗森便利店', 3, 20, '校园便利购物和生活补给点位。', 78, 1, 0);

SET @campus_njust_nanjing = (
    SELECT c.id FROM campus c JOIN university u ON c.university_id = u.id
    WHERE u.name = '南京理工大学' AND c.name = '南京校区' AND c.is_deleted = 0 AND u.is_deleted = 0 LIMIT 1
);

SELECT IF(@campus_njust_nanjing IS NULL, 1 / 0, @campus_njust_nanjing) AS campus_check;

DELETE FROM poi
WHERE campus_id = @campus_njust_nanjing
  AND name IN (
               '南大门', '一号门', '二号门', '三号门', '四号门', '五号门',
               '一工（第一教学楼）', '二工（第二教学楼）', '三工（第三教学楼）',
               '四工（第四教学楼）', '五号楼', '六号楼', '七号楼', '八号楼',
               '九号楼', '十号楼', '第一实验楼', '第二实验楼', '第三实验楼',
               '第四实验楼', '第五实验楼', '第六实验楼', '第七实验楼',
               '第八实验楼', '第九实验楼', '第十实验楼', '图书馆', '行政办公楼',
               '兵器博物馆', '校史馆', '大学生创新创业中心', '逸夫楼', '综合服务楼',
               '体育馆', '游泳馆', '标准田径场', '篮球场', '排球场', '网球场',
               '羽毛球场', '乒乓球场', '北区宿舍 1-18 舍', '南区宿舍 19-30 舍',
               '研究生公寓', '学一食堂', '学二食堂', '学三食堂', '学四食堂',
               '清真食堂', '教工食堂', '风味餐厅', '校医院', '师生服务中心',
               '后勤服务中心', '菜鸟驿站', '校园快递中心', '校园超市', '教育超市',
               '校风碑广场', '喷泉广场', '时间广场', '水杉林景观区',
               '二月兰景观区', '中心绿地', '紫霞湖景观区',
               '教学楼', '实验楼', '学生食堂', '运动场', '学生活动中心', '学生宿舍区', '校园商业服务区'
    );

INSERT INTO poi
(campus_id, name, category, suggested_duration, intro, hot_score, data_status, is_deleted)
VALUES
    (@campus_njust_nanjing, '南大门', 1, 15, '孝陵卫校区南侧主要出入口。', 86, 1, 0),
    (@campus_njust_nanjing, '一号门', 1, 15, '孝陵卫校区校园出入口。', 82, 1, 0),
    (@campus_njust_nanjing, '二号门', 1, 15, '孝陵卫校区校园出入口。', 82, 1, 0),
    (@campus_njust_nanjing, '三号门', 1, 15, '孝陵卫校区校园出入口。', 80, 1, 0),
    (@campus_njust_nanjing, '四号门', 1, 15, '孝陵卫校区校园出入口。', 80, 1, 0),
    (@campus_njust_nanjing, '五号门', 1, 15, '孝陵卫校区校园出入口。', 78, 1, 0),
    (@campus_njust_nanjing, '一工（第一教学楼）', 2, 35, '课程教学和日常学习楼宇。', 86, 1, 0),
    (@campus_njust_nanjing, '二工（第二教学楼）', 2, 35, '课程教学和日常学习楼宇。', 86, 1, 0),
    (@campus_njust_nanjing, '三工（第三教学楼）', 2, 35, '课程教学和日常学习楼宇。', 86, 1, 0),
    (@campus_njust_nanjing, '四工（第四教学楼）', 2, 35, '课程教学和日常学习楼宇。', 86, 1, 0),
    (@campus_njust_nanjing, '五号楼', 2, 35, '教学、科研和办公相关楼宇。', 84, 1, 0),
    (@campus_njust_nanjing, '六号楼', 2, 35, '教学、科研和办公相关楼宇。', 84, 1, 0),
    (@campus_njust_nanjing, '七号楼', 2, 35, '教学、科研和办公相关楼宇。', 84, 1, 0),
    (@campus_njust_nanjing, '八号楼', 2, 35, '教学、科研和办公相关楼宇。', 84, 1, 0),
    (@campus_njust_nanjing, '九号楼', 2, 35, '教学、科研和办公相关楼宇。', 83, 1, 0),
    (@campus_njust_nanjing, '十号楼', 2, 35, '教学、科研和办公相关楼宇。', 83, 1, 0),
    (@campus_njust_nanjing, '第一实验楼', 2, 40, '实验教学和科研实践相关楼宇。', 86, 1, 0),
    (@campus_njust_nanjing, '第二实验楼', 2, 40, '实验教学和科研实践相关楼宇。', 86, 1, 0),
    (@campus_njust_nanjing, '第三实验楼', 2, 40, '实验教学和科研实践相关楼宇。', 85, 1, 0),
    (@campus_njust_nanjing, '第四实验楼', 2, 40, '实验教学和科研实践相关楼宇。', 85, 1, 0),
    (@campus_njust_nanjing, '第五实验楼', 2, 40, '实验教学和科研实践相关楼宇。', 85, 1, 0),
    (@campus_njust_nanjing, '第六实验楼', 2, 40, '实验教学和科研实践相关楼宇。', 84, 1, 0),
    (@campus_njust_nanjing, '第七实验楼', 2, 40, '实验教学和科研实践相关楼宇。', 84, 1, 0),
    (@campus_njust_nanjing, '第八实验楼', 2, 40, '实验教学和科研实践相关楼宇。', 84, 1, 0),
    (@campus_njust_nanjing, '第九实验楼', 2, 40, '实验教学和科研实践相关楼宇。', 83, 1, 0),
    (@campus_njust_nanjing, '第十实验楼', 2, 40, '实验教学和科研实践相关楼宇。', 83, 1, 0),
    (@campus_njust_nanjing, '图书馆', 2, 60, '孝陵卫校区学习、自习和文献服务核心点位。', 92, 1, 0),
    (@campus_njust_nanjing, '行政办公楼', 2, 25, '行政办公和校务服务相关楼宇。', 82, 1, 0),
    (@campus_njust_nanjing, '兵器博物馆', 1, 45, '展示学校兵器科学和军工办学传统的特色文化点位。', 93, 1, 0),
    (@campus_njust_nanjing, '校史馆', 1, 35, '展示学校办学历史和校园文化的点位。', 86, 1, 0),
    (@campus_njust_nanjing, '大学生创新创业中心', 2, 35, '创新创业实践、项目孵化和学生团队活动空间。', 86, 1, 0),
    (@campus_njust_nanjing, '逸夫楼', 2, 35, '教学科研和学术活动相关楼宇。', 84, 1, 0),
    (@campus_njust_nanjing, '综合服务楼', 3, 30, '校园事务办理和综合服务相关楼宇。', 82, 1, 0),
    (@campus_njust_nanjing, '体育馆', 4, 35, '室内体育教学、训练和赛事活动场馆。', 84, 1, 0),
    (@campus_njust_nanjing, '游泳馆', 4, 35, '游泳教学、训练和体育活动场馆。', 82, 1, 0),
    (@campus_njust_nanjing, '标准田径场', 4, 30, '跑步、体测和户外体育活动空间。', 84, 1, 0),
    (@campus_njust_nanjing, '篮球场', 4, 25, '篮球运动和课余体育活动场地。', 82, 1, 0),
    (@campus_njust_nanjing, '排球场', 4, 25, '排球运动和体育课活动场地。', 78, 1, 0),
    (@campus_njust_nanjing, '网球场', 4, 25, '网球运动和日常锻炼场地。', 78, 1, 0),
    (@campus_njust_nanjing, '羽毛球场', 4, 25, '羽毛球运动和日常锻炼场地。', 78, 1, 0),
    (@campus_njust_nanjing, '乒乓球场', 4, 25, '乒乓球运动和日常锻炼场地。', 78, 1, 0),
    (@campus_njust_nanjing, '北区宿舍 1-18 舍', 3, 20, '孝陵卫校区北区学生住宿生活区域。', 82, 1, 0),
    (@campus_njust_nanjing, '南区宿舍 19-30 舍', 3, 20, '孝陵卫校区南区学生住宿生活区域。', 82, 1, 0),
    (@campus_njust_nanjing, '研究生公寓', 3, 20, '研究生住宿生活区域。', 80, 1, 0),
    (@campus_njust_nanjing, '学一食堂', 3, 35, '孝陵卫校区日常就餐点位。', 86, 1, 0),
    (@campus_njust_nanjing, '学二食堂', 3, 35, '孝陵卫校区日常就餐点位。', 86, 1, 0),
    (@campus_njust_nanjing, '学三食堂', 3, 35, '孝陵卫校区日常就餐点位。', 85, 1, 0),
    (@campus_njust_nanjing, '学四食堂', 3, 35, '孝陵卫校区日常就餐点位。', 85, 1, 0),
    (@campus_njust_nanjing, '清真食堂', 3, 30, '满足清真餐饮需求的生活餐饮点位。', 82, 1, 0),
    (@campus_njust_nanjing, '教工食堂', 3, 35, '教职工日常就餐点位。', 78, 1, 0),
    (@campus_njust_nanjing, '风味餐厅', 3, 35, '风味餐饮和多样化就餐点位。', 84, 1, 0),
    (@campus_njust_nanjing, '校医院', 3, 20, '基础医疗与健康服务点位。', 78, 1, 0),
    (@campus_njust_nanjing, '师生服务中心', 3, 25, '校园事务办理和师生服务点位。', 82, 1, 0),
    (@campus_njust_nanjing, '后勤服务中心', 3, 25, '校园后勤保障和生活服务相关点位。', 80, 1, 0),
    (@campus_njust_nanjing, '菜鸟驿站', 3, 20, '学生日常取寄快递点位。', 82, 1, 0),
    (@campus_njust_nanjing, '校园快递中心', 3, 20, '校园快递和物流服务点位。', 82, 1, 0),
    (@campus_njust_nanjing, '校园超市', 3, 20, '日常购物和生活补给点位。', 82, 1, 0),
    (@campus_njust_nanjing, '教育超市', 3, 20, '学习用品和生活物资补给点位。', 80, 1, 0),
    (@campus_njust_nanjing, '校风碑广场', 1, 25, '体现学校精神和校园文化的公共广场。', 84, 1, 0),
    (@campus_njust_nanjing, '喷泉广场', 1, 25, '校园公共活动和景观休闲点位。', 82, 1, 0),
    (@campus_njust_nanjing, '时间广场', 1, 25, '校园文化和公共活动广场。', 82, 1, 0),
    (@campus_njust_nanjing, '水杉林景观区', 1, 30, '校园特色林地景观和休闲点位。', 82, 1, 0),
    (@campus_njust_nanjing, '二月兰景观区', 1, 30, '季节性校园景观和休闲点位。', 80, 1, 0),
    (@campus_njust_nanjing, '中心绿地', 1, 25, '孝陵卫校区中心公共绿地和休闲空间。', 80, 1, 0),
    (@campus_njust_nanjing, '紫霞湖景观区', 1, 30, '校园周边水系景观和休闲点位。', 80, 1, 0);

SET @campus_njust_jiangyin = (
    SELECT c.id FROM campus c JOIN university u ON c.university_id = u.id
    WHERE u.name = '南京理工大学' AND c.name = '江阴校区' AND c.is_deleted = 0 AND u.is_deleted = 0 LIMIT 1
);

SELECT IF(@campus_njust_jiangyin IS NULL, 1 / 0, @campus_njust_jiangyin) AS campus_check;

DELETE FROM poi
WHERE campus_id = @campus_njust_jiangyin
  AND name IN (
               '南校门', '北校门', '东校门', '西校门', '二道门', '格物楼', '致知楼',
               '诚意楼', '正心楼', '修身楼', '齐家楼', '治国楼', '平天下楼',
               '教学实验综合楼', '工程训练中心', '学术交流中心', '图书馆', '智慧教室',
               '学术报告厅', '体育馆', '游泳馆', '东体育场', '西体育场', '风雨操场',
               '篮球场', '排球场', '网球场', '羽毛球场', '乒乓球场', '北区学生公寓',
               '南区学生公寓', '研究生公寓', '留学生公寓', '专家公寓', '学生第一食堂',
               '学生第二食堂', '学生第三食堂', '清真食堂', '教工食堂', '风味餐厅',
               '校医院', '事务中心', '快递收发中心', '洗衣中心', '校园超市', '咖啡店',
               '理发店', '打印店', '健身房', '学子湖景观区', '水杉林景观区',
               '校风碑广场', '中心绿地', '下沉广场',
               '教学楼', '实验楼', '学生食堂', '体育场', '学生公寓区', '综合服务中心', '校园商业服务区'
    );

INSERT INTO poi
(campus_id, name, category, suggested_duration, intro, hot_score, data_status, is_deleted)
VALUES
    (@campus_njust_jiangyin, '南校门', 1, 15, '江阴校区南侧出入口。', 82, 1, 0),
    (@campus_njust_jiangyin, '北校门', 1, 15, '江阴校区北侧出入口。', 80, 1, 0),
    (@campus_njust_jiangyin, '东校门', 1, 15, '江阴校区东侧出入口。', 80, 1, 0),
    (@campus_njust_jiangyin, '西校门', 1, 15, '江阴校区西侧出入口。', 78, 1, 0),
    (@campus_njust_jiangyin, '二道门', 1, 15, '江阴校区校园出入口和通行节点。', 78, 1, 0),
    (@campus_njust_jiangyin, '格物楼', 2, 35, '教学科研和课程学习相关楼宇。', 84, 1, 0),
    (@campus_njust_jiangyin, '致知楼', 2, 35, '教学科研和课程学习相关楼宇。', 84, 1, 0),
    (@campus_njust_jiangyin, '诚意楼', 2, 35, '教学科研和课程学习相关楼宇。', 84, 1, 0),
    (@campus_njust_jiangyin, '正心楼', 2, 35, '教学科研和课程学习相关楼宇。', 84, 1, 0),
    (@campus_njust_jiangyin, '修身楼', 2, 35, '教学科研和课程学习相关楼宇。', 84, 1, 0),
    (@campus_njust_jiangyin, '齐家楼', 2, 35, '教学科研和课程学习相关楼宇。', 83, 1, 0),
    (@campus_njust_jiangyin, '治国楼', 2, 35, '教学科研和课程学习相关楼宇。', 83, 1, 0),
    (@campus_njust_jiangyin, '平天下楼', 2, 35, '教学科研和课程学习相关楼宇。', 83, 1, 0),
    (@campus_njust_jiangyin, '教学实验综合楼', 2, 45, '课程教学、实验教学和自习活动综合楼宇。', 86, 1, 0),
    (@campus_njust_jiangyin, '工程训练中心', 2, 45, '工程实践、实验训练和动手能力培养空间。', 86, 1, 0),
    (@campus_njust_jiangyin, '学术交流中心', 2, 35, '学术会议、交流和报告活动相关空间。', 84, 1, 0),
    (@campus_njust_jiangyin, '图书馆', 2, 60, '江阴校区学习、自习和文献服务核心点位。', 88, 1, 0),
    (@campus_njust_jiangyin, '智慧教室', 2, 35, '智慧教学、研讨学习和课程活动空间。', 84, 1, 0),
    (@campus_njust_jiangyin, '学术报告厅', 2, 35, '学术报告、讲座和校园活动空间。', 84, 1, 0),
    (@campus_njust_jiangyin, '体育馆', 4, 35, '室内体育教学、训练和赛事活动场馆。', 82, 1, 0),
    (@campus_njust_jiangyin, '游泳馆', 4, 35, '游泳教学、训练和体育活动场馆。', 80, 1, 0),
    (@campus_njust_jiangyin, '东体育场', 4, 30, '东侧户外体育活动空间。', 80, 1, 0),
    (@campus_njust_jiangyin, '西体育场', 4, 30, '西侧户外体育活动空间。', 80, 1, 0),
    (@campus_njust_jiangyin, '风雨操场', 4, 30, '适合雨雪天气下开展体育活动的运动空间。', 78, 1, 0),
    (@campus_njust_jiangyin, '篮球场', 4, 25, '篮球运动和课余体育活动场地。', 78, 1, 0),
    (@campus_njust_jiangyin, '排球场', 4, 25, '排球运动和体育课活动场地。', 76, 1, 0),
    (@campus_njust_jiangyin, '网球场', 4, 25, '网球运动和日常锻炼场地。', 76, 1, 0),
    (@campus_njust_jiangyin, '羽毛球场', 4, 25, '羽毛球运动和日常锻炼场地。', 76, 1, 0),
    (@campus_njust_jiangyin, '乒乓球场', 4, 25, '乒乓球运动和日常锻炼场地。', 76, 1, 0),
    (@campus_njust_jiangyin, '北区学生公寓', 3, 20, '江阴校区北区学生住宿生活区域。', 80, 1, 0),
    (@campus_njust_jiangyin, '南区学生公寓', 3, 20, '江阴校区南区学生住宿生活区域。', 80, 1, 0),
    (@campus_njust_jiangyin, '研究生公寓', 3, 20, '研究生住宿生活区域。', 78, 1, 0),
    (@campus_njust_jiangyin, '留学生公寓', 3, 20, '留学生住宿生活区域。', 78, 1, 0),
    (@campus_njust_jiangyin, '专家公寓', 3, 20, '专家住宿生活相关区域。', 76, 1, 0),
    (@campus_njust_jiangyin, '学生第一食堂', 3, 35, '江阴校区日常就餐点位。', 82, 1, 0),
    (@campus_njust_jiangyin, '学生第二食堂', 3, 35, '江阴校区日常就餐点位。', 82, 1, 0),
    (@campus_njust_jiangyin, '学生第三食堂', 3, 35, '江阴校区日常就餐点位。', 81, 1, 0),
    (@campus_njust_jiangyin, '清真食堂', 3, 30, '满足清真餐饮需求的生活餐饮点位。', 78, 1, 0),
    (@campus_njust_jiangyin, '教工食堂', 3, 35, '教职工日常就餐点位。', 76, 1, 0),
    (@campus_njust_jiangyin, '风味餐厅', 3, 35, '风味餐饮和多样化就餐点位。', 80, 1, 0),
    (@campus_njust_jiangyin, '校医院', 3, 20, '基础医疗与健康服务点位。', 76, 1, 0),
    (@campus_njust_jiangyin, '事务中心', 3, 25, '校园事务办理和师生服务点位。', 78, 1, 0),
    (@campus_njust_jiangyin, '快递收发中心', 3, 20, '校园快递和物流服务点位。', 80, 1, 0),
    (@campus_njust_jiangyin, '洗衣中心', 3, 20, '学生日常洗衣服务点位。', 78, 1, 0),
    (@campus_njust_jiangyin, '校园超市', 3, 20, '日常购物和生活补给点位。', 80, 1, 0),
    (@campus_njust_jiangyin, '咖啡店', 3, 20, '咖啡饮品和轻食休闲点位。', 76, 1, 0),
    (@campus_njust_jiangyin, '理发店', 3, 20, '日常理发和生活服务点位。', 76, 1, 0),
    (@campus_njust_jiangyin, '打印店', 3, 20, '打印复印和学习资料服务点位。', 76, 1, 0),
    (@campus_njust_jiangyin, '健身房', 4, 30, '室内健身和力量训练空间。', 78, 1, 0),
    (@campus_njust_jiangyin, '学子湖景观区', 1, 30, '江阴校区水系景观和休闲点位。', 80, 1, 0),
    (@campus_njust_jiangyin, '水杉林景观区', 1, 30, '校园特色林地景观和休闲点位。', 80, 1, 0),
    (@campus_njust_jiangyin, '校风碑广场', 1, 25, '体现学校精神和校园文化的公共广场。', 80, 1, 0),
    (@campus_njust_jiangyin, '中心绿地', 1, 25, '江阴校区中心公共绿地和休闲空间。', 78, 1, 0),
    (@campus_njust_jiangyin, '下沉广场', 1, 25, '公共活动、通行和休闲空间。', 78, 1, 0);

-- Demo users. The raw password for every demo account is 123456.
-- Passwords are stored as BCrypt hashes to match AuthServiceImpl login validation.
INSERT INTO users
(id, username, phone, password, nickname, avatar_url, role, identity_type, high_school,
 target_uni_id, current_uni_id, profile_completed, status, is_deleted)
VALUES
    (1, 'xiaochen', '13800000001', '$2y$10$xcLsm6woj/DAg9Hf/Bbixe8dvlGCnHnu1x16x3XMIb94Dt.gAEq.W', '小陈', NULL, 0, 2, '北京市第四中学', NULL, 1, 1, 1, 0),
    (2, 'user01', '13800000002', '$2y$10$xcLsm6woj/DAg9Hf/Bbixe8dvlGCnHnu1x16x3XMIb94Dt.gAEq.W', '测试01', NULL, 0, 1, '人大附中', 1, NULL, 1, 1, 0),
    (3, 'user02', '13800000003', '$2y$10$xcLsm6woj/DAg9Hf/Bbixe8dvlGCnHnu1x16x3XMIb94Dt.gAEq.W', '测试02', NULL, 0, 1, '衡水中学', 1, NULL, 1, 1, 0),
    (4, 'user03', '13800000004', '$2y$10$xcLsm6woj/DAg9Hf/Bbixe8dvlGCnHnu1x16x3XMIb94Dt.gAEq.W', '测试03', NULL, 0, 2, '成都七中', NULL, 1, 1, 1, 0),
    (5, 'user04', '13800000005', '$2y$10$xcLsm6woj/DAg9Hf/Bbixe8dvlGCnHnu1x16x3XMIb94Dt.gAEq.W', '测试04', NULL, 0, 2, '华师一附中', NULL, 2, 1, 1, 0),
    (6, 'admin01', '13800000006', '$2y$10$xcLsm6woj/DAg9Hf/Bbixe8dvlGCnHnu1x16x3XMIb94Dt.gAEq.W', '管理员', NULL, 9, 2, NULL, NULL, 1, 1, 1, 0);

-- Review data intentionally starts empty. Reviews should come from real user submissions.

COMMIT;
