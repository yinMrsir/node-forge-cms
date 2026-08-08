/*
 Navicat MySQL Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80029
 Source Host           : localhost:3306
 Source Schema         : node_forge_cms

 Target Server Type    : MySQL
 Target Server Version : 80029
 File Encoding         : 65001

 Date: 08/08/2026 21:10:11
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for ai_config
-- ----------------------------
DROP TABLE IF EXISTS `ai_config`;
CREATE TABLE `ai_config` (
  `ai_config_id` int NOT NULL AUTO_INCREMENT,
  `config_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `provider` enum('zhipu','doubao','deepseek') CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `config_value` json NOT NULL DEFAULT (_utf8mb4'{}'),
  `status` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '1',
  `is_default` enum('Y','N') CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT 'N',
  `sort_order` int NOT NULL DEFAULT '0',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '',
  `create_time` datetime DEFAULT NULL,
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '',
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`ai_config_id`),
  UNIQUE KEY `ai_config_config_key_unique` (`config_key`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of ai_config
-- ----------------------------
BEGIN;
INSERT INTO `ai_config` VALUES (1, '豆包', 'doubao', 'doubao', '{\"model\": \"doubao-1-5-pro-32k-250115\", \"apiKey\": \"05b97049-8082-415c-8b41-f068c43daf2f\", \"endpoint\": \"https://ark.cn-beijing.volces.com/api/v3/chat/completions\", \"maxTokens\": 2000, \"temperature\": 0.7}', '1', 'Y', 0, '', '', '2026-02-06 05:54:05', '', '2026-02-06 07:03:58');
INSERT INTO `ai_config` VALUES (2, '智谱', 'zhipu', 'zhipu', '{\"model\": \"glm-4.7\", \"apiKey\": \"a3fdc3633b564b10afe606cff8e34d01.ztTLb0kYmfFhecpV\", \"endpoint\": \"https://open.bigmodel.cn/api/paas/v4/chat/completions\", \"maxTokens\": 2000, \"temperature\": 0.7}', '1', 'N', 0, '', '', '2026-02-06 06:47:23', '', '2026-02-06 07:04:03');
COMMIT;

-- ----------------------------
-- Table structure for banner
-- ----------------------------
DROP TABLE IF EXISTS `banner`;
CREATE TABLE `banner` (
  `banner_id` int NOT NULL AUTO_INCREMENT,
  `title` json DEFAULT (_utf8mb4'{"zh":"","en":""}'),
  `description` json DEFAULT (_utf8mb4'{"zh":"","en":""}'),
  `image_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `link_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `button_text` json DEFAULT (_utf8mb4'{"zh":"","en":""}'),
  `order_num` int DEFAULT '0',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '1',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '',
  `create_time` datetime DEFAULT NULL,
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '',
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`banner_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of banner
-- ----------------------------
BEGIN;
INSERT INTO `banner` VALUES (1, '{\"bn\": \"উদ্ভাবনমূলক প্রযুক্তি · কোম্পানির উন্নতির জন্য শক্তিপ্রদান\", \"en\": \"Innovative technology · Empowering Enterprise Development\", \"hi\": \"नवाचार प्रौद्योगिकी · उद्यमों के विकास को सशक्त बनाना\", \"ja\": \"イノベーション技術・企業の発展をエンパワーする\", \"nb\": \"Innovativ teknologi · Krefter opp bedriftsutvikling\", \"pl\": \"Innowacyjne technologie · Wzmocnienie rozwoju przedsiębiorstw\", \"tr\": \"Yenilikçi teknoloji · Şirketlerin gelişimini güçlendirme\", \"tw\": \"創新科技 · 賦能企業發展\", \"zh\": \"创新科技 · 赋能企业发展\"}', '{\"bn\": \"প্রতিষ্ঠানের ডিজিটাল সমাধানে মনোনিবেশ করে, উচ্চ-কার্যক্ষমতা, সম্প্রসারণযোগ্য সিএমএস সিস্টেম এবং পূর্ণ স্ট্যাক প্রযুক্তি পরিষেবা প্রদান করে\", \"en\": \"Focusing on enterprise digital solutions, we provide high-performance, scalable CMS systems and full-stack technical services\", \"hi\": \"कंपनी के डिजिटल समाधानों पर ध्यान केंद्रित करें, उच्च प्रदर्शनकारी, विस्तारयोग्य सीएमएस सिस्टम और पूर्ण स्टैक प्रौद्योगिकी सेवाएं प्रदान करें\", \"ja\": \"企業のデジタル化ソリューションに特化し、高性能で拡張可能なCMSシステムとフルスタック技術サービスを提供します。 \", \"tr\": \"Şirketlerin dijital çözümlerine odaklanarak, yüksek performanslı ve genişletilebilir bir CMS sistemi ve tam yığın teknolojisi hizmetleri sunuyoruz.\", \"tw\": \"專注於企業數位化解決方案，提供高效能、可擴展的CMS系統和全棧技術服務\", \"zh\": \"专注于企业数字化解决方案，提供高性能、可扩展的CMS系统和全栈技术服务 \"}', 'http://127.0.0.1:3000/uploads/2026-02-04/R6uWFP5mN.jpeg', '/products', '{\"bn\": \"পণ্য দেখুন\", \"en\": \"View the product\", \"hi\": \"उत्पाद देखें\", \"ja\": \"商品を見る\", \"tr\": \"Ürünü görüntüle\", \"tw\": \"查看產品\", \"zh\": \"查看产品\"}', 1, '1', '0', '', 'admin', NULL, 'admin', '2026-02-09 03:25:46');
INSERT INTO `banner` VALUES (2, '{\"en\": \"Innovative technology · Empowering enterprise development\", \"ja\": \"イノベーション技術・企業の発展をエンパワーする\", \"nb\": \"Innovativ teknologi · Stimulerer bedriftsutvikling\", \"zh\": \"创新科技 · 赋能企业发展\"}', '{\"en\": \"Focus on enterprise digital solutions, providing high-performance and scalable CMS systems and full-stack technical services.\", \"ja\": \"企業のデジタル化ソリューションに特化し、高性能で拡張性のあるCMSシステムとフルスタック技術サービスを提供します。 \", \"zh\": \"专注于企业数字化解决方案，提供高性能、可扩展的CMS系统和全栈技术服务 \"}', 'http://127.0.0.1:3000/uploads/2026-02-04/yQG8iu2iv.jpeg', '/products', '{\"en\": \"View products\", \"ja\": \"製品を確認する\", \"zh\": \"查看产品\"}', 2, '1', '0', '', 'admin', NULL, 'admin', '2026-02-09 03:33:31');
COMMIT;

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `category_name` json DEFAULT (_utf8mb4'{"zh":"","en":""}'),
  `category_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `parent_category_id` int DEFAULT '0',
  `mpath` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `order_num` int DEFAULT '0',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '',
  `create_time` datetime DEFAULT NULL,
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '',
  `update_time` datetime DEFAULT NULL,
  `detail_template_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `url_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `template_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `description` json DEFAULT (_utf8mb4'{"zh":"","en":""}'),
  `redirect_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `is_recommend` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0',
  `keywords` json DEFAULT (_utf8mb4'{"zh":"","en":""}'),
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `category_url_key_unique` (`url_key`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of category
-- ----------------------------
BEGIN;
INSERT INTO `category` VALUES (1, '{\"en\": \"dynamic\", \"zh\": \"企业动态\"}', '1', 0, '1.', 1, '1', '0', '', 'admin', NULL, 'admin', '2026-05-06 11:30:44', NULL, 'dynamic', 'news', '{\"en\": \"\", \"zh\": \"\"}', NULL, '0', '{\"en\": \"\", \"zh\": \"\"}');
INSERT INTO `category` VALUES (2, '{\"en\": \"product\", \"zh\": \"产品新闻\"}', '1', 6, '6.2.', 2, '1', '0', '', 'admin', NULL, 'admin', '2026-01-28 08:40:11', NULL, 'product', 'news', '{\"en\": \"\", \"zh\": \"\"}', NULL, '0', '{\"en\": \"\", \"zh\": \"\"}');
INSERT INTO `category` VALUES (3, '{\"en\": \"controller\", \"ja\": \"コントローラー\", \"tw\": \"控制器\", \"zh\": \"控制器\"}', '2', 5, '5.3.', 2, '1', '0', '', 'admin', NULL, 'admin', '2026-02-06 15:47:11', NULL, 'controller', 'products', '{\"en\": \"\", \"zh\": \"\"}', NULL, '0', '{\"en\": \"\", \"zh\": \"\"}');
INSERT INTO `category` VALUES (4, '{\"en\": \"terminal\", \"tw\": \"顯控類\", \"zh\": \"显控类\"}', '2', 5, '5.4.', 2, '1', '0', '', 'admin', NULL, 'admin', '2026-02-06 15:46:46', NULL, 'terminal', 'products', '{\"en\": \"\", \"zh\": \"\"}', NULL, '1', '{\"en\": \"\", \"zh\": \"\"}');
INSERT INTO `category` VALUES (5, '{\"ar\": \"مركز المنتجات\", \"bn\": \"প্রোডাক্ট সেন্টার\", \"da\": \"Produktcenter\", \"de\": \"Produktzentrum\", \"en\": \"Product Center\", \"es\": \"Centro de productos\", \"fr\": \"Centre de produits\", \"hi\": \"उत्पाद केंद्र\", \"id\": \"Pusat Produk\", \"it\": \"Centro dei prodotti\", \"ja\": \"製品センター\", \"ko\": \"제품 센터\", \"nb\": \"Sehlopha sa Lihlahisoa\", \"nl\": \"Productencentrum\", \"pl\": \"Centrum produktów\", \"pt\": \"Centro de Produtos\", \"ru\": \"Центр продукции\", \"th\": \"ศูนย์ผลิตภัณฑ์\", \"tr\": \"Ürün Merkezi\", \"tw\": \"產品中心\", \"zh\": \"产品中心\"}', '1', 0, '5.', 1, '1', '0', '', 'admin', '2026-01-28 11:39:55', 'admin', '2026-02-06 15:41:54', '', 'products', 'products', '{\"ar\": \"نحن نقدم حلول منتجات مستوى الشركات الغنية لتلبية الاحتياجات الرقمية في سيناريوهات مختلفة.\", \"bn\": \"আমরা বিস্তৃত কোম্পানির স্তরের পণ্য সমাধান সরবরাহ করি, যা বিভিন্ন পরিস্থিতির ডিজিটাল চাহিদা পূরণ করে।\", \"da\": \"Vi tilbyder en bred vifte af løsninger på virksomhedsniveau, der imødekommer de digitale behov i forskellige scenarier.\", \"de\": \"Wir bieten reichhaltige Unternehmensproduktlösungen an, um die digitalen Anforderungen in verschiedenen Szenarien zu erfüllen.\", \"en\": \"We offer a wide range of enterprise-level product solutions to meet the digital needs of different scenarios.\", \"es\": \"Ofrecemos una amplia variedad de soluciones de productos empresariales para satisfacer las necesidades digitales de diferentes escenarios.\", \"fr\": \"Nous offrons des solutions de produits d\'entreprise riches pour répondre aux besoins numériques de différents scénarios.\", \"hi\": \"हम विभिन्न परिदृश्यों की डिजिटल आवश्यकताओं को पूरा करने के लिए समृद्ध कारोबारी स्तर के उत्पाद समाधान प्रदान करते हैं।\", \"id\": \"Kami menyediakan beragam solusi produk tingkat perusahaan untuk memenuhi kebutuhan digital berbagai skenario.\", \"it\": \"We offer a wide range of enterprise-level product solutions to meet the digital needs of different scenarios.\", \"ja\": \"当社では豊富なエンタープライズレベルの製品ソリューションを提供し、様々なシーンのデジタルニーズを満たします。 \", \"ko\": \"우리는 풍부한 엔터프라이즈급 제품 솔루션을 제공하여 다양한 시나리오의 디지털 니즈를 충족합니다.\", \"nb\": \"Re rupa ubudzi lwakho lwezinto eziphantsi emifanekiso yezikhumalo zezinkampani, ukuhambisa imikembe yomdibaniso yezemibuzo yezemikhakha ehlukene.\", \"nl\": \"Wij bieden uitgebreide zakelijke productoplossingen aan om aan de digitale behoeften van verschillende scenario\'s te voldoen.\", \"pl\": \"Oferujemy bogate rozwiązania produktów dla przedsiębiorstw, które spełniają cyfrowe potrzeby w różnych scenariuszach.\", \"pt\": \"Oferecemos uma ampla gama de soluções de produtos corporativos para atender às necessidades digitais de diferentes cenários.\", \"ru\": \"Мы предлагаем обширный спектр корпоративных продуктовых решений, которые удовлетворяют цифровые потребности различных сценариев.\", \"th\": \"เรามอบแนวทางการแก้ปัญหาผลิตภัณฑ์ระดับองค์กรที่หลากหลายเพื่อตอบสนองความต้องการดิจิตอลในสถานการณ์ต่างๆ\", \"tr\": \"Farklı senaryolardaki dijital ihtiyacları karşılayan zengin kurumsal ürün çözümleri sunuyoruz.\", \"tw\": \"我們提供豐富的企業級產品解決方案，滿足不同場景的數位化需求\", \"zh\": \"我们提供丰富的企业级产品解决方案，满足不同场景的数字化需求\"}', NULL, '0', '{\"ar\": \"المنتجات الذكية، الذكاء الاصطناعي (AI)، المتحكم\", \"bn\": \"স্মার্ট পণ্য, এআই, কন্ট্রোলার\", \"da\": \"Smarte produkter, AI, styringselement\", \"de\": \"Intelligente Produkte, KI, Controller\", \"en\": \"Smart products, AI, Controller\", \"es\": \"Productos inteligentes, IA, controlador\", \"fr\": \"Produits intelligents, IA, contrôleur\", \"hi\": \"स्मार्ट उत्पाद, AI, नियंत्रक\", \"id\": \"Produk cerdas, AI, Pengontrol\", \"it\": \"Prodotti intelligenti, AI, controller\", \"ja\": \"スマート製品、AI、コントローラー\", \"ko\": \"스마트 제품, AI, 컨트롤러\", \"nb\": \"Zakhidimi zinto, AI, Umqhubeli\", \"nl\": \"Slimme producten, AI, controller\", \"pl\": \"Produkty inteligentne, AI, sterownik\", \"pt\": \"Produtos inteligentes, IA, controlador\", \"ru\": \"Интеллектуальные продукты, ИИ, контроллер\", \"th\": \"ผลิตภัณฑ์อัจฉริยะ, AI, เครื่องควบคุม\", \"tr\": \"Akıllı ürünler, Yapay Zeka (AI), Kontrolcü\", \"tw\": \"智慧產品, 人工智慧, 控制器\", \"zh\": \"智能产品, AI, 控制器\"}');
INSERT INTO `category` VALUES (6, '{\"en\": \"News\", \"ja\": \"ニュース情報\", \"tw\": \"新聞資訊\", \"zh\": \"新闻资讯\"}', '1', 0, '6.', 3, '1', '0', '', 'admin', NULL, 'admin', '2026-02-06 15:47:59', NULL, 'news', 'news', '{}', NULL, '0', '{\"en\": \"\", \"zh\": \"\"}');
INSERT INTO `category` VALUES (7, '{\"en\": \"AI news\", \"ja\": \"AIニュース\", \"tw\": \"人工智慧資訊\", \"zh\": \"AI资讯\"}', '1', 6, '6.7.', 1, '1', '0', '', 'admin', NULL, 'admin', '2026-02-06 15:50:31', NULL, 'ai-news', 'news', '{}', NULL, '1', '{\"en\": \"\", \"zh\": \"\"}');
INSERT INTO `category` VALUES (8, '{\"en\": \"About Us\", \"ja\": \"私たちについて\", \"tw\": \"關於我們\", \"zh\": \"关于我们\"}', '1', 0, '8.', 4, '1', '0', '', 'admin', NULL, 'admin', '2026-02-06 15:48:09', NULL, 'about', 'content', '{}', '/about/profile', '0', '{\"en\": \"\", \"zh\": \"\"}');
INSERT INTO `category` VALUES (9, '{\"en\": \"Company Profile\", \"zh\": \"企业简介\"}', '1', 8, '8.9.', 1, '1', '0', '', 'admin', NULL, 'admin', '2026-02-04 03:26:50', NULL, 'profile', 'content', '{}', NULL, '0', '{\"en\": \"\", \"zh\": \"\"}');
INSERT INTO `category` VALUES (10, '{\"en\": \"Corporate culture\", \"zh\": \"企业文化\"}', '1', 8, '8.10.', 2, '1', '0', '', 'admin', NULL, 'admin', '2026-02-04 03:27:03', NULL, 'culture', 'content', '{}', NULL, '0', '{\"en\": \"\", \"zh\": \"\"}');
INSERT INTO `category` VALUES (11, '{\"en\": \"Corporate honors\", \"zh\": \"企业荣誉\"}', '1', 8, '8.11.', 3, '1', '0', '', 'admin', NULL, 'admin', '2026-02-04 03:27:12', NULL, 'honor', 'content', '{}', NULL, '0', '{\"en\": \"\", \"zh\": \"\"}');
INSERT INTO `category` VALUES (12, '{\"en\": \"Contact us\", \"zh\": \"联系我们\"}', '1', 8, '8.12.', 4, '1', '0', '', 'admin', NULL, 'admin', '2026-02-04 03:27:24', NULL, 'contact-us', 'content', '{}', NULL, '0', '{\"en\": \"\", \"zh\": \"\"}');
INSERT INTO `category` VALUES (13, '{\"en\": \"Product services\", \"ja\": \"製品サービス\", \"zh\": \"产品服务\"}', '1', 0, '13.', 2, '1', '0', '', 'admin', NULL, 'admin', '2026-02-06 07:04:33', NULL, 'service', 'content', '{}', '/service/digital-solutions', '0', '{\"en\": \"\", \"zh\": \"\"}');
INSERT INTO `category` VALUES (14, '{\"en\": \"Digital solutions\", \"ja\": \"デジタル化ソリューション\", \"tw\": \"數位化解決方案\", \"zh\": \"数字化解决方案\"}', '1', 13, '13.14.', 1, '1', '0', '', 'admin', NULL, 'admin', '2026-02-06 15:52:53', NULL, 'digital-solutions', 'content', '{}', NULL, '1', '{\"en\": \"\", \"zh\": \"\"}');
INSERT INTO `category` VALUES (15, '{\"en\": \"Customized development\", \"ja\": \"カスタマイズ開発\", \"tw\": \"客製化開發\", \"zh\": \"定制化开发\"}', '1', 13, '13.15.', 2, '1', '0', '', 'admin', NULL, 'admin', '2026-02-06 15:53:20', NULL, 'customized-development', 'content', '{}', NULL, '1', '{\"en\": \"\", \"zh\": \"\"}');
INSERT INTO `category` VALUES (16, '{\"en\": \"Technical support\", \"ja\": \"技術サポート\", \"tw\": \"技術支援\", \"zh\": \"技术支持\"}', '1', 13, '13.16.', 3, '1', '0', '', 'admin', NULL, 'admin', '2026-02-06 15:53:07', NULL, 'technical-support', 'content', '{}', NULL, '1', '{\"en\": \"\", \"zh\": \"\"}');
INSERT INTO `category` VALUES (17, '{\"en\": \"Cooperative franchise\", \"zh\": \"合作加盟\"}', '1', 13, '13.17.', 4, '1', '0', '', 'admin', NULL, 'admin', NULL, NULL, 'cooperative-franchise', 'content', '{}', NULL, '0', '{\"en\": \"\", \"zh\": \"\"}');
INSERT INTO `category` VALUES (18, '{\"en\": \"AI products\", \"ja\": \"AI製品（エーアイせいひん） \", \"nb\": \"AI-produkter\", \"pl\": \"Produkty AI\", \"tw\": \"人工智慧產品\", \"zh\": \"AI产品\"}', '1', 5, '5.18.', 1, '1', '0', '', 'admin', NULL, 'admin', '2026-02-09 03:33:15', NULL, 'ai', 'products', '{}', NULL, '0', '{}');
COMMIT;

-- ----------------------------
-- Table structure for contact
-- ----------------------------
DROP TABLE IF EXISTS `contact`;
CREATE TABLE `contact` (
  `contact_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `subject` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0',
  `handle_remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '',
  `create_time` datetime DEFAULT NULL,
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '',
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`contact_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of contact
-- ----------------------------
BEGIN;
INSERT INTO `contact` VALUES (1, '老鹰', '15674874636', '542968439@qq.com', 'product', '咨询产品如何部署', '0', '已联系', '0', '', '', NULL, '', NULL);
COMMIT;

-- ----------------------------
-- Table structure for content
-- ----------------------------
DROP TABLE IF EXISTS `content`;
CREATE TABLE `content` (
  `content_id` int NOT NULL AUTO_INCREMENT,
  `content` json DEFAULT (_utf8mb4'{"zh":"","en":""}'),
  `category_id` int DEFAULT NULL,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '',
  `create_time` datetime DEFAULT NULL,
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '',
  `update_time` datetime DEFAULT NULL,
  `description` json DEFAULT (_utf8mb4'{"zh":"","en":""}'),
  `keywords` json DEFAULT (_utf8mb4'{"zh":"","en":""}'),
  PRIMARY KEY (`content_id`),
  UNIQUE KEY `content_category_id_unique` (`category_id`),
  CONSTRAINT `content_category_id_category_category_id_fk` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of content
-- ----------------------------
BEGIN;
INSERT INTO `content` VALUES (1, '{\"en\": \"<p>NodeForge was founded in 2020 and is a high-tech enterprise specializing in enterprise digital solutions. Its core team members come from leading Internet companies such as Alibaba, Tencent, and ByteDance, and they have over 10 years of experience in enterprise-level product research and development and implementation. </p><p> </p><p> </p><p> </p><p>The company takes \\\"technological innovation driving enterprise development\\\" as its mission, focuses on the digital transformation needs of enterprises, and builds a product matrix centered on NodeForge CMS, providing full-stack digital solutions for industries such as manufacturing, retail, education, and government affairs. </p><p> </p><p> </p><p>As of 2026, the company has served over 500 enterprise customers, covering more than 30 provinces and cities across the country. With stable product performance, high-quality technical services and personalized customization capabilities, it has won unanimous recognition from customers.</p>\", \"ja\": \"<p>NodeForgeは2020年に設立され、企業のデジタル化ソリューションに特化したハイテク企業です。コアチームはアリババ、テンセント、バイトダンスなどのトップインターネット企業出身で、10年以上の企業向け製品の開発と実施の経験を持っています。</p><p>同社は「技術革新で企業の発展を促す」を使命とし、企業のデジタル化転換のニーズに焦点を当て、NodeForge CMSを核とする製品マトリックスを構築し、製造、小売、教育、行政などの業界にフルスタック型のデジタル化ソリューションを提供しています。</p><p>2026年までに、同社は500社以上の企業顧客にサービスを提供し、全国30以上の省市をカバーしています。安定した製品性能、優れた技術サービス、個別化のカスタマイズ能力で、顧客から一致した認めを得ています。</p>\", \"zh\": \"<p>NodeForge成立于2020年，是一家专注于企业数字化解决方案的高新技术企业，核心团队来自阿里、腾讯、字节等头部互联网企业，拥有10+年企业级产品研发和实施经验。</p><p>公司以「技术创新驱动企业发展」为使命，聚焦企业数字化转型需求，打造以NodeForge CMS为核心的产品矩阵，为制造、零售、教育、政务等行业提供全栈式数字化解决方案。</p><p>截至2026年，公司已服务超过500家企业客户，覆盖全国30+省市，凭借稳定的产品性能、优质的技术服务和个性化的定制能力，赢得了客户的一致认可。</p>\"}', 9, '0', NULL, 'admin', NULL, 'admin', '2026-02-06 07:08:14', '{\"en\": \"NodeForge was founded in 2020 and is a high-tech enterprise specializing in enterprise digital solutions. Its core team members come from leading Internet companies such as Alibaba, Tencent, and ByteDance, and they have over 10 years of experience in enterprise-level product research and development and implementation. \", \"ja\": \"NodeForgeは2020年に設立され、企業のデジタル化ソリューションに特化したハイテク企業です。コアチームはアリババ、テンセント、バイトドメインなどのトップインターネット企業出身で、10年以上の企業向け製品の開発と実施の経験を持っています。 \", \"zh\": \"NodeForge成立于2020年，是一家专注于企业数字化解决方案的高新技术企业，核心团队来自阿里、腾讯、字节等头部互联网企业，拥有10+年企业级产品研发和实施经验。\"}', '{\"en\": \"High-tech enterprise\", \"ja\": \"高度技術企業\", \"zh\": \"高新技术企业\"}');
INSERT INTO `content` VALUES (3, '{\"en\": \"\", \"zh\": \"<p>企业文化</p>\"}', 10, '0', NULL, 'admin', '2026-02-03 14:27:35', 'admin', '2026-02-03 14:29:45', '{\"en\": \"\", \"zh\": \"\"}', '{\"en\": \"\", \"zh\": \"\"}');
INSERT INTO `content` VALUES (4, '{\"en\": \"<p style=\\\"text-align: start;\\\">Digital solutions<span style=\\\"color: rgb(16, 18, 20); background-color: rgba(255, 228, 181, 0.7);\\\"><br></span></p>\", \"zh\": \"<p>数字化解决方案</p>\"}', 14, '0', NULL, 'admin', '2026-02-04 13:19:34', 'admin', '2026-02-04 13:19:34', '{\"en\": \"\", \"zh\": \"\"}', '{\"en\": \"\", \"zh\": \"\"}');
COMMIT;

-- ----------------------------
-- Table structure for dept
-- ----------------------------
DROP TABLE IF EXISTS `dept`;
CREATE TABLE `dept` (
  `dept_id` int NOT NULL AUTO_INCREMENT,
  `dept_name` varchar(50) DEFAULT '',
  `order_num` int DEFAULT '0',
  `leader` varchar(20) DEFAULT '',
  `phone` varchar(11) DEFAULT '',
  `email` varchar(50) DEFAULT '',
  `status` char(1) DEFAULT '0',
  `del_flag` char(1) DEFAULT '0',
  `parent_dept_id` int DEFAULT '0',
  `mpath` varchar(255) DEFAULT NULL,
  `remark` varchar(500) DEFAULT '',
  `create_by` varchar(64) DEFAULT '',
  `create_time` datetime DEFAULT NULL,
  `update_by` varchar(64) DEFAULT '',
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of dept
-- ----------------------------
BEGIN;
INSERT INTO `dept` VALUES (1, '淳渔', 1, '', '', '', '0', '0', 0, '', '', 'admin', NULL, 'admin', NULL);
COMMIT;

-- ----------------------------
-- Table structure for dict_data
-- ----------------------------
DROP TABLE IF EXISTS `dict_data`;
CREATE TABLE `dict_data` (
  `dict_data_id` int NOT NULL AUTO_INCREMENT,
  `dict_sort` int DEFAULT '0',
  `dict_label` varchar(100) DEFAULT NULL,
  `dict_value` varchar(100) DEFAULT NULL,
  `css_class` varchar(100) DEFAULT NULL,
  `list_class` varchar(100) DEFAULT NULL,
  `is_default` char(1) DEFAULT 'N',
  `status` char(1) DEFAULT '0',
  `dict_type_id` int DEFAULT NULL,
  `remark` varchar(500) DEFAULT '',
  `create_by` varchar(64) DEFAULT '',
  `create_time` datetime DEFAULT NULL,
  `update_by` varchar(64) DEFAULT '',
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`dict_data_id`),
  KEY `dict_data_dict_type_id_dict_type_dict_id_fk` (`dict_type_id`),
  CONSTRAINT `dict_data_dict_type_id_dict_type_dict_id_fk` FOREIGN KEY (`dict_type_id`) REFERENCES `dict_type` (`dict_id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of dict_data
-- ----------------------------
BEGIN;
INSERT INTO `dict_data` VALUES (1, 1, '正常', '0', NULL, 'primary', 'N', '0', 1, '正常状态', '', '2022-01-06 17:22:29', '', '2022-01-06 17:22:29');
INSERT INTO `dict_data` VALUES (2, 2, '停用', '1', NULL, 'danger', 'N', '0', 1, '停用状态', '', '2022-01-06 17:22:47', '', '2022-01-06 17:22:47');
INSERT INTO `dict_data` VALUES (3, 1, '是', 'Y', NULL, 'primary', 'N', '0', 2, '系统默认是', '', '2022-01-06 17:23:11', '', '2022-01-06 17:23:11');
INSERT INTO `dict_data` VALUES (4, 2, '否', 'N', NULL, 'danger', 'N', '0', 2, '系统默认否', '', '2022-01-06 17:23:28', '', '2022-01-06 17:23:28');
INSERT INTO `dict_data` VALUES (5, 1, '通知', '1', NULL, 'warning', 'N', '0', 3, '通知', '', '2022-01-06 17:23:53', '', '2022-01-06 17:23:53');
INSERT INTO `dict_data` VALUES (6, 2, '公告', '2', NULL, 'success', 'N', '0', 3, '公告', '', '2022-01-06 17:24:48', '', '2022-01-06 17:24:48');
INSERT INTO `dict_data` VALUES (7, 1, '正常', '0', NULL, 'primary', 'N', '0', 4, '正常状态', '', '2022-01-06 17:25:17', '', '2022-01-06 17:25:17');
INSERT INTO `dict_data` VALUES (8, 2, '关闭', '1', NULL, 'danger', 'N', '0', 4, '关闭状态', '', '2022-01-06 17:25:32', '', '2022-01-06 17:25:32');
INSERT INTO `dict_data` VALUES (9, 1, '显示', '0', NULL, 'primary', 'N', '0', 5, '显示菜单', '', '2022-01-06 17:26:13', '', '2022-01-06 17:26:13');
INSERT INTO `dict_data` VALUES (10, 2, '隐藏', '1', NULL, 'danger', 'N', '0', 5, '隐藏菜单', '', '2022-01-06 17:26:29', '', '2022-01-06 17:26:29');
INSERT INTO `dict_data` VALUES (11, 1, '男', '0', NULL, 'default', 'N', '0', 6, '性别男', '', '2022-01-06 17:26:54', '', '2022-01-06 17:26:54');
INSERT INTO `dict_data` VALUES (12, 2, '女', '1', NULL, 'default', 'N', '0', 6, '', '', '2022-01-06 17:27:09', '', '2022-01-06 17:27:09');
INSERT INTO `dict_data` VALUES (13, 3, '未知', '2', NULL, 'default', 'N', '0', 6, '', '', '2022-01-06 17:27:27', '', '2022-01-06 17:27:27');
INSERT INTO `dict_data` VALUES (14, 1, '其他', '1', '', 'default', 'N', '0', 7, '其他操作', '', '2022-01-06 17:28:03', '', '2022-01-06 17:28:03');
INSERT INTO `dict_data` VALUES (15, 2, '插入', '2', NULL, 'primary', 'N', '0', 7, '插入操作', '', '2022-01-06 17:28:17', '', '2022-01-06 17:28:17');
INSERT INTO `dict_data` VALUES (16, 3, '更新', '3', NULL, 'success', 'N', '0', 7, '更新操作', '', '2022-01-06 17:28:32', '', '2022-01-06 17:28:32');
INSERT INTO `dict_data` VALUES (17, 4, '删除', '4', NULL, 'danger', 'N', '0', 7, '删除操作', '', '2022-01-06 17:28:47', '', '2022-01-06 17:28:47');
INSERT INTO `dict_data` VALUES (18, 5, '授权', '5', NULL, 'info', 'N', '0', 7, '授权操作', '', '2022-01-06 17:29:03', '', '2022-01-06 17:29:03');
INSERT INTO `dict_data` VALUES (19, 6, '导出', '6', NULL, 'primary', 'N', '0', 7, '导出操作', '', '2022-01-06 17:29:18', '', '2022-01-06 17:29:18');
INSERT INTO `dict_data` VALUES (20, 7, '导入', '7', NULL, 'success', 'N', '0', 7, '导入操作', '', '2022-01-06 17:29:32', '', '2022-01-06 17:29:32');
INSERT INTO `dict_data` VALUES (21, 8, '强退', '8', NULL, 'info', 'N', '0', 7, '强退操作', '', '2022-01-06 17:29:48', '', '2022-01-06 17:29:48');
INSERT INTO `dict_data` VALUES (22, 9, '清除', '9', NULL, 'danger', 'N', '0', 7, '清除操作', '', '2022-01-06 17:30:06', '', '2022-01-06 17:30:06');
INSERT INTO `dict_data` VALUES (23, 1, '成功', '0', NULL, 'primary', 'N', '0', 8, '正常状态', '', '2022-01-06 17:30:29', '', '2022-01-06 17:30:29');
INSERT INTO `dict_data` VALUES (24, 2, '失败', '1', NULL, 'danger', 'N', '0', 8, '停用状态', '', '2022-01-06 17:30:44', '', '2022-01-06 17:30:57');
INSERT INTO `dict_data` VALUES (25, 1, '正常', '0', NULL, 'primary', 'N', '0', 9, '正常状态', '', '2022-01-06 17:31:20', '', '2022-01-06 17:31:20');
INSERT INTO `dict_data` VALUES (26, 2, '暂停', '1', NULL, 'danger', 'N', '0', 9, '停用状态', '', '2022-01-06 17:31:34', '', '2022-01-06 17:31:34');
INSERT INTO `dict_data` VALUES (27, 1, '默认', 'DEFAULT', NULL, 'default', 'N', '0', 10, '默认分组', '', '2022-01-06 17:31:55', '', '2022-01-06 17:31:55');
INSERT INTO `dict_data` VALUES (28, 2, '系统', 'SYSTEM', NULL, 'default', 'N', '0', 10, '系统分组', '', '2022-01-06 17:32:12', '', '2022-01-06 17:32:12');
INSERT INTO `dict_data` VALUES (29, 1, '网站', '1', NULL, 'default', 'N', '0', 11, '', '', '2025-02-14 02:41:05', '', '2025-02-14 02:41:05');
INSERT INTO `dict_data` VALUES (30, 2, '外链', '2', NULL, 'default', 'N', '0', 11, '', '', '2025-02-14 02:41:05', '', '2025-02-14 02:41:05');
INSERT INTO `dict_data` VALUES (31, 1, '男', '1', NULL, 'primary', 'N', '0', 12, '', '', '2025-04-03 03:25:01', 'admin', '2025-04-03 03:45:18');
INSERT INTO `dict_data` VALUES (32, 2, '女', '2', NULL, 'danger', 'N', '0', 12, '', '', '2025-04-03 03:25:01', '', '2025-04-03 03:25:01');
INSERT INTO `dict_data` VALUES (33, 3, '未知', '3', NULL, 'info', 'N', '0', 12, '', '', '2025-04-03 03:25:01', '', '2025-04-03 03:25:01');
INSERT INTO `dict_data` VALUES (34, 1, '正片', '1', NULL, 'default', 'N', '0', 13, '', '', '2025-04-07 09:12:56', '', '2025-04-07 09:12:56');
INSERT INTO `dict_data` VALUES (35, 2, '预告片', '2', NULL, 'default', 'N', '0', 13, '', '', '2025-04-07 09:12:56', 'admin', '2025-04-07 09:15:00');
INSERT INTO `dict_data` VALUES (36, 3, '花絮', '3', NULL, 'default', 'N', '0', 13, '', '', '2025-04-07 09:12:56', 'admin', '2025-04-07 09:14:56');
INSERT INTO `dict_data` VALUES (37, 4, '片段', '4', NULL, 'default', 'N', '0', 13, '', '', '2025-04-07 09:12:56', '', '2025-04-07 09:12:56');
INSERT INTO `dict_data` VALUES (38, 5, '其他', '5', NULL, 'default', 'N', '0', 13, '', '', '2025-04-07 09:12:56', '', '2025-04-07 09:12:56');
INSERT INTO `dict_data` VALUES (39, 1, '海报', '1', NULL, 'default', 'N', '0', 14, '', '', '2025-04-07 09:20:01', 'admin', '2025-04-07 11:07:33');
INSERT INTO `dict_data` VALUES (40, 2, '剧照', '2', NULL, 'default', 'N', '0', 14, '', '', '2025-04-07 09:20:01', '', '2025-04-07 09:20:01');
INSERT INTO `dict_data` VALUES (41, 3, '壁纸', '3', NULL, 'default', 'N', '0', 14, '', '', '2025-04-07 09:20:01', '', '2025-04-07 09:20:01');
INSERT INTO `dict_data` VALUES (42, 1, '未审核', '1', NULL, 'warning', 'N', '0', 15, '', '', '2025-04-07 09:20:01', 'admin', '2025-04-07 11:08:38');
INSERT INTO `dict_data` VALUES (43, 2, '已通过', '2', NULL, 'success', 'N', '0', 15, '', '', '2025-04-07 09:20:01', 'admin', '2025-04-07 11:08:33');
INSERT INTO `dict_data` VALUES (44, 3, '未通过', '3', NULL, 'danger', 'N', '0', 15, '', '', '2025-04-07 09:20:01', '', '2025-04-07 09:20:01');
INSERT INTO `dict_data` VALUES (45, 1, '魔都资源', '1', NULL, 'default', 'N', '0', 16, 'https://moduzy5.com/', '', '2025-09-26 06:24:52', 'admin', '2025-09-26 12:28:33');
COMMIT;

-- ----------------------------
-- Table structure for dict_type
-- ----------------------------
DROP TABLE IF EXISTS `dict_type`;
CREATE TABLE `dict_type` (
  `dict_id` int NOT NULL AUTO_INCREMENT,
  `dict_name` varchar(100) DEFAULT '',
  `dict_type` varchar(100) NOT NULL DEFAULT '',
  `status` char(1) DEFAULT '0',
  `remark` varchar(500) DEFAULT '',
  `create_by` varchar(64) DEFAULT '',
  `create_time` datetime DEFAULT NULL,
  `update_by` varchar(64) DEFAULT '',
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`dict_id`),
  UNIQUE KEY `dict_type_dict_type_unique` (`dict_type`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of dict_type
-- ----------------------------
BEGIN;
INSERT INTO `dict_type` VALUES (1, '系统开关', 'sys_normal_disable', '0', '系统开关列表', '', '2022-01-06 17:19:33', '', '2022-01-06 17:19:33');
INSERT INTO `dict_type` VALUES (2, '系统是否', 'sys_yes_no', '0', '系统是否列表', '', '2022-01-06 17:19:56', '', '2022-01-06 17:19:56');
INSERT INTO `dict_type` VALUES (3, '通知类型', 'sys_notice_type', '0', '通知类型列表', '', '2022-01-06 17:20:09', '', '2022-01-06 17:20:09');
INSERT INTO `dict_type` VALUES (4, '通知状态', 'sys_notice_status', '0', '通知状态列表', '', '2022-01-06 17:20:20', '', '2022-01-06 17:20:20');
INSERT INTO `dict_type` VALUES (5, '菜单状态', 'sys_show_hide', '0', '菜单状态列表', '', '2022-01-06 17:20:43', '', '2022-01-06 17:20:43');
INSERT INTO `dict_type` VALUES (6, '用户性别', 'sys_user_sex', '0', '用户性别列表', '', '2022-01-06 17:20:58', '', '2022-01-06 17:20:58');
INSERT INTO `dict_type` VALUES (7, '操作类型', 'sys_oper_type', '0', '操作类型列表', '', '2022-01-06 17:21:17', '', '2022-01-06 17:21:17');
INSERT INTO `dict_type` VALUES (8, '系统状态', 'sys_common_status', '0', '登录状态列表', '', '2022-01-06 17:21:34', '', '2022-01-06 17:21:34');
INSERT INTO `dict_type` VALUES (9, '任务状态', 'sys_job_status', '0', '任务状态列表', '', '2022-01-06 17:21:50', 'admin', '2022-12-13 15:12:17');
INSERT INTO `dict_type` VALUES (10, '任务分组', 'sys_job_group', '0', '任务分组列表', '', '2022-01-06 17:22:00', '', '2022-01-06 17:22:00');
INSERT INTO `dict_type` VALUES (11, '栏目类型', 'column_type', '0', '', '', '2025-02-14 02:41:05', '', '2025-02-14 02:41:05');
INSERT INTO `dict_type` VALUES (12, '性别类型', 'sex_type', '0', '', '', '2025-04-03 03:25:01', '', '2025-04-03 03:25:01');
INSERT INTO `dict_type` VALUES (13, '影视分类', 'videos_type', '0', '', '', '2025-04-07 09:12:56', '', '2025-04-07 09:12:56');
INSERT INTO `dict_type` VALUES (14, '图片类型', 'movie_img_type', '0', '', '', '2025-04-07 09:20:01', '', '2025-04-07 09:20:01');
INSERT INTO `dict_type` VALUES (15, '图片状态', 'movie_img_status', '0', '', '', '2025-04-07 09:20:01', '', '2025-04-07 09:20:01');
INSERT INTO `dict_type` VALUES (16, '视频资源来源', 'video_resources_source', '0', '', '', '2025-09-26 06:24:52', 'admin', '2025-09-26 12:55:20');
COMMIT;

-- ----------------------------
-- Table structure for i18n_locale
-- ----------------------------
DROP TABLE IF EXISTS `i18n_locale`;
CREATE TABLE `i18n_locale` (
  `locale_id` int NOT NULL AUTO_INCREMENT COMMENT '语言主键',
  `locale_code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '语言代码（如: zh, en, ja）',
  `locale_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '语言名称',
  `is_default` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT 'N' COMMENT '是否默认语言',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '语言图标',
  `sort_order` int DEFAULT '0' COMMENT '排序',
  `status` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '备注',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`locale_id`),
  UNIQUE KEY `i18n_locale_locale_code_unique` (`locale_code`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='多语言配置表';

-- ----------------------------
-- Records of i18n_locale
-- ----------------------------
BEGIN;
INSERT INTO `i18n_locale` VALUES (1, 'zh', '简体中文', 'Y', '🇨🇳', 1, '0', '', '', '2026-02-05 10:08:02', '', '2026-02-05 10:08:02');
INSERT INTO `i18n_locale` VALUES (2, 'en', 'English', 'N', '🇺🇸', 2, '0', '', '', '2026-02-05 10:08:02', '', '2026-02-05 10:08:02');
INSERT INTO `i18n_locale` VALUES (3, 'ja', '日本語', 'N', '🇯🇵', 3, '0', '', '', '2026-02-05 03:13:08', '', '2026-02-05 03:13:08');
INSERT INTO `i18n_locale` VALUES (4, 'es', 'Español', 'N', '🇪🇸', 3, '1', '', '', '2026-02-06 14:27:11', '', '2026-02-06 15:43:30');
INSERT INTO `i18n_locale` VALUES (5, 'fr', 'Français', 'N', '🇫🇷', 3, '1', '', '', '2026-02-06 14:28:14', '', '2026-02-06 15:43:28');
INSERT INTO `i18n_locale` VALUES (6, 'pt', 'Português', 'N', '🇵🇹', 3, '1', '', '', '2026-02-06 14:29:20', '', '2026-02-06 15:43:25');
INSERT INTO `i18n_locale` VALUES (7, 'it', 'Italiano', 'N', '🇮🇹', 3, '1', '', '', '2026-02-06 14:29:42', '', '2026-02-06 15:43:22');
INSERT INTO `i18n_locale` VALUES (8, 'th', 'ภาษาไทย', 'N', '🇹🇭', 3, '1', '', '', '2026-02-06 14:30:42', '', '2026-02-06 15:43:20');
INSERT INTO `i18n_locale` VALUES (9, 'pl', 'Polski', 'N', '🇵🇱', 3, '1', '', '', '2026-02-06 14:31:13', '', '2026-02-09 03:48:59');
INSERT INTO `i18n_locale` VALUES (10, 'ko', '한국어', 'N', '🇰🇷', 3, '1', '', '', '2026-02-06 14:31:41', '', '2026-02-06 15:43:15');
INSERT INTO `i18n_locale` VALUES (11, 'de', 'Deutsch', 'N', '🇩🇪', 3, '1', '', '', '2026-02-06 14:32:25', '', '2026-02-06 15:43:12');
INSERT INTO `i18n_locale` VALUES (12, 'ru', 'Русский', 'N', '🇷🇺', 3, '1', '', '', '2026-02-06 14:33:11', '', '2026-02-06 15:43:10');
INSERT INTO `i18n_locale` VALUES (13, 'da', 'Dansk', 'N', '🇩🇰', 3, '1', '', '', '2026-02-06 14:33:41', '', '2026-02-06 15:43:07');
INSERT INTO `i18n_locale` VALUES (14, 'ar', 'العربية', 'N', '', 3, '1', '', '', '2026-02-06 14:34:37', '', '2026-02-06 15:43:01');
INSERT INTO `i18n_locale` VALUES (15, 'nb', 'Norsk bokmål', 'N', '🇳🇴', 3, '1', '', '', '2026-02-06 14:35:21', '', '2026-02-09 03:48:54');
INSERT INTO `i18n_locale` VALUES (16, 'nl', 'Nederlands', 'N', '🇳🇱', 3, '1', '', '', '2026-02-06 14:35:50', '', '2026-02-06 15:42:56');
INSERT INTO `i18n_locale` VALUES (17, 'id', 'Bahasa Indonesia', 'N', '🇮🇩', 3, '1', '', '', '2026-02-06 14:36:26', '', '2026-02-06 15:42:53');
INSERT INTO `i18n_locale` VALUES (18, 'tw', '繁体中文', 'N', '', 2, '0', '', '', '2026-02-06 14:37:03', '', '2026-02-06 15:13:56');
INSERT INTO `i18n_locale` VALUES (19, 'tr', 'Türkçe', 'N', '🇹🇷', 3, '1', '', '', '2026-02-06 14:37:39', '', '2026-02-06 15:49:11');
INSERT INTO `i18n_locale` VALUES (20, 'hi', 'हिन्दी', 'N', '', 3, '1', '', '', '2026-02-06 14:38:01', '', '2026-02-06 15:49:14');
INSERT INTO `i18n_locale` VALUES (21, 'bn', 'বাংলা', 'N', '🇧🇩', 3, '1', '', '', '2026-02-06 14:38:21', '', '2026-02-06 15:49:19');
COMMIT;

-- ----------------------------
-- Table structure for i18n_translation
-- ----------------------------
DROP TABLE IF EXISTS `i18n_translation`;
CREATE TABLE `i18n_translation` (
  `translation_id` int NOT NULL AUTO_INCREMENT COMMENT '翻译主键',
  `locale_code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '语言代码',
  `translation_key` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '翻译键（如: site.name, nav.home）',
  `translation_value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT (_utf8mb4''),
  `group_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '分组（如: site, nav, home）',
  `sort_order` int DEFAULT '0' COMMENT '排序',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '备注',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`translation_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1386 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='多语言翻译内容表';

-- ----------------------------
-- Records of i18n_translation
-- ----------------------------
BEGIN;
INSERT INTO `i18n_translation` VALUES (602, 'zh', 'site.name', 'NodeForgeCMS', 'site', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (603, 'zh', 'nav.home', '首页', 'nav', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (604, 'zh', 'nav.news', '新闻资讯', 'nav', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (605, 'zh', 'nav.products', '产品中心', 'nav', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (606, 'zh', 'nav.language', '语言 / Language', 'nav', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (607, 'zh', 'home.banner.title', '创新科技 · 赋能企业发展', 'home', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (608, 'zh', 'home.banner.description', '专注于企业数字化解决方案，提供高性能、可扩展的CMS系统和全栈技术服务', 'home', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (609, 'zh', 'home.banner.learnMore', '了解更多', 'home', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (610, 'zh', 'home.banner.viewProducts', '查看产品', 'home', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (611, 'zh', 'home.products.title', '产品中心', 'home', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (612, 'zh', 'home.products.description', '我们提供丰富的企业级产品解决方案，满足不同场景的数字化需求', 'home', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (613, 'zh', 'home.products.viewDetails', '查看详情', 'home', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (614, 'zh', 'home.news.title', '新闻中心', 'home', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (615, 'zh', 'home.news.description', '了解企业最新动态、行业资讯和产品更新', 'home', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (616, 'zh', 'home.news.readFull', '阅读全文', 'home', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (617, 'zh', 'home.news.viewMore', '查看更多新闻', 'home', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (618, 'zh', 'home.about.title', '企业介绍', 'home', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (619, 'zh', 'home.about.subtitle', '专注于企业数字化解决方案，以技术创新驱动企业发展', 'home', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (620, 'zh', 'home.about.imageUrl', '企业介绍', 'home', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (621, 'zh', 'home.about.intro1', 'NodeForge成立于20xx年，是一家专注于企业数字化解决方案的科技公司，核心团队来自头部互联网企业和软件服务商，拥有丰富的企业级产品研发和实施经验。', 'home', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (622, 'zh', 'home.about.intro2', '我们以Node.js、Vue/Nuxt为核心技术栈，打造高性能、易扩展的企业级CMS系统，帮助企业快速搭建数字化官网、内容管理平台，降低数字化转型成本。', 'home', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (623, 'zh', 'home.about.intro3', '截至目前，我们已服务超过500家企业客户，涵盖制造、零售、教育、政务等多个行业，凭借稳定的产品性能和优质的服务赢得了客户的一致认可。', 'home', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (624, 'zh', 'home.about.stats.partners', '合作企业', 'home', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (625, 'zh', 'home.about.stats.products', '核心产品', 'home', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (626, 'zh', 'home.about.stats.team', '技术团队', 'home', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (627, 'zh', 'home.about.stats.satisfaction', '客户满意度', 'home', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (628, 'zh', 'home.contact.title', '关于我们', 'home', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (629, 'zh', 'home.contact.subtitle', '联系我们，了解更多产品信息和合作方案', 'home', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (630, 'zh', 'home.contact.info.address', '公司地址', 'home', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (631, 'zh', 'home.contact.info.phone', '联系电话', 'home', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (632, 'zh', 'home.contact.info.email', '电子邮箱', 'home', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (633, 'zh', 'home.contact.address', '北京市朝阳区建国路88号现代国际大厦A座', 'home', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (634, 'zh', 'home.contact.phone', '400-888-9999', 'home', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (635, 'zh', 'home.contact.social.title', '关注我们', 'home', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (636, 'zh', 'home.contact.form.title', '咨询留言', 'home', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (637, 'zh', 'home.contact.form.name', '姓名', 'home', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (638, 'zh', 'home.contact.form.namePlaceholder', '请输入您的姓名', 'home', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (639, 'zh', 'home.contact.form.phone', '电话', 'home', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (640, 'zh', 'home.contact.form.phonePlaceholder', '请输入您的联系电话', 'home', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (641, 'zh', 'home.contact.form.email', '邮箱', 'home', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (642, 'zh', 'home.contact.form.emailPlaceholder', '请输入您的电子邮箱', 'home', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (643, 'zh', 'home.contact.form.subject', '咨询主题', 'home', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (644, 'zh', 'home.contact.form.subjectPlaceholder', '请选择咨询主题', 'home', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (645, 'zh', 'home.contact.form.subjectProduct', '产品咨询', 'home', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (646, 'zh', 'home.contact.form.subjectCooperation', '合作洽谈', 'home', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (647, 'zh', 'home.contact.form.subjectTechnical', '技术支持', 'home', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (648, 'zh', 'home.contact.form.subjectOther', '其他问题', 'home', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (649, 'zh', 'home.contact.form.message', '留言内容', 'home', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (650, 'zh', 'home.contact.form.messagePlaceholder', '请输入您的留言内容', 'home', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (651, 'zh', 'home.contact.form.submit', '提交留言', 'home', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (652, 'zh', 'home.contact.form.submitting', '提交中...', 'home', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (653, 'zh', 'home.contact.form.success', '提交成功！我们会尽快与您联系。', 'home', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (654, 'zh', 'home.contact.form.error', '提交失败，请稍后重试', 'home', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (655, 'zh', 'home.contact.form.errorDetail', '提交失败，请稍后重试', 'home', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (656, 'zh', 'footer.description', '专注于企业数字化解决方案，以技术创新驱动企业发展', 'footer', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (657, 'zh', 'footer.quickLinks', '快速链接', 'footer', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (658, 'zh', 'footer.hotCategories', '热门栏目', 'footer', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (659, 'zh', 'footer.contactUs', '联系我们', 'footer', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (660, 'zh', 'footer.address', '北京市朝阳区建国路88号', 'footer', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (661, 'zh', 'footer.phone', '400-888-9999', 'footer', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (662, 'zh', 'footer.copyright', '© 2026 NodeForge. 保留所有权利。', 'footer', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (663, 'zh', 'common.home', '首页', 'common', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (664, 'zh', 'common.search', '搜索', 'common', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (665, 'zh', 'common.aiSearch', 'AI 智能搜索', 'common', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (666, 'zh', 'common.searching', '搜索中...', 'common', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (667, 'zh', 'common.searchPlaceholder', '搜索关键词...', 'common', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (668, 'zh', 'common.newSearch', '重新搜索', 'common', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (669, 'zh', 'common.viewDetails', '查看详情', 'common', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (670, 'zh', 'common.prevPage', '上一页', 'common', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (671, 'zh', 'common.nextPage', '下一页', 'common', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (672, 'zh', 'common.noData', '暂无相关数据', 'common', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (673, 'zh', 'common.noNews', '暂无相关新闻，换个关键词试试吧', 'common', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (674, 'zh', 'common.noProducts', '暂无相关产品，敬请期待', 'common', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (675, 'zh', 'common.loading', '加载中...', 'common', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (676, 'zh', 'news.detail.category', '分类', 'news', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (677, 'zh', 'news.detail.publishTime', '发布时间', 'news', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (678, 'zh', 'news.detail.viewCount', '阅读量', 'news', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (679, 'zh', 'news.detail.prev', '上一篇', 'news', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (680, 'zh', 'news.detail.next', '下一篇', 'news', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (681, 'zh', 'news.detail.prevEmpty', '上一篇：暂无', 'news', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (682, 'zh', 'news.detail.nextEmpty', '下一篇：暂无', 'news', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (683, 'zh', 'news.detail.related', '相关推荐', 'news', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (684, 'zh', 'news.searchPlaceholder', '搜索新闻关键词...', 'news', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (685, 'zh', 'news.aiSearchPlaceholder', '请输入您想查找的内容，例如：最新的科技新闻', 'news', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (686, 'zh', 'news.trySearch', '试试搜索：', 'news', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (687, 'zh', 'news.suggestionLatest', '最近的新闻', 'news', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (688, 'zh', 'news.suggestionHot', '热门新闻', 'news', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (689, 'zh', 'news.suggestionTech', '科技新闻', 'news', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (690, 'zh', 'news.suggestionProduct', '产品信息', 'news', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (691, 'zh', 'news.aiSearchTitle', 'AI 智能搜索', 'news', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (692, 'zh', 'news.aiSearchDesc', '用自然语言描述您想要查找的内容，AI 将帮您智能匹配最相关的结果', 'news', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (693, 'zh', 'news.featureUnderstand', '智能理解', 'news', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (694, 'zh', 'news.featureUnderstandDesc', '理解您的搜索意图，自动匹配最相关的内容', 'news', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (695, 'zh', 'news.featureSummarize', '智能总结', 'news', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (696, 'zh', 'news.featureSummarizeDesc', 'AI 自动总结搜索结果，快速了解核心信息', 'news', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (697, 'zh', 'news.featureSuggest', '智能推荐', 'news', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (698, 'zh', 'news.featureSuggestDesc', '基于搜索结果推荐相关内容和优化建议', 'news', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (699, 'zh', 'news.aiAnalyzing', 'AI 正在分析您的查询...', 'news', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (700, 'zh', 'news.aiAnalyzingDesc', '正在理解搜索意图，智能匹配内容', 'news', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (701, 'zh', 'news.aiSummary', 'AI 搜索总结', 'news', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (702, 'zh', 'news.aiSuggestions', '智能建议', 'news', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (703, 'zh', 'news.relatedSearches', '相关搜索', 'news', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (704, 'zh', 'news.searchResultsCount', '找到 {count} 条关于\"{keyword}\"的结果', 'news', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (705, 'zh', 'news.noResults', '未找到相关内容', 'news', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (706, 'zh', 'news.noResultsDesc', '请尝试使用其他关键词或更通用的搜索条件', 'news', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (707, 'zh', 'news.searchError', '搜索失败，请稍后重试', 'news', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (708, 'zh', 'product.consultNow', '立即咨询', 'product', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (709, 'zh', 'product.freeTrial', '免费试用', 'product', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (710, 'zh', 'product.detailTitle', '产品详情介绍', 'product', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (711, 'zh', 'error.pageNotFound', '页面未找到', 'error', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (712, 'zh', 'error.categoryNotFound', '该栏目不存在或未发布', 'error', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (713, 'zh', 'error.backToHome', '返回首页', 'error', 0, '', '', '2026-02-06 07:48:32', '', '2026-02-06 07:48:32');
INSERT INTO `i18n_translation` VALUES (714, 'en', 'site.name', 'NodeForgeCMS', 'site', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (715, 'en', 'nav.home', 'Home', 'nav', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (716, 'en', 'nav.news', 'News', 'nav', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (717, 'en', 'nav.products', 'Products', 'nav', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (718, 'en', 'nav.language', 'Language / 语言', 'nav', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (719, 'en', 'home.banner.title', 'Innovative Technology · Empowering Enterprise Development', 'home', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (720, 'en', 'home.banner.description', 'Specializing in enterprise digital solutions, providing high-performance, scalable CMS systems and full-stack technical services', 'home', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (721, 'en', 'home.banner.learnMore', 'Learn More', 'home', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (722, 'en', 'home.banner.viewProducts', 'View Products', 'home', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (723, 'en', 'home.products.title', 'Product Center', 'home', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (724, 'en', 'home.products.description', 'We offer a rich portfolio of enterprise-level product solutions to meet digital needs across diverse scenarios', 'home', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (725, 'en', 'home.products.viewDetails', 'View Details', 'home', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (726, 'en', 'home.news.title', 'News Center', 'home', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (727, 'en', 'home.news.description', 'Stay updated with the latest enterprise dynamics, industry insights and product upgrades', 'home', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (728, 'en', 'home.news.readFull', 'Read Full Article', 'home', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (729, 'en', 'home.news.viewMore', 'View More News', 'home', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (730, 'en', 'home.about.title', 'About Us', 'home', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (731, 'en', 'home.about.subtitle', 'Specializing in enterprise digital solutions, driving development through technological innovation', 'home', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (732, 'en', 'home.about.imageUrl', 'About Us', 'home', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (733, 'en', 'home.about.intro1', 'Founded in 20xx, NodeForge is a technology company focused on enterprise digital solutions. Our core team hails from leading internet enterprises and software service providers, boasting extensive experience in enterprise-level product R&D and implementation.', 'home', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (734, 'en', 'home.about.intro2', 'With Node.js and Vue/Nuxt as our core tech stack, we build high-performance, easily scalable enterprise CMS systems. We help businesses quickly set up digital official websites and content management platforms, reducing the cost of digital transformation.', 'home', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (735, 'en', 'home.about.intro3', 'To date, we have served over 500 enterprise clients across manufacturing, retail, education, government and other industries, earning consistent recognition for our stable product performance and high-quality services.', 'home', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (736, 'en', 'home.about.stats.partners', 'Cooperative Enterprises', 'home', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (737, 'en', 'home.about.stats.products', 'Core Products', 'home', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (738, 'en', 'home.about.stats.team', 'Technical Team', 'home', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (739, 'en', 'home.about.stats.satisfaction', 'Customer Satisfaction', 'home', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (740, 'en', 'home.contact.title', 'About Us', 'home', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (741, 'en', 'home.contact.subtitle', 'Contact us for more product information and cooperation solutions', 'home', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (742, 'en', 'home.contact.info.address', 'Address', 'home', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (743, 'en', 'home.contact.info.phone', 'Phone', 'home', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (744, 'en', 'home.contact.info.email', 'Email', 'home', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (745, 'en', 'home.contact.address', 'Tower A, Modern International Building, No.88 Jianguo Road, Chaoyang District, Beijing', 'home', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (746, 'en', 'home.contact.phone', '400-888-9999', 'home', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (747, 'en', 'home.contact.social.title', 'Follow Us', 'home', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (748, 'en', 'home.contact.form.title', 'Consultation & Message', 'home', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (749, 'en', 'home.contact.form.name', 'Name', 'home', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (750, 'en', 'home.contact.form.namePlaceholder', 'Please enter your name', 'home', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (751, 'en', 'home.contact.form.phone', 'Phone Number', 'home', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (752, 'en', 'home.contact.form.phonePlaceholder', 'Please enter your contact number', 'home', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (753, 'en', 'home.contact.form.email', 'Email', 'home', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (754, 'en', 'home.contact.form.emailPlaceholder', 'Please enter your email address', 'home', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (755, 'en', 'home.contact.form.subject', 'Consultation Subject', 'home', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (756, 'en', 'home.contact.form.subjectPlaceholder', 'Please select a consultation subject', 'home', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (757, 'en', 'home.contact.form.subjectProduct', 'Product Consultation', 'home', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (758, 'en', 'home.contact.form.subjectCooperation', 'Cooperation Discussion', 'home', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (759, 'en', 'home.contact.form.subjectTechnical', 'Technical Support', 'home', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (760, 'en', 'home.contact.form.subjectOther', 'Other Inquiries', 'home', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (761, 'en', 'home.contact.form.message', 'Message Content', 'home', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (762, 'en', 'home.contact.form.messagePlaceholder', 'Please enter your message', 'home', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (763, 'en', 'home.contact.form.submit', 'Submit Message', 'home', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (764, 'en', 'home.contact.form.submitting', 'Submitting...', 'home', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (765, 'en', 'home.contact.form.success', 'Submitted successfully! We will contact you as soon as possible.', 'home', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (766, 'en', 'home.contact.form.error', 'Submission failed, please try again later', 'home', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (767, 'en', 'home.contact.form.errorDetail', 'Submission failed, please try again later', 'home', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (768, 'en', 'footer.description', 'Specializing in enterprise digital solutions, driving development through technological innovation', 'footer', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (769, 'en', 'footer.quickLinks', 'Quick Links', 'footer', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (770, 'en', 'footer.hotCategories', 'Popular Columns', 'footer', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (771, 'en', 'footer.contactUs', 'Contact Us', 'footer', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (772, 'en', 'footer.address', 'No.88 Jianguo Road, Chaoyang District, Beijing', 'footer', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (773, 'en', 'footer.phone', '400-888-9999', 'footer', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (774, 'en', 'footer.copyright', '© 2026 NodeForge. All Rights Reserved.', 'footer', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (775, 'en', 'common.home', 'Home', 'common', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (776, 'en', 'common.search', 'Search', 'common', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (777, 'en', 'common.aiSearch', 'AI Intelligent Search', 'common', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (778, 'en', 'common.searching', 'Searching...', 'common', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (779, 'en', 'common.searchPlaceholder', 'Enter search keywords...', 'common', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (780, 'en', 'common.newSearch', 'New Search', 'common', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (781, 'en', 'common.viewDetails', 'View Details', 'common', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (782, 'en', 'common.prevPage', 'Previous Page', 'common', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (783, 'en', 'common.nextPage', 'Next Page', 'common', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (784, 'en', 'common.noData', 'No relevant data available', 'common', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (785, 'en', 'common.noNews', 'No relevant news found, please try other keywords', 'common', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (786, 'en', 'common.noProducts', 'No relevant products available yet, stay tuned', 'common', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (787, 'en', 'common.loading', 'Loading...', 'common', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (788, 'en', 'news.detail.category', 'Category', 'news', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (789, 'en', 'news.detail.publishTime', 'Publish Time', 'news', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (790, 'en', 'news.detail.viewCount', 'Page Views', 'news', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (791, 'en', 'news.detail.prev', 'Previous Article', 'news', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (792, 'en', 'news.detail.next', 'Next Article', 'news', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (793, 'en', 'news.detail.prevEmpty', 'Previous Article: None', 'news', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (794, 'en', 'news.detail.nextEmpty', 'Next Article: None', 'news', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (795, 'en', 'news.detail.related', 'Related Recommendations', 'news', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (796, 'en', 'news.searchPlaceholder', 'Search news keywords...', 'news', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (797, 'en', 'news.aiSearchPlaceholder', 'Please enter what you want to find, e.g., the latest technology news', 'news', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (798, 'en', 'news.trySearch', 'Try searching for: ', 'news', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (799, 'en', 'news.suggestionLatest', 'Latest News', 'news', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (800, 'en', 'news.suggestionHot', 'Hot News', 'news', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (801, 'en', 'news.suggestionTech', 'Technology News', 'news', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (802, 'en', 'news.suggestionProduct', 'Product Information', 'news', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (803, 'en', 'news.aiSearchTitle', 'AI Intelligent Search', 'news', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (804, 'en', 'news.aiSearchDesc', 'Describe what you want to find in natural language, and AI will intelligently match the most relevant results', 'news', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (805, 'en', 'news.featureUnderstand', 'Intelligent Understanding', 'news', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (806, 'en', 'news.featureUnderstandDesc', 'Understand your search intent and automatically match the most relevant content', 'news', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (807, 'en', 'news.featureSummarize', 'Intelligent Summary', 'news', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (808, 'en', 'news.featureSummarizeDesc', 'AI automatically summarizes search results for quick access to core information', 'news', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (809, 'en', 'news.featureSuggest', 'Intelligent Recommendation', 'news', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (810, 'en', 'news.featureSuggestDesc', 'Recommend relevant content and optimization suggestions based on search results', 'news', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (811, 'en', 'news.aiAnalyzing', 'AI is analyzing your query...', 'news', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (812, 'en', 'news.aiAnalyzingDesc', 'Understanding search intent and intelligently matching content', 'news', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (813, 'en', 'news.aiSummary', 'AI Search Summary', 'news', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (814, 'en', 'news.aiSuggestions', 'Intelligent Suggestions', 'news', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (815, 'en', 'news.relatedSearches', 'Related Searches', 'news', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (816, 'en', 'news.searchResultsCount', '{count} results found for \"{keyword}\"', 'news', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (817, 'en', 'news.noResults', 'No relevant content found', 'news', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (818, 'en', 'news.noResultsDesc', 'Please try other keywords or more general search criteria', 'news', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (819, 'en', 'news.searchError', 'Search failed, please try again later', 'news', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (820, 'en', 'product.consultNow', 'Consult Now', 'product', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (821, 'en', 'product.freeTrial', 'Free Trial', 'product', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (822, 'en', 'product.detailTitle', 'Product Details', 'product', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (823, 'en', 'error.pageNotFound', 'Page Not Found', 'error', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (824, 'en', 'error.categoryNotFound', 'This column does not exist or is not published', 'error', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (825, 'en', 'error.backToHome', 'Back to Home', 'error', 0, '', '', '2026-02-06 15:18:31', '', '2026-02-06 15:18:31');
INSERT INTO `i18n_translation` VALUES (826, 'tw', 'site.name', 'NodeForgeCMS', 'site', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (827, 'tw', 'nav.home', '首頁', 'nav', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (828, 'tw', 'nav.news', '新聞資訊', 'nav', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (829, 'tw', 'nav.products', '產品中心', 'nav', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (830, 'tw', 'nav.language', '語言 / Language', 'nav', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (831, 'tw', 'home.banner.title', '創新科技 · 賦能企業發展', 'home', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (832, 'tw', 'home.banner.description', '專注於企業數位化解決方案，提供高效能、可擴充的CMS系統與全棧技術服務', 'home', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (833, 'tw', 'home.banner.learnMore', '瞭解更多', 'home', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (834, 'tw', 'home.banner.viewProducts', '瀏覽產品', 'home', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (835, 'tw', 'home.products.title', '產品中心', 'home', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (836, 'tw', 'home.products.description', '我們提供豐富的企業級產品解決方案，滿足不同場景的數位化需求', 'home', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (837, 'tw', 'home.products.viewDetails', '檢視詳情', 'home', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (838, 'tw', 'home.news.title', '新聞中心', 'home', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (839, 'tw', 'home.news.description', '掌握企業最新動態、產業資訊與產品更新內容', 'home', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (840, 'tw', 'home.news.readFull', '閱讀全文', 'home', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (841, 'tw', 'home.news.viewMore', '查看更多新聞', 'home', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (842, 'tw', 'home.about.title', '企業介紹', 'home', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (843, 'tw', 'home.about.subtitle', '專注於企業數位化解決方案，以技術創新驅動企業發展', 'home', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (844, 'tw', 'home.about.imageUrl', '企業介紹', 'home', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (845, 'tw', 'home.about.intro1', 'NodeForge成立於20xx年，是一家專注於企業數位化解決方案的科技公司，核心團隊來自頂尖網際網路企業與軟體服務商，擁有豐富的企業級產品研發與實施經驗。', 'home', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (846, 'tw', 'home.about.intro2', '我們以Node.js、Vue/Nuxt為核心技術棧，打造高效能、易擴充的企業級CMS系統，協助企業快速建置數位化官網、內容管理平台，降低數位轉型成本。', 'home', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (847, 'tw', 'home.about.intro3', '截至目前，我們已服務超過500家企業客戶，涵蓋製造、零售、教育、政務等多個產業，憑藉穩定的產品效能與優質的服務，獲得客戶的一致肯定。', 'home', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (848, 'tw', 'home.about.stats.partners', '合作企業', 'home', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (849, 'tw', 'home.about.stats.products', '核心產品', 'home', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (850, 'tw', 'home.about.stats.team', '技術團隊', 'home', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (851, 'tw', 'home.about.stats.satisfaction', '客戶滿意度', 'home', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (852, 'tw', 'home.contact.title', '關於我們', 'home', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (853, 'tw', 'home.contact.subtitle', '聯繫我們，瞭解更多產品資訊與合作方案', 'home', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (854, 'tw', 'home.contact.info.address', '公司地址', 'home', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (855, 'tw', 'home.contact.info.phone', '聯繫電話', 'home', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (856, 'tw', 'home.contact.info.email', '電子郵件', 'home', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (857, 'tw', 'home.contact.address', '北京市朝陽區建國路88號現代國際大廈A座', 'home', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (858, 'tw', 'home.contact.phone', '400-888-9999', 'home', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (859, 'tw', 'home.contact.social.title', '追蹤我們', 'home', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (860, 'tw', 'home.contact.form.title', '諮詢留言', 'home', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (861, 'tw', 'home.contact.form.name', '姓名', 'home', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (862, 'tw', 'home.contact.form.namePlaceholder', '請輸入您的姓名', 'home', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (863, 'tw', 'home.contact.form.phone', '電話', 'home', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (864, 'tw', 'home.contact.form.phonePlaceholder', '請輸入您的聯繫電話', 'home', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (865, 'tw', 'home.contact.form.email', '信箱', 'home', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (866, 'tw', 'home.contact.form.emailPlaceholder', '請輸入您的電子郵件', 'home', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (867, 'tw', 'home.contact.form.subject', '諮詢主題', 'home', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (868, 'tw', 'home.contact.form.subjectPlaceholder', '請選擇諮詢主題', 'home', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (869, 'tw', 'home.contact.form.subjectProduct', '產品諮詢', 'home', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (870, 'tw', 'home.contact.form.subjectCooperation', '合作洽談', 'home', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (871, 'tw', 'home.contact.form.subjectTechnical', '技術支援', 'home', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (872, 'tw', 'home.contact.form.subjectOther', '其他問題', 'home', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (873, 'tw', 'home.contact.form.message', '留言內容', 'home', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (874, 'tw', 'home.contact.form.messagePlaceholder', '請輸入您的留言內容', 'home', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (875, 'tw', 'home.contact.form.submit', '提交留言', 'home', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (876, 'tw', 'home.contact.form.submitting', '提交中...', 'home', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (877, 'tw', 'home.contact.form.success', '提交成功！我們將儘速與您聯繫。', 'home', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (878, 'tw', 'home.contact.form.error', '提交失敗，請稍後再試', 'home', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (879, 'tw', 'home.contact.form.errorDetail', '提交失敗，請稍後再試', 'home', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (880, 'tw', 'footer.description', '專注於企業數位化解決方案，以技術創新驅動企業發展', 'footer', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (881, 'tw', 'footer.quickLinks', '快速連結', 'footer', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (882, 'tw', 'footer.hotCategories', '熱門欄目', 'footer', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (883, 'tw', 'footer.contactUs', '聯繫我們', 'footer', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (884, 'tw', 'footer.address', '北京市朝陽區建國路88號', 'footer', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (885, 'tw', 'footer.phone', '400-888-9999', 'footer', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (886, 'tw', 'footer.copyright', '© 2026 NodeForge. 保留所有權利。', 'footer', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (887, 'tw', 'common.home', '首頁', 'common', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (888, 'tw', 'common.search', '搜尋', 'common', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (889, 'tw', 'common.aiSearch', 'AI 智慧搜尋', 'common', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (890, 'tw', 'common.searching', '搜尋中...', 'common', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (891, 'tw', 'common.searchPlaceholder', '輸入搜尋關鍵字...', 'common', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (892, 'tw', 'common.newSearch', '重新搜尋', 'common', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (893, 'tw', 'common.viewDetails', '檢視詳情', 'common', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (894, 'tw', 'common.prevPage', '上一頁', 'common', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (895, 'tw', 'common.nextPage', '下一頁', 'common', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (896, 'tw', 'common.noData', '暫無相關資料', 'common', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (897, 'tw', 'common.noNews', '暫無相關新聞，更換關鍵字試試吧', 'common', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (898, 'tw', 'common.noProducts', '暫無相關產品，敬請期待', 'common', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (899, 'tw', 'common.loading', '載入中...', 'common', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (900, 'tw', 'news.detail.category', '分類', 'news', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (901, 'tw', 'news.detail.publishTime', '發布時間', 'news', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (902, 'tw', 'news.detail.viewCount', '閱讀次數', 'news', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (903, 'tw', 'news.detail.prev', '上一篇', 'news', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (904, 'tw', 'news.detail.next', '下一篇', 'news', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (905, 'tw', 'news.detail.prevEmpty', '上一篇：無', 'news', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (906, 'tw', 'news.detail.nextEmpty', '下一篇：無', 'news', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (907, 'tw', 'news.detail.related', '相關推薦', 'news', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (908, 'tw', 'news.searchPlaceholder', '搜尋新聞關鍵字...', 'news', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (909, 'tw', 'news.aiSearchPlaceholder', '請輸入您想查詢的內容，例如：最新的科技新聞', 'news', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (910, 'tw', 'news.trySearch', '試試搜尋：', 'news', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (911, 'tw', 'news.suggestionLatest', '最新新聞', 'news', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (912, 'tw', 'news.suggestionHot', '熱門新聞', 'news', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (913, 'tw', 'news.suggestionTech', '科技新聞', 'news', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (914, 'tw', 'news.suggestionProduct', '產品資訊', 'news', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (915, 'tw', 'news.aiSearchTitle', 'AI 智慧搜尋', 'news', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (916, 'tw', 'news.aiSearchDesc', '以自然語言描述您想查找的內容，AI 將協助您智慧匹配最相關的結果', 'news', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (917, 'tw', 'news.featureUnderstand', '智慧理解', 'news', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (918, 'tw', 'news.featureUnderstandDesc', '理解您的搜尋意圖，自動匹配最相關的內容', 'news', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (919, 'tw', 'news.featureSummarize', '智慧彙整', 'news', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (920, 'tw', 'news.featureSummarizeDesc', 'AI 自動彙整搜尋結果，快速掌握核心資訊', 'news', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (921, 'tw', 'news.featureSuggest', '智慧推薦', 'news', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (922, 'tw', 'news.featureSuggestDesc', '依據搜尋結果，推薦相關內容與優化建議', 'news', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (923, 'tw', 'news.aiAnalyzing', 'AI 正在分析您的查詢...', 'news', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (924, 'tw', 'news.aiAnalyzingDesc', '正在理解搜尋意圖，智慧匹配相關內容', 'news', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (925, 'tw', 'news.aiSummary', 'AI 搜尋彙整', 'news', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (926, 'tw', 'news.aiSuggestions', '智慧建議', 'news', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (927, 'tw', 'news.relatedSearches', '相關搜尋', 'news', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (928, 'tw', 'news.searchResultsCount', '找到 {count} 筆關於「{keyword}」的結果', 'news', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (929, 'tw', 'news.noResults', '未找到相關內容', 'news', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (930, 'tw', 'news.noResultsDesc', '請嘗試使用其他關鍵字或更通用的搜尋條件', 'news', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (931, 'tw', 'news.searchError', '搜尋失敗，請稍後再試', 'news', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (932, 'tw', 'product.consultNow', '立即諮詢', 'product', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (933, 'tw', 'product.freeTrial', '免費試用', 'product', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (934, 'tw', 'product.detailTitle', '產品詳情介紹', 'product', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (935, 'tw', 'error.pageNotFound', '頁面未找到', 'error', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (936, 'tw', 'error.categoryNotFound', '該欄目不存在或尚未發布', 'error', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (937, 'tw', 'error.backToHome', '返回首頁', 'error', 0, '', '', '2026-02-06 15:20:19', '', '2026-02-06 15:20:19');
INSERT INTO `i18n_translation` VALUES (938, 'bn', 'site.name', 'NodeForgeCMS', 'site', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (939, 'bn', 'nav.home', 'মূল পৃষ্ঠা', 'nav', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (940, 'bn', 'nav.news', 'সংবাদ', 'nav', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (941, 'bn', 'nav.products', 'পণ্য কেন্দ্র', 'nav', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (942, 'bn', 'nav.language', 'ভাষা / Language', 'nav', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (943, 'bn', 'home.banner.title', 'নবীন প্রযুক্তি · এন্টারপ্রাইজের বিকাশকে সশক্ত করা', 'home', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (944, 'bn', 'home.banner.description', 'এন্টারপ্রাইজ ডিজিটাল সমাধানে মনোনিবেশ করা, উচ্চ কর্মক্ষমতা, স্কেলেবল CMS সিস্টেম এবং ফুল-স্ট্যাক প্রযুক্তিগত সেবা প্রদান করা', 'home', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (945, 'bn', 'home.banner.learnMore', 'আরও জানুন', 'home', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (946, 'bn', 'home.banner.viewProducts', 'পণ্য দেখুন', 'home', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (947, 'bn', 'home.products.title', 'পণ্য কেন্দ্র', 'home', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (948, 'bn', 'home.products.description', 'আমরা বিভিন্ন পরিস্থিতিতে ডিজিটাল প্রয়োজনীয়তা পূরণ করার জন্য সমৃদ্ধ এন্টারপ্রাইজ-স্তরের পণ্য সমাধান প্রদান করছি', 'home', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (949, 'bn', 'home.products.viewDetails', 'বিবরণ দেখুন', 'home', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (950, 'bn', 'home.news.title', 'সংবাদ কেন্দ্র', 'home', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (951, 'bn', 'home.news.description', 'এন্টারপ্রাইজের নতুনতম ঘটনাবলী, শিল্প সংবাদ এবং পণ্য আপডেট জানুন', 'home', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (952, 'bn', 'home.news.readFull', 'পুরো নিবন্ধ পড়ুন', 'home', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (953, 'bn', 'home.news.viewMore', 'আরও সংবাদ দেখুন', 'home', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (954, 'bn', 'home.about.title', 'কোম্পানি সম্পর্কে', 'home', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (955, 'bn', 'home.about.subtitle', 'এন্টারপ্রাইজ ডিজিটাল সমাধানে মনোনিবেশ করা, প্রযুক্তিগত উদ্ভাবনের মাধ্যমে ব্যবসার বিকাশ চালানো', 'home', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (956, 'bn', 'home.about.imageUrl', 'কোম্পানি সম্পর্কে', 'home', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (957, 'bn', 'home.about.intro1', '20xx সালে প্রতিষ্ঠিত NodeForge হলো এন্টারপ্রাইজ ডিজিটাল সমাধানে মনোনিবেশ করা একটি প্রযুক্তি কোম্পানি। আমাদের মূল দল শীর্ষস্থানীয় ইন্টারনেট সংস্থা এবং সফটওয়্যার সেবা প্রদানকারীদের কাছ থেকে এসেছে, যাদের এন্টারপ্রাইজ-স্তরের পণ্য গবেষণা ও বিকাশ এবং বাস্তবায়নে ব্যাপক অভিজ্ঞতা রয়েছে।', 'home', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (958, 'bn', 'home.about.intro2', 'Node.js এবং Vue/Nuxt কে আমাদের মূল টেক স্ট্যাক হিসেবে ব্যবহার করে, আমরা উচ্চ কর্মক্ষমতা, সহজেই স্কেলেবল এন্টারপ্রাইজ CMS সিস্টেম তৈরি করছি। আমরা ব্যবসায়কে দ্রুত ডিজিটাল অফিসিয়াল ওয়েবসাইট এবং কন্টেন্ট ম্যানেজমেন্ট প্ল্যাটফর্ম স্থাপনে সাহায্য করছি, ডিজিটাল রূপান্তরের খরচ কমিয়ে দিচ্ছি।', 'home', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (959, 'bn', 'home.about.intro3', 'আজ পর্যন্ত, আমরা প্রস্তুতি, খুচরা বিক্রয়, শিক্ষা, সরকারি কাজসমূহ সহ বিভিন্ন শিল্পে ৫০০ টিরও বেশি এন্টারপ্রাইজ গ্রাহককে সেবা প্রদান করেছি। স্থিতিশীল পণ্য কর্মক্ষমতা এবং উচ্চমানের সেবার কারণে গ্রাহকদের কাছ থেকে ধারাবাহিক স্বীকৃতি পেয়েছি।', 'home', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (960, 'bn', 'home.about.stats.partners', 'সহযোগী এন্টারপ্রাইজ', 'home', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (961, 'bn', 'home.about.stats.products', 'মূল পণ্য', 'home', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (962, 'bn', 'home.about.stats.team', 'প্রযুক্তিগত দল', 'home', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (963, 'bn', 'home.about.stats.satisfaction', 'গ্রাহক সন্তুষ্টি', 'home', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (964, 'bn', 'home.contact.title', 'আমাদের সম্পর্কে', 'home', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (965, 'bn', 'home.contact.subtitle', 'আরও পণ্য তথ্য এবং সহযোগিতা পরিকল্পনার জন্য আমাদের সাথে যোগাযোগ করুন', 'home', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (966, 'bn', 'home.contact.info.address', 'ঠিকানা', 'home', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (967, 'bn', 'home.contact.info.phone', 'যোগাযোগ নম্বর', 'home', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (968, 'bn', 'home.contact.info.email', 'ইমেইল', 'home', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (969, 'bn', 'home.contact.address', 'বেইজিংয়ের চায়অ্যাং জেলার জিয়ানগুয়ো রোড নম্বর ৮৮, মডার্ন ইন্টারন্যাশনাল বিল্ডিং টাওয়ার এ', 'home', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (970, 'bn', 'home.contact.phone', '400-888-9999', 'home', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (971, 'bn', 'home.contact.social.title', 'আমাদের ফলো করুন', 'home', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (972, 'bn', 'home.contact.form.title', 'পরামর্শ ও মেসেজ', 'home', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (973, 'bn', 'home.contact.form.name', 'নাম', 'home', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (974, 'bn', 'home.contact.form.namePlaceholder', 'দয়া করে আপনার নাম লিখুন', 'home', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (975, 'bn', 'home.contact.form.phone', 'ফোন নম্বর', 'home', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (976, 'bn', 'home.contact.form.phonePlaceholder', 'দয়া করে আপনার যোগাযোগ নম্বর লিখুন', 'home', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (977, 'bn', 'home.contact.form.email', 'ইমেইল', 'home', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (978, 'bn', 'home.contact.form.emailPlaceholder', 'দয়া করে আপনার ইমেইল ঠিকানা লিখুন', 'home', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (979, 'bn', 'home.contact.form.subject', 'পরামর্শের বিষয়', 'home', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (980, 'bn', 'home.contact.form.subjectPlaceholder', 'দয়া করে পরামর্শের বিষয় নির্বাচন করুন', 'home', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (981, 'bn', 'home.contact.form.subjectProduct', 'পণ্য পরামর্শ', 'home', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (982, 'bn', 'home.contact.form.subjectCooperation', 'সহযোগিতা আলোচনা', 'home', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (983, 'bn', 'home.contact.form.subjectTechnical', 'প্রযুক্তিগত সমর্থন', 'home', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (984, 'bn', 'home.contact.form.subjectOther', 'অন্যান্য প্রশ্ন', 'home', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (985, 'bn', 'home.contact.form.message', 'মেসেজের বিষয়বস্তু', 'home', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (986, 'bn', 'home.contact.form.messagePlaceholder', 'দয়া করে আপনার মেসেজ লিখুন', 'home', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (987, 'bn', 'home.contact.form.submit', 'মেসেজ জমা দিন', 'home', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (988, 'bn', 'home.contact.form.submitting', 'জমা দিচ্ছি...', 'home', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (989, 'bn', 'home.contact.form.success', 'সফলভাবে জমা দেওয়া হয়েছে! আমরা যত তাড়াতাড়ি সম্ভব আপনার সাথে যোগাযোগ করব।', 'home', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (990, 'bn', 'home.contact.form.error', 'জমা দেওয়া ব্যর্থ, দয়া করে পরে আবার চেষ্টা করুন', 'home', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (991, 'bn', 'home.contact.form.errorDetail', 'জমা দেওয়া ব্যর্থ, দয়া করে পরে আবার চেষ্টা করুন', 'home', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (992, 'bn', 'footer.description', 'এন্টারপ্রাইজ ডিজিটাল সমাধানে মনোনিবেশ করা, প্রযুক্তিগত উদ্ভাবনের মাধ্যমে ব্যবসার বিকাশ চালানো', 'footer', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (993, 'bn', 'footer.quickLinks', 'দ্রুত লিঙ্ক', 'footer', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (994, 'bn', 'footer.hotCategories', 'জনপ্রিয় কলাম', 'footer', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (995, 'bn', 'footer.contactUs', 'আমাদের সাথে যোগাযোগ করুন', 'footer', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (996, 'bn', 'footer.address', 'বেইজিংয়ের চায়অ্যাং জেলার জিয়ানগুয়ো রোড নম্বর ৮৮', 'footer', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (997, 'bn', 'footer.phone', '400-888-9999', 'footer', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (998, 'bn', 'footer.copyright', '© 2026 NodeForge. সমস্ত অধিকার সংরক্ষিত।', 'footer', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (999, 'bn', 'common.home', 'মূল পৃষ্ঠা', 'common', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (1000, 'bn', 'common.search', 'অনুসন্ধান', 'common', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (1001, 'bn', 'common.aiSearch', 'AI বুদ্ধিমান অনুসন্ধান', 'common', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (1002, 'bn', 'common.searching', 'অনুসন্ধান করছি...', 'common', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (1003, 'bn', 'common.searchPlaceholder', 'অনুসন্ধান কীওয়ার্ড লিখুন...', 'common', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (1004, 'bn', 'common.newSearch', 'পুনরায় অনুসন্ধান করুন', 'common', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (1005, 'bn', 'common.viewDetails', 'বিবরণ দেখুন', 'common', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (1006, 'bn', 'common.prevPage', 'পূর্ববর্তী পৃষ্ঠা', 'common', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (1007, 'bn', 'common.nextPage', 'পরবর্তী পৃষ্ঠা', 'common', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (1008, 'bn', 'common.noData', 'কোনো প্রাসঙ্গিক ডেটা নেই', 'common', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (1009, 'bn', 'common.noNews', 'কোনো প্রাসঙ্গিক সংবাদ নেই, দয়া করে অন্য কীওয়ার্ড চেষ্টা করুন', 'common', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (1010, 'bn', 'common.noProducts', 'এখনও পর্যন্ত কোনো প্রাসঙ্গিক পণ্য নেই, অপেক্ষা করুন', 'common', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (1011, 'bn', 'common.loading', 'লোড হচ্ছে...', 'common', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (1012, 'bn', 'news.detail.category', 'বিভাগ', 'news', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (1013, 'bn', 'news.detail.publishTime', 'প্রকাশের সময়', 'news', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (1014, 'bn', 'news.detail.viewCount', 'দেখার সংখ্যা', 'news', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (1015, 'bn', 'news.detail.prev', 'পূর্ববর্তী নিবন্ধ', 'news', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (1016, 'bn', 'news.detail.next', 'পরবর্তী নিবন্ধ', 'news', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (1017, 'bn', 'news.detail.prevEmpty', 'পূর্ববর্তী নিবন্ধ: নেই', 'news', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (1018, 'bn', 'news.detail.nextEmpty', 'পরবর্তী নিবন্ধ: নেই', 'news', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (1019, 'bn', 'news.detail.related', 'সম্পর্কিত সুপারিশ', 'news', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (1020, 'bn', 'news.searchPlaceholder', 'সংবাদ কীওয়ার্ড অনুসন্ধান করুন...', 'news', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (1021, 'bn', 'news.aiSearchPlaceholder', 'দয়া করে আপনি যা খুঁজছেন তা লিখুন, যেমন: নতুনতম প্রযুক্তি সংবাদ', 'news', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (1022, 'bn', 'news.trySearch', 'অনুসন্ধান চেষ্টা করুন:', 'news', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (1023, 'bn', 'news.suggestionLatest', 'নতুনতম সংবাদ', 'news', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (1024, 'bn', 'news.suggestionHot', 'জনপ্রিয় সংবাদ', 'news', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (1025, 'bn', 'news.suggestionTech', 'প্রযুক্তি সংবাদ', 'news', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (1026, 'bn', 'news.suggestionProduct', 'পণ্য তথ্য', 'news', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (1027, 'bn', 'news.aiSearchTitle', 'AI বুদ্ধিমান অনুসন্ধান', 'news', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (1028, 'bn', 'news.aiSearchDesc', 'প্রাকৃতিক ভাষায় আপনি যা খুঁজছেন তা বর্ণনা করুন, AI সবচেয়ে প্রাসঙ্গিক ফলাফলের সাথে স্মার্টভাবে মেলবে', 'news', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (1029, 'bn', 'news.featureUnderstand', 'বুদ্ধিমান বোঝার ক্ষমতা', 'news', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (1030, 'bn', 'news.featureUnderstandDesc', 'আপনার অনুসন্ধানের উদ্দেশ্য বোঝে, স্বয়ংক্রিয়ভাবে সবচেয়ে প্রাসঙ্গিক কন্টেন্টের সাথে মেলবে', 'news', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (1031, 'bn', 'news.featureSummarize', 'বুদ্ধিমান সারসংক্ষেপ', 'news', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (1032, 'bn', 'news.featureSummarizeDesc', 'AI স্বয়ংক্রিয়ভাবে অনুসন্ধান ফলাফল সারসংক্ষেপ করে, দ্রুত মূল তথ্য জানুন', 'news', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (1033, 'bn', 'news.featureSuggest', 'বুদ্ধিমান সুপারিশ', 'news', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (1034, 'bn', 'news.featureSuggestDesc', 'অনুসন্ধান ফলাফলের ভিত্তিতে সম্পর্কিত কন্টেন্ট এবং অপ্টিমাইজেশন সুপারিশ প্রদান করা', 'news', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (1035, 'bn', 'news.aiAnalyzing', 'AI আপনার কোয়েরী বিশ্লেষণ করছে...', 'news', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (1036, 'bn', 'news.aiAnalyzingDesc', 'অনুসন্ধানের উদ্দেশ্য বোঝছি, স্মার্টভাবে কন্টেন্টের সাথে মেলছি', 'news', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (1037, 'bn', 'news.aiSummary', 'AI অনুসন্ধান সারসংক্ষেপ', 'news', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (1038, 'bn', 'news.aiSuggestions', 'বুদ্ধিমান সুপারিশ', 'news', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (1039, 'bn', 'news.relatedSearches', 'সম্পর্কিত অনুসন্ধান', 'news', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (1040, 'bn', 'news.searchResultsCount', '\"{keyword}\" সম্পর্কে {count} টি ফলাফল পাওয়া গেছে', 'news', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (1041, 'bn', 'news.noResults', 'কোনো প্রাসঙ্গিক কন্টেন্ট পাওয়া যায়নি', 'news', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (1042, 'bn', 'news.noResultsDesc', 'দয়া করে অন্য কীওয়ার্ড বা আরও সাধারণ অনুসন্ধান শর্তাবলী ব্যবহার করার চেষ্টা করুন', 'news', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (1043, 'bn', 'news.searchError', 'অনুসন্ধান ব্যর্থ, দয়া করে পরে আবার চেষ্টা করুন', 'news', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (1044, 'bn', 'product.consultNow', 'এখনই পরামর্শ নিন', 'product', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (1045, 'bn', 'product.freeTrial', 'বিনামূল্যে ট্রায়াল', 'product', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (1046, 'bn', 'product.detailTitle', 'পণ্য বিবরণ', 'product', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (1047, 'bn', 'error.pageNotFound', 'পৃষ্ঠা পাওয়া যায়নি', 'error', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (1048, 'bn', 'error.categoryNotFound', 'এই কলামটি বিদ্যমান নেই বা প্রকাশিত নেই', 'error', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (1049, 'bn', 'error.backToHome', 'মূল পৃষ্ঠায় ফিরুন', 'error', 0, '', '', '2026-02-06 15:22:52', '', '2026-02-06 15:22:52');
INSERT INTO `i18n_translation` VALUES (1050, 'hi', 'site.name', 'NodeForgeCMS', 'site', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1051, 'hi', 'nav.home', 'मुख्य पृष्ठ', 'nav', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1052, 'hi', 'nav.news', 'समाचार', 'nav', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1053, 'hi', 'nav.products', 'उत्पाद केंद्र', 'nav', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1054, 'hi', 'nav.language', 'भाषा / Language', 'nav', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1055, 'hi', 'home.banner.title', 'नवीन तकनीक · उद्यम के विकास को सशक्त बनाना', 'home', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1056, 'hi', 'home.banner.description', 'उद्यम डिजिटल समाधानों पर專註, उच्च प्रदर्शन, स्केलेबल CMS सिस्टम और फुल-स्टैक तकनीकी सेवाएं प्रदान करना', 'home', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1057, 'hi', 'home.banner.learnMore', 'और जानें', 'home', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1058, 'hi', 'home.banner.viewProducts', 'उत्पाद देखें', 'home', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1059, 'hi', 'home.products.title', 'उत्पाद केंद्र', 'home', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1060, 'hi', 'home.products.description', 'हम विभिन्न परिदृश्यों की डिजिटल आवश्यकताओं को पूरा करने के लिए समृद्ध उद्यम स्तर के उत्पाद समाधान प्रदान करते हैं', 'home', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1061, 'hi', 'home.products.viewDetails', 'विवरण देखें', 'home', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1062, 'hi', 'home.news.title', 'समाचार केंद्र', 'home', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1063, 'hi', 'home.news.description', 'उद्यम की नवीनतम गतिविधियां, उद्योग की जानकारी और उत्पाद अपडेट प्राप्त करें', 'home', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1064, 'hi', 'home.news.readFull', 'पूरा लेख पढ़ें', 'home', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1065, 'hi', 'home.news.viewMore', 'और समाचार देखें', 'home', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1066, 'hi', 'home.about.title', 'कंपनी के बारे में', 'home', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1067, 'hi', 'home.about.subtitle', 'उद्यम डिजिटल समाधानों पर專註, तकनीकी नवाचार के माध्यम से उद्यम के विकास को चलाना', 'home', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1068, 'hi', 'home.about.imageUrl', 'कंपनी के बारे में', 'home', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1069, 'hi', 'home.about.intro1', 'NodeForge की स्थापना 20xx में हुई थी, यह एक तकनीकी कंपनी है जो उद्यम डिजिटल समाधानों पर專註 है। हमारी मुख्य टीम शीर्ष इंटरनेट कंपनियों और सॉफ्टवेयर सेवा प्रदाताओं से आती है, जिनके पास उद्यम स्तर के उत्पाद अनुसंधान विकास और कार्यान्वयन में व्यापक अनुभव है।', 'home', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1070, 'hi', 'home.about.intro2', 'Node.js और Vue/Nuxt को हमारा मुख्य तकनीकी स्टैक के रूप में उपयोग करते हुए, हम उच्च प्रदर्शन, आसानी से स्केलेबल उद्यम CMS सिस्टम बनाते हैं। हम व्यवसायों को तेजी से डिजिटल आधिकारिक वेबसाइट और कंटेंट मैनेजमेंट प्लेटफॉर्म स्थापित करने में मदद करते हैं, डिजिटल परिवर्तन की लागत को कम करते हैं।', 'home', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1071, 'hi', 'home.about.intro3', 'अब तक, हमने विनिर्माण, खुदरा बिक्री, शिक्षा, सरकारी कार्यों सहित विभिन्न उद्योगों में 500 से अधिक उद्यम ग्राहकों की सेवा की है। स्थिर उत्पाद प्रदर्शन और उच्च गुणवत्ता की सेवाओं के कारण हमने ग्राहकों से निरंतर मान्यता प्राप्त की है।', 'home', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1072, 'hi', 'home.about.stats.partners', 'सहयोगी उद्यम', 'home', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1073, 'hi', 'home.about.stats.products', 'मुख्य उत्पाद', 'home', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1074, 'hi', 'home.about.stats.team', 'तकनीकी टीम', 'home', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1075, 'hi', 'home.about.stats.satisfaction', 'ग्राहक संतुष्टि', 'home', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1076, 'hi', 'home.contact.title', 'हमारे बारे में', 'home', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1077, 'hi', 'home.contact.subtitle', 'अधिक उत्पाद जानकारी और सहयोग योजनाओं के लिए हमसे संपर्क करें', 'home', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1078, 'hi', 'home.contact.info.address', 'पता', 'home', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1079, 'hi', 'home.contact.info.phone', 'संपर्क नंबर', 'home', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1080, 'hi', 'home.contact.info.email', 'ईमेल', 'home', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1081, 'hi', 'home.contact.address', 'बीजिंग के चाओयांग जिले में जियांगगुओ रोड नं. 88, मॉडर्न इंटरनेशनल बिल्डिंग टावर ए', 'home', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1082, 'hi', 'home.contact.phone', '400-888-9999', 'home', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1083, 'hi', 'home.contact.social.title', 'हमें फॉलो करें', 'home', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1084, 'hi', 'home.contact.form.title', 'सलाह और संदेश', 'home', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1085, 'hi', 'home.contact.form.name', 'नाम', 'home', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1086, 'hi', 'home.contact.form.namePlaceholder', 'कृपया अपना नाम दर्ज करें', 'home', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1087, 'hi', 'home.contact.form.phone', 'फोन नंबर', 'home', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1088, 'hi', 'home.contact.form.phonePlaceholder', 'कृपया अपना संपर्क नंबर दर्ज करें', 'home', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1089, 'hi', 'home.contact.form.email', 'ईमेल', 'home', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1090, 'hi', 'home.contact.form.emailPlaceholder', 'कृपया अपना ईमेल पता दर्ज करें', 'home', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1091, 'hi', 'home.contact.form.subject', 'सलाह का विषय', 'home', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1092, 'hi', 'home.contact.form.subjectPlaceholder', 'कृपया सलाह का विषय चुनें', 'home', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1093, 'hi', 'home.contact.form.subjectProduct', 'उत्पाद सलाह', 'home', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1094, 'hi', 'home.contact.form.subjectCooperation', 'सहयोग की चर्चा', 'home', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1095, 'hi', 'home.contact.form.subjectTechnical', 'तकनीकी सहायता', 'home', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1096, 'hi', 'home.contact.form.subjectOther', 'अन्य प्रश्न', 'home', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1097, 'hi', 'home.contact.form.message', 'संदेश का सामग्री', 'home', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1098, 'hi', 'home.contact.form.messagePlaceholder', 'कृपया अपना संदेश दर्ज करें', 'home', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1099, 'hi', 'home.contact.form.submit', 'संदेश सबमिट करें', 'home', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1100, 'hi', 'home.contact.form.submitting', 'सबमिट हो रहा है...', 'home', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1101, 'hi', 'home.contact.form.success', 'सफलतापूर्वक सबमिट हुआ! हम जल्द ही आपके साथ संपर्क करेंगे।', 'home', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1102, 'hi', 'home.contact.form.error', 'सबमिट करने में विफल, कृपया बाद में पुनः प्रयास करें', 'home', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1103, 'hi', 'home.contact.form.errorDetail', 'सबमिट करने में विफल, कृपया बाद में पुनः प्रयास करें', 'home', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1104, 'hi', 'footer.description', 'उद्यम डिजिटल समाधानों पर專註, तकनीकी नवाचार के माध्यम से उद्यम के विकास को चलाना', 'footer', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1105, 'hi', 'footer.quickLinks', 'त्वरित लिंक', 'footer', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1106, 'hi', 'footer.hotCategories', 'लोकप्रिय कॉलम', 'footer', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1107, 'hi', 'footer.contactUs', 'हमसे संपर्क करें', 'footer', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1108, 'hi', 'footer.address', 'बीजिंग के चाओयांग जिले में जियांगगुओ रोड नं. 88', 'footer', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1109, 'hi', 'footer.phone', '400-888-9999', 'footer', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1110, 'hi', 'footer.copyright', '© 2026 NodeForge. सभी अधिकार सुरक्षित हैं।', 'footer', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1111, 'hi', 'common.home', 'मुख्य पृष्ठ', 'common', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1112, 'hi', 'common.search', 'खोज', 'common', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1113, 'hi', 'common.aiSearch', 'AI इंटेलिजेंट खोज', 'common', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1114, 'hi', 'common.searching', 'खोज हो रही है...', 'common', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1115, 'hi', 'common.searchPlaceholder', 'खोज कीवर्ड दर्ज करें...', 'common', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1116, 'hi', 'common.newSearch', 'पुनः खोजें', 'common', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1117, 'hi', 'common.viewDetails', 'विवरण देखें', 'common', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1118, 'hi', 'common.prevPage', 'पिछला पृष्ठ', 'common', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1119, 'hi', 'common.nextPage', 'अगला पृष्ठ', 'common', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1120, 'hi', 'common.noData', 'कोई प्रासंगिक डेटा उपलब्ध नहीं', 'common', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1121, 'hi', 'common.noNews', 'कोई प्रासंगिक समाचार नहीं मिला, कृपया अन्य कीवर्ड आजमाएं', 'common', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1122, 'hi', 'common.noProducts', 'अभी तक कोई प्रासंगिक उत्पाद उपलब्ध नहीं, प्रतीक्षा करें', 'common', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1123, 'hi', 'common.loading', 'लोड हो रहा है...', 'common', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1124, 'hi', 'news.detail.category', 'वर्ग', 'news', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1125, 'hi', 'news.detail.publishTime', 'प्रकाशन का समय', 'news', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1126, 'hi', 'news.detail.viewCount', 'देखने की संख्या', 'news', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1127, 'hi', 'news.detail.prev', 'पिछला लेख', 'news', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1128, 'hi', 'news.detail.next', 'अगला लेख', 'news', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1129, 'hi', 'news.detail.prevEmpty', 'पिछला लेख: कोई नहीं', 'news', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1130, 'hi', 'news.detail.nextEmpty', 'अगला लेख: कोई नहीं', 'news', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1131, 'hi', 'news.detail.related', 'संबंधित सुझाव', 'news', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1132, 'hi', 'news.searchPlaceholder', 'समाचार कीवर्ड खोजें...', 'news', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1133, 'hi', 'news.aiSearchPlaceholder', 'कृपया वह चीज दर्ज करें जिसे आप खोजना चाहते हैं, उदाहरण के लिए: नवीनतम तकनीकी समाचार', 'news', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1134, 'hi', 'news.trySearch', 'खोज का प्रयास करें:', 'news', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1135, 'hi', 'news.suggestionLatest', 'नवीनतम समाचार', 'news', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1136, 'hi', 'news.suggestionHot', 'लोकप्रिय समाचार', 'news', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1137, 'hi', 'news.suggestionTech', 'तकनीकी समाचार', 'news', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1138, 'hi', 'news.suggestionProduct', 'उत्पाद जानकारी', 'news', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1139, 'hi', 'news.aiSearchTitle', 'AI इंटेलिजेंट खोज', 'news', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1140, 'hi', 'news.aiSearchDesc', 'प्राकृतिक भाषा में वह चीज वर्णन करें जिसे आप खोजना चाहते हैं, AI सबसे प्रासंगिक परिणामों से इंटेलिजेंट रूप से मेल खाएगा', 'news', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1141, 'hi', 'news.featureUnderstand', 'इंटेलिजेंट समझ', 'news', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1142, 'hi', 'news.featureUnderstandDesc', 'आपके खोज के इरादे को समझें, स्वचालित रूप से सबसे प्रासंगिक सामग्री से मेल खाएं', 'news', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1143, 'hi', 'news.featureSummarize', 'इंटेलिजेंट सारांश', 'news', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1144, 'hi', 'news.featureSummarizeDesc', 'AI स्वचालित रूप से खोज परिणामों का सारांश बनाता है, मुख्य जानकारी को तेजी से प्राप्त करें', 'news', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1145, 'hi', 'news.featureSuggest', 'इंटेलिजेंट सुझाव', 'news', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1146, 'hi', 'news.featureSuggestDesc', 'खोज परिणामों के आधार पर संबंधित सामग्री और अनुकूलन सुझाव प्रदान करें', 'news', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1147, 'hi', 'news.aiAnalyzing', 'AI आपके क्वेरी का विश्लेषण कर रहा है...', 'news', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1148, 'hi', 'news.aiAnalyzingDesc', 'खोज के इरादे को समझ रहा है, सामग्री का इंटेलिजेंट मिलान कर रहा है', 'news', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1149, 'hi', 'news.aiSummary', 'AI खोज सारांश', 'news', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1150, 'hi', 'news.aiSuggestions', 'इंटेलिजेंट सुझाव', 'news', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1151, 'hi', 'news.relatedSearches', 'संबंधित खोज', 'news', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1152, 'hi', 'news.searchResultsCount', '\"{keyword}\" के लिए {count} परिणाम मिले', 'news', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1153, 'hi', 'news.noResults', 'कोई प्रासंगिक सामग्री नहीं मिली', 'news', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1154, 'hi', 'news.noResultsDesc', 'कृपया अन्य कीवर्ड या अधिक सामान्य खोज मानदंडों का उपयोग करने का प्रयास करें', 'news', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1155, 'hi', 'news.searchError', 'खोज में विफल, कृपया बाद में पुनः प्रयास करें', 'news', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1156, 'hi', 'product.consultNow', 'अभी सलाह लें', 'product', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1157, 'hi', 'product.freeTrial', 'मुफ्त परीक्षण', 'product', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1158, 'hi', 'product.detailTitle', 'उत्पाद विवरण', 'product', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1159, 'hi', 'error.pageNotFound', 'पृष्ठ नहीं मिला', 'error', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1160, 'hi', 'error.categoryNotFound', 'यह कॉलम मौजूद नहीं है या प्रकाशित नहीं हुआ है', 'error', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1161, 'hi', 'error.backToHome', 'मुख्य पृष्ठ पर लौटें', 'error', 0, '', '', '2026-02-06 15:31:41', '', '2026-02-06 15:31:41');
INSERT INTO `i18n_translation` VALUES (1162, 'tr', 'site.name', 'NodeForgeCMS', 'site', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1163, 'tr', 'nav.home', 'Anasayfa', 'nav', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1164, 'tr', 'nav.news', 'Haberler', 'nav', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1165, 'tr', 'nav.products', 'Ürünler Merkezi', 'nav', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1166, 'tr', 'nav.language', 'Dil / 语言', 'nav', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1167, 'tr', 'home.banner.title', 'İnovasyon Teknolojisi · İşletme Gelişimini Güçlendirir', 'home', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1168, 'tr', 'home.banner.description', 'İşletme dijital çözümleri üzerine uzmanlaşmış, yüksek performanslı, ölçeklenebilir CMS sistemleri ve tam stack teknolojik hizmetler sunar', 'home', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1169, 'tr', 'home.banner.learnMore', 'Daha Fazlasını Öğrenin', 'home', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1170, 'tr', 'home.banner.viewProducts', 'Ürünleri Görüntüleyin', 'home', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1171, 'tr', 'home.products.title', 'Ürünler Merkezi', 'home', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1172, 'tr', 'home.products.description', 'Farklı senaryolardaki dijital ihtiyaçları karşılamak için zengin işletme seviyeli ürün çözümleri sunuyoruz', 'home', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1173, 'tr', 'home.products.viewDetails', 'Detayları Görüntüleyin', 'home', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1174, 'tr', 'home.news.title', 'Haberler Merkezi', 'home', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1175, 'tr', 'home.news.description', 'İşletmenin en son gelişmelerini, sektör haberlerini ve ürün güncellemelerini öğrenin', 'home', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1176, 'tr', 'home.news.readFull', 'Tam Makaleyi Oku', 'home', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1177, 'tr', 'home.news.viewMore', 'Daha Fazla Haber Görüntüleyin', 'home', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1178, 'tr', 'home.about.title', 'Şirket Hakkında', 'home', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1179, 'tr', 'home.about.subtitle', 'İşletme dijital çözümleri üzerine uzmanlaşmış, teknolojik inovasyon ile işletme gelişimini yönlendirir', 'home', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1180, 'tr', 'home.about.imageUrl', 'Şirket Hakkında', 'home', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1181, 'tr', 'home.about.intro1', 'NodeForge 20xx yılında kurulmuştur, işletme dijital çözümleri üzerine uzmanlaşmış bir teknoloji şirketidir. Çekirdek ekibimiz, önde gelen internet şirketlerinden ve yazılım hizmet sağlayıcılarından oluşur ve zengin işletme seviyeli ürün araştırma-geliştirme ve uygulama deneyimine sahiptir.', 'home', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1182, 'tr', 'home.about.intro2', 'Node.js ve Vue/Nuxt\'u çekirdek teknoloji stack olarak kullanarak, yüksek performanslı, kolayca ölçeklenebilir işletme seviyeli CMS sistemleri oluşturuyoruz. İşletmelerin dijital resmi web sitelerini ve içerik yönetim platformlarını hızlıca kurmalarına yardımcı olarak dijital dönüşüm maliyetlerini düşürüyoruz.', 'home', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1183, 'tr', 'home.about.intro3', 'Bugüne kadar, imalat, perakende, eğitim, kamu hizmetleri gibi çeşitli sektörlerde 500\'den fazla işletme müşterisine hizmet verdik ve stabil ürün performansı ile yüksek kaliteli hizmetlerimizle müşterilerimizin tamamen onayını kazandık.', 'home', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1184, 'tr', 'home.about.stats.partners', 'İş Ortağı İşletmeler', 'home', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1185, 'tr', 'home.about.stats.products', 'Çekirdek Ürünler', 'home', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1186, 'tr', 'home.about.stats.team', 'Teknik Ekip', 'home', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1187, 'tr', 'home.about.stats.satisfaction', 'Müşteri Memnuniyeti', 'home', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1188, 'tr', 'home.contact.title', 'Hakkımızda', 'home', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1189, 'tr', 'home.contact.subtitle', 'Daha fazla ürün bilgisi ve iş birliği planları için bizimle iletişime geçin', 'home', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1190, 'tr', 'home.contact.info.address', 'Şirket Adresi', 'home', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1191, 'tr', 'home.contact.info.phone', 'İletişim Telefonu', 'home', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1192, 'tr', 'home.contact.info.email', 'E-posta Adresi', 'home', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1193, 'tr', 'home.contact.address', 'A Blok, Modern Uluslararası Binası, 88 Jianguo Yolu, Çaoyang Bölgesi, Pekin', 'home', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1194, 'tr', 'home.contact.phone', '400-888-9999', 'home', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1195, 'tr', 'home.contact.social.title', 'Bizi Takip Edin', 'home', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1196, 'tr', 'home.contact.form.title', 'Danışma ve Mesaj', 'home', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1197, 'tr', 'home.contact.form.name', 'Ad Soyad', 'home', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1198, 'tr', 'home.contact.form.namePlaceholder', 'Lütfen ad soyadınızı girin', 'home', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1199, 'tr', 'home.contact.form.phone', 'Telefon', 'home', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1200, 'tr', 'home.contact.form.phonePlaceholder', 'Lütfen iletişim telefonunuzu girin', 'home', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1201, 'tr', 'home.contact.form.email', 'E-posta', 'home', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1202, 'tr', 'home.contact.form.emailPlaceholder', 'Lütfen e-posta adresinizi girin', 'home', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1203, 'tr', 'home.contact.form.subject', 'Danışma Konusu', 'home', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1204, 'tr', 'home.contact.form.subjectPlaceholder', 'Lütfen bir danışma konusu seçin', 'home', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1205, 'tr', 'home.contact.form.subjectProduct', 'Ürün Danışması', 'home', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1206, 'tr', 'home.contact.form.subjectCooperation', 'İş Birliği Görüşmesi', 'home', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1207, 'tr', 'home.contact.form.subjectTechnical', 'Teknik Destek', 'home', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1208, 'tr', 'home.contact.form.subjectOther', 'Diğer Sorular', 'home', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1209, 'tr', 'home.contact.form.message', 'Mesaj İçeriği', 'home', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1210, 'tr', 'home.contact.form.messagePlaceholder', 'Lütfen mesaj içeriğinizi girin', 'home', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1211, 'tr', 'home.contact.form.submit', 'Mesajı Gönder', 'home', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1212, 'tr', 'home.contact.form.submitting', 'Gönderiliyor...', 'home', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1213, 'tr', 'home.contact.form.success', 'Gönderildi! En kısa zamanda sizinle iletişime geçeceğiz.', 'home', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1214, 'tr', 'home.contact.form.error', 'Gönderim başarısız, lütfen daha sonra tekrar deneyin', 'home', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1215, 'tr', 'home.contact.form.errorDetail', 'Gönderim başarısız, lütfen daha sonra tekrar deneyin', 'home', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1216, 'tr', 'footer.description', 'İşletme dijital çözümleri üzerine uzmanlaşmış, teknolojik inovasyon ile işletme gelişimini yönlendirir', 'footer', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1217, 'tr', 'footer.quickLinks', 'Hızlı Bağlantılar', 'footer', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1218, 'tr', 'footer.hotCategories', 'Popüler Kategoriler', 'footer', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1219, 'tr', 'footer.contactUs', 'Bizimle İletişime Geçin', 'footer', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1220, 'tr', 'footer.address', '88 Jianguo Yolu, Çaoyang Bölgesi, Pekin', 'footer', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1221, 'tr', 'footer.phone', '400-888-9999', 'footer', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1222, 'tr', 'footer.copyright', '© 2026 NodeForge. Tüm hakları saklıdır.', 'footer', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1223, 'tr', 'common.home', 'Anasayfa', 'common', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1224, 'tr', 'common.search', 'Arama', 'common', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1225, 'tr', 'common.aiSearch', 'AI Akıllı Arama', 'common', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1226, 'tr', 'common.searching', 'Aranıyor...', 'common', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1227, 'tr', 'common.searchPlaceholder', 'Arama anahtar kelimeleri girin...', 'common', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1228, 'tr', 'common.newSearch', 'Yeniden Ara', 'common', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1229, 'tr', 'common.viewDetails', 'Detayları Görüntüleyin', 'common', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1230, 'tr', 'common.prevPage', 'Önceki Sayfa', 'common', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1231, 'tr', 'common.nextPage', 'Sonraki Sayfa', 'common', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1232, 'tr', 'common.noData', 'İlişkili veri bulunmuyor', 'common', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1233, 'tr', 'common.noNews', 'İlişkili haber bulunmuyor, lütfen farklı anahtar kelimeler deneyin', 'common', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1234, 'tr', 'common.noProducts', 'Henüz ilişkili ürün bulunmuyor, yakında geliyor', 'common', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1235, 'tr', 'common.loading', 'Yükleniyor...', 'common', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1236, 'tr', 'news.detail.category', 'Kategori', 'news', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1237, 'tr', 'news.detail.publishTime', 'Yayın Zamanı', 'news', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1238, 'tr', 'news.detail.viewCount', 'Görüntüleme Sayısı', 'news', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1239, 'tr', 'news.detail.prev', 'Önceki Makale', 'news', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1240, 'tr', 'news.detail.next', 'Sonraki Makale', 'news', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1241, 'tr', 'news.detail.prevEmpty', 'Önceki Makale: Yok', 'news', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1242, 'tr', 'news.detail.nextEmpty', 'Sonraki Makale: Yok', 'news', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1243, 'tr', 'news.detail.related', 'İlişkili Öneriler', 'news', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1244, 'tr', 'news.searchPlaceholder', 'Haber anahtar kelimeleri ara...', 'news', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1245, 'tr', 'news.aiSearchPlaceholder', 'Bulmak istediğiniz içeriği girin, örn: En son teknoloji haberleri', 'news', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1246, 'tr', 'news.trySearch', 'Şunları deneyin:', 'news', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1247, 'tr', 'news.suggestionLatest', 'En Son Haberler', 'news', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1248, 'tr', 'news.suggestionHot', 'Popüler Haberler', 'news', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1249, 'tr', 'news.suggestionTech', 'Teknoloji Haberleri', 'news', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1250, 'tr', 'news.suggestionProduct', 'Ürün Bilgileri', 'news', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1251, 'tr', 'news.aiSearchTitle', 'AI Akıllı Arama', 'news', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1252, 'tr', 'news.aiSearchDesc', 'Bulmak istediğiniz içeriği doğal dil ile tanımlayın, AI en alakalı sonuçları akıllıca eşleştirecektir', 'news', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1253, 'tr', 'news.featureUnderstand', 'Akıllı Anlama', 'news', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1254, 'tr', 'news.featureUnderstandDesc', 'Arama niyetini anlar, otomatik olarak en alakalı içeriği eşleştirir', 'news', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1255, 'tr', 'news.featureSummarize', 'Akıllı Özetleme', 'news', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1256, 'tr', 'news.featureSummarizeDesc', 'AI, arama sonuçlarını otomatik olarak özetler, temel bilgileri hızlıca öğrenin', 'news', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1257, 'tr', 'news.featureSuggest', 'Akıllı Öneri', 'news', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1258, 'tr', 'news.featureSuggestDesc', 'Arama sonuçlarına dayalı ilişkili içerik ve optimizasyon önerileri sunar', 'news', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1259, 'tr', 'news.aiAnalyzing', 'AI sorgunuzu analiz ediyor...', 'news', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1260, 'tr', 'news.aiAnalyzingDesc', 'Arama niyeti anlaşılıyor, içerik akıllıca eşleştiriliyor', 'news', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1261, 'tr', 'news.aiSummary', 'AI Arama Özeti', 'news', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1262, 'tr', 'news.aiSuggestions', 'Akıllı Öneriler', 'news', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1263, 'tr', 'news.relatedSearches', 'İlişkili Aramalar', 'news', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1264, 'tr', 'news.searchResultsCount', '\"{keyword}\" için {count} sonuç bulundu', 'news', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1265, 'tr', 'news.noResults', 'İlişkili içerik bulunamadı', 'news', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1266, 'tr', 'news.noResultsDesc', 'Lütfen diğer anahtar kelimeler veya daha genel arama koşulları kullanmayı deneyin', 'news', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1267, 'tr', 'news.searchError', 'Arama başarısız, lütfen daha sonra tekrar deneyin', 'news', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1268, 'tr', 'product.consultNow', 'Hemen Danışın', 'product', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1269, 'tr', 'product.freeTrial', 'Ücretsiz Deneme', 'product', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1270, 'tr', 'product.detailTitle', 'Ürün Detayları Tanıtımı', 'product', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1271, 'tr', 'error.pageNotFound', 'Sayfa Bulunamadı', 'error', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1272, 'tr', 'error.categoryNotFound', 'Bu kategori mevcut değil veya yayınlanmadı', 'error', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1273, 'tr', 'error.backToHome', 'Anasayfaya Dön', 'error', 0, '', '', '2026-02-06 15:37:52', '', '2026-02-06 15:37:52');
INSERT INTO `i18n_translation` VALUES (1274, 'ja', 'site.name', 'NodeForgeCMS', 'site', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1275, 'ja', 'nav.home', 'ホーム', 'nav', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1276, 'ja', 'nav.news', 'ニュース', 'nav', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1277, 'ja', 'nav.products', '製品センター', 'nav', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1278, 'ja', 'nav.language', '言語 / Language', 'nav', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1279, 'ja', 'home.banner.title', 'イノベーションテクノロジー・企業発展を強力にサポート', 'home', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1280, 'ja', 'home.banner.description', '企業デジタルソリューションに特化し、高性能・スケーラブルなCMSシステムとフルスタック技術サービスを提供', 'home', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1281, 'ja', 'home.banner.learnMore', '詳細を見る', 'home', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1282, 'ja', 'home.banner.viewProducts', '製品を閲覧', 'home', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1283, 'ja', 'home.products.title', '製品センター', 'home', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1284, 'ja', 'home.products.description', '多様なシナリオのデジタルニーズに応える、充実したエンタープライズレベルの製品ソリューションを提供', 'home', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1285, 'ja', 'home.products.viewDetails', '詳細を閲覧', 'home', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1286, 'ja', 'home.news.title', 'ニュースセンター', 'home', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1287, 'ja', 'home.news.description', '企業の最新情報、業界ニュース、製品アップデートをいち早くゲット', 'home', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1288, 'ja', 'home.news.readFull', '全文を読む', 'home', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1289, 'ja', 'home.news.viewMore', 'もっとニュースを見る', 'home', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1290, 'ja', 'home.about.title', '企業紹介', 'home', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1291, 'ja', 'home.about.subtitle', '企業デジタルソリューションに特化、技術イノベーションで企業発展をけん引', 'home', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1292, 'ja', 'home.about.imageUrl', '企業紹介', 'home', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1293, 'ja', 'home.about.intro1', 'NodeForgeは20xx年に設立され、企業デジタルソリューションに特化したテクノロジーカンパニーです。コアチームはトップクラスのインターネット企業やソフトウェアサービスプロバイダーから集結し、豊富なエンタープライズレベル製品の研究開発・導入実績を持っています。', 'home', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1294, 'ja', 'home.about.intro2', 'Node.jsおよびVue/Nuxtをコアテクノロジースタックとし、高性能・拡張容易なエンタープライズレベルCMSシステムを構築。企業がデジタルオフィシャルサイトやコンテンツ管理プラットフォームを迅速に構築することを支援し、デジタルトランスフォーメーションのコストを削減します。', 'home', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1295, 'ja', 'home.about.intro3', '現在までに、製造業・小売業・教育業・行政サービスなど複数の業種にわたる500社以上の企業クライアントにサービスを提供し、安定した製品パフォーマンスと高クオリティなサービスで、クライアントから高い評価を得ています。', 'home', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1296, 'ja', 'home.about.stats.partners', '連携企業', 'home', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1297, 'ja', 'home.about.stats.products', 'コア製品', 'home', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1298, 'ja', 'home.about.stats.team', '技術チーム', 'home', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1299, 'ja', 'home.about.stats.satisfaction', '顧客満足度', 'home', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1300, 'ja', 'home.contact.title', '会社について', 'home', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1301, 'ja', 'home.contact.subtitle', '製品情報や連携プランの詳細については、お問い合わせください', 'home', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1302, 'ja', 'home.contact.info.address', '本社住所', 'home', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1303, 'ja', 'home.contact.info.phone', 'お問い合わせ電話', 'home', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1304, 'ja', 'home.contact.info.email', 'メールアドレス', 'home', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1305, 'ja', 'home.contact.address', '北京市朝陽区建国路88番地 モダンインターナショナルビルA棟', 'home', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1306, 'ja', 'home.contact.phone', '400-888-9999', 'home', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1307, 'ja', 'home.contact.social.title', 'フォローしてください', 'home', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1308, 'ja', 'home.contact.form.title', 'お問い合わせフォーム', 'home', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1309, 'ja', 'home.contact.form.name', 'お名前', 'home', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1310, 'ja', 'home.contact.form.namePlaceholder', 'お名前を入力してください', 'home', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1311, 'ja', 'home.contact.form.phone', '電話番号', 'home', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1312, 'ja', 'home.contact.form.phonePlaceholder', '連絡先の電話番号を入力してください', 'home', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1313, 'ja', 'home.contact.form.email', 'メールアドレス', 'home', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1314, 'ja', 'home.contact.form.emailPlaceholder', 'メールアドレスを入力してください', 'home', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1315, 'ja', 'home.contact.form.subject', 'お問い合わせテーマ', 'home', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1316, 'ja', 'home.contact.form.subjectPlaceholder', 'お問い合わせテーマを選択してください', 'home', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1317, 'ja', 'home.contact.form.subjectProduct', '製品に関するお問い合わせ', 'home', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1318, 'ja', 'home.contact.form.subjectCooperation', '業務連携の商談', 'home', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1319, 'ja', 'home.contact.form.subjectTechnical', '技術サポート', 'home', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1320, 'ja', 'home.contact.form.subjectOther', 'その他の質問', 'home', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1321, 'ja', 'home.contact.form.message', 'お問い合わせ内容', 'home', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1322, 'ja', 'home.contact.form.messagePlaceholder', 'お問い合わせ内容を入力してください', 'home', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1323, 'ja', 'home.contact.form.submit', '送信', 'home', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1324, 'ja', 'home.contact.form.submitting', '送信中...', 'home', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1325, 'ja', 'home.contact.form.success', '送信が完了しました！最速でご連絡いたします。', 'home', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1326, 'ja', 'home.contact.form.error', '送信に失敗しました、後ほど再試行してください', 'home', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1327, 'ja', 'home.contact.form.errorDetail', '送信に失敗しました、後ほど再試行してください', 'home', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1328, 'ja', 'footer.description', '企業デジタルソリューションに特化、技術イノベーションで企業発展をけん引', 'footer', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1329, 'ja', 'footer.quickLinks', 'クイックリンク', 'footer', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1330, 'ja', 'footer.hotCategories', '人気カテゴリー', 'footer', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1331, 'ja', 'footer.contactUs', 'お問い合わせ', 'footer', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1332, 'ja', 'footer.address', '北京市朝陽区建国路88番地', 'footer', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1333, 'ja', 'footer.phone', '400-888-9999', 'footer', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1334, 'ja', 'footer.copyright', '© 2026 NodeForge. 全著作権所有。', 'footer', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1335, 'ja', 'common.home', 'ホーム', 'common', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1336, 'ja', 'common.search', '検索', 'common', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1337, 'ja', 'common.aiSearch', 'AIスマート検索', 'common', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1338, 'ja', 'common.searching', '検索中...', 'common', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1339, 'ja', 'common.searchPlaceholder', '検索キーワードを入力...', 'common', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1340, 'ja', 'common.newSearch', '再検索', 'common', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1341, 'ja', 'common.viewDetails', '詳細を閲覧', 'common', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1342, 'ja', 'common.prevPage', '前のページ', 'common', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1343, 'ja', 'common.nextPage', '次のページ', 'common', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1344, 'ja', 'common.noData', '関連データはありません', 'common', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1345, 'ja', 'common.noNews', '関連ニュースはありません、他のキーワードで試してください', 'common', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1346, 'ja', 'common.noProducts', '現在、関連製品は準備中です、お待ちください', 'common', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1347, 'ja', 'common.loading', '読み込み中...', 'common', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1348, 'ja', 'news.detail.category', 'カテゴリー', 'news', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1349, 'ja', 'news.detail.publishTime', '公開日時', 'news', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1350, 'ja', 'news.detail.viewCount', '閲覧数', 'news', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1351, 'ja', 'news.detail.prev', '前の記事', 'news', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1352, 'ja', 'news.detail.next', '次の記事', 'news', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1353, 'ja', 'news.detail.prevEmpty', '前の記事：なし', 'news', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1354, 'ja', 'news.detail.nextEmpty', '次の記事：なし', 'news', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1355, 'ja', 'news.detail.related', '関連記事推奨', 'news', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1356, 'ja', 'news.searchPlaceholder', 'ニュースキーワードを検索...', 'news', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1357, 'ja', 'news.aiSearchPlaceholder', '検索したい内容を入力してください、例：最新のテクノロジーニュース', 'news', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1358, 'ja', 'news.trySearch', '検索例：', 'news', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1359, 'ja', 'news.suggestionLatest', '最新ニュース', 'news', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1360, 'ja', 'news.suggestionHot', '人気ニュース', 'news', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1361, 'ja', 'news.suggestionTech', 'テクノロジーニュース', 'news', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1362, 'ja', 'news.suggestionProduct', '製品情報', 'news', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1363, 'ja', 'news.aiSearchTitle', 'AIスマート検索', 'news', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1364, 'ja', 'news.aiSearchDesc', '自然言語で検索したい内容を記述すると、AIが最も関連性の高い結果をインテリジェントにマッチング', 'news', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1365, 'ja', 'news.featureUnderstand', 'インテリジェント理解', 'news', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1366, 'ja', 'news.featureUnderstandDesc', '検索意図を理解し、自動的に最も関連性の高いコンテンツをマッチング', 'news', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1367, 'ja', 'news.featureSummarize', 'インテリジェントサマリー', 'news', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1368, 'ja', 'news.featureSummarizeDesc', 'AIが検索結果を自動的にまとめ、コア情報を迅速に把握', 'news', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1369, 'ja', 'news.featureSuggest', 'インテリジェント推奨', 'news', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1370, 'ja', 'news.featureSuggestDesc', '検索結果に基づき、関連コンテンツと最適化提案を推奨', 'news', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1371, 'ja', 'news.aiAnalyzing', 'AIがクエリを分析中...', 'news', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1372, 'ja', 'news.aiAnalyzingDesc', '検索意図を理解中、コンテンツをインテリジェントにマッチング', 'news', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1373, 'ja', 'news.aiSummary', 'AI検索サマリー', 'news', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1374, 'ja', 'news.aiSuggestions', 'インテリジェント提案', 'news', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1375, 'ja', 'news.relatedSearches', '関連検索', 'news', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1376, 'ja', 'news.searchResultsCount', '\"{keyword}\" に関する結果 {count} 件が見つかりました', 'news', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1377, 'ja', 'news.noResults', '関連コンテンツは見つかりませんでした', 'news', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1378, 'ja', 'news.noResultsDesc', '他のキーワードまたはより汎用的な検索条件を試してください', 'news', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1379, 'ja', 'news.searchError', '検索に失敗しました、後ほど再試行してください', 'news', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1380, 'ja', 'product.consultNow', '今すぐお問い合わせ', 'product', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1381, 'ja', 'product.freeTrial', '無料トライアル', 'product', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1382, 'ja', 'product.detailTitle', '製品詳細紹介', 'product', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1383, 'ja', 'error.pageNotFound', 'ページが見つかりません', 'error', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1384, 'ja', 'error.categoryNotFound', 'このカテゴリーは存在しないか、公開されていません', 'error', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
INSERT INTO `i18n_translation` VALUES (1385, 'ja', 'error.backToHome', 'ホームに戻る', 'error', 0, '', '', '2026-02-06 15:51:59', '', '2026-02-06 15:51:59');
COMMIT;

-- ----------------------------
-- Table structure for job
-- ----------------------------
DROP TABLE IF EXISTS `job`;
CREATE TABLE `job` (
  `job_id` int NOT NULL AUTO_INCREMENT,
  `job_name` varchar(64) NOT NULL,
  `job_group` varchar(64) DEFAULT 'DEFAULT',
  `invoke_target` varchar(225) NOT NULL,
  `cron_expression` varchar(225) NOT NULL,
  `misfire_policy` varchar(20) DEFAULT '3',
  `concurrent` varchar(1) DEFAULT '1',
  `status` varchar(1) DEFAULT '0',
  `remark` varchar(500) DEFAULT '',
  `create_by` varchar(64) DEFAULT '',
  `create_time` datetime DEFAULT NULL,
  `update_by` varchar(64) DEFAULT '',
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`job_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for job_log
-- ----------------------------
DROP TABLE IF EXISTS `job_log`;
CREATE TABLE `job_log` (
  `job_log_id` int NOT NULL AUTO_INCREMENT,
  `job_name` varchar(64) DEFAULT NULL,
  `job_group` varchar(64) DEFAULT NULL,
  `invoke_target` varchar(500) DEFAULT NULL,
  `job_message` varchar(500) DEFAULT '',
  `status` varchar(1) DEFAULT '0',
  `exception_info` varchar(2000) DEFAULT '',
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`job_log_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12217 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of job_log
-- ----------------------------
BEGIN;
INSERT INTO `job_log` VALUES (12173, '生成周排名(每30分钟执行一次)', 'DEFAULT', 'generateWeeklyStatistics()', '启动任务成功', '0', '', '2026-01-06 02:29:32');
INSERT INTO `job_log` VALUES (12174, '生成月排名(每30分钟执行一次)', 'DEFAULT', 'generateMonthStatistics()', '启动任务成功', '0', '', '2026-01-06 02:29:32');
INSERT INTO `job_log` VALUES (12175, '生成年排名(每天零点执行一次)', 'DEFAULT', 'generateYearStatistics()', '启动任务成功', '0', '', '2026-01-06 02:29:32');
INSERT INTO `job_log` VALUES (12176, '兑换券状态定时变更', 'DEFAULT', 'updateExpiredCoupons()', '启动任务成功', '0', '', '2026-01-06 02:29:32');
INSERT INTO `job_log` VALUES (12177, '邀请奖励发放任务', 'DEFAULT', 'processInviteRewards()', '启动任务成功', '0', '', '2026-01-06 02:29:32');
INSERT INTO `job_log` VALUES (12178, '生成周排名(每30分钟执行一次)', 'DEFAULT', 'generateWeeklyStatistics()', '执行任务成功', '0', '', '2026-01-06 02:30:00');
INSERT INTO `job_log` VALUES (12179, '生成月排名(每30分钟执行一次)', 'DEFAULT', 'generateMonthStatistics()', '执行任务成功', '0', '', '2026-01-06 02:31:00');
INSERT INTO `job_log` VALUES (12180, '生成周排名(每30分钟执行一次)', 'DEFAULT', 'generateWeeklyStatistics()', '启动任务成功', '0', '', '2026-01-06 03:11:13');
INSERT INTO `job_log` VALUES (12181, '生成月排名(每30分钟执行一次)', 'DEFAULT', 'generateMonthStatistics()', '启动任务成功', '0', '', '2026-01-06 03:11:13');
INSERT INTO `job_log` VALUES (12182, '生成年排名(每天零点执行一次)', 'DEFAULT', 'generateYearStatistics()', '启动任务成功', '0', '', '2026-01-06 03:11:13');
INSERT INTO `job_log` VALUES (12183, '兑换券状态定时变更', 'DEFAULT', 'updateExpiredCoupons()', '启动任务成功', '0', '', '2026-01-06 03:11:13');
INSERT INTO `job_log` VALUES (12184, '邀请奖励发放任务', 'DEFAULT', 'processInviteRewards()', '启动任务成功', '0', '', '2026-01-06 03:11:13');
INSERT INTO `job_log` VALUES (12185, '生成周排名(每30分钟执行一次)', 'DEFAULT', 'generateWeeklyStatistics()', '执行任务成功', '0', '', '2026-01-06 03:30:00');
INSERT INTO `job_log` VALUES (12186, '生成月排名(每30分钟执行一次)', 'DEFAULT', 'generateMonthStatistics()', '执行任务成功', '0', '', '2026-01-06 03:31:00');
INSERT INTO `job_log` VALUES (12187, '生成周排名(每30分钟执行一次)', 'DEFAULT', 'generateWeeklyStatistics()', '启动任务成功', '0', '', '2026-01-06 03:33:15');
INSERT INTO `job_log` VALUES (12188, '生成月排名(每30分钟执行一次)', 'DEFAULT', 'generateMonthStatistics()', '启动任务成功', '0', '', '2026-01-06 03:33:15');
INSERT INTO `job_log` VALUES (12189, '生成年排名(每天零点执行一次)', 'DEFAULT', 'generateYearStatistics()', '启动任务成功', '0', '', '2026-01-06 03:33:15');
INSERT INTO `job_log` VALUES (12190, '兑换券状态定时变更', 'DEFAULT', 'updateExpiredCoupons()', '启动任务成功', '0', '', '2026-01-06 03:33:15');
INSERT INTO `job_log` VALUES (12191, '邀请奖励发放任务', 'DEFAULT', 'processInviteRewards()', '启动任务成功', '0', '', '2026-01-06 03:33:15');
INSERT INTO `job_log` VALUES (12192, '生成周排名(每30分钟执行一次)', 'DEFAULT', 'generateWeeklyStatistics()', '启动任务成功', '0', '', '2026-01-06 03:34:00');
INSERT INTO `job_log` VALUES (12193, '生成月排名(每30分钟执行一次)', 'DEFAULT', 'generateMonthStatistics()', '启动任务成功', '0', '', '2026-01-06 03:34:00');
INSERT INTO `job_log` VALUES (12194, '生成年排名(每天零点执行一次)', 'DEFAULT', 'generateYearStatistics()', '启动任务成功', '0', '', '2026-01-06 03:34:00');
INSERT INTO `job_log` VALUES (12195, '兑换券状态定时变更', 'DEFAULT', 'updateExpiredCoupons()', '启动任务成功', '0', '', '2026-01-06 03:34:00');
INSERT INTO `job_log` VALUES (12196, '邀请奖励发放任务', 'DEFAULT', 'processInviteRewards()', '启动任务成功', '0', '', '2026-01-06 03:34:00');
INSERT INTO `job_log` VALUES (12197, '生成周排名(每30分钟执行一次)', 'DEFAULT', 'generateWeeklyStatistics()', '启动任务成功', '0', '', '2026-01-06 03:36:40');
INSERT INTO `job_log` VALUES (12198, '生成月排名(每30分钟执行一次)', 'DEFAULT', 'generateMonthStatistics()', '启动任务成功', '0', '', '2026-01-06 03:36:40');
INSERT INTO `job_log` VALUES (12199, '生成年排名(每天零点执行一次)', 'DEFAULT', 'generateYearStatistics()', '启动任务成功', '0', '', '2026-01-06 03:36:40');
INSERT INTO `job_log` VALUES (12200, '兑换券状态定时变更', 'DEFAULT', 'updateExpiredCoupons()', '启动任务成功', '0', '', '2026-01-06 03:36:40');
INSERT INTO `job_log` VALUES (12201, '邀请奖励发放任务', 'DEFAULT', 'processInviteRewards()', '启动任务成功', '0', '', '2026-01-06 03:36:40');
INSERT INTO `job_log` VALUES (12202, '生成周排名(每30分钟执行一次)', 'DEFAULT', 'generateWeeklyStatistics()', '启动任务成功', '0', '', '2026-01-27 01:48:24');
INSERT INTO `job_log` VALUES (12203, '生成月排名(每30分钟执行一次)', 'DEFAULT', 'generateMonthStatistics()', '启动任务成功', '0', '', '2026-01-27 01:48:24');
INSERT INTO `job_log` VALUES (12204, '生成年排名(每天零点执行一次)', 'DEFAULT', 'generateYearStatistics()', '启动任务成功', '0', '', '2026-01-27 01:48:24');
INSERT INTO `job_log` VALUES (12205, '兑换券状态定时变更', 'DEFAULT', 'updateExpiredCoupons()', '启动任务成功', '0', '', '2026-01-27 01:48:24');
INSERT INTO `job_log` VALUES (12206, '邀请奖励发放任务', 'DEFAULT', 'processInviteRewards()', '启动任务成功', '0', '', '2026-01-27 01:48:24');
INSERT INTO `job_log` VALUES (12207, '生成周排名(每30分钟执行一次)', 'DEFAULT', 'generateWeeklyStatistics()', '启动任务成功', '0', '', '2026-01-27 01:48:36');
INSERT INTO `job_log` VALUES (12208, '生成月排名(每30分钟执行一次)', 'DEFAULT', 'generateMonthStatistics()', '启动任务成功', '0', '', '2026-01-27 01:48:36');
INSERT INTO `job_log` VALUES (12209, '生成年排名(每天零点执行一次)', 'DEFAULT', 'generateYearStatistics()', '启动任务成功', '0', '', '2026-01-27 01:48:36');
INSERT INTO `job_log` VALUES (12210, '兑换券状态定时变更', 'DEFAULT', 'updateExpiredCoupons()', '启动任务成功', '0', '', '2026-01-27 01:48:36');
INSERT INTO `job_log` VALUES (12211, '邀请奖励发放任务', 'DEFAULT', 'processInviteRewards()', '启动任务成功', '0', '', '2026-01-27 01:48:36');
INSERT INTO `job_log` VALUES (12212, '生成周排名(每30分钟执行一次)', 'DEFAULT', 'generateWeeklyStatistics()', '启动任务成功', '0', '', '2026-01-27 01:48:42');
INSERT INTO `job_log` VALUES (12213, '生成月排名(每30分钟执行一次)', 'DEFAULT', 'generateMonthStatistics()', '启动任务成功', '0', '', '2026-01-27 01:48:42');
INSERT INTO `job_log` VALUES (12214, '生成年排名(每天零点执行一次)', 'DEFAULT', 'generateYearStatistics()', '启动任务成功', '0', '', '2026-01-27 01:48:42');
INSERT INTO `job_log` VALUES (12215, '兑换券状态定时变更', 'DEFAULT', 'updateExpiredCoupons()', '启动任务成功', '0', '', '2026-01-27 01:48:42');
INSERT INTO `job_log` VALUES (12216, '邀请奖励发放任务', 'DEFAULT', 'processInviteRewards()', '启动任务成功', '0', '', '2026-01-27 01:48:42');
COMMIT;

-- ----------------------------
-- Table structure for json_config
-- ----------------------------
DROP TABLE IF EXISTS `json_config`;
CREATE TABLE `json_config` (
  `json_config_id` int NOT NULL AUTO_INCREMENT,
  `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '',
  `configValue` json DEFAULT (_utf8mb4'{}'),
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '',
  `create_time` datetime DEFAULT NULL,
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '',
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`json_config_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Table structure for login_info
-- ----------------------------
DROP TABLE IF EXISTS `login_info`;
CREATE TABLE `login_info` (
  `info_id` int NOT NULL AUTO_INCREMENT,
  `user_name` varchar(50) NOT NULL DEFAULT '',
  `ipaddr` varchar(128) NOT NULL DEFAULT '',
  `login_location` varchar(255) NOT NULL DEFAULT '',
  `browser` varchar(50) NOT NULL DEFAULT '',
  `os` varchar(50) NOT NULL DEFAULT '',
  `status` char(1) NOT NULL DEFAULT '0',
  `msg` text NOT NULL DEFAULT (_utf8mb4''),
  `login_time` datetime NOT NULL,
  PRIMARY KEY (`info_id`)
) ENGINE=InnoDB AUTO_INCREMENT=470 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of login_info
-- ----------------------------
BEGIN;
INSERT INTO `login_info` VALUES (53, 'admin', '104.168.83.13', '未知', 'Chrome136', 'macOS10.15.7', '0', '登录成功', '2025-04-11 09:19:47');
INSERT INTO `login_info` VALUES (54, 'admin', '119.39.23.70', '未知', 'Chrome134', 'macOS10.15.7', '0', '登录成功', '2025-04-11 09:21:14');
INSERT INTO `login_info` VALUES (55, 'admin', '119.39.23.70', '湖南省 长沙市', 'Chrome134', 'macOS10.15.7', '0', '登录成功', '2025-04-11 09:31:05');
INSERT INTO `login_info` VALUES (56, 'admin', '120.227.33.125', '湖南省 长沙市', 'Chrome134', 'macOS10.15.7', '0', '登录成功', '2025-04-11 12:12:44');
INSERT INTO `login_info` VALUES (57, 'admin', '120.36.110.183', '福建省 福州市', 'Chrome128', 'Windows10', '0', '登录成功', '2025-04-11 14:05:22');
INSERT INTO `login_info` VALUES (58, 'admin', '120.227.33.125', '湖南省 长沙市', 'Chrome134', 'macOS10.15.7', '0', '登录成功', '2025-04-11 14:12:40');
INSERT INTO `login_info` VALUES (59, 'admin', '40.160.230.146', ' ', 'Edge135', 'Windows10', '0', '登录成功', '2025-04-11 14:26:11');
INSERT INTO `login_info` VALUES (60, 'admin', '183.192.61.170', '上海市 上海市', 'Quark7', 'Android15', '0', '登录成功', '2025-04-11 14:34:24');
INSERT INTO `login_info` VALUES (61, 'laoying', '120.227.33.125', '湖南省 长沙市', 'Chrome134', 'macOS10.15.7', '0', '登录成功', '2025-04-11 15:35:48');
INSERT INTO `login_info` VALUES (62, 'admin', '120.227.33.125', '湖南省 长沙市', 'Chrome134', 'macOS10.15.7', '0', '登录成功', '2025-04-11 15:36:08');
INSERT INTO `login_info` VALUES (63, 'laoying', '120.227.33.125', '湖南省 长沙市', 'Chrome134', 'macOS10.15.7', '1', '验证码错误', '2025-04-11 15:38:01');
INSERT INTO `login_info` VALUES (64, 'laoying', '120.227.33.125', '湖南省 长沙市', 'Chrome134', 'macOS10.15.7', '0', '登录成功', '2025-04-11 15:38:04');
INSERT INTO `login_info` VALUES (65, 'admin', '120.227.33.125', '湖南省 长沙市', 'Chrome134', 'macOS10.15.7', '0', '登录成功', '2025-04-11 15:44:47');
INSERT INTO `login_info` VALUES (66, 'laoying', '120.227.33.125', '湖南省 长沙市', 'Chrome134', 'macOS10.15.7', '0', '登录成功', '2025-04-11 15:45:10');
INSERT INTO `login_info` VALUES (67, 'admin', '183.218.163.107', '江西省 南昌市', 'Chrome129', 'Windows10', '1', '验证码错误', '2025-04-11 16:37:11');
INSERT INTO `login_info` VALUES (68, 'admin', '183.218.163.107', '江西省 南昌市', 'Chrome129', 'Windows10', '1', '验证码错误', '2025-04-11 16:37:13');
INSERT INTO `login_info` VALUES (69, 'admin', '183.218.163.107', '江西省 南昌市', 'Chrome129', 'Windows10', '0', '登录成功', '2025-04-11 16:37:16');
INSERT INTO `login_info` VALUES (70, 'admin', '103.251.98.212', '广西 南宁市', 'Mobile Safari16', 'iOS16.7.10', '0', '登录成功', '2025-04-11 17:18:06');
INSERT INTO `login_info` VALUES (71, 'laoying', '120.227.33.125', '湖南省 长沙市', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-04-12 02:02:33');
INSERT INTO `login_info` VALUES (72, 'admin', '103.251.98.212', '广西 南宁市', 'QQBrowser13', 'Windows10', '0', '登录成功', '2025-04-12 03:14:19');
INSERT INTO `login_info` VALUES (73, 'admin', '103.251.98.212', '广西 南宁市', 'QQBrowser13', 'Windows10', '0', '登录成功', '2025-04-12 05:44:18');
INSERT INTO `login_info` VALUES (74, 'admin', '183.228.72.133', '重庆市 重庆市', 'Chrome120', 'Windows10', '0', '登录成功', '2025-04-12 09:20:25');
INSERT INTO `login_info` VALUES (75, 'admin', '104.243.21.220', ' ', 'Edge135', 'Windows10', '0', '登录成功', '2025-04-12 13:49:56');
INSERT INTO `login_info` VALUES (76, 'admin', '117.139.195.71', '四川省 成都市', 'Chrome135', 'Windows10', '0', '登录成功', '2025-04-12 14:47:06');
INSERT INTO `login_info` VALUES (77, 'laoying', '120.227.33.125', '湖南省 长沙市', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-04-13 06:17:46');
INSERT INTO `login_info` VALUES (78, 'admin', '111.49.39.90', '宁夏 银川市', 'Edge135', 'Windows10', '0', '登录成功', '2025-04-13 09:28:03');
INSERT INTO `login_info` VALUES (79, 'admin', '60.10.194.247', '河北省 廊坊市', 'Edge126', 'Windows10', '0', '登录成功', '2025-04-13 13:01:06');
INSERT INTO `login_info` VALUES (80, 'admin', '58.241.71.200', '江苏省 常州市', 'Mobile Safari18', 'iOS18.3.2', '0', '登录成功', '2025-04-14 00:29:39');
INSERT INTO `login_info` VALUES (81, 'laoying', '118.248.140.178', '湖南省 邵阳市', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-04-14 01:32:56');
INSERT INTO `login_info` VALUES (82, 'admin', '219.157.191.136', '河南省 郑州市', 'Edge135', 'Windows10', '0', '登录成功', '2025-04-14 01:37:19');
INSERT INTO `login_info` VALUES (83, 'laoying', '118.248.140.178', '湖南省 邵阳市', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-04-14 05:52:09');
INSERT INTO `login_info` VALUES (84, 'admin', '171.15.167.94', '河南省 郑州市', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-04-14 06:02:50');
INSERT INTO `login_info` VALUES (85, 'admin', '222.223.124.192', '河北省 邢台市', 'Edge135', 'Windows10', '0', '登录成功', '2025-04-14 08:01:05');
INSERT INTO `login_info` VALUES (86, 'admin', '173.214.27.106', ' ', 'Chrome135', 'Windows10', '0', '登录成功', '2025-04-14 09:27:15');
INSERT INTO `login_info` VALUES (87, 'admin', '114.96.41.113', '安徽省 马鞍山市', 'Edge135', 'Windows10', '0', '登录成功', '2025-04-14 10:35:12');
INSERT INTO `login_info` VALUES (88, 'admin', '120.229.210.102', '广东省 揭阳市', 'Edge134', 'macOS10.15.7', '0', '登录成功', '2025-04-14 11:37:46');
INSERT INTO `login_info` VALUES (89, 'eagle', '120.227.33.125', '湖南省 长沙市', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-04-14 13:46:45');
INSERT INTO `login_info` VALUES (90, 'admin', '120.227.33.125', '湖南省 长沙市', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-04-14 13:46:59');
INSERT INTO `login_info` VALUES (91, 'laoying', '120.227.33.125', '湖南省 长沙市', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-04-14 13:47:34');
INSERT INTO `login_info` VALUES (92, 'eagle', '120.227.33.125', '湖南省 长沙市', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-04-14 13:47:55');
INSERT INTO `login_info` VALUES (93, 'admin', '175.152.112.196', '四川省 成都市', 'Chrome133', 'Windows10', '0', '登录成功', '2025-04-14 13:53:45');
INSERT INTO `login_info` VALUES (94, 'laoying', '120.227.33.125', '湖南省 长沙市', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-04-14 14:47:25');
INSERT INTO `login_info` VALUES (95, 'admin', '58.101.247.41', '浙江省 杭州市', 'Chrome135', 'Windows10', '0', '登录成功', '2025-04-14 15:15:06');
INSERT INTO `login_info` VALUES (96, 'admin', '183.135.227.233', '浙江省 宁波市', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-04-14 15:39:19');
INSERT INTO `login_info` VALUES (97, 'admin', '117.189.20.33', '贵州省 贵阳市', 'Chrome120', 'Windows10', '0', '登录成功', '2025-04-14 17:22:38');
INSERT INTO `login_info` VALUES (98, 'admin', '113.249.239.31', '重庆市 重庆市', 'Chrome136', 'Windows10', '0', '登录成功', '2025-04-15 01:23:03');
INSERT INTO `login_info` VALUES (99, 'admin', '157.10.105.73', ' ', 'Firefox137', 'Windows10', '0', '登录成功', '2025-04-15 05:34:28');
INSERT INTO `login_info` VALUES (100, 'laoying', '119.39.23.70', '湖南省 长沙市', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-04-15 06:39:59');
INSERT INTO `login_info` VALUES (101, 'admin', '113.119.158.200', '广东省 广州市', 'Chrome119', 'Windows10', '0', '登录成功', '2025-04-15 08:43:19');
INSERT INTO `login_info` VALUES (102, 'admin', '183.230.37.181', '重庆市 重庆市', 'Edge135', 'Windows10', '0', '登录成功', '2025-04-15 09:25:29');
INSERT INTO `login_info` VALUES (103, 'admin', '219.142.154.40', '北京市 北京市', 'Chrome134', 'Windows10', '0', '登录成功', '2025-04-15 12:59:08');
INSERT INTO `login_info` VALUES (104, 'admin', '183.186.76.154', '山西省 吕梁市', 'Edge135', 'Windows10', '0', '登录成功', '2025-04-15 13:47:58');
INSERT INTO `login_info` VALUES (105, 'admin', '112.6.231.2', '山东省 潍坊市', 'Chrome115', 'Windows10', '1', '验证码错误', '2025-04-16 05:16:22');
INSERT INTO `login_info` VALUES (106, 'admin', '112.6.231.2', '山东省 潍坊市', 'Chrome115', 'Windows10', '0', '登录成功', '2025-04-16 05:16:26');
INSERT INTO `login_info` VALUES (107, 'admin', '120.236.4.10', '广东省 深圳市', 'Chrome135', 'Windows10', '0', '登录成功', '2025-04-16 08:40:14');
INSERT INTO `login_info` VALUES (108, 'admin', '111.203.158.101', '北京市 北京市', 'Chrome135', 'Windows10', '0', '登录成功', '2025-04-16 08:52:58');
INSERT INTO `login_info` VALUES (109, 'admin', '103.188.234.179', ' ', 'Chrome135', 'Windows10', '0', '登录成功', '2025-04-16 11:28:46');
INSERT INTO `login_info` VALUES (110, 'admin', '112.54.172.77', '内蒙古 呼和浩特市', 'Chrome128', 'Windows10', '0', '登录成功', '2025-04-17 00:58:19');
INSERT INTO `login_info` VALUES (111, 'admin', '111.172.130.107', '湖北省 武汉市', 'Chrome135', 'Windows10', '0', '登录成功', '2025-04-17 02:18:49');
INSERT INTO `login_info` VALUES (112, 'admin', '123.173.115.50', '吉林省 长春市', 'Edge135', 'Windows10', '0', '登录成功', '2025-04-17 08:08:54');
INSERT INTO `login_info` VALUES (113, 'laoying', '119.39.1.143', '湖南省 长沙市', 'Chrome135', 'macOS10.15.7', '1', '验证码错误', '2025-04-17 08:33:19');
INSERT INTO `login_info` VALUES (114, 'laoying', '119.39.1.143', '湖南省 长沙市', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-04-17 08:33:23');
INSERT INTO `login_info` VALUES (115, 'admin', '125.33.250.63', '北京市 北京市', 'Edge135', 'Windows10', '0', '登录成功', '2025-04-17 09:22:12');
INSERT INTO `login_info` VALUES (116, 'admin', '58.62.166.123', '广东省 广州市', 'Edge126', 'Windows10', '0', '登录成功', '2025-04-17 14:59:33');
INSERT INTO `login_info` VALUES (117, 'admin', '175.145.232.161', ' ', 'Edge135', 'Windows10', '0', '登录成功', '2025-04-18 02:38:14');
INSERT INTO `login_info` VALUES (118, 'admin', '113.244.71.38', '湖南省 永州市', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-04-18 06:02:37');
INSERT INTO `login_info` VALUES (119, 'admin', '122.238.55.58', '浙江省 嘉兴市', 'Chrome126', 'Windows10', '0', '登录成功', '2025-04-18 07:48:14');
INSERT INTO `login_info` VALUES (120, 'admin', '113.128.85.119', '山东省 济南市', 'Sogou Explorer1', 'Windows10', '1', '验证码错误', '2025-04-18 08:31:47');
INSERT INTO `login_info` VALUES (121, 'admin', '113.128.85.119', '山东省 济南市', 'Sogou Explorer1', 'Windows10', '0', '登录成功', '2025-04-18 08:31:54');
INSERT INTO `login_info` VALUES (122, 'laoying', '119.39.1.143', '湖南省 长沙市', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-04-18 09:01:56');
INSERT INTO `login_info` VALUES (123, 'admin', '124.193.218.82', '北京市 北京市', 'Chrome124', 'macOS10.15.7', '0', '登录成功', '2025-04-18 09:09:08');
INSERT INTO `login_info` VALUES (124, 'admin', '118.248.44.134', '湖南省 益阳市', 'Firefox137', 'Windows10', '0', '登录成功', '2025-04-18 12:03:55');
INSERT INTO `login_info` VALUES (125, 'admin', '103.231.84.3', '香港 ', 'Chrome135', 'Windows10', '0', '登录成功', '2025-04-19 06:38:13');
INSERT INTO `login_info` VALUES (126, 'laoying', '120.228.89.165', '湖南省 长沙市', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-04-19 11:48:31');
INSERT INTO `login_info` VALUES (127, 'admin', '221.225.141.78', '江苏省 苏州市', 'Chrome134', 'Windows10', '1', '验证码错误', '2025-04-19 13:23:36');
INSERT INTO `login_info` VALUES (128, 'admin', '221.225.141.78', '江苏省 苏州市', 'Chrome134', 'Windows10', '0', '登录成功', '2025-04-19 13:23:42');
INSERT INTO `login_info` VALUES (129, 'admin', '43.167.220.79', ' ', 'Edge135', 'macOS10.15.7', '0', '登录成功', '2025-04-20 01:29:18');
INSERT INTO `login_info` VALUES (130, 'admin', '183.128.208.240', '浙江省 杭州市', 'Chrome126', 'Windows10', '0', '登录成功', '2025-04-20 03:32:06');
INSERT INTO `login_info` VALUES (131, 'admin', '58.212.33.229', '江苏省 南京市', 'Edge135', 'Windows10', '0', '登录成功', '2025-04-20 04:52:28');
INSERT INTO `login_info` VALUES (132, 'admin', '183.9.130.154', '广东省 揭阳市', 'Edge135', 'Windows10', '0', '登录成功', '2025-04-20 12:12:45');
INSERT INTO `login_info` VALUES (133, 'admin', '14.221.38.100', '广东省 东莞市', 'Chrome122', 'Windows10', '0', '登录成功', '2025-04-21 01:31:16');
INSERT INTO `login_info` VALUES (134, 'laoying', '119.39.1.143', '湖南省 长沙市', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-04-21 02:50:09');
INSERT INTO `login_info` VALUES (135, 'admin', '112.32.91.181', '安徽省 合肥市', 'Chrome135', 'Windows10', '0', '登录成功', '2025-04-21 06:00:07');
INSERT INTO `login_info` VALUES (136, 'laoying', '113.244.65.158', '湖南省 永州市', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-04-21 08:06:56');
INSERT INTO `login_info` VALUES (137, 'admin', '120.237.153.179', '广东省 珠海市', 'Chrome135', 'Windows10', '0', '登录成功', '2025-04-21 09:21:25');
INSERT INTO `login_info` VALUES (138, 'admin', '218.68.64.192', '天津市 天津市', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-04-21 09:45:16');
INSERT INTO `login_info` VALUES (139, 'admin', '101.6.130.18', '北京市 北京市', 'Chrome128', 'macOS10.15.7', '0', '登录成功', '2025-04-21 16:19:47');
INSERT INTO `login_info` VALUES (140, 'admin', '183.192.62.53', '上海市 上海市', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-04-21 17:10:30');
INSERT INTO `login_info` VALUES (141, 'laoying', '119.39.1.143', '湖南省 长沙市', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-04-22 02:12:35');
INSERT INTO `login_info` VALUES (142, 'admin', '114.108.225.175', ' ', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-04-22 02:44:10');
INSERT INTO `login_info` VALUES (143, 'admin', '219.232.77.94', '广西 南宁市', 'Edge135', 'Windows10', '0', '登录成功', '2025-04-22 06:00:09');
INSERT INTO `login_info` VALUES (144, 'admin', '113.245.75.169', '湖南省 湘潭市', 'Chrome122', 'Windows10', '0', '登录成功', '2025-04-22 11:02:53');
INSERT INTO `login_info` VALUES (145, 'admin', '117.188.16.109', '贵州省 贵阳市', 'Edge135', 'Windows10', '0', '登录成功', '2025-04-22 13:29:15');
INSERT INTO `login_info` VALUES (146, 'admin', '101.39.146.190', '北京市 北京市', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-04-22 14:53:59');
INSERT INTO `login_info` VALUES (147, 'admin', '50.116.13.108', ' ', 'Edge135', 'Windows10', '0', '登录成功', '2025-04-23 02:51:37');
INSERT INTO `login_info` VALUES (148, 'admin', '1.80.83.222', '陕西省 西安市', 'Edge135', 'Windows10', '0', '登录成功', '2025-04-23 02:55:12');
INSERT INTO `login_info` VALUES (149, 'laoying', '119.39.1.143', '湖南省 长沙市', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-04-23 03:26:31');
INSERT INTO `login_info` VALUES (150, 'admin', '103.188.234.179', ' ', 'Chrome135', 'Windows10', '0', '登录成功', '2025-04-23 04:43:02');
INSERT INTO `login_info` VALUES (151, 'admin', '43.167.220.79', ' ', 'Edge135', 'macOS10.15.7', '0', '登录成功', '2025-04-23 06:11:33');
INSERT INTO `login_info` VALUES (152, 'admin', '120.230.44.194', '广东省 广州市', 'Chrome133', 'macOS10.15.7', '0', '登录成功', '2025-04-23 06:56:12');
INSERT INTO `login_info` VALUES (153, 'admin', '183.255.44.192', '海南省 儋州市', 'Chrome121', 'Windows10', '0', '登录成功', '2025-04-23 07:26:15');
INSERT INTO `login_info` VALUES (154, 'admin', '183.93.146.196', '湖北省 襄阳市', 'Firefox137', 'Windows10', '0', '登录成功', '2025-04-23 08:41:14');
INSERT INTO `login_info` VALUES (155, 'admin', '223.145.30.151', '湖南省 岳阳市', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-04-23 09:03:30');
INSERT INTO `login_info` VALUES (156, 'admin', '125.92.113.25', '广东省 江门市', 'Chrome135', 'Windows10', '0', '登录成功', '2025-04-23 09:23:48');
INSERT INTO `login_info` VALUES (157, 'admin', '154.18.174.162', ' ', 'Chrome135', 'Windows10', '0', '登录成功', '2025-04-23 09:43:06');
INSERT INTO `login_info` VALUES (158, 'admin', '163.125.167.174', '广东省 深圳市', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-04-23 10:05:18');
INSERT INTO `login_info` VALUES (159, 'admin', '39.144.57.209', '辽宁省 ', 'Edge135', 'Windows10', '0', '登录成功', '2025-04-23 10:53:34');
INSERT INTO `login_info` VALUES (160, 'admin', '1.198.22.147', '河南省 郑州市', 'Edge135', 'Windows10', '0', '登录成功', '2025-04-23 11:10:49');
INSERT INTO `login_info` VALUES (161, 'laoying', '120.228.88.105', '湖南省 长沙市', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-04-23 14:56:06');
INSERT INTO `login_info` VALUES (162, 'admin', '183.192.62.53', '上海市 上海市', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-04-23 22:12:12');
INSERT INTO `login_info` VALUES (163, 'admin', '36.57.114.157', '安徽省 六安市', 'Chrome122', 'Windows10', '1', '验证码错误', '2025-04-24 01:00:26');
INSERT INTO `login_info` VALUES (164, 'admin', '36.57.114.157', '安徽省 六安市', 'Chrome122', 'Windows10', '0', '登录成功', '2025-04-24 01:00:29');
INSERT INTO `login_info` VALUES (165, 'admin', '182.101.60.172', '江西省 南昌市', 'Edge135', 'macOS10.15.7', '0', '登录成功', '2025-04-24 01:01:31');
INSERT INTO `login_info` VALUES (166, 'laoying', '118.248.141.5', '湖南省 邵阳市', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-04-24 01:34:59');
INSERT INTO `login_info` VALUES (167, 'admin', '115.238.84.98', '浙江省 杭州市', 'Chrome135', 'Windows10', '0', '登录成功', '2025-04-24 01:47:20');
INSERT INTO `login_info` VALUES (168, 'admin', '117.151.246.13', '湖北省 恩施州', 'Chrome135', 'Windows10', '0', '登录成功', '2025-04-24 02:17:06');
INSERT INTO `login_info` VALUES (169, 'admin', '115.238.84.98', '浙江省 杭州市', 'Chrome135', 'Windows10', '0', '登录成功', '2025-04-24 02:22:55');
INSERT INTO `login_info` VALUES (170, 'admin', '223.104.82.75', '广东省 广州市', 'Edge135', 'Windows10', '0', '登录成功', '2025-04-24 02:44:51');
INSERT INTO `login_info` VALUES (171, 'admin', '113.77.134.148', '广东省 东莞市', 'Chrome131', 'Windows10', '0', '登录成功', '2025-04-24 07:41:14');
INSERT INTO `login_info` VALUES (172, 'laoying', '118.248.141.5', '湖南省 邵阳市', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-04-24 08:31:55');
INSERT INTO `login_info` VALUES (173, 'admin', '183.159.120.91', '浙江省 杭州市', 'Edge135', 'macOS10.15.7', '0', '登录成功', '2025-04-24 08:48:09');
INSERT INTO `login_info` VALUES (174, 'admin', '115.193.2.74', '浙江省 杭州市', 'Chrome135', 'Windows10', '0', '登录成功', '2025-04-24 09:21:19');
INSERT INTO `login_info` VALUES (175, 'admin', '223.68.29.157', '江苏省 宿迁市', 'Chrome131', 'Windows10', '0', '登录成功', '2025-04-24 09:24:53');
INSERT INTO `login_info` VALUES (176, 'admin', '58.212.178.100', '江苏省 南京市', 'Edge135', 'Windows10', '0', '登录成功', '2025-04-24 11:21:53');
INSERT INTO `login_info` VALUES (177, 'admin', '223.106.33.187', '江苏省 苏州市', 'Edge135', 'Windows10', '0', '登录成功', '2025-04-24 13:40:17');
INSERT INTO `login_info` VALUES (178, 'admin', '123.185.78.172', '辽宁省 大连市', 'Chrome133', 'Windows10', '0', '登录成功', '2025-04-24 14:17:00');
INSERT INTO `login_info` VALUES (179, 'admin', '112.2.253.119', '江苏省 南京市', 'Firefox137', 'Windows10', '1', '验证码错误', '2025-04-25 02:53:52');
INSERT INTO `login_info` VALUES (180, 'admin', '112.2.253.119', '江苏省 南京市', 'Firefox137', 'Windows10', '0', '登录成功', '2025-04-25 02:53:56');
INSERT INTO `login_info` VALUES (181, 'laoying', '119.39.1.143', '湖南省 长沙市', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-04-25 03:25:30');
INSERT INTO `login_info` VALUES (182, 'admin', '222.91.150.15', '陕西省 西安市', 'QQBrowser13', 'Windows10', '0', '登录成功', '2025-04-25 04:12:04');
INSERT INTO `login_info` VALUES (183, 'admin', '111.10.226.227', '重庆市 重庆市', 'Chrome135', 'Windows10', '0', '登录成功', '2025-04-25 05:46:51');
INSERT INTO `login_info` VALUES (184, 'admin', '123.119.186.168', '北京市 北京市', 'Edge135', 'Windows10', '0', '登录成功', '2025-04-25 05:59:09');
INSERT INTO `login_info` VALUES (185, 'admin', '123.245.1.133', '辽宁省 沈阳市', 'Chrome135', 'Windows10', '0', '登录成功', '2025-04-25 08:42:55');
INSERT INTO `login_info` VALUES (186, 'admin', '121.30.190.115', '山西省 大同市', 'Edge135', 'Windows10', '0', '登录成功', '2025-04-25 09:28:48');
INSERT INTO `login_info` VALUES (187, 'admin', '183.192.62.53', '上海市 上海市', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-04-26 02:01:15');
INSERT INTO `login_info` VALUES (188, 'admin', '42.229.130.16', '河南省 安阳市', 'Chrome135', 'Windows10', '0', '登录成功', '2025-04-26 05:00:02');
INSERT INTO `login_info` VALUES (189, 'admin', '110.83.48.177', '福建省 福州市', 'Chrome135', 'Windows10', '0', '登录成功', '2025-04-26 07:04:02');
INSERT INTO `login_info` VALUES (190, 'admin', '27.202.201.27', '山东省 东营市', 'Chrome135', 'Windows10', '0', '登录成功', '2025-04-26 09:16:45');
INSERT INTO `login_info` VALUES (191, 'laoying', '120.228.88.105', '湖南省 长沙市', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-04-26 11:09:57');
INSERT INTO `login_info` VALUES (192, 'admin', '223.88.36.102', '河南省 郑州市', 'Chrome135', 'Windows10', '0', '登录成功', '2025-04-26 12:38:12');
INSERT INTO `login_info` VALUES (193, 'admin', '58.152.113.218', '香港 ', 'Chrome135', 'Windows10', '0', '登录成功', '2025-04-26 13:38:49');
INSERT INTO `login_info` VALUES (194, 'admin', '113.76.169.124', '广东省 珠海市', 'Chrome135', 'Windows10', '0', '登录成功', '2025-04-26 14:33:16');
INSERT INTO `login_info` VALUES (195, 'admin', '114.108.225.175', ' ', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-04-26 16:41:16');
INSERT INTO `login_info` VALUES (196, 'admin', '58.152.113.218', '香港 ', 'Chrome135', 'Windows10', '0', '登录成功', '2025-04-27 00:54:58');
INSERT INTO `login_info` VALUES (197, 'admin', '61.242.153.115', '江西省 抚州市', 'Edge123', 'Android10', '0', '登录成功', '2025-04-27 00:56:51');
INSERT INTO `login_info` VALUES (198, 'laoying', '118.248.208.127', '湖南省 邵阳市', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-04-27 01:28:30');
INSERT INTO `login_info` VALUES (199, 'admin', '223.104.86.97', '四川省 ', 'Edge135', 'Windows10', '0', '登录成功', '2025-04-27 02:08:31');
INSERT INTO `login_info` VALUES (200, 'admin', '36.233.228.188', '台湾省 ', 'Chrome135', 'Windows10', '0', '登录成功', '2025-04-27 04:01:51');
INSERT INTO `login_info` VALUES (201, 'admin', '113.116.30.188', '广东省 深圳市', 'Edge135', 'Windows10', '0', '登录成功', '2025-04-27 06:29:30');
INSERT INTO `login_info` VALUES (202, 'admin', '182.88.27.229', '广西 南宁市', 'Chrome135', 'Windows10', '0', '登录成功', '2025-04-27 06:29:44');
INSERT INTO `login_info` VALUES (203, 'admin', '113.116.30.188', '广东省 深圳市', 'Edge135', 'Windows10', '0', '登录成功', '2025-04-27 06:30:22');
INSERT INTO `login_info` VALUES (204, 'admin', '113.132.235.244', '陕西省 西安市', 'Chrome135', 'Windows10', '0', '登录成功', '2025-04-27 07:40:30');
INSERT INTO `login_info` VALUES (205, 'admin', '36.97.124.232', '吉林省 松原市', 'Edge135', 'Windows10', '0', '登录成功', '2025-04-27 09:54:30');
INSERT INTO `login_info` VALUES (206, 'laoying', '120.228.88.105', '湖南省 长沙市', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-04-27 12:35:27');
INSERT INTO `login_info` VALUES (207, 'admin', '27.43.204.228', '广东省 潮州市', 'Edge135', 'Windows10', '0', '登录成功', '2025-04-27 13:54:53');
INSERT INTO `login_info` VALUES (208, 'admin', '223.145.30.192', '湖南省 岳阳市', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-04-27 17:43:44');
INSERT INTO `login_info` VALUES (209, 'admin', '39.144.59.170', '辽宁省 沈阳市', 'Edge135', 'Windows10', '0', '登录成功', '2025-04-27 23:29:14');
INSERT INTO `login_info` VALUES (210, 'admin', '120.42.159.98', '福建省 泉州市', 'Edge135', 'Windows10', '0', '登录成功', '2025-04-28 01:14:00');
INSERT INTO `login_info` VALUES (211, 'admin', '111.60.118.254', '湖北省 武汉市', 'Chrome135', 'Windows10', '0', '登录成功', '2025-04-28 08:56:20');
INSERT INTO `login_info` VALUES (212, 'admin', '222.64.253.177', '上海市 上海市', 'Chrome135', 'Windows10', '0', '登录成功', '2025-04-28 12:06:13');
INSERT INTO `login_info` VALUES (213, 'admin', '103.172.116.207', ' ', 'Chrome135', 'Windows10', '0', '登录成功', '2025-04-28 14:50:59');
INSERT INTO `login_info` VALUES (214, 'admin', '14.153.218.153', '广东省 深圳市', 'Edge135', 'Windows10', '0', '登录成功', '2025-04-28 15:54:28');
INSERT INTO `login_info` VALUES (215, 'admin', '113.75.82.37', '广东省 河源市', 'Edge135', 'Windows10', '0', '登录成功', '2025-04-28 18:27:16');
INSERT INTO `login_info` VALUES (216, 'admin', '124.64.17.91', '北京市 北京市', 'Chrome132', 'Windows10', '0', '登录成功', '2025-04-29 01:07:16');
INSERT INTO `login_info` VALUES (217, 'laoying', '118.248.208.127', '湖南省 邵阳市', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-04-29 01:12:13');
INSERT INTO `login_info` VALUES (218, 'admin', '111.60.88.186', '湖北省 武汉市', 'Edge135', 'Windows10', '0', '登录成功', '2025-04-29 01:44:08');
INSERT INTO `login_info` VALUES (219, 'admin', '106.120.54.124', '北京市 北京市', 'Edge135', 'Windows10', '0', '登录成功', '2025-04-29 06:23:39');
INSERT INTO `login_info` VALUES (220, 'admin', '111.26.161.240', '吉林省 长春市', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-04-29 06:55:38');
INSERT INTO `login_info` VALUES (221, 'admin', '123.174.204.27', '山西省 运城市', 'Chrome135', 'Windows10', '0', '登录成功', '2025-04-29 08:12:18');
INSERT INTO `login_info` VALUES (222, 'admin', '14.19.73.102', '广东省 广州市', 'Chrome135', 'Windows10', '0', '登录成功', '2025-04-29 10:52:15');
INSERT INTO `login_info` VALUES (223, 'admin', '223.88.36.102', '河南省 郑州市', 'Chrome135', 'Windows10', '1', '验证码错误', '2025-04-29 13:56:22');
INSERT INTO `login_info` VALUES (224, 'admin', '223.88.36.102', '河南省 郑州市', 'Chrome135', 'Windows10', '0', '登录成功', '2025-04-29 13:56:28');
INSERT INTO `login_info` VALUES (225, 'admin', '27.187.195.81', '河北省 保定市', 'Chrome135', 'Windows10', '0', '登录成功', '2025-04-29 15:30:22');
INSERT INTO `login_info` VALUES (226, 'admin', '39.144.144.71', '四川省 成都市', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-04-29 17:00:36');
INSERT INTO `login_info` VALUES (227, 'laoying', '119.39.1.143', '湖南省 长沙市', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-04-30 01:44:33');
INSERT INTO `login_info` VALUES (228, 'admin', '223.73.7.176', '广东省 深圳市', 'Chrome135', 'Windows10', '1', '验证码错误', '2025-04-30 02:12:04');
INSERT INTO `login_info` VALUES (229, 'admin', '223.73.7.176', '广东省 深圳市', 'Chrome135', 'Windows10', '1', '验证码错误', '2025-04-30 02:12:10');
INSERT INTO `login_info` VALUES (230, 'admin', '223.73.7.176', '广东省 深圳市', 'Chrome135', 'Windows10', '0', '登录成功', '2025-04-30 02:12:19');
INSERT INTO `login_info` VALUES (231, 'admin', '183.14.28.189', '广东省 深圳市', 'Safari17', 'macOS10.15.7', '0', '登录成功', '2025-04-30 02:40:40');
INSERT INTO `login_info` VALUES (232, 'admin', '202.103.63.1', '湖北省 武汉市', 'Edge135', 'Windows10', '0', '登录成功', '2025-04-30 02:54:29');
INSERT INTO `login_info` VALUES (233, 'admin', '121.235.47.82', '江苏省 无锡市', 'Chrome131', 'Windows10', '0', '登录成功', '2025-04-30 04:05:14');
INSERT INTO `login_info` VALUES (234, 'admin', '116.30.125.188', '广东省 深圳市', 'Edge135', 'Windows10', '0', '登录成功', '2025-04-30 08:30:30');
INSERT INTO `login_info` VALUES (235, 'admin', '175.152.113.42', '四川省 成都市', 'Chrome135', 'Windows10', '1', '验证码错误', '2025-04-30 12:00:49');
INSERT INTO `login_info` VALUES (236, 'admin', '175.152.113.42', '四川省 成都市', 'Chrome135', 'Windows10', '0', '登录成功', '2025-04-30 12:00:53');
INSERT INTO `login_info` VALUES (237, 'admin', '124.79.50.64', '上海市 上海市', 'Edge135', 'Windows10', '0', '登录成功', '2025-04-30 13:25:49');
INSERT INTO `login_info` VALUES (238, 'admin', '114.108.225.175', ' ', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-04-30 15:41:31');
INSERT INTO `login_info` VALUES (239, 'admin', '113.221.72.63', '湖南省 常德市', 'Chrome122', 'Windows10', '0', '登录成功', '2025-05-01 01:33:10');
INSERT INTO `login_info` VALUES (240, 'admin', '36.143.132.243', '河北省 石家庄市', 'Firefox137', 'Windows10', '0', '登录成功', '2025-05-01 01:40:48');
INSERT INTO `login_info` VALUES (241, 'admin', '113.77.104.91', '广东省 东莞市', 'Chrome132', 'Windows10', '0', '登录成功', '2025-05-01 04:47:00');
INSERT INTO `login_info` VALUES (242, 'admin', '220.197.224.169', '云南省 昆明市', 'Chrome135', 'Windows10', '0', '登录成功', '2025-05-01 07:59:46');
INSERT INTO `login_info` VALUES (243, 'admin', '36.143.132.243', '河北省 石家庄市', 'Firefox137', 'Windows10', '0', '登录成功', '2025-05-01 08:05:15');
INSERT INTO `login_info` VALUES (244, 'admin', '106.60.188.185', '云南省 昆明市', 'Chrome135', 'Windows10', '0', '登录成功', '2025-05-01 08:40:08');
INSERT INTO `login_info` VALUES (245, 'laoying', '120.228.88.188', '湖南省 长沙市', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-05-01 13:28:14');
INSERT INTO `login_info` VALUES (246, 'admin', '120.245.25.2', '北京市 北京市', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-05-01 15:59:16');
INSERT INTO `login_info` VALUES (247, 'admin', '114.108.225.175', ' ', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-05-01 20:25:46');
INSERT INTO `login_info` VALUES (248, 'admin', '120.245.25.2', '北京市 北京市', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-05-02 00:39:48');
INSERT INTO `login_info` VALUES (249, 'admin', '222.152.213.0', ' ', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-05-02 13:13:20');
INSERT INTO `login_info` VALUES (250, 'admin', '185.151.146.98', ' ', 'Mobile Chrome135', 'Android10', '0', '登录成功', '2025-05-02 14:45:11');
INSERT INTO `login_info` VALUES (251, 'admin', '223.104.133.110', '湖南省 长沙市', 'MIUI Browser19', 'Android15', '0', '登录成功', '2025-05-03 00:26:59');
INSERT INTO `login_info` VALUES (252, 'admin', '222.128.46.10', '北京市 北京市', 'Chrome122', 'Windows10', '0', '登录成功', '2025-05-03 00:47:18');
INSERT INTO `login_info` VALUES (253, 'admin', '103.17.148.123', ' ', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-05-03 02:03:47');
INSERT INTO `login_info` VALUES (254, 'admin', '14.155.235.67', '广东省 深圳市', 'Edge135', 'Windows10', '0', '登录成功', '2025-05-03 03:11:06');
INSERT INTO `login_info` VALUES (255, 'laoying', '120.228.88.188', '湖南省 长沙市', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-05-03 05:24:28');
INSERT INTO `login_info` VALUES (256, 'admin', '120.242.203.188', '安徽省 安庆市', 'Chrome135', 'Windows10', '0', '登录成功', '2025-05-03 12:30:20');
INSERT INTO `login_info` VALUES (257, 'admin', '14.155.235.67', '广东省 深圳市', 'Edge135', 'Windows10', '0', '登录成功', '2025-05-03 14:14:16');
INSERT INTO `login_info` VALUES (258, 'laoying', '120.228.88.188', '湖南省 长沙市', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-05-04 05:25:11');
INSERT INTO `login_info` VALUES (259, 'admin', '112.36.58.72', '山东省 德州市', 'Edge135', 'Windows10', '0', '登录成功', '2025-05-04 11:34:01');
INSERT INTO `login_info` VALUES (260, 'admin', '122.90.28.36', '福建省 福州市', 'Chrome120', 'Windows10', '0', '登录成功', '2025-05-04 11:52:26');
INSERT INTO `login_info` VALUES (261, 'admin', '58.244.69.25', '吉林省 长春市', 'Edge136', 'Windows10', '0', '登录成功', '2025-05-04 14:41:24');
INSERT INTO `login_info` VALUES (262, 'admin', '14.145.61.5', '广东省 广州市', 'Edge135', 'Windows10', '0', '登录成功', '2025-05-04 17:30:21');
INSERT INTO `login_info` VALUES (263, 'admin', '45.192.106.113', '香港 ', 'Chrome130', 'Windows10', '1', '验证码错误', '2025-05-04 23:21:32');
INSERT INTO `login_info` VALUES (264, 'admin', '45.192.106.113', '香港 ', 'Chrome130', 'Windows10', '0', '登录成功', '2025-05-04 23:21:37');
INSERT INTO `login_info` VALUES (265, 'admin', '111.60.133.184', '湖北省 武汉市', 'Edge135', 'Windows10', '0', '登录成功', '2025-05-05 00:30:49');
INSERT INTO `login_info` VALUES (266, 'admin', '117.147.118.86', '浙江省 温州市', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-05-05 01:36:36');
INSERT INTO `login_info` VALUES (267, 'admin', '223.94.33.20', '浙江省 宁波市', 'Chrome135', 'Windows10', '1', '验证码错误', '2025-05-05 07:05:00');
INSERT INTO `login_info` VALUES (268, 'admin', '223.94.33.20', '浙江省 宁波市', 'Chrome135', 'Windows10', '0', '登录成功', '2025-05-05 07:05:05');
INSERT INTO `login_info` VALUES (269, 'laoying', '120.228.88.188', '湖南省 长沙市', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-05-05 08:00:02');
INSERT INTO `login_info` VALUES (270, 'admin', '182.88.167.163', '广西 南宁市', 'Chrome135', 'Windows10', '0', '登录成功', '2025-05-05 09:32:21');
INSERT INTO `login_info` VALUES (271, 'laoying', '120.228.88.188', '湖南省 长沙市', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-05-05 13:32:08');
INSERT INTO `login_info` VALUES (272, 'admin', '14.155.244.41', '广东省 深圳市', 'Edge136', 'Windows10', '0', '登录成功', '2025-05-05 14:23:03');
INSERT INTO `login_info` VALUES (273, 'laoying', '120.228.88.188', '湖南省 长沙市', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-05-05 14:36:09');
INSERT INTO `login_info` VALUES (274, 'admin', '54.238.188.95', ' ', 'Chrome138', 'Windows10', '0', '登录成功', '2025-05-05 17:42:01');
INSERT INTO `login_info` VALUES (275, 'admin', '114.108.225.175', ' ', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-05-05 21:11:58');
INSERT INTO `login_info` VALUES (276, 'laoying', '118.248.215.174', '湖南省 邵阳市', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-05-06 01:40:18');
INSERT INTO `login_info` VALUES (277, 'admin', '60.169.68.42', '安徽省 芜湖市', 'Edge136', 'Windows10', '0', '登录成功', '2025-05-06 01:47:33');
INSERT INTO `login_info` VALUES (278, 'admin', '14.154.45.229', '广东省 深圳市', 'Edge135', 'Windows10', '0', '登录成功', '2025-05-06 02:10:16');
INSERT INTO `login_info` VALUES (279, 'admin', '123.112.21.188', '北京市 北京市', 'Chrome135', 'Windows10', '0', '登录成功', '2025-05-06 05:53:45');
INSERT INTO `login_info` VALUES (280, 'admin', '113.133.208.59', '陕西省 西安市', 'Edge112', 'Windows10', '0', '登录成功', '2025-05-06 06:19:24');
INSERT INTO `login_info` VALUES (281, 'admin', '1.25.64.11', '内蒙古 包头市', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-05-06 06:32:09');
INSERT INTO `login_info` VALUES (282, 'laoying', '119.39.1.143', '湖南省 长沙市', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-05-06 09:08:50');
INSERT INTO `login_info` VALUES (283, 'admin', '14.153.247.252', '广东省 深圳市', 'Chrome135', 'Windows10', '0', '登录成功', '2025-05-06 09:14:38');
INSERT INTO `login_info` VALUES (284, 'admin', '61.93.200.248', '香港 ', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-05-06 12:04:32');
INSERT INTO `login_info` VALUES (285, 'admin', '219.237.177.224', '北京市 北京市', 'Quark2', 'Windows10', '1', '验证码错误', '2025-05-06 13:29:31');
INSERT INTO `login_info` VALUES (286, 'admin', '219.237.177.224', '北京市 北京市', 'Quark2', 'Windows10', '1', '验证码错误', '2025-05-06 13:29:41');
INSERT INTO `login_info` VALUES (287, 'admin', '219.237.177.224', '北京市 北京市', 'Quark2', 'Windows10', '0', '登录成功', '2025-05-06 13:29:44');
INSERT INTO `login_info` VALUES (288, 'admin', '14.155.202.115', '广东省 深圳市', 'Edge136', 'Windows10', '0', '登录成功', '2025-05-06 13:54:11');
INSERT INTO `login_info` VALUES (289, 'admin', '219.134.219.105', '广东省 深圳市', 'Mobile Chrome135', 'iOS18.3.2', '0', '登录成功', '2025-05-06 15:40:59');
INSERT INTO `login_info` VALUES (290, 'admin', '91.229.132.83', ' ', 'Chrome135', 'Windows10', '0', '登录成功', '2025-05-06 16:37:16');
INSERT INTO `login_info` VALUES (291, 'admin', '117.24.201.114', '福建省 泉州市', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-05-07 01:25:05');
INSERT INTO `login_info` VALUES (292, 'admin', '36.152.178.139', '江苏省 苏州市', 'Chrome135', 'Windows10', '0', '登录成功', '2025-05-07 03:15:27');
INSERT INTO `login_info` VALUES (293, 'admin', '123.119.187.218', '北京市 北京市', 'Edge135', 'Windows10', '0', '登录成功', '2025-05-07 03:33:29');
INSERT INTO `login_info` VALUES (294, 'admin', '175.152.142.68', '四川省 成都市', 'Firefox116', 'Windows10', '0', '登录成功', '2025-05-07 04:18:44');
INSERT INTO `login_info` VALUES (295, 'admin', '171.109.145.53', '广西 北海市', 'Quark7', 'Android15', '0', '登录成功', '2025-05-07 08:47:00');
INSERT INTO `login_info` VALUES (296, 'admin', '223.152.69.67', '湖南省 郴州市', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-05-07 08:52:12');
INSERT INTO `login_info` VALUES (297, 'admin', '112.123.93.179', '安徽省 蚌埠市', 'Chrome121', 'Windows10', '0', '登录成功', '2025-05-07 09:10:44');
INSERT INTO `login_info` VALUES (298, 'admin', '175.160.33.179', '辽宁省 沈阳市', 'Chrome135', 'Windows10', '0', '登录成功', '2025-05-07 09:42:49');
INSERT INTO `login_info` VALUES (299, 'admin', '183.197.46.24', '河北省 石家庄市', 'Edge136', 'Windows10', '1', '验证码错误', '2025-05-07 13:25:53');
INSERT INTO `login_info` VALUES (300, 'admin', '183.197.46.24', '河北省 石家庄市', 'Edge136', 'Windows10', '0', '登录成功', '2025-05-07 13:26:00');
INSERT INTO `login_info` VALUES (301, 'admin', '101.24.214.151', '河北省 石家庄市', 'Edge136', 'Windows10', '0', '登录成功', '2025-05-07 13:32:28');
INSERT INTO `login_info` VALUES (302, 'laoying', '113.244.65.183', '湖南省 永州市', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-05-08 01:43:19');
INSERT INTO `login_info` VALUES (303, 'admin', '117.88.136.114', '江苏省 南京市', 'Chrome136', 'Windows10', '0', '登录成功', '2025-05-08 03:07:34');
INSERT INTO `login_info` VALUES (304, 'admin', '183.230.64.14', '重庆市 重庆市', 'Chrome109', 'Windows10', '1', '验证码错误', '2025-05-08 03:15:25');
INSERT INTO `login_info` VALUES (305, 'admin', '183.230.64.14', '重庆市 重庆市', 'Chrome109', 'Windows10', '0', '登录成功', '2025-05-08 03:15:30');
INSERT INTO `login_info` VALUES (306, 'admin', '120.246.45.5', '北京市 北京市', 'Edge136', 'Windows10', '0', '登录成功', '2025-05-08 03:32:11');
INSERT INTO `login_info` VALUES (307, 'admin', '171.88.108.117', '四川省 成都市', 'Chrome136', 'Windows10', '0', '登录成功', '2025-05-08 03:36:01');
INSERT INTO `login_info` VALUES (308, 'admin', '106.114.250.73', '河北省 石家庄市', 'Edge136', 'Windows10', '0', '登录成功', '2025-05-08 03:54:52');
INSERT INTO `login_info` VALUES (309, 'admin', '61.182.226.81', '河北省 石家庄市', 'Edge136', 'Windows10', '0', '登录成功', '2025-05-08 04:19:06');
INSERT INTO `login_info` VALUES (310, 'admin', '222.173.70.78', '山东省 青岛市', 'Edge128', 'Windows10', '0', '登录成功', '2025-05-08 06:01:31');
INSERT INTO `login_info` VALUES (311, 'admin', '183.141.221.164', '浙江省 嘉兴市', 'Chrome135', 'Windows10', '0', '登录成功', '2025-05-08 06:11:19');
INSERT INTO `login_info` VALUES (312, 'admin', '171.223.122.232', '四川省 成都市', 'Chrome124', 'Windows10', '0', '登录成功', '2025-05-08 08:33:46');
INSERT INTO `login_info` VALUES (313, 'admin', '39.144.30.52', '新疆 昌吉州', 'Edge136', 'Windows10', '0', '登录成功', '2025-05-08 11:57:57');
INSERT INTO `login_info` VALUES (314, 'admin', '117.154.83.60', '湖北省 武汉市', 'Chrome135', 'Windows10', '0', '登录成功', '2025-05-08 13:28:19');
INSERT INTO `login_info` VALUES (315, 'laoying', '113.244.65.183', '湖南省 永州市', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-05-09 01:59:26');
INSERT INTO `login_info` VALUES (316, 'admin', '116.18.220.227', '广东省 东莞市', 'Chrome135', 'Windows10', '0', '登录成功', '2025-05-09 02:02:52');
INSERT INTO `login_info` VALUES (317, 'admin', '120.197.159.126', '广东省 东莞市', 'Chrome129', 'Windows10', '0', '登录成功', '2025-05-09 02:16:35');
INSERT INTO `login_info` VALUES (318, 'admin', '223.73.2.83', '广东省 深圳市', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-05-09 03:04:08');
INSERT INTO `login_info` VALUES (319, 'admin', '1.83.4.162', '陕西省 西安市', 'Edge135', 'Windows10', '0', '登录成功', '2025-05-09 07:34:01');
INSERT INTO `login_info` VALUES (320, 'admin', '119.39.1.143', '湖南省 长沙市', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-05-09 07:50:50');
INSERT INTO `login_info` VALUES (321, 'admin', '166.108.206.53', ' ', 'Edge128', 'Windows10', '0', '登录成功', '2025-05-09 08:17:03');
INSERT INTO `login_info` VALUES (322, 'laoying', '119.39.1.143', '湖南省 长沙市', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-05-09 08:17:14');
INSERT INTO `login_info` VALUES (323, 'admin', '119.39.1.143', '湖南省 长沙市', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-05-09 08:22:07');
INSERT INTO `login_info` VALUES (324, 'laoying', '119.39.1.143', '湖南省 长沙市', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-05-09 09:17:53');
INSERT INTO `login_info` VALUES (325, 'admin', '1.202.36.114', '北京市 北京市', 'Chrome135', 'Windows10', '0', '登录成功', '2025-05-09 09:34:25');
INSERT INTO `login_info` VALUES (326, 'admin', '119.15.85.198', ' ', 'Chrome135', 'Windows10', '0', '登录成功', '2025-05-09 10:03:16');
INSERT INTO `login_info` VALUES (327, 'admin', '109.110.162.51', ' ', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-05-09 10:12:37');
INSERT INTO `login_info` VALUES (328, 'admin', '111.33.199.126', '天津市 天津市', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-05-09 14:17:11');
INSERT INTO `login_info` VALUES (329, 'laoying', '120.228.88.47', '湖南省 长沙市', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-05-10 00:14:08');
INSERT INTO `login_info` VALUES (330, 'admin', '112.96.209.108', '广东省 广州市', 'Chrome86', 'Windows7', '0', '登录成功', '2025-05-10 01:16:39');
INSERT INTO `login_info` VALUES (331, 'admin', '182.102.89.125', '江西省 南昌市', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-05-10 02:08:02');
INSERT INTO `login_info` VALUES (332, 'admin', '112.245.49.134', '山东省 泰安市', 'Chrome136', 'Windows10', '0', '登录成功', '2025-05-10 05:56:53');
INSERT INTO `login_info` VALUES (333, 'admin', '185.212.58.48', ' ', 'Chrome135', 'Windows10', '0', '登录成功', '2025-05-10 10:03:47');
INSERT INTO `login_info` VALUES (334, 'laoying', '120.228.88.47', '湖南省 长沙市', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-05-10 11:54:48');
INSERT INTO `login_info` VALUES (335, 'admin', '27.38.240.203', '广东省 深圳市', 'Chrome136', 'Windows10', '0', '登录成功', '2025-05-11 09:31:26');
INSERT INTO `login_info` VALUES (336, 'laoying', '120.228.88.47', '湖南省 长沙市', 'Chrome136', 'macOS10.15.7', '0', '登录成功', '2025-05-11 13:56:32');
INSERT INTO `login_info` VALUES (337, 'admin', '101.68.3.7', '浙江省 杭州市', 'MIUI Browser19', 'Android15', '0', '登录成功', '2025-05-11 23:25:36');
INSERT INTO `login_info` VALUES (338, 'laoying', '113.244.65.81', '湖南省 永州市', 'Chrome136', 'macOS10.15.7', '0', '登录成功', '2025-05-12 01:39:25');
INSERT INTO `login_info` VALUES (339, 'admin', '119.130.200.212', '广东省 广州市', 'Edge136', 'Windows10', '0', '登录成功', '2025-05-12 03:20:23');
INSERT INTO `login_info` VALUES (340, 'admin', '123.177.54.10', '辽宁省 沈阳市', 'Chrome131', 'Windows10', '0', '登录成功', '2025-05-12 05:43:55');
INSERT INTO `login_info` VALUES (341, 'admin', '112.96.230.5', '广东省 广州市', 'Edge136', 'Windows10', '0', '登录成功', '2025-05-12 06:05:15');
INSERT INTO `login_info` VALUES (342, 'laoying', '119.39.1.143', '湖南省 长沙市', 'Chrome136', 'macOS10.15.7', '0', '登录成功', '2025-05-12 07:49:07');
INSERT INTO `login_info` VALUES (343, 'admin', '115.207.134.176', '浙江省 衢州市', 'Chrome136', 'Windows10', '0', '登录成功', '2025-05-12 08:51:39');
INSERT INTO `login_info` VALUES (344, 'admin', '114.108.225.175', ' ', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-05-12 21:58:11');
INSERT INTO `login_info` VALUES (345, 'admin', '59.174.63.57', '湖北省 武汉市', 'Chrome136', 'macOS10.15.7', '0', '登录成功', '2025-05-13 00:11:04');
INSERT INTO `login_info` VALUES (346, 'admin', '113.120.201.136', '山东省 潍坊市', 'Edge136', 'Windows10', '0', '登录成功', '2025-05-13 02:58:35');
INSERT INTO `login_info` VALUES (347, 'admin', '159.138.134.119', '香港 ', 'Chrome136', 'Windows10', '0', '登录成功', '2025-05-13 03:26:31');
INSERT INTO `login_info` VALUES (348, 'admin', '103.131.130.195', '台湾省 ', 'Chrome136', 'Windows10', '0', '登录成功', '2025-05-13 05:00:09');
INSERT INTO `login_info` VALUES (349, 'admin', '221.232.128.205', '湖北省 武汉市', 'Edge136', 'Windows10', '1', '验证码错误', '2025-05-13 06:10:38');
INSERT INTO `login_info` VALUES (350, 'admin', '221.232.128.205', '湖北省 武汉市', 'Edge136', 'Windows10', '0', '登录成功', '2025-05-13 06:10:43');
INSERT INTO `login_info` VALUES (351, 'admin', '112.21.22.164', '江苏省 无锡市', 'Chrome136', 'Windows10', '0', '登录成功', '2025-05-13 06:54:58');
INSERT INTO `login_info` VALUES (352, 'laoying', '119.39.1.143', '湖南省 长沙市', 'Chrome136', 'macOS10.15.7', '0', '登录成功', '2025-05-13 07:52:48');
INSERT INTO `login_info` VALUES (353, 'admin', '120.1.7.130', '河北省 石家庄市', 'Chrome136', 'Windows10', '0', '登录成功', '2025-05-13 09:32:09');
INSERT INTO `login_info` VALUES (354, 'admin', '45.195.70.15', '香港 ', 'Edge136', 'Windows10', '0', '登录成功', '2025-05-13 12:09:13');
INSERT INTO `login_info` VALUES (355, 'laoying', '120.228.88.149', '湖南省 长沙市', 'Chrome136', 'macOS10.15.7', '0', '登录成功', '2025-05-13 12:49:26');
INSERT INTO `login_info` VALUES (356, 'admin', '119.183.223.104', '山东省 潍坊市', 'Chrome136', 'Windows10', '0', '登录成功', '2025-05-13 13:33:15');
INSERT INTO `login_info` VALUES (357, 'admin', '39.184.4.235', '浙江省 台州市', 'Chrome136', 'macOS10.15.7', '0', '登录成功', '2025-05-13 15:47:15');
INSERT INTO `login_info` VALUES (358, 'admin', '121.15.193.79', '广东省 深圳市', 'Edge136', 'Windows10', '0', '登录成功', '2025-05-14 09:24:21');
INSERT INTO `login_info` VALUES (359, 'admin', '111.33.233.194', '天津市 天津市', 'Chrome120', 'macOS10.15.7', '0', '登录成功', '2025-05-14 11:13:40');
INSERT INTO `login_info` VALUES (360, 'admin', '36.46.168.215', '陕西省 西安市', 'Chrome136', 'Windows10', '0', '登录成功', '2025-05-14 12:28:48');
INSERT INTO `login_info` VALUES (361, 'admin', '120.231.119.254', '广东省 中山市', 'Chrome136', 'Windows10', '0', '登录成功', '2025-05-14 16:44:26');
INSERT INTO `login_info` VALUES (362, 'laoying', '113.244.65.71', '湖南省 永州市', 'Chrome136', 'macOS10.15.7', '0', '登录成功', '2025-05-15 01:35:32');
INSERT INTO `login_info` VALUES (363, 'admin', '101.7.161.121', '山西省 太原市', 'Chrome128', 'Windows10', '0', '登录成功', '2025-05-15 02:37:01');
INSERT INTO `login_info` VALUES (364, 'admin', '14.145.58.114', '广东省 广州市', 'Chrome136', 'Windows10', '0', '登录成功', '2025-05-15 02:48:28');
INSERT INTO `login_info` VALUES (365, 'admin', '113.65.212.164', '广东省 广州市', 'Edge133', 'Windows10', '1', '验证码错误', '2025-05-15 02:54:34');
INSERT INTO `login_info` VALUES (366, 'admin', '113.65.212.164', '广东省 广州市', 'Edge133', 'Windows10', '0', '登录成功', '2025-05-15 02:54:39');
INSERT INTO `login_info` VALUES (367, 'admin', '125.36.117.214', '天津市 天津市', 'Chrome136', 'Windows10', '1', '验证码错误', '2025-05-15 06:20:34');
INSERT INTO `login_info` VALUES (368, 'admin', '125.36.117.214', '天津市 天津市', 'Chrome136', 'Windows10', '0', '登录成功', '2025-05-15 06:20:39');
INSERT INTO `login_info` VALUES (369, 'admin', '60.27.179.212', '天津市 天津市', 'Chrome135', 'macOS10.15.7', '0', '登录成功', '2025-05-15 09:49:44');
INSERT INTO `login_info` VALUES (370, 'admin', '165.140.241.130', ' ', 'Chrome136', 'Windows10', '0', '登录成功', '2025-05-15 14:03:09');
INSERT INTO `login_info` VALUES (371, 'admin', '125.36.117.214', '天津市 天津市', 'Chrome136', 'Windows10', '0', '登录成功', '2025-05-16 01:53:42');
INSERT INTO `login_info` VALUES (372, 'admin', '14.145.58.114', '广东省 广州市', 'Edge136', 'Windows10', '0', '登录成功', '2025-05-16 03:03:47');
INSERT INTO `login_info` VALUES (373, 'admin', '125.36.117.214', '天津市 天津市', 'Chrome136', 'Windows10', '0', '登录成功', '2025-05-16 03:16:54');
INSERT INTO `login_info` VALUES (374, 'admin', '14.145.58.114', '广东省 广州市', 'Edge136', 'Windows10', '0', '登录成功', '2025-05-16 03:24:20');
INSERT INTO `login_info` VALUES (375, 'admin', '125.36.117.214', '天津市 天津市', 'Chrome136', 'Windows10', '0', '登录成功', '2025-05-16 03:26:57');
INSERT INTO `login_info` VALUES (376, 'admin', '14.145.58.114', '广东省 广州市', 'Edge136', 'Windows10', '0', '登录成功', '2025-05-16 03:33:54');
INSERT INTO `login_info` VALUES (377, 'admin', '14.145.58.114', '广东省 广州市', 'Edge136', 'Windows10', '0', '登录成功', '2025-05-16 03:34:31');
INSERT INTO `login_info` VALUES (378, 'laoying', '119.39.23.122', '湖南省 长沙市', 'Chrome136', 'macOS10.15.7', '0', '登录成功', '2025-05-16 06:01:44');
INSERT INTO `login_info` VALUES (379, 'admin', '14.145.58.114', '广东省 广州市', 'Chrome136', 'Windows10', '0', '登录成功', '2025-05-16 06:29:37');
INSERT INTO `login_info` VALUES (380, 'admin', '111.59.18.190', '广西 南宁市', 'Chrome135', 'Windows10', '0', '登录成功', '2025-05-16 07:28:38');
INSERT INTO `login_info` VALUES (381, 'admin', '171.110.98.136', '广西 钦州市', 'Edge136', 'Windows10', '0', '登录成功', '2025-05-16 07:32:08');
INSERT INTO `login_info` VALUES (382, 'admin', '112.90.194.148', '广东省 清远市', 'Edge135', 'macOS10.15.7', '0', '登录成功', '2025-05-16 08:16:15');
INSERT INTO `login_info` VALUES (383, 'admin', '119.62.206.30', '云南省 西双版纳州', 'Edge136', 'Windows10', '0', '登录成功', '2025-05-16 13:42:56');
INSERT INTO `login_info` VALUES (384, 'admin', '14.155.233.122', '广东省 深圳市', 'Edge136', 'Windows10', '0', '登录成功', '2025-05-16 16:48:46');
INSERT INTO `login_info` VALUES (385, 'admin', '112.42.32.197', '辽宁省 大连市', 'Firefox138', 'Windows10', '0', '登录成功', '2025-05-16 17:47:01');
INSERT INTO `login_info` VALUES (386, 'admin', '183.69.158.7', '重庆市 重庆市', 'Chrome136', 'Windows10', '1', '验证码错误', '2025-05-17 02:16:20');
INSERT INTO `login_info` VALUES (387, 'admin', '183.69.158.7', '重庆市 重庆市', 'Chrome136', 'Windows10', '0', '登录成功', '2025-05-17 02:16:35');
INSERT INTO `login_info` VALUES (388, 'admin', '14.155.233.122', '广东省 深圳市', 'Edge136', 'Windows10', '0', '登录成功', '2025-05-17 02:45:57');
INSERT INTO `login_info` VALUES (389, 'laoying', '118.248.215.135', '湖南省 邵阳市', 'Chrome136', 'macOS10.15.7', '0', '登录成功', '2025-05-17 05:39:17');
INSERT INTO `login_info` VALUES (390, 'admin', '112.87.186.237', '江苏省 苏州市', 'Edge136', 'Windows10', '0', '登录成功', '2025-05-17 15:50:51');
INSERT INTO `login_info` VALUES (391, 'admin', '183.15.204.194', '广东省 深圳市', 'Chrome136', 'Windows10', '0', '登录成功', '2025-05-18 02:45:06');
INSERT INTO `login_info` VALUES (392, 'admin', '49.88.22.119', '江苏省 连云港市', 'Edge126', 'Windows10', '0', '登录成功', '2025-05-18 02:52:43');
INSERT INTO `login_info` VALUES (393, 'admin', '124.127.144.97', '北京市 北京市', 'Edge136', 'macOS10.15.7', '0', '登录成功', '2025-05-18 03:04:00');
INSERT INTO `login_info` VALUES (394, 'admin', '119.1.177.151', '贵州省 黔东南州', 'Edge136', 'Windows10', '0', '登录成功', '2025-05-18 17:05:54');
INSERT INTO `login_info` VALUES (395, 'laoying', '119.39.23.122', '湖南省 长沙市', 'Chrome136', 'macOS10.15.7', '0', '登录成功', '2025-05-19 01:14:45');
INSERT INTO `login_info` VALUES (396, 'admin', '219.232.77.64', '广西 南宁市', 'Edge127', 'Windows10', '0', '登录成功', '2025-05-19 03:10:56');
INSERT INTO `login_info` VALUES (397, 'admin', '106.115.91.43', '河北省 邯郸市', 'Edge136', 'macOS10.15.7', '0', '登录成功', '2025-05-19 04:56:36');
INSERT INTO `login_info` VALUES (398, 'admin', '183.239.158.35', '广东省 深圳市', 'Chrome121', 'Windows10', '0', '登录成功', '2025-05-19 05:35:15');
INSERT INTO `login_info` VALUES (399, 'admin', '116.18.120.114', '广东省 东莞市', 'Edge136', 'Windows10', '0', '登录成功', '2025-05-19 06:33:08');
INSERT INTO `login_info` VALUES (400, 'laoying', '119.39.23.122', '湖南省 长沙市', 'Chrome136', 'macOS10.15.7', '0', '登录成功', '2025-05-19 09:00:14');
INSERT INTO `login_info` VALUES (401, 'admin', '14.145.50.106', '广东省 广州市', 'Chrome136', 'Windows10', '0', '登录成功', '2025-05-19 10:19:23');
INSERT INTO `login_info` VALUES (402, 'admin', '14.145.168.20', '广东省 广州市', 'Quark2', 'Windows10', '0', '登录成功', '2025-05-20 02:36:49');
INSERT INTO `login_info` VALUES (403, 'admin', '14.145.50.106', '广东省 广州市', 'Chrome136', 'Windows10', '0', '登录成功', '2025-05-20 03:53:04');
INSERT INTO `login_info` VALUES (404, 'admin', '183.253.145.178', '福建省 泉州市', 'Chrome86', 'Windows7', '0', '登录成功', '2025-05-20 07:52:13');
INSERT INTO `login_info` VALUES (405, 'admin', '36.33.45.253', '安徽省 合肥市', 'Edge136', 'Windows10', '0', '登录成功', '2025-05-20 07:58:20');
INSERT INTO `login_info` VALUES (406, 'admin', '14.19.77.194', '广东省 广州市', 'Chrome136', 'macOS10.15.7', '0', '登录成功', '2025-05-20 08:59:24');
INSERT INTO `login_info` VALUES (407, 'admin', '14.155.220.189', '广东省 深圳市', 'Edge136', 'Windows10', '0', '登录成功', '2025-05-20 14:15:46');
INSERT INTO `login_info` VALUES (408, 'admin', '115.62.236.132', '河南省 新乡市', 'Edge136', 'Windows10', '0', '登录成功', '2025-05-20 14:24:43');
INSERT INTO `login_info` VALUES (409, 'laoying', '119.39.23.122', '湖南省 长沙市', 'Chrome136', 'macOS10.15.7', '0', '登录成功', '2025-05-21 03:56:25');
INSERT INTO `login_info` VALUES (410, 'admin', '113.218.137.149', '湖南省 长沙市', 'Chrome136', 'Windows10', '0', '登录成功', '2025-05-21 05:29:31');
INSERT INTO `login_info` VALUES (411, 'admin', '127.0.0.1', '内网IP', 'Chrome136', 'macOS10.15.7', '0', '登录成功', '2025-05-21 06:34:08');
INSERT INTO `login_info` VALUES (412, 'admin', '127.0.0.1', '内网IP', 'Chrome136', 'macOS10.15.7', '0', '登录成功', '2025-05-21 07:20:13');
INSERT INTO `login_info` VALUES (413, 'admin', '127.0.0.1', '内网IP', 'Chrome136', 'macOS10.15.7', '0', '登录成功', '2025-05-26 05:37:01');
INSERT INTO `login_info` VALUES (414, 'admin', '127.0.0.1', '内网IP', 'Chrome136', 'macOS10.15.7', '0', '登录成功', '2025-06-03 01:41:32');
INSERT INTO `login_info` VALUES (415, 'admin', '127.0.0.1', '内网IP', 'Chrome137', 'macOS10.15.7', '0', '登录成功', '2025-06-18 06:47:04');
INSERT INTO `login_info` VALUES (416, 'admin', '127.0.0.1', '内网IP', 'Chrome140', 'macOS10.15.7', '0', '登录成功', '2025-09-25 06:43:39');
INSERT INTO `login_info` VALUES (417, 'admin', '127.0.0.1', '内网IP', 'Chrome140', 'macOS10.15.7', '0', '登录成功', '2025-09-26 07:08:51');
INSERT INTO `login_info` VALUES (418, 'admin', '', '湖南省 长沙市', 'Chrome141', 'macOS10.15.7', '0', '登录成功', '2025-10-22 07:18:54');
INSERT INTO `login_info` VALUES (419, 'admin', '', '湖南省 长沙市', 'Chrome141', 'macOS10.15.7', '0', '登录成功', '2025-11-05 13:43:36');
INSERT INTO `login_info` VALUES (420, 'admin', '', '湖南省 长沙市', 'Chrome142', 'macOS10.15.7', '1', '密码错误', '2025-11-11 02:51:28');
INSERT INTO `login_info` VALUES (421, 'admin', '', '湖南省 长沙市', 'Chrome142', 'macOS10.15.7', '0', '登录成功', '2025-11-11 02:51:34');
INSERT INTO `login_info` VALUES (422, 'admin', '', '湖南省 长沙市', 'Chrome142', 'macOS10.15.7', '0', '登录成功', '2025-11-25 07:38:21');
INSERT INTO `login_info` VALUES (423, 'admin', '', '湖南省 长沙市', 'Chrome142', 'macOS10.15.7', '0', '登录成功', '2025-11-28 06:09:14');
INSERT INTO `login_info` VALUES (424, 'admin', '', '湖南省 长沙市', 'Chrome142', 'macOS10.15.7', '0', '登录成功', '2025-11-28 06:09:16');
INSERT INTO `login_info` VALUES (425, 'admin', '', '湖南省 长沙市', 'Chrome142', 'macOS10.15.7', '0', '登录成功', '2025-12-02 06:35:04');
INSERT INTO `login_info` VALUES (426, 'admin', '', '湖南省 长沙市', 'Chrome142', 'macOS10.15.7', '1', '密码错误', '2025-12-03 02:51:51');
INSERT INTO `login_info` VALUES (427, 'admin', '', '湖南省 长沙市', 'Chrome142', 'macOS10.15.7', '0', '登录成功', '2025-12-03 02:51:58');
INSERT INTO `login_info` VALUES (428, 'admin', '', '湖南省 长沙市', 'Chrome142', 'macOS10.15.7', '0', '登录成功', '2025-12-05 09:35:47');
INSERT INTO `login_info` VALUES (429, 'admin', '', '湖南省 长沙市', 'Chrome143', 'macOS10.15.7', '1', '密码错误', '2026-01-06 02:29:47');
INSERT INTO `login_info` VALUES (430, 'admin', '', '湖南省 长沙市', 'Chrome143', 'macOS10.15.7', '1', '验证码错误', '2026-01-06 02:29:59');
INSERT INTO `login_info` VALUES (431, 'admin', '', '湖南省 长沙市', 'Chrome143', 'macOS10.15.7', '0', '登录成功', '2026-01-06 02:30:03');
INSERT INTO `login_info` VALUES (432, 'admin', '', '', 'Chrome143', 'macOS10.15.7', '1', '密码错误', '2026-01-27 02:03:04');
INSERT INTO `login_info` VALUES (433, 'admin', '', '', 'Chrome143', 'macOS10.15.7', '1', '密码错误', '2026-01-27 02:03:13');
INSERT INTO `login_info` VALUES (434, 'admin', '127.0.0.1', '内网IP', 'Chrome143', 'macOS10.15.7', '0', '登录成功', '2026-01-27 02:03:20');
INSERT INTO `login_info` VALUES (435, 'admin', '127.0.0.1', '内网IP', 'Chrome143', 'macOS10.15.7', '0', '登录成功', '2026-01-28 03:40:37');
INSERT INTO `login_info` VALUES (436, 'admin', '', '', 'Chrome143', 'macOS10.15.7', '1', '验证码错误', '2026-01-30 02:41:21');
INSERT INTO `login_info` VALUES (437, 'admin', '127.0.0.1', '内网IP', 'Chrome143', 'macOS10.15.7', '0', '登录成功', '2026-01-30 02:41:25');
INSERT INTO `login_info` VALUES (438, 'admin', '127.0.0.1', '内网IP', 'Chrome143', 'macOS10.15.7', '0', '登录成功', '2026-02-02 08:05:07');
INSERT INTO `login_info` VALUES (439, 'admin', '127.0.0.1', '内网IP', 'Chrome143', 'macOS10.15.7', '0', '登录成功', '2026-02-03 01:48:37');
INSERT INTO `login_info` VALUES (440, 'admin', '', '', 'Chrome143', 'macOS10.15.7', '1', '密码错误', '2026-02-03 13:36:44');
INSERT INTO `login_info` VALUES (441, 'admin', '', '', 'Chrome143', 'macOS10.15.7', '1', '密码错误', '2026-02-03 13:36:47');
INSERT INTO `login_info` VALUES (442, 'admin', '127.0.0.1', '内网IP', 'Chrome143', 'macOS10.15.7', '0', '登录成功', '2026-02-03 13:36:53');
INSERT INTO `login_info` VALUES (443, 'admin', '', '', 'Chrome143', 'macOS10.15.7', '1', '密码错误', '2026-02-04 14:50:25');
INSERT INTO `login_info` VALUES (444, 'admin', '127.0.0.1', '内网IP', 'Chrome143', 'macOS10.15.7', '0', '登录成功', '2026-02-04 14:50:30');
INSERT INTO `login_info` VALUES (445, 'admin', '127.0.0.1', '内网IP', 'Chrome143', 'macOS10.15.7', '0', '登录成功', '2026-02-04 14:52:17');
INSERT INTO `login_info` VALUES (446, 'admin', '127.0.0.1', '内网IP', 'Chrome143', 'macOS10.15.7', '0', '登录成功', '2026-02-04 14:57:07');
INSERT INTO `login_info` VALUES (447, 'admin', '127.0.0.1', '内网IP', 'Chrome143', 'macOS10.15.7', '0', '登录成功', '2026-02-05 02:08:38');
INSERT INTO `login_info` VALUES (448, 'admin', '127.0.0.1', '内网IP', 'Chrome143', 'macOS10.15.7', '0', '登录成功', '2026-02-06 03:42:48');
INSERT INTO `login_info` VALUES (449, 'admin', '127.0.0.1', '内网IP', 'Chrome143', 'macOS10.15.7', '0', '登录成功', '2026-02-07 03:53:49');
INSERT INTO `login_info` VALUES (450, 'admin', '127.0.0.1', '内网IP', 'Chrome144', 'macOS10.15.7', '0', '登录成功', '2026-02-09 03:16:39');
INSERT INTO `login_info` VALUES (451, 'admin', '127.0.0.1', '内网IP', 'Chrome144', 'macOS10.15.7', '0', '登录成功', '2026-02-10 01:42:38');
INSERT INTO `login_info` VALUES (452, 'admin', '127.0.0.1', 'Hunan Changsha', 'Chrome144', 'macOS10.15.7', '0', '登录成功', '2026-02-10 02:25:09');
INSERT INTO `login_info` VALUES (453, 'admin', '', '', 'Chrome144', 'macOS10.15.7', '1', '验证码错误', '2026-02-10 02:25:14');
INSERT INTO `login_info` VALUES (454, 'admin', '127.0.0.1', 'undefined undefined', 'Chrome144', 'macOS10.15.7', '0', '登录成功', '2026-02-10 02:25:23');
INSERT INTO `login_info` VALUES (455, 'admin', '', '', 'Chrome144', 'macOS10.15.7', '1', '密码错误', '2026-02-10 02:26:59');
INSERT INTO `login_info` VALUES (456, 'admin', '', '', 'Chrome144', 'macOS10.15.7', '1', '密码错误', '2026-02-10 02:27:15');
INSERT INTO `login_info` VALUES (457, 'admin', '', '', 'Chrome144', 'macOS10.15.7', '1', '密码错误', '2026-02-10 02:27:42');
INSERT INTO `login_info` VALUES (458, 'admin', '', '', 'Chrome144', 'macOS10.15.7', '1', '密码错误', '2026-02-10 02:28:05');
INSERT INTO `login_info` VALUES (459, 'admin', '', 'undefined undefined', 'Chrome144', 'macOS10.15.7', '1', '密码错误', '2026-02-10 02:28:57');
INSERT INTO `login_info` VALUES (460, 'admin', '', 'Hunan Changsha', 'Chrome144', 'macOS10.15.7', '1', '密码错误', '2026-02-10 02:29:44');
INSERT INTO `login_info` VALUES (461, 'admin', '', 'undefined undefined', 'Chrome144', 'macOS10.15.7', '1', '密码错误', '2026-02-10 02:29:59');
INSERT INTO `login_info` VALUES (462, 'admin', '', 'Hunan Changsha', 'Chrome144', 'macOS10.15.7', '1', '验证码错误', '2026-02-10 02:34:17');
INSERT INTO `login_info` VALUES (463, 'admin', '', 'Hunan Changsha', 'Chrome144', 'macOS10.15.7', '1', '密码错误', '2026-02-10 02:34:29');
INSERT INTO `login_info` VALUES (464, 'admin', '127.0.0.1', '内网IP', 'Chrome144', 'macOS10.15.7', '0', '登录成功', '2026-02-24 01:46:05');
INSERT INTO `login_info` VALUES (465, 'admin', '127.0.0.1', '内网IP', 'Chrome146', 'macOS10.15.7', '0', '登录成功', '2026-04-29 01:27:49');
INSERT INTO `login_info` VALUES (466, 'admin', '127.0.0.1', '内网IP', 'Chrome147', 'macOS10.15.7', '0', '登录成功', '2026-05-03 10:28:36');
INSERT INTO `login_info` VALUES (467, 'chunyu', '', '', 'Chrome147', 'macOS10.15.7', '1', '验证码错误', '2026-05-06 11:22:09');
INSERT INTO `login_info` VALUES (468, 'admin', '127.0.0.1', '内网IP', 'Chrome147', 'macOS10.15.7', '0', '登录成功', '2026-05-06 11:22:19');
INSERT INTO `login_info` VALUES (469, 'admin', '127.0.0.1', '内网IP', 'Chrome150', 'macOS10.15.7', '0', '登录成功', '2026-08-08 12:42:04');
COMMIT;

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu` (
  `menu_id` int NOT NULL AUTO_INCREMENT,
  `menu_name` varchar(50) NOT NULL,
  `order_num` int NOT NULL,
  `path` varchar(200) NOT NULL DEFAULT '',
  `component` varchar(255) DEFAULT NULL,
  `query` varchar(255) DEFAULT NULL,
  `is_frame` int NOT NULL DEFAULT '1',
  `is_cache` char(1) NOT NULL DEFAULT '0',
  `menu_type` char(1) NOT NULL DEFAULT '',
  `visible` char(1) NOT NULL DEFAULT '0',
  `status` char(1) NOT NULL DEFAULT '0',
  `perms` varchar(100) DEFAULT NULL,
  `icon` char(100) NOT NULL DEFAULT '#',
  `parent_menu_id` int DEFAULT '0',
  `mpath` varchar(255) DEFAULT NULL,
  `remark` varchar(500) DEFAULT '',
  `create_by` varchar(64) DEFAULT '',
  `create_time` datetime DEFAULT NULL,
  `update_by` varchar(64) DEFAULT '',
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=144 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of menu
-- ----------------------------
BEGIN;
INSERT INTO `menu` VALUES (1, '系统管理', 8, 'system', NULL, NULL, 1, '0', 'M', '0', '0', NULL, 'system', NULL, '1.', '', '', '2021-12-22 10:43:24', 'admin', '2023-01-16 11:35:17');
INSERT INTO `menu` VALUES (2, '系统监控', 9, 'monitor', NULL, NULL, 1, '0', 'M', '0', '0', NULL, 'monitor', 0, '', '', '', '2021-12-22 10:43:24', 'admin', '2024-12-14 08:48:41');
INSERT INTO `menu` VALUES (3, '系统工具', 10, 'tool', NULL, NULL, 1, '0', 'M', '1', '1', NULL, 'tool', 0, '', '', '', '2021-12-22 10:43:24', 'test', '2024-12-14 14:18:09');
INSERT INTO `menu` VALUES (4, '用户管理', 1, 'user', 'system/user/index', NULL, 1, '0', 'C', '0', '0', 'system:user:list', 'user', 1, '1.4.', '', '', '2021-12-22 10:43:24', '', '2023-01-16 11:35:17');
INSERT INTO `menu` VALUES (5, '角色管理', 2, 'role', 'system/role/index', NULL, 1, '0', 'C', '0', '0', 'system:role:list', 'peoples', 1, '1.5.', '', '', '2021-12-22 10:43:24', '', '2023-01-16 11:35:17');
INSERT INTO `menu` VALUES (6, '菜单管理', 3, 'menu', 'system/menu/index', NULL, 1, '0', 'C', '0', '0', 'system:menu:list', 'tree-table', 1, '1.6.', '', '', '2021-12-22 10:43:24', '', '2023-01-16 11:35:17');
INSERT INTO `menu` VALUES (7, '部门管理', 4, 'dept', 'system/dept/index', NULL, 1, '0', 'C', '0', '0', 'system:dept:list', 'tree', 1, '1.7.', '', '', '2021-12-22 10:43:24', '', '2023-01-16 11:35:17');
INSERT INTO `menu` VALUES (8, '岗位管理', 5, 'post', 'system/post/index', NULL, 1, '0', 'C', '0', '0', 'system:post:list', 'post', 1, '1.8.', '', '', '2021-12-22 10:43:24', '', '2023-01-16 11:35:17');
INSERT INTO `menu` VALUES (9, '字典管理', 6, 'dict', 'system/dict/index', NULL, 1, '0', 'C', '0', '0', 'system:dict:list', 'dict', 1, '1.9.', '', '', '2021-12-22 10:43:24', '', '2023-01-16 11:35:17');
INSERT INTO `menu` VALUES (10, '参数设置', 7, 'config', 'system/config/index', NULL, 1, '0', 'C', '0', '0', 'system:config:list', 'edit', 1, '1.10.', '', '', '2021-12-22 10:43:24', 'admin', '2025-01-02 01:50:19');
INSERT INTO `menu` VALUES (11, '通知公告', 8, 'notice', 'system/notice/index', NULL, 1, '0', 'C', '1', '1', 'system:notice:list', 'message', 1, '1.11.', '', '', '2021-12-22 10:43:24', 'admin', '2024-12-14 07:05:06');
INSERT INTO `menu` VALUES (12, '日志管理', 9, 'log', NULL, NULL, 1, '0', 'M', '0', '0', NULL, 'log', 1, '1.12.', '', '', '2021-12-22 10:43:24', '', '2023-01-16 11:35:17');
INSERT INTO `menu` VALUES (13, '操作日志', 1, 'operlog', 'monitor/operlog/index', NULL, 1, '0', 'C', '1', '1', 'monitor:operlog:list', 'form', 12, '1.12.13.', '', '', '2021-12-22 10:43:24', 'admin', '2024-12-14 07:05:01');
INSERT INTO `menu` VALUES (14, '登录日志', 2, 'logininfor', 'monitor/logininfor/index', NULL, 1, '0', 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 12, '1.12.14.', '', '', '2021-12-22 10:43:24', '', '2023-01-16 11:35:17');
INSERT INTO `menu` VALUES (15, '用户查询', 1, '', NULL, NULL, 1, '0', 'F', '0', '0', 'system:user:query', '#', 4, '1.4.15.', '', '', '2021-12-22 10:43:24', '', '2023-01-16 11:35:17');
INSERT INTO `menu` VALUES (16, '用户新增', 2, '', NULL, NULL, 1, '0', 'F', '0', '0', 'system:user:add', '#', 4, '1.4.16.', '', '', '2021-12-22 10:43:24', '', '2023-01-16 11:35:17');
INSERT INTO `menu` VALUES (17, '用户修改', 3, '', NULL, NULL, 1, '0', 'F', '0', '0', 'system:user:edit', '#', 4, '1.4.17.', '', '', '2021-12-22 10:43:24', '', '2023-01-16 11:35:17');
INSERT INTO `menu` VALUES (18, '用户删除', 4, '', NULL, NULL, 1, '0', 'F', '0', '0', 'system:user:remove', '#', 4, '1.4.18.', '', '', '2021-12-22 10:43:24', '', '2023-01-16 11:35:17');
INSERT INTO `menu` VALUES (19, '用户导出', 5, '', NULL, NULL, 1, '0', 'F', '0', '0', 'system:user:export', '#', 4, '1.4.19.', '', '', '2021-12-22 10:43:24', '', '2023-01-16 11:35:17');
INSERT INTO `menu` VALUES (20, '用户导入', 6, '', NULL, NULL, 1, '0', 'F', '0', '0', 'system:user:import', '#', 4, '1.4.20.', '', '', '2021-12-22 10:43:24', '', '2023-01-16 11:35:17');
INSERT INTO `menu` VALUES (21, '重置密码', 7, '', NULL, NULL, 1, '0', 'F', '0', '0', 'system:user:resetPwd', '#', 4, '1.4.21.', '', '', '2021-12-22 10:43:24', '', '2023-01-16 11:35:17');
INSERT INTO `menu` VALUES (22, '角色查询', 1, '', NULL, NULL, 1, '0', 'F', '0', '0', 'system:role:query', '#', 5, '1.5.22.', '', '', '2021-12-22 10:43:24', '', '2023-01-16 11:35:17');
INSERT INTO `menu` VALUES (23, '角色新增', 2, '', NULL, NULL, 1, '0', 'F', '0', '0', 'system:role:add', '#', 5, '1.5.23.', '', '', '2021-12-22 10:43:24', '', '2023-01-16 11:35:17');
INSERT INTO `menu` VALUES (24, '角色修改', 3, '', NULL, NULL, 1, '0', 'F', '0', '0', 'system:role:edit', '#', 5, '1.5.24.', '', '', '2021-12-22 10:43:24', '', '2023-01-16 11:35:17');
INSERT INTO `menu` VALUES (25, '角色删除', 4, '', NULL, NULL, 1, '0', 'F', '0', '0', 'system:role:remove', '#', 5, '1.5.25.', '', '', '2021-12-22 10:43:24', '', '2023-01-16 11:35:17');
INSERT INTO `menu` VALUES (26, '菜单查询', 1, '', NULL, NULL, 1, '0', 'F', '0', '0', 'system:menu:query', '#', 6, '1.6.26.', '', '', '2021-12-22 10:43:24', '', '2023-01-16 11:35:17');
INSERT INTO `menu` VALUES (27, '菜单新增', 2, '', NULL, NULL, 1, '0', 'F', '0', '0', 'system:menu:add', '#', 6, '1.6.27.', '', '', '2021-12-22 10:43:24', '', '2023-01-16 11:35:17');
INSERT INTO `menu` VALUES (28, '菜单修改', 3, '', NULL, NULL, 1, '0', 'F', '0', '0', 'system:menu:edit', '#', 6, '1.6.28.', '', '', '2021-12-22 10:43:24', '', '2023-01-16 11:35:17');
INSERT INTO `menu` VALUES (29, '菜单删除', 4, '', NULL, NULL, 1, '0', 'F', '0', '0', 'system:menu:remove', '#', 6, '1.6.29.', '', '', '2021-12-22 10:43:24', '', '2023-01-16 11:35:17');
INSERT INTO `menu` VALUES (30, '部门查询', 1, '', NULL, NULL, 1, '0', 'F', '0', '0', 'system:dept:query', '#', 7, '1.7.30.', '', '', '2021-12-22 10:43:24', '', '2023-01-16 11:35:17');
INSERT INTO `menu` VALUES (31, '部门新增', 2, '', NULL, NULL, 1, '0', 'F', '0', '0', 'system:dept:add', '#', 7, '1.7.31.', '', '', '2021-12-22 10:43:24', '', '2023-01-16 11:35:17');
INSERT INTO `menu` VALUES (32, '部门修改', 3, '', NULL, NULL, 1, '0', 'F', '0', '0', 'system:dept:edit', '#', 7, '1.7.32.', '', '', '2021-12-22 10:43:24', '', '2023-01-16 11:35:17');
INSERT INTO `menu` VALUES (33, '部门删除', 4, '', NULL, NULL, 1, '0', 'F', '0', '0', 'system:dept:remove', '#', 7, '1.7.33.', '', '', '2021-12-22 10:43:24', '', '2023-01-16 11:35:17');
INSERT INTO `menu` VALUES (34, '公告新增', 2, '', NULL, NULL, 1, '0', 'F', '0', '0', 'system:notice:add', '#', 11, '1.11.34.', '', '', '2021-12-22 10:43:24', '', '2023-01-16 11:35:17');
INSERT INTO `menu` VALUES (35, '公告查询', 1, '', NULL, NULL, 1, '0', 'F', '0', '0', 'system:notice:query', '#', 11, '1.11.35.', '', '', '2021-12-22 10:43:24', '', '2023-01-16 11:35:17');
INSERT INTO `menu` VALUES (36, '公告修改', 3, '', NULL, NULL, 1, '0', 'F', '0', '0', 'system:notice:edit', '#', 11, '1.11.36.', '', '', '2021-12-22 10:43:24', '', '2023-01-16 11:35:17');
INSERT INTO `menu` VALUES (37, '公告删除', 4, '', NULL, NULL, 1, '0', 'F', '0', '0', 'system:notice:remove', '#', 11, '1.11.37.', '', '', '2021-12-22 10:43:24', '', '2023-01-16 11:35:17');
INSERT INTO `menu` VALUES (38, '岗位查询', 1, '', NULL, NULL, 1, '0', 'F', '0', '0', 'system:post:query', '#', 8, '1.8.38.', '', '', '2021-12-22 13:42:28', '', '2023-01-16 11:35:17');
INSERT INTO `menu` VALUES (39, '岗位新增', 2, '', NULL, NULL, 1, '0', 'F', '0', '0', 'system:post:add', '#', 8, '1.8.39.', '', '', '2021-12-22 13:42:50', '', '2023-01-16 11:35:17');
INSERT INTO `menu` VALUES (40, '岗位修改', 3, '', NULL, NULL, 1, '0', 'F', '0', '0', 'system:post:edit', '#', 8, '1.8.40.', '', '', '2021-12-22 13:43:09', '', '2023-01-16 11:35:17');
INSERT INTO `menu` VALUES (41, '岗位删除', 4, '', NULL, NULL, 1, '0', 'F', '0', '0', 'system:post:remove', '#', 8, '1.8.41.', '', '', '2021-12-22 13:43:43', '', '2023-01-16 11:35:17');
INSERT INTO `menu` VALUES (42, '岗位导出', 5, '', NULL, NULL, 1, '0', 'F', '0', '0', 'system:post:export', '#', 8, '1.8.42.', '', '', '2021-12-22 13:45:04', '', '2023-01-16 11:35:17');
INSERT INTO `menu` VALUES (43, '在线用户', 1, 'online', 'monitor/online/index', NULL, 1, '0', 'C', '0', '0', 'monitor:online:list', 'online', 2, '2.43.', '', '', '2021-12-23 21:10:14', '', '2023-01-16 11:34:54');
INSERT INTO `menu` VALUES (44, '表单构建', 1, 'build', 'tool/build/index', NULL, 1, '0', 'C', '1', '0', 'tool:build:list', 'build', 3, '3.44.', '', '', '2021-12-24 11:19:41', 'admin', '2023-01-29 15:57:10');
INSERT INTO `menu` VALUES (45, '系统接口', 2, 'swagger', 'tool/swagger/index', NULL, 1, '0', 'C', '0', '0', 'tool:swagger:list', 'swagger', 3, '3.45.', '', '', '2021-12-24 11:20:28', '', '2023-01-16 11:34:45');
INSERT INTO `menu` VALUES (46, '定时任务', 2, 'job', 'monitor/job/index', NULL, 1, '0', 'C', '0', '0', 'monitor:job:list', 'job', 2, '46.', '', '', '2021-12-24 11:53:24', 'admin', '2024-12-21 15:24:39');
INSERT INTO `menu` VALUES (48, '服务监控', 4, 'server', 'monitor/server/index', NULL, 1, '0', 'C', '0', '0', 'monitor:server:list', 'server', 2, '2.48.', '', '', '2021-12-24 11:55:16', '', '2023-01-16 11:34:54');
INSERT INTO `menu` VALUES (49, '字典查询', 1, '', NULL, NULL, 1, '0', 'F', '0', '0', 'system:dict:query', '#', 9, '1.9.49.', '', '', '2021-12-29 14:58:27', '', '2023-01-16 11:35:17');
INSERT INTO `menu` VALUES (50, '字典新增', 2, '', NULL, NULL, 1, '0', 'F', '0', '0', 'system:dict:add', '#', 9, '1.9.50.', '', '', '2021-12-29 14:59:15', '', '2023-01-16 11:35:17');
INSERT INTO `menu` VALUES (51, '字典修改', 3, '', NULL, NULL, 1, '0', 'F', '0', '0', 'system:dict:edit', '#', 9, '1.9.51.', '', '', '2021-12-29 15:01:08', '', '2023-01-16 11:35:17');
INSERT INTO `menu` VALUES (52, '字典删除', 4, '', NULL, NULL, 1, '0', 'F', '0', '0', 'system:dict:remove', '#', 9, '1.9.52.', '', '', '2021-12-29 15:03:37', '', '2023-01-16 11:35:17');
INSERT INTO `menu` VALUES (53, '字典导出', 5, '', NULL, NULL, 1, '0', 'F', '0', '0', 'system:dict:export', '#', 9, '1.9.53.', '', '', '2021-12-29 15:06:54', '', '2023-01-16 11:35:17');
INSERT INTO `menu` VALUES (54, '参数查询', 1, '', NULL, NULL, 1, '0', 'F', '0', '0', 'system:config:query', '#', 10, '1.10.54.', '', '', '2021-12-29 15:07:37', '', '2023-01-16 11:35:17');
INSERT INTO `menu` VALUES (55, '参数新增', 2, '', NULL, NULL, 1, '0', 'F', '0', '0', 'system:config:add', '#', 10, '1.10.55.', '', '', '2021-12-29 15:15:51', '', '2023-01-16 11:35:17');
INSERT INTO `menu` VALUES (56, '参数修改', 3, '', NULL, NULL, 1, '0', 'F', '0', '0', 'system:config:edit', '#', 10, '1.10.56.', '', '', '2021-12-29 15:29:36', '', '2023-01-16 11:35:17');
INSERT INTO `menu` VALUES (57, '参数删除', 4, '', NULL, NULL, 1, '0', 'F', '0', '0', 'system:config:remove', '#', 10, '1.10.57.', '', '', '2021-12-29 15:30:05', '', '2023-01-16 11:35:17');
INSERT INTO `menu` VALUES (58, '参数导出', 5, '', NULL, NULL, 1, '0', 'F', '0', '0', 'system:config:export', '#', 10, '1.10.58.', '', '', '2021-12-29 15:30:33', '', '2023-01-16 11:35:17');
INSERT INTO `menu` VALUES (59, '操作查询', 1, '', NULL, NULL, 1, '0', 'F', '0', '0', 'monitor:operlog:query', '#', 13, '1.12.13.59.', '', '', '2021-12-29 15:31:40', '', '2023-01-16 11:35:17');
INSERT INTO `menu` VALUES (60, '操作删除', 2, '', NULL, NULL, 1, '0', 'F', '0', '0', 'monitor:operlog:remove', '#', 13, '1.12.13.60.', '', '', '2021-12-29 15:33:25', '', '2023-01-16 11:35:17');
INSERT INTO `menu` VALUES (61, '日志导出', 4, '', NULL, NULL, 1, '0', 'F', '0', '0', 'monitor:operlog:export', '#', 13, '1.12.13.61.', '', '', '2021-12-29 15:33:58', '', '2023-01-16 11:35:17');
INSERT INTO `menu` VALUES (62, '登录查询', 1, '', NULL, NULL, 1, '0', 'F', '0', '0', 'monitor:logininfor:query', '#', 14, '1.12.14.62.', '', '', '2021-12-29 15:34:24', '', '2023-01-16 11:35:17');
INSERT INTO `menu` VALUES (63, '登录删除', 2, '', NULL, NULL, 1, '0', 'F', '0', '0', 'monitor:logininfor:remove', '#', 14, '1.12.14.63.', '', '', '2021-12-29 15:34:36', '', '2023-01-16 11:35:17');
INSERT INTO `menu` VALUES (64, '日志导出', 3, '', NULL, NULL, 1, '0', 'F', '0', '0', 'monitor:logininfor:export', '#', 14, '1.12.14.64.', '', '', '2021-12-29 15:34:46', '', '2023-01-16 11:35:17');
INSERT INTO `menu` VALUES (65, '在线查询', 1, '', NULL, NULL, 1, '0', 'F', '0', '0', 'monitor:online:query', '#', 43, '2.43.65.', '', '', '2021-12-29 15:35:26', '', '2023-01-16 11:34:54');
INSERT INTO `menu` VALUES (66, '批量强退', 2, '', NULL, NULL, 1, '0', 'F', '0', '0', 'monitor:online:batchLogout', '#', 43, '2.43.66.', '', '', '2021-12-29 15:35:40', '', '2023-01-16 11:34:54');
INSERT INTO `menu` VALUES (67, '单条强退', 3, '', NULL, NULL, 1, '0', 'F', '0', '0', 'monitor:online:forceLogout', '#', 43, '2.43.67.', '', '', '2021-12-29 15:35:51', '', '2023-01-16 11:34:54');
INSERT INTO `menu` VALUES (68, '任务查询', 1, '', NULL, NULL, 1, '0', 'F', '0', '0', 'monitor:job:query', '#', 46, '2.46.68.', '', '', '2021-12-29 15:36:13', '', '2023-01-16 11:34:54');
INSERT INTO `menu` VALUES (69, '任务新增', 2, '', NULL, NULL, 1, '0', 'F', '0', '0', 'monitor:job:add', '#', 46, '2.46.69.', '', '', '2021-12-29 15:36:25', '', '2023-01-16 11:34:54');
INSERT INTO `menu` VALUES (70, '任务修改', 3, '', NULL, NULL, 1, '0', 'F', '0', '0', 'monitor:job:edit', '#', 46, '2.46.70.', '', '', '2021-12-29 15:36:36', '', '2023-01-16 11:34:54');
INSERT INTO `menu` VALUES (71, '任务删除', 4, '', NULL, NULL, 1, '0', 'F', '0', '0', 'monitor:job:remove', '#', 46, '2.46.71.', '', '', '2021-12-29 15:36:48', '', '2023-01-16 11:34:54');
INSERT INTO `menu` VALUES (72, '状态修改', 5, '', NULL, NULL, 1, '0', 'F', '0', '0', 'monitor:job:changeStatus', '#', 46, '2.46.72.', '', '', '2021-12-29 15:36:58', '', '2023-01-16 11:34:54');
INSERT INTO `menu` VALUES (73, '任务导出', 7, '', NULL, NULL, 1, '0', 'F', '0', '0', 'monitor:job:export', '#', 46, '2.46.73.', '', '', '2021-12-29 15:37:31', '', '2023-01-16 11:34:54');
INSERT INTO `menu` VALUES (93, '缓存管理', 1, 'cache', 'monitor/cache/index', NULL, 1, '0', 'C', '0', '0', 'monitor:cache:list', 'redis', 2, '2.93.', '', 'admin', '2023-03-27 14:14:04', 'admin', '2023-03-27 15:06:32');
INSERT INTO `menu` VALUES (96, '缓存查询', 1, '', NULL, NULL, 1, '0', 'F', '0', '0', 'monitor:cache:query', '#', 93, '2.93.96.', '', 'admin', '2023-03-27 16:08:06', 'admin', '2023-03-27 16:08:20');
INSERT INTO `menu` VALUES (97, '缓存删除', 2, '', NULL, NULL, 1, '0', 'F', '0', '0', 'monitor:cache:remove', '#', 93, '2.93.97.', '', 'admin', '2023-03-27 16:09:19', 'admin', '2023-03-27 16:09:50');
INSERT INTO `menu` VALUES (118, 'CMS管理', 10, 'cms', NULL, NULL, 1, '0', 'M', '0', '0', '', 'documentation', 0, NULL, '', '', '2026-01-27 11:35:21', '', '2026-01-27 11:35:21');
INSERT INTO `menu` VALUES (119, '栏目管理', 1, 'category', 'cms/category/index', NULL, 1, '0', 'C', '0', '0', 'cms:category:list', 'tree', 118, NULL, '', '', '2026-01-27 11:35:21', '', '2026-01-27 11:35:21');
INSERT INTO `menu` VALUES (120, '分类查询', 1, '', '', NULL, 1, '0', 'F', '0', '0', 'cms:category:query', '', 119, NULL, '', '', '2026-01-27 11:35:21', '', '2026-01-27 11:35:21');
INSERT INTO `menu` VALUES (121, '分类新增', 2, '', '', NULL, 1, '0', 'F', '0', '0', 'cms:category:add', '', 119, NULL, '', '', '2026-01-27 11:35:21', '', '2026-01-27 11:35:21');
INSERT INTO `menu` VALUES (122, '分类修改', 3, '', '', NULL, 1, '0', 'F', '0', '0', 'cms:category:edit', '', 119, NULL, '', '', '2026-01-27 11:35:21', '', '2026-01-27 11:35:21');
INSERT INTO `menu` VALUES (123, '分类删除', 4, '', '', NULL, 1, '0', 'F', '0', '0', 'cms:category:remove', '', 119, NULL, '', '', '2026-01-27 11:35:21', '', '2026-01-27 11:35:21');
INSERT INTO `menu` VALUES (124, '新闻管理', 2, 'news', 'cms/news/index', NULL, 1, '0', 'C', '0', '0', 'cms:news:list', 'example', 118, NULL, '', '', '2026-01-27 11:35:21', '', '2026-01-27 11:35:21');
INSERT INTO `menu` VALUES (125, '新闻查询', 1, '', '', NULL, 1, '0', 'F', '0', '0', 'cms:news:query', '', 124, NULL, '', '', '2026-01-27 11:35:21', '', '2026-01-27 11:35:21');
INSERT INTO `menu` VALUES (126, '新闻新增', 2, '', '', NULL, 1, '0', 'F', '0', '0', 'cms:news:add', '', 124, NULL, '', '', '2026-01-27 11:35:21', '', '2026-01-27 11:35:21');
INSERT INTO `menu` VALUES (127, '新闻修改', 3, '', '', NULL, 1, '0', 'F', '0', '0', 'cms:news:edit', '', 124, NULL, '', '', '2026-01-27 11:35:21', '', '2026-01-27 11:35:21');
INSERT INTO `menu` VALUES (128, '新闻删除', 4, '', '', NULL, 1, '0', 'F', '0', '0', 'cms:news:remove', '', 124, NULL, '', '', '2026-01-27 11:35:21', '', '2026-01-27 11:35:21');
INSERT INTO `menu` VALUES (129, '产品管理', 3, 'product', 'cms/product/index', NULL, 1, '0', 'C', '0', '0', 'cms:product:list', 'shopping', 118, NULL, '', '', '2026-01-27 11:35:21', '', '2026-01-27 11:35:21');
INSERT INTO `menu` VALUES (130, '产品查询', 1, '', '', NULL, 1, '0', 'F', '0', '0', 'cms:product:query', '', 129, NULL, '', '', '2026-01-27 11:35:21', '', '2026-01-27 11:35:21');
INSERT INTO `menu` VALUES (131, '产品新增', 2, '', '', NULL, 1, '0', 'F', '0', '0', 'cms:product:add', '', 129, NULL, '', '', '2026-01-27 11:35:21', '', '2026-01-27 11:35:21');
INSERT INTO `menu` VALUES (132, '产品修改', 3, '', '', NULL, 1, '0', 'F', '0', '0', 'cms:product:edit', '', 129, NULL, '', '', '2026-01-27 11:35:21', '', '2026-01-27 11:35:21');
INSERT INTO `menu` VALUES (133, '产品删除', 4, '', '', NULL, 1, '0', 'F', '0', '0', 'cms:product:remove', '', 129, NULL, '', '', '2026-01-27 11:35:21', '', '2026-01-27 11:35:21');
INSERT INTO `menu` VALUES (134, '内容页管理', 5, 'content', 'cms/content/index', NULL, 1, '0', 'C', '0', '0', NULL, 'edit', 118, '134.', '', 'admin', '2025-12-05 08:54:28', 'admin', '2025-12-05 08:54:28');
INSERT INTO `menu` VALUES (135, '轮播图管理', 1, 'banner', 'cms/banner/index', NULL, 1, '0', 'C', '0', '0', NULL, 'druid', 118, '135.', '', 'admin', '2025-12-05 08:54:28', 'admin', '2026-02-03 14:47:21');
INSERT INTO `menu` VALUES (136, '留言咨询', 6, 'contact', 'cms/contact/index', NULL, 1, '0', 'C', '0', '0', NULL, 'form', 118, '136.', '', 'admin', '2025-12-05 08:54:28', 'admin', '2025-12-05 08:54:28');
INSERT INTO `menu` VALUES (137, '首页SEO配置', 7, 'seo', 'cms/seo/index', NULL, 1, '0', 'C', '0', '0', NULL, 'example', 118, '137.', '', 'admin', '2025-12-05 08:54:28', 'admin', '2025-12-05 08:54:28');
INSERT INTO `menu` VALUES (138, '多语言配置', 9, 'i18n', 'system/i18n/index', NULL, 1, '0', 'C', '0', '0', NULL, 'server', 1, '1.138.', '', 'admin', NULL, 'admin', '2026-02-05 02:10:13');
INSERT INTO `menu` VALUES (139, 'AI配置管理', 10, 'aiConfig', 'system/aiConfig/index', NULL, 1, '0', 'C', '0', '0', 'system:aiConfig:list', 'validCode', 1, '1.139.', 'AI服务配置管理菜单', 'admin', '2026-02-06 11:40:47', 'admin', '2026-02-06 03:45:12');
INSERT INTO `menu` VALUES (140, 'AI配置新增', 1, '', '', NULL, 1, '0', 'F', '0', '0', 'system:aiConfig:add', '#', 139, NULL, '', 'admin', '2026-02-06 11:40:47', 'admin', '2026-02-06 11:40:47');
INSERT INTO `menu` VALUES (141, 'AI配置修改', 2, '', '', NULL, 1, '0', 'F', '0', '0', 'system:aiConfig:edit', '#', 139, NULL, '', 'admin', '2026-02-06 11:40:47', 'admin', '2026-02-06 11:40:47');
INSERT INTO `menu` VALUES (142, 'AI配置删除', 3, '', '', NULL, 1, '0', 'F', '0', '0', 'system:aiConfig:remove', '#', 139, NULL, '', 'admin', '2026-02-06 11:40:47', 'admin', '2026-02-06 11:40:47');
INSERT INTO `menu` VALUES (143, 'AI配置导出', 4, '', '', NULL, 1, '0', 'F', '0', '0', 'system:aiConfig:export', '#', 139, NULL, '', 'admin', '2026-02-06 11:40:47', 'admin', '2026-02-06 11:40:47');
COMMIT;

-- ----------------------------
-- Table structure for navigation_config
-- ----------------------------
DROP TABLE IF EXISTS `navigation_config`;
CREATE TABLE `navigation_config` (
  `id` int NOT NULL AUTO_INCREMENT,
  `display_name` json DEFAULT (_utf8mb4'{"zh":"","en":""}'),
  `web_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `mobile_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `img_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `is_new_window` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0',
  `is_enabled` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0',
  `sort_order` int DEFAULT '0',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '',
  `create_time` datetime DEFAULT NULL,
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '',
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Table structure for news
-- ----------------------------
DROP TABLE IF EXISTS `news`;
CREATE TABLE `news` (
  `news_id` int NOT NULL AUTO_INCREMENT,
  `title` json DEFAULT (_utf8mb4'{"zh":"","en":""}'),
  `content` json DEFAULT (_utf8mb4'{"zh":"","en":""}'),
  `summary` json DEFAULT (_utf8mb4'{"zh":"","en":""}'),
  `category_id` int DEFAULT NULL,
  `cover_image` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `source` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `is_top` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0',
  `is_recommend` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0',
  `view_count` int DEFAULT '0',
  `publish_time` datetime DEFAULT NULL,
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '',
  `create_time` datetime DEFAULT NULL,
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '',
  `update_time` datetime DEFAULT NULL,
  `keywords` json DEFAULT (_utf8mb4'{"zh":"","en":""}'),
  PRIMARY KEY (`news_id`),
  KEY `news_category_id_category_category_id_fk` (`category_id`),
  KEY `idx_news_list_sort` (`del_flag`,`is_top`,`publish_time`,`create_time`),
  KEY `idx_news_category` (`category_id`),
  KEY `idx_news_status` (`status`),
  CONSTRAINT `news_category_id_category_category_id_fk` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of news
-- ----------------------------
BEGIN;
INSERT INTO `news` VALUES (1, '{\"en\": \"The market for cemented carbide tools\", \"zh\": \"CTT 展会第一天｜聚焦莫斯科，世界舞台\"}', '{\"en\": \"<p>The market for cemented carbide tools</p>\", \"zh\": \"<p>全球碳化物工具的市场规模在2023年的价值为110.3亿美元。预计到2024年，该市场将从2024年的1,15.4亿美元增长到2032年的184.1亿美元，在预测期间的复合年增长率为6.0％。欧洲在2023年以34.81％的份额占据了全球市场。</p>\\n<p>&nbsp;</p>\\n<p>这些工具也称为水泥碳化物或碳化物的切割工具。在过去的几十年中，碳化物切割工具或插入物一直是制造业中最广泛使用的工具。它是由钨粉和碳化物粉制造的。这些材料比钢（钢的硬度三次），供热，快速速度，减少回收时间且价格较低。来自金属制造，汽车，建筑，家具和工业机制等各种行业的这些产品的需求增加，这些产品推动了全球市场的增长。&nbsp; 这些工具是切割工具的一种形式，并利用了重型机器，例如钻机机，CNC机器，车床机和铣床。碳化物车床工具在航空航天，汽车和建筑等各个行业的普及是预期在预测期内推动市场增长的关键因素。</p>\\n<p>&nbsp;</p>\\n<p>预计全球市场将在预测期间显着增长，因为主要参与者引入了新颖的耐磨成绩，并扩大了各种直径范围的倾斜工具。预计现有产品线的这种产品开发将提高对这些工具的需求并推动市场的增长。住宅和商业建设活动的增加，这反过来又增加了全球公共基础设施的投资，这反过来又增加了对钻头的需求，从而推动了市场增长。</p>\"}', '{\"en\": \"The global market size of carbide tools was valued at 11.03 billion US dollars in 2023. It is projected that by 2024, the market will grow from 11.54 billion US dollars in 2024 to 18.41 billion US dollars in 2032, with a compound annual growth rate of 6.0% during the forecast period.\", \"zh\": \"全球碳化物工具的市场规模在2023年的价值为110.3亿美元。预计到2024年，该市场将从2024年的1,15.4亿美元增长到2032年的184.1亿美元，在预测期间的复合年增长率为6.0％。\"}', 1, 'http://127.0.0.1:3000/uploads/2026-01-30/ccdAMGlGo.jpeg', NULL, NULL, '0', '1', 48, '2026-01-27 14:48:33', '1', '0', '', 'admin', NULL, 'admin', NULL, '{\"en\": \"\", \"zh\": \"\"}');
INSERT INTO `news` VALUES (2, '{\"en\": \"Video generation has entered the \\\"all-round\\\" era.\", \"ja\": \"ビデオ生成が「万能」時代に突入する。\", \"zh\": \"视频生成进入“全能”时代\"}', '{\"en\": \"<p>On January 29th, Skywork AI officially open - sourced its self - developed video generation model, SkyReels - V3. As a series of multi - modal video generation models, this series supports three core capabilities: Reference Images - to - Video, Video Extension, and Talking Avatar. It achieves high - fidelity multi - modal video generation within a single modeling architecture, reaching the industry\'s leading level.</p><p><br></p><p>The three core capabilities serve as independent modules, each deeply optimized and supporting flexible combination. The Skywork AI team achieved this through technologies such as enterprise - level data processing, ultra - fast inference capabilities, and an efficient training architecture, enabling the generated videos to reach a professional - grade effect, with multiple indicators reaching or exceeding the industry\'s leading level.</p><p><br></p><p>SkyReels - V3 can generate high - quality video sequences with consistent timing and semantics based on 1 to 4 reference images combined with text prompts. Whether it\'s a character image, product display, or background scene, the generated videos can accurately preserve the original identity features, spatial composition, and narrative coherence.</p><p><br></p><p>Behind it are multiple technological innovations of the Skywork AI team in data construction, multi - reference condition fusion, and hybrid training strategies:</p><p>1. High - quality data construction: The team screened materials with significant dynamic movements from a vast amount of videos and adopted a cross - frame pairing strategy to ensure temporal diversity. More importantly, they used an image editing model to extract the main subject area, complete the background, and rewrite semantics, effectively avoiding the common \\\"copy - paste\\\" artifacts and ensuring the generation quality from the data source.</p><p>2. Multi - reference condition fusion: The model uses a unified strategy to jointly encode visual and text information, supporting up to 4 reference images. This means that users can achieve natural interaction and scene combination of complex multi - subjects and multi - elements without complex image stitching or manual masking. For example, in the e - commerce scenario, product images can be combined with virtual anchor images to directly generate a product - promotion video in a specific environment, accurately preserving product details and the anchor\'s identity features.</p><p>3. Hybrid training strategy: The team used image - video hybrid training, jointly leveraging large - scale image and video datasets, and used multi - resolution joint optimization to improve the robustness of different spatial scales and aspect ratios.</p><p>In an evaluation of a mixed test set containing 200 pairs (covering multiple fields such as movies, TV, e - commerce, and advertising), SkyReels - V3 demonstrated excellent performance.</p><p>Facing various reference types such as people, animals, objects, and background scenes, SkyReels - V3 achieved a reference consistency index of 0.6698, surpassing mainstream commercial models such as Vidu Q2 (0.5961), Kling 1.6 (0.6630), and PixVerse V5 (0.6542). It also led the field with a score of 0.8119 in the visual quality index, proving its powerful ability to generate high - fidelity videos while maintaining reference features. </p>\", \"ja\": \"<p>1月29日、Skywork AIは自社開発のビデオ生成モデル「SkyReels - V3」を正式にオープンソース化しました。この一連のマルチモーダルビデオ生成モデルは、参照画像からビデオへの変換（Reference Images - to - Video）、ビデオの延長（Video Extension）、音声駆動のバーチャルアバター（Talking Avatar）という3つの核心機能をサポートし、単一のモデリングアーキテクチャで高忠実度のマルチモーダルビデオ生成を実現し、業界トップレベルに達しています。</p><p>3つの核心機能は独立したモジュールとして、それぞれのモジュールが深度に最適化され、柔軟な組み合わせが可能です。Skywork AIチームは、企業レベルのデータ処理、高速推論能力、効率的なトレーニングアーキテクチャなどの技術を通じて、生成されるビデオを専門レベルの品質にし、多くの指標が業界トップレベルに達し、またはそれを上回っています。</p><p>SkyReels - V3は、1～4枚の参照画像を元に、テキストプロンプトを組み合わせることで、時間的に連続し、意味的に一貫した高品質のビデオシーケンスを生成できます。人物像、商品展示、背景シーンなど、生成されたビデオは元のアイデンティティ特徴、空間構図、物語の一貫性を正確に保持します。</p><p>その背景には、Skywork AIチームがデータ構築、多参照条件の融合、ハイブリッドトレーニング戦略において行った多重の技術革新があります。</p><p>1. 高品質のデータ構築：チームは大量のビデオから顕著な動的運動を持つ素材を選別し、フレーム間のペアリング戦略を採用して時間的な多様性を確保します。さらに重要なのは、画像編集モデルを利用して主体領域を抽出し、背景を補完し、意味を再記述することで、一般的な「コピー＆ペースト」の偽影を効果的に回避し、データの源から生成品質を保障しています。</p><p>2. 多参照条件の融合：モデルは統一的な戦略で視覚情報とテキスト情報を統合してエンコードし、最大4枚の参照画像をサポートします。これにより、ユーザーは複雑な画像の結合や手動によるマスク操作を行うことなく、複雑な多主体、多要素の自然な相互作用とシーンの組み合わせを実現できます。例えば、電子商取引のシーンでは、商品画像とバーチャルアナウンサーの画像を組み合わせて、特定の環境下での商品販売ビデオを直接生成でき、商品の詳細とアナウンサーのアイデンティティ特徴を正確に保持します。</p><p>3. ハイブリッドトレーニング戦略：チームは画像とビデオのハイブリッドトレーニングを利用し、大規模な画像とビデオのデータセットを統合して利用し、多解像度の統合最適化を行って、異なる空間スケールと縦横比に対するロバスト性を向上させています。</p><p>映画・テレビ、電子商取引、広告など多領域をカバーする200組のハイブリッドテストセットを含む評価で、SkyReels - V3は卓越した性能を発揮しました。</p><p>人物、動物、物体、背景シーンなどの多様な参照タイプに対して、SkyReels - V3は参照一致性指標で0.6698を達成し、Vidu Q2（0.5961）、Kling 1.6（0.6630）、PixVerse V5（0.6542）などの主流の商用モデルを上回りました。視覚品質指標では0.8119の得点でトップを占め、参照特徴を保持しながら高忠実度のビデオを生成する強力な能力を証明しました。</p>\", \"zh\": \"<p>1月29日，Skywork AI正式开源自研视频生成模型SkyReels-V3。作为一系列多模态视频生成模型，该系列支持参考图像转视频（Reference Images-to-Video）、视频延长（Video Extension）和音频驱动虚拟形象（Talking Avatar）三大核心能力，在单一建模架构中实现高保真多模态视频生成，达到行业领先水平。</p><p>三大核心能力作为独立模块，每个模块深度优化且支持灵活组合。Skywork AI团队通过企业级数据处理、极速推理能力和高效的训练架构等技术实现，让生成的视频达到专业级效果，多项指标达到或超越行业领先水平。</p><p>SkyReels-V3可根据1至4张参考图像，并结合文本提示，生成时间连贯、语义一致的高质量视频序列。无论是人物形象、商品展示还是背景场景，生成的视频都能精准保留原始身份特征、空间构图和叙事连贯性。</p><p>其背后是Skywork AI团队在数据构建、多参考条件融合和混合训练策略上的多重技术创新：</p><p>1. 高质量数据构建：团队从海量视频中筛选具有显著动态运动的素材，并采用跨帧配对策略确保时间多样性。更为关键的是，利用图像编辑模型对主体区域进行提取、背景补全和语义重写，有效避免了常见的“复制粘贴”伪影，从数据源头保障了生成质量。</p><p>2. 多参考条件融合：模型采用统一的策略联合编码视觉和文本信息，最多支持4张参考图像。这意味着用户无需进行复杂的图像拼接或手动蒙版，即可实现复杂多主体、多元素的自然交互与场景组合。例如，在电商场景中，可将商品图与虚拟主播形象结合，直接生成一段在特定环境下的带货视频，精准保留商品细节与主播身份特征。</p><p>3. 混合训练策略：团队利用图像-视频混合训练，联合利用大规模图像和视频数据集，且利用多分辨率联合优化提升不同空间尺度和宽高比的鲁棒性。</p><p>在包含200对混合测试集（涵盖电影电视、电商、广告等多领域）的评估中，SkyReels-V3展现出卓越的性能表现。</p><p>面对人物、动物、物体和背景场景等多种参考类型，SkyReels-V3在参考一致性指标上达到0.6698，超越Vidu Q2（0.5961）、Kling 1.6（0.6630）和PixVerse V5（0.6542）等主流商用模型；在视觉质量指标上更以0.8119的得分领先全场，证明了其在保持参考特征的同时生成高保真视频的强大能力。</p>\"}', '{\"en\": \"Kunlun Wanwei\'s SkyReels-V3 is open-sourced, covering three core capabilities: reference image-to-video conversion, video extension, and audio-driven virtual avatars.\", \"ja\": \"崑崙万維のSkyReels - V3がオープンソース化され、参照画像からの動画変換、動画の延長、音声による仮想形象の駆動という3つの核心的な機能をカバーしています。 \", \"zh\": \"昆仑万维SkyReels-V3开源，覆盖参考图像转视频、视频延长、音频驱动虚拟形象三大核心能力\"}', 7, 'http://127.0.0.1:3000/uploads/2026-02-02/1sNh70OJ3.png', NULL, NULL, '1', '0', 105, '2026-02-02 16:07:47', '1', '0', '', 'admin', NULL, 'admin', NULL, '{\"en\": \"Video generation, SkyReels-V3\", \"ja\": \"動画生成、SkyReels - V3\", \"zh\": \"视频生成, SkyReels-V3\"}');
INSERT INTO `news` VALUES (3, '{\"en\": \"$2 billion for Q.ai, apple wants you to \\\"silently\\\" control AI\", \"zh\": \"20 亿美元收 Q.ai，苹果想让你「无声」地控制 AI\"}', '{\"en\": \"<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"0\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"0\\\" data-sentence=\\\"0\\\" data-group=\\\"0-0\\\">Apple, which has been lagging behind in AI, has stepped up its pace in recent months.</span><span class=\\\"tgt color_text_0 highlight\\\" data-section=\\\"0\\\" data-sentence=\\\"1\\\" data-group=\\\"0-1\\\"> After leaving OpenAI and joining hands with Google Gemini, Apple has made a new move recently. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"1\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"2\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"2\\\" data-sentence=\\\"0\\\" data-group=\\\"2-0\\\">On January 29 local time, Apple completed a nearly $2 billion acquisition of Israeli AI startup Q.ai. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"3\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"4\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"4\\\" data-sentence=\\\"0\\\" data-group=\\\"4-0\\\">This is Apple\'s second-largest deal since it acquired Beats for $3 billion in 2014. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"5\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"6\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"6\\\" data-sentence=\\\"0\\\" data-group=\\\"6-0\\\">According to multiple media reports such as the Financial times, the core technology of Q.ai lies in analyzing facial micro-expressions and muscle movements to interpret \\\"Silent Speech\\\", that is, users do not need to make sounds, and their intentions can be recognized by the device just through mouth movements. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"7\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"8\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"8\\\" data-sentence=\\\"0\\\" data-group=\\\"8-0\\\">This technology is expected to be integrated into future AirPods, iphones and even the rumored AI glasses, achieving more private and barrier-free human-computer interaction. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"9\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"10\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"10\\\" data-sentence=\\\"0\\\" data-group=\\\"10-0\\\">The founding team of Q.ai has a prominent background. Aviad Maizels, the co-founder, previously founded PrimeSense, which was acquired by apple in 2013 and whose technology later became the prototype of the iPhone Face ID. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"11\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"12\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"12\\\" data-sentence=\\\"0\\\" data-group=\\\"12-0\\\">This acquisition was announced on the same day that Apple released its strong financial report, highlighting the company\'s urgency to make up for its shortcomings in the AI hardware race. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"13\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"14\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"14\\\" data-sentence=\\\"0\\\" data-group=\\\"14-0\\\">01 </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"15\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"16\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"17\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"17\\\" data-sentence=\\\"0\\\" data-group=\\\"17-0\\\">A silent gamble </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"18\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"19\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"20\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"21\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"22\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"22\\\" data-sentence=\\\"0\\\" data-group=\\\"22-0\\\">The acquisition of Q.a is a concentrated manifestation of apple \'s anxiety about entry points in the era of generative AI. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"23\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"24\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"24\\\" data-sentence=\\\"0\\\" data-group=\\\"24-0\\\">While OpenAI\'s ChatGPT and Google\'s Gemini have redefined interaction through voice and text, Apple\'s Siri has been widely criticized for its outdated experience. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"25\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"26\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"26\\\" data-sentence=\\\"0\\\" data-group=\\\"26-0\\\">The acquisition of Q.ai is apple \'s attempt to open up a \\\"second front\\\" beyond traditional voice interaction. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"27\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"28\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"28\\\" data-sentence=\\\"0\\\" data-group=\\\"28-0\\\">Silent speech recognition technology directly addresses the core pain points of current voice assistants: privacy and scene limitations.</span><span class=\\\"tgt color_text_0\\\" data-section=\\\"28\\\" data-sentence=\\\"1\\\" data-group=\\\"28-1\\\"> It is neither polite nor realistic to speak loudly into the equipment in a meeting room, library or on a noisy street.</span><span class=\\\"tgt color_text_0\\\" data-section=\\\"28\\\" data-sentence=\\\"2\\\" data-group=\\\"28-2\\\"> Like the author, there are quite a few patients who suffer from \\\"voice shame\\\" when facing a second person. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"29\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"30\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"30\\\" data-sentence=\\\"0\\\" data-group=\\\"30-0\\\">And the acquired Q.ai \'s technology promises private, seamless command input in any environment. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"31\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"32\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"32\\\" data-sentence=\\\"0\\\" data-group=\\\"32-0\\\">On a deeper level, this is a continuation of Apple\'s philosophy of \\\"hardware defines experience\\\". </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"33\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"34\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"34\\\" data-sentence=\\\"0\\\" data-group=\\\"34-0\\\">Apple is not content with merely catching up in large cloud models. Instead, it is attempting to create an interactive moat that is difficult for competitors to replicate through the integration of unique sensor technology and hardware. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"35\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"36\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"36\\\" data-sentence=\\\"0\\\" data-group=\\\"36-0\\\">Combining silent recognition with AirPods and future glasses can firmly capture users\' \\\"ears\\\" and \\\"faces\\\", which is a more intimate and longer-lasting entry point than mobile phone screens. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"37\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"38\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"38\\\" data-sentence=\\\"0\\\" data-group=\\\"38-0\\\">Well-known technology blogger Robert Scoble pointed out that this is closely related to the new camera technology that Apple is about to launch, indicating that a multi-device interactive perception network is taking shape. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"39\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"40\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"40\\\" data-sentence=\\\"0\\\" data-group=\\\"40-0\\\">To put it bluntly, Apple is betting that the next interaction paradigm will not be smarter conversations, but more intangible perceptions.</span></p>\", \"zh\": \"<p>在 AI 上日渐落后的苹果，最近几个月加紧了前进步伐。抛弃 OpenAI，携手 Google Gemini 后，苹果近日又有新动作。</p>\\n<p>当地时间 1 月 29 日，苹果公司完成了一项近 20 亿美元的收购，目标是以色列 AI 初创公司 Q.ai。</p>\\n<p><strong>这是苹果自 2014 年以 30 亿美元收购 Beats 以来，规模第二大的交易</strong>。</p>\\n<p>据《金融时报》等多家媒体报道，<strong>Q.ai 的核心技术在于分析面部微表情和肌肉运动，从而解读「无声语音」</strong>（Silent Speech），即用户无需发出声音，仅通过嘴部动作即可被设备识别意图。</p>\\n<p><strong>这项技术被认为有望集成到未来的 AirPods、iPhone 乃至传闻中的 AI 眼镜中，实现更私密、无障碍的人机交互</strong>。</p>\\n<p>Q.ai 的创始团队背景显赫，联合创始人 Aviad Maizels 此前创立的 PrimeSense 公司在 2013 年被苹果收购，其技术后来成为 iPhone Face ID 的原型。</p>\\n<p>此次收购在苹果发布强劲财报的同一天公布，凸显了公司在 AI 硬件竞赛中补短板的急迫性。</p>\\n<section data-mpa-action-id=\\\"ml0b1pi51yye\\\" data-pm-slice=\\\"0 0 []\\\"></section>\\n<section data-mpa-template=\\\"t\\\" data-mpa-action-id=\\\"ml0b1pi51ts6\\\">\\n<section data-mpa-template=\\\"t\\\">\\n<section>\\n<section>\\n<section>\\n<section>\\n<section>\\n<p><em><strong>01<br></strong></em></p>\\n</section>\\n</section>\\n<section>\\n<section></section>\\n</section>\\n</section>\\n</section>\\n</section>\\n<p><strong><span data-pm-slice=\\\"1 1 [&quot;para&quot;,{&quot;tagName&quot;:&quot;p&quot;,&quot;attributes&quot;:{&quot;style&quot;:&quot;margin: 25px 0px; text-align: justify; color: rgb(0, 0, 0); letter-spacing: 1px; font-size: 16px; line-height: 1.75;&quot;,&quot;mpa-paragraph-type&quot;:&quot;body&quot;},&quot;namespaceURI&quot;:&quot;http://www.w3.org/1999/xhtml&quot;}]\\\">「无声」豪赌</span><br></strong></p>\\n</section>\\n</section>\\n<p>&nbsp;</p>\\n<p>Q.ai 收购背后，是苹果在生成式 AI 时代入口焦虑的集中体现。</p>\\n<p>当 OpenAI 的 ChatGPT、谷歌的 Gemini 通过语音和文字重新定义交互时，苹果的 Siri 却因体验落后而备受诟病。</p>\\n<p>收购 Q.ai，是苹果在传统语音交互之外，开辟「第二战场」的尝试。</p>\\n<p><strong>无声语音识别技术直击了当前语音助手的核心痛点：隐私与场景限制。</strong>&nbsp;在会议室、图书馆或嘈杂的街道上，对着设备大声说话既不礼貌也不现实。像笔者一样，面对第二个人就有「语音羞耻症」的患者，不在少数。</p>\\n<p>而被收购的 Q.ai 的技术承诺让用户在任何环境下都能进行私密、无缝的指令输入。</p>\\n<p>更深层次看，这是苹果「硬件定义体验」哲学的延续。</p>\\n<p>苹果不满足于在云端大模型上追赶，而是试图通过独特的传感器技术与硬件集成，打造竞争对手难以复制的交互护城河。</p>\\n<p>将无声识别与 AirPods、未来眼镜结合，<strong>能牢牢抓住用户的「耳朵」和「脸」，这是比手机屏幕更贴身、使用时间更长的入口</strong>。</p>\\n<p>知名科技博主 Robert Scoble 指出，这与苹果即将推出的新型摄像头技术息息相关，预示着多设备联动的感知网络正在形成。</p>\\n<p>说白了，苹果在赌下一个交互范式不是更聪明的对话，而是更无形的感知。</p>\"}', '{\"en\": \"Apple, which has been lagging behind in AI, has stepped up its pace in recent months. After leaving OpenAI and joining hands with Google Gemini, Apple has made a new move recently.\", \"zh\": \"在 AI 上日渐落后的苹果，最近几个月加紧了前进步伐。抛弃 OpenAI，携手 Google Gemini 后，苹果近日又有新动作。\"}', 7, 'http://127.0.0.1:3000/uploads/2026-02-02/yEVDhwzXi.png', NULL, NULL, '0', '0', 55, '2026-02-02 16:10:48', '1', '0', '', 'admin', NULL, 'admin', NULL, '{\"en\": \"\", \"zh\": \"\"}');
INSERT INTO `news` VALUES (4, '{\"en\": \"MiniMax Music 2.5: Grammy-level creation, no more studio needed\", \"zh\": \"MiniMax Music 2.5: 格莱美级创作，不再需要录音棚\"}', '{\"en\": \"\", \"zh\": \"<p data-pm-slice=\\\"0 0 []\\\">今天，我们正式发布 MiniMax Music 2.5：全维度突破，指挥细节，定义真实。</p>\\n<p>AI 音乐始终面对两个挑战：可控性与真实度。前者决定了创作者能否表达真实意图，后者决定了作品是否具备专业质感。</p>\\n<p>过去，从粗糙的 Demo 到具有明星质感的作品之间，隔着昂贵的录音棚、复杂的混音设备以及多年的专业训练。</p>\\n<p>相较于上一代模型，<strong>Music 2.5 在「段落级强控制」与「物理级高保真」两大技术难题上实现突破&mdash;&mdash;让创作更准，让音乐更真。</strong></p>\\n<p><strong>Direct the Detail. Define the Real.&nbsp;</strong></p>\\n<p data-pm-slice=\\\"0 0 []\\\">这道门槛，正在被打破。格莱美级的音乐创作，从此触手可及。</p>\\n<section></section>\\n<section data-pm-slice=\\\"0 0 []\\\">\\n<section>\\n<section>\\n<section></section>\\n</section>\\n</section>\\n</section>\"}', '{\"en\": \"Today, we officially release MiniMax Music 2.5: All-dimensional breakthrough, conducting details, defining reality.\", \"zh\": \"今天，我们正式发布 MiniMax Music 2.5：全维度突破，指挥细节，定义真实。\"}', 7, 'http://127.0.0.1:3000/uploads/2026-02-02/7xauLawQY.png', NULL, NULL, '0', '1', 54, '2026-02-02 16:12:44', '1', '0', '', 'admin', NULL, 'admin', NULL, '{\"en\": \"\", \"zh\": \"\"}');
INSERT INTO `news` VALUES (5, '{\"en\": \"The vLLM team officially announced its start-up: raising 150 million US dollars, and You Kaichao, a recipient of the Tsinghua University Special Award, became a co-founder\", \"zh\": \"vLLM团队官宣创业：融资1.5亿美元，清华特奖游凯超成为联创\"}', '{\"en\": \"\", \"zh\": \"<p>本轮融资由风险投资公司 Andreessen Horowitz（a16z）和 Lightspeed 领投，Sequoia Capital、Altimeter Capital、Redpoint Ventures 和 ZhenFund 也参与了投资。</p>\\n<p>Inferact 的 1.5 亿美元天使轮融资虽不及 Ilya Sutskever 的公司 SSI 的 10 亿美元，但已经超过了 Mistral AI 的 1.15 亿美元，是有史以来规模最大的种子轮融资之一，标志着业界对于 AI 推理基础设施的重视程度正在急速提升。</p>\\n<p>Inferact 的使命是将 vLLM 发展成为世界领先的 AI 推理引擎，并通过降低推理成本、加快推理速度来加速 AI 的发展。</p>\\n<p>该公司认为，AI 行业未来面临的最大挑战不是构建新模型，而是如何以低成本、高可靠性地运行现有模型。</p>\\n<p>毫无疑问，Inferact 的核心是开源项目 vLLM，这是一个于 2023 年启动的开源项目，旨在帮助企业在数据中心硬件上高效运行 AI 模型。</p>\\n<p>vLLM 最初由加州大学伯克利分校（UC Berkeley）的天空计算实验室 (Sky Computing Lab) 开发，现由 PyTorch 基金会负责管理，已吸引了来自整个 AI 行业的 2000 多名贡献者，是全球范围内最受欢迎的开源大模型推理加速框架。</p>\\n<p>如今，vLLM 的推理能力在为 Meta、谷歌、Character.AI 等科技公司提供支持。</p>\\n<p>Inferact 的首席执行官 Simon Mo 是一位伯克利在读博士生，他是 vLLM 的创始维护者之一。Mo 表示，公司成立于 2025 年 11 月，并于本周正式对外公布。他将 Inferact 的起源与伯克利早期的一些软件项目进行了比较，这些项目后来发展成为规模更大的企业，例如 Apache Spark 和 Ray。</p>\\n<section></section>\\n<section data-pm-slice=\\\"0 0 []\\\">\\n<section>\\n<section>\\n<section></section>\\n</section>\\n</section>\\n</section>\"}', '{\"en\": \"Early Friday morning Beijing time, news came that Inferact, an artificial intelligence startup founded by the creator of the open-source software vLLM, was officially established. It raised 150 million US dollars (about 1 billion yuan) in its seed round of financing, and the company\'s valuation reached 800 million US dollars.\", \"zh\": \"北京时间周五凌晨传来消息，由开源软件 vLLM 的创建者创立的人工智能初创公司 Inferact 正式成立，其在种子轮融资中筹集了 1.5 亿美元（约合 10 亿元人民币），公司估值达到 8 亿美元。\"}', 7, 'http://127.0.0.1:3000/uploads/2026-02-02/DvJXuJXlF.png', NULL, NULL, '0', '1', 173, '2026-02-02 16:14:31', '1', '0', '', 'admin', NULL, 'admin', NULL, '{\"en\": \"\", \"zh\": \"\"}');
COMMIT;

-- ----------------------------
-- Table structure for post
-- ----------------------------
DROP TABLE IF EXISTS `post`;
CREATE TABLE `post` (
  `post_id` int NOT NULL AUTO_INCREMENT,
  `post_code` varchar(30) NOT NULL,
  `post_name` varchar(30) NOT NULL,
  `post_sort` int NOT NULL,
  `status` varchar(1) NOT NULL,
  `remark` varchar(500) DEFAULT '',
  `create_by` varchar(64) DEFAULT '',
  `create_time` datetime DEFAULT NULL,
  `update_by` varchar(64) DEFAULT '',
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`post_id`),
  UNIQUE KEY `post_post_code_unique` (`post_code`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of post
-- ----------------------------
BEGIN;
INSERT INTO `post` VALUES (1, '1', '董事长', 1, '0', '', 'admin', '2024-12-14 09:20:20', 'admin', '2024-12-14 09:20:20');
COMMIT;

-- ----------------------------
-- Table structure for product
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
  `product_id` int NOT NULL AUTO_INCREMENT,
  `product_name` json DEFAULT (_utf8mb4'{"zh":"","en":""}'),
  `description` json DEFAULT (_utf8mb4'{"zh":"","en":""}'),
  `summary` json DEFAULT (_utf8mb4'{"zh":"","en":""}'),
  `category_id` int DEFAULT NULL,
  `main_image` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `images` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '',
  `specifications` json DEFAULT (_utf8mb4'{}'),
  `is_recommend` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0',
  `is_new` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0',
  `view_count` int DEFAULT '0',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '',
  `create_time` datetime DEFAULT NULL,
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '',
  `update_time` datetime DEFAULT NULL,
  `keywords` json DEFAULT (_utf8mb4'{"zh":"","en":""}'),
  PRIMARY KEY (`product_id`),
  KEY `product_category_id_category_category_id_fk` (`category_id`),
  CONSTRAINT `product_category_id_category_category_id_fk` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of product
-- ----------------------------
BEGIN;
INSERT INTO `product` VALUES (1, '{\"en\": \"Premium Carbide\", \"zh\": \" KZ4103_Y\"}', '{\"en\": \"<p>This product features a carbide circular saw blade paired with a high-speed steel (HSS) shank, utilizing a screw-countersunk shank design. Its core advantage is the quick-replaceable saw blade, enabling an economical \\\"long-lasting shank, on-demand blade replacement\\\" combination that significantly reduces long-term operating costs.</p>\\n<p>In addition to the HSS shank, this circular saw blade can also be paired with a ferritic stainless steel shank or configured as a solid carbide shank. For these multiple options and a customized quote, please feel free to contact us.</p>\", \"zh\": \"<p class=\\\"MsoNormal\\\">●&nbsp;采用32核处理器+FPGA双核架构设计，运算能力强、并行处理数据快，存储容量大，适用于复杂移动机械在恶劣作业环境下智能化控制；</p>\\n<p class=\\\"MsoNormal\\\">●&nbsp;采用软硬件特殊防护设计，满足移动机械对控制器在高湿高温、防水防尘、高冲击、强振动及复杂电磁环境下的特殊要求；</p>\\n<p class=\\\"MsoNormal\\\">●&nbsp;使用国际标准J1939协议，与发动机进行数据交换,并对其运行状态进行实时监测和控制；</p>\\n<p class=\\\"MsoNormal\\\">●&nbsp;控制油门执行机构对发动机调速；</p>\\n<p class=\\\"MsoNormal\\\">●&nbsp;对电磁比例阀进行精准电流控制，不受温度及电压波动干扰；</p>\\n<p class=\\\"MsoNormal\\\">●&nbsp;运行控制软件，直接控制移动机械液压电磁阀、继电器及其它电子电器部件，使之智能化作业；</p>\\n<p class=\\\"MsoNormal\\\">●&nbsp;为外接传感器提供多路独立电源；</p>\\n<p class=\\\"MsoNormal\\\">●&nbsp;具备完整的系统监视、故障诊断、报警及信息管理；</p>\\n<p class=\\\"MsoNormal\\\">●&nbsp;机械负载、电缆开路或短路自动检测；</p>\\n<p class=\\\"MsoNormal\\\">●&nbsp;机械传感器、开关、电子、电器部件可直接连接，有过电压和电气干扰保护；</p>\\n<p class=\\\"MsoNormal\\\">●&nbsp;CAN总线接口可与其它电子装置交换信息，可以使用不同协议操作；</p>\\n<p class=\\\"MsoNormal\\\">● 符合IEC61131-3标准，可兼容使用KQcode平台、Codesys 3.5国际通用平台进行编程，开发效率高，可快速、安全地将机械投入运行。</p>\"}', '{\"en\": \"It adopts a dual-core architecture design of a 32-core processor and FPGA, featuring strong computing power, fast parallel data processing, and large storage capacity. It is suitable for intelligent control of complex mobile machinery in harsh working environments\", \"zh\": \"采用32核处理器+FPGA双核架构设计，运算能力强、并行处理数据快，存储容量大，适用于复杂移动机械在恶劣作业环境下智能化控制\"}', 3, 'http://127.0.0.1:3000/uploads/2026-01-28/ZyAOKcbHz.png', '', '{}', '1', '0', 63, '1', '0', '', 'admin', NULL, 'admin', '2026-02-04 03:23:39', '{\"en\": \"\", \"zh\": \"\"}');
INSERT INTO `product` VALUES (2, '{\"en\": \"TK5001\", \"zh\": \"TK5001\"}', '{\"en\": \"\", \"zh\": \"<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"0\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"0\\\" data-sentence=\\\"0\\\" data-group=\\\"0-0\\\">● Brand-new appearance design; </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"1\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"2\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"2\\\" data-sentence=\\\"0\\\" data-group=\\\"2-0\\\">● High-precision positioning, supporting RTK technology, achieving centimeter-level positioning accuracy; </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"3\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"4\\\"><span class=\\\"tgt color_text_0 highlight\\\" data-section=\\\"4\\\" data-sentence=\\\"0\\\" data-group=\\\"4-0\\\">It supports 4G LTE communication through the SIM card interface and is suitable for remote data transmission and control. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"5\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"6\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"6\\\" data-sentence=\\\"0\\\" data-group=\\\"6-0\\\">● Multi-band antenna support, equipped with 4G LTE and WIFI antennas to ensure reliable wireless communication; </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"7\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"8\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"8\\\" data-sentence=\\\"0\\\" data-group=\\\"8-0\\\">● RS422 and CAN communication are configured. RS422 is used for high-precision data transmission, while CAN is used for real-time control and data exchange. Through the joint efforts of RS422 and CAN, the high-precision positioning and real-time control of the system are achieved. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"9\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"10\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"10\\\" data-sentence=\\\"0\\\" data-group=\\\"10-0\\\">● Equipped with indicator lights, it can promptly feedback the status of the controller. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"11\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"12\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"12\\\" data-sentence=\\\"0\\\" data-group=\\\"12-0\\\">● Supports mainstream differential protocols in the industry such as RTCM and CMR; </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"13\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"14\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"14\\\" data-sentence=\\\"0\\\" data-group=\\\"14-0\\\">● IP67 design, safe and reliable; </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"15\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"16\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"16\\\" data-sentence=\\\"0\\\" data-group=\\\"16-0\\\">● Flexible installation methods are available, including threaded rod and screw fixation, etc. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"17\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"18\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"18\\\" data-sentence=\\\"0\\\" data-group=\\\"18-0\\\">● Supports secondary development.</span></p>\"}', '{\"en\": \"Mobile mechanical equipment\\nProduct features: RTK controller\", \"zh\": \"移动机械装备\\n产品特色：RTK控制器\"}', 3, 'http://127.0.0.1:3000/uploads/2026-01-30/NfPwkJD3K.jpeg', '', '{}', '0', '0', 8, '1', '0', '', 'admin', '2026-01-30 06:58:33', 'admin', '2026-02-04 06:47:19', '{\"en\": \"\", \"zh\": \"\"}');
INSERT INTO `product` VALUES (3, '{\"en\": \"JK4116\", \"zh\": \"JK4116\"}', '{\"en\": \"<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"0\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"0\\\" data-sentence=\\\"0\\\" data-group=\\\"0-0\\\">● Interact with machinery through human-machine interaction and conduct intelligent control over it; </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"1\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"2\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"2\\\" data-sentence=\\\"0\\\" data-group=\\\"2-0\\\">● Touch virtual keyboard operation; </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"3\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"4\\\"><span class=\\\"tgt color_text_0 highlight\\\" data-section=\\\"4\\\" data-sentence=\\\"0\\\" data-group=\\\"4-0\\\">● Remote upgrade of systems and applications; </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"5\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"6\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"6\\\" data-sentence=\\\"0\\\" data-group=\\\"6-0\\\">● Use the international standard J1939 protocol to exchange data with the engine and conduct real-time monitoring and control of its operating status; </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"7\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"8\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"8\\\" data-sentence=\\\"0\\\" data-group=\\\"8-0\\\">Control the throttle actuator to adjust the speed of the engine; </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"9\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"10\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"10\\\" data-sentence=\\\"0\\\" data-group=\\\"10-0\\\">● Directly control the hydraulic solenoid valves, relays and other electronic and electrical components of mobile machinery to enable intelligent operation; </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"11\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"12\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"12\\\" data-sentence=\\\"0\\\" data-group=\\\"12-0\\\">● Provide independent power supply for external sensors; </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"13\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"14\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"14\\\" data-sentence=\\\"0\\\" data-group=\\\"14-0\\\">The system and applications are offline via an SD card. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"15\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"16\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"16\\\" data-sentence=\\\"0\\\" data-group=\\\"16-0\\\">It adopts a special protection design for both software and hardware to meet the special requirements of mobile machinery for products in high-temperature and high-humidity, waterproof and dustproof, high-impact, strong vibration and complex electromagnetic environments. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"17\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"18\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"18\\\" data-sentence=\\\"0\\\" data-group=\\\"18-0\\\">The display screen has a wide viewing Angle. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"19\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"20\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"20\\\" data-sentence=\\\"0\\\" data-group=\\\"20-0\\\">It adopts a three-in-one structure of LCD screen, touch screen and protective glass to prevent water mist in the interlayer and image refraction deformation. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"21\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"22\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"22\\\" data-sentence=\\\"0\\\" data-group=\\\"22-0\\\">● Display of mechanical operation data and working status.</span><span class=\\\"tgt color_text_0\\\" data-section=\\\"22\\\" data-sentence=\\\"1\\\" data-group=\\\"22-1\\\"> Storage of historical alarm records and set parameters; </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"23\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"24\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"24\\\" data-sentence=\\\"0\\\" data-group=\\\"24-0\\\">● It adopts graphics acceleration technology and has a short startup time. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"25\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"26\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"26\\\" data-sentence=\\\"0\\\" data-group=\\\"26-0\\\">It complies with the IEC61131-3 standard and is compatible with programming using the KQcode platform and the codesys 3.5 international common platform.</span></p>\", \"zh\": \"<p class=\\\"MsoNormal\\\">●&nbsp;与机械进行人机交互，并对其进行智能化控制；</p>\\n<p class=\\\"MsoNormal\\\">●&nbsp;触摸虚拟键盘操作；</p>\\n<p class=\\\"MsoNormal\\\">●&nbsp;系统及应用程序远程升级；</p>\\n<p class=\\\"MsoNormal\\\">●&nbsp;使用国际标准J1939协议，与发动机进行数据交换,并对其运行状态进行实时监测和控制；</p>\\n<p class=\\\"MsoNormal\\\">●&nbsp;控制油门执行机构对发动机调速；</p>\\n<p class=\\\"MsoNormal\\\">●&nbsp;直接控制移动机械液压电磁阀、继电器及其它电子电器部件，使之智能化作业；</p>\\n<p class=\\\"MsoNormal\\\">●&nbsp;为外接传感器提供独立电源；</p>\\n<p class=\\\"MsoNormal\\\">●&nbsp;系统及应用程序通过SD卡离线；</p>\\n<p class=\\\"MsoNormal\\\">●&nbsp;采用软硬件特殊防护设计，满足移动机械对产品在高温高湿、防水防尘、高冲击、强振动及复杂电磁环境下的特殊要求；</p>\\n<p class=\\\"MsoNormal\\\">●&nbsp;显示屏可视角度大；</p>\\n<p class=\\\"MsoNormal\\\">●&nbsp;采用液晶屏、触摸屏及防护玻璃三合一结构，防止夹层水雾及图像折射变形；</p>\\n<p class=\\\"MsoNormal\\\">●&nbsp;机械运行数据及作业状态显示。历史报警记录及设置参数存储；</p>\\n<p class=\\\"MsoNormal\\\">●&nbsp;采用图形加速技术，启动时间短。</p>\\n<p class=\\\"MsoNormal\\\">● 符合IEC61131-3标准，可兼容使用KQcode平台、codesys 3.5国际通用平台进行编程。</p>\"}', '{\"en\": \"Mobile mechanical equipment\\n4.3-inch touch display and control terminal\", \"zh\": \"移动机械装备\\n4.3寸触摸显控终端\"}', 4, 'http://127.0.0.1:3000/uploads/2026-01-30/CF4Om4Zyv.png', 'http://127.0.0.1:3000/uploads/2026-01-30/q0955gZhl.png,http://127.0.0.1:3000/uploads/2026-01-30/4aYXnk8Y9.png', '{}', '1', '0', 18, '1', '0', '', 'admin', '2026-01-30 06:59:50', 'admin', '2026-02-04 06:48:20', '{\"en\": \"\", \"zh\": \"\"}');
INSERT INTO `product` VALUES (4, '{\"en\": \"KZ5104\", \"zh\": \"KZ5104\"}', '{\"en\": \"<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"0\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"0\\\" data-sentence=\\\"0\\\" data-group=\\\"0-0\\\">It adopts a 32-core processor architecture design, featuring strong computing power, fast parallel data processing, and large storage capacity. It is suitable for intelligent control of complex mobile machinery in harsh working environments. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"1\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"2\\\"><span class=\\\"tgt color_text_0 highlight\\\" data-section=\\\"2\\\" data-sentence=\\\"0\\\" data-group=\\\"2-0\\\">It adopts a special protection design for both software and hardware to meet the special requirements of mobile machinery for the controller in high-humidity and high-temperature, waterproof and dustproof, high-shock, strong vibration and complex electromagnetic environments. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"3\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"4\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"4\\\" data-sentence=\\\"0\\\" data-group=\\\"4-0\\\">● Use the international standard J1939 protocol to exchange data with the engine and conduct real-time monitoring and control of its operating status; </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"5\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"6\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"6\\\" data-sentence=\\\"0\\\" data-group=\\\"6-0\\\">Control the throttle actuator to adjust the speed of the engine; </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"7\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"8\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"8\\\" data-sentence=\\\"0\\\" data-group=\\\"8-0\\\">● Precise current control of the electromagnetic proportional valve is achieved, free from interference by temperature and voltage fluctuations. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"9\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"10\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"10\\\" data-sentence=\\\"0\\\" data-group=\\\"10-0\\\">The operation control software directly controls the hydraulic solenoid valves, relays and other electronic and electrical components of the mobile machinery, enabling intelligent operation. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"11\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"12\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"12\\\" data-sentence=\\\"0\\\" data-group=\\\"12-0\\\">● Provide multiple independent power supplies for external sensors; </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"13\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"14\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"14\\\" data-sentence=\\\"0\\\" data-group=\\\"14-0\\\">It is equipped with complete system monitoring, fault diagnosis, alarm and information management. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"15\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"16\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"16\\\" data-sentence=\\\"0\\\" data-group=\\\"16-0\\\">● Automatic detection of mechanical load, open circuit or short circuit of cables; </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"17\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"18\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"18\\\" data-sentence=\\\"0\\\" data-group=\\\"18-0\\\">Mechanical sensors, switches, electronic and electrical components can be directly connected, and there is overvoltage and electrical interference protection. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"19\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"20\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"20\\\" data-sentence=\\\"0\\\" data-group=\\\"20-0\\\">The CAN bus interface can exchange information with other electronic devices and operate using different protocols. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"21\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"22\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"22\\\" data-sentence=\\\"0\\\" data-group=\\\"22-0\\\">It complies with the IEC61131-3 standard and is compatible with programming using the KQcode platform and the internationally recognized Codesys 3.5 platform. It features high development efficiency and enables the machinery to be put into operation quickly and safely.</span></p>\", \"zh\": \"<p>● 采用32核处理器架构设计，运算能力强、并行处理数据快，存储容量大，适用于复杂移动机械在恶劣作业环境下智能化控制；</p>\\n<p>● 采用软硬件特殊防护设计，满足移动机械对控制器在高湿高温、防水防尘、高冲击、强振动及复杂● 电磁环境下的特殊要求；</p>\\n<p>● 使用国际标准J1939协议，与发动机进行数据交换,并对其运行状态进行实时监测和控制；</p>\\n<p>● 控制油门执行机构对发动机调速；</p>\\n<p>● 对电磁比例阀进行精准电流控制，不受温度及电压波动干扰；</p>\\n<p>● 运行控制软件，直接控制移动机械液压电磁阀、继电器及其它电子电器部件，使之智能化作业；</p>\\n<p>● 为外接传感器提供多路独立电源；</p>\\n<p>● 具备完整的系统监视、故障诊断、报警及信息管理；</p>\\n<p>● 机械负载、电缆开路或短路自动检测；</p>\\n<p>● 机械传感器、开关、电子、电器部件可直接连接，有过电压和电气干扰保护；</p>\\n<p>● CAN总线接口可与其它电子装置交换信息，可以使用不同协议操作；</p>\\n<p>● 符合IEC61131-3标准，可兼容使用KQcode平台、Codesys 3.5国际通用平台进行编程，开发效率高，可快速、安全地将机械投入运行。</p>\"}', '{\"en\": \"Application field: Mobile mechanical equipment\\nProduct features: Small controller\", \"zh\": \"应用领域: 移动机械装备\\n产品特色: 小型控制器\"}', 3, 'http://127.0.0.1:3000/uploads/2026-01-30/nzP3l3PNP.jpeg', '', '{}', '0', '0', 8, '1', '0', '', 'admin', '2026-01-30 07:07:42', 'admin', '2026-02-04 06:47:44', '{\"en\": \"\", \"zh\": \"\"}');
INSERT INTO `product` VALUES (5, '{\"en\": \"XQ4106\", \"zh\": \"XQ4106\"}', '{\"en\": \"<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"0\\\"><span class=\\\"tgt color_text_0 highlight\\\" data-section=\\\"0\\\" data-sentence=\\\"0\\\" data-group=\\\"0-0\\\">The entire vehicle monitor mainly consists of a device shell, a touchable LCD screen, a main circuit board and multiple industrial standard interface boards, meeting the communication requirements of the project for the device </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"1\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"1\\\" data-sentence=\\\"0\\\" data-group=\\\"1-0\\\">It can perform human-computer interaction without damaging the touch LCD screen in environments with strong vibration and shock </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"2\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"2\\\" data-sentence=\\\"0\\\" data-group=\\\"2-0\\\">The panel is made of high-strength high-quality aluminum alloy plates, and the body is made of high-quality stainless steel. The color is consistent with the panel, which is black RAL9004, and the outer surface is fine sand with a mottled texture </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"3\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"3\\\" data-sentence=\\\"0\\\" data-group=\\\"3-0\\\">The device provides an independent protective grounding terminal, adopting a sealed chassis stud lead-out structure. Through the matching nuts, the round bare end OT grounding terminal is fixed to prevent accidental wiring detachment.</span><span class=\\\"tgt color_text_0\\\" data-section=\\\"3\\\" data-sentence=\\\"1\\\" data-group=\\\"3-1\\\"> The grounding symbol of the grounding terminal of the device is clearly marked, and the safety grounding circuit meets the requirements for short-circuit current flow. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"4\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"4\\\" data-sentence=\\\"0\\\" data-group=\\\"4-0\\\">The device is pre-installed with the standard version of the Windows 7 64-bit operating system, common fonts such as Microsoft Yahei and Huawen Kaiti are installed, and all required drivers are installed. It supports Profibus communication, Modbus communication, Ethernet communication with on-site industrial equipment, as well as communication with the SCADA system. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"5\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"5\\\" data-sentence=\\\"0\\\" data-group=\\\"5-0\\\">The processor adopts an Intel&reg; Atom&trade; E3845 1.91GHz processor, with 4GB of memory and 64GB of SSD storage</span></p>\", \"zh\": \"<div>● 车载监控器整机主要由装置外壳、可触控液晶屏、主体电路板及多个工业标准接口板构成，满足项目对装置的通讯要求</div>\\n<div>● 能在强震动、强冲击环境下，进行人机交互而不损坏触摸液晶屏幕</div>\\n<div>● 面板采用高强度优质铝合金板材，优质不锈钢机身，颜色和面板一致，颜色为黑色RAL9004，外表面为麻纹细砂</div>\\n<div>● 装置提供独立的保护接地端子，采用密封机箱螺柱引出式结构，并通过配套螺帽，固定圆型裸端头OT接地端子，防止接线偶然脱落。装置接地端子接地符号标示清晰，安全接地回路满足短路电流流通的要求；</div>\\n<div>● 装置预装标准版Win7 64位操作系统，安装如微软雅黑、华文楷体等字常见字体，安装所需全部驱动，支持与现场工业设备之间的 Profibus通信、Modbus通信、以太网通信以及与SCADA系统之间的通信。</div>\\n<div>● 处理器采用Intel&reg; Atom&trade; E3845 1.91GHz处理器、内存4GB、SSD存储64G</div>\"}', '{\"en\": \"Application field: Mobile mechanical equipment\\nProduct features: 12.1-inch high-speed rail on-board all-in-one machine\", \"zh\": \"应用领域: 移动机械装备\\n产品特色: 12.1寸高铁车载一体机\"}', 4, 'http://127.0.0.1:3000/uploads/2026-01-30/ghf2JGSC5.png', '', '{}', '1', '0', 10, '1', '0', '', 'admin', '2026-01-30 07:09:49', 'admin', '2026-02-04 03:22:18', '{\"en\": \"\", \"zh\": \"\"}');
INSERT INTO `product` VALUES (6, '{\"en\": \"JK3103\", \"zh\": \"JK3103\"}', '{\"en\": \"<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"0\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"0\\\" data-sentence=\\\"0\\\" data-group=\\\"0-0\\\">It can work reliably in harsh environments and complex electromagnetic conditions </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"1\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"2\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"2\\\" data-sentence=\\\"0\\\" data-group=\\\"2-0\\\">● CORTEXT-M4 ARM+FPGA, dual-core dual-system framework. The dual cores respectively perform HMI and logic control tasks, with fast operation speed </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"3\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"4\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"4\\\" data-sentence=\\\"0\\\" data-group=\\\"4-0\\\">It integrates control, display and wireless transmission operation, with a compact structure and high integration </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"5\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"6\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"6\\\" data-sentence=\\\"0\\\" data-group=\\\"6-0\\\">Support the intelligent connection of devices with the Internet of Things platform to obtain the operating status of machines and equipment, and conduct remote monitoring and full life cycle management </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"7\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"8\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"8\\\" data-sentence=\\\"0\\\" data-group=\\\"8-0\\\">● According to device changes, it supports flexible configuration and expansion of fieldbus resources </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"9\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"10\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"10\\\" data-sentence=\\\"0\\\" data-group=\\\"10-0\\\">● Adopt an advanced one.</span><span class=\\\"tgt color_text_0\\\" data-section=\\\"10\\\" data-sentence=\\\"1\\\" data-group=\\\"10-1\\\"> The software development platform based on the NET architecture and the IEC61131-3 international programming standard integrates logic control and human-machine interface programming, which is efficient, flexible and convenient, reducing the difficulty of programming and maintenance, and allowing users to quickly get started </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"11\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"12\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"12\\\" data-sentence=\\\"0\\\" data-group=\\\"12-0\\\">It provides a large number of industrial control function modules, which are convenient for users to call and greatly improve the development efficiency of users </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"13\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"14\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"14\\\" data-sentence=\\\"0\\\" data-group=\\\"14-0\\\">● Adopt illegal reading verification technology to effectively protect intellectual property rights</span></p>\", \"zh\": \"<p>● 适应于恶劣环境及复杂电磁环境下可靠工作</p><p>● CORTEXT-M4 ARM+FPGA,双核双系统框架，双核分别执行HMI和逻辑控制任务，运行速度快</p><p>● 集控制、显示、无线传输操作于一体，结构紧凑，集成度高</p><p>● 支持设备智联搭载物联网平台获取机器和设备的运行状态，进行远程监控及全生命周期管理</p><p>● 根据设备变化，支持现场总线灵活配置及扩展资源</p><p>● 采用基于先进的.NET架构和IEC61131-3国际编程标准的软件开发平台，对逻辑控制与人机界面一体化编程，高效、灵活、方便，降低编程及维护难度，用户可快速上手</p><p>● 提供大量工业控制功能模块，方便用户调用，极大提高用户开发效率</p><p>● 采用非法读取验证技术，有效保护知识产权</p><p><br></p>\"}', '{\"en\": \"Application field: Mobile mechanical equipment\\nProduct features: 5-inch color display and control terminal\", \"zh\": \"应用领域: 移动机械装备\\n产品特色: 5寸彩色显控终端\"}', 4, 'http://127.0.0.1:3000/uploads/2026-01-30/tJDDuhAZx.png', '', '{}', '0', '0', 23, '1', '0', '', 'admin', '2026-01-30 07:16:15', 'admin', '2026-02-04 08:25:38', '{\"en\": \"\", \"zh\": \"\"}');
INSERT INTO `product` VALUES (7, '{\"en\": \"JK4120\", \"zh\": \"JK4120\"}', '{\"en\": \"<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"0\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"0\\\" data-sentence=\\\"0\\\" data-group=\\\"0-0\\\">&bull; Interact with machinery through human-machine interaction and conduct intelligent control over it; </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"1\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"2\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"2\\\" data-sentence=\\\"0\\\" data-group=\\\"2-0\\\">&bull; Touch virtual keyboard operation; </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"3\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"4\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"4\\\" data-sentence=\\\"0\\\" data-group=\\\"4-0\\\">&bull; Use the international standard J1939 protocol to exchange data with the engine and conduct real-time monitoring and control of its operating status; </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"5\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"6\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"6\\\" data-sentence=\\\"0\\\" data-group=\\\"6-0\\\">Control the throttle actuator to adjust the speed of the engine; </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"7\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"8\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"8\\\" data-sentence=\\\"0\\\" data-group=\\\"8-0\\\">Directly control the hydraulic solenoid valves, relays and other electronic and electrical components of mobile machinery to enable intelligent operation. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"9\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"10\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"10\\\" data-sentence=\\\"0\\\" data-group=\\\"10-0\\\">&bull; Provide independent power supply for external sensors; </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"11\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"12\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"12\\\" data-sentence=\\\"0\\\" data-group=\\\"12-0\\\">The system and applications are upgraded via SD card. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"13\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"14\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"14\\\" data-sentence=\\\"0\\\" data-group=\\\"14-0\\\">It adopts a special protection design for both software and hardware to meet the special requirements of mobile machinery for products in high-temperature and high-humidity, waterproof and dustproof, high-impact, strong vibration and complex electromagnetic environments. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"15\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"16\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"16\\\" data-sentence=\\\"0\\\" data-group=\\\"16-0\\\">The display screen has a wide viewing Angle. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"17\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"18\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"18\\\" data-sentence=\\\"0\\\" data-group=\\\"18-0\\\">It adopts a three-in-one structure of LCD screen, touch screen and protective glass to prevent water mist in the interlayer and image refraction deformation. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"19\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"20\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"20\\\" data-sentence=\\\"0\\\" data-group=\\\"20-0\\\">Mechanical operation data and work status display, historical alarm records and set parameter storage; </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"21\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"22\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"22\\\" data-sentence=\\\"0\\\" data-group=\\\"22-0\\\">&bull; It adopts graphics acceleration technology, with a short startup time; </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"23\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"24\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"24\\\" data-sentence=\\\"0\\\" data-group=\\\"24-0\\\">It complies with the IEC61131-3 standard and is compatible with programming using the KQcode platform and the Codesys 3.5 international common platform.</span></p>\", \"zh\": \"<p>&bull; 与机械进行人机交互，并对其进行智能化控制；</p>\\n<p>&bull; 触摸虚拟键盘操作；</p>\\n<p>&bull; 使用国际标准J1939协议，与发动机进行数据交换,并对其运行状态进行实时监测和控制；</p>\\n<p>&bull; 控制油门执行机构对发动机调速；</p>\\n<p>&bull; 直接控制移动机械液压电磁阀、继电器及其它电子电器部件，使之智能化作业；</p>\\n<p>&bull; 为外接传感器提供独立电源；</p>\\n<p>&bull; 系统及应用程序通过SD卡升级；</p>\\n<p>&bull; 采用软硬件特殊防护设计，满足移动机械对产品在高温高湿、防水防尘、高冲击、强振动及复杂电磁环境下的特殊要求；</p>\\n<p>&bull; 显示屏可视角度大；</p>\\n<p>&bull; 采用液晶屏、触摸屏及防护玻璃三合一结构，防止夹层水雾及图像折射变形；</p>\\n<p>&bull; 机械运行数据及作业状态显示，历史报警记录及设置参数存储；</p>\\n<p>&bull; 采用图形加速技术，启动时间短；</p>\\n<p>&bull; 符合IEC61131-3标准，可兼容使用KQcode平台、Codesys 3.5国际通用平台进行编程。</p>\"}', '{\"en\": \"Application field: Mobile mechanical equipment\\nProduct features: 5-inch color display and control terminal\", \"zh\": \"应用领域: 移动机械装备\\n产品特色: 5寸彩色显控终端\"}', 4, 'http://127.0.0.1:3000/uploads/2026-01-30/nuWKbChd2.jpeg', '', '{}', '0', '0', 13, '1', '0', '', 'admin', '2026-01-30 09:04:18', 'admin', '2026-02-04 12:55:29', '{\"en\": \"JK4120, monitor\", \"zh\": \"JK4120, 显示器\"}');
INSERT INTO `product` VALUES (8, '{\"zh\": \"2026新款AI智能机器狗\"}', '{\"zh\": \"<p>2026新款ai智能机器狗儿童玩具男孩电动遥控编程机械人工新年礼物</p><p><img src=\\\"http://127.0.0.1:3000/uploads/2026-02-05/tJrRZMyFU.jpeg\\\" alt=\\\"\\\" data-href=\\\"http://127.0.0.1:3000/uploads/2026-02-05/tJrRZMyFU.jpeg\\\" style=\\\"\\\"/></p><p><br></p>\"}', '{\"zh\": \"儿童玩具男孩电动遥控编程机械人工新年礼物\"}', 18, 'http://127.0.0.1:3000/uploads/2026-02-05/lMi7EkT1D.jpeg', '', '{}', '0', '0', 9, '1', '0', '', 'admin', '2026-02-05 08:44:09', 'admin', '2026-02-05 08:45:23', '{}');
INSERT INTO `product` VALUES (9, '{\"en\": \"Intelligent welcome and explanation robot\", \"ja\": \"スマート迎賓解説ロボット\", \"zh\": \"智能迎宾讲解机器人\"}', '{\"en\": \"<p><span style=\\\"color: rgba(9, 9, 10, 0.92); font-size: 14px;\\\">Leopard Secretary Mini (discount available upon consultation), Leopard Secretary 2, Instruction Manual. For detailed information on the overall machine discount price, please consult us.</span></p>\", \"ja\": \"<p><span style=\\\"color: rgba(9, 9, 10, 0.92); font-size: 14px;\\\">豹小秘mini（相談すると特典あり）、豹小秘2、取扱説明書、本体特典価格については詳しく相談できます。</span></p>\", \"zh\": \"<p><span style=\\\"color: rgba(9, 9, 10, 0.92); font-size: 14px;\\\">豹小秘mini(咨询可优惠),豹小秘2,说明书,整机优惠价可详询</span></p>\"}', '{\"en\": \"Explanation of robot AI dialogue, human - machine interaction exhibition hall, hospital and school front - desk reception robots\", \"ja\": \"ロボットのAI対話やヒューマン・マシンインタラクションの解説展示ホール、病院や学校の受付ロボット\", \"zh\": \"讲解机器人AI对话人机交互展厅医院学校前台接待机器人\"}', 18, 'http://127.0.0.1:3000/uploads/2026-02-05/YT6xs9gDx.png', '', '{}', '0', '0', 15, '1', '0', '', 'admin', '2026-02-05 08:46:53', 'admin', '2026-02-06 07:07:33', '{\"zh\": \"\"}');
COMMIT;

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `role_id` int NOT NULL AUTO_INCREMENT,
  `role_name` varchar(30) NOT NULL,
  `role_key` varchar(100) NOT NULL,
  `role_sort` int NOT NULL,
  `data_scope` char(1) DEFAULT '1',
  `menu_check_strictly` tinyint(1) DEFAULT '1',
  `dept_check_strictly` tinyint(1) DEFAULT '1',
  `status` char(1) NOT NULL,
  `del_flag` char(1) DEFAULT '0',
  `remark` varchar(500) DEFAULT '',
  `create_by` varchar(64) DEFAULT '',
  `create_time` datetime DEFAULT NULL,
  `update_by` varchar(64) DEFAULT '',
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of role
-- ----------------------------
BEGIN;
INSERT INTO `role` VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', '', '', NULL, '', NULL);
INSERT INTO `role` VALUES (2, '管理员', '2', 2, '1', 1, 1, '0', '0', '', 'admin', '2024-12-14 09:20:20', 'test', '2024-12-14 14:17:55');
COMMIT;

-- ----------------------------
-- Table structure for role_to_menu
-- ----------------------------
DROP TABLE IF EXISTS `role_to_menu`;
CREATE TABLE `role_to_menu` (
  `role_id` int DEFAULT NULL,
  `menu_id` int DEFAULT NULL,
  KEY `role_to_menu_role_id_role_role_id_fk` (`role_id`),
  KEY `role_to_menu_menu_id_menu_menu_id_fk` (`menu_id`),
  CONSTRAINT `role_to_menu_menu_id_menu_menu_id_fk` FOREIGN KEY (`menu_id`) REFERENCES `menu` (`menu_id`),
  CONSTRAINT `role_to_menu_role_id_role_role_id_fk` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of role_to_menu
-- ----------------------------
BEGIN;
INSERT INTO `role_to_menu` VALUES (2, 1);
INSERT INTO `role_to_menu` VALUES (2, 4);
INSERT INTO `role_to_menu` VALUES (2, 15);
INSERT INTO `role_to_menu` VALUES (2, 16);
INSERT INTO `role_to_menu` VALUES (2, 17);
INSERT INTO `role_to_menu` VALUES (2, 18);
INSERT INTO `role_to_menu` VALUES (2, 19);
INSERT INTO `role_to_menu` VALUES (2, 20);
INSERT INTO `role_to_menu` VALUES (2, 21);
INSERT INTO `role_to_menu` VALUES (2, 5);
INSERT INTO `role_to_menu` VALUES (2, 22);
INSERT INTO `role_to_menu` VALUES (2, 23);
INSERT INTO `role_to_menu` VALUES (2, 24);
INSERT INTO `role_to_menu` VALUES (2, 25);
INSERT INTO `role_to_menu` VALUES (2, 6);
INSERT INTO `role_to_menu` VALUES (2, 26);
INSERT INTO `role_to_menu` VALUES (2, 27);
INSERT INTO `role_to_menu` VALUES (2, 28);
INSERT INTO `role_to_menu` VALUES (2, 29);
INSERT INTO `role_to_menu` VALUES (2, 7);
INSERT INTO `role_to_menu` VALUES (2, 30);
INSERT INTO `role_to_menu` VALUES (2, 31);
INSERT INTO `role_to_menu` VALUES (2, 32);
INSERT INTO `role_to_menu` VALUES (2, 33);
INSERT INTO `role_to_menu` VALUES (2, 8);
INSERT INTO `role_to_menu` VALUES (2, 38);
INSERT INTO `role_to_menu` VALUES (2, 39);
INSERT INTO `role_to_menu` VALUES (2, 40);
INSERT INTO `role_to_menu` VALUES (2, 41);
INSERT INTO `role_to_menu` VALUES (2, 42);
INSERT INTO `role_to_menu` VALUES (2, 9);
INSERT INTO `role_to_menu` VALUES (2, 49);
INSERT INTO `role_to_menu` VALUES (2, 50);
INSERT INTO `role_to_menu` VALUES (2, 51);
INSERT INTO `role_to_menu` VALUES (2, 52);
INSERT INTO `role_to_menu` VALUES (2, 53);
INSERT INTO `role_to_menu` VALUES (2, 10);
INSERT INTO `role_to_menu` VALUES (2, 54);
INSERT INTO `role_to_menu` VALUES (2, 55);
INSERT INTO `role_to_menu` VALUES (2, 56);
INSERT INTO `role_to_menu` VALUES (2, 57);
INSERT INTO `role_to_menu` VALUES (2, 58);
INSERT INTO `role_to_menu` VALUES (2, 11);
INSERT INTO `role_to_menu` VALUES (2, 35);
INSERT INTO `role_to_menu` VALUES (2, 34);
INSERT INTO `role_to_menu` VALUES (2, 36);
INSERT INTO `role_to_menu` VALUES (2, 37);
INSERT INTO `role_to_menu` VALUES (2, 12);
INSERT INTO `role_to_menu` VALUES (2, 13);
INSERT INTO `role_to_menu` VALUES (2, 59);
INSERT INTO `role_to_menu` VALUES (2, 60);
INSERT INTO `role_to_menu` VALUES (2, 61);
INSERT INTO `role_to_menu` VALUES (2, 14);
INSERT INTO `role_to_menu` VALUES (2, 62);
INSERT INTO `role_to_menu` VALUES (2, 63);
INSERT INTO `role_to_menu` VALUES (2, 64);
COMMIT;

-- ----------------------------
-- Table structure for seo
-- ----------------------------
DROP TABLE IF EXISTS `seo`;
CREATE TABLE `seo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `page_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `page_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `title` json DEFAULT (_utf8mb4'{"zh":"","en":""}'),
  `keywords` json DEFAULT (_utf8mb4'{"zh":"","en":""}'),
  `description` json DEFAULT (_utf8mb4'{"zh":"","en":""}'),
  `og_title` json DEFAULT (_utf8mb4'{"zh":"","en":""}'),
  `og_description` json DEFAULT (_utf8mb4'{"zh":"","en":""}'),
  `og_image` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '',
  `create_time` datetime DEFAULT NULL,
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '',
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of seo
-- ----------------------------
BEGIN;
INSERT INTO `seo` VALUES (1, 'home', '', '{\"en\": \"NodeForge - Enterprise CMS Content Management System\", \"ja\": \"NodeForge - エンタープライズレベルのCMSコンテンツ管理システム\", \"zh\": \"NodeForge - 企业级CMS内容管理系统\"}', '{\"en\": \"CMS,Content Management System,Enterprise CMS,Node.js,Nuxt,Vue,Web Development,Digital Platform\", \"ja\": \"CMS、コンテンツ管理システム、エンタープライズレベルのCMS、Node.js、Nuxt、Vue、ウェブサイト構築、デジタル公式ウェブサイト\", \"zh\": \"CMS,内容管理系统,企业级CMS,Node.js,Nuxt,Vue,网站建设,数字化官网\"}', '{\"en\": \"NodeForge specializes in enterprise digital solutions, providing high-performance, scalable CMS systems and full-stack technical services to help enterprises rapidly build digital websites and content management platforms.\", \"ja\": \"NodeForgeは企業のデジタル化ソリューションに特化しており、高性能で拡張性のあるCMSシステムとフルスタック技術サービスを提供し、企業が迅速にデジタル公式ウェブサイトやコンテンツ管理プラットフォームを構築するのを支援します。 \", \"zh\": \"NodeForge专注于企业数字化解决方案，提供高性能、可扩展的CMS系统和全栈技术服务，帮助企业快速搭建数字化官网、内容管理平台。\"}', '{\"en\": \"\", \"zh\": \"\"}', '{\"en\": \"\", \"zh\": \"\"}', '', '0', '', '', NULL, '', '2026-02-06 07:08:32');
COMMIT;

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config` (
  `sys_config_id` int NOT NULL AUTO_INCREMENT,
  `config_name` varchar(100) DEFAULT '',
  `config_key` varchar(100) DEFAULT '',
  `config_value` text DEFAULT (_utf8mb4''),
  `config_type` enum('Y','N') DEFAULT 'N',
  `remark` varchar(500) DEFAULT '',
  `create_by` varchar(64) DEFAULT '',
  `create_time` datetime DEFAULT NULL,
  `update_by` varchar(64) DEFAULT '',
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`sys_config_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
BEGIN;
INSERT INTO `sys_config` VALUES (1, '登录过期时长', 'loginTime', '259200', 'Y', '三天(60 * 60 * 24 * 3)', '', '2025-01-02 01:53:49', '', '2025-05-13 01:40:56');
INSERT INTO `sys_config` VALUES (2, '文件上传', 'fileConfig', 'default', 'Y', '参数键值可到文件配置中获取，值为default时默认存储到服务器', '', '2025-04-18 09:03:19', '', '2025-04-19 14:31:34');
COMMIT;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `user_name` varchar(30) NOT NULL,
  `nick_name` varchar(30) NOT NULL,
  `user_type` varchar(2) DEFAULT '00',
  `email` varchar(50) DEFAULT NULL,
  `phonenumber` varchar(11) DEFAULT NULL,
  `sex` char(1) DEFAULT '0',
  `avatar` varchar(100) DEFAULT '',
  `password` varchar(100) DEFAULT '',
  `salt` varchar(100) DEFAULT '',
  `status` char(1) DEFAULT '0',
  `del_flag` char(1) DEFAULT '0',
  `login_ip` varchar(128) DEFAULT '',
  `login_date` date DEFAULT NULL,
  `dept_id` int DEFAULT NULL,
  `remark` varchar(500) DEFAULT '',
  `create_by` varchar(64) DEFAULT '',
  `create_time` datetime DEFAULT NULL,
  `update_by` varchar(64) DEFAULT '',
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  KEY `user_dept_id_dept_dept_id_fk` (`dept_id`),
  CONSTRAINT `user_dept_id_dept_dept_id_fk` FOREIGN KEY (`dept_id`) REFERENCES `dept` (`dept_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of user
-- ----------------------------
BEGIN;
INSERT INTO `user` VALUES (1, 'admin', 'admin', '00', '5428@qq.com', '15677777777', '0', '/uploads/kcfTVyaHs.png', '9c68fb331431f8dcfb7defef22b0c527', 'Y2uPc7hyq8Vi5qBc879Ut', '0', '0', '', NULL, 1, '', '', NULL, '', '2024-12-14 09:14:45');
INSERT INTO `user` VALUES (2, 'test', 'test', '00', NULL, NULL, '0', '', '728c992f87ae532307c688d1e212394f', 'BBIs09BXeYNzzzILTqPXQ', '0', '0', '', NULL, 1, '', 'admin', '2024-12-14 09:20:20', 'admin', '2024-12-14 09:20:20');
INSERT INTO `user` VALUES (3, 'eagle', 'eagle', '00', NULL, NULL, '0', '', '1fb95d6d5d2a557386fcbcfd75178b04', 'LHmrkV4f1kNA33kdYT-vL', '0', '0', '', NULL, 1, '', 'laoying', '2025-04-12 15:32:16', 'laoying', '2025-04-14 13:47:42');
COMMIT;

-- ----------------------------
-- Table structure for user_to_post
-- ----------------------------
DROP TABLE IF EXISTS `user_to_post`;
CREATE TABLE `user_to_post` (
  `user_id` int DEFAULT NULL,
  `post_id` int DEFAULT NULL,
  KEY `user_to_post_user_id_user_user_id_fk` (`user_id`),
  KEY `user_to_post_post_id_post_post_id_fk` (`post_id`),
  CONSTRAINT `user_to_post_post_id_post_post_id_fk` FOREIGN KEY (`post_id`) REFERENCES `post` (`post_id`),
  CONSTRAINT `user_to_post_user_id_user_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of user_to_post
-- ----------------------------
BEGIN;
INSERT INTO `user_to_post` VALUES (2, 1);
COMMIT;

-- ----------------------------
-- Table structure for user_to_role
-- ----------------------------
DROP TABLE IF EXISTS `user_to_role`;
CREATE TABLE `user_to_role` (
  `user_id` int DEFAULT NULL,
  `role_id` int DEFAULT NULL,
  KEY `user_to_role_user_id_user_user_id_fk` (`user_id`),
  KEY `user_to_role_role_id_role_role_id_fk` (`role_id`),
  CONSTRAINT `user_to_role_role_id_role_role_id_fk` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`),
  CONSTRAINT `user_to_role_user_id_user_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of user_to_role
-- ----------------------------
BEGIN;
INSERT INTO `user_to_role` VALUES (1, 1);
INSERT INTO `user_to_role` VALUES (2, 2);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
