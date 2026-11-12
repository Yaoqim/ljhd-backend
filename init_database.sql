-- =====================================================================
-- 连接互动统一认证微服务系统 - 数据库初始化脚本
-- 基于详细需求分析文档_完整版.md生成
-- 字符编码: UTF-8
-- =====================================================================

-- =====================================================================
-- 1. 用户相关表
-- =====================================================================

-- 用户表
CREATE TABLE `user` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键',
  `user_code` VARCHAR(64) NOT NULL UNIQUE COMMENT '用户编码（唯一）',
  `nickname` VARCHAR(64) NOT NULL COMMENT '昵称',
  `id_card` VARCHAR(18) COMMENT '身份证号（可选）',
  `sex` CHAR(2) COMMENT '性别：男/女/未知',
  `phone` VARCHAR(20) COMMENT '手机号（可选）',
  `password` VARCHAR(255) COMMENT '密码（按Spring Security加密存储）',
  `status` CHAR(10) NOT NULL DEFAULT 'ENABLED' COMMENT '用户状态：ENABLED(启用)/DISABLED(停用)/FROZEN(冻结)/DELETED(删除)',
  `created_person` VARCHAR(64) COMMENT '创建人',
  `created_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_person` VARCHAR(64) COMMENT '修改人',
  `updated_time` DATETIME COMMENT '修改时间',
  INDEX `idx_user_code` (`user_code`),
  INDEX `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT '用户表';

-- 用户角色关联表
CREATE TABLE `user_role` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键',
  `user_code` VARCHAR(64) NOT NULL COMMENT '用户编码',
  `role_code` VARCHAR(64) NOT NULL COMMENT '角色编码',
  `created_person` VARCHAR(64) COMMENT '创建人',
  `created_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  UNIQUE KEY `uk_user_role` (`user_code`, `role_code`),
  INDEX `idx_user_code` (`user_code`),
  INDEX `idx_role_code` (`role_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT '用户角色关联表';

-- 第三方登录绑定表
CREATE TABLE `third_party_login_binding` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键',
  `user_code` VARCHAR(64) NOT NULL COMMENT '平台用户编码',
  `app_code` VARCHAR(64) COMMENT '应用编码（关联Application表的app_code；NULL表示通用登录方式）',
  `login_type` CHAR(10) NOT NULL COMMENT '登录类型：WECHAT(微信)/MOBILE_CODE(手机验证码)/PASSWORD(密码)',
  `unionid` VARCHAR(64) COMMENT '微信unionid（全局唯一，有值表示微信登录）',
  `phone_number` VARCHAR(20) COMMENT '手机号（两种登录方式都可能有，全局唯一）',
  `nickname` VARCHAR(64) COMMENT '用户昵称（从第三方平台获取）',
  `avatar` VARCHAR(255) COMMENT '用户头像URL（从第三方平台获取）',
  `status` CHAR(10) NOT NULL DEFAULT 'ACTIVE' COMMENT '绑定状态：ACTIVE(活跃)/FROZEN(冻结)',
  `bound_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '绑定时间',
  `joined_time` DATETIME COMMENT '加入应用时间（用户通过此登录方式首次登录该应用时记录）',
  `last_login_time` DATETIME COMMENT '最后登录时间',
  `created_person` VARCHAR(64) COMMENT '创建人',
  `created_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  UNIQUE KEY `uk_user_app` (`user_code`, `app_code`),
  INDEX `idx_user_code` (`user_code`),
  INDEX `idx_app_code` (`app_code`),
  INDEX `idx_unionid` (`unionid`),
  INDEX `idx_phone_number` (`phone_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT '第三方登录绑定表';
-- =====================================================================
-- 2. 角色与权限相关表
-- =====================================================================

-- 角色表
CREATE TABLE `role` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键',
  `role_code` VARCHAR(64) NOT NULL UNIQUE COMMENT '角色编码（唯一）',
  `role_name` VARCHAR(64) NOT NULL COMMENT '角色名称',
  `role_desc` VARCHAR(500) COMMENT '角色说明',
  `is_default_role` CHAR(1) DEFAULT 'N' COMMENT '是否默认角色：Y(是)/N(否)',
  `app_code` VARCHAR(64) COMMENT '应用编码（可选，如果指定则为该应用的专用角色，NULL表示通用角色）',
  `status` CHAR(10) NOT NULL DEFAULT 'ENABLED' COMMENT '角色状态：ENABLED(启用)/DISABLED(停用)/DELETED(删除)',
  `created_person` VARCHAR(64) COMMENT '创建人',
  `created_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_person` VARCHAR(64) COMMENT '修改人',
  `updated_time` DATETIME COMMENT '修改时间',
  INDEX `idx_role_code` (`role_code`),
  INDEX `idx_app_code` (`app_code`),
  INDEX `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT '角色表';

-- 角色菜单关联表
CREATE TABLE `role_menu` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键',
  `role_code` VARCHAR(64) NOT NULL COMMENT '角色编码',
  `menu_code` VARCHAR(64) NOT NULL COMMENT '菜单编码',
  `app_code` VARCHAR(64) NOT NULL COMMENT '应用编码',
  `created_person` VARCHAR(64) COMMENT '创建人',
  `created_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  UNIQUE KEY `uk_role_menu` (`role_code`, `menu_code`, `app_code`),
  INDEX `idx_role_code` (`role_code`),
  INDEX `idx_menu_code` (`menu_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT '角色菜单关联表';

-- =====================================================================
-- 3. 菜单相关表
-- =====================================================================

-- 菜单表
CREATE TABLE `menu` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键',
  `menu_code` VARCHAR(64) NOT NULL UNIQUE COMMENT '菜单编码（唯一）',
  `menu_name` VARCHAR(64) NOT NULL COMMENT '菜单名称',
  `menu_type` VARCHAR(10) NOT NULL COMMENT '菜单类型：MENU(菜单)/PAGE(页面)/BUTTON(按钮)',
  `platform_type` VARCHAR(100) COMMENT '平台类型：PC、MINI_APP、H5（可多选，逗号分隔）',
  `parent_code` VARCHAR(64) COMMENT '父级菜单编码',
  `app_code` VARCHAR(64) COMMENT '应用编码（根节点时与app_code一致，其他节点自动继承根节点的app_code）',
  `route_path` VARCHAR(128) COMMENT '功能路径/路由',
  `icon` VARCHAR(64) COMMENT '图标',
  `sort_order` INT DEFAULT 99 COMMENT '排序（越小越靠前）',
  `status` CHAR(10) NOT NULL DEFAULT 'ENABLED' COMMENT '菜单状态：ENABLED(启用)/DISABLED(停用)',
  `created_person` VARCHAR(64) COMMENT '创建人',
  `created_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_person` VARCHAR(64) COMMENT '修改人',
  `updated_time` DATETIME COMMENT '修改时间',
  INDEX `idx_menu_code` (`menu_code`),
  INDEX `idx_parent_code` (`parent_code`),
  INDEX `idx_app_code` (`app_code`),
  INDEX `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT '菜单表';

-- =====================================================================
-- 4. 应用相关表
-- =====================================================================

-- 应用表
CREATE TABLE `application` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键',
  `app_code` VARCHAR(64) NOT NULL UNIQUE COMMENT '应用编码（唯一）',
  `app_name` VARCHAR(64) NOT NULL COMMENT '应用名称',
  `app_desc` VARCHAR(500) COMMENT '应用描述',
  `enable_basic_fee` BOOLEAN DEFAULT FALSE COMMENT '是否启用基础算力计费',
  `status` CHAR(10) NOT NULL DEFAULT 'ENABLED' COMMENT '应用状态：ENABLED(启用)/DISABLED(停用)/DELETED(删除)',
  `created_person` VARCHAR(64) COMMENT '创建人',
  `created_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_person` VARCHAR(64) COMMENT '修改人',
  `updated_time` DATETIME COMMENT '最后更新时间',
  INDEX `idx_app_code` (`app_code`),
  INDEX `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT '应用表';

-- =====================================================================
-- 5. AI 大模型配置相关表
-- =====================================================================

-- AI 大模型价格配置表
CREATE TABLE `ai_model_config` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键',
  `platform_type` VARCHAR(64) NOT NULL COMMENT '平台类型（OpenAI、阿里、百度、讯飞等）',
  `model_code` VARCHAR(64) NOT NULL UNIQUE COMMENT '大模型英文名称（唯一）',
  `model_name` VARCHAR(64) NOT NULL COMMENT '大模型中文名称',
  `single_request_price` INT NOT NULL COMMENT '单次请求价格（算力值）',
  `created_person` VARCHAR(64) COMMENT '创建人',
  `created_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_person` VARCHAR(64) COMMENT '修改人',
  `updated_time` DATETIME COMMENT '修改时间',
  INDEX `idx_platform_type` (`platform_type`),
  INDEX `idx_model_code` (`model_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT 'AI大模型价格配置表';

-- =====================================================================
-- 6. 算力账户相关表
-- =====================================================================

-- 用户算力账户表
CREATE TABLE `ai_account` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键',
  `user_code` VARCHAR(64) NOT NULL COMMENT '用户编码',
  `app_code` VARCHAR(64) NOT NULL COMMENT '应用编码',
  `total_balance` BIGINT NOT NULL DEFAULT 0 COMMENT '总算力',
  `used_power` BIGINT NOT NULL DEFAULT 0 COMMENT '已用算力',
  `available_power` BIGINT NOT NULL DEFAULT 0 COMMENT '可用算力（total_balance - used_power）',
  `created_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_time` DATETIME COMMENT '修改时间',
  UNIQUE KEY `uk_user_app` (`user_code`, `app_code`),
  INDEX `idx_user_code` (`user_code`),
  INDEX `idx_app_code` (`app_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT '用户算力账户表';

-- 算力流水表
CREATE TABLE `ai_account_flow` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键',
  `user_code` VARCHAR(64) NOT NULL COMMENT '用户编码',
  `app_code` VARCHAR(64) NOT NULL COMMENT '应用编码',
  `power_amount` BIGINT NOT NULL COMMENT '算力值（始终为正值，根据flow_type判断是充值还是消耗；任何扣减操作如手工扣减错误充值也记为正值）',
  `flow_type` VARCHAR(50) NOT NULL COMMENT '操作类型：RECHARGE（充值）、CONSUME（消耗）、ADJUSTMENT（扣减）',
  `model_code` VARCHAR(64) COMMENT '请求的大模型编码',
  `platform_type` VARCHAR(64) COMMENT '平台类型',
  `flow_desc` VARCHAR(500) COMMENT '流水说明',
  `flow_status` CHAR(7) NOT NULL DEFAULT 'SUCCESS' COMMENT '流水状态：SUCCESS(成功)/FAILED(失败)',
  `account_record_id` BIGINT COMMENT '上账记录ID（关联AccountRecord表）',
  `order_no` VARCHAR(64) COMMENT '订单号（关联RechargeRecord表，上账时冗余）',
  `created_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  INDEX `idx_user_code` (`user_code`),
  INDEX `idx_app_code` (`app_code`),
  INDEX `idx_flow_type` (`flow_type`),
  INDEX `idx_order_no` (`order_no`),
  INDEX `idx_created_time` (`created_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT '算力流水表';

-- 月度大模型消耗统计表
CREATE TABLE `ai_consume_statistics` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键',
  `statistic_year_month` VARCHAR(7) NOT NULL COMMENT '统计年月（YYYY-MM格式）',
  `platform_type` VARCHAR(64) NOT NULL COMMENT '平台类型（如OpenAI、阿里、百度等）',
  `model_code` VARCHAR(64) NOT NULL COMMENT '大模型编码',
  `total_consume_power` BIGINT NOT NULL DEFAULT 0 COMMENT '月度消耗的总算力',
  `consume_count` INT NOT NULL DEFAULT 0 COMMENT '月度消耗次数',
  `consume_duration` BIGINT NOT NULL DEFAULT 0 COMMENT '月度消耗总时间（毫秒）',
  `created_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  UNIQUE KEY `uk_statistics` (`statistic_year_month`, `platform_type`, `model_code`),
  INDEX `idx_statistic_year_month` (`statistic_year_month`),
  INDEX `idx_platform_type` (`platform_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT '月度大模型消耗统计表';

-- =====================================================================
-- 7. 充值与上账相关表
-- =====================================================================

-- 充值订单记录表
CREATE TABLE `recharge_record` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键',
  `app_code` VARCHAR(64) NOT NULL COMMENT '应用编码（订单关联的应用，必需存在）',
  `user_code` VARCHAR(64) NOT NULL COMMENT '用户编码',
  `order_no` VARCHAR(64) NOT NULL UNIQUE COMMENT '订单号（唯一）',
  `amount` DECIMAL(10,2) NOT NULL COMMENT '充值金额（RMB）',
  `power` BIGINT NOT NULL COMMENT '充值算力值',
  `recharge_type` VARCHAR(10) NOT NULL DEFAULT 'MANUAL' COMMENT '充值类型：MANUAL(手动录入)/PAYMENT(支付充值)',
  `status` CHAR(10) NOT NULL DEFAULT 'SUCCESS' COMMENT '充值状态：PENDING(待处理)/SUCCESS(成功)/FAILED(失败)',
  `created_person` VARCHAR(64) COMMENT '充值人（管理员用户编码或业务用户编码）',
  `created_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '充值时间',
  UNIQUE KEY `uk_order_no` (`order_no`),
  INDEX `idx_user_code` (`user_code`),
  INDEX `idx_app_code` (`app_code`),
  INDEX `idx_status` (`status`),
  INDEX `idx_created_time` (`created_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT '充值订单记录表';

-- 算力上账记录表
CREATE TABLE `account_record` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键',
  `user_code` VARCHAR(64) NOT NULL COMMENT '用户编码',
  `order_no` VARCHAR(64) NOT NULL COMMENT '订单号（关联RechargeRecord表的订单号）',
  `power_amount` BIGINT NOT NULL COMMENT '上账算力值',
  `status` CHAR(10) NOT NULL DEFAULT 'SUCCESS' COMMENT '上账状态：SUCCESS(成功)/FAILED(失败)',
  `account_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '上账时间',
  `remark` VARCHAR(500) COMMENT '备注',
  INDEX `idx_user_code` (`user_code`),
  INDEX `idx_order_no` (`order_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT '算力上账记录表';

-- 支付符号表
CREATE TABLE `prepay_symbol` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键',
  `symbol` VARCHAR(128) NOT NULL UNIQUE COMMENT '支付符号（唯一）',
  `user_code` VARCHAR(64) NOT NULL COMMENT '用户编码',
  `app_code` VARCHAR(64) NOT NULL COMMENT '应用编码',
  `amount` DECIMAL(10,2) NOT NULL COMMENT '支付金额（RMB）',
  `status` VARCHAR(10) NOT NULL DEFAULT 'PENDING' COMMENT '符号状态：PENDING(待确认)/COMPLETED(已完成)/EXPIRED(已过期)',
  `created_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `expire_time` DATETIME NOT NULL COMMENT '过期时间',
  INDEX `idx_symbol` (`symbol`),
  INDEX `idx_user_code` (`user_code`),
  INDEX `idx_app_code` (`app_code`),
  INDEX `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT '支付符号表';

-- =====================================================================
-- 8. 预埋测试数据
-- =====================================================================

-- 插入测试应用
INSERT INTO `application` (`app_code`, `app_name`, `app_desc`, `enable_basic_fee`, `status`, `created_person`, `created_time`)
VALUES
  ('admin_system', '后台管理系统', '内部后台管理系统', FALSE, 'ENABLED', 'SYSTEM', NOW()),
  ('app_001', '业务应用01', '用户业务应用一', FALSE, 'ENABLED', 'SYSTEM', NOW()),
  ('app_002', '业务应用02', '用户业务应用二', TRUE, 'ENABLED', 'SYSTEM', NOW());

-- 插入测试用户
INSERT INTO `user` (`user_code`, `nickname`, `phone`, `password`, `status`, `created_person`, `created_time`)
VALUES
  ('admin_001', '管理员', '13800000001', '$2a$10$slYQmyNdGzin7olLwb2c7u.7h1fDO.FvYaPCb5qHrKNWvUhUcqCrm', 'ENABLED', 'SYSTEM', NOW()),
  ('user_001', '用户01', '13800000002', NULL, 'ENABLED', 'SYSTEM', NOW()),
  ('user_002', '用户02', '13800000003', NULL, 'ENABLED', 'SYSTEM', NOW());

-- 插入测试角色
INSERT INTO `role` (`role_code`, `role_name`, `role_desc`, `is_default_role`, `app_code`, `status`, `created_person`, `created_time`)
VALUES
  ('admin_role', '管理员角色', '后台管理系统管理员', 'N', 'admin_system', 'ENABLED', 'SYSTEM', NOW()),
  ('user_role', '普通用户', '普通用户角色', 'Y', 'app_001', 'ENABLED', 'SYSTEM', NOW()),
  ('power_user_role', '高级用户', '高级用户角色', 'N', NULL, 'ENABLED', 'SYSTEM', NOW());

-- 插入测试菜单
INSERT INTO `menu` (`menu_code`, `menu_name`, `menu_type`, `platform_type`, `parent_code`, `app_code`, `route_path`, `sort_order`, `status`, `created_person`, `created_time`)
VALUES
  ('admin_system', '系统管理', 'MENU', 'PC', NULL, 'admin_system', NULL, 1, 'ENABLED', 'SYSTEM', NOW()),
  ('user_manage', '用户管理', 'PAGE', 'PC', 'admin_system', 'admin_system', '/system/user/list', 10, 'ENABLED', 'SYSTEM', NOW()),
  ('role_manage', '角色管理', 'PAGE', 'PC', 'admin_system', 'admin_system', '/system/role/list', 20, 'ENABLED', 'SYSTEM', NOW()),
  ('menu_manage', '菜单管理', 'PAGE', 'PC', 'admin_system', 'admin_system', '/system/menu/list', 30, 'ENABLED', 'SYSTEM', NOW()),
  ('app_001', '业务应用', 'MENU', 'PC,H5', NULL, 'app_001', NULL, 1, 'ENABLED', 'SYSTEM', NOW()),
  ('app_dashboard', '仪表板', 'PAGE', 'PC,H5', 'app_001', 'app_001', '/app/dashboard', 10, 'ENABLED', 'SYSTEM', NOW());

-- 插入测试角色菜单关联
INSERT INTO `role_menu` (`role_code`, `menu_code`, `app_code`, `created_person`, `created_time`)
VALUES
  ('admin_role', 'user_manage', 'admin_system', 'SYSTEM', NOW()),
  ('admin_role', 'role_manage', 'admin_system', 'SYSTEM', NOW()),
  ('admin_role', 'menu_manage', 'admin_system', 'SYSTEM', NOW()),
  ('user_role', 'app_dashboard', 'app_001', 'SYSTEM', NOW());

-- 插入测试用户角色关联
INSERT INTO `user_role` (`user_code`, `role_code`, `created_person`, `created_time`)
VALUES
  ('admin_001', 'admin_role', 'SYSTEM', NOW()),
  ('user_001', 'user_role', 'SYSTEM', NOW()),
  ('user_002', 'user_role', 'SYSTEM', NOW());


-- 插入测试第三方登录绑定
INSERT INTO `third_party_login_binding` (`user_code`, `app_code`, `login_type`, `unionid`, `phone_number`, `nickname`, `avatar`, `status`, `bound_time`, `joined_time`, `last_login_time`, `created_person`, `created_time`)
VALUES
  ('user_001', 'app_001', 'WECHAT', 'wechat_unionid_001', '13800000002', '用户01', 'https://example.com/avatar1.jpg', 'ACTIVE', NOW(), NOW(), NOW(), 'SYSTEM', NOW()),
  ('user_002', 'app_001', 'MOBILE_CODE', NULL, '13800000003', '用户02', 'https://example.com/avatar2.jpg', 'ACTIVE', NOW(), NOW(), NOW(), 'SYSTEM', NOW());

-- 插入测试AI模型配置
INSERT INTO `ai_model_config` (`platform_type`, `model_code`, `model_name`, `single_request_price`, `created_person`, `created_time`)
VALUES
  ('OpenAI', 'gpt-4', 'GPT-4', 100, 'SYSTEM', NOW()),
  ('OpenAI', 'gpt-3.5-turbo', 'GPT-3.5 Turbo', 50, 'SYSTEM', NOW()),
  ('阿里', 'qwen-plus', '通义千问Plus', 80, 'SYSTEM', NOW()),
  ('百度', 'ernie-3.5', 'ERNIE 3.5', 70, 'SYSTEM', NOW());

-- =====================================================================
-- 备注
-- =====================================================================
-- 1. 所有表都禁止使用外键约束，关联关系由应用逻辑维护
-- 2. 字符编码统一使用 utf8mb4_unicode_ci，避免出现乱码问题
-- 3. 所有时间字段都使用 DATETIME 类型，默认值为 CURRENT_TIMESTAMP
-- 4. 所有关键字段都建立索引以提高查询性能
-- 5. 测试数据密码为：123456（已加密），请妥善保管
-- 6. 预埋数据的创建人都设为 SYSTEM，表示系统初始化创建
