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

 Date: 06/02/2026 16:39:48
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for ai_config
-- ----------------------------
DROP TABLE IF EXISTS `ai_config`;
CREATE TABLE `ai_config` (
  `ai_config_id` int NOT NULL AUTO_INCREMENT,
  `config_name` varchar(100) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `provider` enum('zhipu','doubao','deepseek') COLLATE utf8mb4_bin NOT NULL,
  `config_key` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `config_value` json NOT NULL DEFAULT (_utf8mb4'{}'),
  `status` enum('0','1') COLLATE utf8mb4_bin NOT NULL DEFAULT '1',
  `is_default` enum('Y','N') COLLATE utf8mb4_bin NOT NULL DEFAULT 'N',
  `sort_order` int NOT NULL DEFAULT '0',
  `remark` varchar(500) COLLATE utf8mb4_bin DEFAULT '',
  `create_by` varchar(64) COLLATE utf8mb4_bin DEFAULT '',
  `create_time` datetime DEFAULT NULL,
  `update_by` varchar(64) COLLATE utf8mb4_bin DEFAULT '',
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`ai_config_id`),
  UNIQUE KEY `ai_config_config_key_unique` (`config_key`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of ai_config
-- ----------------------------
BEGIN;
INSERT INTO `ai_config` VALUES (1, '豆包', 'doubao', 'doubao', '{\"model\": \"doubao-1-5-pro-32k-250115\", \"apiKey\": \"xxxxx-xxx-415c-xxx-xxxx\", \"endpoint\": \"https://ark.cn-beijing.volces.com/api/v3/chat/completions\", \"maxTokens\": 2000, \"temperature\": 0.7}', '1', 'Y', 0, '', '', '2026-02-06 05:54:05', '', '2026-02-06 07:03:58');
INSERT INTO `ai_config` VALUES (2, '智谱', 'zhipu', 'zhipu', '{\"model\": \"glm-4.7\", \"apiKey\": \"xxxxxxxxxxx.xxxxxxx\", \"endpoint\": \"https://open.bigmodel.cn/api/paas/v4/chat/completions\", \"maxTokens\": 2000, \"temperature\": 0.7}', '1', 'N', 0, '', '', '2026-02-06 06:47:23', '', '2026-02-06 07:04:03');
COMMIT;

-- ----------------------------
-- Table structure for banner
-- ----------------------------
DROP TABLE IF EXISTS `banner`;
CREATE TABLE `banner` (
  `banner_id` int NOT NULL AUTO_INCREMENT,
  `title` json DEFAULT (_utf8mb4'{"zh":"","en":""}'),
  `description` json DEFAULT (_utf8mb4'{"zh":"","en":""}'),
  `image_url` varchar(500) COLLATE utf8mb4_bin NOT NULL,
  `link_url` varchar(500) COLLATE utf8mb4_bin DEFAULT NULL,
  `button_text` json DEFAULT (_utf8mb4'{"zh":"","en":""}'),
  `order_num` int DEFAULT '0',
  `status` char(1) COLLATE utf8mb4_bin DEFAULT '1',
  `del_flag` char(1) COLLATE utf8mb4_bin DEFAULT '0',
  `remark` varchar(500) COLLATE utf8mb4_bin DEFAULT '',
  `create_by` varchar(64) COLLATE utf8mb4_bin DEFAULT '',
  `create_time` datetime DEFAULT NULL,
  `update_by` varchar(64) COLLATE utf8mb4_bin DEFAULT '',
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`banner_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of banner
-- ----------------------------
BEGIN;
INSERT INTO `banner` VALUES (1, '{\"en\": \"Innovative technology · Empowering Enterprise Development\", \"ja\": \"イノベーション技術・企業の発展をエンパワーする\", \"zh\": \"创新科技 · 赋能企业发展\"}', '{\"en\": \"Focusing on enterprise digital solutions, we provide high-performance, scalable CMS systems and full-stack technical services\", \"ja\": \"企業のデジタル化ソリューションに特化し、高性能で拡張可能なCMSシステムとフルスタック技術サービスを提供します。 \", \"zh\": \"专注于企业数字化解决方案，提供高性能、可扩展的CMS系统和全栈技术服务 \"}', 'http://node-forge.yinchunyu.com/uploads/2026-02-04/R6uWFP5mN.jpeg', '/products', '{\"en\": \"View the product\", \"ja\": \"商品を見る\", \"zh\": \"查看产品\"}', 1, '1', '0', '', 'admin', NULL, 'admin', '2026-02-06 06:33:05');
INSERT INTO `banner` VALUES (2, '{\"en\": \"Innovative technology · Empowering enterprise development\", \"ja\": \"イノベーション技術・企業の発展をエンパワーする\", \"zh\": \"创新科技 · 赋能企业发展\"}', '{\"en\": \"Focus on enterprise digital solutions, providing high-performance and scalable CMS systems and full-stack technical services.\", \"ja\": \"企業のデジタル化ソリューションに特化し、高性能で拡張性のあるCMSシステムとフルスタック技術サービスを提供します。 \", \"zh\": \"专注于企业数字化解决方案，提供高性能、可扩展的CMS系统和全栈技术服务 \"}', 'http://node-forge.yinchunyu.com/uploads/2026-02-04/yQG8iu2iv.jpeg', '/products', '{\"en\": \"View products\", \"ja\": \"製品を確認する\", \"zh\": \"查看产品\"}', 2, '1', '0', '', 'admin', NULL, 'admin', '2026-02-06 06:33:39');
COMMIT;

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `category_name` json DEFAULT (_utf8mb4'{"zh":"","en":""}'),
  `category_type` char(1) COLLATE utf8mb4_bin NOT NULL,
  `parent_category_id` int DEFAULT '0',
  `mpath` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `order_num` int DEFAULT '0',
  `status` char(1) COLLATE utf8mb4_bin DEFAULT '0',
  `del_flag` char(1) COLLATE utf8mb4_bin DEFAULT '0',
  `remark` varchar(500) COLLATE utf8mb4_bin DEFAULT '',
  `create_by` varchar(64) COLLATE utf8mb4_bin DEFAULT '',
  `create_time` datetime DEFAULT NULL,
  `update_by` varchar(64) COLLATE utf8mb4_bin DEFAULT '',
  `update_time` datetime DEFAULT NULL,
  `detail_template_type` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `url_key` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL,
  `template_type` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `description` json DEFAULT (_utf8mb4'{"zh":"","en":""}'),
  `redirect_url` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `is_recommend` char(1) COLLATE utf8mb4_bin DEFAULT '0',
  `keywords` json DEFAULT (_utf8mb4'{"zh":"","en":""}'),
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `category_url_key_unique` (`url_key`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of category
-- ----------------------------
BEGIN;
INSERT INTO `category` VALUES (1, '{\"en\": \"dynamic\", \"zh\": \"企业动态\"}', '1', 6, '6.1.', 1, '1', '0', '', 'admin', NULL, 'admin', '2026-01-28 08:40:08', NULL, 'dynamic', 'news', '{\"en\": \"\", \"zh\": \"\"}', NULL, '0', '{\"en\": \"\", \"zh\": \"\"}');
INSERT INTO `category` VALUES (2, '{\"en\": \"product\", \"zh\": \"产品新闻\"}', '1', 6, '6.2.', 2, '1', '0', '', 'admin', NULL, 'admin', '2026-01-28 08:40:11', NULL, 'product', 'news', '{\"en\": \"\", \"zh\": \"\"}', NULL, '0', '{\"en\": \"\", \"zh\": \"\"}');
INSERT INTO `category` VALUES (3, '{\"en\": \"controller\", \"zh\": \"控制器\"}', '2', 5, '5.3.', 2, '1', '0', '', 'admin', NULL, 'admin', '2026-02-05 08:40:55', NULL, 'controller', 'products', '{\"en\": \"\", \"zh\": \"\"}', NULL, '0', '{\"en\": \"\", \"zh\": \"\"}');
INSERT INTO `category` VALUES (4, '{\"en\": \"terminal\", \"zh\": \"显控类\"}', '2', 5, '5.4.', 2, '1', '0', '', 'admin', NULL, 'admin', '2026-01-28 08:37:34', NULL, 'terminal', 'products', '{\"en\": \"\", \"zh\": \"\"}', NULL, '1', '{\"en\": \"\", \"zh\": \"\"}');
INSERT INTO `category` VALUES (5, '{\"en\": \"Products\", \"ja\": \"製品センター\", \"zh\": \"产品中心\"}', '1', 0, '5.', 1, '1', '0', '', 'admin', '2026-01-28 11:39:55', 'admin', '2026-02-06 07:04:19', '', 'products', 'products', '{\"en\": \"We offer a wide range of enterprise-level product solutions to meet the digitalization needs of various scenarios\", \"ja\": \"当社では豊富な企業向け製品ソリューションを提供し、様々なシーンのデジタルニーズを満たします。 \", \"zh\": \"我们提供丰富的企业级产品解决方案，满足不同场景的数字化需求\"}', NULL, '0', '{\"en\": \"Intelligent products, AI, controllers\", \"ja\": \"スマート製品、AI、コントローラー\", \"zh\": \"智能产品, AI, 控制器\"}');
INSERT INTO `category` VALUES (6, '{\"en\": \"News\", \"zh\": \"新闻资讯\"}', '1', 0, '6.', 3, '1', '0', '', 'admin', NULL, 'admin', '2026-02-04 03:30:22', NULL, 'news', 'news', '{}', NULL, '0', '{\"en\": \"\", \"zh\": \"\"}');
INSERT INTO `category` VALUES (7, '{\"en\": \"AI news\", \"zh\": \"AI资讯\"}', '1', 6, '6.7.', 1, '1', '0', '', 'admin', NULL, 'admin', NULL, NULL, 'ai-news', 'news', '{}', NULL, '1', '{\"en\": \"\", \"zh\": \"\"}');
INSERT INTO `category` VALUES (8, '{\"en\": \"About Us\", \"zh\": \"关于我们\"}', '1', 0, '8.', 4, '1', '0', '', 'admin', NULL, 'admin', '2026-02-04 03:30:27', NULL, 'about', 'content', '{}', '/about/profile', '0', '{\"en\": \"\", \"zh\": \"\"}');
INSERT INTO `category` VALUES (9, '{\"en\": \"Company Profile\", \"zh\": \"企业简介\"}', '1', 8, '8.9.', 1, '1', '0', '', 'admin', NULL, 'admin', '2026-02-04 03:26:50', NULL, 'profile', 'content', '{}', NULL, '0', '{\"en\": \"\", \"zh\": \"\"}');
INSERT INTO `category` VALUES (10, '{\"en\": \"Corporate culture\", \"zh\": \"企业文化\"}', '1', 8, '8.10.', 2, '1', '0', '', 'admin', NULL, 'admin', '2026-02-04 03:27:03', NULL, 'culture', 'content', '{}', NULL, '0', '{\"en\": \"\", \"zh\": \"\"}');
INSERT INTO `category` VALUES (11, '{\"en\": \"Corporate honors\", \"zh\": \"企业荣誉\"}', '1', 8, '8.11.', 3, '1', '0', '', 'admin', NULL, 'admin', '2026-02-04 03:27:12', NULL, 'honor', 'content', '{}', NULL, '0', '{\"en\": \"\", \"zh\": \"\"}');
INSERT INTO `category` VALUES (12, '{\"en\": \"Contact us\", \"zh\": \"联系我们\"}', '1', 8, '8.12.', 4, '1', '0', '', 'admin', NULL, 'admin', '2026-02-04 03:27:24', NULL, 'contact-us', 'content', '{}', NULL, '0', '{\"en\": \"\", \"zh\": \"\"}');
INSERT INTO `category` VALUES (13, '{\"en\": \"Product services\", \"ja\": \"製品サービス\", \"zh\": \"产品服务\"}', '1', 0, '13.', 2, '1', '0', '', 'admin', NULL, 'admin', '2026-02-06 07:04:33', NULL, 'service', 'content', '{}', '/service/digital-solutions', '0', '{\"en\": \"\", \"zh\": \"\"}');
INSERT INTO `category` VALUES (14, '{\"en\": \"Digital solutions\", \"zh\": \"数字化解决方案\"}', '1', 13, '13.14.', 1, '1', '0', '', 'admin', NULL, 'admin', NULL, NULL, 'digital-solutions', 'content', '{}', NULL, '1', '{\"en\": \"\", \"zh\": \"\"}');
INSERT INTO `category` VALUES (15, '{\"en\": \"Customized development\", \"zh\": \"定制化开发\"}', '1', 13, '13.15.', 2, '1', '0', '', 'admin', NULL, 'admin', NULL, NULL, 'customized-development', 'content', '{}', NULL, '1', '{\"en\": \"\", \"zh\": \"\"}');
INSERT INTO `category` VALUES (16, '{\"en\": \"Technical support\", \"zh\": \"技术支持\"}', '1', 13, '13.16.', 3, '1', '0', '', 'admin', NULL, 'admin', '2026-02-04 03:32:13', NULL, 'technical-support', 'content', '{}', NULL, '1', '{\"en\": \"\", \"zh\": \"\"}');
INSERT INTO `category` VALUES (17, '{\"en\": \"Cooperative franchise\", \"zh\": \"合作加盟\"}', '1', 13, '13.17.', 4, '1', '0', '', 'admin', NULL, 'admin', NULL, NULL, 'cooperative-franchise', 'content', '{}', NULL, '0', '{\"en\": \"\", \"zh\": \"\"}');
INSERT INTO `category` VALUES (18, '{\"en\": \"AI products\", \"ja\": \"AI製品（エーアイせいひん） \", \"zh\": \"AI产品\"}', '1', 5, '5.18.', 1, '1', '0', '', 'admin', NULL, 'admin', '2026-02-06 07:05:07', NULL, 'ai', 'products', '{}', NULL, '0', '{}');
COMMIT;

-- ----------------------------
-- Table structure for contact
-- ----------------------------
DROP TABLE IF EXISTS `contact`;
CREATE TABLE `contact` (
  `contact_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `phone` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL,
  `email` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL,
  `subject` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `message` text COLLATE utf8mb4_bin NOT NULL,
  `status` char(1) COLLATE utf8mb4_bin DEFAULT '0',
  `handle_remark` varchar(500) COLLATE utf8mb4_bin DEFAULT NULL,
  `del_flag` char(1) COLLATE utf8mb4_bin DEFAULT '0',
  `remark` varchar(500) COLLATE utf8mb4_bin DEFAULT '',
  `create_by` varchar(64) COLLATE utf8mb4_bin DEFAULT '',
  `create_time` datetime DEFAULT NULL,
  `update_by` varchar(64) COLLATE utf8mb4_bin DEFAULT '',
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
  `del_flag` char(1) COLLATE utf8mb4_bin DEFAULT '0',
  `remark` varchar(500) COLLATE utf8mb4_bin DEFAULT '',
  `create_by` varchar(64) COLLATE utf8mb4_bin DEFAULT '',
  `create_time` datetime DEFAULT NULL,
  `update_by` varchar(64) COLLATE utf8mb4_bin DEFAULT '',
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='多语言配置表';

-- ----------------------------
-- Records of i18n_locale
-- ----------------------------
BEGIN;
INSERT INTO `i18n_locale` VALUES (1, 'zh', '简体中文', 'Y', '🇨🇳', 1, '0', '', '', '2026-02-05 10:08:02', '', '2026-02-05 10:08:02');
INSERT INTO `i18n_locale` VALUES (2, 'en', 'English', 'N', '🇺🇸', 2, '0', '', '', '2026-02-05 10:08:02', '', '2026-02-05 10:08:02');
INSERT INTO `i18n_locale` VALUES (3, 'ja', '日本語', 'N', '🇯🇵', 3, '0', '', '', '2026-02-05 03:13:08', '', '2026-02-05 03:13:08');
COMMIT;

-- ----------------------------
-- Table structure for i18n_translation
-- ----------------------------
DROP TABLE IF EXISTS `i18n_translation`;
CREATE TABLE `i18n_translation` (
  `translation_id` int NOT NULL AUTO_INCREMENT COMMENT '翻译主键',
  `locale_code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '语言代码',
  `translation_key` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '翻译键（如: site.name, nav.home）',
  `translation_value` text COLLATE utf8mb4_bin DEFAULT (_utf8mb4''),
  `group_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '分组（如: site, nav, home）',
  `sort_order` int DEFAULT '0' COMMENT '排序',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '备注',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`translation_id`)
) ENGINE=InnoDB AUTO_INCREMENT=714 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='多语言翻译内容表';

-- ----------------------------
-- Records of i18n_translation
-- ----------------------------
BEGIN;
INSERT INTO `i18n_translation` VALUES (344, 'en', 'site.name', 'NodeForgeCMS', 'site', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (345, 'en', 'nav.home', 'Home', 'nav', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (346, 'en', 'nav.news', 'News', 'nav', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (347, 'en', 'nav.products', 'Products', 'nav', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (348, 'en', 'nav.language', 'Language', 'nav', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (349, 'en', 'home.banner.title', 'Innovative Technology · Empowering Enterprise Development', 'home', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (350, 'en', 'home.banner.description', 'Dedicated to enterprise digital solutions, providing high-performance, scalable CMS systems and full-stack technical services', 'home', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (351, 'en', 'home.banner.learnMore', 'Learn More', 'home', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (352, 'en', 'home.banner.viewProducts', 'View Products', 'home', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (353, 'en', 'home.products.title', 'Products', 'home', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (354, 'en', 'home.products.description', 'We provide rich enterprise-level product solutions to meet digital needs across different scenarios', 'home', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (355, 'en', 'home.products.viewDetails', 'View Details', 'home', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (356, 'en', 'home.news.title', 'News Center', 'home', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (357, 'en', 'home.news.description', 'Stay up to date with the latest company updates, industry news and product releases', 'home', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (358, 'en', 'home.news.readFull', 'Read Full', 'home', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (359, 'en', 'home.news.viewMore', 'View More News', 'home', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (360, 'en', 'home.about.title', 'About Us', 'home', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (361, 'en', 'home.about.subtitle', 'Contact us to learn more about our products and partnership opportunities', 'home', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (362, 'en', 'home.about.imageUrl', 'About Us', 'home', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (363, 'en', 'home.about.intro1', 'NodeForge was established in 20xx. We are a technology company focused on enterprise digital solutions, with a core team from top internet companies and software service providers, with extensive experience in enterprise-level product R&D and implementation.', 'home', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (364, 'en', 'home.about.intro2', 'We use Node.js and Vue/Nuxt as our core technology stack to build high-performance, scalable enterprise-grade CMS systems, helping enterprises rapidly build digital websites and content management platforms, reducing digital transformation costs.', 'home', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (365, 'en', 'home.about.intro3', 'To date, we have served over 500 enterprise clients across manufacturing, retail, education, government and other industries, earning consistent recognition for our stable product performance and quality service.', 'home', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (366, 'en', 'home.about.stats.partners', 'Partners', 'home', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (367, 'en', 'home.about.stats.products', 'Products', 'home', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (368, 'en', 'home.about.stats.team', 'Team', 'home', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (369, 'en', 'home.about.stats.satisfaction', 'Satisfaction', 'home', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (370, 'en', 'home.contact.title', 'About Us', 'home', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (371, 'en', 'home.contact.subtitle', 'Contact us for more information about our products and partnership opportunities', 'home', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (372, 'en', 'home.contact.info.address', 'Company Address', 'home', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (373, 'en', 'home.contact.info.phone', 'Phone', 'home', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (374, 'en', 'home.contact.info.email', 'Email', 'home', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (375, 'en', 'home.contact.address', '88 Jianguo Road, Chaoyang District, Beijing, China', 'home', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (376, 'en', 'home.contact.phone', '400-888-9999', 'home', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (377, 'en', 'home.contact.social.title', 'Follow Us', 'home', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (378, 'en', 'home.contact.form.title', 'Consultation message', 'home', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (379, 'en', 'home.contact.form.name', 'Name', 'home', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (380, 'en', 'home.contact.form.namePlaceholder', 'Enter your name', 'home', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (381, 'en', 'home.contact.form.phone', 'Phone', 'home', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (382, 'en', 'home.contact.form.phonePlaceholder', 'Enter your phone number', 'home', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (383, 'en', 'home.contact.form.email', 'Email', 'home', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (384, 'en', 'home.contact.form.emailPlaceholder', 'Enter your email', 'home', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (385, 'en', 'home.contact.form.subject', 'Subject', 'home', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (386, 'en', 'home.contact.form.subjectPlaceholder', 'Select a subject', 'home', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (387, 'en', 'home.contact.form.subjectProduct', 'Product Inquiry', 'home', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (388, 'en', 'home.contact.form.subjectCooperation', 'Cooperation', 'home', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (389, 'en', 'home.contact.form.subjectTechnical', 'Technical Support', 'home', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (390, 'en', 'home.contact.form.subjectOther', 'Other', 'home', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (391, 'en', 'home.contact.form.message', 'Message', 'home', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (392, 'en', 'home.contact.form.messagePlaceholder', 'Enter your message', 'home', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (393, 'en', 'home.contact.form.submit', 'Submit', 'home', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (394, 'en', 'home.contact.form.submitting', 'Submitting...', 'home', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (395, 'en', 'home.contact.form.success', 'Submitted successfully! We will contact you soon.', 'home', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (396, 'en', 'home.contact.form.error', 'Submission failed, please try again later', 'home', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (397, 'en', 'home.contact.form.errorDetail', 'Submission failed, please try again later', 'home', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (398, 'en', 'footer.description', 'Dedicated to enterprise digital solutions, driving business development through technological innovation', 'footer', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (399, 'en', 'footer.quickLinks', 'Quick Links', 'footer', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (400, 'en', 'footer.hotCategories', 'Hot Categories', 'footer', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (401, 'en', 'footer.contactUs', 'Contact Us', 'footer', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (402, 'en', 'footer.address', '88 Jianguo Road, Chaoyang District, Beijing, China', 'footer', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (403, 'en', 'footer.phone', '400-888-9999', 'footer', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (404, 'en', 'footer.copyright', '© 2026 NodeForge. All rights reserved.', 'footer', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (405, 'en', 'common.home', 'Home', 'common', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (406, 'en', 'common.search', 'Search', 'common', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (407, 'en', 'common.searchPlaceholder', 'Search keywords...', 'common', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (408, 'en', 'common.viewDetails', 'View Details', 'common', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (409, 'en', 'common.prevPage', 'Previous', 'common', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (410, 'en', 'common.nextPage', 'Next', 'common', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (411, 'en', 'common.noData', 'No data available', 'common', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (412, 'en', 'common.noNews', 'No related news found, try different keywords', 'common', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (413, 'en', 'common.noProducts', 'No products available yet, stay tuned', 'common', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (414, 'en', 'common.loading', 'Loading...', 'common', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (415, 'en', 'news.detail.category', 'Category', 'news', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (416, 'en', 'news.detail.publishTime', 'Published', 'news', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (417, 'en', 'news.detail.viewCount', 'Views', 'news', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (418, 'en', 'news.detail.prev', 'Previous', 'news', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (419, 'en', 'news.detail.next', 'Next', 'news', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (420, 'en', 'news.detail.prevEmpty', 'Previous: None', 'news', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (421, 'en', 'news.detail.nextEmpty', 'Next: None', 'news', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (422, 'en', 'news.detail.related', 'Related News', 'news', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (423, 'en', 'news.searchPlaceholder', 'Search news keywords...', 'news', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (424, 'en', 'product.consultNow', 'Consult Now', 'product', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (425, 'en', 'product.freeTrial', 'Free Trial', 'product', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (426, 'en', 'product.detailTitle', 'Product Details', 'product', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (427, 'en', 'error.pageNotFound', 'Page Not Found', 'error', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (428, 'en', 'error.categoryNotFound', 'This category does not exist or is not published', 'error', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (429, 'en', 'error.backToHome', 'Back to Home', 'error', 0, '', '', '2026-02-05 02:31:14', '', '2026-02-05 02:31:14');
INSERT INTO `i18n_translation` VALUES (516, 'ja', 'site.name', 'NodeForgeCMS', 'site', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (517, 'ja', 'nav.home', 'ホーム', 'nav', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (518, 'ja', 'nav.news', 'ニュース', 'nav', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (519, 'ja', 'nav.products', '製品情報', 'nav', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (520, 'ja', 'nav.language', '言語 / Language', 'nav', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (521, 'ja', 'home.banner.title', '革新的なテクノロジーで企業の発展を支える', 'home', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (522, 'ja', 'home.banner.description', '企業のデジタル化ソリューションに特化し、高性能でスケーラブルなCMSシステムとフルスタック技術サービスを提供します', 'home', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (523, 'ja', 'home.banner.learnMore', '詳細を見る', 'home', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (524, 'ja', 'home.banner.viewProducts', '製品を見る', 'home', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (525, 'ja', 'home.products.title', '製品情報', 'home', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (526, 'ja', 'home.products.description', '多様な業種・場面に対応した企業向けソリューションを豊富に提供し、デジタル化のニーズに応えます', 'home', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (527, 'ja', 'home.products.viewDetails', '詳細を見る', 'home', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (528, 'ja', 'home.news.title', 'ニュース', 'home', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (529, 'ja', 'home.news.description', '企業の最新情報、業界ニュース、製品アップデートをいち早くお届けします', 'home', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (530, 'ja', 'home.news.readFull', '全文を読む', 'home', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (531, 'ja', 'home.news.viewMore', 'もっと見る', 'home', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (532, 'ja', 'home.about.title', '企業紹介', 'home', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (533, 'ja', 'home.about.subtitle', '企業のデジタル化ソリューションに特化し、技術革新で企業の発展を牽引します', 'home', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (534, 'ja', 'home.about.imageUrl', '企業紹介', 'home', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (535, 'ja', 'home.about.intro1', 'NodeForgeは20xx年設立。企業のデジタル化ソリューションに特化したテクノロジー企業です。中心メンバーは大手インターネット企業・ソフトウェアベンダー出身で、企業向け製品の開発・導入実績が豊富です。', 'home', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (536, 'ja', 'home.about.intro2', 'Node.js、Vue/Nuxtをコア技術スタックとし、高性能で拡張しやすい企業向けCMSシステムを開発。企業がデジタル化公式サイト・コンテンツ管理プラットフォームを迅速に構築し、デジタル転換のコストを削減できるよう支援します。', 'home', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (537, 'ja', 'home.about.intro3', 'これまで製造、小売、教育、行政など多業種にわたり500社以上の企業にサービスを提供。安定した製品パフォーマンスと質の高いサポートにより、顧客から高い評価を得ています。', 'home', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (538, 'ja', 'home.about.stats.partners', '取引企業', 'home', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (539, 'ja', 'home.about.stats.products', '主力製品', 'home', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (540, 'ja', 'home.about.stats.team', '技術チーム', 'home', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (541, 'ja', 'home.about.stats.satisfaction', '顧客満足度', 'home', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (542, 'ja', 'home.contact.title', 'お問い合わせ', 'home', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (543, 'ja', 'home.contact.subtitle', '製品情報や提携プランの詳細は、お気軽にご連絡ください', 'home', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (544, 'ja', 'home.contact.info.address', '所在地', 'home', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (545, 'ja', 'home.contact.info.phone', '電話番号', 'home', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (546, 'ja', 'home.contact.info.email', 'メールアドレス', 'home', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (547, 'ja', 'home.contact.address', '北京市朝陽区建国路88号 現代国際ビルA棟', 'home', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (548, 'ja', 'home.contact.phone', '400-888-9999', 'home', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (549, 'ja', 'home.contact.social.title', 'フォローする', 'home', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (550, 'ja', 'home.contact.form.title', 'お問い合わせ・メッセージ', 'home', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (551, 'ja', 'home.contact.form.name', 'お名前', 'home', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (552, 'ja', 'home.contact.form.namePlaceholder', 'お名前を入力してください', 'home', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (553, 'ja', 'home.contact.form.phone', '電話番号', 'home', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (554, 'ja', 'home.contact.form.phonePlaceholder', '連絡先電話番号を入力してください', 'home', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (555, 'ja', 'home.contact.form.email', 'メールアドレス', 'home', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (556, 'ja', 'home.contact.form.emailPlaceholder', 'メールアドレスを入力してください', 'home', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (557, 'ja', 'home.contact.form.subject', 'お問い合わせ種別', 'home', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (558, 'ja', 'home.contact.form.subjectPlaceholder', 'お問い合わせ内容を選択してください', 'home', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (559, 'ja', 'home.contact.form.subjectProduct', '製品について', 'home', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (560, 'ja', 'home.contact.form.subjectCooperation', '業務提携について', 'home', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (561, 'ja', 'home.contact.form.subjectTechnical', '技術サポート', 'home', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (562, 'ja', 'home.contact.form.subjectOther', 'その他のお問い合わせ', 'home', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (563, 'ja', 'home.contact.form.message', 'メッセージ内容', 'home', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (564, 'ja', 'home.contact.form.messagePlaceholder', 'メッセージを入力してください', 'home', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (565, 'ja', 'home.contact.form.submit', '送信する', 'home', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (566, 'ja', 'home.contact.form.submitting', '送信中...', 'home', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (567, 'ja', 'home.contact.form.success', '送信が完了しました！後ほど担当者よりご連絡いたします。', 'home', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (568, 'ja', 'home.contact.form.error', '送信に失敗しました。しばらく経ってから再度お試しください', 'home', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (569, 'ja', 'home.contact.form.errorDetail', '送信に失敗しました。しばらく経ってから再度お試しください', 'home', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (570, 'ja', 'footer.description', '企業のデジタル化ソリューションに特化し、技術革新で企業の発展を牽引します', 'footer', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (571, 'ja', 'footer.quickLinks', 'クイックリンク', 'footer', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (572, 'ja', 'footer.hotCategories', '人気カテゴリ', 'footer', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (573, 'ja', 'footer.contactUs', 'お問い合わせ', 'footer', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (574, 'ja', 'footer.address', '北京市朝陽区建国路88号', 'footer', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (575, 'ja', 'footer.phone', '400-888-9999', 'footer', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (576, 'ja', 'footer.copyright', '© 2026 NodeForge. All Rights Reserved.', 'footer', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (577, 'ja', 'common.home', 'ホーム', 'common', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (578, 'ja', 'common.search', '検索', 'common', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (579, 'ja', 'common.searchPlaceholder', 'キーワードを入力...', 'common', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (580, 'ja', 'common.viewDetails', '詳細を見る', 'common', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (581, 'ja', 'common.prevPage', '前のページ', 'common', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (582, 'ja', 'common.nextPage', '次のページ', 'common', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (583, 'ja', 'common.noData', 'データがありません', 'common', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (584, 'ja', 'common.noNews', '該当するニュースがありません。キーワードを変更してお試しください', 'common', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (585, 'ja', 'common.noProducts', '該当する製品がありません。今後の追加をお待ちください', 'common', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (586, 'ja', 'common.loading', '読み込み中...', 'common', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (587, 'ja', 'news.detail.category', 'カテゴリ', 'news', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (588, 'ja', 'news.detail.publishTime', '公開日', 'news', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (589, 'ja', 'news.detail.viewCount', '閲覧数', 'news', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (590, 'ja', 'news.detail.prev', '前の記事', 'news', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (591, 'ja', 'news.detail.next', '次の記事', 'news', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (592, 'ja', 'news.detail.prevEmpty', '前の記事：ありません', 'news', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (593, 'ja', 'news.detail.nextEmpty', '次の記事：ありません', 'news', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (594, 'ja', 'news.detail.related', '関連記事', 'news', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (595, 'ja', 'news.searchPlaceholder', 'ニュースのキーワードを検索...', 'news', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (596, 'ja', 'product.consultNow', '今すぐ問い合わせ', 'product', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (597, 'ja', 'product.freeTrial', '無料トライアル', 'product', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (598, 'ja', 'product.detailTitle', '製品詳細紹介', 'product', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (599, 'ja', 'error.pageNotFound', 'ページが見つかりません', 'error', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (600, 'ja', 'error.categoryNotFound', 'このカテゴリは存在しないか、公開されていません', 'error', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
INSERT INTO `i18n_translation` VALUES (601, 'ja', 'error.backToHome', 'ホームに戻る', 'error', 0, '', '', '2026-02-05 08:13:25', '', '2026-02-05 08:13:25');
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
  `config_key` varchar(100) COLLATE utf8mb4_bin DEFAULT '',
  `configValue` json DEFAULT (_utf8mb4'{}'),
  `remark` varchar(500) COLLATE utf8mb4_bin DEFAULT '',
  `create_by` varchar(64) COLLATE utf8mb4_bin DEFAULT '',
  `create_time` datetime DEFAULT NULL,
  `update_by` varchar(64) COLLATE utf8mb4_bin DEFAULT '',
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
) ENGINE=InnoDB AUTO_INCREMENT=449 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
INSERT INTO `menu` VALUES (119, '分类管理', 1, 'category', 'cms/category/index', NULL, 1, '0', 'C', '0', '0', 'cms:category:list', 'tree', 118, NULL, '', '', '2026-01-27 11:35:21', '', '2026-01-27 11:35:21');
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
  `web_url` varchar(500) COLLATE utf8mb4_bin NOT NULL,
  `mobile_url` varchar(500) COLLATE utf8mb4_bin DEFAULT NULL,
  `img_url` varchar(500) COLLATE utf8mb4_bin DEFAULT NULL,
  `is_new_window` char(1) COLLATE utf8mb4_bin DEFAULT '0',
  `is_enabled` char(1) COLLATE utf8mb4_bin DEFAULT '0',
  `sort_order` int DEFAULT '0',
  `remark` varchar(500) COLLATE utf8mb4_bin DEFAULT '',
  `create_by` varchar(64) COLLATE utf8mb4_bin DEFAULT '',
  `create_time` datetime DEFAULT NULL,
  `update_by` varchar(64) COLLATE utf8mb4_bin DEFAULT '',
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
  `cover_image` varchar(500) COLLATE utf8mb4_bin DEFAULT NULL,
  `author` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `source` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL,
  `is_top` char(1) COLLATE utf8mb4_bin DEFAULT '0',
  `is_recommend` char(1) COLLATE utf8mb4_bin DEFAULT '0',
  `view_count` int DEFAULT '0',
  `publish_time` datetime DEFAULT NULL,
  `status` char(1) COLLATE utf8mb4_bin DEFAULT '0',
  `del_flag` char(1) COLLATE utf8mb4_bin DEFAULT '0',
  `remark` varchar(500) COLLATE utf8mb4_bin DEFAULT '',
  `create_by` varchar(64) COLLATE utf8mb4_bin DEFAULT '',
  `create_time` datetime DEFAULT NULL,
  `update_by` varchar(64) COLLATE utf8mb4_bin DEFAULT '',
  `update_time` datetime DEFAULT NULL,
  `keywords` json DEFAULT (_utf8mb4'{"zh":"","en":""}'),
  PRIMARY KEY (`news_id`),
  KEY `news_category_id_category_category_id_fk` (`category_id`),
  CONSTRAINT `news_category_id_category_category_id_fk` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of news
-- ----------------------------
BEGIN;
INSERT INTO `news` VALUES (1, '{\"en\": \"The market for cemented carbide tools\", \"zh\": \"CTT 展会第一天｜聚焦莫斯科，世界舞台\"}', '{\"en\": \"<p>The market for cemented carbide tools</p>\", \"zh\": \"<p>全球碳化物工具的市场规模在2023年的价值为110.3亿美元。预计到2024年，该市场将从2024年的1,15.4亿美元增长到2032年的184.1亿美元，在预测期间的复合年增长率为6.0％。欧洲在2023年以34.81％的份额占据了全球市场。</p>\\n<p>&nbsp;</p>\\n<p>这些工具也称为水泥碳化物或碳化物的切割工具。在过去的几十年中，碳化物切割工具或插入物一直是制造业中最广泛使用的工具。它是由钨粉和碳化物粉制造的。这些材料比钢（钢的硬度三次），供热，快速速度，减少回收时间且价格较低。来自金属制造，汽车，建筑，家具和工业机制等各种行业的这些产品的需求增加，这些产品推动了全球市场的增长。&nbsp; 这些工具是切割工具的一种形式，并利用了重型机器，例如钻机机，CNC机器，车床机和铣床。碳化物车床工具在航空航天，汽车和建筑等各个行业的普及是预期在预测期内推动市场增长的关键因素。</p>\\n<p>&nbsp;</p>\\n<p>预计全球市场将在预测期间显着增长，因为主要参与者引入了新颖的耐磨成绩，并扩大了各种直径范围的倾斜工具。预计现有产品线的这种产品开发将提高对这些工具的需求并推动市场的增长。住宅和商业建设活动的增加，这反过来又增加了全球公共基础设施的投资，这反过来又增加了对钻头的需求，从而推动了市场增长。</p>\"}', '{\"en\": \"The global market size of carbide tools was valued at 11.03 billion US dollars in 2023. It is projected that by 2024, the market will grow from 11.54 billion US dollars in 2024 to 18.41 billion US dollars in 2032, with a compound annual growth rate of 6.0% during the forecast period.\", \"zh\": \"全球碳化物工具的市场规模在2023年的价值为110.3亿美元。预计到2024年，该市场将从2024年的1,15.4亿美元增长到2032年的184.1亿美元，在预测期间的复合年增长率为6.0％。\"}', 1, 'http://node-forge.yinchunyu.com/uploads/2026-01-30/ccdAMGlGo.jpeg', NULL, NULL, '0', '1', 33, '2026-01-27 14:48:33', '1', '0', '', 'admin', NULL, 'admin', NULL, '{\"en\": \"\", \"zh\": \"\"}');
INSERT INTO `news` VALUES (2, '{\"en\": \"Video generation has entered the \\\"all-round\\\" era.\", \"ja\": \"ビデオ生成が「万能」時代に突入する。\", \"zh\": \"视频生成进入“全能”时代\"}', '{\"en\": \"<p>On January 29th, Skywork AI officially open - sourced its self - developed video generation model, SkyReels - V3. As a series of multi - modal video generation models, this series supports three core capabilities: Reference Images - to - Video, Video Extension, and Talking Avatar. It achieves high - fidelity multi - modal video generation within a single modeling architecture, reaching the industry\'s leading level.</p><p><br></p><p>The three core capabilities serve as independent modules, each deeply optimized and supporting flexible combination. The Skywork AI team achieved this through technologies such as enterprise - level data processing, ultra - fast inference capabilities, and an efficient training architecture, enabling the generated videos to reach a professional - grade effect, with multiple indicators reaching or exceeding the industry\'s leading level.</p><p><br></p><p>SkyReels - V3 can generate high - quality video sequences with consistent timing and semantics based on 1 to 4 reference images combined with text prompts. Whether it\'s a character image, product display, or background scene, the generated videos can accurately preserve the original identity features, spatial composition, and narrative coherence.</p><p><br></p><p>Behind it are multiple technological innovations of the Skywork AI team in data construction, multi - reference condition fusion, and hybrid training strategies:</p><p>1. High - quality data construction: The team screened materials with significant dynamic movements from a vast amount of videos and adopted a cross - frame pairing strategy to ensure temporal diversity. More importantly, they used an image editing model to extract the main subject area, complete the background, and rewrite semantics, effectively avoiding the common \\\"copy - paste\\\" artifacts and ensuring the generation quality from the data source.</p><p>2. Multi - reference condition fusion: The model uses a unified strategy to jointly encode visual and text information, supporting up to 4 reference images. This means that users can achieve natural interaction and scene combination of complex multi - subjects and multi - elements without complex image stitching or manual masking. For example, in the e - commerce scenario, product images can be combined with virtual anchor images to directly generate a product - promotion video in a specific environment, accurately preserving product details and the anchor\'s identity features.</p><p>3. Hybrid training strategy: The team used image - video hybrid training, jointly leveraging large - scale image and video datasets, and used multi - resolution joint optimization to improve the robustness of different spatial scales and aspect ratios.</p><p>In an evaluation of a mixed test set containing 200 pairs (covering multiple fields such as movies, TV, e - commerce, and advertising), SkyReels - V3 demonstrated excellent performance.</p><p>Facing various reference types such as people, animals, objects, and background scenes, SkyReels - V3 achieved a reference consistency index of 0.6698, surpassing mainstream commercial models such as Vidu Q2 (0.5961), Kling 1.6 (0.6630), and PixVerse V5 (0.6542). It also led the field with a score of 0.8119 in the visual quality index, proving its powerful ability to generate high - fidelity videos while maintaining reference features. </p>\", \"ja\": \"<p>1月29日、Skywork AIは自社開発のビデオ生成モデル「SkyReels - V3」を正式にオープンソース化しました。この一連のマルチモーダルビデオ生成モデルは、参照画像からビデオへの変換（Reference Images - to - Video）、ビデオの延長（Video Extension）、音声駆動のバーチャルアバター（Talking Avatar）という3つの核心機能をサポートし、単一のモデリングアーキテクチャで高忠実度のマルチモーダルビデオ生成を実現し、業界トップレベルに達しています。</p><p>3つの核心機能は独立したモジュールとして、それぞれのモジュールが深度に最適化され、柔軟な組み合わせが可能です。Skywork AIチームは、企業レベルのデータ処理、高速推論能力、効率的なトレーニングアーキテクチャなどの技術を通じて、生成されるビデオを専門レベルの品質にし、多くの指標が業界トップレベルに達し、またはそれを上回っています。</p><p>SkyReels - V3は、1～4枚の参照画像を元に、テキストプロンプトを組み合わせることで、時間的に連続し、意味的に一貫した高品質のビデオシーケンスを生成できます。人物像、商品展示、背景シーンなど、生成されたビデオは元のアイデンティティ特徴、空間構図、物語の一貫性を正確に保持します。</p><p>その背景には、Skywork AIチームがデータ構築、多参照条件の融合、ハイブリッドトレーニング戦略において行った多重の技術革新があります。</p><p>1. 高品質のデータ構築：チームは大量のビデオから顕著な動的運動を持つ素材を選別し、フレーム間のペアリング戦略を採用して時間的な多様性を確保します。さらに重要なのは、画像編集モデルを利用して主体領域を抽出し、背景を補完し、意味を再記述することで、一般的な「コピー＆ペースト」の偽影を効果的に回避し、データの源から生成品質を保障しています。</p><p>2. 多参照条件の融合：モデルは統一的な戦略で視覚情報とテキスト情報を統合してエンコードし、最大4枚の参照画像をサポートします。これにより、ユーザーは複雑な画像の結合や手動によるマスク操作を行うことなく、複雑な多主体、多要素の自然な相互作用とシーンの組み合わせを実現できます。例えば、電子商取引のシーンでは、商品画像とバーチャルアナウンサーの画像を組み合わせて、特定の環境下での商品販売ビデオを直接生成でき、商品の詳細とアナウンサーのアイデンティティ特徴を正確に保持します。</p><p>3. ハイブリッドトレーニング戦略：チームは画像とビデオのハイブリッドトレーニングを利用し、大規模な画像とビデオのデータセットを統合して利用し、多解像度の統合最適化を行って、異なる空間スケールと縦横比に対するロバスト性を向上させています。</p><p>映画・テレビ、電子商取引、広告など多領域をカバーする200組のハイブリッドテストセットを含む評価で、SkyReels - V3は卓越した性能を発揮しました。</p><p>人物、動物、物体、背景シーンなどの多様な参照タイプに対して、SkyReels - V3は参照一致性指標で0.6698を達成し、Vidu Q2（0.5961）、Kling 1.6（0.6630）、PixVerse V5（0.6542）などの主流の商用モデルを上回りました。視覚品質指標では0.8119の得点でトップを占め、参照特徴を保持しながら高忠実度のビデオを生成する強力な能力を証明しました。</p>\", \"zh\": \"<p>1月29日，Skywork AI正式开源自研视频生成模型SkyReels-V3。作为一系列多模态视频生成模型，该系列支持参考图像转视频（Reference Images-to-Video）、视频延长（Video Extension）和音频驱动虚拟形象（Talking Avatar）三大核心能力，在单一建模架构中实现高保真多模态视频生成，达到行业领先水平。</p><p>三大核心能力作为独立模块，每个模块深度优化且支持灵活组合。Skywork AI团队通过企业级数据处理、极速推理能力和高效的训练架构等技术实现，让生成的视频达到专业级效果，多项指标达到或超越行业领先水平。</p><p>SkyReels-V3可根据1至4张参考图像，并结合文本提示，生成时间连贯、语义一致的高质量视频序列。无论是人物形象、商品展示还是背景场景，生成的视频都能精准保留原始身份特征、空间构图和叙事连贯性。</p><p>其背后是Skywork AI团队在数据构建、多参考条件融合和混合训练策略上的多重技术创新：</p><p>1. 高质量数据构建：团队从海量视频中筛选具有显著动态运动的素材，并采用跨帧配对策略确保时间多样性。更为关键的是，利用图像编辑模型对主体区域进行提取、背景补全和语义重写，有效避免了常见的“复制粘贴”伪影，从数据源头保障了生成质量。</p><p>2. 多参考条件融合：模型采用统一的策略联合编码视觉和文本信息，最多支持4张参考图像。这意味着用户无需进行复杂的图像拼接或手动蒙版，即可实现复杂多主体、多元素的自然交互与场景组合。例如，在电商场景中，可将商品图与虚拟主播形象结合，直接生成一段在特定环境下的带货视频，精准保留商品细节与主播身份特征。</p><p>3. 混合训练策略：团队利用图像-视频混合训练，联合利用大规模图像和视频数据集，且利用多分辨率联合优化提升不同空间尺度和宽高比的鲁棒性。</p><p>在包含200对混合测试集（涵盖电影电视、电商、广告等多领域）的评估中，SkyReels-V3展现出卓越的性能表现。</p><p>面对人物、动物、物体和背景场景等多种参考类型，SkyReels-V3在参考一致性指标上达到0.6698，超越Vidu Q2（0.5961）、Kling 1.6（0.6630）和PixVerse V5（0.6542）等主流商用模型；在视觉质量指标上更以0.8119的得分领先全场，证明了其在保持参考特征的同时生成高保真视频的强大能力。</p>\"}', '{\"en\": \"Kunlun Wanwei\'s SkyReels-V3 is open-sourced, covering three core capabilities: reference image-to-video conversion, video extension, and audio-driven virtual avatars.\", \"ja\": \"崑崙万維のSkyReels - V3がオープンソース化され、参照画像からの動画変換、動画の延長、音声による仮想形象の駆動という3つの核心的な機能をカバーしています。 \", \"zh\": \"昆仑万维SkyReels-V3开源，覆盖参考图像转视频、视频延长、音频驱动虚拟形象三大核心能力\"}', 7, 'http://node-forge.yinchunyu.com/uploads/2026-02-02/1sNh70OJ3.png', NULL, NULL, '1', '0', 81, '2026-02-02 16:07:47', '1', '0', '', 'admin', NULL, 'admin', NULL, '{\"en\": \"Video generation, SkyReels-V3\", \"ja\": \"動画生成、SkyReels - V3\", \"zh\": \"视频生成, SkyReels-V3\"}');
INSERT INTO `news` VALUES (3, '{\"en\": \"$2 billion for Q.ai, apple wants you to \\\"silently\\\" control AI\", \"zh\": \"20 亿美元收 Q.ai，苹果想让你「无声」地控制 AI\"}', '{\"en\": \"<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"0\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"0\\\" data-sentence=\\\"0\\\" data-group=\\\"0-0\\\">Apple, which has been lagging behind in AI, has stepped up its pace in recent months.</span><span class=\\\"tgt color_text_0 highlight\\\" data-section=\\\"0\\\" data-sentence=\\\"1\\\" data-group=\\\"0-1\\\"> After leaving OpenAI and joining hands with Google Gemini, Apple has made a new move recently. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"1\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"2\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"2\\\" data-sentence=\\\"0\\\" data-group=\\\"2-0\\\">On January 29 local time, Apple completed a nearly $2 billion acquisition of Israeli AI startup Q.ai. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"3\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"4\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"4\\\" data-sentence=\\\"0\\\" data-group=\\\"4-0\\\">This is Apple\'s second-largest deal since it acquired Beats for $3 billion in 2014. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"5\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"6\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"6\\\" data-sentence=\\\"0\\\" data-group=\\\"6-0\\\">According to multiple media reports such as the Financial times, the core technology of Q.ai lies in analyzing facial micro-expressions and muscle movements to interpret \\\"Silent Speech\\\", that is, users do not need to make sounds, and their intentions can be recognized by the device just through mouth movements. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"7\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"8\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"8\\\" data-sentence=\\\"0\\\" data-group=\\\"8-0\\\">This technology is expected to be integrated into future AirPods, iphones and even the rumored AI glasses, achieving more private and barrier-free human-computer interaction. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"9\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"10\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"10\\\" data-sentence=\\\"0\\\" data-group=\\\"10-0\\\">The founding team of Q.ai has a prominent background. Aviad Maizels, the co-founder, previously founded PrimeSense, which was acquired by apple in 2013 and whose technology later became the prototype of the iPhone Face ID. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"11\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"12\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"12\\\" data-sentence=\\\"0\\\" data-group=\\\"12-0\\\">This acquisition was announced on the same day that Apple released its strong financial report, highlighting the company\'s urgency to make up for its shortcomings in the AI hardware race. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"13\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"14\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"14\\\" data-sentence=\\\"0\\\" data-group=\\\"14-0\\\">01 </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"15\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"16\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"17\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"17\\\" data-sentence=\\\"0\\\" data-group=\\\"17-0\\\">A silent gamble </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"18\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"19\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"20\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"21\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"22\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"22\\\" data-sentence=\\\"0\\\" data-group=\\\"22-0\\\">The acquisition of Q.a is a concentrated manifestation of apple \'s anxiety about entry points in the era of generative AI. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"23\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"24\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"24\\\" data-sentence=\\\"0\\\" data-group=\\\"24-0\\\">While OpenAI\'s ChatGPT and Google\'s Gemini have redefined interaction through voice and text, Apple\'s Siri has been widely criticized for its outdated experience. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"25\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"26\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"26\\\" data-sentence=\\\"0\\\" data-group=\\\"26-0\\\">The acquisition of Q.ai is apple \'s attempt to open up a \\\"second front\\\" beyond traditional voice interaction. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"27\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"28\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"28\\\" data-sentence=\\\"0\\\" data-group=\\\"28-0\\\">Silent speech recognition technology directly addresses the core pain points of current voice assistants: privacy and scene limitations.</span><span class=\\\"tgt color_text_0\\\" data-section=\\\"28\\\" data-sentence=\\\"1\\\" data-group=\\\"28-1\\\"> It is neither polite nor realistic to speak loudly into the equipment in a meeting room, library or on a noisy street.</span><span class=\\\"tgt color_text_0\\\" data-section=\\\"28\\\" data-sentence=\\\"2\\\" data-group=\\\"28-2\\\"> Like the author, there are quite a few patients who suffer from \\\"voice shame\\\" when facing a second person. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"29\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"30\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"30\\\" data-sentence=\\\"0\\\" data-group=\\\"30-0\\\">And the acquired Q.ai \'s technology promises private, seamless command input in any environment. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"31\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"32\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"32\\\" data-sentence=\\\"0\\\" data-group=\\\"32-0\\\">On a deeper level, this is a continuation of Apple\'s philosophy of \\\"hardware defines experience\\\". </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"33\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"34\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"34\\\" data-sentence=\\\"0\\\" data-group=\\\"34-0\\\">Apple is not content with merely catching up in large cloud models. Instead, it is attempting to create an interactive moat that is difficult for competitors to replicate through the integration of unique sensor technology and hardware. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"35\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"36\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"36\\\" data-sentence=\\\"0\\\" data-group=\\\"36-0\\\">Combining silent recognition with AirPods and future glasses can firmly capture users\' \\\"ears\\\" and \\\"faces\\\", which is a more intimate and longer-lasting entry point than mobile phone screens. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"37\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"38\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"38\\\" data-sentence=\\\"0\\\" data-group=\\\"38-0\\\">Well-known technology blogger Robert Scoble pointed out that this is closely related to the new camera technology that Apple is about to launch, indicating that a multi-device interactive perception network is taking shape. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"39\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"40\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"40\\\" data-sentence=\\\"0\\\" data-group=\\\"40-0\\\">To put it bluntly, Apple is betting that the next interaction paradigm will not be smarter conversations, but more intangible perceptions.</span></p>\", \"zh\": \"<p>在 AI 上日渐落后的苹果，最近几个月加紧了前进步伐。抛弃 OpenAI，携手 Google Gemini 后，苹果近日又有新动作。</p>\\n<p>当地时间 1 月 29 日，苹果公司完成了一项近 20 亿美元的收购，目标是以色列 AI 初创公司 Q.ai。</p>\\n<p><strong>这是苹果自 2014 年以 30 亿美元收购 Beats 以来，规模第二大的交易</strong>。</p>\\n<p>据《金融时报》等多家媒体报道，<strong>Q.ai 的核心技术在于分析面部微表情和肌肉运动，从而解读「无声语音」</strong>（Silent Speech），即用户无需发出声音，仅通过嘴部动作即可被设备识别意图。</p>\\n<p><strong>这项技术被认为有望集成到未来的 AirPods、iPhone 乃至传闻中的 AI 眼镜中，实现更私密、无障碍的人机交互</strong>。</p>\\n<p>Q.ai 的创始团队背景显赫，联合创始人 Aviad Maizels 此前创立的 PrimeSense 公司在 2013 年被苹果收购，其技术后来成为 iPhone Face ID 的原型。</p>\\n<p>此次收购在苹果发布强劲财报的同一天公布，凸显了公司在 AI 硬件竞赛中补短板的急迫性。</p>\\n<section data-mpa-action-id=\\\"ml0b1pi51yye\\\" data-pm-slice=\\\"0 0 []\\\"></section>\\n<section data-mpa-template=\\\"t\\\" data-mpa-action-id=\\\"ml0b1pi51ts6\\\">\\n<section data-mpa-template=\\\"t\\\">\\n<section>\\n<section>\\n<section>\\n<section>\\n<section>\\n<p><em><strong>01<br></strong></em></p>\\n</section>\\n</section>\\n<section>\\n<section></section>\\n</section>\\n</section>\\n</section>\\n</section>\\n<p><strong><span data-pm-slice=\\\"1 1 [&quot;para&quot;,{&quot;tagName&quot;:&quot;p&quot;,&quot;attributes&quot;:{&quot;style&quot;:&quot;margin: 25px 0px; text-align: justify; color: rgb(0, 0, 0); letter-spacing: 1px; font-size: 16px; line-height: 1.75;&quot;,&quot;mpa-paragraph-type&quot;:&quot;body&quot;},&quot;namespaceURI&quot;:&quot;http://www.w3.org/1999/xhtml&quot;}]\\\">「无声」豪赌</span><br></strong></p>\\n</section>\\n</section>\\n<p>&nbsp;</p>\\n<p>Q.ai 收购背后，是苹果在生成式 AI 时代入口焦虑的集中体现。</p>\\n<p>当 OpenAI 的 ChatGPT、谷歌的 Gemini 通过语音和文字重新定义交互时，苹果的 Siri 却因体验落后而备受诟病。</p>\\n<p>收购 Q.ai，是苹果在传统语音交互之外，开辟「第二战场」的尝试。</p>\\n<p><strong>无声语音识别技术直击了当前语音助手的核心痛点：隐私与场景限制。</strong>&nbsp;在会议室、图书馆或嘈杂的街道上，对着设备大声说话既不礼貌也不现实。像笔者一样，面对第二个人就有「语音羞耻症」的患者，不在少数。</p>\\n<p>而被收购的 Q.ai 的技术承诺让用户在任何环境下都能进行私密、无缝的指令输入。</p>\\n<p>更深层次看，这是苹果「硬件定义体验」哲学的延续。</p>\\n<p>苹果不满足于在云端大模型上追赶，而是试图通过独特的传感器技术与硬件集成，打造竞争对手难以复制的交互护城河。</p>\\n<p>将无声识别与 AirPods、未来眼镜结合，<strong>能牢牢抓住用户的「耳朵」和「脸」，这是比手机屏幕更贴身、使用时间更长的入口</strong>。</p>\\n<p>知名科技博主 Robert Scoble 指出，这与苹果即将推出的新型摄像头技术息息相关，预示着多设备联动的感知网络正在形成。</p>\\n<p>说白了，苹果在赌下一个交互范式不是更聪明的对话，而是更无形的感知。</p>\"}', '{\"en\": \"Apple, which has been lagging behind in AI, has stepped up its pace in recent months. After leaving OpenAI and joining hands with Google Gemini, Apple has made a new move recently.\", \"zh\": \"在 AI 上日渐落后的苹果，最近几个月加紧了前进步伐。抛弃 OpenAI，携手 Google Gemini 后，苹果近日又有新动作。\"}', 7, 'http://node-forge.yinchunyu.com/uploads/2026-02-02/yEVDhwzXi.png', NULL, NULL, '0', '0', 32, '2026-02-02 16:10:48', '1', '0', '', 'admin', NULL, 'admin', NULL, '{\"en\": \"\", \"zh\": \"\"}');
INSERT INTO `news` VALUES (4, '{\"en\": \"MiniMax Music 2.5: Grammy-level creation, no more studio needed\", \"zh\": \"MiniMax Music 2.5: 格莱美级创作，不再需要录音棚\"}', '{\"en\": \"\", \"zh\": \"<p data-pm-slice=\\\"0 0 []\\\">今天，我们正式发布 MiniMax Music 2.5：全维度突破，指挥细节，定义真实。</p>\\n<p>AI 音乐始终面对两个挑战：可控性与真实度。前者决定了创作者能否表达真实意图，后者决定了作品是否具备专业质感。</p>\\n<p>过去，从粗糙的 Demo 到具有明星质感的作品之间，隔着昂贵的录音棚、复杂的混音设备以及多年的专业训练。</p>\\n<p>相较于上一代模型，<strong>Music 2.5 在「段落级强控制」与「物理级高保真」两大技术难题上实现突破&mdash;&mdash;让创作更准，让音乐更真。</strong></p>\\n<p><strong>Direct the Detail. Define the Real.&nbsp;</strong></p>\\n<p data-pm-slice=\\\"0 0 []\\\">这道门槛，正在被打破。格莱美级的音乐创作，从此触手可及。</p>\\n<section></section>\\n<section data-pm-slice=\\\"0 0 []\\\">\\n<section>\\n<section>\\n<section></section>\\n</section>\\n</section>\\n</section>\"}', '{\"en\": \"Today, we officially release MiniMax Music 2.5: All-dimensional breakthrough, conducting details, defining reality.\", \"zh\": \"今天，我们正式发布 MiniMax Music 2.5：全维度突破，指挥细节，定义真实。\"}', 7, 'http://node-forge.yinchunyu.com/uploads/2026-02-02/7xauLawQY.png', NULL, NULL, '0', '1', 30, '2026-02-02 16:12:44', '1', '0', '', 'admin', NULL, 'admin', NULL, '{\"en\": \"\", \"zh\": \"\"}');
INSERT INTO `news` VALUES (5, '{\"en\": \"The vLLM team officially announced its start-up: raising 150 million US dollars, and You Kaichao, a recipient of the Tsinghua University Special Award, became a co-founder\", \"zh\": \"vLLM团队官宣创业：融资1.5亿美元，清华特奖游凯超成为联创\"}', '{\"en\": \"\", \"zh\": \"<p>本轮融资由风险投资公司 Andreessen Horowitz（a16z）和 Lightspeed 领投，Sequoia Capital、Altimeter Capital、Redpoint Ventures 和 ZhenFund 也参与了投资。</p>\\n<p>Inferact 的 1.5 亿美元天使轮融资虽不及 Ilya Sutskever 的公司 SSI 的 10 亿美元，但已经超过了 Mistral AI 的 1.15 亿美元，是有史以来规模最大的种子轮融资之一，标志着业界对于 AI 推理基础设施的重视程度正在急速提升。</p>\\n<p>Inferact 的使命是将 vLLM 发展成为世界领先的 AI 推理引擎，并通过降低推理成本、加快推理速度来加速 AI 的发展。</p>\\n<p>该公司认为，AI 行业未来面临的最大挑战不是构建新模型，而是如何以低成本、高可靠性地运行现有模型。</p>\\n<p>毫无疑问，Inferact 的核心是开源项目 vLLM，这是一个于 2023 年启动的开源项目，旨在帮助企业在数据中心硬件上高效运行 AI 模型。</p>\\n<p>vLLM 最初由加州大学伯克利分校（UC Berkeley）的天空计算实验室 (Sky Computing Lab) 开发，现由 PyTorch 基金会负责管理，已吸引了来自整个 AI 行业的 2000 多名贡献者，是全球范围内最受欢迎的开源大模型推理加速框架。</p>\\n<p>如今，vLLM 的推理能力在为 Meta、谷歌、Character.AI 等科技公司提供支持。</p>\\n<p>Inferact 的首席执行官 Simon Mo 是一位伯克利在读博士生，他是 vLLM 的创始维护者之一。Mo 表示，公司成立于 2025 年 11 月，并于本周正式对外公布。他将 Inferact 的起源与伯克利早期的一些软件项目进行了比较，这些项目后来发展成为规模更大的企业，例如 Apache Spark 和 Ray。</p>\\n<section></section>\\n<section data-pm-slice=\\\"0 0 []\\\">\\n<section>\\n<section>\\n<section></section>\\n</section>\\n</section>\\n</section>\"}', '{\"en\": \"Early Friday morning Beijing time, news came that Inferact, an artificial intelligence startup founded by the creator of the open-source software vLLM, was officially established. It raised 150 million US dollars (about 1 billion yuan) in its seed round of financing, and the company\'s valuation reached 800 million US dollars.\", \"zh\": \"北京时间周五凌晨传来消息，由开源软件 vLLM 的创建者创立的人工智能初创公司 Inferact 正式成立，其在种子轮融资中筹集了 1.5 亿美元（约合 10 亿元人民币），公司估值达到 8 亿美元。\"}', 7, 'http://node-forge.yinchunyu.com/uploads/2026-02-02/DvJXuJXlF.png', NULL, NULL, '0', '1', 141, '2026-02-02 16:14:31', '1', '0', '', 'admin', NULL, 'admin', NULL, '{\"en\": \"\", \"zh\": \"\"}');
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
  `main_image` varchar(500) COLLATE utf8mb4_bin DEFAULT NULL,
  `images` varchar(500) COLLATE utf8mb4_bin DEFAULT '',
  `specifications` json DEFAULT (_utf8mb4'{}'),
  `is_recommend` char(1) COLLATE utf8mb4_bin DEFAULT '0',
  `is_new` char(1) COLLATE utf8mb4_bin DEFAULT '0',
  `view_count` int DEFAULT '0',
  `status` char(1) COLLATE utf8mb4_bin DEFAULT '0',
  `del_flag` char(1) COLLATE utf8mb4_bin DEFAULT '0',
  `remark` varchar(500) COLLATE utf8mb4_bin DEFAULT '',
  `create_by` varchar(64) COLLATE utf8mb4_bin DEFAULT '',
  `create_time` datetime DEFAULT NULL,
  `update_by` varchar(64) COLLATE utf8mb4_bin DEFAULT '',
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
INSERT INTO `product` VALUES (1, '{\"en\": \"Premium Carbide\", \"zh\": \" KZ4103_Y\"}', '{\"en\": \"<p>This product features a carbide circular saw blade paired with a high-speed steel (HSS) shank, utilizing a screw-countersunk shank design. Its core advantage is the quick-replaceable saw blade, enabling an economical \\\"long-lasting shank, on-demand blade replacement\\\" combination that significantly reduces long-term operating costs.</p>\\n<p>In addition to the HSS shank, this circular saw blade can also be paired with a ferritic stainless steel shank or configured as a solid carbide shank. For these multiple options and a customized quote, please feel free to contact us.</p>\", \"zh\": \"<p class=\\\"MsoNormal\\\">●&nbsp;采用32核处理器+FPGA双核架构设计，运算能力强、并行处理数据快，存储容量大，适用于复杂移动机械在恶劣作业环境下智能化控制；</p>\\n<p class=\\\"MsoNormal\\\">●&nbsp;采用软硬件特殊防护设计，满足移动机械对控制器在高湿高温、防水防尘、高冲击、强振动及复杂电磁环境下的特殊要求；</p>\\n<p class=\\\"MsoNormal\\\">●&nbsp;使用国际标准J1939协议，与发动机进行数据交换,并对其运行状态进行实时监测和控制；</p>\\n<p class=\\\"MsoNormal\\\">●&nbsp;控制油门执行机构对发动机调速；</p>\\n<p class=\\\"MsoNormal\\\">●&nbsp;对电磁比例阀进行精准电流控制，不受温度及电压波动干扰；</p>\\n<p class=\\\"MsoNormal\\\">●&nbsp;运行控制软件，直接控制移动机械液压电磁阀、继电器及其它电子电器部件，使之智能化作业；</p>\\n<p class=\\\"MsoNormal\\\">●&nbsp;为外接传感器提供多路独立电源；</p>\\n<p class=\\\"MsoNormal\\\">●&nbsp;具备完整的系统监视、故障诊断、报警及信息管理；</p>\\n<p class=\\\"MsoNormal\\\">●&nbsp;机械负载、电缆开路或短路自动检测；</p>\\n<p class=\\\"MsoNormal\\\">●&nbsp;机械传感器、开关、电子、电器部件可直接连接，有过电压和电气干扰保护；</p>\\n<p class=\\\"MsoNormal\\\">●&nbsp;CAN总线接口可与其它电子装置交换信息，可以使用不同协议操作；</p>\\n<p class=\\\"MsoNormal\\\">● 符合IEC61131-3标准，可兼容使用KQcode平台、Codesys 3.5国际通用平台进行编程，开发效率高，可快速、安全地将机械投入运行。</p>\"}', '{\"en\": \"It adopts a dual-core architecture design of a 32-core processor and FPGA, featuring strong computing power, fast parallel data processing, and large storage capacity. It is suitable for intelligent control of complex mobile machinery in harsh working environments\", \"zh\": \"采用32核处理器+FPGA双核架构设计，运算能力强、并行处理数据快，存储容量大，适用于复杂移动机械在恶劣作业环境下智能化控制\"}', 3, 'http://node-forge.yinchunyu.com/uploads/2026-01-28/ZyAOKcbHz.png', '', '{}', '1', '0', 58, '1', '0', '', 'admin', NULL, 'admin', '2026-02-04 03:23:39', '{\"en\": \"\", \"zh\": \"\"}');
INSERT INTO `product` VALUES (2, '{\"en\": \"TK5001\", \"zh\": \"TK5001\"}', '{\"en\": \"\", \"zh\": \"<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"0\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"0\\\" data-sentence=\\\"0\\\" data-group=\\\"0-0\\\">● Brand-new appearance design; </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"1\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"2\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"2\\\" data-sentence=\\\"0\\\" data-group=\\\"2-0\\\">● High-precision positioning, supporting RTK technology, achieving centimeter-level positioning accuracy; </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"3\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"4\\\"><span class=\\\"tgt color_text_0 highlight\\\" data-section=\\\"4\\\" data-sentence=\\\"0\\\" data-group=\\\"4-0\\\">It supports 4G LTE communication through the SIM card interface and is suitable for remote data transmission and control. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"5\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"6\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"6\\\" data-sentence=\\\"0\\\" data-group=\\\"6-0\\\">● Multi-band antenna support, equipped with 4G LTE and WIFI antennas to ensure reliable wireless communication; </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"7\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"8\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"8\\\" data-sentence=\\\"0\\\" data-group=\\\"8-0\\\">● RS422 and CAN communication are configured. RS422 is used for high-precision data transmission, while CAN is used for real-time control and data exchange. Through the joint efforts of RS422 and CAN, the high-precision positioning and real-time control of the system are achieved. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"9\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"10\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"10\\\" data-sentence=\\\"0\\\" data-group=\\\"10-0\\\">● Equipped with indicator lights, it can promptly feedback the status of the controller. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"11\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"12\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"12\\\" data-sentence=\\\"0\\\" data-group=\\\"12-0\\\">● Supports mainstream differential protocols in the industry such as RTCM and CMR; </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"13\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"14\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"14\\\" data-sentence=\\\"0\\\" data-group=\\\"14-0\\\">● IP67 design, safe and reliable; </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"15\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"16\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"16\\\" data-sentence=\\\"0\\\" data-group=\\\"16-0\\\">● Flexible installation methods are available, including threaded rod and screw fixation, etc. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"17\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"18\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"18\\\" data-sentence=\\\"0\\\" data-group=\\\"18-0\\\">● Supports secondary development.</span></p>\"}', '{\"en\": \"Mobile mechanical equipment\\nProduct features: RTK controller\", \"zh\": \"移动机械装备\\n产品特色：RTK控制器\"}', 3, 'http://node-forge.yinchunyu.com/uploads/2026-01-30/NfPwkJD3K.jpeg', '', '{}', '0', '0', 3, '1', '0', '', 'admin', '2026-01-30 06:58:33', 'admin', '2026-02-04 06:47:19', '{\"en\": \"\", \"zh\": \"\"}');
INSERT INTO `product` VALUES (3, '{\"en\": \"JK4116\", \"zh\": \"JK4116\"}', '{\"en\": \"<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"0\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"0\\\" data-sentence=\\\"0\\\" data-group=\\\"0-0\\\">● Interact with machinery through human-machine interaction and conduct intelligent control over it; </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"1\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"2\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"2\\\" data-sentence=\\\"0\\\" data-group=\\\"2-0\\\">● Touch virtual keyboard operation; </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"3\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"4\\\"><span class=\\\"tgt color_text_0 highlight\\\" data-section=\\\"4\\\" data-sentence=\\\"0\\\" data-group=\\\"4-0\\\">● Remote upgrade of systems and applications; </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"5\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"6\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"6\\\" data-sentence=\\\"0\\\" data-group=\\\"6-0\\\">● Use the international standard J1939 protocol to exchange data with the engine and conduct real-time monitoring and control of its operating status; </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"7\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"8\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"8\\\" data-sentence=\\\"0\\\" data-group=\\\"8-0\\\">Control the throttle actuator to adjust the speed of the engine; </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"9\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"10\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"10\\\" data-sentence=\\\"0\\\" data-group=\\\"10-0\\\">● Directly control the hydraulic solenoid valves, relays and other electronic and electrical components of mobile machinery to enable intelligent operation; </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"11\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"12\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"12\\\" data-sentence=\\\"0\\\" data-group=\\\"12-0\\\">● Provide independent power supply for external sensors; </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"13\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"14\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"14\\\" data-sentence=\\\"0\\\" data-group=\\\"14-0\\\">The system and applications are offline via an SD card. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"15\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"16\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"16\\\" data-sentence=\\\"0\\\" data-group=\\\"16-0\\\">It adopts a special protection design for both software and hardware to meet the special requirements of mobile machinery for products in high-temperature and high-humidity, waterproof and dustproof, high-impact, strong vibration and complex electromagnetic environments. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"17\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"18\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"18\\\" data-sentence=\\\"0\\\" data-group=\\\"18-0\\\">The display screen has a wide viewing Angle. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"19\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"20\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"20\\\" data-sentence=\\\"0\\\" data-group=\\\"20-0\\\">It adopts a three-in-one structure of LCD screen, touch screen and protective glass to prevent water mist in the interlayer and image refraction deformation. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"21\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"22\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"22\\\" data-sentence=\\\"0\\\" data-group=\\\"22-0\\\">● Display of mechanical operation data and working status.</span><span class=\\\"tgt color_text_0\\\" data-section=\\\"22\\\" data-sentence=\\\"1\\\" data-group=\\\"22-1\\\"> Storage of historical alarm records and set parameters; </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"23\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"24\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"24\\\" data-sentence=\\\"0\\\" data-group=\\\"24-0\\\">● It adopts graphics acceleration technology and has a short startup time. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"25\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"26\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"26\\\" data-sentence=\\\"0\\\" data-group=\\\"26-0\\\">It complies with the IEC61131-3 standard and is compatible with programming using the KQcode platform and the codesys 3.5 international common platform.</span></p>\", \"zh\": \"<p class=\\\"MsoNormal\\\">●&nbsp;与机械进行人机交互，并对其进行智能化控制；</p>\\n<p class=\\\"MsoNormal\\\">●&nbsp;触摸虚拟键盘操作；</p>\\n<p class=\\\"MsoNormal\\\">●&nbsp;系统及应用程序远程升级；</p>\\n<p class=\\\"MsoNormal\\\">●&nbsp;使用国际标准J1939协议，与发动机进行数据交换,并对其运行状态进行实时监测和控制；</p>\\n<p class=\\\"MsoNormal\\\">●&nbsp;控制油门执行机构对发动机调速；</p>\\n<p class=\\\"MsoNormal\\\">●&nbsp;直接控制移动机械液压电磁阀、继电器及其它电子电器部件，使之智能化作业；</p>\\n<p class=\\\"MsoNormal\\\">●&nbsp;为外接传感器提供独立电源；</p>\\n<p class=\\\"MsoNormal\\\">●&nbsp;系统及应用程序通过SD卡离线；</p>\\n<p class=\\\"MsoNormal\\\">●&nbsp;采用软硬件特殊防护设计，满足移动机械对产品在高温高湿、防水防尘、高冲击、强振动及复杂电磁环境下的特殊要求；</p>\\n<p class=\\\"MsoNormal\\\">●&nbsp;显示屏可视角度大；</p>\\n<p class=\\\"MsoNormal\\\">●&nbsp;采用液晶屏、触摸屏及防护玻璃三合一结构，防止夹层水雾及图像折射变形；</p>\\n<p class=\\\"MsoNormal\\\">●&nbsp;机械运行数据及作业状态显示。历史报警记录及设置参数存储；</p>\\n<p class=\\\"MsoNormal\\\">●&nbsp;采用图形加速技术，启动时间短。</p>\\n<p class=\\\"MsoNormal\\\">● 符合IEC61131-3标准，可兼容使用KQcode平台、codesys 3.5国际通用平台进行编程。</p>\"}', '{\"en\": \"Mobile mechanical equipment\\n4.3-inch touch display and control terminal\", \"zh\": \"移动机械装备\\n4.3寸触摸显控终端\"}', 4, 'http://node-forge.yinchunyu.com/uploads/2026-01-30/CF4Om4Zyv.png', 'http://node-forge.yinchunyu.com/uploads/2026-01-30/q0955gZhl.png,http://node-forge.yinchunyu.com/uploads/2026-01-30/4aYXnk8Y9.png', '{}', '1', '0', 12, '1', '0', '', 'admin', '2026-01-30 06:59:50', 'admin', '2026-02-04 06:48:20', '{\"en\": \"\", \"zh\": \"\"}');
INSERT INTO `product` VALUES (4, '{\"en\": \"KZ5104\", \"zh\": \"KZ5104\"}', '{\"en\": \"<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"0\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"0\\\" data-sentence=\\\"0\\\" data-group=\\\"0-0\\\">It adopts a 32-core processor architecture design, featuring strong computing power, fast parallel data processing, and large storage capacity. It is suitable for intelligent control of complex mobile machinery in harsh working environments. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"1\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"2\\\"><span class=\\\"tgt color_text_0 highlight\\\" data-section=\\\"2\\\" data-sentence=\\\"0\\\" data-group=\\\"2-0\\\">It adopts a special protection design for both software and hardware to meet the special requirements of mobile machinery for the controller in high-humidity and high-temperature, waterproof and dustproof, high-shock, strong vibration and complex electromagnetic environments. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"3\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"4\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"4\\\" data-sentence=\\\"0\\\" data-group=\\\"4-0\\\">● Use the international standard J1939 protocol to exchange data with the engine and conduct real-time monitoring and control of its operating status; </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"5\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"6\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"6\\\" data-sentence=\\\"0\\\" data-group=\\\"6-0\\\">Control the throttle actuator to adjust the speed of the engine; </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"7\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"8\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"8\\\" data-sentence=\\\"0\\\" data-group=\\\"8-0\\\">● Precise current control of the electromagnetic proportional valve is achieved, free from interference by temperature and voltage fluctuations. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"9\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"10\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"10\\\" data-sentence=\\\"0\\\" data-group=\\\"10-0\\\">The operation control software directly controls the hydraulic solenoid valves, relays and other electronic and electrical components of the mobile machinery, enabling intelligent operation. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"11\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"12\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"12\\\" data-sentence=\\\"0\\\" data-group=\\\"12-0\\\">● Provide multiple independent power supplies for external sensors; </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"13\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"14\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"14\\\" data-sentence=\\\"0\\\" data-group=\\\"14-0\\\">It is equipped with complete system monitoring, fault diagnosis, alarm and information management. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"15\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"16\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"16\\\" data-sentence=\\\"0\\\" data-group=\\\"16-0\\\">● Automatic detection of mechanical load, open circuit or short circuit of cables; </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"17\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"18\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"18\\\" data-sentence=\\\"0\\\" data-group=\\\"18-0\\\">Mechanical sensors, switches, electronic and electrical components can be directly connected, and there is overvoltage and electrical interference protection. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"19\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"20\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"20\\\" data-sentence=\\\"0\\\" data-group=\\\"20-0\\\">The CAN bus interface can exchange information with other electronic devices and operate using different protocols. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"21\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"22\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"22\\\" data-sentence=\\\"0\\\" data-group=\\\"22-0\\\">It complies with the IEC61131-3 standard and is compatible with programming using the KQcode platform and the internationally recognized Codesys 3.5 platform. It features high development efficiency and enables the machinery to be put into operation quickly and safely.</span></p>\", \"zh\": \"<p>● 采用32核处理器架构设计，运算能力强、并行处理数据快，存储容量大，适用于复杂移动机械在恶劣作业环境下智能化控制；</p>\\n<p>● 采用软硬件特殊防护设计，满足移动机械对控制器在高湿高温、防水防尘、高冲击、强振动及复杂● 电磁环境下的特殊要求；</p>\\n<p>● 使用国际标准J1939协议，与发动机进行数据交换,并对其运行状态进行实时监测和控制；</p>\\n<p>● 控制油门执行机构对发动机调速；</p>\\n<p>● 对电磁比例阀进行精准电流控制，不受温度及电压波动干扰；</p>\\n<p>● 运行控制软件，直接控制移动机械液压电磁阀、继电器及其它电子电器部件，使之智能化作业；</p>\\n<p>● 为外接传感器提供多路独立电源；</p>\\n<p>● 具备完整的系统监视、故障诊断、报警及信息管理；</p>\\n<p>● 机械负载、电缆开路或短路自动检测；</p>\\n<p>● 机械传感器、开关、电子、电器部件可直接连接，有过电压和电气干扰保护；</p>\\n<p>● CAN总线接口可与其它电子装置交换信息，可以使用不同协议操作；</p>\\n<p>● 符合IEC61131-3标准，可兼容使用KQcode平台、Codesys 3.5国际通用平台进行编程，开发效率高，可快速、安全地将机械投入运行。</p>\"}', '{\"en\": \"Application field: Mobile mechanical equipment\\nProduct features: Small controller\", \"zh\": \"应用领域: 移动机械装备\\n产品特色: 小型控制器\"}', 3, 'http://node-forge.yinchunyu.com/uploads/2026-01-30/nzP3l3PNP.jpeg', '', '{}', '0', '0', 3, '1', '0', '', 'admin', '2026-01-30 07:07:42', 'admin', '2026-02-04 06:47:44', '{\"en\": \"\", \"zh\": \"\"}');
INSERT INTO `product` VALUES (5, '{\"en\": \"XQ4106\", \"zh\": \"XQ4106\"}', '{\"en\": \"<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"0\\\"><span class=\\\"tgt color_text_0 highlight\\\" data-section=\\\"0\\\" data-sentence=\\\"0\\\" data-group=\\\"0-0\\\">The entire vehicle monitor mainly consists of a device shell, a touchable LCD screen, a main circuit board and multiple industrial standard interface boards, meeting the communication requirements of the project for the device </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"1\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"1\\\" data-sentence=\\\"0\\\" data-group=\\\"1-0\\\">It can perform human-computer interaction without damaging the touch LCD screen in environments with strong vibration and shock </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"2\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"2\\\" data-sentence=\\\"0\\\" data-group=\\\"2-0\\\">The panel is made of high-strength high-quality aluminum alloy plates, and the body is made of high-quality stainless steel. The color is consistent with the panel, which is black RAL9004, and the outer surface is fine sand with a mottled texture </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"3\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"3\\\" data-sentence=\\\"0\\\" data-group=\\\"3-0\\\">The device provides an independent protective grounding terminal, adopting a sealed chassis stud lead-out structure. Through the matching nuts, the round bare end OT grounding terminal is fixed to prevent accidental wiring detachment.</span><span class=\\\"tgt color_text_0\\\" data-section=\\\"3\\\" data-sentence=\\\"1\\\" data-group=\\\"3-1\\\"> The grounding symbol of the grounding terminal of the device is clearly marked, and the safety grounding circuit meets the requirements for short-circuit current flow. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"4\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"4\\\" data-sentence=\\\"0\\\" data-group=\\\"4-0\\\">The device is pre-installed with the standard version of the Windows 7 64-bit operating system, common fonts such as Microsoft Yahei and Huawen Kaiti are installed, and all required drivers are installed. It supports Profibus communication, Modbus communication, Ethernet communication with on-site industrial equipment, as well as communication with the SCADA system. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"5\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"5\\\" data-sentence=\\\"0\\\" data-group=\\\"5-0\\\">The processor adopts an Intel&reg; Atom&trade; E3845 1.91GHz processor, with 4GB of memory and 64GB of SSD storage</span></p>\", \"zh\": \"<div>● 车载监控器整机主要由装置外壳、可触控液晶屏、主体电路板及多个工业标准接口板构成，满足项目对装置的通讯要求</div>\\n<div>● 能在强震动、强冲击环境下，进行人机交互而不损坏触摸液晶屏幕</div>\\n<div>● 面板采用高强度优质铝合金板材，优质不锈钢机身，颜色和面板一致，颜色为黑色RAL9004，外表面为麻纹细砂</div>\\n<div>● 装置提供独立的保护接地端子，采用密封机箱螺柱引出式结构，并通过配套螺帽，固定圆型裸端头OT接地端子，防止接线偶然脱落。装置接地端子接地符号标示清晰，安全接地回路满足短路电流流通的要求；</div>\\n<div>● 装置预装标准版Win7 64位操作系统，安装如微软雅黑、华文楷体等字常见字体，安装所需全部驱动，支持与现场工业设备之间的 Profibus通信、Modbus通信、以太网通信以及与SCADA系统之间的通信。</div>\\n<div>● 处理器采用Intel&reg; Atom&trade; E3845 1.91GHz处理器、内存4GB、SSD存储64G</div>\"}', '{\"en\": \"Application field: Mobile mechanical equipment\\nProduct features: 12.1-inch high-speed rail on-board all-in-one machine\", \"zh\": \"应用领域: 移动机械装备\\n产品特色: 12.1寸高铁车载一体机\"}', 4, 'http://node-forge.yinchunyu.com/uploads/2026-01-30/ghf2JGSC5.png', '', '{}', '1', '0', 5, '1', '0', '', 'admin', '2026-01-30 07:09:49', 'admin', '2026-02-04 03:22:18', '{\"en\": \"\", \"zh\": \"\"}');
INSERT INTO `product` VALUES (6, '{\"en\": \"JK3103\", \"zh\": \"JK3103\"}', '{\"en\": \"<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"0\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"0\\\" data-sentence=\\\"0\\\" data-group=\\\"0-0\\\">It can work reliably in harsh environments and complex electromagnetic conditions </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"1\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"2\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"2\\\" data-sentence=\\\"0\\\" data-group=\\\"2-0\\\">● CORTEXT-M4 ARM+FPGA, dual-core dual-system framework. The dual cores respectively perform HMI and logic control tasks, with fast operation speed </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"3\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"4\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"4\\\" data-sentence=\\\"0\\\" data-group=\\\"4-0\\\">It integrates control, display and wireless transmission operation, with a compact structure and high integration </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"5\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"6\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"6\\\" data-sentence=\\\"0\\\" data-group=\\\"6-0\\\">Support the intelligent connection of devices with the Internet of Things platform to obtain the operating status of machines and equipment, and conduct remote monitoring and full life cycle management </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"7\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"8\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"8\\\" data-sentence=\\\"0\\\" data-group=\\\"8-0\\\">● According to device changes, it supports flexible configuration and expansion of fieldbus resources </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"9\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"10\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"10\\\" data-sentence=\\\"0\\\" data-group=\\\"10-0\\\">● Adopt an advanced one.</span><span class=\\\"tgt color_text_0\\\" data-section=\\\"10\\\" data-sentence=\\\"1\\\" data-group=\\\"10-1\\\"> The software development platform based on the NET architecture and the IEC61131-3 international programming standard integrates logic control and human-machine interface programming, which is efficient, flexible and convenient, reducing the difficulty of programming and maintenance, and allowing users to quickly get started </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"11\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"12\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"12\\\" data-sentence=\\\"0\\\" data-group=\\\"12-0\\\">It provides a large number of industrial control function modules, which are convenient for users to call and greatly improve the development efficiency of users </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"13\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"14\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"14\\\" data-sentence=\\\"0\\\" data-group=\\\"14-0\\\">● Adopt illegal reading verification technology to effectively protect intellectual property rights</span></p>\", \"zh\": \"<p>● 适应于恶劣环境及复杂电磁环境下可靠工作</p><p>● CORTEXT-M4 ARM+FPGA,双核双系统框架，双核分别执行HMI和逻辑控制任务，运行速度快</p><p>● 集控制、显示、无线传输操作于一体，结构紧凑，集成度高</p><p>● 支持设备智联搭载物联网平台获取机器和设备的运行状态，进行远程监控及全生命周期管理</p><p>● 根据设备变化，支持现场总线灵活配置及扩展资源</p><p>● 采用基于先进的.NET架构和IEC61131-3国际编程标准的软件开发平台，对逻辑控制与人机界面一体化编程，高效、灵活、方便，降低编程及维护难度，用户可快速上手</p><p>● 提供大量工业控制功能模块，方便用户调用，极大提高用户开发效率</p><p>● 采用非法读取验证技术，有效保护知识产权</p><p><br></p>\"}', '{\"en\": \"Application field: Mobile mechanical equipment\\nProduct features: 5-inch color display and control terminal\", \"zh\": \"应用领域: 移动机械装备\\n产品特色: 5寸彩色显控终端\"}', 4, 'http://node-forge.yinchunyu.com/uploads/2026-01-30/tJDDuhAZx.png', '', '{}', '0', '0', 18, '1', '0', '', 'admin', '2026-01-30 07:16:15', 'admin', '2026-02-04 08:25:38', '{\"en\": \"\", \"zh\": \"\"}');
INSERT INTO `product` VALUES (7, '{\"en\": \"JK4120\", \"zh\": \"JK4120\"}', '{\"en\": \"<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"0\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"0\\\" data-sentence=\\\"0\\\" data-group=\\\"0-0\\\">&bull; Interact with machinery through human-machine interaction and conduct intelligent control over it; </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"1\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"2\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"2\\\" data-sentence=\\\"0\\\" data-group=\\\"2-0\\\">&bull; Touch virtual keyboard operation; </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"3\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"4\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"4\\\" data-sentence=\\\"0\\\" data-group=\\\"4-0\\\">&bull; Use the international standard J1939 protocol to exchange data with the engine and conduct real-time monitoring and control of its operating status; </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"5\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"6\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"6\\\" data-sentence=\\\"0\\\" data-group=\\\"6-0\\\">Control the throttle actuator to adjust the speed of the engine; </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"7\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"8\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"8\\\" data-sentence=\\\"0\\\" data-group=\\\"8-0\\\">Directly control the hydraulic solenoid valves, relays and other electronic and electrical components of mobile machinery to enable intelligent operation. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"9\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"10\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"10\\\" data-sentence=\\\"0\\\" data-group=\\\"10-0\\\">&bull; Provide independent power supply for external sensors; </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"11\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"12\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"12\\\" data-sentence=\\\"0\\\" data-group=\\\"12-0\\\">The system and applications are upgraded via SD card. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"13\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"14\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"14\\\" data-sentence=\\\"0\\\" data-group=\\\"14-0\\\">It adopts a special protection design for both software and hardware to meet the special requirements of mobile machinery for products in high-temperature and high-humidity, waterproof and dustproof, high-impact, strong vibration and complex electromagnetic environments. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"15\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"16\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"16\\\" data-sentence=\\\"0\\\" data-group=\\\"16-0\\\">The display screen has a wide viewing Angle. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"17\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"18\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"18\\\" data-sentence=\\\"0\\\" data-group=\\\"18-0\\\">It adopts a three-in-one structure of LCD screen, touch screen and protective glass to prevent water mist in the interlayer and image refraction deformation. </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"19\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"20\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"20\\\" data-sentence=\\\"0\\\" data-group=\\\"20-0\\\">Mechanical operation data and work status display, historical alarm records and set parameter storage; </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"21\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"22\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"22\\\" data-sentence=\\\"0\\\" data-group=\\\"22-0\\\">&bull; It adopts graphics acceleration technology, with a short startup time; </span></p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"23\\\">&nbsp;</p>\\n<p class=\\\"tgt color_text_0 un-step-trans\\\" data-section=\\\"24\\\"><span class=\\\"tgt color_text_0\\\" data-section=\\\"24\\\" data-sentence=\\\"0\\\" data-group=\\\"24-0\\\">It complies with the IEC61131-3 standard and is compatible with programming using the KQcode platform and the Codesys 3.5 international common platform.</span></p>\", \"zh\": \"<p>&bull; 与机械进行人机交互，并对其进行智能化控制；</p>\\n<p>&bull; 触摸虚拟键盘操作；</p>\\n<p>&bull; 使用国际标准J1939协议，与发动机进行数据交换,并对其运行状态进行实时监测和控制；</p>\\n<p>&bull; 控制油门执行机构对发动机调速；</p>\\n<p>&bull; 直接控制移动机械液压电磁阀、继电器及其它电子电器部件，使之智能化作业；</p>\\n<p>&bull; 为外接传感器提供独立电源；</p>\\n<p>&bull; 系统及应用程序通过SD卡升级；</p>\\n<p>&bull; 采用软硬件特殊防护设计，满足移动机械对产品在高温高湿、防水防尘、高冲击、强振动及复杂电磁环境下的特殊要求；</p>\\n<p>&bull; 显示屏可视角度大；</p>\\n<p>&bull; 采用液晶屏、触摸屏及防护玻璃三合一结构，防止夹层水雾及图像折射变形；</p>\\n<p>&bull; 机械运行数据及作业状态显示，历史报警记录及设置参数存储；</p>\\n<p>&bull; 采用图形加速技术，启动时间短；</p>\\n<p>&bull; 符合IEC61131-3标准，可兼容使用KQcode平台、Codesys 3.5国际通用平台进行编程。</p>\"}', '{\"en\": \"Application field: Mobile mechanical equipment\\nProduct features: 5-inch color display and control terminal\", \"zh\": \"应用领域: 移动机械装备\\n产品特色: 5寸彩色显控终端\"}', 4, 'http://node-forge.yinchunyu.com/uploads/2026-01-30/nuWKbChd2.jpeg', '', '{}', '0', '0', 8, '1', '0', '', 'admin', '2026-01-30 09:04:18', 'admin', '2026-02-04 12:55:29', '{\"en\": \"JK4120, monitor\", \"zh\": \"JK4120, 显示器\"}');
INSERT INTO `product` VALUES (8, '{\"zh\": \"2026新款AI智能机器狗\"}', '{\"zh\": \"<p>2026新款ai智能机器狗儿童玩具男孩电动遥控编程机械人工新年礼物</p><p><img src=\\\"http://node-forge.yinchunyu.com/uploads/2026-02-05/tJrRZMyFU.jpeg\\\" alt=\\\"\\\" data-href=\\\"http://node-forge.yinchunyu.com/uploads/2026-02-05/tJrRZMyFU.jpeg\\\" style=\\\"\\\"/></p><p><br></p>\"}', '{\"zh\": \"儿童玩具男孩电动遥控编程机械人工新年礼物\"}', 18, 'http://node-forge.yinchunyu.com/uploads/2026-02-05/lMi7EkT1D.jpeg', '', '{}', '0', '0', 1, '1', '0', '', 'admin', '2026-02-05 08:44:09', 'admin', '2026-02-05 08:45:23', '{}');
INSERT INTO `product` VALUES (9, '{\"en\": \"Intelligent welcome and explanation robot\", \"ja\": \"スマート迎賓解説ロボット\", \"zh\": \"智能迎宾讲解机器人\"}', '{\"en\": \"<p><span style=\\\"color: rgba(9, 9, 10, 0.92); font-size: 14px;\\\">Leopard Secretary Mini (discount available upon consultation), Leopard Secretary 2, Instruction Manual. For detailed information on the overall machine discount price, please consult us.</span></p>\", \"ja\": \"<p><span style=\\\"color: rgba(9, 9, 10, 0.92); font-size: 14px;\\\">豹小秘mini（相談すると特典あり）、豹小秘2、取扱説明書、本体特典価格については詳しく相談できます。</span></p>\", \"zh\": \"<p><span style=\\\"color: rgba(9, 9, 10, 0.92); font-size: 14px;\\\">豹小秘mini(咨询可优惠),豹小秘2,说明书,整机优惠价可详询</span></p>\"}', '{\"en\": \"Explanation of robot AI dialogue, human - machine interaction exhibition hall, hospital and school front - desk reception robots\", \"ja\": \"ロボットのAI対話やヒューマン・マシンインタラクションの解説展示ホール、病院や学校の受付ロボット\", \"zh\": \"讲解机器人AI对话人机交互展厅医院学校前台接待机器人\"}', 18, 'http://node-forge.yinchunyu.com/uploads/2026-02-05/YT6xs9gDx.png', '', '{}', '0', '0', 1, '1', '0', '', 'admin', '2026-02-05 08:46:53', 'admin', '2026-02-06 07:07:33', '{\"zh\": \"\"}');
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
  `page_type` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `page_key` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL,
  `title` json DEFAULT (_utf8mb4'{"zh":"","en":""}'),
  `keywords` json DEFAULT (_utf8mb4'{"zh":"","en":""}'),
  `description` json DEFAULT (_utf8mb4'{"zh":"","en":""}'),
  `og_title` json DEFAULT (_utf8mb4'{"zh":"","en":""}'),
  `og_description` json DEFAULT (_utf8mb4'{"zh":"","en":""}'),
  `og_image` varchar(500) COLLATE utf8mb4_bin DEFAULT NULL,
  `del_flag` char(1) COLLATE utf8mb4_bin DEFAULT '0',
  `remark` varchar(500) COLLATE utf8mb4_bin DEFAULT '',
  `create_by` varchar(64) COLLATE utf8mb4_bin DEFAULT '',
  `create_time` datetime DEFAULT NULL,
  `update_by` varchar(64) COLLATE utf8mb4_bin DEFAULT '',
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
INSERT INTO `user` VALUES (1, 'admin', 'admin', '00', '5428@qq.com', '15677777777', '0', '/uploads/DRYdnUydl.png', '9c68fb331431f8dcfb7defef22b0c527', 'Y2uPc7hyq8Vi5qBc879Ut', '0', '0', '', NULL, 1, '', '', NULL, '', '2024-12-14 09:14:45');
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
