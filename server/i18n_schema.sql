-- ----------------------------
-- i18n 多语言配置表
-- Date: 2026-02-05
-- ----------------------------

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for i18n_locale (语言配置表)
-- ----------------------------
DROP TABLE IF EXISTS `i18n_locale`;
CREATE TABLE `i18n_locale` (
  `locale_id` int NOT NULL AUTO_INCREMENT COMMENT '语言主键',
  `locale_code` varchar(10) COLLATE utf8mb4_bin NOT NULL COMMENT '语言代码（如: zh, en, ja）',
  `locale_name` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '语言名称',
  `is_default` varchar(1) COLLATE utf8mb4_bin DEFAULT 'N' COMMENT '是否默认语言',
  `icon` varchar(100) COLLATE utf8mb4_bin DEFAULT '' COMMENT '语言图标',
  `sort_order` int DEFAULT '0' COMMENT '排序',
  `status` varchar(1) COLLATE utf8mb4_bin DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `remark` varchar(500) COLLATE utf8mb4_bin DEFAULT '' COMMENT '备注',
  `create_by` varchar(64) COLLATE utf8mb4_bin DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_bin DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`locale_id`),
  UNIQUE KEY `uk_locale_code` (`locale_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='多语言配置表';

-- ----------------------------
-- Records of i18n_locale
-- ----------------------------
BEGIN;
INSERT INTO `i18n_locale` (`locale_code`, `locale_name`, `is_default`, `icon`, `sort_order`, `status`, `create_time`, `update_time`) VALUES
('zh', '简体中文', 'Y', '🇨🇳', 1, '0', NOW(), NOW()),
('en', 'English', 'N', '🇺🇸', 2, '0', NOW(), NOW());
COMMIT;

-- ----------------------------
-- Table structure for i18n_translation (翻译内容表)
-- ----------------------------
DROP TABLE IF EXISTS `i18n_translation`;
CREATE TABLE `i18n_translation` (
  `translation_id` int NOT NULL AUTO_INCREMENT COMMENT '翻译主键',
  `locale_code` varchar(10) COLLATE utf8mb4_bin NOT NULL COMMENT '语言代码',
  `translation_key` varchar(200) COLLATE utf8mb4_bin NOT NULL COMMENT '翻译键（如: site.name, nav.home）',
  `translation_value` text COLLATE utf8mb4_bin COMMENT '翻译值',
  `group_name` varchar(50) COLLATE utf8mb4_bin DEFAULT '' COMMENT '分组（如: site, nav, home）',
  `sort_order` int DEFAULT '0' COMMENT '排序',
  `remark` varchar(500) COLLATE utf8mb4_bin DEFAULT '' COMMENT '备注',
  `create_by` varchar(64) COLLATE utf8mb4_bin DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_bin DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`translation_id`),
  KEY `idx_locale_code` (`locale_code`),
  KEY `idx_translation_key` (`translation_key`),
  KEY `idx_group_name` (`group_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='多语言翻译内容表';

SET FOREIGN_KEY_CHECKS = 1;
