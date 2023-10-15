/*
 Navicat Premium Data Transfer

 Source Server         : devzeros hosting school
 Source Server Type    : MySQL
 Source Server Version : 100519
 Source Host           : 212.1.209.1:3306
 Source Schema         : u848983783_school_templat

 Target Server Type    : MySQL
 Target Server Version : 100519
 File Encoding         : 65001

 Date: 31/08/2023 20:20:47
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for accounting
-- ----------------------------
DROP TABLE IF EXISTS `accounting`;
CREATE TABLE `accounting`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int UNSIGNED NULL DEFAULT NULL,
  `creator_id` int NULL DEFAULT NULL,
  `order_item_id` int UNSIGNED NULL DEFAULT NULL,
  `webinar_id` int UNSIGNED NULL DEFAULT NULL,
  `bundle_id` int UNSIGNED NULL DEFAULT NULL,
  `meeting_time_id` int UNSIGNED NULL DEFAULT NULL,
  `subscribe_id` int UNSIGNED NULL DEFAULT NULL,
  `promotion_id` int UNSIGNED NULL DEFAULT NULL,
  `registration_package_id` int UNSIGNED NULL DEFAULT NULL,
  `product_id` int UNSIGNED NULL DEFAULT NULL,
  `installment_payment_id` int UNSIGNED NULL DEFAULT NULL,
  `installment_order_id` int UNSIGNED NULL DEFAULT NULL COMMENT 'This field is filled in the seller\'s financial document to find the installment order',
  `gift_id` int UNSIGNED NULL DEFAULT NULL,
  `system` tinyint(1) NOT NULL DEFAULT 0,
  `tax` tinyint(1) NOT NULL DEFAULT 0,
  `amount` decimal(13, 2) NULL DEFAULT NULL,
  `type` enum('addiction','deduction') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type_account` enum('income','asset','subscribe','promotion','registration_package','installment_payment') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `store_type` enum('automatic','manual') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'automatic',
  `referred_user_id` int UNSIGNED NULL DEFAULT NULL,
  `is_affiliate_amount` tinyint(1) NOT NULL DEFAULT 0,
  `is_affiliate_commission` tinyint(1) NOT NULL DEFAULT 0,
  `is_registration_bonus` tinyint(1) NOT NULL DEFAULT 0,
  `is_cashback` tinyint(1) NOT NULL DEFAULT 0,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_at` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `webinar_id`(`webinar_id`) USING BTREE,
  INDEX `meeting_time_id`(`meeting_time_id`) USING BTREE,
  INDEX `subscribe_id`(`subscribe_id`) USING BTREE,
  INDEX `promotion_id`(`promotion_id`) USING BTREE,
  INDEX `accounting_installment_payment_id_foreign`(`installment_payment_id`) USING BTREE,
  CONSTRAINT `accounting_installment_payment_id_foreign` FOREIGN KEY (`installment_payment_id`) REFERENCES `installment_order_payments` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 825 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of accounting
-- ----------------------------

-- ----------------------------
-- Table structure for advertising_banners
-- ----------------------------
DROP TABLE IF EXISTS `advertising_banners`;
CREATE TABLE `advertising_banners`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `position` enum('home1','home2','course','course_sidebar','product_show','bundle','bundle_sidebar') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `size` int UNSIGNED NOT NULL DEFAULT 12,
  `link` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `published` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of advertising_banners
-- ----------------------------

-- ----------------------------
-- Table structure for advertising_banners_translations
-- ----------------------------
DROP TABLE IF EXISTS `advertising_banners_translations`;
CREATE TABLE `advertising_banners_translations`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `advertising_banner_id` int UNSIGNED NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `advertising_banners_translations_advertising_banner_id_foreign`(`advertising_banner_id`) USING BTREE,
  INDEX `advertising_banners_translations_locale_index`(`locale`) USING BTREE,
  CONSTRAINT `advertising_banners_translations_advertising_banner_id_foreign` FOREIGN KEY (`advertising_banner_id`) REFERENCES `advertising_banners` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of advertising_banners_translations
-- ----------------------------

-- ----------------------------
-- Table structure for affiliates
-- ----------------------------
DROP TABLE IF EXISTS `affiliates`;
CREATE TABLE `affiliates`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `affiliate_user_id` int UNSIGNED NOT NULL,
  `referred_user_id` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `affiliates_affiliate_user_id_foreign`(`affiliate_user_id`) USING BTREE,
  INDEX `affiliates_referred_user_id_foreign`(`referred_user_id`) USING BTREE,
  CONSTRAINT `affiliates_affiliate_user_id_foreign` FOREIGN KEY (`affiliate_user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `affiliates_referred_user_id_foreign` FOREIGN KEY (`referred_user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of affiliates
-- ----------------------------

-- ----------------------------
-- Table structure for affiliates_codes
-- ----------------------------
DROP TABLE IF EXISTS `affiliates_codes`;
CREATE TABLE `affiliates_codes`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int UNSIGNED NOT NULL,
  `code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `affiliates_codes_code_unique`(`code`) USING BTREE,
  INDEX `affiliates_codes_user_id_foreign`(`user_id`) USING BTREE,
  CONSTRAINT `affiliates_codes_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of affiliates_codes
-- ----------------------------

-- ----------------------------
-- Table structure for agora_history
-- ----------------------------
DROP TABLE IF EXISTS `agora_history`;
CREATE TABLE `agora_history`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `session_id` int UNSIGNED NOT NULL,
  `start_at` int UNSIGNED NOT NULL,
  `end_at` int UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `agora_history_session_id_foreign`(`session_id`) USING BTREE,
  CONSTRAINT `agora_history_session_id_foreign` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of agora_history
-- ----------------------------

-- ----------------------------
-- Table structure for attendance_translations
-- ----------------------------
DROP TABLE IF EXISTS `attendance_translations`;
CREATE TABLE `attendance_translations`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `attendance_id` int UNSIGNED NOT NULL,
  `student_id` int UNSIGNED NOT NULL,
  `status` enum('present','absent') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `confirmed_assistance` int NULL DEFAULT NULL,
  `created_at` int NOT NULL,
  `updated_at` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `attendance_translations_attendance_id_foreign`(`attendance_id`) USING BTREE,
  INDEX `attendance_translations_student_id_foreign`(`student_id`) USING BTREE,
  CONSTRAINT `attendance_translations_attendance_id_foreign` FOREIGN KEY (`attendance_id`) REFERENCES `attendances` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `attendance_translations_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of attendance_translations
-- ----------------------------

-- ----------------------------
-- Table structure for attendances
-- ----------------------------
DROP TABLE IF EXISTS `attendances`;
CREATE TABLE `attendances`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `teacher_id` int UNSIGNED NOT NULL,
  `text_lesson_id` int UNSIGNED NOT NULL,
  `date` int NOT NULL,
  `created_at` int NOT NULL,
  `updated_at` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `attendances_teacher_id_foreign`(`teacher_id`) USING BTREE,
  INDEX `attendances_text_lesson_id_foreign`(`text_lesson_id`) USING BTREE,
  CONSTRAINT `attendances_teacher_id_foreign` FOREIGN KEY (`teacher_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `attendances_text_lesson_id_foreign` FOREIGN KEY (`text_lesson_id`) REFERENCES `text_lessons` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of attendances
-- ----------------------------

-- ----------------------------
-- Table structure for badge_translations
-- ----------------------------
DROP TABLE IF EXISTS `badge_translations`;
CREATE TABLE `badge_translations`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `badge_id` int UNSIGNED NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `badge_translations_badge_id_foreign`(`badge_id`) USING BTREE,
  INDEX `badge_translations_locale_index`(`locale`) USING BTREE,
  CONSTRAINT `badge_translations_badge_id_foreign` FOREIGN KEY (`badge_id`) REFERENCES `badges` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of badge_translations
-- ----------------------------

-- ----------------------------
-- Table structure for badges
-- ----------------------------
DROP TABLE IF EXISTS `badges`;
CREATE TABLE `badges`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` enum('register_date','course_count','course_rate','sale_count','support_rate','product_sale_count','make_topic','send_post_in_topic','instructor_blog') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `condition` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `score` int NULL DEFAULT NULL,
  `created_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `badges_type_index`(`type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 42 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of badges
-- ----------------------------

-- ----------------------------
-- Table structure for become_instructors
-- ----------------------------
DROP TABLE IF EXISTS `become_instructors`;
CREATE TABLE `become_instructors`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int UNSIGNED NOT NULL,
  `role` enum('teacher','organization') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `package_id` int UNSIGNED NULL DEFAULT NULL,
  `certificate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `status` enum('pending','accept','reject') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `created_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `become_instructors_user_id_foreign`(`user_id`) USING BTREE,
  CONSTRAINT `become_instructors_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of become_instructors
-- ----------------------------

-- ----------------------------
-- Table structure for blog
-- ----------------------------
DROP TABLE IF EXISTS `blog`;
CREATE TABLE `blog`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `category_id` int UNSIGNED NULL DEFAULT NULL,
  `author_id` int UNSIGNED NOT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `visit_count` int UNSIGNED NULL DEFAULT 0,
  `enable_comment` tinyint(1) NOT NULL DEFAULT 1,
  `status` enum('pending','publish') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `created_at` int UNSIGNED NOT NULL,
  `updated_at` int UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `blog_category_id_foreign`(`category_id`) USING BTREE,
  INDEX `slug`(`slug`) USING BTREE,
  CONSTRAINT `blog_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `blog_categories` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of blog
-- ----------------------------

-- ----------------------------
-- Table structure for blog_categories
-- ----------------------------
DROP TABLE IF EXISTS `blog_categories`;
CREATE TABLE `blog_categories`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 39 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of blog_categories
-- ----------------------------

-- ----------------------------
-- Table structure for blog_translations
-- ----------------------------
DROP TABLE IF EXISTS `blog_translations`;
CREATE TABLE `blog_translations`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `blog_id` int UNSIGNED NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `meta_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `blog_translations_blog_id_locale_unique`(`blog_id`, `locale`) USING BTREE,
  INDEX `blog_translations_locale_index`(`locale`) USING BTREE,
  CONSTRAINT `blog_translations_blog_id_foreign` FOREIGN KEY (`blog_id`) REFERENCES `blog` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 30 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of blog_translations
-- ----------------------------

-- ----------------------------
-- Table structure for bundle_filter_option
-- ----------------------------
DROP TABLE IF EXISTS `bundle_filter_option`;
CREATE TABLE `bundle_filter_option`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `bundle_id` int UNSIGNED NOT NULL,
  `filter_option_id` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `bundle_filter_option_bundle_id_foreign`(`bundle_id`) USING BTREE,
  INDEX `bundle_filter_option_filter_option_id_foreign`(`filter_option_id`) USING BTREE,
  CONSTRAINT `bundle_filter_option_bundle_id_foreign` FOREIGN KEY (`bundle_id`) REFERENCES `bundles` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `bundle_filter_option_filter_option_id_foreign` FOREIGN KEY (`filter_option_id`) REFERENCES `filter_options` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 52 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bundle_filter_option
-- ----------------------------

-- ----------------------------
-- Table structure for bundle_translations
-- ----------------------------
DROP TABLE IF EXISTS `bundle_translations`;
CREATE TABLE `bundle_translations`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `bundle_id` int UNSIGNED NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `seo_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `bundle_translations_bundle_id_foreign`(`bundle_id`) USING BTREE,
  INDEX `bundle_translations_locale_index`(`locale`) USING BTREE,
  CONSTRAINT `bundle_translations_bundle_id_foreign` FOREIGN KEY (`bundle_id`) REFERENCES `bundles` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bundle_translations
-- ----------------------------

-- ----------------------------
-- Table structure for bundle_webinars
-- ----------------------------
DROP TABLE IF EXISTS `bundle_webinars`;
CREATE TABLE `bundle_webinars`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `creator_id` int UNSIGNED NOT NULL,
  `bundle_id` int UNSIGNED NOT NULL,
  `webinar_id` int UNSIGNED NOT NULL,
  `order` int UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `bundle_webinars_bundle_id_foreign`(`bundle_id`) USING BTREE,
  INDEX `bundle_webinars_webinar_id_foreign`(`webinar_id`) USING BTREE,
  CONSTRAINT `bundle_webinars_bundle_id_foreign` FOREIGN KEY (`bundle_id`) REFERENCES `bundles` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `bundle_webinars_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bundle_webinars
-- ----------------------------

-- ----------------------------
-- Table structure for bundles
-- ----------------------------
DROP TABLE IF EXISTS `bundles`;
CREATE TABLE `bundles`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `creator_id` int UNSIGNED NOT NULL,
  `teacher_id` int UNSIGNED NOT NULL,
  `category_id` int UNSIGNED NULL DEFAULT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `thumbnail` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `image_cover` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `video_demo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `video_demo_source` enum('upload','youtube','vimeo','external_link') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `price` int NULL DEFAULT NULL,
  `points` int NULL DEFAULT NULL,
  `subscribe` tinyint(1) NOT NULL DEFAULT 0,
  `access_days` int UNSIGNED NULL DEFAULT NULL COMMENT 'Number of days to access the bundle',
  `message_for_reviewer` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `status` enum('active','pending','is_draft','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` bigint UNSIGNED NOT NULL,
  `updated_at` bigint UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `bundles_creator_id_foreign`(`creator_id`) USING BTREE,
  INDEX `bundles_teacher_id_foreign`(`teacher_id`) USING BTREE,
  INDEX `bundles_category_id_foreign`(`category_id`) USING BTREE,
  INDEX `bundles_slug_index`(`slug`) USING BTREE,
  CONSTRAINT `bundles_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `bundles_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `bundles_teacher_id_foreign` FOREIGN KEY (`teacher_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bundles
-- ----------------------------

-- ----------------------------
-- Table structure for cart
-- ----------------------------
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `creator_id` int UNSIGNED NOT NULL,
  `webinar_id` int UNSIGNED NULL DEFAULT NULL,
  `bundle_id` int UNSIGNED NULL DEFAULT NULL,
  `product_order_id` int UNSIGNED NULL DEFAULT NULL,
  `reserve_meeting_id` int UNSIGNED NULL DEFAULT NULL,
  `subscribe_id` int UNSIGNED NULL DEFAULT NULL,
  `promotion_id` int UNSIGNED NULL DEFAULT NULL,
  `gift_id` int UNSIGNED NULL DEFAULT NULL,
  `ticket_id` int UNSIGNED NULL DEFAULT NULL,
  `special_offer_id` int UNSIGNED NULL DEFAULT NULL,
  `product_discount_id` int UNSIGNED NULL DEFAULT NULL,
  `installment_payment_id` int UNSIGNED NULL DEFAULT NULL,
  `created_at` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `cart_creator_id_foreign`(`creator_id`) USING BTREE,
  INDEX `cart_webinar_id_foreign`(`webinar_id`) USING BTREE,
  INDEX `cart_ticket_id_foreign`(`ticket_id`) USING BTREE,
  INDEX `cart_reserve_meeting_id_foreign`(`reserve_meeting_id`) USING BTREE,
  INDEX `cart_subscribe_id_foreign`(`subscribe_id`) USING BTREE,
  INDEX `cart_promotion_id_foreign`(`promotion_id`) USING BTREE,
  INDEX `cart_special_offer_id_foreign`(`special_offer_id`) USING BTREE,
  INDEX `cart_product_order_id_foreign`(`product_order_id`) USING BTREE,
  INDEX `cart_product_discount_id_foreign`(`product_discount_id`) USING BTREE,
  INDEX `cart_bundle_id_foreign`(`bundle_id`) USING BTREE,
  INDEX `cart_installment_payment_id_foreign`(`installment_payment_id`) USING BTREE,
  INDEX `cart_gift_id_foreign`(`gift_id`) USING BTREE,
  CONSTRAINT `cart_bundle_id_foreign` FOREIGN KEY (`bundle_id`) REFERENCES `bundles` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `cart_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `cart_gift_id_foreign` FOREIGN KEY (`gift_id`) REFERENCES `gifts` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `cart_installment_payment_id_foreign` FOREIGN KEY (`installment_payment_id`) REFERENCES `installment_order_payments` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `cart_product_discount_id_foreign` FOREIGN KEY (`product_discount_id`) REFERENCES `product_discounts` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `cart_product_order_id_foreign` FOREIGN KEY (`product_order_id`) REFERENCES `product_orders` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `cart_promotion_id_foreign` FOREIGN KEY (`promotion_id`) REFERENCES `promotions` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `cart_reserve_meeting_id_foreign` FOREIGN KEY (`reserve_meeting_id`) REFERENCES `reserve_meetings` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `cart_special_offer_id_foreign` FOREIGN KEY (`special_offer_id`) REFERENCES `special_offers` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `cart_subscribe_id_foreign` FOREIGN KEY (`subscribe_id`) REFERENCES `subscribes` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `cart_ticket_id_foreign` FOREIGN KEY (`ticket_id`) REFERENCES `tickets` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `cart_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 211 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cart
-- ----------------------------

-- ----------------------------
-- Table structure for cashback_rule_specification_items
-- ----------------------------
DROP TABLE IF EXISTS `cashback_rule_specification_items`;
CREATE TABLE `cashback_rule_specification_items`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `cashback_rule_id` int UNSIGNED NOT NULL,
  `category_id` int UNSIGNED NULL DEFAULT NULL,
  `instructor_id` int UNSIGNED NULL DEFAULT NULL,
  `seller_id` int UNSIGNED NULL DEFAULT NULL,
  `webinar_id` int UNSIGNED NULL DEFAULT NULL,
  `product_id` int UNSIGNED NULL DEFAULT NULL,
  `bundle_id` int UNSIGNED NULL DEFAULT NULL,
  `subscribe_id` int UNSIGNED NULL DEFAULT NULL,
  `registration_package_id` int UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `cashback_rule_specification_items_cashback_rule_id_foreign`(`cashback_rule_id`) USING BTREE,
  INDEX `cashback_rule_specification_items_category_id_foreign`(`category_id`) USING BTREE,
  INDEX `cashback_rule_specification_items_instructor_id_foreign`(`instructor_id`) USING BTREE,
  INDEX `cashback_rule_specification_items_seller_id_foreign`(`seller_id`) USING BTREE,
  INDEX `cashback_rule_specification_items_webinar_id_foreign`(`webinar_id`) USING BTREE,
  INDEX `cashback_rule_specification_items_product_id_foreign`(`product_id`) USING BTREE,
  INDEX `cashback_rule_specification_items_bundle_id_foreign`(`bundle_id`) USING BTREE,
  INDEX `cashback_rule_specification_items_subscribe_id_foreign`(`subscribe_id`) USING BTREE,
  INDEX `rules_registration_package_id`(`registration_package_id`) USING BTREE,
  CONSTRAINT `cashback_rule_specification_items_bundle_id_foreign` FOREIGN KEY (`bundle_id`) REFERENCES `bundles` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `cashback_rule_specification_items_cashback_rule_id_foreign` FOREIGN KEY (`cashback_rule_id`) REFERENCES `cashback_rules` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `cashback_rule_specification_items_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `cashback_rule_specification_items_instructor_id_foreign` FOREIGN KEY (`instructor_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `cashback_rule_specification_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `cashback_rule_specification_items_seller_id_foreign` FOREIGN KEY (`seller_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `cashback_rule_specification_items_subscribe_id_foreign` FOREIGN KEY (`subscribe_id`) REFERENCES `subscribes` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `cashback_rule_specification_items_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `rules_registration_package_id` FOREIGN KEY (`registration_package_id`) REFERENCES `registration_packages` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cashback_rule_specification_items
-- ----------------------------

-- ----------------------------
-- Table structure for cashback_rule_translations
-- ----------------------------
DROP TABLE IF EXISTS `cashback_rule_translations`;
CREATE TABLE `cashback_rule_translations`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `cashback_rule_id` int UNSIGNED NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `cashback_rule_translations_cashback_rule_id_foreign`(`cashback_rule_id`) USING BTREE,
  INDEX `cashback_rule_translations_locale_index`(`locale`) USING BTREE,
  CONSTRAINT `cashback_rule_translations_cashback_rule_id_foreign` FOREIGN KEY (`cashback_rule_id`) REFERENCES `cashback_rules` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cashback_rule_translations
-- ----------------------------
INSERT INTO `cashback_rule_translations` VALUES (5, 5, 'en', 'Christmas Cashback');

-- ----------------------------
-- Table structure for cashback_rule_users_groups
-- ----------------------------
DROP TABLE IF EXISTS `cashback_rule_users_groups`;
CREATE TABLE `cashback_rule_users_groups`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `cashback_rule_id` int UNSIGNED NOT NULL,
  `group_id` int UNSIGNED NULL DEFAULT NULL,
  `user_id` int UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `cashback_rule_users_groups_cashback_rule_id_foreign`(`cashback_rule_id`) USING BTREE,
  INDEX `cashback_rule_users_groups_group_id_foreign`(`group_id`) USING BTREE,
  INDEX `cashback_rule_users_groups_user_id_foreign`(`user_id`) USING BTREE,
  CONSTRAINT `cashback_rule_users_groups_cashback_rule_id_foreign` FOREIGN KEY (`cashback_rule_id`) REFERENCES `cashback_rules` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `cashback_rule_users_groups_group_id_foreign` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `cashback_rule_users_groups_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 32 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cashback_rule_users_groups
-- ----------------------------

-- ----------------------------
-- Table structure for cashback_rules
-- ----------------------------
DROP TABLE IF EXISTS `cashback_rules`;
CREATE TABLE `cashback_rules`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `target_type` enum('all','courses','store_products','bundles','meetings','registration_packages','subscription_packages','recharge_wallet') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `target` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `start_date` bigint UNSIGNED NULL DEFAULT NULL,
  `end_date` bigint UNSIGNED NULL DEFAULT NULL,
  `amount` double(15, 2) NULL DEFAULT NULL,
  `amount_type` enum('fixed_amount','percent') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `apply_cashback_per_item` tinyint(1) NOT NULL DEFAULT 0,
  `max_amount` double(15, 2) NULL DEFAULT NULL,
  `min_amount` double(15, 2) NULL DEFAULT NULL,
  `enable` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cashback_rules
-- ----------------------------
INSERT INTO `cashback_rules` VALUES (5, 'all', NULL, 1672610400, NULL, 10.00, 'percent', 0, NULL, NULL, 0, 1678921892);

-- ----------------------------
-- Table structure for categories
-- ----------------------------
DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent_id` int NULL DEFAULT NULL,
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `order` int UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `parent_id`(`parent_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 617 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of categories
-- ----------------------------
INSERT INTO `categories` VALUES (614, 'DesarrolloDeSoftware', NULL, '/store/1/default_images/categories_icons/code.png', 1);
INSERT INTO `categories` VALUES (615, 'Diseo', NULL, '/store/1/favicon.png', 2);
INSERT INTO `categories` VALUES (616, 'Desarrollo-Web', NULL, '/store/1/DevZero-01-01.png', 3);

-- ----------------------------
-- Table structure for category_translations
-- ----------------------------
DROP TABLE IF EXISTS `category_translations`;
CREATE TABLE `category_translations`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `category_id` int UNSIGNED NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `category_translations_category_id_foreign`(`category_id`) USING BTREE,
  INDEX `category_translations_locale_index`(`locale`) USING BTREE,
  CONSTRAINT `category_translations_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of category_translations
-- ----------------------------
INSERT INTO `category_translations` VALUES (3, 614, 'es', 'Desarrollo De Software');
INSERT INTO `category_translations` VALUES (4, 615, 'es', 'Diseño');
INSERT INTO `category_translations` VALUES (5, 616, 'es', 'Desarrollo Web');

-- ----------------------------
-- Table structure for certificate_template_translations
-- ----------------------------
DROP TABLE IF EXISTS `certificate_template_translations`;
CREATE TABLE `certificate_template_translations`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `certificate_template_id` int UNSIGNED NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `body` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `rtl` tinyint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `certificate_template_id`(`certificate_template_id`) USING BTREE,
  INDEX `certificate_template_translations_locale_index`(`locale`) USING BTREE,
  CONSTRAINT `certificate_template_id` FOREIGN KEY (`certificate_template_id`) REFERENCES `certificates_templates` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of certificate_template_translations
-- ----------------------------

-- ----------------------------
-- Table structure for certificates
-- ----------------------------
DROP TABLE IF EXISTS `certificates`;
CREATE TABLE `certificates`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `quiz_id` int UNSIGNED NULL DEFAULT NULL,
  `quiz_result_id` int UNSIGNED NULL DEFAULT NULL,
  `student_id` int UNSIGNED NOT NULL,
  `webinar_id` int UNSIGNED NULL DEFAULT NULL,
  `user_grade` int UNSIGNED NULL DEFAULT NULL,
  `type` enum('quiz','course') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `certificates_quiz_id_foreign`(`quiz_id`) USING BTREE,
  INDEX `certificates_quiz_result_id_foreign`(`quiz_result_id`) USING BTREE,
  INDEX `certificates_student_id_foreign`(`student_id`) USING BTREE,
  INDEX `certificates_webinar_id_foreign`(`webinar_id`) USING BTREE,
  CONSTRAINT `certificates_quiz_id_foreign` FOREIGN KEY (`quiz_id`) REFERENCES `quizzes` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `certificates_quiz_result_id_foreign` FOREIGN KEY (`quiz_result_id`) REFERENCES `quizzes_results` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `certificates_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `certificates_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of certificates
-- ----------------------------

-- ----------------------------
-- Table structure for certificates_templates
-- ----------------------------
DROP TABLE IF EXISTS `certificates_templates`;
CREATE TABLE `certificates_templates`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` enum('quiz','course') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `position_x` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `position_y` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `font_size` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `text_color` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `status` enum('draft','publish') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` int NOT NULL,
  `updated_at` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of certificates_templates
-- ----------------------------

-- ----------------------------
-- Table structure for comments
-- ----------------------------
DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int UNSIGNED NOT NULL,
  `review_id` int UNSIGNED NULL DEFAULT NULL,
  `webinar_id` int UNSIGNED NULL DEFAULT NULL,
  `bundle_id` int UNSIGNED NULL DEFAULT NULL,
  `upcoming_course_id` int UNSIGNED NULL DEFAULT NULL,
  `blog_id` int UNSIGNED NULL DEFAULT NULL,
  `product_id` int UNSIGNED NULL DEFAULT NULL,
  `product_review_id` int UNSIGNED NULL DEFAULT NULL,
  `reply_id` int UNSIGNED NULL DEFAULT NULL,
  `comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `status` enum('pending','active') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `report` tinyint(1) NOT NULL DEFAULT 0,
  `disabled` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` int NOT NULL,
  `viewed_at` int UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `comments_webinar_id_foreign`(`webinar_id`) USING BTREE,
  INDEX `comments_user_id_foreign`(`user_id`) USING BTREE,
  INDEX `comments_review_id_foreign`(`review_id`) USING BTREE,
  INDEX `comments_reply_id_foreign`(`reply_id`) USING BTREE,
  INDEX `comments_product_id_foreign`(`product_id`) USING BTREE,
  INDEX `comments_bundle_id_foreign`(`bundle_id`) USING BTREE,
  INDEX `blog_id`(`blog_id`) USING BTREE,
  INDEX `comments_upcoming_course_id_foreign`(`upcoming_course_id`) USING BTREE,
  CONSTRAINT `comments_bundle_id_foreign` FOREIGN KEY (`bundle_id`) REFERENCES `bundles` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`blog_id`) REFERENCES `blog` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `comments_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `comments_reply_id_foreign` FOREIGN KEY (`reply_id`) REFERENCES `comments` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `comments_review_id_foreign` FOREIGN KEY (`review_id`) REFERENCES `webinar_reviews` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `comments_upcoming_course_id_foreign` FOREIGN KEY (`upcoming_course_id`) REFERENCES `upcoming_courses` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `comments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `comments_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 67 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of comments
-- ----------------------------

-- ----------------------------
-- Table structure for comments_reports
-- ----------------------------
DROP TABLE IF EXISTS `comments_reports`;
CREATE TABLE `comments_reports`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int UNSIGNED NOT NULL,
  `blog_id` int UNSIGNED NULL DEFAULT NULL,
  `product_id` int UNSIGNED NULL DEFAULT NULL,
  `webinar_id` int UNSIGNED NULL DEFAULT NULL,
  `bundle_id` int UNSIGNED NULL DEFAULT NULL,
  `comment_id` int UNSIGNED NOT NULL,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `comments_reports_comment_id_foreign`(`comment_id`) USING BTREE,
  INDEX `comments_reports_product_id_foreign`(`product_id`) USING BTREE,
  CONSTRAINT `comments_reports_comment_id_foreign` FOREIGN KEY (`comment_id`) REFERENCES `comments` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `comments_reports_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of comments_reports
-- ----------------------------

-- ----------------------------
-- Table structure for contacts
-- ----------------------------
DROP TABLE IF EXISTS `contacts`;
CREATE TABLE `contacts`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `subject` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `reply` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `status` enum('pending','replied') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `created_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of contacts
-- ----------------------------

-- ----------------------------
-- Table structure for course_forum_answers
-- ----------------------------
DROP TABLE IF EXISTS `course_forum_answers`;
CREATE TABLE `course_forum_answers`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `forum_id` int UNSIGNED NOT NULL,
  `user_id` int UNSIGNED NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `pin` tinyint(1) NOT NULL DEFAULT 0,
  `resolved` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `course_forum_answers_user_id_foreign`(`user_id`) USING BTREE,
  INDEX `course_forum_answers_forum_id_foreign`(`forum_id`) USING BTREE,
  CONSTRAINT `course_forum_answers_forum_id_foreign` FOREIGN KEY (`forum_id`) REFERENCES `course_forums` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `course_forum_answers_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of course_forum_answers
-- ----------------------------

-- ----------------------------
-- Table structure for course_forums
-- ----------------------------
DROP TABLE IF EXISTS `course_forums`;
CREATE TABLE `course_forums`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `webinar_id` int UNSIGNED NOT NULL,
  `user_id` int UNSIGNED NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `attach` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `pin` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `course_forums_webinar_id_foreign`(`webinar_id`) USING BTREE,
  INDEX `course_forums_user_id_foreign`(`user_id`) USING BTREE,
  CONSTRAINT `course_forums_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `course_forums_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of course_forums
-- ----------------------------

-- ----------------------------
-- Table structure for course_learning
-- ----------------------------
DROP TABLE IF EXISTS `course_learning`;
CREATE TABLE `course_learning`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int UNSIGNED NOT NULL,
  `text_lesson_id` int UNSIGNED NULL DEFAULT NULL,
  `file_id` int UNSIGNED NULL DEFAULT NULL,
  `session_id` int UNSIGNED NULL DEFAULT NULL,
  `created_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `course_learning_user_id_foreign`(`user_id`) USING BTREE,
  INDEX `course_learning_text_lesson_id_foreign`(`text_lesson_id`) USING BTREE,
  INDEX `course_learning_file_id_foreign`(`file_id`) USING BTREE,
  INDEX `course_learning_session_id_foreign`(`session_id`) USING BTREE,
  CONSTRAINT `course_learning_file_id_foreign` FOREIGN KEY (`file_id`) REFERENCES `files` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `course_learning_session_id_foreign` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `course_learning_text_lesson_id_foreign` FOREIGN KEY (`text_lesson_id`) REFERENCES `text_lessons` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `course_learning_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 80 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of course_learning
-- ----------------------------
INSERT INTO `course_learning` VALUES (78, 1016, 37, NULL, NULL, 1681489115);

-- ----------------------------
-- Table structure for course_noticeboard_status
-- ----------------------------
DROP TABLE IF EXISTS `course_noticeboard_status`;
CREATE TABLE `course_noticeboard_status`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int UNSIGNED NOT NULL,
  `noticeboard_id` int UNSIGNED NOT NULL,
  `seen_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `course_noticeboard_status_noticeboard_id_foreign`(`noticeboard_id`) USING BTREE,
  CONSTRAINT `course_noticeboard_status_noticeboard_id_foreign` FOREIGN KEY (`noticeboard_id`) REFERENCES `course_noticeboards` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 51 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of course_noticeboard_status
-- ----------------------------

-- ----------------------------
-- Table structure for course_noticeboards
-- ----------------------------
DROP TABLE IF EXISTS `course_noticeboards`;
CREATE TABLE `course_noticeboards`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `creator_id` int UNSIGNED NOT NULL,
  `webinar_id` int UNSIGNED NOT NULL,
  `color` enum('warning','danger','neutral','info','success') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `course_noticeboards_creator_id_foreign`(`creator_id`) USING BTREE,
  INDEX `course_noticeboards_webinar_id_foreign`(`webinar_id`) USING BTREE,
  CONSTRAINT `course_noticeboards_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `course_noticeboards_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of course_noticeboards
-- ----------------------------

-- ----------------------------
-- Table structure for courses
-- ----------------------------
DROP TABLE IF EXISTS `courses`;
CREATE TABLE `courses`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `state` int NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of courses
-- ----------------------------

-- ----------------------------
-- Table structure for currencies
-- ----------------------------
DROP TABLE IF EXISTS `currencies`;
CREATE TABLE `currencies`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `currency` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `currency_position` enum('left','right','left_with_space','right_with_space') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `currency_separator` enum('dot','comma') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `currency_decimal` int UNSIGNED NULL DEFAULT NULL,
  `exchange_rate` double(15, 2) NULL DEFAULT NULL,
  `order` int UNSIGNED NULL DEFAULT NULL,
  `created_at` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of currencies
-- ----------------------------
INSERT INTO `currencies` VALUES (4, 'EUR', 'left', 'dot', 2, 0.93, 1, 1678868603);
INSERT INTO `currencies` VALUES (6, 'INR', 'left', 'dot', 2, 82.52, 2, 1678869222);

-- ----------------------------
-- Table structure for delete_account_requests
-- ----------------------------
DROP TABLE IF EXISTS `delete_account_requests`;
CREATE TABLE `delete_account_requests`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int UNSIGNED NOT NULL,
  `created_at` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `delete_account_requests_user_id_foreign`(`user_id`) USING BTREE,
  CONSTRAINT `delete_account_requests_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of delete_account_requests
-- ----------------------------

-- ----------------------------
-- Table structure for discount_bundles
-- ----------------------------
DROP TABLE IF EXISTS `discount_bundles`;
CREATE TABLE `discount_bundles`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `discount_id` int UNSIGNED NOT NULL,
  `bundle_id` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `discount_bundles_discount_id_foreign`(`discount_id`) USING BTREE,
  INDEX `discount_bundles_bundle_id_foreign`(`bundle_id`) USING BTREE,
  CONSTRAINT `discount_bundles_bundle_id_foreign` FOREIGN KEY (`bundle_id`) REFERENCES `bundles` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `discount_bundles_discount_id_foreign` FOREIGN KEY (`discount_id`) REFERENCES `discounts` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of discount_bundles
-- ----------------------------

-- ----------------------------
-- Table structure for discount_categories
-- ----------------------------
DROP TABLE IF EXISTS `discount_categories`;
CREATE TABLE `discount_categories`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `discount_id` int UNSIGNED NOT NULL,
  `category_id` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `discount_categories_discount_id_foreign`(`discount_id`) USING BTREE,
  INDEX `discount_categories_category_id_foreign`(`category_id`) USING BTREE,
  CONSTRAINT `discount_categories_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `discount_categories_discount_id_foreign` FOREIGN KEY (`discount_id`) REFERENCES `discounts` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of discount_categories
-- ----------------------------

-- ----------------------------
-- Table structure for discount_courses
-- ----------------------------
DROP TABLE IF EXISTS `discount_courses`;
CREATE TABLE `discount_courses`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `discount_id` int UNSIGNED NOT NULL,
  `course_id` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `discount_courses_discount_id_foreign`(`discount_id`) USING BTREE,
  INDEX `discount_courses_course_id_foreign`(`course_id`) USING BTREE,
  CONSTRAINT `discount_courses_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `discount_courses_discount_id_foreign` FOREIGN KEY (`discount_id`) REFERENCES `discounts` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of discount_courses
-- ----------------------------

-- ----------------------------
-- Table structure for discount_groups
-- ----------------------------
DROP TABLE IF EXISTS `discount_groups`;
CREATE TABLE `discount_groups`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `discount_id` int UNSIGNED NOT NULL,
  `group_id` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `discount_groups_discount_id_foreign`(`discount_id`) USING BTREE,
  INDEX `discount_groups_group_id_foreign`(`group_id`) USING BTREE,
  CONSTRAINT `discount_groups_discount_id_foreign` FOREIGN KEY (`discount_id`) REFERENCES `discounts` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `discount_groups_group_id_foreign` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of discount_groups
-- ----------------------------

-- ----------------------------
-- Table structure for discount_users
-- ----------------------------
DROP TABLE IF EXISTS `discount_users`;
CREATE TABLE `discount_users`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `discount_id` int UNSIGNED NOT NULL,
  `user_id` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `discount_users_discount_id_foreign`(`discount_id`) USING BTREE,
  INDEX `discount_users_user_id_foreign`(`user_id`) USING BTREE,
  CONSTRAINT `discount_users_discount_id_foreign` FOREIGN KEY (`discount_id`) REFERENCES `discounts` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `discount_users_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of discount_users
-- ----------------------------

-- ----------------------------
-- Table structure for discounts
-- ----------------------------
DROP TABLE IF EXISTS `discounts`;
CREATE TABLE `discounts`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `creator_id` int UNSIGNED NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `discount_type` enum('percentage','fixed_amount') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `source` enum('all','course','category','meeting','product','bundle') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `percent` int UNSIGNED NULL DEFAULT NULL,
  `amount` int UNSIGNED NULL DEFAULT NULL,
  `max_amount` int UNSIGNED NULL DEFAULT NULL,
  `minimum_order` int UNSIGNED NULL DEFAULT NULL,
  `count` int NOT NULL DEFAULT 1,
  `user_type` enum('all_users','special_users') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_type` enum('all','physical','virtual') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `for_first_purchase` tinyint(1) NOT NULL DEFAULT 0,
  `status` enum('active','disable') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `expired_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `discounts_code_unique`(`code`) USING BTREE,
  INDEX `discounts_creator_id_foreign`(`creator_id`) USING BTREE,
  CONSTRAINT `discounts_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of discounts
-- ----------------------------

-- ----------------------------
-- Table structure for faq_translations
-- ----------------------------
DROP TABLE IF EXISTS `faq_translations`;
CREATE TABLE `faq_translations`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `faq_id` int UNSIGNED NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `answer` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `faq_translations_faq_id_foreign`(`faq_id`) USING BTREE,
  INDEX `faq_translations_locale_index`(`locale`) USING BTREE,
  CONSTRAINT `faq_translations_faq_id_foreign` FOREIGN KEY (`faq_id`) REFERENCES `faqs` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 46 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of faq_translations
-- ----------------------------

-- ----------------------------
-- Table structure for faqs
-- ----------------------------
DROP TABLE IF EXISTS `faqs`;
CREATE TABLE `faqs`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `creator_id` int UNSIGNED NOT NULL,
  `webinar_id` int UNSIGNED NULL DEFAULT NULL,
  `bundle_id` int UNSIGNED NULL DEFAULT NULL,
  `upcoming_course_id` int UNSIGNED NULL DEFAULT NULL,
  `order` int UNSIGNED NULL DEFAULT NULL,
  `created_at` int UNSIGNED NULL DEFAULT NULL,
  `updated_at` int UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `faqs_webinar_id_foreign`(`webinar_id`) USING BTREE,
  INDEX `faqs_creator_id_foreign`(`creator_id`) USING BTREE,
  INDEX `faqs_bundle_id_foreign`(`bundle_id`) USING BTREE,
  INDEX `faqs_upcoming_course_id_foreign`(`upcoming_course_id`) USING BTREE,
  CONSTRAINT `faqs_bundle_id_foreign` FOREIGN KEY (`bundle_id`) REFERENCES `bundles` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `faqs_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `faqs_upcoming_course_id_foreign` FOREIGN KEY (`upcoming_course_id`) REFERENCES `upcoming_courses` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `faqs_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 58 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of faqs
-- ----------------------------

-- ----------------------------
-- Table structure for favorites
-- ----------------------------
DROP TABLE IF EXISTS `favorites`;
CREATE TABLE `favorites`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int UNSIGNED NOT NULL,
  `webinar_id` int UNSIGNED NULL DEFAULT NULL,
  `bundle_id` int UNSIGNED NULL DEFAULT NULL,
  `upcoming_course_id` int UNSIGNED NULL DEFAULT NULL,
  `created_at` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `favorites_webinar_id_foreign`(`webinar_id`) USING BTREE,
  INDEX `favorites_user_id_foreign`(`user_id`) USING BTREE,
  INDEX `favorites_bundle_id_foreign`(`bundle_id`) USING BTREE,
  INDEX `favorites_upcoming_course_id_foreign`(`upcoming_course_id`) USING BTREE,
  CONSTRAINT `favorites_bundle_id_foreign` FOREIGN KEY (`bundle_id`) REFERENCES `bundles` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `favorites_upcoming_course_id_foreign` FOREIGN KEY (`upcoming_course_id`) REFERENCES `upcoming_courses` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `favorites_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `favorites_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of favorites
-- ----------------------------

-- ----------------------------
-- Table structure for feature_webinar_translations
-- ----------------------------
DROP TABLE IF EXISTS `feature_webinar_translations`;
CREATE TABLE `feature_webinar_translations`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `feature_webinar_id` int UNSIGNED NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `feature_webinar_translations_feature_webinar_id_foreign`(`feature_webinar_id`) USING BTREE,
  INDEX `feature_webinar_translations_locale_index`(`locale`) USING BTREE,
  CONSTRAINT `feature_webinar_translations_feature_webinar_id_foreign` FOREIGN KEY (`feature_webinar_id`) REFERENCES `feature_webinars` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of feature_webinar_translations
-- ----------------------------

-- ----------------------------
-- Table structure for feature_webinars
-- ----------------------------
DROP TABLE IF EXISTS `feature_webinars`;
CREATE TABLE `feature_webinars`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `webinar_id` int UNSIGNED NOT NULL,
  `page` enum('categories','home','home_categories') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('publish','pending') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `updated_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `feature_webinars_webinar_id_index`(`webinar_id`) USING BTREE,
  CONSTRAINT `feature_webinars_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of feature_webinars
-- ----------------------------

-- ----------------------------
-- Table structure for file_translations
-- ----------------------------
DROP TABLE IF EXISTS `file_translations`;
CREATE TABLE `file_translations`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `file_id` int UNSIGNED NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `file_translations_file_id_foreign`(`file_id`) USING BTREE,
  INDEX `file_translations_locale_index`(`locale`) USING BTREE,
  CONSTRAINT `file_translations_file_id_foreign` FOREIGN KEY (`file_id`) REFERENCES `files` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 65 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of file_translations
-- ----------------------------

-- ----------------------------
-- Table structure for files
-- ----------------------------
DROP TABLE IF EXISTS `files`;
CREATE TABLE `files`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `creator_id` int UNSIGNED NOT NULL,
  `webinar_id` int UNSIGNED NOT NULL,
  `chapter_id` int UNSIGNED NULL DEFAULT NULL,
  `accessibility` enum('free','paid') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `downloadable` tinyint(1) NULL DEFAULT 0,
  `storage` enum('upload','youtube','vimeo','external_link','google_drive','dropbox','iframe','s3','upload_archive','secure_host') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `file` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `volume` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_type` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `interactive_type` enum('adobe_captivate','i_spring','custom') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `interactive_file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `interactive_file_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `check_previous_parts` tinyint(1) NOT NULL DEFAULT 0,
  `access_after_day` int UNSIGNED NULL DEFAULT NULL,
  `online_viewer` tinyint(1) NOT NULL DEFAULT 0,
  `order` int UNSIGNED NULL DEFAULT NULL,
  `status` enum('active','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `created_at` int NOT NULL,
  `updated_at` int NULL DEFAULT NULL,
  `deleted_at` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `files_webinar_id_foreign`(`webinar_id`) USING BTREE,
  INDEX `files_creator_id_foreign`(`creator_id`) USING BTREE,
  INDEX `files_chapter_id_foreign`(`chapter_id`) USING BTREE,
  CONSTRAINT `files_chapter_id_foreign` FOREIGN KEY (`chapter_id`) REFERENCES `webinar_chapters` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `files_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `files_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 96 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of files
-- ----------------------------

-- ----------------------------
-- Table structure for filter_option_translations
-- ----------------------------
DROP TABLE IF EXISTS `filter_option_translations`;
CREATE TABLE `filter_option_translations`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `filter_option_id` int UNSIGNED NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `filter_option_translations_filter_option_id_foreign`(`filter_option_id`) USING BTREE,
  INDEX `filter_option_translations_locale_index`(`locale`) USING BTREE,
  CONSTRAINT `filter_option_translations_filter_option_id_foreign` FOREIGN KEY (`filter_option_id`) REFERENCES `filter_options` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1227 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of filter_option_translations
-- ----------------------------

-- ----------------------------
-- Table structure for filter_options
-- ----------------------------
DROP TABLE IF EXISTS `filter_options`;
CREATE TABLE `filter_options`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `filter_id` int UNSIGNED NOT NULL,
  `order` int UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `filter_options_filter_id_foreign`(`filter_id`) USING BTREE,
  CONSTRAINT `filter_options_filter_id_foreign` FOREIGN KEY (`filter_id`) REFERENCES `filters` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 9293 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of filter_options
-- ----------------------------

-- ----------------------------
-- Table structure for filter_translations
-- ----------------------------
DROP TABLE IF EXISTS `filter_translations`;
CREATE TABLE `filter_translations`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `filter_id` int UNSIGNED NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `filter_translations_filter_id_foreign`(`filter_id`) USING BTREE,
  INDEX `filter_translations_locale_index`(`locale`) USING BTREE,
  CONSTRAINT `filter_translations_filter_id_foreign` FOREIGN KEY (`filter_id`) REFERENCES `filters` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 278 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of filter_translations
-- ----------------------------

-- ----------------------------
-- Table structure for filters
-- ----------------------------
DROP TABLE IF EXISTS `filters`;
CREATE TABLE `filters`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `category_id` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `filters_category_id_foreign`(`category_id`) USING BTREE,
  CONSTRAINT `filters_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1848 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of filters
-- ----------------------------

-- ----------------------------
-- Table structure for floating_bar_translations
-- ----------------------------
DROP TABLE IF EXISTS `floating_bar_translations`;
CREATE TABLE `floating_bar_translations`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `floating_bar_id` int UNSIGNED NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `btn_text` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `floating_bar_translations_floating_bar_id_foreign`(`floating_bar_id`) USING BTREE,
  INDEX `floating_bar_translations_locale_index`(`locale`) USING BTREE,
  CONSTRAINT `floating_bar_translations_floating_bar_id_foreign` FOREIGN KEY (`floating_bar_id`) REFERENCES `floating_bars` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of floating_bar_translations
-- ----------------------------
INSERT INTO `floating_bar_translations` VALUES (3, 2, 'en', 'New Years Day Celebration', 'Get all courses with 50 to 70% off without any limitation', 'View Courses');

-- ----------------------------
-- Table structure for floating_bars
-- ----------------------------
DROP TABLE IF EXISTS `floating_bars`;
CREATE TABLE `floating_bars`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `start_at` bigint NULL DEFAULT NULL,
  `end_at` bigint NULL DEFAULT NULL,
  `title_color` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `description_color` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `background_color` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `background_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `btn_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `btn_color` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `btn_text_color` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `bar_height` int NULL DEFAULT NULL,
  `position` enum('top','bottom') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `fixed` tinyint(1) NOT NULL DEFAULT 0,
  `enable` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of floating_bars
-- ----------------------------
INSERT INTO `floating_bars` VALUES (2, 1678456800, 1755727200, '#2d2d2d', '#b3b3b3', '/store/1/topnav_icon.svg', '#1f3b64', '/store/1/topnav_background.jpg', '/classes?discount=on', '#feb702', '#ffffff', 70, 'top', 1, 0);

-- ----------------------------
-- Table structure for follows
-- ----------------------------
DROP TABLE IF EXISTS `follows`;
CREATE TABLE `follows`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `follower` int UNSIGNED NOT NULL,
  `user_id` int UNSIGNED NOT NULL,
  `status` enum('requested','accepted','rejected') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `follows_follower_foreign`(`follower`) USING BTREE,
  INDEX `follows_user_id_foreign`(`user_id`) USING BTREE,
  CONSTRAINT `follows_follower_foreign` FOREIGN KEY (`follower`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `follows_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of follows
-- ----------------------------

-- ----------------------------
-- Table structure for forum_featured_topics
-- ----------------------------
DROP TABLE IF EXISTS `forum_featured_topics`;
CREATE TABLE `forum_featured_topics`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `topic_id` int UNSIGNED NOT NULL,
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `forum_featured_topics_topic_id_foreign`(`topic_id`) USING BTREE,
  CONSTRAINT `forum_featured_topics_topic_id_foreign` FOREIGN KEY (`topic_id`) REFERENCES `forum_topics` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of forum_featured_topics
-- ----------------------------

-- ----------------------------
-- Table structure for forum_recommended_topic_items
-- ----------------------------
DROP TABLE IF EXISTS `forum_recommended_topic_items`;
CREATE TABLE `forum_recommended_topic_items`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `recommended_topic_id` int UNSIGNED NOT NULL,
  `topic_id` int UNSIGNED NOT NULL,
  `created_at` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `forum_recommended_topic_items_recommended_topic_id_foreign`(`recommended_topic_id`) USING BTREE,
  INDEX `forum_recommended_topic_items_topic_id_foreign`(`topic_id`) USING BTREE,
  CONSTRAINT `forum_recommended_topic_items_recommended_topic_id_foreign` FOREIGN KEY (`recommended_topic_id`) REFERENCES `forum_recommended_topics` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `forum_recommended_topic_items_topic_id_foreign` FOREIGN KEY (`topic_id`) REFERENCES `forum_topics` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 55 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of forum_recommended_topic_items
-- ----------------------------

-- ----------------------------
-- Table structure for forum_recommended_topics
-- ----------------------------
DROP TABLE IF EXISTS `forum_recommended_topics`;
CREATE TABLE `forum_recommended_topics`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of forum_recommended_topics
-- ----------------------------

-- ----------------------------
-- Table structure for forum_topic_attachments
-- ----------------------------
DROP TABLE IF EXISTS `forum_topic_attachments`;
CREATE TABLE `forum_topic_attachments`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `creator_id` int UNSIGNED NOT NULL,
  `topic_id` int UNSIGNED NOT NULL,
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `forum_topic_attachments_topic_id_foreign`(`topic_id`) USING BTREE,
  INDEX `forum_topic_attachments_creator_id_foreign`(`creator_id`) USING BTREE,
  CONSTRAINT `forum_topic_attachments_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `forum_topic_attachments_topic_id_foreign` FOREIGN KEY (`topic_id`) REFERENCES `forum_topics` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of forum_topic_attachments
-- ----------------------------

-- ----------------------------
-- Table structure for forum_topic_bookmarks
-- ----------------------------
DROP TABLE IF EXISTS `forum_topic_bookmarks`;
CREATE TABLE `forum_topic_bookmarks`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int UNSIGNED NOT NULL,
  `topic_id` int UNSIGNED NOT NULL,
  `created_at` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `forum_topic_bookmarks_user_id_foreign`(`user_id`) USING BTREE,
  INDEX `forum_topic_bookmarks_topic_id_foreign`(`topic_id`) USING BTREE,
  CONSTRAINT `forum_topic_bookmarks_topic_id_foreign` FOREIGN KEY (`topic_id`) REFERENCES `forum_topics` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `forum_topic_bookmarks_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of forum_topic_bookmarks
-- ----------------------------

-- ----------------------------
-- Table structure for forum_topic_likes
-- ----------------------------
DROP TABLE IF EXISTS `forum_topic_likes`;
CREATE TABLE `forum_topic_likes`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int UNSIGNED NOT NULL,
  `topic_id` int UNSIGNED NULL DEFAULT NULL,
  `topic_post_id` int UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `forum_topic_likes_user_id_foreign`(`user_id`) USING BTREE,
  INDEX `forum_topic_likes_topic_id_foreign`(`topic_id`) USING BTREE,
  INDEX `forum_topic_likes_topic_post_id_foreign`(`topic_post_id`) USING BTREE,
  CONSTRAINT `forum_topic_likes_topic_id_foreign` FOREIGN KEY (`topic_id`) REFERENCES `forum_topics` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `forum_topic_likes_topic_post_id_foreign` FOREIGN KEY (`topic_post_id`) REFERENCES `forum_topic_posts` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `forum_topic_likes_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of forum_topic_likes
-- ----------------------------

-- ----------------------------
-- Table structure for forum_topic_posts
-- ----------------------------
DROP TABLE IF EXISTS `forum_topic_posts`;
CREATE TABLE `forum_topic_posts`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int UNSIGNED NOT NULL,
  `topic_id` int UNSIGNED NOT NULL,
  `parent_id` int UNSIGNED NULL DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `attach` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `pin` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `forum_topic_posts_user_id_foreign`(`user_id`) USING BTREE,
  INDEX `forum_topic_posts_topic_id_foreign`(`topic_id`) USING BTREE,
  INDEX `forum_topic_posts_parent_id_foreign`(`parent_id`) USING BTREE,
  CONSTRAINT `forum_topic_posts_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `forum_topic_posts` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `forum_topic_posts_topic_id_foreign` FOREIGN KEY (`topic_id`) REFERENCES `forum_topics` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `forum_topic_posts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of forum_topic_posts
-- ----------------------------

-- ----------------------------
-- Table structure for forum_topic_reports
-- ----------------------------
DROP TABLE IF EXISTS `forum_topic_reports`;
CREATE TABLE `forum_topic_reports`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int UNSIGNED NOT NULL,
  `topic_id` int UNSIGNED NULL DEFAULT NULL,
  `topic_post_id` int UNSIGNED NULL DEFAULT NULL,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `forum_topic_reports_user_id_foreign`(`user_id`) USING BTREE,
  INDEX `forum_topic_reports_topic_id_foreign`(`topic_id`) USING BTREE,
  INDEX `forum_topic_reports_topic_post_id_foreign`(`topic_post_id`) USING BTREE,
  CONSTRAINT `forum_topic_reports_topic_id_foreign` FOREIGN KEY (`topic_id`) REFERENCES `forum_topics` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `forum_topic_reports_topic_post_id_foreign` FOREIGN KEY (`topic_post_id`) REFERENCES `forum_topic_posts` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `forum_topic_reports_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of forum_topic_reports
-- ----------------------------

-- ----------------------------
-- Table structure for forum_topics
-- ----------------------------
DROP TABLE IF EXISTS `forum_topics`;
CREATE TABLE `forum_topics`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `creator_id` int UNSIGNED NOT NULL,
  `forum_id` int UNSIGNED NOT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `pin` tinyint(1) NOT NULL DEFAULT 0,
  `close` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `forum_topics_slug_unique`(`slug`) USING BTREE,
  INDEX `forum_topics_creator_id_foreign`(`creator_id`) USING BTREE,
  INDEX `forum_topics_forum_id_foreign`(`forum_id`) USING BTREE,
  CONSTRAINT `forum_topics_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `forum_topics_forum_id_foreign` FOREIGN KEY (`forum_id`) REFERENCES `forums` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of forum_topics
-- ----------------------------

-- ----------------------------
-- Table structure for forum_translations
-- ----------------------------
DROP TABLE IF EXISTS `forum_translations`;
CREATE TABLE `forum_translations`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `forum_id` int UNSIGNED NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `forum_translations_forum_id_foreign`(`forum_id`) USING BTREE,
  INDEX `forum_translations_locale_index`(`locale`) USING BTREE,
  CONSTRAINT `forum_translations_forum_id_foreign` FOREIGN KEY (`forum_id`) REFERENCES `forums` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of forum_translations
-- ----------------------------

-- ----------------------------
-- Table structure for forums
-- ----------------------------
DROP TABLE IF EXISTS `forums`;
CREATE TABLE `forums`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `role_id` int UNSIGNED NULL DEFAULT NULL,
  `group_id` int UNSIGNED NULL DEFAULT NULL,
  `parent_id` int UNSIGNED NULL DEFAULT NULL,
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `status` enum('disabled','active') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `close` tinyint(1) NOT NULL DEFAULT 0,
  `order` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `forums_slug_unique`(`slug`) USING BTREE,
  INDEX `forums_role_id_foreign`(`role_id`) USING BTREE,
  INDEX `forums_group_id_foreign`(`group_id`) USING BTREE,
  CONSTRAINT `forums_group_id_foreign` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `forums_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of forums
-- ----------------------------

-- ----------------------------
-- Table structure for gifts
-- ----------------------------
DROP TABLE IF EXISTS `gifts`;
CREATE TABLE `gifts`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int UNSIGNED NOT NULL,
  `webinar_id` int UNSIGNED NULL DEFAULT NULL,
  `bundle_id` int UNSIGNED NULL DEFAULT NULL,
  `product_id` int UNSIGNED NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` bigint UNSIGNED NULL DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `viewed` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'for show modal in recipient user panel',
  `status` enum('active','pending','cancel') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'pending',
  `created_at` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `gifts_user_id_foreign`(`user_id`) USING BTREE,
  INDEX `gifts_webinar_id_foreign`(`webinar_id`) USING BTREE,
  INDEX `gifts_bundle_id_foreign`(`bundle_id`) USING BTREE,
  INDEX `gifts_product_id_foreign`(`product_id`) USING BTREE,
  CONSTRAINT `gifts_bundle_id_foreign` FOREIGN KEY (`bundle_id`) REFERENCES `bundles` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `gifts_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `gifts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `gifts_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gifts
-- ----------------------------

-- ----------------------------
-- Table structure for group_users
-- ----------------------------
DROP TABLE IF EXISTS `group_users`;
CREATE TABLE `group_users`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `group_id` int UNSIGNED NOT NULL,
  `user_id` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `group_users_group_id_foreign`(`group_id`) USING BTREE,
  INDEX `group_users_user_id_foreign`(`user_id`) USING BTREE,
  CONSTRAINT `group_users_group_id_foreign` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `group_users_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 71 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of group_users
-- ----------------------------
INSERT INTO `group_users` VALUES (67, 4, 1016, 1681486947);
INSERT INTO `group_users` VALUES (68, 4, 1055, 1684174239);
INSERT INTO `group_users` VALUES (69, 4, 1066, 1692022793);
INSERT INTO `group_users` VALUES (70, 4, 1067, 1692029748);

-- ----------------------------
-- Table structure for groups
-- ----------------------------
DROP TABLE IF EXISTS `groups`;
CREATE TABLE `groups`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `creator_id` int UNSIGNED NOT NULL,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `discount` int NULL DEFAULT NULL,
  `commission` int NULL DEFAULT NULL,
  `status` enum('active','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'inactive',
  `created_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `groups_creator_id_foreign`(`creator_id`) USING BTREE,
  CONSTRAINT `groups_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of groups
-- ----------------------------
INSERT INTO `groups` VALUES (4, 1, 'Dev Zeros School', 0, 0, 'active', 1681486947);

-- ----------------------------
-- Table structure for groups_registration_packages
-- ----------------------------
DROP TABLE IF EXISTS `groups_registration_packages`;
CREATE TABLE `groups_registration_packages`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `group_id` int UNSIGNED NOT NULL,
  `instructors_count` int NULL DEFAULT NULL,
  `students_count` int NULL DEFAULT NULL,
  `courses_capacity` int NULL DEFAULT NULL,
  `courses_count` int NULL DEFAULT NULL,
  `meeting_count` int NULL DEFAULT NULL,
  `status` enum('disabled','active') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `groups_registration_packages_group_id_foreign`(`group_id`) USING BTREE,
  CONSTRAINT `groups_registration_packages_group_id_foreign` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of groups_registration_packages
-- ----------------------------

-- ----------------------------
-- Table structure for home_page_statistic_translations
-- ----------------------------
DROP TABLE IF EXISTS `home_page_statistic_translations`;
CREATE TABLE `home_page_statistic_translations`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `home_page_statistic_id` int UNSIGNED NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `home_page_statistic_id`(`home_page_statistic_id`) USING BTREE,
  INDEX `home_page_statistic_translations_locale_index`(`locale`) USING BTREE,
  CONSTRAINT `home_page_statistic_id` FOREIGN KEY (`home_page_statistic_id`) REFERENCES `home_page_statistics` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of home_page_statistic_translations
-- ----------------------------
INSERT INTO `home_page_statistic_translations` VALUES (2, 2, 'en', 'Skillful Instructors', 'Start learning from experienced instructors.');
INSERT INTO `home_page_statistic_translations` VALUES (3, 3, 'en', 'Video Courses', 'Learn without any geographical & time limitations.');
INSERT INTO `home_page_statistic_translations` VALUES (4, 4, 'en', 'Live Classes', 'Improve your skills using live knowledge flow.');
INSERT INTO `home_page_statistic_translations` VALUES (5, 5, 'en', 'Happy Students', 'are available to help you by their knowledge');
INSERT INTO `home_page_statistic_translations` VALUES (6, 4, 'fa', 'عنوان یب سیبسی ب', 'بل بلابل سل سبس بسیب');

-- ----------------------------
-- Table structure for home_page_statistics
-- ----------------------------
DROP TABLE IF EXISTS `home_page_statistics`;
CREATE TABLE `home_page_statistics`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `color` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `count` int UNSIGNED NOT NULL,
  `order` int UNSIGNED NULL DEFAULT NULL,
  `created_at` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of home_page_statistics
-- ----------------------------
INSERT INTO `home_page_statistics` VALUES (2, '/store/1/default_images/trend_categories_icons/chess.png', '#c95d63', 20, 1, 1675870234);
INSERT INTO `home_page_statistics` VALUES (3, '/store/1/default_images/trend_categories_icons/palette.png', '#496ddb', 12, 4, 1675870276);
INSERT INTO `home_page_statistics` VALUES (4, '/store/1/default_images/trend_categories_icons/connection.png', '#717ec3', 16, 3, 1675870320);
INSERT INTO `home_page_statistics` VALUES (5, '/store/1/default_images/trend_categories_icons/family.png', '#ae8799', 78, 2, 1675870418);

-- ----------------------------
-- Table structure for home_sections
-- ----------------------------
DROP TABLE IF EXISTS `home_sections`;
CREATE TABLE `home_sections`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` enum('featured_classes','latest_bundles','latest_classes','best_rates','trend_categories','full_advertising_banner','best_sellers','discount_classes','free_classes','store_products','testimonials','subscribes','find_instructors','reward_program','become_instructor','forum_section','video_or_image_section','instructors','half_advertising_banner','organizations','blog','upcoming_courses') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `order` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `home_sections_name_index`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 32 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of home_sections
-- ----------------------------
INSERT INTO `home_sections` VALUES (1, 'latest_classes', 1);

-- ----------------------------
-- Table structure for installment_order_attachments
-- ----------------------------
DROP TABLE IF EXISTS `installment_order_attachments`;
CREATE TABLE `installment_order_attachments`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `installment_order_id` int UNSIGNED NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `file` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `installment_order_id_attachment`(`installment_order_id`) USING BTREE,
  CONSTRAINT `installment_order_id_attachment` FOREIGN KEY (`installment_order_id`) REFERENCES `installment_orders` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of installment_order_attachments
-- ----------------------------

-- ----------------------------
-- Table structure for installment_order_payments
-- ----------------------------
DROP TABLE IF EXISTS `installment_order_payments`;
CREATE TABLE `installment_order_payments`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `installment_order_id` int UNSIGNED NOT NULL,
  `sale_id` int UNSIGNED NULL DEFAULT NULL,
  `type` enum('upfront','step') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `step_id` int UNSIGNED NULL DEFAULT NULL,
  `amount` double(15, 2) NOT NULL,
  `status` enum('paying','paid','canceled','refunded') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'paying',
  `created_at` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `installment_order_id`(`installment_order_id`) USING BTREE,
  INDEX `installment_order_payments_step_id_foreign`(`step_id`) USING BTREE,
  INDEX `installment_order_payments_sale_id_foreign`(`sale_id`) USING BTREE,
  CONSTRAINT `installment_order_id` FOREIGN KEY (`installment_order_id`) REFERENCES `installment_orders` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `installment_order_payments_sale_id_foreign` FOREIGN KEY (`sale_id`) REFERENCES `sales` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `installment_order_payments_step_id_foreign` FOREIGN KEY (`step_id`) REFERENCES `installment_steps` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of installment_order_payments
-- ----------------------------

-- ----------------------------
-- Table structure for installment_orders
-- ----------------------------
DROP TABLE IF EXISTS `installment_orders`;
CREATE TABLE `installment_orders`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `installment_id` int UNSIGNED NOT NULL,
  `user_id` int UNSIGNED NOT NULL,
  `webinar_id` int UNSIGNED NULL DEFAULT NULL,
  `product_id` int UNSIGNED NULL DEFAULT NULL,
  `bundle_id` int UNSIGNED NULL DEFAULT NULL,
  `subscribe_id` int UNSIGNED NULL DEFAULT NULL,
  `registration_package_id` int UNSIGNED NULL DEFAULT NULL,
  `product_order_id` int UNSIGNED NULL DEFAULT NULL,
  `item_price` double(15, 2) NOT NULL DEFAULT 0,
  `status` enum('paying','open','rejected','pending_verification','canceled','refunded') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'paying',
  `created_at` bigint UNSIGNED NOT NULL,
  `refund_at` bigint UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `installment_orders_installment_id_foreign`(`installment_id`) USING BTREE,
  INDEX `installment_orders_user_id_foreign`(`user_id`) USING BTREE,
  INDEX `installment_orders_webinar_id_foreign`(`webinar_id`) USING BTREE,
  INDEX `installment_orders_product_id_foreign`(`product_id`) USING BTREE,
  INDEX `installment_orders_bundle_id_foreign`(`bundle_id`) USING BTREE,
  INDEX `installment_orders_subscribe_id_foreign`(`subscribe_id`) USING BTREE,
  INDEX `installment_orders_registration_package_id_foreign`(`registration_package_id`) USING BTREE,
  INDEX `installment_product_order_id`(`product_order_id`) USING BTREE,
  CONSTRAINT `installment_orders_bundle_id_foreign` FOREIGN KEY (`bundle_id`) REFERENCES `bundles` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `installment_orders_installment_id_foreign` FOREIGN KEY (`installment_id`) REFERENCES `installments` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `installment_orders_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `installment_orders_registration_package_id_foreign` FOREIGN KEY (`registration_package_id`) REFERENCES `registration_packages` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `installment_orders_subscribe_id_foreign` FOREIGN KEY (`subscribe_id`) REFERENCES `subscribes` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `installment_orders_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `installment_orders_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `installment_product_order_id` FOREIGN KEY (`product_order_id`) REFERENCES `product_orders` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of installment_orders
-- ----------------------------

-- ----------------------------
-- Table structure for installment_reminders
-- ----------------------------
DROP TABLE IF EXISTS `installment_reminders`;
CREATE TABLE `installment_reminders`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int UNSIGNED NOT NULL,
  `installment_order_id` int UNSIGNED NOT NULL,
  `installment_step_id` int UNSIGNED NOT NULL,
  `type` enum('before_due','due','after_due') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `installment_reminders_user_id_foreign`(`user_id`) USING BTREE,
  CONSTRAINT `installment_reminders_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of installment_reminders
-- ----------------------------

-- ----------------------------
-- Table structure for installment_specification_items
-- ----------------------------
DROP TABLE IF EXISTS `installment_specification_items`;
CREATE TABLE `installment_specification_items`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `installment_id` int UNSIGNED NOT NULL,
  `category_id` int UNSIGNED NULL DEFAULT NULL,
  `instructor_id` int UNSIGNED NULL DEFAULT NULL,
  `seller_id` int UNSIGNED NULL DEFAULT NULL,
  `webinar_id` int UNSIGNED NULL DEFAULT NULL,
  `product_id` int UNSIGNED NULL DEFAULT NULL,
  `bundle_id` int UNSIGNED NULL DEFAULT NULL,
  `subscribe_id` int UNSIGNED NULL DEFAULT NULL,
  `registration_package_id` int UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `installment_specification_items_installment_id_foreign`(`installment_id`) USING BTREE,
  INDEX `installment_specification_items_category_id_foreign`(`category_id`) USING BTREE,
  INDEX `installment_specification_items_instructor_id_foreign`(`instructor_id`) USING BTREE,
  INDEX `installment_specification_items_seller_id_foreign`(`seller_id`) USING BTREE,
  INDEX `installment_specification_items_webinar_id_foreign`(`webinar_id`) USING BTREE,
  INDEX `installment_specification_items_product_id_foreign`(`product_id`) USING BTREE,
  INDEX `installment_specification_items_bundle_id_foreign`(`bundle_id`) USING BTREE,
  INDEX `installment_specification_items_subscribe_id_foreign`(`subscribe_id`) USING BTREE,
  INDEX `installment_specification_items_registration_package_id_foreign`(`registration_package_id`) USING BTREE,
  CONSTRAINT `installment_specification_items_bundle_id_foreign` FOREIGN KEY (`bundle_id`) REFERENCES `bundles` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `installment_specification_items_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `installment_specification_items_installment_id_foreign` FOREIGN KEY (`installment_id`) REFERENCES `installments` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `installment_specification_items_instructor_id_foreign` FOREIGN KEY (`instructor_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `installment_specification_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `installment_specification_items_registration_package_id_foreign` FOREIGN KEY (`registration_package_id`) REFERENCES `registration_packages` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `installment_specification_items_seller_id_foreign` FOREIGN KEY (`seller_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `installment_specification_items_subscribe_id_foreign` FOREIGN KEY (`subscribe_id`) REFERENCES `subscribes` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `installment_specification_items_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of installment_specification_items
-- ----------------------------

-- ----------------------------
-- Table structure for installment_step_translations
-- ----------------------------
DROP TABLE IF EXISTS `installment_step_translations`;
CREATE TABLE `installment_step_translations`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `installment_step_id` int UNSIGNED NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `installment_step_translations_installment_step_id_foreign`(`installment_step_id`) USING BTREE,
  INDEX `installment_step_translations_locale_index`(`locale`) USING BTREE,
  CONSTRAINT `installment_step_translations_installment_step_id_foreign` FOREIGN KEY (`installment_step_id`) REFERENCES `installment_steps` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of installment_step_translations
-- ----------------------------

-- ----------------------------
-- Table structure for installment_steps
-- ----------------------------
DROP TABLE IF EXISTS `installment_steps`;
CREATE TABLE `installment_steps`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `installment_id` int UNSIGNED NOT NULL,
  `deadline` int UNSIGNED NULL DEFAULT NULL,
  `amount` double(15, 2) NULL DEFAULT NULL,
  `amount_type` enum('fixed_amount','percent') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `order` int UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `installment_steps_installment_id_foreign`(`installment_id`) USING BTREE,
  CONSTRAINT `installment_steps_installment_id_foreign` FOREIGN KEY (`installment_id`) REFERENCES `installments` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of installment_steps
-- ----------------------------

-- ----------------------------
-- Table structure for installment_translations
-- ----------------------------
DROP TABLE IF EXISTS `installment_translations`;
CREATE TABLE `installment_translations`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `installment_id` int UNSIGNED NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `main_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `banner` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `options` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `verification_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `verification_banner` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `verification_video` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `installment_translations_installment_id_foreign`(`installment_id`) USING BTREE,
  INDEX `installment_translations_locale_index`(`locale`) USING BTREE,
  CONSTRAINT `installment_translations_installment_id_foreign` FOREIGN KEY (`installment_id`) REFERENCES `installments` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of installment_translations
-- ----------------------------

-- ----------------------------
-- Table structure for installment_user_groups
-- ----------------------------
DROP TABLE IF EXISTS `installment_user_groups`;
CREATE TABLE `installment_user_groups`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `installment_id` int UNSIGNED NOT NULL,
  `group_id` int UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `installment_user_groups_installment_id_foreign`(`installment_id`) USING BTREE,
  INDEX `installment_user_groups_group_id_foreign`(`group_id`) USING BTREE,
  CONSTRAINT `installment_user_groups_group_id_foreign` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `installment_user_groups_installment_id_foreign` FOREIGN KEY (`installment_id`) REFERENCES `installments` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of installment_user_groups
-- ----------------------------

-- ----------------------------
-- Table structure for installments
-- ----------------------------
DROP TABLE IF EXISTS `installments`;
CREATE TABLE `installments`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `target_type` enum('all','courses','store_products','bundles','meetings','registration_packages','subscription_packages') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `target` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `capacity` int UNSIGNED NULL DEFAULT NULL,
  `start_date` bigint UNSIGNED NULL DEFAULT NULL,
  `end_date` bigint UNSIGNED NULL DEFAULT NULL,
  `verification` tinyint(1) NOT NULL DEFAULT 0,
  `request_uploads` tinyint(1) NOT NULL DEFAULT 0,
  `bypass_verification_for_verified_users` tinyint(1) NOT NULL DEFAULT 0,
  `upfront` double(15, 2) NULL DEFAULT NULL,
  `upfront_type` enum('fixed_amount','percent') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `enable` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of installments
-- ----------------------------

-- ----------------------------
-- Table structure for interested_course_translations
-- ----------------------------
DROP TABLE IF EXISTS `interested_course_translations`;
CREATE TABLE `interested_course_translations`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `interested_courses_id` int UNSIGNED NOT NULL,
  `webinar_id` int UNSIGNED NOT NULL,
  `created_at` int NOT NULL,
  `updated_at` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `interested_course_translations_interested_courses_id_foreign`(`interested_courses_id`) USING BTREE,
  INDEX `interested_course_translations_webinar_id_foreign`(`webinar_id`) USING BTREE,
  CONSTRAINT `interested_course_translations_interested_courses_id_foreign` FOREIGN KEY (`interested_courses_id`) REFERENCES `interested_courses` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `interested_course_translations_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of interested_course_translations
-- ----------------------------
INSERT INTO `interested_course_translations` VALUES (4, 4, 2025, 1685760183, NULL);
INSERT INTO `interested_course_translations` VALUES (5, 5, 2025, 1686351144, NULL);
INSERT INTO `interested_course_translations` VALUES (6, 6, 2025, 1686351539, NULL);
INSERT INTO `interested_course_translations` VALUES (7, 7, 2025, 1686669678, NULL);
INSERT INTO `interested_course_translations` VALUES (8, 8, 2029, 1693078030, NULL);
INSERT INTO `interested_course_translations` VALUES (9, 9, 2029, 1693078148, NULL);
INSERT INTO `interested_course_translations` VALUES (10, 10, 2029, 1693078762, NULL);

-- ----------------------------
-- Table structure for interested_courses
-- ----------------------------
DROP TABLE IF EXISTS `interested_courses`;
CREATE TABLE `interested_courses`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int NULL DEFAULT NULL,
  `full_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `mobile` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `country_id` int NULL DEFAULT NULL,
  `terms` int NOT NULL,
  `pending` int NOT NULL,
  `note` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` int NOT NULL,
  `updated_at` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of interested_courses
-- ----------------------------
INSERT INTO `interested_courses` VALUES (3, 1057, 'carlos andrés castilla garcía', '573043541475', 'carloscastilla31@gmail.com', 1, 1, 1, NULL, 1684601386, NULL);
INSERT INTO `interested_courses` VALUES (4, NULL, 'Jhon Torres', '3142478225', 'unijhonsaul@gmail.com', 1, 1, 1, NULL, 1685760183, NULL);
INSERT INTO `interested_courses` VALUES (5, NULL, 'Jairo Tapia', '3135816040', 'jairotapia56@hotmail.com', 57, 1, 1, NULL, 1686351144, NULL);
INSERT INTO `interested_courses` VALUES (6, NULL, 'Kelly Johanna Blanco Molina', '3186037335', 'kelly.blanco@devzeros.com', 57, 1, 1, NULL, 1686351539, NULL);
INSERT INTO `interested_courses` VALUES (7, 1057, 'carlos andrés castilla garcía', '3043541475', 'carloscastilla31@gmail.com', 57, 1, 1, NULL, 1686669678, NULL);
INSERT INTO `interested_courses` VALUES (8, NULL, 'Andrés Pérez', '123456789', 'ronlad.castro@devzeros.com', 57, 1, 1, NULL, 1693078030, NULL);
INSERT INTO `interested_courses` VALUES (9, NULL, 'Ronlad Castro', '3024563759', 'ronlad@gmail.com', 57, 1, 1, NULL, 1693078148, NULL);
INSERT INTO `interested_courses` VALUES (10, NULL, 'Ronlad Castro', '3024563759', 'ronlad@devzeros.com', 57, 1, 1, NULL, 1693078762, NULL);

-- ----------------------------
-- Table structure for jazzcash_transactions
-- ----------------------------
DROP TABLE IF EXISTS `jazzcash_transactions`;
CREATE TABLE `jazzcash_transactions`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `txn_ref_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `order` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'Order data fields and values',
  `request` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'Jazzcash request data fields and values',
  `response` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT 'Jazzcash response data fields and values',
  `status` enum('pending','error','completed') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of jazzcash_transactions
-- ----------------------------

-- ----------------------------
-- Table structure for meeting_times
-- ----------------------------
DROP TABLE IF EXISTS `meeting_times`;
CREATE TABLE `meeting_times`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `meeting_id` int UNSIGNED NOT NULL,
  `meeting_type` enum('all','in_person','online') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'all',
  `day_label` enum('saturday','sunday','monday','tuesday','wednesday','thursday','friday') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `time` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_at` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `meeting_times_meeting_id_foreign`(`meeting_id`) USING BTREE,
  CONSTRAINT `meeting_times_meeting_id_foreign` FOREIGN KEY (`meeting_id`) REFERENCES `meetings` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 174 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of meeting_times
-- ----------------------------

-- ----------------------------
-- Table structure for meetings
-- ----------------------------
DROP TABLE IF EXISTS `meetings`;
CREATE TABLE `meetings`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `creator_id` int UNSIGNED NOT NULL,
  `amount` double(15, 2) UNSIGNED NULL DEFAULT NULL,
  `discount` int NULL DEFAULT NULL,
  `in_person` tinyint(1) NOT NULL DEFAULT 0,
  `in_person_amount` double(15, 2) NULL DEFAULT NULL,
  `group_meeting` tinyint(1) NOT NULL DEFAULT 0,
  `online_group_min_student` int NULL DEFAULT NULL,
  `online_group_max_student` int NULL DEFAULT NULL,
  `online_group_amount` double(15, 2) NULL DEFAULT NULL,
  `in_person_group_min_student` int NULL DEFAULT NULL,
  `in_person_group_max_student` int NULL DEFAULT NULL,
  `in_person_group_amount` double(15, 2) NULL DEFAULT NULL,
  `disabled` tinyint(1) NULL DEFAULT 0,
  `created_at` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `meetings_creator_id_foreign`(`creator_id`) USING BTREE,
  CONSTRAINT `meetings_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 36 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of meetings
-- ----------------------------

-- ----------------------------
-- Table structure for migrations
-- ----------------------------
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 544 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of migrations
-- ----------------------------
INSERT INTO `migrations` VALUES (1, '2014_10_12_000000_create_users_table', 1);
INSERT INTO `migrations` VALUES (2, '2014_10_12_100000_create_password_resets_table', 1);
INSERT INTO `migrations` VALUES (3, '2020_08_09_145553_create_roles_table', 1);
INSERT INTO `migrations` VALUES (4, '2020_08_09_145834_create_sections_table', 1);
INSERT INTO `migrations` VALUES (5, '2020_08_09_145926_create_permissions_table', 1);
INSERT INTO `migrations` VALUES (6, '2020_08_24_163003_create_webinars_table', 1);
INSERT INTO `migrations` VALUES (7, '2020_08_24_164823_create_webinar_partner_teacher_table', 1);
INSERT INTO `migrations` VALUES (8, '2020_08_24_165658_create_tags_table', 1);
INSERT INTO `migrations` VALUES (9, '2020_08_24_165835_create_webinar_tag_table', 1);
INSERT INTO `migrations` VALUES (10, '2020_08_24_171611_create_categories_table', 1);
INSERT INTO `migrations` VALUES (11, '2020_08_29_052437_create_filters_table', 1);
INSERT INTO `migrations` VALUES (12, '2020_08_29_052900_create_filter_options_table', 1);
INSERT INTO `migrations` VALUES (13, '2020_08_29_054455_add_category_id_in_webinar_table', 1);
INSERT INTO `migrations` VALUES (14, '2020_09_01_174741_add_seo_description_and_start_end_time_in_webinar_table', 1);
INSERT INTO `migrations` VALUES (15, '2020_09_02_180508_create_webinar_filter_option_table', 1);
INSERT INTO `migrations` VALUES (16, '2020_09_02_193923_create_tickets_table', 1);
INSERT INTO `migrations` VALUES (17, '2020_09_02_210447_create_sessions_table', 1);
INSERT INTO `migrations` VALUES (18, '2020_09_02_212642_create_files_table', 1);
INSERT INTO `migrations` VALUES (19, '2020_09_03_175543_create_faqs_table', 1);
INSERT INTO `migrations` VALUES (20, '2020_09_08_175539_delete_webinar_tag_and_update_tag_table', 1);
INSERT INTO `migrations` VALUES (21, '2020_09_09_154522_create_quizzes_table', 1);
INSERT INTO `migrations` VALUES (22, '2020_09_09_174646_create_quizzes_questions_table', 1);
INSERT INTO `migrations` VALUES (23, '2020_09_09_182726_create_quizzes_questions_answers_table', 1);
INSERT INTO `migrations` VALUES (24, '2020_09_14_160028_create_prerequisites_table', 1);
INSERT INTO `migrations` VALUES (25, '2020_09_14_183235_nullable_item_id_in_quizzes_table', 1);
INSERT INTO `migrations` VALUES (26, '2020_09_14_190110_create_webinar_quizzes_table', 1);
INSERT INTO `migrations` VALUES (27, '2020_09_16_163835_create_quizzes_results_table', 1);
INSERT INTO `migrations` VALUES (28, '2020_09_24_102115_add_total_mark_in_quize_table', 1);
INSERT INTO `migrations` VALUES (29, '2020_09_24_132242_create_comment_table', 1);
INSERT INTO `migrations` VALUES (30, '2020_09_24_132639_create_favorites_table', 1);
INSERT INTO `migrations` VALUES (31, '2020_09_26_181200_create_certificate_table', 1);
INSERT INTO `migrations` VALUES (32, '2020_09_26_181444_create_certificates_templates_table', 1);
INSERT INTO `migrations` VALUES (33, '2020_09_30_170451_add_slug_in_webinars_table', 1);
INSERT INTO `migrations` VALUES (34, '2020_09_30_191202_create_purchases_table', 1);
INSERT INTO `migrations` VALUES (35, '2020_10_02_063828_create_rating_table', 1);
INSERT INTO `migrations` VALUES (36, '2020_10_02_094723_edit_table_and_add_foreign_key', 1);
INSERT INTO `migrations` VALUES (37, '2020_10_08_055408_add_reviwes_table', 1);
INSERT INTO `migrations` VALUES (38, '2020_10_08_084100_edit_status_comments_table', 1);
INSERT INTO `migrations` VALUES (39, '2020_10_08_121041_create_meetings_table', 2);
INSERT INTO `migrations` VALUES (40, '2020_10_08_121621_create_meeting_times_table', 2);
INSERT INTO `migrations` VALUES (41, '2020_10_08_121848_create_meeting_requests_table', 2);
INSERT INTO `migrations` VALUES (42, '2020_10_15_172913_add_about_and_head_line_in_users_table', 2);
INSERT INTO `migrations` VALUES (43, '2020_10_15_173645_create_follow_table', 2);
INSERT INTO `migrations` VALUES (46, '2020_10_17_100606_create_badges_table', 3);
INSERT INTO `migrations` VALUES (47, '2020_10_08_121848_create_reserve_meetings_table', 4);
INSERT INTO `migrations` VALUES (48, '2020_10_20_193013_update_users_table', 5);
INSERT INTO `migrations` VALUES (50, '2020_10_18_220323_convert_creatore_user_id_to_creator_id', 7);
INSERT INTO `migrations` VALUES (51, '2020_10_22_153502_create_cart_table', 7);
INSERT INTO `migrations` VALUES (52, '2020_10_22_154636_create_orders_table', 7);
INSERT INTO `migrations` VALUES (53, '2020_10_22_155930_create_order_items_table', 7);
INSERT INTO `migrations` VALUES (54, '2020_10_23_204203_create_sales_table', 7);
INSERT INTO `migrations` VALUES (55, '2020_10_23_211459_create_accounting_table', 7);
INSERT INTO `migrations` VALUES (56, '2020_10_23_213515_create_discounts_table', 7);
INSERT INTO `migrations` VALUES (57, '2020_10_23_213934_create_discount_users_table', 7);
INSERT INTO `migrations` VALUES (58, '2020_10_23_235444_create_ticket_users_table', 7);
INSERT INTO `migrations` VALUES (59, '2020_10_25_172331_create_groups_table', 7);
INSERT INTO `migrations` VALUES (60, '2020_10_25_172523_create_group_users_table', 7);
INSERT INTO `migrations` VALUES (62, '2020_11_02_202754_edit_email_in_users_table', 8);
INSERT INTO `migrations` VALUES (63, '2020_11_03_200314_edit_some_tables', 9);
INSERT INTO `migrations` VALUES (64, '2020_11_06_193300_create_settings_table', 10);
INSERT INTO `migrations` VALUES (67, '2020_11_09_202533_create_feature_webinars_table', 11);
INSERT INTO `migrations` VALUES (68, '2020_11_10_193459_edit_webinars_table', 12);
INSERT INTO `migrations` VALUES (69, '2020_11_11_203344_create_trend_categories_table', 13);
INSERT INTO `migrations` VALUES (72, '2020_11_11_222833_create_blog_categories_table', 14);
INSERT INTO `migrations` VALUES (75, '2020_11_11_231204_create_blog_table', 15);
INSERT INTO `migrations` VALUES (76, '2020_10_25_223247_add_sub_title_tickets_table', 16);
INSERT INTO `migrations` VALUES (77, '2020_10_28_001340_add_count_in_discount_users_table', 16);
INSERT INTO `migrations` VALUES (78, '2020_10_28_221509_create_payment_channels_table', 16);
INSERT INTO `migrations` VALUES (79, '2020_11_01_120909_change_class_name_enum_payment_channels_table', 16);
INSERT INTO `migrations` VALUES (80, '2020_11_07_233948_add_some_raw_in_order_items__table', 16);
INSERT INTO `migrations` VALUES (81, '2020_11_10_061350_add_discount_id_in_order_items_table', 16);
INSERT INTO `migrations` VALUES (82, '2020_11_10_071651_decimal_orders_order_items_sales_table', 16);
INSERT INTO `migrations` VALUES (83, '2020_11_11_193138_change_reference_id_type_in_orders_tabel', 16);
INSERT INTO `migrations` VALUES (84, '2020_11_11_222413_change_meeting_id_to_meeting_time_id_in_order_items_table', 16);
INSERT INTO `migrations` VALUES (85, '2020_11_11_225421_add_locked_at_and_reserved_at_and_change_request_time_to_day_in_reserve_meetings_table', 17);
INSERT INTO `migrations` VALUES (86, '2020_11_12_000116_add_type_in_orders_table', 17);
INSERT INTO `migrations` VALUES (87, '2020_11_12_001912_change_meeting_id_to_meeting_time_id_in_accounting_table', 17);
INSERT INTO `migrations` VALUES (88, '2020_11_12_133009_decimal_paid_amount_in_reserve_meetings_table', 17);
INSERT INTO `migrations` VALUES (91, '2020_11_12_170109_add_blog_id_to_comments_table', 18);
INSERT INTO `migrations` VALUES (98, '2020_11_14_201228_add_bio_and_ban_to_users_table', 20);
INSERT INTO `migrations` VALUES (99, '2020_11_14_224447_create_users_badges_table', 21);
INSERT INTO `migrations` VALUES (100, '2020_11_14_233319_create_payout_request_table', 22);
INSERT INTO `migrations` VALUES (101, '2020_11_15_010622_change_byer_id_and_add_seller_id_in_sales_table', 22);
INSERT INTO `migrations` VALUES (102, '2020_11_16_195009_create_supports_table', 22);
INSERT INTO `migrations` VALUES (103, '2020_11_16_201814_create_support_departments_table', 22);
INSERT INTO `migrations` VALUES (107, '2020_11_16_202254_create_supports_table', 23);
INSERT INTO `migrations` VALUES (109, '2020_11_17_192744_create_support_conversations_table', 24);
INSERT INTO `migrations` VALUES (110, '2020_11_17_072348_create_offline_payments_table', 25);
INSERT INTO `migrations` VALUES (111, '2020_11_19_191943_add_replied_status_to_comments_table', 25);
INSERT INTO `migrations` VALUES (114, '2020_11_20_215748_create_subscribes_table', 26);
INSERT INTO `migrations` VALUES (115, '2020_11_21_185519_create_notification_templates_table', 27);
INSERT INTO `migrations` VALUES (116, '2020_11_22_210832_create_promotions_table', 28);
INSERT INTO `migrations` VALUES (118, '2020_11_23_194153_add_status_column_to_discounts_table', 29);
INSERT INTO `migrations` VALUES (119, '2020_11_23_213532_create_users_occupations_table', 30);
INSERT INTO `migrations` VALUES (120, '2020_11_30_220855_change_amount_in_payouts_table', 31);
INSERT INTO `migrations` VALUES (121, '2020_11_30_231334_add_pay_date_in_offline_payments_table', 31);
INSERT INTO `migrations` VALUES (122, '2020_11_30_233018_add_charge_enum_in_type_in_orders_table', 31);
INSERT INTO `migrations` VALUES (123, '2020_12_01_193948_create_testimonials_table', 32);
INSERT INTO `migrations` VALUES (124, '2020_12_02_202043_edit_and_add_types_to_webinars_table', 33);
INSERT INTO `migrations` VALUES (128, '2020_12_04_204048_add_column_creator_id_to_some_tables', 34);
INSERT INTO `migrations` VALUES (129, '2020_12_05_205320_create_text_lessons_table', 35);
INSERT INTO `migrations` VALUES (130, '2020_12_05_210052_create_text_lessons_attachments_table', 36);
INSERT INTO `migrations` VALUES (131, '2020_12_06_215701_add_order_column_to_webinar_items_tables', 37);
INSERT INTO `migrations` VALUES (132, '2020_12_11_114844_add_column_storage_to_files_table', 38);
INSERT INTO `migrations` VALUES (133, '2020_12_07_211009_add_subscribe_id_in_order_items_table', 39);
INSERT INTO `migrations` VALUES (134, '2020_12_07_211657_nullable_payment_method_in_orders_table', 39);
INSERT INTO `migrations` VALUES (135, '2020_12_07_212306_add_subscribe_enum__type_in_orders_table', 39);
INSERT INTO `migrations` VALUES (136, '2020_12_07_223237_changes_in_sales_table', 39);
INSERT INTO `migrations` VALUES (137, '2020_12_07_224925_add_subscribe_id_in_accounting_table', 39);
INSERT INTO `migrations` VALUES (138, '2020_12_07_230200_create_subscribe_uses_table', 39);
INSERT INTO `migrations` VALUES (139, '2020_12_11_123209_add_subscribe_type_account_in_accounting_table', 39);
INSERT INTO `migrations` VALUES (140, '2020_12_11_132819_add_sale_id_in_subscribe_use_in_subscribe_uses_table', 39);
INSERT INTO `migrations` VALUES (141, '2020_12_11_135824_add_subscribe_payment_method_in_sales_table', 39);
INSERT INTO `migrations` VALUES (143, '2020_12_13_205751_create_advertising_banners_table', 41);
INSERT INTO `migrations` VALUES (145, '2020_12_14_204251_create_become_instructors_table', 42);
INSERT INTO `migrations` VALUES (146, '2020_11_12_232207_create_reports_table', 43);
INSERT INTO `migrations` VALUES (147, '2020_11_12_232207_create_comments_reports_table', 44);
INSERT INTO `migrations` VALUES (148, '2020_12_17_210822_create_webinar_reports_table', 45);
INSERT INTO `migrations` VALUES (150, '2020_12_18_181551_create_notifications_table', 46);
INSERT INTO `migrations` VALUES (151, '2020_12_18_195833_create_notifications_status_table', 47);
INSERT INTO `migrations` VALUES (152, '2020_12_19_195152_add_status_column_to_payment_channels_table', 48);
INSERT INTO `migrations` VALUES (154, '2020_12_20_231434_create_contacts_table', 49);
INSERT INTO `migrations` VALUES (155, '2020_12_21_210345_edit_quizzes_table', 50);
INSERT INTO `migrations` VALUES (156, '2020_12_24_221715_add_column_to_users_table', 50);
INSERT INTO `migrations` VALUES (157, '2020_12_24_084728_create_special_offers_table', 51);
INSERT INTO `migrations` VALUES (158, '2020_12_25_204545_add_promotion_enum_type_in_orders_table', 51);
INSERT INTO `migrations` VALUES (159, '2020_12_25_205139_add_promotion_id_in_order_items_table', 51);
INSERT INTO `migrations` VALUES (160, '2020_12_25_205811_add_promotion_id_in_accounting_table', 51);
INSERT INTO `migrations` VALUES (161, '2020_12_25_210341_add_promotion_id_in_sales_table', 51);
INSERT INTO `migrations` VALUES (162, '2020_12_25_212453_add_promotion_type_account_enum_in_accounting_table', 51);
INSERT INTO `migrations` VALUES (163, '2020_12_25_231005_add_promotion_type_enum_in_sales_table', 51);
INSERT INTO `migrations` VALUES (166, '2020_12_29_192943_add_column_reply_to_contacts_table', 53);
INSERT INTO `migrations` VALUES (167, '2020_12_30_225001_create_payu_transactions_table', 54);
INSERT INTO `migrations` VALUES (168, '2021_01_06_202649_edit_column_password_from_users_table', 55);
INSERT INTO `migrations` VALUES (169, '2021_01_08_134022_add_api_column_to_sessions_table', 56);
INSERT INTO `migrations` VALUES (170, '2021_01_10_215540_add_column_store_type_to_accounting', 57);
INSERT INTO `migrations` VALUES (173, '2021_01_13_214145_edit_carts_table', 58);
INSERT INTO `migrations` VALUES (174, '2021_01_13_230725_delete_column_type_from_orders_table', 59);
INSERT INTO `migrations` VALUES (175, '2021_01_20_214653_add_discount_column_to_reserve_meetings_table', 60);
INSERT INTO `migrations` VALUES (177, '2021_01_27_193915_add_foreign_key_to_support_conversations_table', 61);
INSERT INTO `migrations` VALUES (178, '2021_02_02_203821_add_viewed_at_column_to_comments_table', 62);
INSERT INTO `migrations` VALUES (180, '2021_02_12_134504_add_financial_approval_column_to_users_table', 64);
INSERT INTO `migrations` VALUES (181, '2021_02_12_131916_create_verifications_table', 65);
INSERT INTO `migrations` VALUES (182, '2021_02_15_221518_add_certificate_to_users_table', 66);
INSERT INTO `migrations` VALUES (183, '2021_02_16_194103_add_cloumn_private_to_webinars_table', 66);
INSERT INTO `migrations` VALUES (184, '2021_02_18_213601_edit_rates_column_webinar_reviews_table', 67);
INSERT INTO `migrations` VALUES (188, '2021_02_27_212131_create_noticeboards_table', 68);
INSERT INTO `migrations` VALUES (189, '2021_02_27_213940_create_noticeboards_status_table', 68);
INSERT INTO `migrations` VALUES (191, '2021_02_28_195025_edit_groups_table', 69);
INSERT INTO `migrations` VALUES (192, '2021_03_06_205221_create_newsletters_table', 70);
INSERT INTO `migrations` VALUES (193, '2021_03_12_105526_add_is_main_column_to_roles_table', 71);
INSERT INTO `migrations` VALUES (194, '2021_03_12_202441_add_description_column_to_feature_webinars_table', 72);
INSERT INTO `migrations` VALUES (195, '2021_03_18_130248_edit_status_column_from_supports_table', 73);
INSERT INTO `migrations` VALUES (196, '2021_03_19_113306_add_column_order_to_categories_table', 74);
INSERT INTO `migrations` VALUES (197, '2021_03_19_115939_add_column_order_to_filter_options_table', 75);
INSERT INTO `migrations` VALUES (199, '2021_03_24_100005_edit_discounts_table', 76);
INSERT INTO `migrations` VALUES (200, '2021_03_27_204551_create_sales_status_table', 77);
INSERT INTO `migrations` VALUES (202, '2021_03_28_182558_add_column_page_to_settings_table', 78);
INSERT INTO `migrations` VALUES (206, '2021_03_31_195835_add_new_status_in_reserve_meetings_table', 79);
INSERT INTO `migrations` VALUES (207, '2020_12_12_204705_create_course_learning_table', 80);
INSERT INTO `migrations` VALUES (208, '2021_04_19_195452_add_meta_description_column_to_blog_table', 81);
INSERT INTO `migrations` VALUES (209, '2021_04_21_200131_add_icon_column_to_categories_table', 82);
INSERT INTO `migrations` VALUES (210, '2021_04_21_203746_add_is_popular_column_to_subscribes_table', 83);
INSERT INTO `migrations` VALUES (211, '2021_04_25_203955_add_is_charge_account_column_to_order_items', 84);
INSERT INTO `migrations` VALUES (212, '2021_04_25_203955_add_is_charge_account_column_to_orders', 85);
INSERT INTO `migrations` VALUES (213, '2021_05_13_111720_add_moderator_secret_column_to_sessions_table', 86);
INSERT INTO `migrations` VALUES (214, '2021_05_13_123920_add_zoom_id_column_to_sessions_table', 87);
INSERT INTO `migrations` VALUES (215, '2021_05_14_182848_create_session_reminds_table', 88);
INSERT INTO `migrations` VALUES (217, '2021_05_25_193743_create_users_zoom_api_table', 89);
INSERT INTO `migrations` VALUES (218, '2021_05_25_205716_add_new_column_to_sessions_table', 90);
INSERT INTO `migrations` VALUES (219, '2021_05_27_095128_add_user_id_to_newsletters_table', 91);
INSERT INTO `migrations` VALUES (220, '2020_12_27_192459_create_pages_table', 92);
INSERT INTO `migrations` VALUES (221, '2021_07_03_222439_add_special_offer_id_to_cart_table', 93);
INSERT INTO `migrations` VALUES (222, '2021_09_02_101422_add_payment_data_to_orders_table', 94);
INSERT INTO `migrations` VALUES (223, '2021_09_02_110519_add_sender_id_to_notifications_table', 95);
INSERT INTO `migrations` VALUES (224, '2021_09_06_113524_create_webinar_chapters_table', 96);
INSERT INTO `migrations` VALUES (228, '2021_09_06_114459_add_chapter_id_to_files_table', 97);
INSERT INTO `migrations` VALUES (229, '2021_09_06_114532_add_chapter_id_to_text_lessons_table', 97);
INSERT INTO `migrations` VALUES (230, '2021_09_06_114547_add_chapter_id_to_sessions_table', 97);
INSERT INTO `migrations` VALUES (231, '2021_09_13_134659_add_chapter_id_to_quizzes_table', 98);
INSERT INTO `migrations` VALUES (234, '2021_09_14_122505_create_affiliates_table', 100);
INSERT INTO `migrations` VALUES (235, '2021_09_14_122117_create_affiliates_codes_table', 101);
INSERT INTO `migrations` VALUES (239, '2021_09_14_142927_add_affiliate_column_to_users_table', 105);
INSERT INTO `migrations` VALUES (241, '2021_09_14_142302_add_affiliate_column_to_accounting_table', 106);
INSERT INTO `migrations` VALUES (244, '2021_09_18_155914_create_blog_translations_table', 107);
INSERT INTO `migrations` VALUES (246, '2021_09_19_190400_create_page_translations_table', 108);
INSERT INTO `migrations` VALUES (248, '2021_09_19_203526_create_setting_translations_table', 109);
INSERT INTO `migrations` VALUES (250, '2021_09_20_140241_create_advertising_banners_translations_table', 110);
INSERT INTO `migrations` VALUES (252, '2021_09_20_175518_create_category_translations_table', 111);
INSERT INTO `migrations` VALUES (255, '2021_09_20_184724_create_filter_translations_table', 112);
INSERT INTO `migrations` VALUES (256, '2021_09_20_185132_create_filter_option_translations_table', 112);
INSERT INTO `migrations` VALUES (258, '2021_09_21_160650_create_subscribe_translations_table', 113);
INSERT INTO `migrations` VALUES (260, '2021_09_21_162922_create_promotion_translations_table', 114);
INSERT INTO `migrations` VALUES (262, '2021_09_21_164954_create_testimonial_translations_table', 115);
INSERT INTO `migrations` VALUES (264, '2021_09_21_182251_create_feature_webinar_translations_table', 116);
INSERT INTO `migrations` VALUES (266, '2021_09_21_184239_create_certificate_template_translations_table', 117);
INSERT INTO `migrations` VALUES (268, '2021_09_21_195731_create_support_department_translations_table', 118);
INSERT INTO `migrations` VALUES (270, '2021_09_21_201512_create_badge_translations_table', 119);
INSERT INTO `migrations` VALUES (272, '2021_09_22_120723_create_webinar_translations_table', 120);
INSERT INTO `migrations` VALUES (274, '2021_09_22_135518_create_ticket_translations_table', 121);
INSERT INTO `migrations` VALUES (276, '2021_09_22_144342_create_webinar_chapter_translations_table', 122);
INSERT INTO `migrations` VALUES (278, '2021_09_22_162502_create_session_translations_table', 123);
INSERT INTO `migrations` VALUES (280, '2021_09_22_172309_create_file_translations_table', 124);
INSERT INTO `migrations` VALUES (282, '2021_09_22_173500_create_faq_translations_table', 125);
INSERT INTO `migrations` VALUES (284, '2021_09_23_094903_create_text_lesson_translations_table', 126);
INSERT INTO `migrations` VALUES (286, '2021_09_27_194537_create_quiz_translations_table', 127);
INSERT INTO `migrations` VALUES (288, '2021_09_28_112529_create_quiz_question_translations_table', 128);
INSERT INTO `migrations` VALUES (290, '2021_09_28_122513_create_quizzes_questions_answer_translations_table', 129);
INSERT INTO `migrations` VALUES (291, '2021_12_03_103010_add_agora_session_api_to_sessions_table', 130);
INSERT INTO `migrations` VALUES (292, '2021_12_03_103558_add_agora_to_sessions_table', 131);
INSERT INTO `migrations` VALUES (293, '2021_12_03_114009_create_agora_history_table', 132);
INSERT INTO `migrations` VALUES (295, '2021_12_04_183524_create_regions_table', 133);
INSERT INTO `migrations` VALUES (298, '2021_12_25_151304_add_new_column_to_meetings_table', 135);
INSERT INTO `migrations` VALUES (299, '2021_12_26_142304_add_new_column_to_meeting_times_table', 136);
INSERT INTO `migrations` VALUES (302, '2022_01_01_162247_add_new_column_to_reserve_meetings_table', 137);
INSERT INTO `migrations` VALUES (305, '2022_01_02_142927_create_rewards_table', 138);
INSERT INTO `migrations` VALUES (307, '2022_01_03_153517_create_rewards_accounting_table', 139);
INSERT INTO `migrations` VALUES (308, '2022_01_04_161756_add_score_column_to_badges_table', 140);
INSERT INTO `migrations` VALUES (309, '2022_01_04_165147_add_points_column_to_webinars_table', 141);
INSERT INTO `migrations` VALUES (312, '2022_01_08_154504_edit_storage_column_and_add_new_value_to_files_table', 142);
INSERT INTO `migrations` VALUES (313, '2022_01_11_162839_add_timezone_column_to_users_table', 143);
INSERT INTO `migrations` VALUES (314, '2022_01_12_142238_add_timezone_column_to_webinars_table', 144);
INSERT INTO `migrations` VALUES (315, '2022_01_15_131828_create_registration_packages_table', 145);
INSERT INTO `migrations` VALUES (319, '2022_01_15_203133_edit_columns_in_accounting_table', 146);
INSERT INTO `migrations` VALUES (320, '2022_01_16_102825_edit_columns_in_order_items_table', 147);
INSERT INTO `migrations` VALUES (321, '2022_01_17_152605_add_registration_package_id_to_sales_table', 148);
INSERT INTO `migrations` VALUES (322, '2022_01_18_103414_create_users_registration_packages_table', 149);
INSERT INTO `migrations` VALUES (323, '2022_01_18_113331_create_groups_registration_packages_table', 150);
INSERT INTO `migrations` VALUES (325, '2022_01_20_110119_add_become_instructor_id_column_to_order_items_table', 152);
INSERT INTO `migrations` VALUES (326, '2022_01_18_160228_add_column_role_to_become_instructors_table', 153);
INSERT INTO `migrations` VALUES (327, '2022_01_26_080434_add_reserve_date_columns_to_reserve_meetings_table', 154);
INSERT INTO `migrations` VALUES (328, '2022_01_28_094259_edit_column_in_discounts_table', 155);
INSERT INTO `migrations` VALUES (329, '2022_01_28_094515_create_discount_courses_table', 155);
INSERT INTO `migrations` VALUES (330, '2022_01_28_094527_create_discount_groups_table', 155);
INSERT INTO `migrations` VALUES (331, '2022_01_31_093231_add_column_description_to_meeting_times_table', 156);
INSERT INTO `migrations` VALUES (332, '2022_01_31_093306_add_column_description_to_reserve_meetings_table', 156);
INSERT INTO `migrations` VALUES (334, '2022_02_01_092922_create_newsletters_history_table', 157);
INSERT INTO `migrations` VALUES (335, '2022_02_01_104529_create_discount_categories_table', 158);
INSERT INTO `migrations` VALUES (337, '2022_02_02_092820_add_attachment_column_to_offline_payments_table', 159);
INSERT INTO `migrations` VALUES (339, '2022_02_02_184235_add_column_video_demo_source_to_webinars_table', 160);
INSERT INTO `migrations` VALUES (340, '2021_12_05_193333_add_new_column_to_users_table', 161);
INSERT INTO `migrations` VALUES (341, '2022_02_27_072819_add_forign_key_for_region_to_users_table', 162);
INSERT INTO `migrations` VALUES (347, '2022_03_05_123830_create_product_categories_table', 163);
INSERT INTO `migrations` VALUES (348, '2022_03_05_125138_create_product_filters_table', 163);
INSERT INTO `migrations` VALUES (350, '2022_03_06_091528_create_product_filter_options_table', 163);
INSERT INTO `migrations` VALUES (351, '2022_03_07_081257_create_product_specifications_table', 164);
INSERT INTO `migrations` VALUES (353, '2022_03_07_081808_create_product_specification_categories_table', 165);
INSERT INTO `migrations` VALUES (357, '2022_03_05_125434_create_products_table', 166);
INSERT INTO `migrations` VALUES (358, '2022_03_07_093128_create_product_discounts_table', 166);
INSERT INTO `migrations` VALUES (362, '2022_03_08_101832_create_product_media_table', 167);
INSERT INTO `migrations` VALUES (363, '2022_03_09_054031_create_product_selected_filter_options_table', 168);
INSERT INTO `migrations` VALUES (364, '2022_03_09_083337_create_product_specification_meta_table', 169);
INSERT INTO `migrations` VALUES (369, '2022_03_09_084108_create_product_selected_specifications_table', 170);
INSERT INTO `migrations` VALUES (370, '2022_03_09_140558_create_product_faqs_table', 171);
INSERT INTO `migrations` VALUES (374, '2022_03_11_180436_create_product_reviews_table', 174);
INSERT INTO `migrations` VALUES (375, '2022_03_11_182715_add_product_id_to_comments_reports_table', 175);
INSERT INTO `migrations` VALUES (376, '2022_03_08_094452_create_product_files_table', 176);
INSERT INTO `migrations` VALUES (377, '2022_03_11_180746_add_product_id_to_comments_table', 177);
INSERT INTO `migrations` VALUES (378, '2022_03_12_102233_add_new_position_to_advertising_banners_table', 178);
INSERT INTO `migrations` VALUES (383, '2022_03_13_072108_add_product_id_to_sales_table', 179);
INSERT INTO `migrations` VALUES (385, '2022_03_13_081212_create_product_orders_table', 180);
INSERT INTO `migrations` VALUES (386, '2022_03_19_171559_create_product_selected_specification_translations_table', 181);
INSERT INTO `migrations` VALUES (387, '2022_03_21_161055_add_create_store_column_to_users_table', 182);
INSERT INTO `migrations` VALUES (388, '2022_03_26_065509_add_new_type_to_rewards_table', 183);
INSERT INTO `migrations` VALUES (389, '2022_03_28_051949_add_product_count_column_to_registration_packages_table', 184);
INSERT INTO `migrations` VALUES (391, '2022_03_28_054322_add_product_type_column_to_discounts_table', 185);
INSERT INTO `migrations` VALUES (392, '2022_03_28_062248_edit_type_column_of_rewards_accounting_table', 186);
INSERT INTO `migrations` VALUES (393, '2022_03_28_083906_edit_type_column_to_badges_table', 187);
INSERT INTO `migrations` VALUES (394, '2022_04_02_051515_create_webinar_chapter_items_table', 188);
INSERT INTO `migrations` VALUES (395, '2022_04_02_085059_remove_type_column_from_webinar_chapters_table', 189);
INSERT INTO `migrations` VALUES (396, '2022_04_02_131352_add_check_sequence_content_fields_to_contents_tables', 190);
INSERT INTO `migrations` VALUES (399, '2022_04_04_075541_add_assignment_type_to_webinar_chapter_items_table', 192);
INSERT INTO `migrations` VALUES (400, '2022_04_04_071203_create_webinar_assignments_table', 193);
INSERT INTO `migrations` VALUES (401, '2022_04_04_071303_create_webinar_assignment_attachments_table', 193);
INSERT INTO `migrations` VALUES (405, '2022_04_05_053308_create_webinar_assignment_history_table', 194);
INSERT INTO `migrations` VALUES (406, '2022_04_05_060030_create_webinar_assignment_history_messages_table', 194);
INSERT INTO `migrations` VALUES (407, '2022_04_06_121240_add_new_type_passed_assignment_to_rewards_table', 195);
INSERT INTO `migrations` VALUES (408, '2022_04_09_064609_add_access_content_column_to_users_table', 196);
INSERT INTO `migrations` VALUES (409, '2022_04_10_073822_create_bundles_table', 197);
INSERT INTO `migrations` VALUES (410, '2022_04_10_092348_create_bundle_filter_option_table', 198);
INSERT INTO `migrations` VALUES (413, '2022_04_10_130733_create_bundle_webinars_table', 200);
INSERT INTO `migrations` VALUES (421, '2022_04_10_093457_add_bundle_id_to_needle_tables', 201);
INSERT INTO `migrations` VALUES (422, '2022_04_12_153052_add_access_time_to_webinars_table', 202);
INSERT INTO `migrations` VALUES (423, '2022_04_13_053947_create_course_noticeboards_table', 203);
INSERT INTO `migrations` VALUES (424, '2022_04_13_054536_create_course_noticeboard_status_table', 203);
INSERT INTO `migrations` VALUES (425, '2022_04_13_130155_add_column_forum_to_webinars_table', 204);
INSERT INTO `migrations` VALUES (427, '2022_04_14_060606_create_course_forums_table', 205);
INSERT INTO `migrations` VALUES (428, '2022_04_14_063316_create_course_forum_answers_table', 206);
INSERT INTO `migrations` VALUES (447, '2022_04_21_133513_add_new_type_in_rewards_table', 216);
INSERT INTO `migrations` VALUES (448, '2022_04_21_135212_add_new_type_in_badges_table', 217);
INSERT INTO `migrations` VALUES (449, '2022_04_24_081637_add_new_type_instructor_blog_in_rewards_table', 218);
INSERT INTO `migrations` VALUES (450, '2022_04_24_082515_add_new_type_instructor_blog_in_badges_table', 219);
INSERT INTO `migrations` VALUES (452, '2022_04_25_043945_create_users_cookie_security_table', 220);
INSERT INTO `migrations` VALUES (453, '2022_04_25_143142_add_organization_price__column_to_webinars_table', 221);
INSERT INTO `migrations` VALUES (454, '2022_04_25_165256_add_image_and_video_to_quizzes_questions_table', 222);
INSERT INTO `migrations` VALUES (456, '2022_04_26_060018_edit_certificates_templates_table', 223);
INSERT INTO `migrations` VALUES (458, '2022_04_26_082017_edit_certificates_table', 224);
INSERT INTO `migrations` VALUES (459, '2022_04_26_155421_create_subscribe_reminds_table', 225);
INSERT INTO `migrations` VALUES (460, '2022_04_26_163428_add_instructor_id_to_noticeboards_table', 226);
INSERT INTO `migrations` VALUES (461, '2022_04_27_133655_add_unlimited_download_to_subscribes_table', 227);
INSERT INTO `migrations` VALUES (462, '2022_04_27_133655_add_infinite_use_to_subscribes_table', 228);
INSERT INTO `migrations` VALUES (463, '2022_04_27_140844_add_extra_time_to_join_to_sessions_table', 229);
INSERT INTO `migrations` VALUES (464, '2022_04_28_052318_create_webinar_extra_description_table', 230);
INSERT INTO `migrations` VALUES (466, '2022_05_09_125820_create_navbar_buttons_table', 232);
INSERT INTO `migrations` VALUES (467, '2021_06_07_000000_create_payku_transactions_table', 233);
INSERT INTO `migrations` VALUES (468, '2021_06_07_000001_create_payku_payments_table', 233);
INSERT INTO `migrations` VALUES (469, '2021_11_30_122831_create_jazzcash_transactions_table', 233);
INSERT INTO `migrations` VALUES (470, '2021_12_15_000000_add_new_columns_to_tables', 233);
INSERT INTO `migrations` VALUES (471, '2022_05_23_081324_create_product_specification_multi_values_table', 234);
INSERT INTO `migrations` VALUES (472, '2022_05_23_091527_create_product_selected_specification_multi_values_table', 235);
INSERT INTO `migrations` VALUES (475, '2022_05_23_151601_add_product_delivery_fee_column_to_sales_table', 236);
INSERT INTO `migrations` VALUES (476, '2022_04_18_103856_create_forums_table', 237);
INSERT INTO `migrations` VALUES (477, '2022_04_18_152201_create_forum_topics_table', 237);
INSERT INTO `migrations` VALUES (478, '2022_04_18_152845_create_forum_topic_attachments_table', 237);
INSERT INTO `migrations` VALUES (479, '2022_04_19_071911_create_forum_topic_posts_table', 237);
INSERT INTO `migrations` VALUES (480, '2022_04_19_123745_create_forum_topic_reports_table', 237);
INSERT INTO `migrations` VALUES (481, '2022_04_19_135314_create_forum_topic_bookmarks_table', 237);
INSERT INTO `migrations` VALUES (482, '2022_04_19_152929_create_forum_topic_likes_table', 237);
INSERT INTO `migrations` VALUES (483, '2022_04_20_152756_create_forum_featured_topics_table', 237);
INSERT INTO `migrations` VALUES (484, '2022_04_21_054043_create_forum_recommended_topics_table', 237);
INSERT INTO `migrations` VALUES (485, '2022_04_21_054815_create_forum_recommended_topic_items_table', 237);
INSERT INTO `migrations` VALUES (486, '2022_05_26_085212_change_some_column_varchar_to_text', 238);
INSERT INTO `migrations` VALUES (487, '2022_05_27_142612_add_avarat_settings_to_users_table', 239);
INSERT INTO `migrations` VALUES (489, '2022_05_01_151107_add_manual_added_column_to_sales_table', 240);
INSERT INTO `migrations` VALUES (490, '2022_05_29_162315_create_delete_account_requests_table', 241);
INSERT INTO `migrations` VALUES (491, '2020_10_20_211927_create_users_metas_table', 242);
INSERT INTO `migrations` VALUES (492, '2022_05_31_133347_add_certificate_column_to_webinars_table', 243);
INSERT INTO `migrations` VALUES (494, '2022_05_31_165839_add_online_viewer_column_to_files_table', 244);
INSERT INTO `migrations` VALUES (495, '2022_06_08_071712_create_home_sections_table', 245);
INSERT INTO `migrations` VALUES (496, '2022_10_14_074434_add_reserve_meeting_id_to_sessions_table', 246);
INSERT INTO `migrations` VALUES (497, '2022_12_25_082946_add_logged_count_column_to_users_table', 247);
INSERT INTO `migrations` VALUES (498, '2022_12_26_064214_add_new_column_to_quizzes_table', 247);
INSERT INTO `migrations` VALUES (499, '2022_12_27_064800_add_column_url_to_categories_table', 247);
INSERT INTO `migrations` VALUES (500, '2023_01_02_085731_create_upcoming_courses_table', 248);
INSERT INTO `migrations` VALUES (501, '2023_01_09_065436_create_installments_table', 249);
INSERT INTO `migrations` VALUES (502, '2023_01_14_144421_create_installment_orders_table', 250);
INSERT INTO `migrations` VALUES (503, '2023_01_18_064141_create_floating_bars_table', 251);
INSERT INTO `migrations` VALUES (504, '2023_01_18_145605_create_cashback_rules_table', 252);
INSERT INTO `migrations` VALUES (505, '2023_01_21_075422_add_column_to_accounting_table', 253);
INSERT INTO `migrations` VALUES (506, '2023_01_24_141128_create_currencies_table', 254);
INSERT INTO `migrations` VALUES (507, '2023_01_25_090622_add_currency_column_to_users', 254);
INSERT INTO `migrations` VALUES (508, '2023_01_25_104531_edit_price_column_tables', 254);
INSERT INTO `migrations` VALUES (509, '2023_01_25_145647_add_column_to_payment_channels_table', 254);
INSERT INTO `migrations` VALUES (510, '2023_01_29_074044_create_installment_reminders_table', 255);
INSERT INTO `migrations` VALUES (511, '2023_02_06_135446_add_new_columns_to_special_offers_table', 256);
INSERT INTO `migrations` VALUES (512, '2023_02_07_141617_create_discount_bundles_table', 257);
INSERT INTO `migrations` VALUES (513, '2023_02_07_152101_add_new_columns_to_users_zoom_api_table', 258);
INSERT INTO `migrations` VALUES (514, '2023_02_08_140023_create_home_page_statistics_table', 259);
INSERT INTO `migrations` VALUES (515, '2023_02_11_135759_add_enable_waitlist_column_to_webinars_table', 260);
INSERT INTO `migrations` VALUES (516, '2023_02_11_144743_create_waitlists_table', 261);
INSERT INTO `migrations` VALUES (518, '2023_02_13_134648_create_offline_banks_table', 262);
INSERT INTO `migrations` VALUES (520, '2023_02_14_144003_create_user_banks_table', 263);
INSERT INTO `migrations` VALUES (523, '2023_02_15_140227_create_test_table', 264);
INSERT INTO `migrations` VALUES (524, '2023_02_15_151458_add_new_storage_to_files_table', 265);
INSERT INTO `migrations` VALUES (528, '2023_02_20_141047_create_gifts_table', 266);
INSERT INTO `migrations` VALUES (529, '2023_02_27_065823_add_enable_registration_bonus_to_users_table', 267);
INSERT INTO `migrations` VALUES (530, '2023_03_05_075231_add_installment_order_id_to_accounting_table', 267);
INSERT INTO `migrations` VALUES (531, '2023_03_08_095345_edit_payouts_table', 268);
INSERT INTO `migrations` VALUES (532, '2023_03_10_143238_edit_column_in_quizzes_table', 269);
INSERT INTO `migrations` VALUES (533, '2023_03_12_110714_edit_column_in_order_items_table', 270);
INSERT INTO `migrations` VALUES (534, '2023_03_13_120634_edit_price_column_in_promotions_table', 271);
INSERT INTO `migrations` VALUES (535, '2023_03_13_135747_add_price_column_to_installment_orders_table', 271);
INSERT INTO `migrations` VALUES (536, '2023_04_11_142125_create_courses_table', 272);
INSERT INTO `migrations` VALUES (537, '2023_04_19_145636_create_attendances_table', 272);
INSERT INTO `migrations` VALUES (538, '2023_04_19_160033_create_attendance_translations_table', 272);
INSERT INTO `migrations` VALUES (539, '2023_05_04_132034_edit_type_in_webinars_table', 272);
INSERT INTO `migrations` VALUES (540, '2023_05_10_193922_create_interested_course_table', 272);
INSERT INTO `migrations` VALUES (541, '2023_05_10_195453_create_interested_courses_translations_table', 272);
INSERT INTO `migrations` VALUES (542, '2023_05_04_132034_edit_type_in_webinars_table', 272);

-- ----------------------------
-- Table structure for navbar_button_translations
-- ----------------------------
DROP TABLE IF EXISTS `navbar_button_translations`;
CREATE TABLE `navbar_button_translations`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `navbar_button_id` int UNSIGNED NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `navbar_button_translations_navbar_button_id_foreign`(`navbar_button_id`) USING BTREE,
  INDEX `navbar_button_translations_locale_index`(`locale`) USING BTREE,
  CONSTRAINT `navbar_button_translations_navbar_button_id_foreign` FOREIGN KEY (`navbar_button_id`) REFERENCES `navbar_buttons` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of navbar_button_translations
-- ----------------------------

-- ----------------------------
-- Table structure for navbar_buttons
-- ----------------------------
DROP TABLE IF EXISTS `navbar_buttons`;
CREATE TABLE `navbar_buttons`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `role_id` int UNSIGNED NULL DEFAULT NULL,
  `for_guest` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `navbar_buttons_role_id_foreign`(`role_id`) USING BTREE,
  CONSTRAINT `navbar_buttons_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of navbar_buttons
-- ----------------------------

-- ----------------------------
-- Table structure for newsletters
-- ----------------------------
DROP TABLE IF EXISTS `newsletters`;
CREATE TABLE `newsletters`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int UNSIGNED NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of newsletters
-- ----------------------------

-- ----------------------------
-- Table structure for newsletters_history
-- ----------------------------
DROP TABLE IF EXISTS `newsletters_history`;
CREATE TABLE `newsletters_history`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `send_method` enum('send_to_all','send_to_bcc','send_to_excel') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `bcc_email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `email_count` int NULL DEFAULT NULL,
  `created_at` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of newsletters_history
-- ----------------------------

-- ----------------------------
-- Table structure for noticeboards
-- ----------------------------
DROP TABLE IF EXISTS `noticeboards`;
CREATE TABLE `noticeboards`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `organ_id` int UNSIGNED NULL DEFAULT NULL,
  `instructor_id` int UNSIGNED NULL DEFAULT NULL,
  `webinar_id` int UNSIGNED NULL DEFAULT NULL,
  `user_id` int UNSIGNED NULL DEFAULT NULL,
  `type` enum('all','organizations','students','instructors','students_and_instructors') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `sender` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `noticeboards_organ_id_foreign`(`organ_id`) USING BTREE,
  INDEX `noticeboards_user_id_foreign`(`user_id`) USING BTREE,
  INDEX `noticeboards_instructor_id_foreign`(`instructor_id`) USING BTREE,
  INDEX `noticeboards_webinar_id_foreign`(`webinar_id`) USING BTREE,
  CONSTRAINT `noticeboards_instructor_id_foreign` FOREIGN KEY (`instructor_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `noticeboards_organ_id_foreign` FOREIGN KEY (`organ_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `noticeboards_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `noticeboards_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of noticeboards
-- ----------------------------

-- ----------------------------
-- Table structure for noticeboards_status
-- ----------------------------
DROP TABLE IF EXISTS `noticeboards_status`;
CREATE TABLE `noticeboards_status`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int UNSIGNED NOT NULL,
  `noticeboard_id` int UNSIGNED NOT NULL,
  `seen_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `noticeboards_status_noticeboard_id_foreign`(`noticeboard_id`) USING BTREE,
  CONSTRAINT `noticeboards_status_noticeboard_id_foreign` FOREIGN KEY (`noticeboard_id`) REFERENCES `noticeboards` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of noticeboards_status
-- ----------------------------

-- ----------------------------
-- Table structure for notification_templates
-- ----------------------------
DROP TABLE IF EXISTS `notification_templates`;
CREATE TABLE `notification_templates`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `template` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 120 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of notification_templates
-- ----------------------------
INSERT INTO `notification_templates` VALUES (2, 'new badge', '<p>You received [u.b.title]&nbsp;badge</p>');
INSERT INTO `notification_templates` VALUES (3, 'Change user group', '<p>your group change to [u.g.title]</p>');
INSERT INTO `notification_templates` VALUES (4, 'Course created', '<p>you create new course&nbsp;with Title [c.title]</p>');
INSERT INTO `notification_templates` VALUES (5, 'Course approve', '<p>your course with title [c.title] approved</p>');
INSERT INTO `notification_templates` VALUES (6, 'Course rejection', '<p>Your course with title [c.title] rejected</p>');
INSERT INTO `notification_templates` VALUES (7, 'New comment', '<p>user [u.name] add new comment fro course with title [c.title]</p>');
INSERT INTO `notification_templates` VALUES (8, 'New support message', '<p>user [u.name] send new support message for course with title [c.title]</p>');
INSERT INTO `notification_templates` VALUES (9, 'support message replied', '<p>support message replied fro course [c.title]</p>');
INSERT INTO `notification_templates` VALUES (10, 'New support for admin', '<p>send new support&nbsp; ticket with title&nbsp;[s.t.title]</p>');
INSERT INTO `notification_templates` VALUES (11, 'support ticket replied for admin', '<p>replied support&nbsp; ticket with title&nbsp;[s.t.title]</p>');
INSERT INTO `notification_templates` VALUES (12, 'New financial document', '<p>&nbsp;New financial document for course [c.title] with type [f.d.type] with price [amount]</p>');
INSERT INTO `notification_templates` VALUES (13, 'Payout request', '<p>payout request with amount&nbsp; [payout.amount]</p>');
INSERT INTO `notification_templates` VALUES (14, 'Payout proceed', 'Payout with amount [payout.amount]&nbsp;&nbsp;proceed by account [payout.account]');
INSERT INTO `notification_templates` VALUES (15, 'New sales', '<p>new sale for course with title [c.title]</p>');
INSERT INTO `notification_templates` VALUES (16, 'New purchase', '<p>new purchase for course with title [c.title]</p>');
INSERT INTO `notification_templates` VALUES (17, 'Rating (Feedback)', '<p>new feedback submitted for course with title [c.title] bu student [student.name] and rate [rate.count]</p>');
INSERT INTO `notification_templates` VALUES (18, 'Offline payment request', '<p>Offline payment request with amount [amount]</p>');
INSERT INTO `notification_templates` VALUES (19, 'Offline payment approved', '<p>Offline payment request with amount [amount]&nbsp;approved</p>');
INSERT INTO `notification_templates` VALUES (20, 'Offline payment rejected', '<p>Offline payment request with amount [amount]&nbsp;rejected</p>');
INSERT INTO `notification_templates` VALUES (21, 'New subscribe plan', '<p>New subscribe plan activated by user [u.name] for plan [s.p.name]</p>');
INSERT INTO `notification_templates` VALUES (22, 'New appointment', '<p>New appointment booked by user [u.name] in time [time.date] with price&nbsp;[amount]</p>');
INSERT INTO `notification_templates` VALUES (23, 'New appointment link', '<p>appointment&nbsp; link defined by the [instructor.name]. time [time.date] and link is [link]</p>');
INSERT INTO `notification_templates` VALUES (24, 'Appointment reminder', '<p>You have an appointment on [time.date]</p>');
INSERT INTO `notification_templates` VALUES (25, 'Meeting finished', '<p>meeting finished instructor : [instructor.name] and student :&nbsp; [student.name] and time : [time.date]</p>');
INSERT INTO `notification_templates` VALUES (26, 'New contact message', '<p>New contact message with title [c.u.title] and user name [u.name] recived</p>');
INSERT INTO `notification_templates` VALUES (27, 'Webinar reminder', '<p>Webinar reminder time [time.date] webinar title [c.title]</p>');
INSERT INTO `notification_templates` VALUES (28, 'Promotion plan', '<p>plan [p.p.name]&nbsp;&nbsp;activated for course [c.title]</p>');
INSERT INTO `notification_templates` VALUES (29, 'Promotion plan for admin', '<p>new request promotion plan [p.p.name] for course [c.title]</p>');
INSERT INTO `notification_templates` VALUES (30, 'Certificate', '<p>certificate recived for course [c.title]</p>');
INSERT INTO `notification_templates` VALUES (31, 'Waiting quiz', '<p>student [student.name]&nbsp; waiting for quiz [q.title] for course [c.title]</p>');
INSERT INTO `notification_templates` VALUES (32, 'Waiting quiz result', '<p>course [c.title]&nbsp;calculated quiz [q.title] result [q.result] by instructor</p>');
INSERT INTO `notification_templates` VALUES (33, 'product new sale', '<p>new sale for product with title [p.title]</p>');
INSERT INTO `notification_templates` VALUES (34, 'Product New purchase', '<p>new purchase for product with title [p.title]</p>');
INSERT INTO `notification_templates` VALUES (35, 'Product New comment', '<p>user [u.name] add new comment fro product with title [p.title]</p>');
INSERT INTO `notification_templates` VALUES (36, 'Product tracking code', '<p>user [u.name] add tracking code for product with title [p.title]</p>');
INSERT INTO `notification_templates` VALUES (37, 'Product Rating (Feedback)', '<p>new feedback submitted for product with title [p.title] by user [u.name] and rate [rate.count]</p>');
INSERT INTO `notification_templates` VALUES (38, 'Product receive shipment', '<p>user [u.name] received product with title [p.title]</p>');
INSERT INTO `notification_templates` VALUES (39, 'Product out of stock', '<p>The product inventory ended with the title [p.title]</p>');
INSERT INTO `notification_templates` VALUES (40, 'Send assignment by the student to the instructor', '<p>[student.name] send assignment for course by title [c.title]</p>');
INSERT INTO `notification_templates` VALUES (41, 'when the instructor sends a message for assignment', '<p>[instructor.name] send message for course by title [c.title]</p>');
INSERT INTO `notification_templates` VALUES (42, 'assignment grade', '<p>The [instructor.name]&nbsp;gave you a grade of [assignment_grade]&nbsp;for course by title [c.title]</p>');
INSERT INTO `notification_templates` VALUES (43, 'user access to content', '<p>Your access to content is enabled.</p>');
INSERT INTO `notification_templates` VALUES (44, 'Send post in topic', '<p>[u.name] send post in your topic with title [topic_title]&nbsp;</p>');
INSERT INTO `notification_templates` VALUES (45, 'publish instructor blog post', '<p>your post with title [blog_title] published.</p>');
INSERT INTO `notification_templates` VALUES (46, 'new comment for instructor blog', '<p>user [u.name] add new comment for your blog with title [blog_title]</p>');
INSERT INTO `notification_templates` VALUES (47, 'Meeting reminder', '<p>Meeting reminder time [time.date] with instructor by name [instructor.name]</p>');
INSERT INTO `notification_templates` VALUES (48, 'subscribe expire reminder', '<p>Your subscribe has been expired in&nbsp;[time.date]</p>');
INSERT INTO `notification_templates` VALUES (49, 'Course Forum new Question', '<p>[u.name] registered a question in the [c.title]&nbsp;course forum.</p>');
INSERT INTO `notification_templates` VALUES (50, 'New answer in course forum', '<p>[u.name] registered a answer in the [c.title]&nbsp;course forum.</p>');
INSERT INTO `notification_templates` VALUES (52, 'You received a gift', '<p>[u.name]&nbsp;sent you [gift_title] which is a [gift_type]&nbsp;as a gift with the following message: [gift_message]</p>');
INSERT INTO `notification_templates` VALUES (53, 'Gift submitted successfully', '<p>Your gift request for [u.name]&nbsp;submitted successfully on [time.date]&nbsp;and the [gift_title] which is a [gift_type]&nbsp;at [amount]&nbsp;will be sent to the recipient on [time.date.2]&nbsp;with the following message: [gift_message]</p>');
INSERT INTO `notification_templates` VALUES (54, 'Gift sent to recipient', '<p>We sent the gift request that you submitted on [time.date]&nbsp;for [u.name]. We sent [gift_title]&nbsp;which is a [gift_type]&nbsp;to the recipient with the following message on [time.date] . [gift_message]</p>');
INSERT INTO `notification_templates` VALUES (55, 'Gift request submitted (Admin)', '<p>[u.name.2] submitted a gift request for [gift_title]&nbsp;which is a [gift_type]&nbsp;for [u.name]&nbsp;on [time.date]&nbsp;at [amount]&nbsp;and it will be sent to the recipient on [time.date.2]</p>');
INSERT INTO `notification_templates` VALUES (56, 'Gift sent to recipient (Admin)', '<p>The system sent a [gift_title]&nbsp;which is a [gift_type]&nbsp;to [u.name]&nbsp;on [time.date.2]&nbsp;successfully. [u.name.2]&nbsp;submitted this request on [time.date]&nbsp;at [amount].</p>');
INSERT INTO `notification_templates` VALUES (57, 'You have an upcoming installment', '<p>You have an installment for [installment_title] at [amount]&nbsp;on due date [time.date]</p>');
INSERT INTO `notification_templates` VALUES (58, 'You have an unpaid installment', '<p>You have an installment for [installment_title]&nbsp;at [amount]&nbsp;for today. Please pay it as soon as possible.</p>');
INSERT INTO `notification_templates` VALUES (59, 'You have an overdue installment', '<p>You have an overdue installment for [installment_title]&nbsp;at [amount]&nbsp;on due date [time.date].</p>');
INSERT INTO `notification_templates` VALUES (60, 'Installment verification request approved', '<p>Your verification request for [installment_title]&nbsp;approved.</p>');
INSERT INTO `notification_templates` VALUES (61, 'Installment verification request rejected', '<p>Your verification request for [installment_title]&nbsp;rejected.</p>');
INSERT INTO `notification_templates` VALUES (62, 'Installment paid successfully', '<p>You paid [amount]&nbsp;for [installment_title]&nbsp;with due date [time.date]&nbsp;successfully.</p>');
INSERT INTO `notification_templates` VALUES (63, 'Installment paid successfully (Admin)', '<p>[u.name] paid [amount]&nbsp;for [installment_title]&nbsp;with the due date [time.date]&nbsp;successfully.</p>');
INSERT INTO `notification_templates` VALUES (64, 'Installment upfront amount paid', '<p>You paid [amount] as upfront for&nbsp;[installment_title].</p>');
INSERT INTO `notification_templates` VALUES (65, 'Installment verification request submitted', '<p>We received your verification request for [installment_title]&nbsp;on [time.date]&nbsp;and the result will be informed to you soon.</p>');
INSERT INTO `notification_templates` VALUES (66, 'Installment verification request submitted (Admin)', '<p>[u.name] submitted a verification request for [installment_title]&nbsp;on [time.date].</p>');
INSERT INTO `notification_templates` VALUES (67, 'Installment request submitted', '<p>Your installment for [installment_title]&nbsp;at [amount]&nbsp;submitted successfully.</p>');
INSERT INTO `notification_templates` VALUES (68, 'Installment request submitted (Admin)', '<p>[u.name] submitted an installment request for [installment_title]&nbsp;at [amount].</p>');
INSERT INTO `notification_templates` VALUES (69, 'New upcoming course submitted', '<p>Your upcoming course [item_title]&nbsp;submitted successfully.</p>');
INSERT INTO `notification_templates` VALUES (70, 'New upcoming course submitted (Admin)', '<p>[u.name] submitted an upcoming course with title [item_title].</p>');
INSERT INTO `notification_templates` VALUES (71, 'Upcoming course approved', '<p>Your upcoming course [item_title]&nbsp;approved.</p>');
INSERT INTO `notification_templates` VALUES (72, 'Upcoming course rejected', '<p>Your upcoming course [item_title] rejected.</p>');
INSERT INTO `notification_templates` VALUES (73, 'Your upcoming course published', '<p>Your upcoming course [item_title]&nbsp;published.</p>');
INSERT INTO `notification_templates` VALUES (74, 'Your upcoming course followed', '<p>[u.name] followed your upcoming course [item_title]</p>');
INSERT INTO `notification_templates` VALUES (75, 'Upcoming course published and is accessible', '<p>The upcoming course [item_title] published now and you can check it.</p>');
INSERT INTO `notification_templates` VALUES (76, 'You got cashback!', '<p>You got [amount]&nbsp;as cashback and this amount added to your account.</p>');
INSERT INTO `notification_templates` VALUES (77, 'User got cashback (Admin)', '<p>[u.name] got [amount] as cashback and this amount charged to their account.</p>');
INSERT INTO `notification_templates` VALUES (78, 'Bundle submitted successfully', '<p>Your bundle with the title [item_title]&nbsp;submitted successfully.</p>');
INSERT INTO `notification_templates` VALUES (79, 'Bundle submitted (Admin)', '<p>[u.name] submitted a bundle with the title [item_title].</p>');
INSERT INTO `notification_templates` VALUES (80, 'Bundle published successfully', '<p>Your bundle with title [item_title]&nbsp;published successfully.</p>');
INSERT INTO `notification_templates` VALUES (81, 'Bundle rejected', '<p>Your bundle with title [item_title]&nbsp;rejected.</p>');
INSERT INTO `notification_templates` VALUES (82, 'New review for your bundle', '<p>[u.name] submitted a [rate.count] star rating for your bundle [item_title].</p>');
INSERT INTO `notification_templates` VALUES (83, 'You got registration bonus', '<p>You got [amount]&nbsp;as registration bonus.</p>');
INSERT INTO `notification_templates` VALUES (84, 'Registration bonus unlocked', '<p>Your registration bonus [amount]&nbsp;unlocked.</p>');
INSERT INTO `notification_templates` VALUES (85, 'Registration bonus unlocked (Admin)', '<p>The registration bonus [amount] is unlocked for [u.name].</p>');
INSERT INTO `notification_templates` VALUES (86, 'SaaS package activated successfully', '<p>[item_title] activated for you until [time.date].</p>');
INSERT INTO `notification_templates` VALUES (87, 'SaaS package activated (Admin)', '<p>[u.name] activated [item_title]&nbsp;registration plan until [time.date].</p>');
INSERT INTO `notification_templates` VALUES (88, 'Your contact message submitted', '<p>We received your contact message with the subject [c.u.title]&nbsp;on time.date].</p>');
INSERT INTO `notification_templates` VALUES (89, 'New contact message received', '<p>New contact message received from [u.name] with subject [c.u.title] with message [c.u.message]</p>');
INSERT INTO `notification_templates` VALUES (90, 'You submitted to waitlist', '<p>You submitted to [c.title]&nbsp;waitlist.</p>');
INSERT INTO `notification_templates` VALUES (91, 'User submitted in waitlist', '<p>[u.name] submitted to [c.title]&nbsp;waitlist.</p>');
INSERT INTO `notification_templates` VALUES (92, 'New user registered with your affiliate code', '<p>[u.name] registered with your affiliate code on [time.date].</p>');
INSERT INTO `notification_templates` VALUES (93, 'New quiz added to course', '<p>New quiz with the title [q.title]&nbsp;added to the course [c.title].</p>');
INSERT INTO `notification_templates` VALUES (94, 'New reward point', '<p>You get [points]&nbsp;for [item_title]&nbsp;on [time.date]</p>');
INSERT INTO `notification_templates` VALUES (95, 'New notice', '<p>You got a new notice with title [c.title]&nbsp;on [time.date]</p>');
INSERT INTO `notification_templates` VALUES (96, 'New course notice', '<p>You got a new course notice for [c.title]&nbsp;with title [item_title]</p>');
INSERT INTO `notification_templates` VALUES (97, 'Your user role changed', '<p>Your user role changed to [u.role]</p>');
INSERT INTO `notification_templates` VALUES (98, 'New user group', '<p>You added to [u.g.title] user group.</p>');
INSERT INTO `notification_templates` VALUES (99, 'Become instructor/organization request approved', '<p>Your become instructor/organization request is approved.</p>');
INSERT INTO `notification_templates` VALUES (100, 'Become instructor/organization request rejected', '<p>Your instructor/organization request rejected</p>');
INSERT INTO `notification_templates` VALUES (101, 'New question in course forum', '<p>[u.name] posted a new question in [c.title] forum.</p>');
INSERT INTO `notification_templates` VALUES (102, 'New answer in course forum', '<p>[u.name] posted a new answer in [c.title] forum.</p>');
INSERT INTO `notification_templates` VALUES (103, 'Live meeting created', '<p>[instructor.name] started a new live meeting. Please login to your account and join it now...</p>');
INSERT INTO `notification_templates` VALUES (104, 'New user registered', '<p>[u.name] registered on the platform on [time.date]&nbsp;as [u.role]</p>');
INSERT INTO `notification_templates` VALUES (105, 'New instructor/organization request', '<p>[u.name] submit a user role change request on [time.date]</p>');
INSERT INTO `notification_templates` VALUES (106, 'New course enrollment', '<p>[u.name] enrolled in [c.title]&nbsp;on [time.date]&nbsp;at [amount]</p>');
INSERT INTO `notification_templates` VALUES (107, 'New forum topic', '<p>[u.name] created a new topic with title [topic_title]&nbsp;in [forum_title]&nbsp;forum.</p>');
INSERT INTO `notification_templates` VALUES (108, 'New report', '<p>[u.name] sent a content review for revising.</p>');
INSERT INTO `notification_templates` VALUES (109, 'New item created', '<p>[u.name] created a new item with title [item_title]</p>');
INSERT INTO `notification_templates` VALUES (110, 'New store order', '<p>New store order received from [u.name]&nbsp;at [amount]</p>');
INSERT INTO `notification_templates` VALUES (111, 'Subscription plan activated', '<p>[u.name] purchased [s.p.name]&nbsp;at [amount]</p>');
INSERT INTO `notification_templates` VALUES (112, 'Content review request', '<p>[u.name] sent a review request for [item_title]</p>');
INSERT INTO `notification_templates` VALUES (113, 'New user blog post', '<p>[u.name] submitted a blog article with title [blog_title]</p>');
INSERT INTO `notification_templates` VALUES (114, 'New item review (Rating)', '<p>[u.name] submitted a new rate for [item_title]</p>');
INSERT INTO `notification_templates` VALUES (115, 'New organization user', '<p>[organization.name] submitted [u.name]&nbsp;as new [u.role]</p>');
INSERT INTO `notification_templates` VALUES (116, 'User wallet charge', '<p>[u.name] charged their wallet for [amount]</p>');
INSERT INTO `notification_templates` VALUES (117, 'New payout request', '<p>[u.name] submitted a new payout request for [amount]</p>');
INSERT INTO `notification_templates` VALUES (118, 'New offline payment request', '<p>[u.name] submitted a new offline payment request at [amount]</p>');
INSERT INTO `notification_templates` VALUES (119, 'Content access approval', '<p>Your content access request approved. You can access all courses now...</p>');

-- ----------------------------
-- Table structure for notifications
-- ----------------------------
DROP TABLE IF EXISTS `notifications`;
CREATE TABLE `notifications`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int UNSIGNED NULL DEFAULT NULL,
  `sender_id` int UNSIGNED NULL DEFAULT NULL,
  `group_id` int UNSIGNED NULL DEFAULT NULL,
  `webinar_id` int UNSIGNED NULL DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `sender` enum('system','admin') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'system',
  `type` enum('single','all_users','students','instructors','organizations','group','course_students') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `notifications_user_id_foreign`(`user_id`) USING BTREE,
  INDEX `notifications_group_id_foreign`(`group_id`) USING BTREE,
  INDEX `webinar_id`(`webinar_id`) USING BTREE,
  CONSTRAINT `notifications_group_id_foreign` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `notifications_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2296 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of notifications
-- ----------------------------
INSERT INTO `notifications` VALUES (1, 1016, NULL, NULL, NULL, 'Course created', '<p>you create new course&nbsp;with Title Sample Course</p>', 'system', 'single', 1656669533);
INSERT INTO `notifications` VALUES (2, 1016, NULL, NULL, NULL, 'Course approve', '<p>your course with title Sample Course approved</p>', 'system', 'single', 1656669564);
INSERT INTO `notifications` VALUES (2185, 1, NULL, NULL, NULL, 'New reward point', '<p>You get 20&nbsp;for Course Completion&nbsp;on 12 abr. 2023 05:16 p. m.</p>', 'system', 'single', 1681334168);
INSERT INTO `notifications` VALUES (2186, 1016, NULL, NULL, NULL, 'Course approve', '<p>your course with title Curso básico de desarrollo approved</p>', 'system', 'single', 1681405704);
INSERT INTO `notifications` VALUES (2187, 1016, NULL, NULL, NULL, 'New reward point', '<p>You get 50&nbsp;for Publishing a Course&nbsp;on 13 abr. 2023 01:08 p. m.</p>', 'system', 'single', 1681405704);
INSERT INTO `notifications` VALUES (2188, 1016, NULL, NULL, NULL, 'Course approve', '<p>your course with title Curso básico de desarrollo approved</p>', 'system', 'single', 1681405962);
INSERT INTO `notifications` VALUES (2189, 1016, NULL, NULL, NULL, 'Course approve', '<p>your course with title Curso básico de desarrollo approved</p>', 'system', 'single', 1681417087);
INSERT INTO `notifications` VALUES (2190, 1016, NULL, NULL, NULL, 'Course approve', '<p>your course with title Curso básico de desarrollo approved</p>', 'system', 'single', 1681417154);
INSERT INTO `notifications` VALUES (2191, 1016, NULL, NULL, NULL, 'Course approve', '<p>your course with title Curso básico de desarrollo approved</p>', 'system', 'single', 1681417331);
INSERT INTO `notifications` VALUES (2192, 1016, NULL, NULL, NULL, 'Course approve', '<p>your course with title Curso básico de desarrollo approved</p>', 'system', 'single', 1681418770);
INSERT INTO `notifications` VALUES (2193, 1016, NULL, NULL, NULL, 'Course approve', '<p>your course with title Curso básico de desarrollo approved</p>', 'system', 'single', 1681420365);
INSERT INTO `notifications` VALUES (2194, 1016, NULL, NULL, NULL, 'Change user group', '<p>your group change to Dev Zeros School</p>', 'system', 'single', 1681486947);
INSERT INTO `notifications` VALUES (2195, 1016, NULL, NULL, NULL, 'New user group', '<p>You added to Dev Zeros School user group.</p>', 'system', 'single', 1681486947);
INSERT INTO `notifications` VALUES (2196, 1016, NULL, NULL, NULL, 'Course approve', '<p>your course with title Curso básico de desarrollo approved</p>', 'system', 'single', 1681487631);
INSERT INTO `notifications` VALUES (2197, 1016, NULL, NULL, NULL, 'Course approve', '<p>your course with title CURSO BÁSICO DE DESARROLLO approved</p>', 'system', 'single', 1681488009);
INSERT INTO `notifications` VALUES (2198, 1016, NULL, NULL, NULL, 'Course approve', '<p>your course with title CURSO BÁSICO DE DESARROLLO approved</p>', 'system', 'single', 1681490569);
INSERT INTO `notifications` VALUES (2199, 1016, NULL, NULL, NULL, 'Course approve', '<p>your course with title BOOTCAMP .NET CORE y REACT approved</p>', 'system', 'single', 1681490971);
INSERT INTO `notifications` VALUES (2200, 1016, NULL, NULL, NULL, 'New reward point', '<p>You get 50&nbsp;for Publishing a Course&nbsp;on 14 abr. 2023 11:49 a. m.</p>', 'system', 'single', 1681490971);
INSERT INTO `notifications` VALUES (2201, 1016, NULL, NULL, NULL, 'Course approve', '<p>your course with title BOOTCAMP .NET CORE & REACT approved</p>', 'system', 'single', 1681491372);
INSERT INTO `notifications` VALUES (2202, 1016, NULL, NULL, NULL, 'Course approve', '<p>your course with title BOOTCAMP .NET CORE & REACT approved</p>', 'system', 'single', 1681492687);
INSERT INTO `notifications` VALUES (2203, 1016, NULL, NULL, NULL, 'Course approve', '<p>your course with title BOOTCAMP .NET CORE & REACT approved</p>', 'system', 'single', 1681492747);
INSERT INTO `notifications` VALUES (2204, 1016, NULL, NULL, NULL, 'Course approve', '<p>your course with title BOOTCAMP .NET CORE & REACT approved</p>', 'system', 'single', 1681492773);
INSERT INTO `notifications` VALUES (2205, 1016, NULL, NULL, NULL, 'Course approve', '<p>your course with title BOOTCAMP .NET CORE & REACT approved</p>', 'system', 'single', 1681492818);
INSERT INTO `notifications` VALUES (2206, 1016, NULL, NULL, NULL, 'Course approve', '<p>your course with title BOOTCAMP .NET CORE & REACT approved</p>', 'system', 'single', 1681497786);
INSERT INTO `notifications` VALUES (2207, 1016, NULL, NULL, NULL, 'Course approve', '<p>your course with title BOOTCAMP .NET CORE AND REACT approved</p>', 'system', 'single', 1681501043);
INSERT INTO `notifications` VALUES (2208, 1016, NULL, NULL, NULL, 'Course approve', '<p>your course with title CURSO BÁSICO DE DESARROLLO approved</p>', 'system', 'single', 1681501190);
INSERT INTO `notifications` VALUES (2209, 1016, NULL, NULL, NULL, 'Course approve', '<p>your course with title BOOTCAMP .NET CORE AND REACT approved</p>', 'system', 'single', 1681518780);
INSERT INTO `notifications` VALUES (2210, 1016, NULL, NULL, NULL, 'Course approve', '<p>your course with title BOOTCAMP .NET CORE AND REACT approved</p>', 'system', 'single', 1682085086);
INSERT INTO `notifications` VALUES (2211, 1016, NULL, NULL, NULL, 'Course approve', '<p>your course with title Programación Para Niños approved</p>', 'system', 'single', 1683236783);
INSERT INTO `notifications` VALUES (2212, 1016, NULL, NULL, NULL, 'New reward point', '<p>You get 50&nbsp;for Publishing a Course&nbsp;on 4 may. 2023 04:46 p. m.</p>', 'system', 'single', 1683236783);
INSERT INTO `notifications` VALUES (2213, 1016, NULL, NULL, NULL, 'Course approve', '<p>your course with title Programación Para Niños approved</p>', 'system', 'single', 1683236818);
INSERT INTO `notifications` VALUES (2214, 1016, NULL, NULL, NULL, 'Course approve', '<p>your course with title Programación Para Niños approved</p>', 'system', 'single', 1683236884);
INSERT INTO `notifications` VALUES (2215, 1016, NULL, NULL, NULL, 'Course approve', '<p>your course with title PROGRAMACIÓN PARA NIÑOS approved</p>', 'system', 'single', 1683238084);
INSERT INTO `notifications` VALUES (2216, 1016, NULL, NULL, NULL, 'Course approve', '<p>your course with title Programación Para Niños approved</p>', 'system', 'single', 1683238165);
INSERT INTO `notifications` VALUES (2217, 1016, NULL, NULL, NULL, 'Course approve', '<p>your course with title Programación Para Niños approved</p>', 'system', 'single', 1683248720);
INSERT INTO `notifications` VALUES (2218, 1016, NULL, NULL, NULL, 'Course approve', '<p>your course with title Programación Para Niños approved</p>', 'system', 'single', 1683248740);
INSERT INTO `notifications` VALUES (2219, 1016, NULL, NULL, NULL, 'Course approve', '<p>your course with title Programación Para Niños approved</p>', 'system', 'single', 1683252241);
INSERT INTO `notifications` VALUES (2220, 1, NULL, NULL, NULL, 'New user registered', '<p>Ronlad Castro registered on the platform on 9 may. 2023 01:31 p. m.&nbsp;as Student</p>', 'system', 'single', 1683657091);
INSERT INTO `notifications` VALUES (2221, 1, NULL, NULL, NULL, 'New user registered', '<p>Carlos registered on the platform on 9 may. 2023 01:56 p. m.&nbsp;as Student</p>', 'system', 'single', 1683658619);
INSERT INTO `notifications` VALUES (2222, 1, NULL, NULL, NULL, 'New user registered', '<p>Carlos Manuel registered on the platform on 9 may. 2023 01:57 p. m.&nbsp;as Student</p>', 'system', 'single', 1683658673);
INSERT INTO `notifications` VALUES (2223, 1, NULL, NULL, NULL, 'New user registered', '<p>Ronlad Castro registered on the platform on 9 may. 2023 04:23 p. m.&nbsp;as Student</p>', 'system', 'single', 1683667382);
INSERT INTO `notifications` VALUES (2224, 1, NULL, NULL, NULL, 'New user registered', '<p>Ronlad Castro registered on the platform on 9 may. 2023 04:25 p. m.&nbsp;as Student</p>', 'system', 'single', 1683667559);
INSERT INTO `notifications` VALUES (2225, 1, NULL, NULL, NULL, 'New user registered', '<p>Ronlad Castro registered on the platform on 9 may. 2023 04:32 p. m.&nbsp;as Student</p>', 'system', 'single', 1683667943);
INSERT INTO `notifications` VALUES (2226, 1, NULL, NULL, NULL, 'New user registered', '<p>Ronlad Castro registered on the platform on 9 may. 2023 04:33 p. m.&nbsp;as Student</p>', 'system', 'single', 1683668010);
INSERT INTO `notifications` VALUES (2227, 1, NULL, NULL, NULL, 'New user registered', '<p>Ronlad Castro registered on the platform on 9 may. 2023 04:57 p. m.&nbsp;as Student</p>', 'system', 'single', 1683669458);
INSERT INTO `notifications` VALUES (2229, 1055, NULL, NULL, NULL, 'New user group', '<p>You added to Dev Zeros School user group.</p>', 'system', 'single', 1684174239);
INSERT INTO `notifications` VALUES (2230, 1016, NULL, NULL, NULL, 'Course approve', '<p>your course with title PROGRAMACIÓN PARA NIÑOS approved</p>', 'system', 'single', 1684176164);
INSERT INTO `notifications` VALUES (2231, 1055, NULL, NULL, NULL, 'Course approve', '<p>your course with title BOOTCAMP PRUEBAS TDD, DDD Y FUNCIONALES approved</p>', 'system', 'single', 1684176201);
INSERT INTO `notifications` VALUES (2232, 1055, NULL, NULL, NULL, 'New reward point', '<p>You get 50&nbsp;for Publishing a Course&nbsp;on 15 may. 2023 01:43 p. m.</p>', 'system', 'single', 1684176202);
INSERT INTO `notifications` VALUES (2233, 1055, NULL, NULL, NULL, 'Course approve', '<p>your course with title BOOTCAMP PRUEBAS TDD, DDD Y FUNCIONALES approved</p>', 'system', 'single', 1684176270);
INSERT INTO `notifications` VALUES (2234, 1055, NULL, NULL, NULL, 'Course approve', '<p>your course with title BOOTCAMP PRUEBAS TDD, DDD Y FUNCIONALES approved</p>', 'system', 'single', 1684178005);
INSERT INTO `notifications` VALUES (2235, 1055, NULL, NULL, NULL, 'Course approve', '<p>your course with title BOOTCAMP PRUEBAS TDD, DDD Y FUNCIONALES approved</p>', 'system', 'single', 1684178717);
INSERT INTO `notifications` VALUES (2236, 1055, NULL, NULL, NULL, 'Course approve', '<p>your course with title BOOTCAMP PRUEBAS TDD, DDD Y FUNCIONALES approved</p>', 'system', 'single', 1684178927);
INSERT INTO `notifications` VALUES (2237, 1055, NULL, NULL, NULL, 'Course approve', '<p>your course with title BOOTCAMP PRUEBAS TDD, DDD Y FUNCIONALES approved</p>', 'system', 'single', 1684179056);
INSERT INTO `notifications` VALUES (2238, 1055, NULL, NULL, NULL, 'Course approve', '<p>your course with title BOOTCAMP PRUEBAS TDD, DDD Y FUNCIONALES approved</p>', 'system', 'single', 1684179149);
INSERT INTO `notifications` VALUES (2239, 1055, NULL, NULL, NULL, 'Course approve', '<p>your course with title BOOTCAMP PRUEBAS TDD, DDD Y FUNCIONALES approved</p>', 'system', 'single', 1684179203);
INSERT INTO `notifications` VALUES (2240, 1055, NULL, NULL, NULL, 'Course approve', '<p>your course with title BOOTCAMP PRUEBAS TDD, DDD Y FUNCIONALES approved</p>', 'system', 'single', 1684179383);
INSERT INTO `notifications` VALUES (2241, 1055, NULL, NULL, NULL, 'Course approve', '<p>your course with title BOOTCAMP PRUEBAS TDD, DDD Y FUNCIONALES approved</p>', 'system', 'single', 1684180022);
INSERT INTO `notifications` VALUES (2242, 1055, NULL, NULL, NULL, 'Course approve', '<p>your course with title BOOTCAMP PRUEBAS TDD, DDD Y FUNCIONALES approved</p>', 'system', 'single', 1684180077);
INSERT INTO `notifications` VALUES (2243, 1055, NULL, NULL, NULL, 'Course approve', '<p>your course with title BOOTCAMP PRUEBAS TDD, DDD Y FUNCIONALES approved</p>', 'system', 'single', 1684180343);
INSERT INTO `notifications` VALUES (2244, 1055, NULL, NULL, NULL, 'Course approve', '<p>your course with title BOOTCAMP PRUEBAS TDD, DDD Y FUNCIONALES approved</p>', 'system', 'single', 1684184956);
INSERT INTO `notifications` VALUES (2245, 1055, NULL, NULL, NULL, 'Course approve', '<p>your course with title BOOTCAMP PRUEBAS TDD, DDD Y FUNCIONALES approved</p>', 'system', 'single', 1684187944);
INSERT INTO `notifications` VALUES (2246, 1055, NULL, NULL, NULL, 'Course approve', '<p>your course with title BOOTCAMP PRUEBAS TDD, DDD Y FUNCIONALES approved</p>', 'system', 'single', 1684188637);
INSERT INTO `notifications` VALUES (2247, 1055, NULL, NULL, NULL, 'Course approve', '<p>your course with title BOOTCAMP PRUEBAS TDD, DDD Y FUNCIONALES approved</p>', 'system', 'single', 1684189091);
INSERT INTO `notifications` VALUES (2248, 1055, NULL, NULL, NULL, 'Course approve', '<p>your course with title BOOTCAMP PRUEBAS TDD, DDD Y FUNCIONALES approved</p>', 'system', 'single', 1684358217);
INSERT INTO `notifications` VALUES (2249, 1016, NULL, NULL, NULL, 'Course approve', '<p>your course with title CURSO BÁSICO DE DESARROLLO approved</p>', 'system', 'single', 1684358356);
INSERT INTO `notifications` VALUES (2250, 1055, NULL, NULL, NULL, 'Course approve', '<p>your course with title BOOTCAMP PRUEBAS TDD, DDD Y FUNCIONALES approved</p>', 'system', 'single', 1684360302);
INSERT INTO `notifications` VALUES (2251, 1055, NULL, NULL, NULL, 'Course approve', '<p>your course with title BOOTCAMP PRUEBAS TDD, DDD Y FUNCIONALES approved</p>', 'system', 'single', 1684360433);
INSERT INTO `notifications` VALUES (2252, 1055, NULL, NULL, NULL, 'Course approve', '<p>your course with title BOOTCAMP PRUEBAS TDD Y FUNCIONALES CON DDD approved</p>', 'system', 'single', 1684422567);
INSERT INTO `notifications` VALUES (2253, 1055, NULL, NULL, NULL, 'Course approve', '<p>your course with title BOOTCAMP PRUEBAS TDD Y FUNCIONALES CON DDD approved</p>', 'system', 'single', 1684428240);
INSERT INTO `notifications` VALUES (2254, 1, NULL, NULL, NULL, 'New user registered', '<p>Yulieth Paola Esquea Muñoz registered on the platform on 19 may. 2023 05:15 p. m.&nbsp;as Estudiante</p>', 'system', 'single', 1684534505);
INSERT INTO `notifications` VALUES (2256, 1, NULL, NULL, NULL, 'New user registered', '<p>carlos andrés castilla garcía registered on the platform on 20 may. 2023 11:47 a. m.&nbsp;as Estudiante</p>', 'system', 'single', 1684601236);
INSERT INTO `notifications` VALUES (2258, 1055, NULL, NULL, NULL, 'Course approve', '<p>your course with title BOOTCAMP PRUEBAS TDD Y FUNCIONALES CON DDD approved</p>', 'system', 'single', 1684601579);
INSERT INTO `notifications` VALUES (2259, 1, NULL, NULL, NULL, 'New user registered', '<p>Eduardo Luis Zequeira Gutierrez registered on the platform on 24 may. 2023 09:41 a. m.&nbsp;as Estudiante</p>', 'system', 'single', 1684939284);
INSERT INTO `notifications` VALUES (2261, 1, NULL, NULL, NULL, 'New user registered', '<p>Aaa registered on the platform on 29 may. 2023 02:43 a. m.&nbsp;as Estudiante</p>', 'system', 'single', 1685346209);
INSERT INTO `notifications` VALUES (2263, 1, NULL, NULL, NULL, 'New user registered', '<p>Jairo Tapia registered on the platform on 9 jun. 2023 05:52 p. m.&nbsp;as Estudiante</p>', 'system', 'single', 1686351177);
INSERT INTO `notifications` VALUES (2264, 1060, NULL, NULL, NULL, 'New reward point', '<p>You get 5&nbsp;for Registration&nbsp;on 9 jun. 2023 05:53 p. m.</p>', 'system', 'single', 1686351209);
INSERT INTO `notifications` VALUES (2265, 1, NULL, NULL, NULL, 'New user registered', '<p>Jhonys Andrés Suárez registered on the platform on 9 jun. 2023 07:57 p. m.&nbsp;as Estudiante</p>', 'system', 'single', 1686358648);
INSERT INTO `notifications` VALUES (2266, 1061, NULL, NULL, NULL, 'New reward point', '<p>You get 5&nbsp;for Registration&nbsp;on 9 jun. 2023 08:04 p. m.</p>', 'system', 'single', 1686359086);
INSERT INTO `notifications` VALUES (2267, 1, NULL, NULL, NULL, 'New user registered', '<p>Eduardo Luis Zequeira Gutierrez registered on the platform on 10 jun. 2023 09:50 p. m.&nbsp;as Estudiante</p>', 'system', 'single', 1686451851);
INSERT INTO `notifications` VALUES (2268, 1062, NULL, NULL, NULL, 'New reward point', '<p>You get 5&nbsp;for Registration&nbsp;on 10 jun. 2023 09:53 p. m.</p>', 'system', 'single', 1686451980);
INSERT INTO `notifications` VALUES (2269, 1055, NULL, NULL, NULL, 'Course approve', '<p>your course with title CURSO BÁSICO DE DESARROLLO approved</p>', 'system', 'single', 1686953445);
INSERT INTO `notifications` VALUES (2270, 1055, NULL, NULL, NULL, 'New reward point', '<p>You get 50&nbsp;for Publishing a Course&nbsp;on 16 jun. 2023 05:10 p. m.</p>', 'system', 'single', 1686953447);
INSERT INTO `notifications` VALUES (2271, 1055, NULL, NULL, NULL, 'Course approve', '<p>your course with title CURSO BÁSICO DE DESARROLLO approved</p>', 'system', 'single', 1686954330);
INSERT INTO `notifications` VALUES (2272, 1, NULL, NULL, NULL, 'New user registered', '<p>Eduardo Luis Zequeira Gutierrez registered on the platform on 17 jun. 2023 10:00 a. m.&nbsp;as Estudiante</p>', 'system', 'single', 1687014021);
INSERT INTO `notifications` VALUES (2273, 1063, NULL, NULL, NULL, 'New reward point', '<p>You get 5&nbsp;for Registration&nbsp;on 17 jun. 2023 10:00 a. m.</p>', 'system', 'single', 1687014043);
INSERT INTO `notifications` VALUES (2274, 1, NULL, NULL, NULL, 'New user registered', '<p>Henry Uriel Rojas Vanegas registered on the platform on 22 jun. 2023 09:42 p. m.&nbsp;as Estudiante</p>', 'system', 'single', 1687488173);
INSERT INTO `notifications` VALUES (2275, 1064, NULL, NULL, NULL, 'New reward point', '<p>You get 5&nbsp;for Registration&nbsp;on 22 jun. 2023 09:43 p. m.</p>', 'system', 'single', 1687488198);
INSERT INTO `notifications` VALUES (2276, 1, NULL, NULL, NULL, 'New user registered', '<p>carlos andrés castilla garcía registered on the platform on 13 jul. 2023 07:36 p. m.&nbsp;as Estudiante</p>', 'system', 'single', 1689295012);
INSERT INTO `notifications` VALUES (2277, 1065, NULL, NULL, NULL, 'New reward point', '<p>You get 5&nbsp;for Registration&nbsp;on 13 jul. 2023 07:37 p. m.</p>', 'system', 'single', 1689295027);
INSERT INTO `notifications` VALUES (2278, 1066, NULL, NULL, NULL, 'New user group', '<p>You added to Dev Zeros School user group.</p>', 'system', 'single', 1692022793);
INSERT INTO `notifications` VALUES (2279, 1066, NULL, NULL, NULL, 'Your user role changed', '<p>Your user role changed to Instructor role</p>', 'system', 'single', 1692022916);
INSERT INTO `notifications` VALUES (2280, 1066, NULL, NULL, NULL, 'Course approve', '<p>your course with title DISEÑO UX/UI approved</p>', 'system', 'single', 1692024728);
INSERT INTO `notifications` VALUES (2281, 1066, NULL, NULL, NULL, 'New reward point', '<p>You get 50&nbsp;for Publishing a Course&nbsp;on 14 ago. 2023 09:52 a. m.</p>', 'system', 'single', 1692024729);
INSERT INTO `notifications` VALUES (2282, 1066, NULL, NULL, NULL, 'Course approve', '<p>your course with title DISEÑO UX/UI approved</p>', 'system', 'single', 1692028355);
INSERT INTO `notifications` VALUES (2283, 1066, NULL, NULL, NULL, 'Course approve', '<p>your course with title DISEÑO UX/UI approved</p>', 'system', 'single', 1692028409);
INSERT INTO `notifications` VALUES (2284, 1066, NULL, NULL, NULL, 'Course approve', '<p>your course with title DISEÑO UX/UI approved</p>', 'system', 'single', 1692028521);
INSERT INTO `notifications` VALUES (2285, 1055, NULL, NULL, NULL, 'Course approve', '<p>your course with title CURSO BÁSICO DE DESARROLLO approved</p>', 'system', 'single', 1692028593);
INSERT INTO `notifications` VALUES (2286, 1066, NULL, NULL, NULL, 'Course approve', '<p>your course with title DISEÑO UX/UI Y MAQUETACIÓN WEB approved</p>', 'system', 'single', 1692028938);
INSERT INTO `notifications` VALUES (2287, 1067, NULL, NULL, NULL, 'New user group', '<p>You added to Dev Zeros School user group.</p>', 'system', 'single', 1692029748);
INSERT INTO `notifications` VALUES (2288, 1067, NULL, NULL, NULL, 'Course approve', '<p>your course with title CURSO DESARROLLO WEB FULL STACK approved</p>', 'system', 'single', 1692032148);
INSERT INTO `notifications` VALUES (2289, 1067, NULL, NULL, NULL, 'New reward point', '<p>You get 50&nbsp;for Publishing a Course&nbsp;on 14 ago. 2023 11:55 a. m.</p>', 'system', 'single', 1692032150);
INSERT INTO `notifications` VALUES (2290, 1016, NULL, NULL, NULL, 'Course approve', '<p>your course with title PROGRAMACIÓN PARA NIÑOS approved</p>', 'system', 'single', 1692036418);
INSERT INTO `notifications` VALUES (2291, 1066, NULL, NULL, NULL, 'Course approve', '<p>your course with title DISEÑO UX/UI Y MAQUETACIÓN WEB approved</p>', 'system', 'single', 1692036497);
INSERT INTO `notifications` VALUES (2292, 1, NULL, NULL, NULL, 'New user registered', '<p>Jeiner Robles Noguera registered on the platform on 24 ago. 2023 10:11 a. m.&nbsp;as Estudiante</p>', 'system', 'single', 1692889890);
INSERT INTO `notifications` VALUES (2293, 1068, NULL, NULL, NULL, 'New reward point', '<p>You get 5&nbsp;for Registration&nbsp;on 24 ago. 2023 10:12 a. m.</p>', 'system', 'single', 1692889937);
INSERT INTO `notifications` VALUES (2294, 1, NULL, NULL, NULL, 'New user registered', '<p>Diego Alejandro Villa Galvis registered on the platform on 30 ago. 2023 02:51 p. m.&nbsp;as Estudiante</p>', 'system', 'single', 1693425103);
INSERT INTO `notifications` VALUES (2295, 1069, NULL, NULL, NULL, 'New reward point', '<p>You get 5&nbsp;for Registration&nbsp;on 30 ago. 2023 02:52 p. m.</p>', 'system', 'single', 1693425124);

-- ----------------------------
-- Table structure for notifications_status
-- ----------------------------
DROP TABLE IF EXISTS `notifications_status`;
CREATE TABLE `notifications_status`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int UNSIGNED NOT NULL,
  `notification_id` int UNSIGNED NOT NULL,
  `seen_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `notifications_status_notification_id_foreign`(`notification_id`) USING BTREE,
  CONSTRAINT `notifications_status_notification_id_foreign` FOREIGN KEY (`notification_id`) REFERENCES `notifications` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 405 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of notifications_status
-- ----------------------------
INSERT INTO `notifications_status` VALUES (342, 1, 2185, 1681395349);
INSERT INTO `notifications_status` VALUES (344, 1016, 2249, 1684358460);
INSERT INTO `notifications_status` VALUES (345, 1016, 2230, 1684358460);
INSERT INTO `notifications_status` VALUES (346, 1016, 2219, 1684358460);
INSERT INTO `notifications_status` VALUES (347, 1016, 2218, 1684358460);
INSERT INTO `notifications_status` VALUES (348, 1016, 2217, 1684358460);
INSERT INTO `notifications_status` VALUES (349, 1016, 2216, 1684358460);
INSERT INTO `notifications_status` VALUES (350, 1016, 2215, 1684358460);
INSERT INTO `notifications_status` VALUES (351, 1016, 2214, 1684358460);
INSERT INTO `notifications_status` VALUES (352, 1016, 2213, 1684358460);
INSERT INTO `notifications_status` VALUES (353, 1016, 2211, 1684358460);
INSERT INTO `notifications_status` VALUES (354, 1016, 2212, 1684358460);
INSERT INTO `notifications_status` VALUES (355, 1016, 2210, 1684358460);
INSERT INTO `notifications_status` VALUES (356, 1016, 2209, 1684358460);
INSERT INTO `notifications_status` VALUES (357, 1016, 2208, 1684358460);
INSERT INTO `notifications_status` VALUES (358, 1016, 2207, 1684358460);
INSERT INTO `notifications_status` VALUES (359, 1016, 2206, 1684358460);
INSERT INTO `notifications_status` VALUES (360, 1016, 2205, 1684358460);
INSERT INTO `notifications_status` VALUES (361, 1016, 2204, 1684358460);
INSERT INTO `notifications_status` VALUES (362, 1016, 2203, 1684358460);
INSERT INTO `notifications_status` VALUES (363, 1016, 2202, 1684358460);
INSERT INTO `notifications_status` VALUES (364, 1016, 2201, 1684358460);
INSERT INTO `notifications_status` VALUES (365, 1016, 2199, 1684358460);
INSERT INTO `notifications_status` VALUES (366, 1016, 2200, 1684358460);
INSERT INTO `notifications_status` VALUES (367, 1016, 2198, 1684358460);
INSERT INTO `notifications_status` VALUES (368, 1016, 2197, 1684358460);
INSERT INTO `notifications_status` VALUES (369, 1016, 2196, 1684358460);
INSERT INTO `notifications_status` VALUES (370, 1016, 2194, 1684358460);
INSERT INTO `notifications_status` VALUES (371, 1016, 2195, 1684358460);
INSERT INTO `notifications_status` VALUES (372, 1016, 2193, 1684358460);
INSERT INTO `notifications_status` VALUES (373, 1016, 2192, 1684358460);
INSERT INTO `notifications_status` VALUES (374, 1016, 2191, 1684358460);
INSERT INTO `notifications_status` VALUES (375, 1016, 2190, 1684358460);
INSERT INTO `notifications_status` VALUES (376, 1016, 2189, 1684358460);
INSERT INTO `notifications_status` VALUES (377, 1016, 2188, 1684358460);
INSERT INTO `notifications_status` VALUES (378, 1016, 2186, 1684358460);
INSERT INTO `notifications_status` VALUES (379, 1016, 2187, 1684358460);
INSERT INTO `notifications_status` VALUES (380, 1016, 2, 1684358460);
INSERT INTO `notifications_status` VALUES (381, 1016, 1, 1684358460);
INSERT INTO `notifications_status` VALUES (385, 1060, 2264, 1686351252);
INSERT INTO `notifications_status` VALUES (386, 1062, 2268, 1686452036);
INSERT INTO `notifications_status` VALUES (387, 1, 2276, 1692024557);
INSERT INTO `notifications_status` VALUES (388, 1, 2274, 1692024557);
INSERT INTO `notifications_status` VALUES (389, 1, 2272, 1692024557);
INSERT INTO `notifications_status` VALUES (390, 1, 2267, 1692024557);
INSERT INTO `notifications_status` VALUES (391, 1, 2265, 1692024557);
INSERT INTO `notifications_status` VALUES (392, 1, 2263, 1692024557);
INSERT INTO `notifications_status` VALUES (393, 1, 2261, 1692024557);
INSERT INTO `notifications_status` VALUES (394, 1, 2259, 1692024557);
INSERT INTO `notifications_status` VALUES (395, 1, 2256, 1692024557);
INSERT INTO `notifications_status` VALUES (396, 1, 2254, 1692024557);
INSERT INTO `notifications_status` VALUES (397, 1, 2227, 1692024557);
INSERT INTO `notifications_status` VALUES (398, 1, 2226, 1692024557);
INSERT INTO `notifications_status` VALUES (399, 1, 2225, 1692024557);
INSERT INTO `notifications_status` VALUES (400, 1, 2224, 1692024557);
INSERT INTO `notifications_status` VALUES (401, 1, 2223, 1692024557);
INSERT INTO `notifications_status` VALUES (402, 1, 2222, 1692024557);
INSERT INTO `notifications_status` VALUES (403, 1, 2221, 1692024557);
INSERT INTO `notifications_status` VALUES (404, 1, 2220, 1692024557);

-- ----------------------------
-- Table structure for offline_bank_specification_translations
-- ----------------------------
DROP TABLE IF EXISTS `offline_bank_specification_translations`;
CREATE TABLE `offline_bank_specification_translations`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `offline_bank_specification_id` int UNSIGNED NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `offline_bank_specification_id`(`offline_bank_specification_id`) USING BTREE,
  INDEX `locale`(`locale`) USING BTREE,
  CONSTRAINT `offline_bank_specification_id` FOREIGN KEY (`offline_bank_specification_id`) REFERENCES `offline_bank_specifications` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of offline_bank_specification_translations
-- ----------------------------
INSERT INTO `offline_bank_specification_translations` VALUES (20, 17, 'en', 'Card ID');
INSERT INTO `offline_bank_specification_translations` VALUES (21, 18, 'en', 'Account ID');
INSERT INTO `offline_bank_specification_translations` VALUES (22, 19, 'en', 'IBAN');
INSERT INTO `offline_bank_specification_translations` VALUES (23, 20, 'en', 'Account Holder');
INSERT INTO `offline_bank_specification_translations` VALUES (24, 21, 'en', 'IBAN');
INSERT INTO `offline_bank_specification_translations` VALUES (25, 22, 'en', 'Card Number');
INSERT INTO `offline_bank_specification_translations` VALUES (26, 23, 'en', 'Card Number');
INSERT INTO `offline_bank_specification_translations` VALUES (27, 24, 'en', 'Account ID');
INSERT INTO `offline_bank_specification_translations` VALUES (28, 25, 'en', 'IBAN');

-- ----------------------------
-- Table structure for offline_bank_specifications
-- ----------------------------
DROP TABLE IF EXISTS `offline_bank_specifications`;
CREATE TABLE `offline_bank_specifications`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `offline_bank_id` int UNSIGNED NOT NULL,
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `offline_bank_specifications_offline_bank_id_foreign`(`offline_bank_id`) USING BTREE,
  CONSTRAINT `offline_bank_specifications_offline_bank_id_foreign` FOREIGN KEY (`offline_bank_id`) REFERENCES `offline_banks` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of offline_bank_specifications
-- ----------------------------
INSERT INTO `offline_bank_specifications` VALUES (17, 6, '2578-4910-3682-6288');
INSERT INTO `offline_bank_specifications` VALUES (18, 6, '38152294372');
INSERT INTO `offline_bank_specifications` VALUES (19, 6, 'QA66QUWW934528129454345775226');
INSERT INTO `offline_bank_specifications` VALUES (20, 7, 'DevZero');
INSERT INTO `offline_bank_specifications` VALUES (21, 7, 'NL37ABNA2423554788');
INSERT INTO `offline_bank_specifications` VALUES (22, 7, '5012-4518-1772-8911');
INSERT INTO `offline_bank_specifications` VALUES (23, 8, '6282-4518-1237-7641');
INSERT INTO `offline_bank_specifications` VALUES (24, 8, '56238341127');
INSERT INTO `offline_bank_specifications` VALUES (25, 8, 'IN37ABNA2422193788');

-- ----------------------------
-- Table structure for offline_bank_translations
-- ----------------------------
DROP TABLE IF EXISTS `offline_bank_translations`;
CREATE TABLE `offline_bank_translations`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `offline_bank_id` int UNSIGNED NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `offline_bank_translations_offline_bank_id_foreign`(`offline_bank_id`) USING BTREE,
  INDEX `offline_bank_translations_locale_index`(`locale`) USING BTREE,
  CONSTRAINT `offline_bank_translations_offline_bank_id_foreign` FOREIGN KEY (`offline_bank_id`) REFERENCES `offline_banks` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of offline_bank_translations
-- ----------------------------
INSERT INTO `offline_bank_translations` VALUES (7, 6, 'en', 'Qatar National Bank');
INSERT INTO `offline_bank_translations` VALUES (8, 7, 'en', 'JPMorgan');
INSERT INTO `offline_bank_translations` VALUES (9, 8, 'en', 'State Bank of India');

-- ----------------------------
-- Table structure for offline_banks
-- ----------------------------
DROP TABLE IF EXISTS `offline_banks`;
CREATE TABLE `offline_banks`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `logo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of offline_banks
-- ----------------------------
INSERT INTO `offline_banks` VALUES (6, '/store/1/default_images/offline_payments/Qatar National Bank.png', 1678951755);
INSERT INTO `offline_banks` VALUES (7, '/store/1/default_images/offline_payments/jpmorgan.png', 1679089716);
INSERT INTO `offline_banks` VALUES (8, '/store/1/default_images/offline_payments/State Bank of India.png', 1679090036);

-- ----------------------------
-- Table structure for offline_payments
-- ----------------------------
DROP TABLE IF EXISTS `offline_payments`;
CREATE TABLE `offline_payments`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int UNSIGNED NOT NULL,
  `amount` int NOT NULL,
  `offline_bank_id` int UNSIGNED NULL DEFAULT NULL,
  `reference_number` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `attachment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `status` enum('waiting','approved','reject') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `pay_date` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `offline_payments_user_id_foreign`(`user_id`) USING BTREE,
  INDEX `offline_payments_offline_bank_id_foreign`(`offline_bank_id`) USING BTREE,
  CONSTRAINT `offline_payments_offline_bank_id_foreign` FOREIGN KEY (`offline_bank_id`) REFERENCES `offline_banks` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `offline_payments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 42 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of offline_payments
-- ----------------------------

-- ----------------------------
-- Table structure for order_items
-- ----------------------------
DROP TABLE IF EXISTS `order_items`;
CREATE TABLE `order_items`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int UNSIGNED NOT NULL,
  `order_id` int UNSIGNED NOT NULL,
  `webinar_id` int UNSIGNED NULL DEFAULT NULL,
  `bundle_id` int UNSIGNED NULL DEFAULT NULL,
  `subscribe_id` int UNSIGNED NULL DEFAULT NULL,
  `promotion_id` int UNSIGNED NULL DEFAULT NULL,
  `gift_id` int UNSIGNED NULL DEFAULT NULL,
  `registration_package_id` int UNSIGNED NULL DEFAULT NULL,
  `product_id` int UNSIGNED NULL DEFAULT NULL,
  `product_order_id` int UNSIGNED NULL DEFAULT NULL,
  `installment_payment_id` int UNSIGNED NULL DEFAULT NULL,
  `reserve_meeting_id` int UNSIGNED NULL DEFAULT NULL,
  `ticket_id` int UNSIGNED NULL DEFAULT NULL,
  `discount_id` int NULL DEFAULT NULL,
  `become_instructor_id` int UNSIGNED NULL DEFAULT NULL,
  `amount` double(15, 2) UNSIGNED NULL DEFAULT NULL,
  `tax` int UNSIGNED NULL DEFAULT NULL,
  `tax_price` double(15, 2) NULL DEFAULT NULL,
  `commission` int UNSIGNED NULL DEFAULT NULL,
  `commission_price` double(15, 2) NULL DEFAULT NULL,
  `discount` double(15, 2) NULL DEFAULT NULL,
  `total_amount` double(15, 2) NULL DEFAULT NULL,
  `product_delivery_fee` double(15, 2) NULL DEFAULT NULL,
  `created_at` int UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `order_items_order_id_foreign`(`order_id`) USING BTREE,
  INDEX `order_items_webinar_id_foreign`(`webinar_id`) USING BTREE,
  INDEX `order_items_ticket_id_foreign`(`ticket_id`) USING BTREE,
  INDEX `order_items_reserve_meeting_id_foreign`(`reserve_meeting_id`) USING BTREE,
  INDEX `order_items_subscribe_id_foreign`(`subscribe_id`) USING BTREE,
  INDEX `order_items_promotion_id_foreign`(`promotion_id`) USING BTREE,
  INDEX `order_items_gift_id_foreign`(`gift_id`) USING BTREE,
  CONSTRAINT `order_items_gift_id_foreign` FOREIGN KEY (`gift_id`) REFERENCES `gifts` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 711 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of order_items
-- ----------------------------
INSERT INTO `order_items` VALUES (707, 1054, 709, 2026, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 170000.00, 10, 17000.00, 0, 0.00, 0.00, 187000.00, 0.00, 1684185008);
INSERT INTO `order_items` VALUES (708, 1058, 710, 2026, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 170000.00, 10, 17000.00, 0, 0.00, 0.00, 187000.00, 0.00, 1684939467);
INSERT INTO `order_items` VALUES (709, 1058, 711, 2026, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 170000.00, 10, 17000.00, 0, 0.00, 0.00, 187000.00, 0.00, 1685378876);
INSERT INTO `order_items` VALUES (710, 1058, 712, 2026, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 170000.00, 10, 17000.00, 0, 0.00, 0.00, 187000.00, 0.00, 1685378946);

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int UNSIGNED NOT NULL,
  `status` enum('pending','paying','paid','fail') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payment_method` enum('credit','payment_channel') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `is_charge_account` tinyint(1) NOT NULL DEFAULT 0,
  `amount` double(15, 2) UNSIGNED NOT NULL,
  `tax` decimal(13, 2) NULL DEFAULT NULL,
  `total_discount` decimal(13, 2) NULL DEFAULT NULL,
  `total_amount` decimal(13, 2) NULL DEFAULT NULL,
  `product_delivery_fee` decimal(13, 2) NULL DEFAULT NULL,
  `reference_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `payment_data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `orders_user_id_foreign`(`user_id`) USING BTREE,
  CONSTRAINT `orders_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 713 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of orders
-- ----------------------------

-- ----------------------------
-- Table structure for page_translations
-- ----------------------------
DROP TABLE IF EXISTS `page_translations`;
CREATE TABLE `page_translations`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `page_id` int UNSIGNED NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `seo_description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `page_translations_page_id_foreign`(`page_id`) USING BTREE,
  INDEX `page_translations_locale_index`(`locale`) USING BTREE,
  CONSTRAINT `page_translations_page_id_foreign` FOREIGN KEY (`page_id`) REFERENCES `pages` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of page_translations
-- ----------------------------
INSERT INTO `page_translations` VALUES (6, 5, 'es', 'Términos y condiciones', 'Términos y condiciones', '<article class=\"col-12\" style=\" text-align: justify\">\r\n  \r\n<p>La contratación de cursos que ofrezca por su parte DEVZEROS S.A.S. y, por su parte el estudiante ala aceptación previa, expresa y sin excepciones de la totalidad de los términos y condiciones aquí previstos. Este documento (así como cualquier otro documento que aquí se mencione) regula las condiciones aplicables a la adquisición de cursos ofertados por DEVZEROS S.A.S. como contraprestación al pago de la matrícula, en los términos que más adelante se establecen y previa aceptación de las presente Condiciones, el estudiante podrá realizar el curso presencial, en función de la modalidad de pago que elija.\r\n</p>\r\n\r\n<h3 style=\"font-size: medium; font-weight: normal\">\r\n1. AUTORIZACIÓN TRATAMIENTO DE DATOS PERSONALES:\r\n</h3>\r\n<p>\r\n De conformidad con las disposiciones contenidas en la Ley 1581 de 2012 (Ley de protección de datos personales), autorizo expresamente a DEVZEROS S.A.S., o a quien represente sus derechos, o a quien en el futuro ostente la calidad de acreedor de cualquiera de las obligaciones que haya contraído o contraiga en el futuro con esta entidad, para que además de los fines de análisis de riesgo de crédito, utilice la información que sobre mí recopile de cualquier fuente para el desarrollo de estrategias comerciales o campañas publicitarias, a favor de DEVZEROS S.A.S., o de un tercero. Recuerde que usted tiene derecho a que DEVZEROS S.A.S., actualice, rectifique y trate sus datos personales de conformidad con nuestra Política de Protección de Datos personales, las que puede ser consultada en la página web www.devzeros.com.\r\n</p>\r\n\r\n<h3 style=\"font-size: medium; font-weight: normal; margin-top: 20px\">\r\n2. AUTORIZACIÓN ENVÍO COMUNICACIONES Y REPORTE:\r\n</h3>\r\n<p>\r\nAutorizo(amos) a DEVZEROS S.A.S., para que envíe a la dirección electrónica aquí registrada las comunicaciones y reporte de tipo legal y comercial que así se requiera. En caso que no halla contacto virtual podrá ser enviada a la dirección de contacto físico. Por medio del presente autorizo(amos) expresa e irrevocablemente a DEVZEROS S.A.S., para enviar mensajes de texto, correspondiente a información de DEVZEROS S.A.S., a el(los) número(s) de celular y/o correo electrónico registrado(s), de igual forma autorizo(amos) a DEVZEROS S.A.S., o quien haga sus veces, o represente sus derechos, para que destruya toda la información aportada para la solicitud de productos, en el caso de que esta sea negada o desistida. De conformidad con lo establecido en el artículo 2 del Decreto 2952 de 2010 autorizo(amos) a DEVZEROS S.A.S., para que en desarrollo de lo dispuesto en el Inc. 2 del artículo 12 de la Ley 1266 de 2008, me(nos) modifique el reporte de comportamiento de pago negativo a través de mensaje de datos y/o correo electrónico que para el efecto suministraré en este documento.\r\n</p>\r\n\r\n<h3 style=\"font-size: medium; font-weight: normal; margin-top: 20px\">\r\n3. DECLARACIÓN DE ORIGEN DE FONDOS:\r\n</h3>\r\n<p>\r\n En nombre propio de manera voluntaria y dando certeza de que todo lo que aquí consigno(amos) es cierto, realizo(amos) la siguiente declaración de fondos a DEVZEROS S.A.S., con el propósito que se pueda dar cumplimiento a lo señalado en la Ley 190 de 1995 (Estatuto Anticorrupción) y demás normas legales concordantes. <br>\r\n(1) mis(nuestros) ingresos provienen de las siguientes fuentes (detalle de la ocupación, oficio, profesión, actividad, negocio, etc.); (2) certifico(amos) que la información suministrada es verídica y autorizo(amos) a DEVZEROS S.A.S, para que la verifique, estoy(amos) informando de mi(nuestra) obligación de actualizar anualmente la información requerida por esta entidad, por el producto o servicio que utilice. (3) declaro(amos) que los recursos entregados, no provienen de ninguna actividad ilícita de las contempladas en el sistema penal colombiano.\r\n</p>\r\n\r\n<h3 style=\"font-size: medium; font-weight: normal; margin-top: 20px\">\r\n4. AUTORIZACIÓN CONSULTA Y REPORTE CENTRALES DE RIESGO:\r\n</h3>\r\n<p>\r\nActuando libre y voluntariamente, autorizo(amos) de manera expresa e irrevocable a DEVZEROS S.A.S., o a quien represente sus derechos, a consultar, solicitar, suministrar, reportar y divulgar toda la información que se refiera a mi comportamiento crediticio, financiero, comercial, de servicios y de terceros países, a cualquier entidad que maneje o administre base de datos con los mismos fines. Conozco que el alcance de esta autorización implica que el comportamiento frente a mis obligaciones será registrado con el objeto de suministrar información suficiente y adecuada al mercado sobre el estado de mis(nuestras) obligaciones financieras, comerciales, crediticias y proveniente de terceros países de la misma naturaleza. En consecuencia, quienes se encuentren vinculados y/o tengan acceso a cualquier entidad que maneje o administre base de datos, podrán conocer esta información, de conformidad con la legislación y jurisprudencia aplicable. La información podrá igualmente ser utilizada para efectos estadísticos. Mis derechos y obligaciones, así como la permanencia de mi información en la base de datos corresponde a lo determinado por el ordenamiento jurídico aplicable del cual, por ser de carácter público estoy enterado. En caso de que, en el futuro, el autorizado en este documento efectúe a favor de un tercero, una venta de cartera o una cesión a cualquier título de las obligaciones a mi cargo, los efectos de la presente autorización se extenderán a este en los mismos términos y condiciones. Así mismo, autorizo(amos) a la central de información a que, en su calidad de operador, ponga mi información a disposición de otros operadores nacionales y extranjeros se extenderán a este en los términos que establece la ley siempre y cuando su objeto sea similar al aquí establecido.\r\n</p>\r\n\r\n<h3 style=\"font-size: medium; font-weight: normal; margin-top: 20px\">\r\n5. SUMINISTRO Y ACTUALIZACIÓN INFORMACIÓN:\r\n</h3>\r\n<p>\r\nEl estudiante se obliga con DEVZEROS S.A.S., a entregar información veraz, verificable y actualizar su información personal, por lo menos, una (1) vez al año, o cada vez que así lo solicite DEVZEROS S.A.S., suministrando la totalidad de los soportes documentales exigidos. El incumplimiento de esta obligación, faculta a DEVZEROS S.A.S., para terminar de manera inmediata y unilateral cualquier tipo de relación que tenga con el estudiante. Por medio del presente documento autorizo(amos) expresa e irrevocablemente a DEVZEROS S.A.S., para actualizar nuestra información personal y/o demográfica por cualquier medio que tenga esa entidad para el efecto.\r\n</p>\r\n\r\n<h3 style=\"font-size: medium; font-weight: normal; margin-top: 20px\">\r\n6. CONDICIONES DE ACCESO A LA PLATAFORMA:\r\n</h3>\r\n<p>\r\n Para poder acceder a los cursos, es necesario rellenar el formulario de inscripción que aparece en devzeros.com/school/register, para lo cual es necesario que revise la Política de Privacidad. Una vez completado el formulario de inscripción y realizado el pago de la matricula o de la totalidad del curso, el estudiante recibirá una confirmación de su matrícula y una copia de este contrato, junto con las instrucciones para iniciar el curso y para realizar los pagos de las siguientes cuotas. El alumno recibirá un usuario y una contraseña para el acceso a la plataforma school.devzeros.com/login/. En caso que al registrarse el alumno haya incurrido en algún error, deberá comunicarlo al correo electrónico admin@devzeros.com.co, para subsanarlo.\r\n</p>\r\n\r\n<h3 style=\"font-size: medium; font-weight: normal; margin-top: 20px\">\r\n7. TARIFAS, CANCELACIÓN Y MEDIOS DE PAGO:\r\n</h3>\r\n<p>\r\n El pago de los cursos presenciales puede realizarse de dos formas: en un solo pago o en pagos aplazados. (1) Si el curso se cancela en un solo plazo, el pago debe realizarse dentro de los 2 días hábiles siguientes al pago de la matrícula y, en todo caso, antes del inicio de las clases. El cupo no estará plenamente garantizado mientras no se realice el pago. (2) Si se realiza en pagos aplazados, se pagará el valor de la matrícula y, en todo caso, antes del inicio de las clases, y el resto de pagos deberán ser abonado en las fechas establecidas conforme al plan de amortización del crédito aprobado. En el evento que el pago del curso lo realiza una empresa, esta deberá abonar el importe completo más el valor de la matricula antes del comienzo del curso. DEVZEROS S.A.S, se reserva el derecho a realizar y cancelar cuantas ofertas y promociones considere necesarias tanto antes como durante el periodo de matriculación de una convocatoria. Los descuentos y promociones no son acumulables. La matrícula o el importe completo del curso se pueden abonar en efectivo en la siguiente dirección: CRA 25 CALLE 7B BIS – 04 Barrio Villa Concha, mediante transferencia o mediante tarjeta de crédito/débito. El alumno deberá ser el titular del medio de pago utilizado, reconociendo y manifestando ser el titular del mismo. Adicionalmente, el alumno es el único responsable de la adecuada custodia y confidencialidad del medio de pago, debiendo hacer frente a cualquier transacción realizadas por él o por el tercero a quien haya facilitado su uso, ya sea voluntariamente, por culpa o negligencia. Excepcionalmente en el caso de que el alumno sea menor de edad, el medio de pago utilizado tendrá que ser su progenitor o representante legal que realice la matrícula en el curso.\r\n </p>\r\n\r\n<h3 style=\"font-size: medium; font-weight: normal; margin-top: 20px\">\r\n 8. DERECHO A RETRACTO:\r\n</h3>\r\n<p>\r\nConforme a nuestro régimen legal, el estudiante podrá hacer ejercer este derecho dentro de los DIEZ (10) días calendarios siguientes a la fecha de celebración del contrato.\r\n </p>\r\n\r\n<h3 style=\"font-size: medium; font-weight: normal; margin-top: 20px\">\r\n 9. LISTAS DE ESPERA, CAMBIOS DE GRUPO, RECUPERACIÓN DE CLASES Y PRÓRROGAS:\r\n</h3>\r\n <p>\r\nEn caso que al realizar la inscripción para la realización de un curso que ya esté completo se apuntará al estudiante en una lista de espera. Si se liberara un cupo antes del inicio del curso, se contactará al(los) interesados y se adjudicarán los cupos a los primeros que respondan y formalicen las correspondientes matrículas. cambio de grupo y recuperación de clases en cursos presenciales: <br>\r\nSi durante el desarrollo del curso el estudiante, por incompatibilidad de horarios, no pudiera asistir a las clases en el horario elegido, podrá cambiar a otro turno del mismo curso que se esté impartiendo en ese momento, siempre que exista disponibilidad de cupos en el grupo al que desea cambiarse. Si no puede asistir a otro turno en ese momento, y puede completar el curso en una convocatoria posterior, siempre que queden cupos disponibles antes del inicio del nuevo grupo. Si el estudiante no puede asistir a alguna clase de su curso por motivos laborales, académicos o de salud, podrá recuperarla en otro turno del mismo curso que se esté impartiendo en ese momento, siempre que exista disponibilidad de cupos en ese grupo. Para recuperar la clase deberá solicitarlo en secretaría y presentar el soporte correspondiente.\r\n</p>\r\n\r\n<h3 style=\"font-size: medium; font-weight: normal; margin-top: 20px\">\r\n10. SUSTITUCIONES Y/O REEMBOLSO:\r\n </h3>\r\n<p>\r\nDEVZEROS S.A.S., se reserva el derecho a cancelar un curso si no se alcanza un mínimo de 8 estudiantes matriculados. En este caso, a los estudiantes que hubiesen reservado su cupo se les devolverá la totalidad de los importes que hubieran abonado. En los cursos presenciales, el primer día de clase el alumno recibirá un horario del curso matriculad, igualmente se reserva el derecho de modificarlo excepcionalmente en caso de fuerza mayor.\r\n</p>\r\n\r\n<h3 style=\"font-size: medium; font-weight: normal; margin-top: 20px\">\r\n11. GARANTÍA DE IDONEIDAD Y PROFESIONALISMO DE LOS DOCENTES:\r\n</h3>\r\n<p>\r\nLos profesores son docentes expertos en el contenido y con experiencia previa demostrable. En caso de ausencia del profesor por enfermedad u otra causa de fuerza mayor, DEVZEROS S.A.S hará todos los esfuerzos posibles para sustituir al profesor por otro docente de igual o mejor cualificación. Si no fuera posible, DEVZEROS S.A.S se reserva el derecho a cancelar el curso, en cuyo caso, ofrecerá al alumno la posibilidad de incorporarse a otro grupo o recuperar la parte proporcional abonada por las clases no impartidas.\r\n</p>\r\n\r\n<h3 style=\"font-size: medium; font-weight: normal; margin-top: 20px\">\r\n12. ACCESO AL MATERIAL Y DERECHOS DE PROPIEDAD INTELECTUAL:\r\n</h3>\r\n <p>\r\nEl acceso y uso por parte de los estudiantes del material que se les faciliten a lo largo de curso es personal e intransferible y no implica por parte de los titulares de los derechos de propiedad intelectual de los materiales, ninguna renuncia, transmisión, licencia o cesión, total ni parcial, de derechos de propiedad intelectual o industrial sobre los mismos. El alumno tendrá acceso a los materiales en el curso presencial. El alumno únicamente podrá hacer uso de los materiales para fines personales y en ningún caso podrá realizar una divulgación ni una explotación de los mismos. Asimismo, se compromete a mantener la confidencialidad sobre los mismos tanto durante el curso como con posterioridad. Entre otras cuestiones, está expresamente prohibido al estudiante: (1) Copiar, reproducir, “ripear” (extraer o copiar los materiales completos o fragmentos de los mismos), descargar, imprimir, reenviar, grabar, poner a disposición del público o utilizar, ya sea parcialmente, ya sea en su totalidad, el material de los cursos (incluidos, entre otros, títulos, imágenes y textos) de cualquier forma que no esté expresamente permitida en las presentes Condiciones Particulares; (2) Eliminar, modificar, suprimir o cualquier forma similar de impedir el efectivo funcionamiento de cualquier medida adoptada para evitar la copia, distribución, puesta a disposición del público, descarga, modificación, transformación o cualquier otro tipo de acceso o tratamiento indebido o no autorizado de los materiales de los cursos, ya sea parcialmente, ya sea en su totalidad; (3) Burlar cualquier tecnología utilizada para proteger los materiales de los cursos accesibles a través del Sitio Web, así como suprimir o eliminar de los mismos cualquier mención o referencia al aviso de los derechos sobre los mismos; (4) Realizar la grabación en audio o video de cualquiera de las clases. Si el estudiante vulnera cualquiera de estas prohibiciones, DEVZEROS S.A.S ejercerá las acciones legales necesarias contra el alumno, que podrán incluir solicitar indemnización por los daños y perjuicios causados. Cualquier texto redactado por los alumnos durante los cursos es titularidad exclusiva del alumno autor de los mismos, manifestando éste que es autor de los mismos y que por tanto que se trata de un texto original que no infringe los derechos de terceros. DEVZEROS S.A.S, no se responsabiliza por acciones, escritos o declaraciones que el docente del curso pueda realizar ya sea en sus clases o a través de sus materiales.\r\n</p>\r\n\r\n<h3 style=\"font-size: medium; font-weight: normal; margin-top: 20px\">\r\n13. OBLIGACIONES DEL ESTUDIANTE:\r\n</h3>\r\n <p>\r\nEn los cursos presenciales: es necesario asistir a un 85% de las clases para obtener el certificado y se requiere puntualidad en las entradas y salidas a las clases y atender el curso con una actitud de respeto hacia los restantes alumnos y hacia los docentes. En el caso de que un alumno no respete las normas de convivencia en el aula o adopte actitudes discriminatorias o abusivas, DEVZEROS  S.A.S., se reserva el derecho a excluirle del curso sin que en ningún caso tenga derecho el alumno a restitución alguna de la matrícula. Igualmente, DEVZEROS S.A.S, se reserva el derecho de suspender temporalmente o definitivamente el acceso del alumno al sitio web o a sus aulas y con ello al curso en cualquier momento en caso de producirse un uso no autorizado, o supuestamente no autorizado, del servicio mismo, ya sea por contravenir lo previsto en las presentes Condiciones o por otras causas. En tales supuestos, no recaerá obligación ni responsabilidad alguna sobre DEVZEROS S.A.S., y no se devolverá ningún importe que el alumno hubiera abonado previamente.\r\n</p>\r\n\r\n<h3 style=\"font-size: medium; font-weight: normal; margin-top: 20px\">\r\n14. ACREDITACIÓN DE CUMPLIMIENTO DEL CURSO Y GARANTÍA DEL SERVICIO:\r\n</h3>\r\n<p>\r\nTodo alumno que complete un curso, recibirá un certificado acreditando que se ha completado el Curso. Igualmente, DEVZEROS S.A.S, se obliga a (1) realizar una prestación de servicios conforme con el contrato celebrado, y a responder de cualquier falta de conformidad; (2) reservarse el derecho a modificar las presentes condiciones, si bien la modificación no afectará al estudiante que ya haya pagado la matrícula para un determinado curso, en relación a dicho curso.\r\n</p>\r\n\r\n<h3 style=\"font-size: medium; font-weight: normal; margin-top: 20px\">\r\n15. DISPOSICIONES FINALES:\r\n</h3>\r\n<p>\r\nDeclaro(amos) que los datos e información suministrada en el presente documento, como los anexos a él, son reales y corresponden a los hechos en ellos descrito, así mismo autorizo(amos) a DEVZEROS S.A.S., o a quien este designe, en forma irrevocable, a lo siguiente: a) verifique y obtenga de cualquier fuente de información de datos o referencias, correspondientes a nosotros y a nuestros comportamientos de pago. b) consultar nuestro endeudamiento y comportamiento de pago ante las centrales de riesgo. Autorizo(amos) a DEVZEROS S.A.S., o a quien represente sus derechos u ostente en el futuro la calidad de acreedor a reportar, procesar, solicitar y divulgar a las centrales de información financieras que administre las entidades bancarias y de entidades financieras de colombina, o a cualquier otra entidad que maneje o administre base de datos con los mismos fines, toda la información a nuestro comportamiento comercial, bajo los preceptos de la Ley 1266 de 2008. El estudiante, manifiesta que conoce el estatuto vigente, los reglamentos y normas internas que rigen el producto objeto de la presente solicitud, en caso de que los mismos con fecha posterior a la solicitud cambien, serán dados a conocer al estudiante por el mecanismo que DEVZEROS S.A.S., considere más idóneo para tal efecto, si trascurrido cinco (5) días hábiles desde la fecha que se le de publicidad el estudiante no manifiesta por escrito alguna inquietud o diferencia respecto de dichos términos, se presumirá que el estudiante los acepta.\r\n</p>\r\n</article>');
INSERT INTO `page_translations` VALUES (7, 3, 'es', 'aboutus', NULL, '<p>asdasdasdasdasda</p>');

-- ----------------------------
-- Table structure for pages
-- ----------------------------
DROP TABLE IF EXISTS `pages`;
CREATE TABLE `pages`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `link` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `robot` tinyint(1) NOT NULL DEFAULT 0,
  `status` enum('publish','draft') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'draft',
  `created_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `pages_link_unique`(`link`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pages
-- ----------------------------
INSERT INTO `pages` VALUES (3, '/about', 'About', 1, 'publish', 1686070385);
INSERT INTO `pages` VALUES (5, '/terms', 'Terms & rules', 1, 'publish', 1686148641);
INSERT INTO `pages` VALUES (6, '/reward_points_system', 'Reward Points System', 1, 'publish', 1646398467);

-- ----------------------------
-- Table structure for password_resets
-- ----------------------------
DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE `password_resets`  (
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  INDEX `password_resets_email_index`(`email`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of password_resets
-- ----------------------------
INSERT INTO `password_resets` VALUES ('av18981848@gmail.com', 'cYTtJLR86NoxZ0whf465XoQa98hhxAxx2Q7t3zeaeTJRYoUMQwqqzb4rgqP2', '2021-02-20 16:05:13');

-- ----------------------------
-- Table structure for payku_payments
-- ----------------------------
DROP TABLE IF EXISTS `payku_payments`;
CREATE TABLE `payku_payments`  (
  `transaction_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `start` date NOT NULL,
  `end` date NOT NULL,
  `media` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `verification_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `authorization_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_4_digits` int UNSIGNED NULL DEFAULT NULL,
  `installments` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `card_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `additional_parameters` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `currency` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  `payment_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `transaction_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `deposit_date` datetime(0) NULL DEFAULT NULL,
  UNIQUE INDEX `payku_payments_transaction_id_unique`(`transaction_id`) USING BTREE,
  CONSTRAINT `payku_payments_transaction_id_foreign` FOREIGN KEY (`transaction_id`) REFERENCES `payku_transactions` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of payku_payments
-- ----------------------------

-- ----------------------------
-- Table structure for payku_transactions
-- ----------------------------
DROP TABLE IF EXISTS `payku_transactions`;
CREATE TABLE `payku_transactions`  (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `order` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `subject` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `url` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `amount` int UNSIGNED NULL DEFAULT NULL,
  `notified_at` datetime(0) NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  `full_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  UNIQUE INDEX `payku_transactions_id_unique`(`id`) USING BTREE,
  UNIQUE INDEX `payku_transactions_order_unique`(`order`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of payku_transactions
-- ----------------------------

-- ----------------------------
-- Table structure for payment_channels
-- ----------------------------
DROP TABLE IF EXISTS `payment_channels`;
CREATE TABLE `payment_channels`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `class_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('active','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `settings` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `currencies` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_at` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 34 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of payment_channels
-- ----------------------------
INSERT INTO `payment_channels` VALUES (19, 'Paypal', 'Paypal', 'active', '/store/1/default_images/payment gateways/paypal.png', '', '[\"USD\"]', '1654755044');
INSERT INTO `payment_channels` VALUES (23, 'Payu', 'Payu', 'active', '/store/1/default_images/payment gateways/payu.png', '', '[\"USD\"]', '1654755044');
INSERT INTO `payment_channels` VALUES (24, 'Razorpay', 'Razorpay', 'active', '/store/1/default_images/payment gateways/razorpay.png', '', '[\"USD\"]', '1654755044');

-- ----------------------------
-- Table structure for payouts
-- ----------------------------
DROP TABLE IF EXISTS `payouts`;
CREATE TABLE `payouts`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int UNSIGNED NOT NULL,
  `user_selected_bank_id` int UNSIGNED NOT NULL,
  `amount` decimal(13, 2) NOT NULL,
  `status` enum('waiting','done','reject') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `payouts_user_id_foreign`(`user_id`) USING BTREE,
  INDEX `payout_user_selected_bank_id`(`user_selected_bank_id`) USING BTREE,
  CONSTRAINT `payout_user_selected_bank_id` FOREIGN KEY (`user_selected_bank_id`) REFERENCES `user_selected_banks` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `payouts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of payouts
-- ----------------------------

-- ----------------------------
-- Table structure for payu_transactions
-- ----------------------------
DROP TABLE IF EXISTS `payu_transactions`;
CREATE TABLE `payu_transactions`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `paid_for_id` bigint UNSIGNED NULL DEFAULT NULL,
  `paid_for_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `transaction_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `gateway` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `body` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `destination` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `hash` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `response` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `status` enum('pending','failed','successful','invalid') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `verified_at` timestamp(0) NULL DEFAULT NULL,
  `deleted_at` timestamp(0) NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `payu_transactions_transaction_id_unique`(`transaction_id`) USING BTREE,
  INDEX `payu_transactions_status_index`(`status`) USING BTREE,
  INDEX `payu_transactions_verified_at_index`(`verified_at`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of payu_transactions
-- ----------------------------

-- ----------------------------
-- Table structure for permissions
-- ----------------------------
DROP TABLE IF EXISTS `permissions`;
CREATE TABLE `permissions`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `role_id` int UNSIGNED NULL DEFAULT NULL,
  `section_id` int UNSIGNED NULL DEFAULT NULL,
  `allow` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `permissions_role_id_index`(`role_id`) USING BTREE,
  INDEX `permissions_section_id_index`(`section_id`) USING BTREE,
  CONSTRAINT `permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `permissions_section_id_foreign` FOREIGN KEY (`section_id`) REFERENCES `sections` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 16040 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of permissions
-- ----------------------------
INSERT INTO `permissions` VALUES (15627, 2, 1, 1);
INSERT INTO `permissions` VALUES (15628, 2, 2, 1);
INSERT INTO `permissions` VALUES (15629, 2, 3, 1);
INSERT INTO `permissions` VALUES (15630, 2, 4, 1);
INSERT INTO `permissions` VALUES (15631, 2, 5, 1);
INSERT INTO `permissions` VALUES (15632, 2, 6, 1);
INSERT INTO `permissions` VALUES (15633, 2, 7, 1);
INSERT INTO `permissions` VALUES (15634, 2, 8, 1);
INSERT INTO `permissions` VALUES (15635, 2, 9, 1);
INSERT INTO `permissions` VALUES (15636, 2, 10, 1);
INSERT INTO `permissions` VALUES (15637, 2, 11, 1);
INSERT INTO `permissions` VALUES (15638, 2, 12, 1);
INSERT INTO `permissions` VALUES (15639, 2, 13, 1);
INSERT INTO `permissions` VALUES (15640, 2, 14, 1);
INSERT INTO `permissions` VALUES (15641, 2, 15, 1);
INSERT INTO `permissions` VALUES (15642, 2, 16, 1);
INSERT INTO `permissions` VALUES (15643, 2, 17, 1);
INSERT INTO `permissions` VALUES (15644, 2, 25, 1);
INSERT INTO `permissions` VALUES (15645, 2, 26, 1);
INSERT INTO `permissions` VALUES (15646, 2, 50, 1);
INSERT INTO `permissions` VALUES (15647, 2, 51, 1);
INSERT INTO `permissions` VALUES (15648, 2, 52, 1);
INSERT INTO `permissions` VALUES (15649, 2, 53, 1);
INSERT INTO `permissions` VALUES (15650, 2, 54, 1);
INSERT INTO `permissions` VALUES (15651, 2, 100, 1);
INSERT INTO `permissions` VALUES (15652, 2, 101, 1);
INSERT INTO `permissions` VALUES (15653, 2, 102, 1);
INSERT INTO `permissions` VALUES (15654, 2, 103, 1);
INSERT INTO `permissions` VALUES (15655, 2, 104, 1);
INSERT INTO `permissions` VALUES (15656, 2, 105, 1);
INSERT INTO `permissions` VALUES (15657, 2, 106, 1);
INSERT INTO `permissions` VALUES (15658, 2, 107, 1);
INSERT INTO `permissions` VALUES (15659, 2, 108, 1);
INSERT INTO `permissions` VALUES (15660, 2, 109, 1);
INSERT INTO `permissions` VALUES (15661, 2, 110, 1);
INSERT INTO `permissions` VALUES (15662, 2, 111, 1);
INSERT INTO `permissions` VALUES (15663, 2, 112, 1);
INSERT INTO `permissions` VALUES (15664, 2, 113, 1);
INSERT INTO `permissions` VALUES (15665, 2, 114, 1);
INSERT INTO `permissions` VALUES (15666, 2, 115, 1);
INSERT INTO `permissions` VALUES (15667, 2, 116, 1);
INSERT INTO `permissions` VALUES (15668, 2, 117, 1);
INSERT INTO `permissions` VALUES (15669, 2, 150, 1);
INSERT INTO `permissions` VALUES (15670, 2, 151, 1);
INSERT INTO `permissions` VALUES (15671, 2, 152, 1);
INSERT INTO `permissions` VALUES (15672, 2, 153, 1);
INSERT INTO `permissions` VALUES (15673, 2, 154, 1);
INSERT INTO `permissions` VALUES (15674, 2, 155, 1);
INSERT INTO `permissions` VALUES (15675, 2, 156, 1);
INSERT INTO `permissions` VALUES (15676, 2, 157, 1);
INSERT INTO `permissions` VALUES (15677, 2, 158, 1);
INSERT INTO `permissions` VALUES (15678, 2, 159, 1);
INSERT INTO `permissions` VALUES (15679, 2, 160, 1);
INSERT INTO `permissions` VALUES (15680, 2, 161, 1);
INSERT INTO `permissions` VALUES (15681, 2, 162, 1);
INSERT INTO `permissions` VALUES (15682, 2, 163, 1);
INSERT INTO `permissions` VALUES (15683, 2, 164, 1);
INSERT INTO `permissions` VALUES (15684, 2, 165, 1);
INSERT INTO `permissions` VALUES (15685, 2, 166, 1);
INSERT INTO `permissions` VALUES (15686, 2, 200, 1);
INSERT INTO `permissions` VALUES (15687, 2, 201, 1);
INSERT INTO `permissions` VALUES (15688, 2, 202, 1);
INSERT INTO `permissions` VALUES (15689, 2, 203, 1);
INSERT INTO `permissions` VALUES (15690, 2, 204, 1);
INSERT INTO `permissions` VALUES (15691, 2, 205, 1);
INSERT INTO `permissions` VALUES (15692, 2, 206, 1);
INSERT INTO `permissions` VALUES (15693, 2, 207, 1);
INSERT INTO `permissions` VALUES (15694, 2, 208, 1);
INSERT INTO `permissions` VALUES (15695, 2, 250, 1);
INSERT INTO `permissions` VALUES (15696, 2, 251, 1);
INSERT INTO `permissions` VALUES (15697, 2, 252, 1);
INSERT INTO `permissions` VALUES (15698, 2, 253, 1);
INSERT INTO `permissions` VALUES (15699, 2, 254, 1);
INSERT INTO `permissions` VALUES (15700, 2, 300, 1);
INSERT INTO `permissions` VALUES (15701, 2, 301, 1);
INSERT INTO `permissions` VALUES (15702, 2, 302, 1);
INSERT INTO `permissions` VALUES (15703, 2, 303, 1);
INSERT INTO `permissions` VALUES (15704, 2, 304, 1);
INSERT INTO `permissions` VALUES (15705, 2, 350, 1);
INSERT INTO `permissions` VALUES (15706, 2, 351, 1);
INSERT INTO `permissions` VALUES (15707, 2, 352, 1);
INSERT INTO `permissions` VALUES (15708, 2, 353, 1);
INSERT INTO `permissions` VALUES (15709, 2, 354, 1);
INSERT INTO `permissions` VALUES (15710, 2, 355, 1);
INSERT INTO `permissions` VALUES (15711, 2, 356, 1);
INSERT INTO `permissions` VALUES (15712, 2, 357, 1);
INSERT INTO `permissions` VALUES (15713, 2, 400, 1);
INSERT INTO `permissions` VALUES (15714, 2, 401, 1);
INSERT INTO `permissions` VALUES (15715, 2, 402, 1);
INSERT INTO `permissions` VALUES (15716, 2, 403, 1);
INSERT INTO `permissions` VALUES (15717, 2, 404, 1);
INSERT INTO `permissions` VALUES (15718, 2, 405, 1);
INSERT INTO `permissions` VALUES (15719, 2, 450, 1);
INSERT INTO `permissions` VALUES (15720, 2, 451, 1);
INSERT INTO `permissions` VALUES (15721, 2, 452, 1);
INSERT INTO `permissions` VALUES (15722, 2, 453, 1);
INSERT INTO `permissions` VALUES (15723, 2, 454, 1);
INSERT INTO `permissions` VALUES (15724, 2, 455, 1);
INSERT INTO `permissions` VALUES (15725, 2, 456, 1);
INSERT INTO `permissions` VALUES (15726, 2, 457, 1);
INSERT INTO `permissions` VALUES (15727, 2, 458, 1);
INSERT INTO `permissions` VALUES (15728, 2, 459, 1);
INSERT INTO `permissions` VALUES (15729, 2, 460, 1);
INSERT INTO `permissions` VALUES (15730, 2, 500, 1);
INSERT INTO `permissions` VALUES (15731, 2, 501, 1);
INSERT INTO `permissions` VALUES (15732, 2, 502, 1);
INSERT INTO `permissions` VALUES (15733, 2, 503, 1);
INSERT INTO `permissions` VALUES (15734, 2, 504, 1);
INSERT INTO `permissions` VALUES (15735, 2, 505, 1);
INSERT INTO `permissions` VALUES (15736, 2, 550, 1);
INSERT INTO `permissions` VALUES (15737, 2, 551, 1);
INSERT INTO `permissions` VALUES (15738, 2, 552, 1);
INSERT INTO `permissions` VALUES (15739, 2, 553, 1);
INSERT INTO `permissions` VALUES (15740, 2, 554, 1);
INSERT INTO `permissions` VALUES (15741, 2, 555, 1);
INSERT INTO `permissions` VALUES (15742, 2, 600, 1);
INSERT INTO `permissions` VALUES (15743, 2, 601, 1);
INSERT INTO `permissions` VALUES (15744, 2, 602, 1);
INSERT INTO `permissions` VALUES (15745, 2, 603, 1);
INSERT INTO `permissions` VALUES (15746, 2, 650, 1);
INSERT INTO `permissions` VALUES (15747, 2, 651, 1);
INSERT INTO `permissions` VALUES (15748, 2, 652, 1);
INSERT INTO `permissions` VALUES (15749, 2, 653, 1);
INSERT INTO `permissions` VALUES (15750, 2, 654, 1);
INSERT INTO `permissions` VALUES (15751, 2, 655, 1);
INSERT INTO `permissions` VALUES (15752, 2, 656, 1);
INSERT INTO `permissions` VALUES (15753, 2, 657, 1);
INSERT INTO `permissions` VALUES (15754, 2, 658, 1);
INSERT INTO `permissions` VALUES (15755, 2, 700, 1);
INSERT INTO `permissions` VALUES (15756, 2, 701, 1);
INSERT INTO `permissions` VALUES (15757, 2, 702, 1);
INSERT INTO `permissions` VALUES (15758, 2, 703, 1);
INSERT INTO `permissions` VALUES (15759, 2, 704, 1);
INSERT INTO `permissions` VALUES (15760, 2, 705, 1);
INSERT INTO `permissions` VALUES (15761, 2, 706, 1);
INSERT INTO `permissions` VALUES (15762, 2, 707, 1);
INSERT INTO `permissions` VALUES (15763, 2, 708, 1);
INSERT INTO `permissions` VALUES (15764, 2, 750, 1);
INSERT INTO `permissions` VALUES (15765, 2, 751, 1);
INSERT INTO `permissions` VALUES (15766, 2, 752, 1);
INSERT INTO `permissions` VALUES (15767, 2, 753, 1);
INSERT INTO `permissions` VALUES (15768, 2, 754, 1);
INSERT INTO `permissions` VALUES (15769, 2, 800, 1);
INSERT INTO `permissions` VALUES (15770, 2, 801, 1);
INSERT INTO `permissions` VALUES (15771, 2, 802, 1);
INSERT INTO `permissions` VALUES (15772, 2, 803, 1);
INSERT INTO `permissions` VALUES (15773, 2, 850, 1);
INSERT INTO `permissions` VALUES (15774, 2, 851, 1);
INSERT INTO `permissions` VALUES (15775, 2, 852, 1);
INSERT INTO `permissions` VALUES (15776, 2, 853, 1);
INSERT INTO `permissions` VALUES (15777, 2, 854, 1);
INSERT INTO `permissions` VALUES (15778, 2, 900, 1);
INSERT INTO `permissions` VALUES (15779, 2, 901, 1);
INSERT INTO `permissions` VALUES (15780, 2, 902, 1);
INSERT INTO `permissions` VALUES (15781, 2, 903, 1);
INSERT INTO `permissions` VALUES (15782, 2, 904, 1);
INSERT INTO `permissions` VALUES (15783, 2, 950, 1);
INSERT INTO `permissions` VALUES (15784, 2, 951, 1);
INSERT INTO `permissions` VALUES (15785, 2, 952, 1);
INSERT INTO `permissions` VALUES (15786, 2, 953, 1);
INSERT INTO `permissions` VALUES (15787, 2, 954, 1);
INSERT INTO `permissions` VALUES (15788, 2, 955, 1);
INSERT INTO `permissions` VALUES (15789, 2, 956, 1);
INSERT INTO `permissions` VALUES (15790, 2, 957, 1);
INSERT INTO `permissions` VALUES (15791, 2, 958, 1);
INSERT INTO `permissions` VALUES (15792, 2, 959, 1);
INSERT INTO `permissions` VALUES (15793, 2, 1000, 1);
INSERT INTO `permissions` VALUES (15794, 2, 1001, 1);
INSERT INTO `permissions` VALUES (15795, 2, 1002, 1);
INSERT INTO `permissions` VALUES (15796, 2, 1003, 1);
INSERT INTO `permissions` VALUES (15797, 2, 1004, 1);
INSERT INTO `permissions` VALUES (15798, 2, 1050, 1);
INSERT INTO `permissions` VALUES (15799, 2, 1051, 1);
INSERT INTO `permissions` VALUES (15800, 2, 1052, 1);
INSERT INTO `permissions` VALUES (15801, 2, 1053, 1);
INSERT INTO `permissions` VALUES (15802, 2, 1054, 1);
INSERT INTO `permissions` VALUES (15803, 2, 1055, 1);
INSERT INTO `permissions` VALUES (15804, 2, 1056, 1);
INSERT INTO `permissions` VALUES (15805, 2, 1057, 1);
INSERT INTO `permissions` VALUES (15806, 2, 1058, 1);
INSERT INTO `permissions` VALUES (15807, 2, 1059, 1);
INSERT INTO `permissions` VALUES (15808, 2, 1060, 1);
INSERT INTO `permissions` VALUES (15809, 2, 1075, 1);
INSERT INTO `permissions` VALUES (15810, 2, 1076, 1);
INSERT INTO `permissions` VALUES (15811, 2, 1077, 1);
INSERT INTO `permissions` VALUES (15812, 2, 1078, 1);
INSERT INTO `permissions` VALUES (15813, 2, 1079, 1);
INSERT INTO `permissions` VALUES (15814, 2, 1080, 1);
INSERT INTO `permissions` VALUES (15815, 2, 1081, 1);
INSERT INTO `permissions` VALUES (15816, 2, 1082, 1);
INSERT INTO `permissions` VALUES (15817, 2, 1083, 1);
INSERT INTO `permissions` VALUES (15818, 2, 1100, 1);
INSERT INTO `permissions` VALUES (15819, 2, 1101, 1);
INSERT INTO `permissions` VALUES (15820, 2, 1102, 1);
INSERT INTO `permissions` VALUES (15821, 2, 1103, 1);
INSERT INTO `permissions` VALUES (15822, 2, 1104, 1);
INSERT INTO `permissions` VALUES (15823, 2, 1150, 1);
INSERT INTO `permissions` VALUES (15824, 2, 1151, 1);
INSERT INTO `permissions` VALUES (15825, 2, 1152, 1);
INSERT INTO `permissions` VALUES (15826, 2, 1153, 1);
INSERT INTO `permissions` VALUES (15827, 2, 1154, 1);
INSERT INTO `permissions` VALUES (15828, 2, 1200, 1);
INSERT INTO `permissions` VALUES (15829, 2, 1201, 1);
INSERT INTO `permissions` VALUES (15830, 2, 1202, 1);
INSERT INTO `permissions` VALUES (15831, 2, 1203, 1);
INSERT INTO `permissions` VALUES (15832, 2, 1204, 1);
INSERT INTO `permissions` VALUES (15833, 2, 1230, 1);
INSERT INTO `permissions` VALUES (15834, 2, 1231, 1);
INSERT INTO `permissions` VALUES (15835, 2, 1232, 1);
INSERT INTO `permissions` VALUES (15836, 2, 1233, 1);
INSERT INTO `permissions` VALUES (15837, 2, 1234, 1);
INSERT INTO `permissions` VALUES (15838, 2, 1235, 1);
INSERT INTO `permissions` VALUES (15839, 2, 1250, 1);
INSERT INTO `permissions` VALUES (15840, 2, 1251, 1);
INSERT INTO `permissions` VALUES (15841, 2, 1252, 1);
INSERT INTO `permissions` VALUES (15842, 2, 1253, 1);
INSERT INTO `permissions` VALUES (15843, 2, 1300, 1);
INSERT INTO `permissions` VALUES (15844, 2, 1301, 1);
INSERT INTO `permissions` VALUES (15845, 2, 1302, 1);
INSERT INTO `permissions` VALUES (15846, 2, 1303, 1);
INSERT INTO `permissions` VALUES (15847, 2, 1304, 1);
INSERT INTO `permissions` VALUES (15848, 2, 1305, 1);
INSERT INTO `permissions` VALUES (15849, 2, 1350, 1);
INSERT INTO `permissions` VALUES (15850, 2, 1351, 1);
INSERT INTO `permissions` VALUES (15851, 2, 1352, 1);
INSERT INTO `permissions` VALUES (15852, 2, 1353, 1);
INSERT INTO `permissions` VALUES (15853, 2, 1354, 1);
INSERT INTO `permissions` VALUES (15854, 2, 1355, 1);
INSERT INTO `permissions` VALUES (15855, 2, 1400, 1);
INSERT INTO `permissions` VALUES (15856, 2, 1401, 1);
INSERT INTO `permissions` VALUES (15857, 2, 1402, 1);
INSERT INTO `permissions` VALUES (15858, 2, 1403, 1);
INSERT INTO `permissions` VALUES (15859, 2, 1404, 1);
INSERT INTO `permissions` VALUES (15860, 2, 1405, 1);
INSERT INTO `permissions` VALUES (15861, 2, 1406, 1);
INSERT INTO `permissions` VALUES (15862, 2, 1407, 1);
INSERT INTO `permissions` VALUES (15863, 2, 1408, 1);
INSERT INTO `permissions` VALUES (15864, 2, 1409, 1);
INSERT INTO `permissions` VALUES (15865, 2, 1450, 1);
INSERT INTO `permissions` VALUES (15866, 2, 1451, 1);
INSERT INTO `permissions` VALUES (15867, 2, 1452, 1);
INSERT INTO `permissions` VALUES (15868, 2, 1453, 1);
INSERT INTO `permissions` VALUES (15869, 2, 1454, 1);
INSERT INTO `permissions` VALUES (15870, 2, 1455, 1);
INSERT INTO `permissions` VALUES (15871, 2, 1456, 1);
INSERT INTO `permissions` VALUES (15872, 2, 1457, 1);
INSERT INTO `permissions` VALUES (15873, 2, 1500, 1);
INSERT INTO `permissions` VALUES (15874, 2, 1501, 1);
INSERT INTO `permissions` VALUES (15875, 2, 1502, 1);
INSERT INTO `permissions` VALUES (15876, 2, 1503, 1);
INSERT INTO `permissions` VALUES (15877, 2, 1504, 1);
INSERT INTO `permissions` VALUES (15878, 2, 1550, 1);
INSERT INTO `permissions` VALUES (15879, 2, 1551, 1);
INSERT INTO `permissions` VALUES (15880, 2, 1552, 1);
INSERT INTO `permissions` VALUES (15881, 2, 1553, 1);
INSERT INTO `permissions` VALUES (15882, 2, 1554, 1);
INSERT INTO `permissions` VALUES (15883, 2, 1600, 1);
INSERT INTO `permissions` VALUES (15884, 2, 1601, 1);
INSERT INTO `permissions` VALUES (15885, 2, 1602, 1);
INSERT INTO `permissions` VALUES (15886, 2, 1603, 1);
INSERT INTO `permissions` VALUES (15887, 2, 1604, 1);
INSERT INTO `permissions` VALUES (15888, 2, 1605, 1);
INSERT INTO `permissions` VALUES (15889, 2, 1650, 1);
INSERT INTO `permissions` VALUES (15890, 2, 1651, 1);
INSERT INTO `permissions` VALUES (15891, 2, 1652, 1);
INSERT INTO `permissions` VALUES (15892, 2, 1675, 1);
INSERT INTO `permissions` VALUES (15893, 2, 1676, 1);
INSERT INTO `permissions` VALUES (15894, 2, 1677, 1);
INSERT INTO `permissions` VALUES (15895, 2, 1678, 1);
INSERT INTO `permissions` VALUES (15896, 2, 1725, 1);
INSERT INTO `permissions` VALUES (15897, 2, 1726, 1);
INSERT INTO `permissions` VALUES (15898, 2, 1727, 1);
INSERT INTO `permissions` VALUES (15899, 2, 1728, 1);
INSERT INTO `permissions` VALUES (15900, 2, 1729, 1);
INSERT INTO `permissions` VALUES (15901, 2, 1730, 1);
INSERT INTO `permissions` VALUES (15902, 2, 1731, 1);
INSERT INTO `permissions` VALUES (15903, 2, 1732, 1);
INSERT INTO `permissions` VALUES (15904, 2, 1750, 1);
INSERT INTO `permissions` VALUES (15905, 2, 1751, 1);
INSERT INTO `permissions` VALUES (15906, 2, 1752, 1);
INSERT INTO `permissions` VALUES (15907, 2, 1753, 1);
INSERT INTO `permissions` VALUES (15908, 2, 1754, 1);
INSERT INTO `permissions` VALUES (15909, 2, 1775, 1);
INSERT INTO `permissions` VALUES (15910, 2, 1776, 1);
INSERT INTO `permissions` VALUES (15911, 2, 1777, 1);
INSERT INTO `permissions` VALUES (15912, 2, 1778, 1);
INSERT INTO `permissions` VALUES (15913, 2, 1779, 1);
INSERT INTO `permissions` VALUES (15914, 2, 1780, 1);
INSERT INTO `permissions` VALUES (15915, 2, 1781, 1);
INSERT INTO `permissions` VALUES (15916, 2, 1800, 1);
INSERT INTO `permissions` VALUES (15917, 2, 1801, 1);
INSERT INTO `permissions` VALUES (15918, 2, 1802, 1);
INSERT INTO `permissions` VALUES (15919, 2, 1803, 1);
INSERT INTO `permissions` VALUES (15920, 2, 1804, 1);
INSERT INTO `permissions` VALUES (15921, 2, 1805, 1);
INSERT INTO `permissions` VALUES (15922, 2, 1806, 1);
INSERT INTO `permissions` VALUES (15923, 2, 1807, 1);
INSERT INTO `permissions` VALUES (15924, 2, 1808, 1);
INSERT INTO `permissions` VALUES (15925, 2, 1809, 1);
INSERT INTO `permissions` VALUES (15926, 2, 1810, 1);
INSERT INTO `permissions` VALUES (15927, 2, 1811, 1);
INSERT INTO `permissions` VALUES (15928, 2, 1812, 1);
INSERT INTO `permissions` VALUES (15929, 2, 1813, 1);
INSERT INTO `permissions` VALUES (15930, 2, 1814, 1);
INSERT INTO `permissions` VALUES (15931, 2, 1815, 1);
INSERT INTO `permissions` VALUES (15932, 2, 1816, 1);
INSERT INTO `permissions` VALUES (15933, 2, 1817, 1);
INSERT INTO `permissions` VALUES (15934, 2, 1818, 1);
INSERT INTO `permissions` VALUES (15935, 2, 1819, 1);
INSERT INTO `permissions` VALUES (15936, 2, 1820, 1);
INSERT INTO `permissions` VALUES (15937, 2, 1821, 1);
INSERT INTO `permissions` VALUES (15938, 2, 1822, 1);
INSERT INTO `permissions` VALUES (15939, 2, 1823, 1);
INSERT INTO `permissions` VALUES (15940, 2, 1824, 1);
INSERT INTO `permissions` VALUES (15941, 2, 1825, 1);
INSERT INTO `permissions` VALUES (15942, 2, 1826, 1);
INSERT INTO `permissions` VALUES (15943, 2, 1827, 1);
INSERT INTO `permissions` VALUES (15944, 2, 1828, 1);
INSERT INTO `permissions` VALUES (15945, 2, 1829, 1);
INSERT INTO `permissions` VALUES (15946, 2, 1830, 1);
INSERT INTO `permissions` VALUES (15947, 2, 1831, 1);
INSERT INTO `permissions` VALUES (15948, 2, 1832, 1);
INSERT INTO `permissions` VALUES (15949, 2, 1833, 1);
INSERT INTO `permissions` VALUES (15950, 2, 1834, 1);
INSERT INTO `permissions` VALUES (15951, 2, 1835, 1);
INSERT INTO `permissions` VALUES (15952, 2, 1836, 1);
INSERT INTO `permissions` VALUES (15953, 2, 1837, 1);
INSERT INTO `permissions` VALUES (15954, 2, 1838, 1);
INSERT INTO `permissions` VALUES (15955, 2, 1850, 1);
INSERT INTO `permissions` VALUES (15956, 2, 1851, 1);
INSERT INTO `permissions` VALUES (15957, 2, 1852, 1);
INSERT INTO `permissions` VALUES (15958, 2, 1853, 1);
INSERT INTO `permissions` VALUES (15959, 2, 1875, 1);
INSERT INTO `permissions` VALUES (15960, 2, 1876, 1);
INSERT INTO `permissions` VALUES (15961, 2, 1877, 1);
INSERT INTO `permissions` VALUES (15962, 2, 1900, 1);
INSERT INTO `permissions` VALUES (15963, 2, 1901, 1);
INSERT INTO `permissions` VALUES (15964, 2, 1902, 1);
INSERT INTO `permissions` VALUES (15965, 2, 1903, 1);
INSERT INTO `permissions` VALUES (15966, 2, 1904, 1);
INSERT INTO `permissions` VALUES (15967, 2, 1905, 1);
INSERT INTO `permissions` VALUES (15968, 2, 1925, 1);
INSERT INTO `permissions` VALUES (15969, 2, 1926, 1);
INSERT INTO `permissions` VALUES (15970, 2, 1927, 1);
INSERT INTO `permissions` VALUES (15971, 2, 1928, 1);
INSERT INTO `permissions` VALUES (15972, 2, 1929, 1);
INSERT INTO `permissions` VALUES (15973, 2, 1930, 1);
INSERT INTO `permissions` VALUES (15974, 2, 1931, 1);
INSERT INTO `permissions` VALUES (15975, 2, 1932, 1);
INSERT INTO `permissions` VALUES (15976, 2, 1933, 1);
INSERT INTO `permissions` VALUES (15977, 2, 1934, 1);
INSERT INTO `permissions` VALUES (15978, 2, 1950, 1);
INSERT INTO `permissions` VALUES (15979, 2, 1951, 1);
INSERT INTO `permissions` VALUES (15980, 2, 1952, 1);
INSERT INTO `permissions` VALUES (15981, 2, 1953, 1);
INSERT INTO `permissions` VALUES (15982, 2, 1954, 1);
INSERT INTO `permissions` VALUES (15983, 2, 1975, 1);
INSERT INTO `permissions` VALUES (15984, 2, 1976, 1);
INSERT INTO `permissions` VALUES (15985, 2, 1977, 1);
INSERT INTO `permissions` VALUES (15986, 2, 1978, 1);
INSERT INTO `permissions` VALUES (15987, 2, 1979, 1);
INSERT INTO `permissions` VALUES (15988, 2, 2000, 1);
INSERT INTO `permissions` VALUES (15989, 2, 2001, 1);
INSERT INTO `permissions` VALUES (15990, 2, 2015, 1);
INSERT INTO `permissions` VALUES (15991, 2, 2016, 1);
INSERT INTO `permissions` VALUES (15992, 2, 2017, 1);
INSERT INTO `permissions` VALUES (15993, 2, 2018, 1);
INSERT INTO `permissions` VALUES (15994, 2, 2019, 1);
INSERT INTO `permissions` VALUES (15995, 2, 2020, 1);
INSERT INTO `permissions` VALUES (15996, 2, 2021, 1);
INSERT INTO `permissions` VALUES (15997, 2, 2030, 1);
INSERT INTO `permissions` VALUES (15998, 2, 2031, 1);
INSERT INTO `permissions` VALUES (15999, 2, 2032, 1);
INSERT INTO `permissions` VALUES (16000, 2, 2050, 1);
INSERT INTO `permissions` VALUES (16001, 2, 2051, 1);
INSERT INTO `permissions` VALUES (16002, 2, 2052, 1);
INSERT INTO `permissions` VALUES (16003, 2, 2053, 1);
INSERT INTO `permissions` VALUES (16004, 2, 2054, 1);
INSERT INTO `permissions` VALUES (16005, 2, 2055, 1);
INSERT INTO `permissions` VALUES (16006, 2, 2070, 1);
INSERT INTO `permissions` VALUES (16007, 2, 2071, 1);
INSERT INTO `permissions` VALUES (16008, 2, 2072, 1);
INSERT INTO `permissions` VALUES (16009, 2, 2073, 1);
INSERT INTO `permissions` VALUES (16010, 2, 2074, 1);
INSERT INTO `permissions` VALUES (16011, 2, 2075, 1);
INSERT INTO `permissions` VALUES (16012, 2, 2076, 1);
INSERT INTO `permissions` VALUES (16013, 2, 2077, 1);
INSERT INTO `permissions` VALUES (16014, 2, 2078, 1);
INSERT INTO `permissions` VALUES (16015, 2, 2079, 1);
INSERT INTO `permissions` VALUES (16016, 2, 2080, 1);
INSERT INTO `permissions` VALUES (16017, 2, 2081, 1);
INSERT INTO `permissions` VALUES (16018, 2, 2090, 1);
INSERT INTO `permissions` VALUES (16019, 2, 2091, 1);
INSERT INTO `permissions` VALUES (16020, 2, 2092, 1);
INSERT INTO `permissions` VALUES (16021, 2, 2093, 1);
INSERT INTO `permissions` VALUES (16022, 2, 3000, 1);
INSERT INTO `permissions` VALUES (16023, 2, 3001, 1);
INSERT INTO `permissions` VALUES (16024, 2, 3010, 1);
INSERT INTO `permissions` VALUES (16025, 2, 3011, 1);
INSERT INTO `permissions` VALUES (16026, 2, 3012, 1);
INSERT INTO `permissions` VALUES (16027, 2, 3013, 1);
INSERT INTO `permissions` VALUES (16028, 2, 3020, 1);
INSERT INTO `permissions` VALUES (16029, 2, 3021, 1);
INSERT INTO `permissions` VALUES (16030, 2, 3022, 1);
INSERT INTO `permissions` VALUES (16031, 2, 3023, 1);
INSERT INTO `permissions` VALUES (16032, 2, 3024, 1);
INSERT INTO `permissions` VALUES (16033, 2, 3025, 1);
INSERT INTO `permissions` VALUES (16034, 2, 3030, 1);
INSERT INTO `permissions` VALUES (16035, 2, 3031, 1);
INSERT INTO `permissions` VALUES (16036, 2, 3032, 1);
INSERT INTO `permissions` VALUES (16037, 2, 3033, 1);
INSERT INTO `permissions` VALUES (16038, 2, 3034, 1);
INSERT INTO `permissions` VALUES (16039, 2, 3035, 1);

-- ----------------------------
-- Table structure for prerequisites
-- ----------------------------
DROP TABLE IF EXISTS `prerequisites`;
CREATE TABLE `prerequisites`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `webinar_id` int UNSIGNED NOT NULL,
  `prerequisite_id` int UNSIGNED NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT 0,
  `order` int UNSIGNED NULL DEFAULT NULL,
  `created_at` int NOT NULL,
  `updated_at` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `prerequisites_webinar_id_foreign`(`webinar_id`) USING BTREE,
  INDEX `prerequisite_id`(`prerequisite_id`) USING BTREE,
  CONSTRAINT `prerequisite_id` FOREIGN KEY (`prerequisite_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `prerequisites_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 31 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of prerequisites
-- ----------------------------

-- ----------------------------
-- Table structure for product_categories
-- ----------------------------
DROP TABLE IF EXISTS `product_categories`;
CREATE TABLE `product_categories`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `parent_id` int NULL DEFAULT NULL,
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `order` int UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product_categories
-- ----------------------------

-- ----------------------------
-- Table structure for product_category_translations
-- ----------------------------
DROP TABLE IF EXISTS `product_category_translations`;
CREATE TABLE `product_category_translations`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `product_category_id` int UNSIGNED NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `product_category_id`(`product_category_id`) USING BTREE,
  INDEX `product_category_translations_locale_index`(`locale`) USING BTREE,
  CONSTRAINT `product_category_id` FOREIGN KEY (`product_category_id`) REFERENCES `product_categories` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product_category_translations
-- ----------------------------

-- ----------------------------
-- Table structure for product_discounts
-- ----------------------------
DROP TABLE IF EXISTS `product_discounts`;
CREATE TABLE `product_discounts`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `creator_id` int UNSIGNED NOT NULL,
  `product_id` int UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `percent` int UNSIGNED NOT NULL,
  `count` int UNSIGNED NULL DEFAULT NULL,
  `status` enum('active','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `start_date` int UNSIGNED NOT NULL,
  `end_date` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `product_discounts_creator_id_foreign`(`creator_id`) USING BTREE,
  INDEX `product_discounts_product_id_foreign`(`product_id`) USING BTREE,
  CONSTRAINT `product_discounts_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `product_discounts_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product_discounts
-- ----------------------------

-- ----------------------------
-- Table structure for product_faq_translations
-- ----------------------------
DROP TABLE IF EXISTS `product_faq_translations`;
CREATE TABLE `product_faq_translations`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `product_faq_id` int UNSIGNED NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `answer` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `product_faq_id`(`product_faq_id`) USING BTREE,
  INDEX `product_faq_translations_locale_index`(`locale`) USING BTREE,
  CONSTRAINT `product_faq_id` FOREIGN KEY (`product_faq_id`) REFERENCES `product_faqs` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product_faq_translations
-- ----------------------------

-- ----------------------------
-- Table structure for product_faqs
-- ----------------------------
DROP TABLE IF EXISTS `product_faqs`;
CREATE TABLE `product_faqs`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `creator_id` int UNSIGNED NOT NULL,
  `product_id` int UNSIGNED NOT NULL,
  `order` int UNSIGNED NULL DEFAULT NULL,
  `created_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `product_faqs_product_id_foreign`(`product_id`) USING BTREE,
  INDEX `product_faqs_creator_id_foreign`(`creator_id`) USING BTREE,
  CONSTRAINT `product_faqs_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `product_faqs_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product_faqs
-- ----------------------------

-- ----------------------------
-- Table structure for product_file_translations
-- ----------------------------
DROP TABLE IF EXISTS `product_file_translations`;
CREATE TABLE `product_file_translations`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `product_file_id` int UNSIGNED NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `product_file_id`(`product_file_id`) USING BTREE,
  INDEX `product_file_translations_locale_index`(`locale`) USING BTREE,
  CONSTRAINT `product_file_id` FOREIGN KEY (`product_file_id`) REFERENCES `product_files` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product_file_translations
-- ----------------------------

-- ----------------------------
-- Table structure for product_files
-- ----------------------------
DROP TABLE IF EXISTS `product_files`;
CREATE TABLE `product_files`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `creator_id` int UNSIGNED NOT NULL,
  `product_id` int UNSIGNED NOT NULL,
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `volume` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `online_viewer` tinyint(1) NOT NULL DEFAULT 0,
  `order` int UNSIGNED NULL DEFAULT NULL,
  `status` enum('active','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `created_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `file_product_id`(`product_id`) USING BTREE,
  INDEX `file_creator_id`(`creator_id`) USING BTREE,
  CONSTRAINT `file_creator_id` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `file_product_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product_files
-- ----------------------------

-- ----------------------------
-- Table structure for product_filter_option_translations
-- ----------------------------
DROP TABLE IF EXISTS `product_filter_option_translations`;
CREATE TABLE `product_filter_option_translations`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `product_filter_option_id` int UNSIGNED NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `product_filter_option_id`(`product_filter_option_id`) USING BTREE,
  INDEX `product_filter_option_translations_locale_index`(`locale`) USING BTREE,
  CONSTRAINT `product_filter_option_id` FOREIGN KEY (`product_filter_option_id`) REFERENCES `product_filter_options` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product_filter_option_translations
-- ----------------------------

-- ----------------------------
-- Table structure for product_filter_options
-- ----------------------------
DROP TABLE IF EXISTS `product_filter_options`;
CREATE TABLE `product_filter_options`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `filter_id` int UNSIGNED NOT NULL,
  `order` int UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `product_filter_options_filter_id_foreign`(`filter_id`) USING BTREE,
  CONSTRAINT `product_filter_options_filter_id_foreign` FOREIGN KEY (`filter_id`) REFERENCES `product_filters` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product_filter_options
-- ----------------------------

-- ----------------------------
-- Table structure for product_filter_translations
-- ----------------------------
DROP TABLE IF EXISTS `product_filter_translations`;
CREATE TABLE `product_filter_translations`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `product_filter_id` int UNSIGNED NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `product_filter_id`(`product_filter_id`) USING BTREE,
  INDEX `product_filter_translations_locale_index`(`locale`) USING BTREE,
  CONSTRAINT `product_filter_id` FOREIGN KEY (`product_filter_id`) REFERENCES `product_filters` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product_filter_translations
-- ----------------------------

-- ----------------------------
-- Table structure for product_filters
-- ----------------------------
DROP TABLE IF EXISTS `product_filters`;
CREATE TABLE `product_filters`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `category_id` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `product_filters_category_id_foreign`(`category_id`) USING BTREE,
  CONSTRAINT `product_filters_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `product_categories` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product_filters
-- ----------------------------

-- ----------------------------
-- Table structure for product_media
-- ----------------------------
DROP TABLE IF EXISTS `product_media`;
CREATE TABLE `product_media`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `creator_id` int UNSIGNED NOT NULL,
  `product_id` int UNSIGNED NOT NULL,
  `type` enum('thumbnail','image','video') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `order` int UNSIGNED NULL DEFAULT NULL,
  `created_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `media_product_id`(`product_id`) USING BTREE,
  INDEX `media_creator_id`(`creator_id`) USING BTREE,
  CONSTRAINT `media_creator_id` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `media_product_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 80 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product_media
-- ----------------------------

-- ----------------------------
-- Table structure for product_orders
-- ----------------------------
DROP TABLE IF EXISTS `product_orders`;
CREATE TABLE `product_orders`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `product_id` int UNSIGNED NOT NULL,
  `seller_id` int UNSIGNED NOT NULL,
  `buyer_id` int UNSIGNED NULL DEFAULT NULL,
  `sale_id` int UNSIGNED NULL DEFAULT NULL,
  `installment_order_id` int UNSIGNED NULL DEFAULT NULL,
  `gift_id` int UNSIGNED NULL DEFAULT NULL,
  `specifications` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `quantity` int UNSIGNED NOT NULL,
  `discount_id` int UNSIGNED NULL DEFAULT NULL,
  `message_to_seller` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `tracking_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `status` enum('pending','waiting_delivery','shipped','success','canceled') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `product_orders_installment_order_id_foreign`(`installment_order_id`) USING BTREE,
  INDEX `product_orders_gift_id_foreign`(`gift_id`) USING BTREE,
  CONSTRAINT `product_orders_gift_id_foreign` FOREIGN KEY (`gift_id`) REFERENCES `gifts` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `product_orders_installment_order_id_foreign` FOREIGN KEY (`installment_order_id`) REFERENCES `installment_orders` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 42 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product_orders
-- ----------------------------

-- ----------------------------
-- Table structure for product_reviews
-- ----------------------------
DROP TABLE IF EXISTS `product_reviews`;
CREATE TABLE `product_reviews`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `product_id` int UNSIGNED NOT NULL,
  `creator_id` int UNSIGNED NOT NULL,
  `product_quality` int UNSIGNED NOT NULL,
  `purchase_worth` int UNSIGNED NOT NULL,
  `delivery_quality` int UNSIGNED NOT NULL,
  `seller_quality` int UNSIGNED NOT NULL,
  `rates` char(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_at` int UNSIGNED NOT NULL,
  `status` enum('pending','active') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `product_reviews_creator_id_foreign`(`creator_id`) USING BTREE,
  INDEX `product_reviews_product_id_foreign`(`product_id`) USING BTREE,
  CONSTRAINT `product_reviews_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `product_reviews_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product_reviews
-- ----------------------------

-- ----------------------------
-- Table structure for product_selected_filter_options
-- ----------------------------
DROP TABLE IF EXISTS `product_selected_filter_options`;
CREATE TABLE `product_selected_filter_options`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `product_id` int UNSIGNED NOT NULL,
  `filter_option_id` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `product_selected_filter_options_product_id_foreign`(`product_id`) USING BTREE,
  INDEX `product_selected_filter_options_filter_option_id_foreign`(`filter_option_id`) USING BTREE,
  CONSTRAINT `product_selected_filter_options_filter_option_id_foreign` FOREIGN KEY (`filter_option_id`) REFERENCES `product_filter_options` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `product_selected_filter_options_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 95 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product_selected_filter_options
-- ----------------------------

-- ----------------------------
-- Table structure for product_selected_specification_multi_values
-- ----------------------------
DROP TABLE IF EXISTS `product_selected_specification_multi_values`;
CREATE TABLE `product_selected_specification_multi_values`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `selected_specification_id` int UNSIGNED NOT NULL,
  `specification_multi_value_id` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `selected_specification_id`(`selected_specification_id`) USING BTREE,
  INDEX `specification_multi_value_id`(`specification_multi_value_id`) USING BTREE,
  CONSTRAINT `selected_specification_id` FOREIGN KEY (`selected_specification_id`) REFERENCES `product_selected_specifications` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `specification_multi_value_id` FOREIGN KEY (`specification_multi_value_id`) REFERENCES `product_specification_multi_values` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product_selected_specification_multi_values
-- ----------------------------

-- ----------------------------
-- Table structure for product_selected_specification_translations
-- ----------------------------
DROP TABLE IF EXISTS `product_selected_specification_translations`;
CREATE TABLE `product_selected_specification_translations`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `product_selected_specification_id` int UNSIGNED NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `product_selected_specification_id_translations`(`product_selected_specification_id`) USING BTREE,
  INDEX `product_selected_specification_translations_locale_index`(`locale`) USING BTREE,
  CONSTRAINT `product_selected_specification_id_translations` FOREIGN KEY (`product_selected_specification_id`) REFERENCES `product_selected_specifications` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product_selected_specification_translations
-- ----------------------------

-- ----------------------------
-- Table structure for product_selected_specifications
-- ----------------------------
DROP TABLE IF EXISTS `product_selected_specifications`;
CREATE TABLE `product_selected_specifications`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `creator_id` int UNSIGNED NOT NULL,
  `product_id` int UNSIGNED NOT NULL,
  `product_specification_id` int UNSIGNED NOT NULL,
  `type` enum('textarea','multi_value') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `allow_selection` tinyint(1) NOT NULL DEFAULT 0,
  `order` int UNSIGNED NULL DEFAULT NULL,
  `status` enum('active','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `created_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `product_selected_specifications_creator_id_foreign`(`creator_id`) USING BTREE,
  INDEX `product_selected_specifications_product_id_foreign`(`product_id`) USING BTREE,
  INDEX `product_selected_specifications_product_specification_id_foreign`(`product_specification_id`) USING BTREE,
  CONSTRAINT `product_selected_specifications_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `product_selected_specifications_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `product_selected_specifications_product_specification_id_foreign` FOREIGN KEY (`product_specification_id`) REFERENCES `product_specifications` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product_selected_specifications
-- ----------------------------

-- ----------------------------
-- Table structure for product_specification_categories
-- ----------------------------
DROP TABLE IF EXISTS `product_specification_categories`;
CREATE TABLE `product_specification_categories`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `specification_id` int UNSIGNED NOT NULL,
  `category_id` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `product_specification_categories_specification_id_foreign`(`specification_id`) USING BTREE,
  INDEX `product_specification_categories_category_id_foreign`(`category_id`) USING BTREE,
  CONSTRAINT `product_specification_categories_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `product_categories` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `product_specification_categories_specification_id_foreign` FOREIGN KEY (`specification_id`) REFERENCES `product_specifications` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 47 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product_specification_categories
-- ----------------------------

-- ----------------------------
-- Table structure for product_specification_multi_value_translations
-- ----------------------------
DROP TABLE IF EXISTS `product_specification_multi_value_translations`;
CREATE TABLE `product_specification_multi_value_translations`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `product_specification_multi_value_id` int UNSIGNED NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `product_specification_multi_value_id`(`product_specification_multi_value_id`) USING BTREE,
  INDEX `product_specification_multi_value_translations_locale_index`(`locale`) USING BTREE,
  CONSTRAINT `product_specification_multi_value_id` FOREIGN KEY (`product_specification_multi_value_id`) REFERENCES `product_specification_multi_values` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product_specification_multi_value_translations
-- ----------------------------

-- ----------------------------
-- Table structure for product_specification_multi_values
-- ----------------------------
DROP TABLE IF EXISTS `product_specification_multi_values`;
CREATE TABLE `product_specification_multi_values`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `specification_id` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `product_specification_multi_values_specification_id_foreign`(`specification_id`) USING BTREE,
  CONSTRAINT `product_specification_multi_values_specification_id_foreign` FOREIGN KEY (`specification_id`) REFERENCES `product_specifications` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product_specification_multi_values
-- ----------------------------

-- ----------------------------
-- Table structure for product_specification_translations
-- ----------------------------
DROP TABLE IF EXISTS `product_specification_translations`;
CREATE TABLE `product_specification_translations`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `product_specification_id` int UNSIGNED NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `product_specification_id`(`product_specification_id`) USING BTREE,
  INDEX `product_specification_translations_locale_index`(`locale`) USING BTREE,
  CONSTRAINT `product_specification_id` FOREIGN KEY (`product_specification_id`) REFERENCES `product_specifications` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product_specification_translations
-- ----------------------------

-- ----------------------------
-- Table structure for product_specifications
-- ----------------------------
DROP TABLE IF EXISTS `product_specifications`;
CREATE TABLE `product_specifications`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `input_type` enum('textarea','multi_value') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product_specifications
-- ----------------------------

-- ----------------------------
-- Table structure for product_translations
-- ----------------------------
DROP TABLE IF EXISTS `product_translations`;
CREATE TABLE `product_translations`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `product_id` int UNSIGNED NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `seo_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `summary` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `product_id`(`product_id`) USING BTREE,
  INDEX `product_translations_locale_index`(`locale`) USING BTREE,
  CONSTRAINT `product_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product_translations
-- ----------------------------

-- ----------------------------
-- Table structure for products
-- ----------------------------
DROP TABLE IF EXISTS `products`;
CREATE TABLE `products`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `creator_id` int UNSIGNED NOT NULL,
  `type` enum('virtual','physical') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_id` int UNSIGNED NULL DEFAULT NULL,
  `price` double(15, 2) UNSIGNED NULL DEFAULT NULL,
  `point` bigint UNSIGNED NULL DEFAULT NULL,
  `unlimited_inventory` tinyint(1) NOT NULL DEFAULT 0,
  `ordering` tinyint(1) NOT NULL DEFAULT 0,
  `inventory` int UNSIGNED NULL DEFAULT NULL,
  `inventory_warning` int UNSIGNED NULL DEFAULT NULL,
  `inventory_updated_at` bigint UNSIGNED NULL DEFAULT NULL,
  `delivery_fee` double(15, 2) UNSIGNED NULL DEFAULT NULL,
  `delivery_estimated_time` int UNSIGNED NULL DEFAULT NULL,
  `message_for_reviewer` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `tax` int UNSIGNED NULL DEFAULT NULL,
  `commission` int UNSIGNED NULL DEFAULT NULL,
  `status` enum('active','pending','draft','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `updated_at` bigint UNSIGNED NOT NULL,
  `created_at` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `products_creator_id_foreign`(`creator_id`) USING BTREE,
  INDEX `products_category_id_foreign`(`category_id`) USING BTREE,
  INDEX `products_type_index`(`type`) USING BTREE,
  INDEX `products_slug_index`(`slug`) USING BTREE,
  CONSTRAINT `products_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `product_categories` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `products_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of products
-- ----------------------------

-- ----------------------------
-- Table structure for promotion_translations
-- ----------------------------
DROP TABLE IF EXISTS `promotion_translations`;
CREATE TABLE `promotion_translations`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `promotion_id` int UNSIGNED NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `promotion_translations_promotion_id_foreign`(`promotion_id`) USING BTREE,
  INDEX `promotion_translations_locale_index`(`locale`) USING BTREE,
  CONSTRAINT `promotion_translations_promotion_id_foreign` FOREIGN KEY (`promotion_id`) REFERENCES `promotions` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of promotion_translations
-- ----------------------------

-- ----------------------------
-- Table structure for promotions
-- ----------------------------
DROP TABLE IF EXISTS `promotions`;
CREATE TABLE `promotions`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `days` int UNSIGNED NOT NULL,
  `price` double(15, 2) UNSIGNED NOT NULL,
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_popular` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of promotions
-- ----------------------------

-- ----------------------------
-- Table structure for purchases
-- ----------------------------
DROP TABLE IF EXISTS `purchases`;
CREATE TABLE `purchases`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `webinar_id` int UNSIGNED NOT NULL,
  `user_id` int UNSIGNED NOT NULL,
  `created_at` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `purchases_webinar_id_foreign`(`webinar_id`) USING BTREE,
  INDEX `purchases_user_id_foreign`(`user_id`) USING BTREE,
  CONSTRAINT `purchases_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `purchases_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of purchases
-- ----------------------------

-- ----------------------------
-- Table structure for quiz_question_translations
-- ----------------------------
DROP TABLE IF EXISTS `quiz_question_translations`;
CREATE TABLE `quiz_question_translations`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `quizzes_question_id` int UNSIGNED NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `correct` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `quiz_question_translations_quiz_question_id_foreign`(`quizzes_question_id`) USING BTREE,
  INDEX `quiz_question_translations_locale_index`(`locale`) USING BTREE,
  CONSTRAINT `quiz_question_translations_quiz_question_id_foreign` FOREIGN KEY (`quizzes_question_id`) REFERENCES `quizzes_questions` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 58 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of quiz_question_translations
-- ----------------------------

-- ----------------------------
-- Table structure for quiz_translations
-- ----------------------------
DROP TABLE IF EXISTS `quiz_translations`;
CREATE TABLE `quiz_translations`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `quiz_id` int UNSIGNED NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `quiz_translations_quiz_id_foreign`(`quiz_id`) USING BTREE,
  INDEX `quiz_translations_locale_index`(`locale`) USING BTREE,
  CONSTRAINT `quiz_translations_quiz_id_foreign` FOREIGN KEY (`quiz_id`) REFERENCES `quizzes` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of quiz_translations
-- ----------------------------

-- ----------------------------
-- Table structure for quizzes
-- ----------------------------
DROP TABLE IF EXISTS `quizzes`;
CREATE TABLE `quizzes`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `webinar_id` int UNSIGNED NULL DEFAULT NULL,
  `creator_id` int UNSIGNED NOT NULL,
  `chapter_id` int UNSIGNED NULL DEFAULT NULL,
  `time` int NULL DEFAULT 0,
  `attempt` int NULL DEFAULT NULL,
  `pass_mark` int NOT NULL,
  `certificate` tinyint(1) NOT NULL,
  `status` enum('active','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_mark` int UNSIGNED NULL DEFAULT NULL,
  `display_limited_questions` tinyint(1) NOT NULL DEFAULT 0,
  `display_number_of_questions` int UNSIGNED NULL DEFAULT NULL,
  `display_questions_randomly` tinyint(1) NOT NULL DEFAULT 0,
  `expiry_days` int UNSIGNED NULL DEFAULT NULL,
  `created_at` int NOT NULL,
  `updated_at` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `quizzes_webinar_id_foreign`(`webinar_id`) USING BTREE,
  INDEX `quizzes_creator_id_foreign`(`creator_id`) USING BTREE,
  INDEX `quizzes_chapter_id_foreign`(`chapter_id`) USING BTREE,
  CONSTRAINT `quizzes_chapter_id_foreign` FOREIGN KEY (`chapter_id`) REFERENCES `webinar_chapters` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `quizzes_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `quizzes_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 43 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of quizzes
-- ----------------------------

-- ----------------------------
-- Table structure for quizzes_questions
-- ----------------------------
DROP TABLE IF EXISTS `quizzes_questions`;
CREATE TABLE `quizzes_questions`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `quiz_id` int UNSIGNED NOT NULL,
  `creator_id` int UNSIGNED NOT NULL,
  `grade` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` enum('multiple','descriptive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `video` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `order` int UNSIGNED NULL DEFAULT NULL,
  `created_at` int NOT NULL,
  `updated_at` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `quizzes_questions_quiz_id_foreign`(`quiz_id`) USING BTREE,
  INDEX `quizzes_questions_creator_id_foreign`(`creator_id`) USING BTREE,
  CONSTRAINT `quizzes_questions_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `quizzes_questions_quiz_id_foreign` FOREIGN KEY (`quiz_id`) REFERENCES `quizzes` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 79 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of quizzes_questions
-- ----------------------------

-- ----------------------------
-- Table structure for quizzes_questions_answer_translations
-- ----------------------------
DROP TABLE IF EXISTS `quizzes_questions_answer_translations`;
CREATE TABLE `quizzes_questions_answer_translations`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `quizzes_questions_answer_id` int UNSIGNED NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `quizzes_questions_answer_id`(`quizzes_questions_answer_id`) USING BTREE,
  INDEX `quizzes_questions_answer_translations_locale_index`(`locale`) USING BTREE,
  CONSTRAINT `quizzes_questions_answer_id` FOREIGN KEY (`quizzes_questions_answer_id`) REFERENCES `quizzes_questions_answers` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 145 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of quizzes_questions_answer_translations
-- ----------------------------

-- ----------------------------
-- Table structure for quizzes_questions_answers
-- ----------------------------
DROP TABLE IF EXISTS `quizzes_questions_answers`;
CREATE TABLE `quizzes_questions_answers`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `creator_id` int UNSIGNED NOT NULL,
  `question_id` int UNSIGNED NOT NULL,
  `image` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `correct` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` int NOT NULL,
  `updated_at` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `quizzes_questions_answers_question_id_foreign`(`question_id`) USING BTREE,
  INDEX `quizzes_questions_answers_creator_id_foreign`(`creator_id`) USING BTREE,
  CONSTRAINT `quizzes_questions_answers_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `quizzes_questions_answers_question_id_foreign` FOREIGN KEY (`question_id`) REFERENCES `quizzes_questions` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 215 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of quizzes_questions_answers
-- ----------------------------

-- ----------------------------
-- Table structure for quizzes_results
-- ----------------------------
DROP TABLE IF EXISTS `quizzes_results`;
CREATE TABLE `quizzes_results`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `quiz_id` int UNSIGNED NOT NULL,
  `user_id` int UNSIGNED NOT NULL,
  `results` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `user_grade` int NULL DEFAULT NULL,
  `status` enum('passed','failed','waiting') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `quizzes_results_quiz_id_foreign`(`quiz_id`) USING BTREE,
  INDEX `quizzes_results_user_id_foreign`(`user_id`) USING BTREE,
  CONSTRAINT `quizzes_results_quiz_id_foreign` FOREIGN KEY (`quiz_id`) REFERENCES `quizzes` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `quizzes_results_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 56 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of quizzes_results
-- ----------------------------

-- ----------------------------
-- Table structure for rating
-- ----------------------------
DROP TABLE IF EXISTS `rating`;
CREATE TABLE `rating`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `webinar_id` int UNSIGNED NOT NULL,
  `user_id` int UNSIGNED NOT NULL,
  `creator_id` int UNSIGNED NOT NULL,
  `rate` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `rating_user_id_foreign`(`user_id`) USING BTREE,
  INDEX `rating_webinar_id_foreign`(`webinar_id`) USING BTREE,
  INDEX `rating_creator_id_foreign`(`creator_id`) USING BTREE,
  CONSTRAINT `rating_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `rating_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `rating_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of rating
-- ----------------------------

-- ----------------------------
-- Table structure for regions
-- ----------------------------
DROP TABLE IF EXISTS `regions`;
CREATE TABLE `regions`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `country_id` int UNSIGNED NULL DEFAULT NULL,
  `province_id` int UNSIGNED NULL DEFAULT NULL,
  `city_id` int UNSIGNED NULL DEFAULT NULL,
  `geo_center` point NULL,
  `type` enum('country','province','city','district') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `regions_country_id_foreign`(`country_id`) USING BTREE,
  INDEX `regions_province_id_foreign`(`province_id`) USING BTREE,
  INDEX `regions_city_id_foreign`(`city_id`) USING BTREE,
  CONSTRAINT `regions_city_id_foreign` FOREIGN KEY (`city_id`) REFERENCES `regions` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `regions_country_id_foreign` FOREIGN KEY (`country_id`) REFERENCES `regions` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `regions_province_id_foreign` FOREIGN KEY (`province_id`) REFERENCES `regions` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 73 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of regions
-- ----------------------------
INSERT INTO `regions` VALUES (69, NULL, NULL, NULL, ST_GeomFromText('POINT(10.4770961392568 -73.2719760749143)'), 'country', 'Colombia', 1681486727);
INSERT INTO `regions` VALUES (70, 69, NULL, NULL, ST_GeomFromText('POINT(10.4770961392568 -73.2719760749143)'), 'province', 'Cesar', 1681486477);
INSERT INTO `regions` VALUES (71, 69, 70, NULL, ST_GeomFromText('POINT(10.4770961392568 -73.2719760749143)'), 'city', 'Valledupar', 1681486616);
INSERT INTO `regions` VALUES (72, 69, 70, 71, ST_GeomFromText('POINT(10.4770961392568 -73.2719760749143)'), 'district', 'Dev Zeros School', 1681486806);

-- ----------------------------
-- Table structure for registration_packages
-- ----------------------------
DROP TABLE IF EXISTS `registration_packages`;
CREATE TABLE `registration_packages`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `days` int UNSIGNED NOT NULL,
  `price` double(15, 2) UNSIGNED NOT NULL,
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` enum('instructors','organizations') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `instructors_count` int NULL DEFAULT NULL,
  `students_count` int NULL DEFAULT NULL,
  `courses_capacity` int NULL DEFAULT NULL,
  `courses_count` int NULL DEFAULT NULL,
  `meeting_count` int NULL DEFAULT NULL,
  `product_count` int UNSIGNED NULL DEFAULT NULL,
  `status` enum('disabled','active') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `registration_packages_role_index`(`role`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of registration_packages
-- ----------------------------

-- ----------------------------
-- Table structure for registration_packages_translations
-- ----------------------------
DROP TABLE IF EXISTS `registration_packages_translations`;
CREATE TABLE `registration_packages_translations`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `registration_package_id` int UNSIGNED NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `registration_package`(`registration_package_id`) USING BTREE,
  INDEX `registration_packages_translations_locale_index`(`locale`) USING BTREE,
  CONSTRAINT `registration_package` FOREIGN KEY (`registration_package_id`) REFERENCES `registration_packages` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of registration_packages_translations
-- ----------------------------

-- ----------------------------
-- Table structure for reserve_meetings
-- ----------------------------
DROP TABLE IF EXISTS `reserve_meetings`;
CREATE TABLE `reserve_meetings`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `meeting_id` int NULL DEFAULT NULL,
  `sale_id` int UNSIGNED NULL DEFAULT NULL,
  `meeting_time_id` int UNSIGNED NOT NULL,
  `day` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` int UNSIGNED NOT NULL,
  `start_at` bigint UNSIGNED NOT NULL,
  `end_at` bigint UNSIGNED NOT NULL,
  `user_id` int UNSIGNED NOT NULL,
  `paid_amount` decimal(13, 2) NOT NULL,
  `meeting_type` enum('in_person','online') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'online',
  `student_count` int NULL DEFAULT NULL,
  `discount` int NULL DEFAULT NULL,
  `link` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `password` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `status` enum('pending','open','finished','canceled') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` int NOT NULL,
  `locked_at` int NULL DEFAULT NULL,
  `reserved_at` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `reserve_meetings_meeting_time_id_foreign`(`meeting_time_id`) USING BTREE,
  INDEX `reserve_meetings_user_id_foreign`(`user_id`) USING BTREE,
  INDEX `reserve_meetings_sale_id_foreign`(`sale_id`) USING BTREE,
  CONSTRAINT `reserve_meetings_meeting_time_id_foreign` FOREIGN KEY (`meeting_time_id`) REFERENCES `meeting_times` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `reserve_meetings_sale_id_foreign` FOREIGN KEY (`sale_id`) REFERENCES `sales` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `reserve_meetings_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 74 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of reserve_meetings
-- ----------------------------

-- ----------------------------
-- Table structure for rewards
-- ----------------------------
DROP TABLE IF EXISTS `rewards`;
CREATE TABLE `rewards`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` enum('account_charge','create_classes','buy','pass_the_quiz','certificate','comment','register','review_courses','instructor_meeting_reserve','student_meeting_reserve','newsletters','badge','referral','learning_progress_100','charge_wallet','buy_store_product','pass_assignment','send_post_in_topic','make_topic','create_blog_by_instructor','comment_for_instructor_blog') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `score` int UNSIGNED NULL DEFAULT NULL,
  `condition` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `status` enum('active','disabled') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rewards
-- ----------------------------
INSERT INTO `rewards` VALUES (3, 'charge_wallet', 50, '150', 'active', 1641205067);
INSERT INTO `rewards` VALUES (4, 'account_charge', 50, '100', 'active', 1641369989);
INSERT INTO `rewards` VALUES (5, 'badge', NULL, NULL, 'active', 1641300755);
INSERT INTO `rewards` VALUES (6, 'create_classes', 50, NULL, 'active', 1641369921);
INSERT INTO `rewards` VALUES (7, 'buy', 50, '10', 'active', 1641369938);
INSERT INTO `rewards` VALUES (8, 'pass_the_quiz', 50, NULL, 'active', 1641369947);
INSERT INTO `rewards` VALUES (9, 'certificate', 30, NULL, 'active', 1641369955);
INSERT INTO `rewards` VALUES (10, 'comment', 5, NULL, 'active', 1641369968);
INSERT INTO `rewards` VALUES (11, 'register', 5, NULL, 'active', 1641370008);
INSERT INTO `rewards` VALUES (12, 'review_courses', 15, NULL, 'active', 1641370016);
INSERT INTO `rewards` VALUES (13, 'instructor_meeting_reserve', 30, NULL, 'active', 1641370026);
INSERT INTO `rewards` VALUES (14, 'student_meeting_reserve', 30, NULL, 'active', 1641370036);
INSERT INTO `rewards` VALUES (15, 'newsletters', 10, NULL, 'active', 1641370050);
INSERT INTO `rewards` VALUES (16, 'referral', 5, NULL, 'active', 1641370059);
INSERT INTO `rewards` VALUES (18, 'learning_progress_100', 20, NULL, 'active', 1641372957);
INSERT INTO `rewards` VALUES (19, 'buy_store_product', 50, '26', 'active', 1648277874);
INSERT INTO `rewards` VALUES (20, 'pass_assignment', 50, NULL, 'active', 1649247227);
INSERT INTO `rewards` VALUES (21, 'make_topic', 1, NULL, 'active', 1650548269);
INSERT INTO `rewards` VALUES (22, 'send_post_in_topic', 1, NULL, 'active', 1650548278);
INSERT INTO `rewards` VALUES (23, 'create_blog_by_instructor', 5, NULL, 'active', 1650788324);
INSERT INTO `rewards` VALUES (24, 'comment_for_instructor_blog', 3, NULL, 'active', 1650788336);

-- ----------------------------
-- Table structure for rewards_accounting
-- ----------------------------
DROP TABLE IF EXISTS `rewards_accounting`;
CREATE TABLE `rewards_accounting`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int UNSIGNED NOT NULL,
  `item_id` int UNSIGNED NULL DEFAULT NULL,
  `type` enum('account_charge','create_classes','buy','pass_the_quiz','certificate','comment','register','review_courses','instructor_meeting_reserve','student_meeting_reserve','newsletters','badge','referral','learning_progress_100','charge_wallet','withdraw','buy_store_product','pass_assignment','send_post_in_topic','make_topic','create_blog_by_instructor','comment_for_instructor_blog') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `score` int UNSIGNED NOT NULL,
  `status` enum('addiction','deduction') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `rewards_accounting_user_id_foreign`(`user_id`) USING BTREE,
  CONSTRAINT `rewards_accounting_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 238 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rewards_accounting
-- ----------------------------
INSERT INTO `rewards_accounting` VALUES (1, 1016, 1, 'create_classes', 50, 'addiction', 1656669565);
INSERT INTO `rewards_accounting` VALUES (217, 1, 2025, 'learning_progress_100', 20, 'addiction', 1681334168);
INSERT INTO `rewards_accounting` VALUES (218, 1016, 2025, 'create_classes', 50, 'addiction', 1681405704);
INSERT INTO `rewards_accounting` VALUES (219, 1016, 2026, 'create_classes', 50, 'addiction', 1681490971);
INSERT INTO `rewards_accounting` VALUES (220, 1016, 2027, 'create_classes', 50, 'addiction', 1683236783);
INSERT INTO `rewards_accounting` VALUES (222, 1055, 2028, 'create_classes', 50, 'addiction', 1684176202);
INSERT INTO `rewards_accounting` VALUES (227, 1060, 1060, 'register', 5, 'addiction', 1686351209);
INSERT INTO `rewards_accounting` VALUES (228, 1061, 1061, 'register', 5, 'addiction', 1686359086);
INSERT INTO `rewards_accounting` VALUES (229, 1062, 1062, 'register', 5, 'addiction', 1686451980);
INSERT INTO `rewards_accounting` VALUES (230, 1055, 2025, 'create_classes', 50, 'addiction', 1686953447);
INSERT INTO `rewards_accounting` VALUES (231, 1063, 1063, 'register', 5, 'addiction', 1687014043);
INSERT INTO `rewards_accounting` VALUES (232, 1064, 1064, 'register', 5, 'addiction', 1687488198);
INSERT INTO `rewards_accounting` VALUES (233, 1065, 1065, 'register', 5, 'addiction', 1689295027);
INSERT INTO `rewards_accounting` VALUES (234, 1066, 2029, 'create_classes', 50, 'addiction', 1692024729);
INSERT INTO `rewards_accounting` VALUES (235, 1067, 2030, 'create_classes', 50, 'addiction', 1692032150);
INSERT INTO `rewards_accounting` VALUES (236, 1068, 1068, 'register', 5, 'addiction', 1692889937);
INSERT INTO `rewards_accounting` VALUES (237, 1069, 1069, 'register', 5, 'addiction', 1693425124);

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `caption` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `users_count` int UNSIGNED NOT NULL DEFAULT 0,
  `is_admin` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of roles
-- ----------------------------
INSERT INTO `roles` VALUES (1, 'user', 'Student role', 0, 0, 1604418504);
INSERT INTO `roles` VALUES (2, 'admin', 'Admin role', 0, 1, 1604418504);
INSERT INTO `roles` VALUES (3, 'organization', 'Organization role', 0, 0, 1604418504);
INSERT INTO `roles` VALUES (4, 'teacher', 'Instructor role', 0, 0, 1604418504);
INSERT INTO `roles` VALUES (6, 'education', 'Author', 0, 1, 1613370817);

-- ----------------------------
-- Table structure for sales
-- ----------------------------
DROP TABLE IF EXISTS `sales`;
CREATE TABLE `sales`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `seller_id` int UNSIGNED NULL DEFAULT NULL,
  `buyer_id` int UNSIGNED NOT NULL,
  `order_id` int UNSIGNED NULL DEFAULT NULL,
  `webinar_id` int UNSIGNED NULL DEFAULT NULL,
  `bundle_id` int UNSIGNED NULL DEFAULT NULL,
  `meeting_id` int UNSIGNED NULL DEFAULT NULL,
  `meeting_time_id` int UNSIGNED NULL DEFAULT NULL,
  `subscribe_id` int UNSIGNED NULL DEFAULT NULL,
  `ticket_id` int UNSIGNED NULL DEFAULT NULL,
  `promotion_id` int UNSIGNED NULL DEFAULT NULL,
  `product_order_id` int UNSIGNED NULL DEFAULT NULL,
  `registration_package_id` int UNSIGNED NULL DEFAULT NULL,
  `installment_payment_id` int UNSIGNED NULL DEFAULT NULL,
  `gift_id` int UNSIGNED NULL DEFAULT NULL,
  `payment_method` enum('credit','payment_channel','subscribe') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `type` enum('webinar','meeting','subscribe','promotion','registration_package','product','bundle','installment_payment','gift') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(13, 2) UNSIGNED NOT NULL,
  `tax` decimal(13, 2) NULL DEFAULT NULL,
  `commission` decimal(13, 2) NULL DEFAULT NULL,
  `discount` decimal(13, 2) NULL DEFAULT NULL,
  `total_amount` decimal(13, 2) NULL DEFAULT NULL,
  `product_delivery_fee` decimal(13, 2) NULL DEFAULT NULL,
  `manual_added` tinyint(1) NOT NULL DEFAULT 0,
  `access_to_purchased_item` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` int UNSIGNED NOT NULL,
  `refund_at` int UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sales_order_id_foreign`(`order_id`) USING BTREE,
  INDEX `sales_webinar_id_foreign`(`webinar_id`) USING BTREE,
  INDEX `sales_meeting_id_foreign`(`meeting_id`) USING BTREE,
  INDEX `sales_ticket_id_foreign`(`ticket_id`) USING BTREE,
  INDEX `sales_buyer_id_foreign`(`buyer_id`) USING BTREE,
  INDEX `sales_seller_id_foreign`(`seller_id`) USING BTREE,
  INDEX `sales_promotion_id_foreign`(`promotion_id`) USING BTREE,
  INDEX `sales_installment_payment_id_foreign`(`installment_payment_id`) USING BTREE,
  CONSTRAINT `sales_installment_payment_id_foreign` FOREIGN KEY (`installment_payment_id`) REFERENCES `installment_order_payments` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 284 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sales
-- ----------------------------
INSERT INTO `sales` VALUES (282, 1016, 1062, NULL, 2025, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'credit', 'webinar', 0.00, NULL, NULL, NULL, 0.00, NULL, 1, 1, 1686947989, NULL);
INSERT INTO `sales` VALUES (283, 1055, 1054, NULL, 2025, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'credit', 'webinar', 0.00, NULL, NULL, NULL, 0.00, NULL, 1, 1, 1689259405, NULL);

-- ----------------------------
-- Table structure for sales_log
-- ----------------------------
DROP TABLE IF EXISTS `sales_log`;
CREATE TABLE `sales_log`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `sale_id` int UNSIGNED NOT NULL,
  `viewed_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sales_status_sale_id_foreign`(`sale_id`) USING BTREE,
  CONSTRAINT `sales_status_sale_id_foreign` FOREIGN KEY (`sale_id`) REFERENCES `sales` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 142 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sales_log
-- ----------------------------
INSERT INTO `sales_log` VALUES (140, 282, 1686947989);
INSERT INTO `sales_log` VALUES (141, 283, 1689259405);

-- ----------------------------
-- Table structure for sections
-- ----------------------------
DROP TABLE IF EXISTS `sections`;
CREATE TABLE `sections`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `section_group_id` int UNSIGNED NULL DEFAULT NULL,
  `caption` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3036 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sections
-- ----------------------------
INSERT INTO `sections` VALUES (1, 'admin_general_dashboard', NULL, 'General Dashboard');
INSERT INTO `sections` VALUES (2, 'admin_general_dashboard_show', 1, 'General Dashboard page');
INSERT INTO `sections` VALUES (3, 'admin_general_dashboard_quick_access_links', 1, 'Quick access links in General Dashboard');
INSERT INTO `sections` VALUES (4, 'admin_general_dashboard_daily_sales_statistics', 1, 'Daily Sales Type Statistics Section');
INSERT INTO `sections` VALUES (5, 'admin_general_dashboard_income_statistics', 1, 'Income Statistics Section');
INSERT INTO `sections` VALUES (6, 'admin_general_dashboard_total_sales_statistics', 1, 'Total Sales Statistics Section');
INSERT INTO `sections` VALUES (7, 'admin_general_dashboard_new_sales', 1, 'New Sales Section');
INSERT INTO `sections` VALUES (8, 'admin_general_dashboard_new_comments', 1, 'New Comments Section');
INSERT INTO `sections` VALUES (9, 'admin_general_dashboard_new_tickets', 1, 'New Tickets Section');
INSERT INTO `sections` VALUES (10, 'admin_general_dashboard_new_reviews', 1, 'New Reviews Section');
INSERT INTO `sections` VALUES (11, 'admin_general_dashboard_sales_statistics_chart', 1, 'Sales Statistics Chart');
INSERT INTO `sections` VALUES (12, 'admin_general_dashboard_recent_comments', 1, 'Recent comments Section');
INSERT INTO `sections` VALUES (13, 'admin_general_dashboard_recent_tickets', 1, 'Recent tickets Section');
INSERT INTO `sections` VALUES (14, 'admin_general_dashboard_recent_webinars', 1, 'Recent webinars Section');
INSERT INTO `sections` VALUES (15, 'admin_general_dashboard_recent_courses', 1, 'Recent courses Section');
INSERT INTO `sections` VALUES (16, 'admin_general_dashboard_users_statistics_chart', 1, 'Users Statistics Chart');
INSERT INTO `sections` VALUES (17, 'admin_clear_cache', 1, 'Clear cache');
INSERT INTO `sections` VALUES (25, 'admin_marketing_dashboard', NULL, 'Marketing Dashboard');
INSERT INTO `sections` VALUES (26, 'admin_marketing_dashboard_show', 25, 'Marketing Dashboard page');
INSERT INTO `sections` VALUES (50, 'admin_roles', NULL, 'Roles');
INSERT INTO `sections` VALUES (51, 'admin_roles_list', 50, 'Roles List');
INSERT INTO `sections` VALUES (52, 'admin_roles_create', 50, 'Roles Create');
INSERT INTO `sections` VALUES (53, 'admin_roles_edit', 50, 'Roles Edit');
INSERT INTO `sections` VALUES (54, 'admin_roles_delete', 50, 'Roles Delete');
INSERT INTO `sections` VALUES (100, 'admin_users', NULL, 'Users');
INSERT INTO `sections` VALUES (101, 'admin_staffs_list', 100, 'Staffs list');
INSERT INTO `sections` VALUES (102, 'admin_users_list', 100, 'Students list');
INSERT INTO `sections` VALUES (103, 'admin_instructors_list', 100, 'Instructors list');
INSERT INTO `sections` VALUES (104, 'admin_organizations_list', 100, 'Organizations list');
INSERT INTO `sections` VALUES (105, 'admin_users_create', 100, 'Users Create');
INSERT INTO `sections` VALUES (106, 'admin_users_edit', 100, 'Users Edit');
INSERT INTO `sections` VALUES (107, 'admin_users_delete', 100, 'Users Delete');
INSERT INTO `sections` VALUES (108, 'admin_users_export_excel', 100, 'List Export excel');
INSERT INTO `sections` VALUES (109, 'admin_users_badges', 100, 'Users Badges');
INSERT INTO `sections` VALUES (110, 'admin_users_badges_edit', 100, 'Badges edit');
INSERT INTO `sections` VALUES (111, 'admin_users_badges_delete', 100, 'Badges delete');
INSERT INTO `sections` VALUES (112, 'admin_users_impersonate', 100, 'users impersonate (login by users)');
INSERT INTO `sections` VALUES (113, 'admin_become_instructors_list', 100, 'Lists of requests for become instructors');
INSERT INTO `sections` VALUES (114, 'admin_become_instructors_reject', 100, 'Reject requests for become instructors');
INSERT INTO `sections` VALUES (115, 'admin_become_instructors_delete', 100, 'Delete requests for become instructors');
INSERT INTO `sections` VALUES (116, 'admin_update_user_registration_package', 100, 'Edit user registration package');
INSERT INTO `sections` VALUES (117, 'admin_update_user_meeting_settings', 100, 'Edit user meeting settings');
INSERT INTO `sections` VALUES (150, 'admin_webinars', NULL, 'Webinars');
INSERT INTO `sections` VALUES (151, 'admin_webinars_list', 150, 'Webinars List');
INSERT INTO `sections` VALUES (152, 'admin_webinars_create', 150, 'Webinars Create');
INSERT INTO `sections` VALUES (153, 'admin_webinars_edit', 150, 'Webinars Edit');
INSERT INTO `sections` VALUES (154, 'admin_webinars_delete', 150, 'Webinars Delete');
INSERT INTO `sections` VALUES (155, 'admin_webinars_export_excel', 150, 'Export excel webinars list');
INSERT INTO `sections` VALUES (156, 'admin_feature_webinars', 150, 'Feature webinars list');
INSERT INTO `sections` VALUES (157, 'admin_feature_webinars_create', 150, 'create feature webinar');
INSERT INTO `sections` VALUES (158, 'admin_feature_webinars_export_excel', 150, 'Feature webinar export excel');
INSERT INTO `sections` VALUES (159, 'admin_webinar_students_lists', 150, 'Webinar students Lists');
INSERT INTO `sections` VALUES (160, 'admin_webinar_students_delete', 150, 'Webinar students delete');
INSERT INTO `sections` VALUES (161, 'admin_webinar_notification_to_students', 150, 'Send notification to course students');
INSERT INTO `sections` VALUES (162, 'admin_webinar_statistics', 150, 'Course statistics');
INSERT INTO `sections` VALUES (163, 'admin_agora_history_list', 150, 'Agora history lists');
INSERT INTO `sections` VALUES (164, 'admin_agora_history_export', 150, 'Agora history export');
INSERT INTO `sections` VALUES (165, 'admin_course_question_forum_list', 150, 'Forum Question Lists');
INSERT INTO `sections` VALUES (166, 'admin_course_question_forum_answers', 150, 'Forum Answers Lists');
INSERT INTO `sections` VALUES (200, 'admin_categories', NULL, 'Categories');
INSERT INTO `sections` VALUES (201, 'admin_categories_list', 200, 'Categories List');
INSERT INTO `sections` VALUES (202, 'admin_categories_create', 200, 'Categories Create');
INSERT INTO `sections` VALUES (203, 'admin_categories_edit', 200, 'Categories Edit');
INSERT INTO `sections` VALUES (204, 'admin_categories_delete', 200, 'Categories Delete');
INSERT INTO `sections` VALUES (205, 'admin_trending_categories', 200, 'Trends Categories List');
INSERT INTO `sections` VALUES (206, 'admin_create_trending_categories', 200, 'Create Trend Categories');
INSERT INTO `sections` VALUES (207, 'admin_edit_trending_categories', 200, 'Edit Trend Categories');
INSERT INTO `sections` VALUES (208, 'admin_delete_trending_categories', 200, 'Delete Trend Categories');
INSERT INTO `sections` VALUES (250, 'admin_tags', NULL, 'Tags');
INSERT INTO `sections` VALUES (251, 'admin_tags_list', 250, 'Tags List');
INSERT INTO `sections` VALUES (252, 'admin_tags_create', 250, 'Tags Create');
INSERT INTO `sections` VALUES (253, 'admin_tags_edit', 250, 'Tags Edit');
INSERT INTO `sections` VALUES (254, 'admin_tags_delete', 250, 'Tags Delete');
INSERT INTO `sections` VALUES (300, 'admin_filters', NULL, 'Filters');
INSERT INTO `sections` VALUES (301, 'admin_filters_list', 300, 'Filters List');
INSERT INTO `sections` VALUES (302, 'admin_filters_create', 300, 'Filters Create');
INSERT INTO `sections` VALUES (303, 'admin_filters_edit', 300, 'Filters Edit');
INSERT INTO `sections` VALUES (304, 'admin_filters_delete', 300, 'Filters Delete');
INSERT INTO `sections` VALUES (350, 'admin_quizzes', NULL, 'Quizzes');
INSERT INTO `sections` VALUES (351, 'admin_quizzes_list', 350, 'Quizzes List');
INSERT INTO `sections` VALUES (352, 'admin_quizzes_create', 350, 'Create Quiz');
INSERT INTO `sections` VALUES (353, 'admin_quizzes_edit', 350, 'Edit Quiz');
INSERT INTO `sections` VALUES (354, 'admin_quizzes_delete', 350, 'Delete Quiz');
INSERT INTO `sections` VALUES (355, 'admin_quizzes_results', 350, 'Quizzes results');
INSERT INTO `sections` VALUES (356, 'admin_quizzes_results_delete', 350, 'Quizzes results delete');
INSERT INTO `sections` VALUES (357, 'admin_quizzes_lists_excel', 350, 'Quizzes export excel');
INSERT INTO `sections` VALUES (400, 'admin_quiz_result', NULL, 'Quiz Result');
INSERT INTO `sections` VALUES (401, 'admin_quiz_result_list', 400, 'Quiz Result List');
INSERT INTO `sections` VALUES (402, 'admin_quiz_result_create', 400, 'Quiz Result Create');
INSERT INTO `sections` VALUES (403, 'admin_quiz_result_edit', 400, 'Quiz Result Edit');
INSERT INTO `sections` VALUES (404, 'admin_quiz_result_delete', 400, 'Quiz Result Delete');
INSERT INTO `sections` VALUES (405, 'admin_quiz_result_export_excel', 400, 'quiz result export excel');
INSERT INTO `sections` VALUES (450, 'admin_certificate', NULL, 'Certificate');
INSERT INTO `sections` VALUES (451, 'admin_certificate_list', 450, 'Certificate List');
INSERT INTO `sections` VALUES (452, 'admin_certificate_create', 450, 'Certificate Create');
INSERT INTO `sections` VALUES (453, 'admin_certificate_edit', 450, 'Certificate Edit');
INSERT INTO `sections` VALUES (454, 'admin_certificate_delete', 450, 'Certificate Delete');
INSERT INTO `sections` VALUES (455, 'admin_certificate_template_list', 450, 'Certificate template lists');
INSERT INTO `sections` VALUES (456, 'admin_certificate_template_create', 450, 'Certificate template create');
INSERT INTO `sections` VALUES (457, 'admin_certificate_template_edit', 450, 'Certificate template edit');
INSERT INTO `sections` VALUES (458, 'admin_certificate_template_delete', 450, 'Certificate template delete');
INSERT INTO `sections` VALUES (459, 'admin_certificate_export_excel', 450, 'Certificates export excel');
INSERT INTO `sections` VALUES (460, 'admin_course_certificate_list', 450, 'Course Competition Certificates');
INSERT INTO `sections` VALUES (500, 'admin_discount_codes', NULL, 'Discount codes');
INSERT INTO `sections` VALUES (501, 'admin_discount_codes_list', 500, 'Discount codes list');
INSERT INTO `sections` VALUES (502, 'admin_discount_codes_create', 500, 'Discount codes create');
INSERT INTO `sections` VALUES (503, 'admin_discount_codes_edit', 500, 'Discount codes edit');
INSERT INTO `sections` VALUES (504, 'admin_discount_codes_delete', 500, 'Discount codes delete');
INSERT INTO `sections` VALUES (505, 'admin_discount_codes_export', 500, 'Discount codes export excel');
INSERT INTO `sections` VALUES (550, 'admin_group', NULL, 'Groups');
INSERT INTO `sections` VALUES (551, 'admin_group_list', 550, 'Groups List');
INSERT INTO `sections` VALUES (552, 'admin_group_create', 550, 'Groups Create');
INSERT INTO `sections` VALUES (553, 'admin_group_edit', 550, 'Groups Edit');
INSERT INTO `sections` VALUES (554, 'admin_group_delete', 550, 'Groups Delete');
INSERT INTO `sections` VALUES (555, 'admin_update_group_registration_package', 550, 'Update group registration package');
INSERT INTO `sections` VALUES (600, 'admin_payment_channel', NULL, 'Payment Channels');
INSERT INTO `sections` VALUES (601, 'admin_payment_channel_list', 600, 'Payment Channels List');
INSERT INTO `sections` VALUES (602, 'admin_payment_channel_toggle_status', 600, 'active or inactive channel');
INSERT INTO `sections` VALUES (603, 'admin_payment_channel_edit', 600, 'Payment Channels Edit');
INSERT INTO `sections` VALUES (650, 'admin_settings', NULL, 'settings');
INSERT INTO `sections` VALUES (651, 'admin_settings_general', 650, 'General settings');
INSERT INTO `sections` VALUES (652, 'admin_settings_financial', 650, 'Financial settings');
INSERT INTO `sections` VALUES (653, 'admin_settings_personalization', 650, 'Personalization settings');
INSERT INTO `sections` VALUES (654, 'admin_settings_notifications', 650, 'Notifications settings');
INSERT INTO `sections` VALUES (655, 'admin_settings_seo', 650, 'Seo settings');
INSERT INTO `sections` VALUES (656, 'admin_settings_customization', 650, 'Customization settings');
INSERT INTO `sections` VALUES (657, 'admin_settings_update_app', 650, 'Update App settings');
INSERT INTO `sections` VALUES (658, 'admin_settings_home_sections', 650, 'Home sections settings');
INSERT INTO `sections` VALUES (700, 'admin_blog', NULL, 'Blog');
INSERT INTO `sections` VALUES (701, 'admin_blog_lists', 700, 'Blog lists');
INSERT INTO `sections` VALUES (702, 'admin_blog_create', 700, 'Blog create');
INSERT INTO `sections` VALUES (703, 'admin_blog_edit', 700, 'Blog edit');
INSERT INTO `sections` VALUES (704, 'admin_blog_delete', 700, 'Blog delete');
INSERT INTO `sections` VALUES (705, 'admin_blog_categories', 700, 'Blog categories list');
INSERT INTO `sections` VALUES (706, 'admin_blog_categories_create', 700, 'Blog categories create');
INSERT INTO `sections` VALUES (707, 'admin_blog_categories_edit', 700, 'Blog categories edit');
INSERT INTO `sections` VALUES (708, 'admin_blog_categories_delete', 700, 'Blog categories delete');
INSERT INTO `sections` VALUES (750, 'admin_sales', NULL, 'Sales');
INSERT INTO `sections` VALUES (751, 'admin_sales_list', 750, 'Sales List');
INSERT INTO `sections` VALUES (752, 'admin_sales_refund', 750, 'Sales Refund');
INSERT INTO `sections` VALUES (753, 'admin_sales_invoice', 750, 'Sales invoice');
INSERT INTO `sections` VALUES (754, 'admin_sales_export', 750, 'Sales Export Excel');
INSERT INTO `sections` VALUES (800, 'admin_documents', NULL, 'Balances');
INSERT INTO `sections` VALUES (801, 'admin_documents_list', 800, 'Balances List');
INSERT INTO `sections` VALUES (802, 'admin_documents_create', 800, 'Balances Create');
INSERT INTO `sections` VALUES (803, 'admin_documents_print', 800, 'Balances print');
INSERT INTO `sections` VALUES (850, 'admin_payouts', NULL, 'Payout');
INSERT INTO `sections` VALUES (851, 'admin_payouts_list', 850, 'Payout List');
INSERT INTO `sections` VALUES (852, 'admin_payouts_reject', 850, 'Payout Reject');
INSERT INTO `sections` VALUES (853, 'admin_payouts_payout', 850, 'Payout accept');
INSERT INTO `sections` VALUES (854, 'admin_payouts_export_excel', 850, 'Payout export excel');
INSERT INTO `sections` VALUES (900, 'admin_offline_payments', NULL, 'Offline Payments');
INSERT INTO `sections` VALUES (901, 'admin_offline_payments_list', 900, 'Offline Payments List');
INSERT INTO `sections` VALUES (902, 'admin_offline_payments_reject', 900, 'Offline Payments Reject');
INSERT INTO `sections` VALUES (903, 'admin_offline_payments_approved', 900, 'Offline Payments Approved');
INSERT INTO `sections` VALUES (904, 'admin_offline_payments_export_excel', 900, 'Offline Payments export excel');
INSERT INTO `sections` VALUES (950, 'admin_supports', NULL, 'Supports');
INSERT INTO `sections` VALUES (951, 'admin_supports_list', 950, 'Supports List');
INSERT INTO `sections` VALUES (952, 'admin_support_send', 950, 'Send Support');
INSERT INTO `sections` VALUES (953, 'admin_supports_reply', 950, 'Supports reply');
INSERT INTO `sections` VALUES (954, 'admin_supports_delete', 950, 'Supports delete');
INSERT INTO `sections` VALUES (955, 'admin_support_departments', 950, 'Support departments lists');
INSERT INTO `sections` VALUES (956, 'admin_support_department_create', 950, 'Create support department');
INSERT INTO `sections` VALUES (957, 'admin_support_departments_edit', 950, 'Edit support departments');
INSERT INTO `sections` VALUES (958, 'admin_support_departments_delete', 950, 'Delete support department');
INSERT INTO `sections` VALUES (959, 'admin_support_course_conversations', 950, 'Course conversations');
INSERT INTO `sections` VALUES (1000, 'admin_subscribe', NULL, 'Subscribes');
INSERT INTO `sections` VALUES (1001, 'admin_subscribe_list', 1000, 'Subscribes list');
INSERT INTO `sections` VALUES (1002, 'admin_subscribe_create', 1000, 'Subscribes create');
INSERT INTO `sections` VALUES (1003, 'admin_subscribe_edit', 1000, 'Subscribes edit');
INSERT INTO `sections` VALUES (1004, 'admin_subscribe_delete', 1000, 'Subscribes delete');
INSERT INTO `sections` VALUES (1050, 'admin_notifications', NULL, 'Notifications');
INSERT INTO `sections` VALUES (1051, 'admin_notifications_list', 1050, 'Notifications list');
INSERT INTO `sections` VALUES (1052, 'admin_notifications_send', 1050, 'Send Notifications');
INSERT INTO `sections` VALUES (1053, 'admin_notifications_edit', 1050, 'Edit and details Notifications');
INSERT INTO `sections` VALUES (1054, 'admin_notifications_delete', 1050, 'Delete Notifications');
INSERT INTO `sections` VALUES (1055, 'admin_notifications_markAllRead', 1050, 'Mark All Read Notifications');
INSERT INTO `sections` VALUES (1056, 'admin_notifications_templates', 1050, 'Notifications templates');
INSERT INTO `sections` VALUES (1057, 'admin_notifications_template_create', 1050, 'Create notification template');
INSERT INTO `sections` VALUES (1058, 'admin_notifications_template_edit', 1050, 'Edit notification template');
INSERT INTO `sections` VALUES (1059, 'admin_notifications_template_delete', 1050, 'Delete notification template');
INSERT INTO `sections` VALUES (1060, 'admin_notifications_posted_list', 1050, 'Notifications Posted list');
INSERT INTO `sections` VALUES (1075, 'admin_noticeboards', NULL, 'Noticeboards');
INSERT INTO `sections` VALUES (1076, 'admin_noticeboards_list', 1075, 'Noticeboards list');
INSERT INTO `sections` VALUES (1077, 'admin_noticeboards_send', 1075, 'Send Noticeboards');
INSERT INTO `sections` VALUES (1078, 'admin_noticeboards_edit', 1075, 'Edit Noticeboards');
INSERT INTO `sections` VALUES (1079, 'admin_noticeboards_delete', 1075, 'Delete Noticeboards');
INSERT INTO `sections` VALUES (1080, 'admin_course_noticeboards_list', 1075, 'Course Noticeboards list');
INSERT INTO `sections` VALUES (1081, 'admin_course_noticeboards_send', 1075, 'Send Course Noticeboards');
INSERT INTO `sections` VALUES (1082, 'admin_course_noticeboards_edit', 1075, 'Edit Course Noticeboards');
INSERT INTO `sections` VALUES (1083, 'admin_course_noticeboards_delete', 1075, 'Delete Course Noticeboards');
INSERT INTO `sections` VALUES (1100, 'admin_promotion', NULL, 'Promotions');
INSERT INTO `sections` VALUES (1101, 'admin_promotion_list', 1100, 'Promotions list');
INSERT INTO `sections` VALUES (1102, 'admin_promotion_create', 1100, 'Promotion create');
INSERT INTO `sections` VALUES (1103, 'admin_promotion_edit', 1100, 'Promotion edit');
INSERT INTO `sections` VALUES (1104, 'admin_promotion_delete', 1100, 'Promotion delete');
INSERT INTO `sections` VALUES (1150, 'admin_testimonials', NULL, 'testimonials');
INSERT INTO `sections` VALUES (1151, 'admin_testimonials_list', 1150, 'testimonials list');
INSERT INTO `sections` VALUES (1152, 'admin_testimonials_create', 1150, 'testimonials create');
INSERT INTO `sections` VALUES (1153, 'admin_testimonials_edit', 1150, 'testimonials edit');
INSERT INTO `sections` VALUES (1154, 'admin_testimonials_delete', 1150, 'testimonials delete');
INSERT INTO `sections` VALUES (1200, 'admin_advertising', NULL, 'advertising');
INSERT INTO `sections` VALUES (1201, 'admin_advertising_banners', 1200, 'advertising banners list');
INSERT INTO `sections` VALUES (1202, 'admin_advertising_banners_create', 1200, 'create advertising banner');
INSERT INTO `sections` VALUES (1203, 'admin_advertising_banners_edit', 1200, 'edit advertising banner');
INSERT INTO `sections` VALUES (1204, 'admin_advertising_banners_delete', 1200, 'delete advertising banner');
INSERT INTO `sections` VALUES (1230, 'admin_newsletters', NULL, 'Newsletters');
INSERT INTO `sections` VALUES (1231, 'admin_newsletters_lists', 1230, 'Newsletters lists');
INSERT INTO `sections` VALUES (1232, 'admin_newsletters_send', 1230, 'Send Newsletters');
INSERT INTO `sections` VALUES (1233, 'admin_newsletters_history', 1230, 'Newsletters histories');
INSERT INTO `sections` VALUES (1234, 'admin_newsletters_delete', 1230, 'Delete newsletters item');
INSERT INTO `sections` VALUES (1235, 'admin_newsletters_export_excel', 1230, 'Export excel newsletters item');
INSERT INTO `sections` VALUES (1250, 'admin_contacts', NULL, 'Contacts');
INSERT INTO `sections` VALUES (1251, 'admin_contacts_lists', 1250, 'Contacts lists');
INSERT INTO `sections` VALUES (1252, 'admin_contacts_reply', 1250, 'Contacts reply');
INSERT INTO `sections` VALUES (1253, 'admin_contacts_delete', 1250, 'Contacts delete');
INSERT INTO `sections` VALUES (1300, 'admin_product_discount', NULL, 'product discount');
INSERT INTO `sections` VALUES (1301, 'admin_product_discount_list', 1300, 'product discount list');
INSERT INTO `sections` VALUES (1302, 'admin_product_discount_create', 1300, 'create product discount');
INSERT INTO `sections` VALUES (1303, 'admin_product_discount_edit', 1300, 'edit product discount');
INSERT INTO `sections` VALUES (1304, 'admin_product_discount_delete', 1300, 'delete product discount');
INSERT INTO `sections` VALUES (1305, 'admin_product_discount_export', 1300, 'delete product export excel');
INSERT INTO `sections` VALUES (1350, 'admin_pages', NULL, 'pages');
INSERT INTO `sections` VALUES (1351, 'admin_pages_list', 1350, 'pages list');
INSERT INTO `sections` VALUES (1352, 'admin_pages_create', 1350, 'pages create');
INSERT INTO `sections` VALUES (1353, 'admin_pages_edit', 1350, 'pages edit');
INSERT INTO `sections` VALUES (1354, 'admin_pages_toggle', 1350, 'pages toggle publish/draft');
INSERT INTO `sections` VALUES (1355, 'admin_pages_delete', 1350, 'pages delete');
INSERT INTO `sections` VALUES (1400, 'admin_comments', NULL, 'Comments');
INSERT INTO `sections` VALUES (1401, 'admin_comments_edit', 1400, 'Comments edit');
INSERT INTO `sections` VALUES (1402, 'admin_comments_reply', 1400, 'Comments reply');
INSERT INTO `sections` VALUES (1403, 'admin_comments_delete', 1400, 'Comments delete');
INSERT INTO `sections` VALUES (1404, 'admin_comments_status', 1400, 'Comments status (active or pending)');
INSERT INTO `sections` VALUES (1405, 'admin_comments_reports', 1400, 'Reports');
INSERT INTO `sections` VALUES (1406, 'admin_webinar_comments', 1400, 'Classes comments');
INSERT INTO `sections` VALUES (1407, 'admin_blog_comments', 1400, 'Blog comments');
INSERT INTO `sections` VALUES (1408, 'admin_product_comments', 1400, 'Product comments');
INSERT INTO `sections` VALUES (1409, 'admin_bundle_comments', 1400, 'Bundle comments');
INSERT INTO `sections` VALUES (1450, 'admin_reports', NULL, 'Reports');
INSERT INTO `sections` VALUES (1451, 'admin_webinar_reports', 1450, 'Classes reports');
INSERT INTO `sections` VALUES (1452, 'admin_webinar_comments_reports', 1450, 'Classes Comments reports');
INSERT INTO `sections` VALUES (1453, 'admin_webinar_reports_delete', 1450, 'Classes reports delete');
INSERT INTO `sections` VALUES (1454, 'admin_blog_comments_reports', 1450, 'Blog Comments reports');
INSERT INTO `sections` VALUES (1455, 'admin_report_reasons', 1450, 'Reports reasons');
INSERT INTO `sections` VALUES (1456, 'admin_product_comments_reports', 1450, 'Products Comments reports');
INSERT INTO `sections` VALUES (1457, 'admin_forum_topic_post_reports', 1450, 'Forum Topic Posts Reports');
INSERT INTO `sections` VALUES (1500, 'admin_additional_pages', NULL, 'Additional Pages');
INSERT INTO `sections` VALUES (1501, 'admin_additional_pages_404', 1500, '404 error page settings');
INSERT INTO `sections` VALUES (1502, 'admin_additional_pages_contact_us', 1500, 'Contact page settings');
INSERT INTO `sections` VALUES (1503, 'admin_additional_pages_footer', 1500, 'Footer settings');
INSERT INTO `sections` VALUES (1504, 'admin_additional_pages_navbar_links', 1500, 'Top Navbar links settings');
INSERT INTO `sections` VALUES (1550, 'admin_appointments', NULL, 'Appointments');
INSERT INTO `sections` VALUES (1551, 'admin_appointments_lists', 1550, 'Appointments lists');
INSERT INTO `sections` VALUES (1552, 'admin_appointments_join', 1550, 'Appointments join');
INSERT INTO `sections` VALUES (1553, 'admin_appointments_send_reminder', 1550, 'Appointments send reminder');
INSERT INTO `sections` VALUES (1554, 'admin_appointments_cancel', 1550, 'Appointments cancel');
INSERT INTO `sections` VALUES (1600, 'admin_reviews', NULL, 'Reviews');
INSERT INTO `sections` VALUES (1601, 'admin_reviews_lists', 1600, 'Reviews lists');
INSERT INTO `sections` VALUES (1602, 'admin_reviews_status_toggle', 1600, 'Reviews status toggle (publish or hidden)');
INSERT INTO `sections` VALUES (1603, 'admin_reviews_detail_show', 1600, 'Review details page');
INSERT INTO `sections` VALUES (1604, 'admin_reviews_reply', 1600, 'Review reply');
INSERT INTO `sections` VALUES (1605, 'admin_reviews_delete', 1600, 'Review delete');
INSERT INTO `sections` VALUES (1650, 'admin_consultants', NULL, 'Consultants');
INSERT INTO `sections` VALUES (1651, 'admin_consultants_lists', 1650, 'Consultants lists');
INSERT INTO `sections` VALUES (1652, 'admin_consultants_export_excel', 1650, 'Consultants export excel');
INSERT INTO `sections` VALUES (1675, 'admin_referrals', NULL, 'Referrals');
INSERT INTO `sections` VALUES (1676, 'admin_referrals_history', 1675, 'Referrals History');
INSERT INTO `sections` VALUES (1677, 'admin_referrals_users', 1675, 'Referrals users');
INSERT INTO `sections` VALUES (1678, 'admin_referrals_export', 1675, 'Export Referrals');
INSERT INTO `sections` VALUES (1725, 'admin_regions', NULL, 'Regions');
INSERT INTO `sections` VALUES (1726, 'admin_regions_countries', 1725, 'countries lists');
INSERT INTO `sections` VALUES (1727, 'admin_regions_provinces', 1725, 'provinces lists');
INSERT INTO `sections` VALUES (1728, 'admin_regions_cities', 1725, 'cities lists');
INSERT INTO `sections` VALUES (1729, 'admin_regions_districts', 1725, 'districts lists');
INSERT INTO `sections` VALUES (1730, 'admin_regions_create', 1725, 'create item');
INSERT INTO `sections` VALUES (1731, 'admin_regions_edit', 1725, 'edit item');
INSERT INTO `sections` VALUES (1732, 'admin_regions_delete', 1725, 'delete item');
INSERT INTO `sections` VALUES (1750, 'admin_rewards', NULL, 'Rewards');
INSERT INTO `sections` VALUES (1751, 'admin_rewards_history', 1750, 'Rewards history');
INSERT INTO `sections` VALUES (1752, 'admin_rewards_settings', 1750, 'Rewards settings');
INSERT INTO `sections` VALUES (1753, 'admin_rewards_items', 1750, 'Rewards items');
INSERT INTO `sections` VALUES (1754, 'admin_rewards_item_delete', 1750, 'Reward item delete');
INSERT INTO `sections` VALUES (1775, 'admin_registration_packages', NULL, 'Registration packages');
INSERT INTO `sections` VALUES (1776, 'admin_registration_packages_lists', 1775, 'packages lists');
INSERT INTO `sections` VALUES (1777, 'admin_registration_packages_new', 1775, 'New package');
INSERT INTO `sections` VALUES (1778, 'admin_registration_packages_edit', 1775, 'Edit package');
INSERT INTO `sections` VALUES (1779, 'admin_registration_packages_delete', 1775, 'Delete package');
INSERT INTO `sections` VALUES (1780, 'admin_registration_packages_reports', 1775, 'Reports');
INSERT INTO `sections` VALUES (1781, 'admin_registration_packages_settings', 1775, 'Settings');
INSERT INTO `sections` VALUES (1800, 'admin_store', NULL, 'Store');
INSERT INTO `sections` VALUES (1801, 'admin_store_products', 1800, 'Products lists');
INSERT INTO `sections` VALUES (1802, 'admin_store_new_product', 1800, 'Create New Product');
INSERT INTO `sections` VALUES (1803, 'admin_store_edit_product', 1800, 'Edit Product');
INSERT INTO `sections` VALUES (1804, 'admin_store_delete_product', 1800, 'Delete Product');
INSERT INTO `sections` VALUES (1805, 'admin_store_export_products', 1800, 'Export excel Products');
INSERT INTO `sections` VALUES (1806, 'admin_store_categories_list', 1800, 'Store Categories Lists');
INSERT INTO `sections` VALUES (1807, 'admin_store_categories_create', 1800, 'Create Store Category');
INSERT INTO `sections` VALUES (1808, 'admin_store_categories_edit', 1800, 'Edit Store Category');
INSERT INTO `sections` VALUES (1809, 'admin_store_categories_delete', 1800, 'Delete Store Category');
INSERT INTO `sections` VALUES (1810, 'admin_store_filters_list', 1800, 'Store Filters Lists');
INSERT INTO `sections` VALUES (1811, 'admin_store_filters_create', 1800, 'Create Store Filter');
INSERT INTO `sections` VALUES (1812, 'admin_store_filters_edit', 1800, 'Edit Store Filter');
INSERT INTO `sections` VALUES (1813, 'admin_store_filters_delete', 1800, 'Delete Store Filter');
INSERT INTO `sections` VALUES (1814, 'admin_store_specifications', 1800, 'Store Specifications');
INSERT INTO `sections` VALUES (1815, 'admin_store_specifications_create', 1800, 'Create New Store Specification');
INSERT INTO `sections` VALUES (1816, 'admin_store_specifications_edit', 1800, 'Edit Store Specification');
INSERT INTO `sections` VALUES (1817, 'admin_store_specifications_delete', 1800, 'Delete Store Specification');
INSERT INTO `sections` VALUES (1818, 'admin_store_discounts', 1800, 'Store Discounts Lists');
INSERT INTO `sections` VALUES (1819, 'admin_store_discounts_create', 1800, 'Create New Store discount');
INSERT INTO `sections` VALUES (1820, 'admin_store_discounts_edit', 1800, 'Edit Store discount');
INSERT INTO `sections` VALUES (1821, 'admin_store_discounts_delete', 1800, 'Delete Store discount');
INSERT INTO `sections` VALUES (1822, 'admin_store_products_orders', 1800, 'Products Orders');
INSERT INTO `sections` VALUES (1823, 'admin_store_products_orders_refund', 1800, 'Products Orders Refund');
INSERT INTO `sections` VALUES (1824, 'admin_store_products_orders_invoice', 1800, 'Products Orders View Invoice');
INSERT INTO `sections` VALUES (1825, 'admin_store_products_orders_export', 1800, 'Products Orders Export Excel');
INSERT INTO `sections` VALUES (1826, 'admin_store_products_orders_tracking_code', 1800, 'Products Orders Tracking code');
INSERT INTO `sections` VALUES (1827, 'admin_store_products_reviews', 1800, 'Reviews lists');
INSERT INTO `sections` VALUES (1828, 'admin_store_products_reviews_status_toggle', 1800, 'Reviews status toggle (publish or hidden)');
INSERT INTO `sections` VALUES (1829, 'admin_store_products_reviews_detail_show', 1800, 'Review details page');
INSERT INTO `sections` VALUES (1830, 'admin_store_products_reviews_delete', 1800, 'Review delete');
INSERT INTO `sections` VALUES (1831, 'admin_store_settings', 1800, 'Store settings');
INSERT INTO `sections` VALUES (1832, 'admin_store_in_house_products', 1800, 'In-house products');
INSERT INTO `sections` VALUES (1833, 'admin_store_in_house_orders', 1800, 'In-house Products Orders');
INSERT INTO `sections` VALUES (1834, 'admin_store_products_sellers', 1800, 'Products Sellers');
INSERT INTO `sections` VALUES (1835, 'admin_store_in_house_products_delete', 1800, 'In-house Products Delete');
INSERT INTO `sections` VALUES (1836, 'admin_store_in_house_products_export', 1800, 'In-house Products Export Excel');
INSERT INTO `sections` VALUES (1837, 'admin_store_in_house_orders', 1800, 'In-house Products Orders');
INSERT INTO `sections` VALUES (1838, 'admin_store_products_sellers', 1800, 'Products Sellers');
INSERT INTO `sections` VALUES (1850, 'admin_webinar_assignments', NULL, 'Webinar assignments');
INSERT INTO `sections` VALUES (1851, 'admin_webinar_assignments_lists', 1850, 'Assignments lists');
INSERT INTO `sections` VALUES (1852, 'admin_webinar_assignments_students', 1850, 'Assignment students');
INSERT INTO `sections` VALUES (1853, 'admin_webinar_assignments_conversations', 1850, 'Assignment students conversations');
INSERT INTO `sections` VALUES (1875, 'admin_users_not_access_content', NULL, 'Users do not have access to the content');
INSERT INTO `sections` VALUES (1876, 'admin_users_not_access_content_lists', 1875, 'Users lists');
INSERT INTO `sections` VALUES (1877, 'admin_users_not_access_content_toggle', 1875, 'Toggle active/inactive users to view content');
INSERT INTO `sections` VALUES (1900, 'admin_bundles', NULL, 'Bundles');
INSERT INTO `sections` VALUES (1901, 'admin_bundles_list', 1900, 'Bundles Lists');
INSERT INTO `sections` VALUES (1902, 'admin_bundles_create', 1900, 'Create new Bundle');
INSERT INTO `sections` VALUES (1903, 'admin_bundles_edit', 1900, 'Edit bundle');
INSERT INTO `sections` VALUES (1904, 'admin_bundles_delete', 1900, 'Delete bundle');
INSERT INTO `sections` VALUES (1905, 'admin_bundles_export_excel', 1900, 'Export excel');
INSERT INTO `sections` VALUES (1925, 'admin_forum', NULL, 'Forums');
INSERT INTO `sections` VALUES (1926, 'admin_forum_list', 1925, 'Forums Lists');
INSERT INTO `sections` VALUES (1927, 'admin_forum_create', 1925, 'Forums create');
INSERT INTO `sections` VALUES (1928, 'admin_forum_edit', 1925, 'Forums edit');
INSERT INTO `sections` VALUES (1929, 'admin_forum_delete', 1925, 'Forums delete');
INSERT INTO `sections` VALUES (1930, 'admin_forum_topics_lists', 1925, 'Forums topics lists');
INSERT INTO `sections` VALUES (1931, 'admin_forum_topics_create', 1925, 'Forums topics create');
INSERT INTO `sections` VALUES (1932, 'admin_forum_topics_delete', 1925, 'Forums topics delete');
INSERT INTO `sections` VALUES (1933, 'admin_forum_topics_posts', 1925, 'Forums topic posts');
INSERT INTO `sections` VALUES (1934, 'admin_forum_topics_create_posts', 1925, 'Forums topic store posts');
INSERT INTO `sections` VALUES (1950, 'admin_featured_topics', NULL, 'Featured topics');
INSERT INTO `sections` VALUES (1951, 'admin_featured_topics_list', 1950, 'Featured topics Lists');
INSERT INTO `sections` VALUES (1952, 'admin_featured_topics_create', 1950, 'Featured topics create');
INSERT INTO `sections` VALUES (1953, 'admin_featured_topics_edit', 1950, 'Featured topics edit');
INSERT INTO `sections` VALUES (1954, 'admin_featured_topics_delete', 1950, 'Featured topics delete');
INSERT INTO `sections` VALUES (1975, 'admin_recommended_topics', NULL, 'Recommended topics');
INSERT INTO `sections` VALUES (1976, 'admin_recommended_topics_list', 1975, 'Recommended topics Lists');
INSERT INTO `sections` VALUES (1977, 'admin_recommended_topics_create', 1975, 'Recommended topics create');
INSERT INTO `sections` VALUES (1978, 'admin_recommended_topics_edit', 1975, 'Recommended topics edit');
INSERT INTO `sections` VALUES (1979, 'admin_recommended_topics_delete', 1975, 'Recommended topics delete');
INSERT INTO `sections` VALUES (2000, 'admin_advertising_modal', NULL, 'Advertising modal');
INSERT INTO `sections` VALUES (2001, 'admin_advertising_modal_config', 2000, 'Set Advertising modal');
INSERT INTO `sections` VALUES (2015, 'admin_enrollment', NULL, 'Enrollment');
INSERT INTO `sections` VALUES (2016, 'admin_enrollment_history', 2015, 'Enrollment History');
INSERT INTO `sections` VALUES (2017, 'admin_enrollment_add_student_to_items', 2015, 'Enrollment Add Student To Items');
INSERT INTO `sections` VALUES (2018, 'admin_enrollment_block_access', 2015, 'Enrollment Block Access');
INSERT INTO `sections` VALUES (2019, 'admin_enrollment_enable_access', 2015, 'Enrollment Enable Access');
INSERT INTO `sections` VALUES (2020, 'admin_enrollment_export', 2015, 'Enrollment Export History');
INSERT INTO `sections` VALUES (2021, 'admin_enrollment_export', 2015, 'Enrollment Export History');
INSERT INTO `sections` VALUES (2030, 'admin_delete_account_requests', NULL, 'Delete Account Requests');
INSERT INTO `sections` VALUES (2031, 'admin_delete_account_requests_lists', 2030, 'Delete Account Requests Lists');
INSERT INTO `sections` VALUES (2032, 'admin_delete_account_requests_confirm', 2030, 'Delete Account Requests Confirm');
INSERT INTO `sections` VALUES (2050, 'admin_upcoming_courses', NULL, 'Upcoming Course');
INSERT INTO `sections` VALUES (2051, 'admin_upcoming_courses_list', 2050, 'Lists');
INSERT INTO `sections` VALUES (2052, 'admin_upcoming_courses_create', 2050, 'Create');
INSERT INTO `sections` VALUES (2053, 'admin_upcoming_courses_edit', 2050, 'Edit and Update');
INSERT INTO `sections` VALUES (2054, 'admin_upcoming_courses_delete', 2050, 'Delete');
INSERT INTO `sections` VALUES (2055, 'admin_upcoming_courses_followers', 2050, 'Followers');
INSERT INTO `sections` VALUES (2070, 'admin_installments', NULL, 'Installments');
INSERT INTO `sections` VALUES (2071, 'admin_installments_list', 2070, 'Lists');
INSERT INTO `sections` VALUES (2072, 'admin_installments_create', 2070, 'Create');
INSERT INTO `sections` VALUES (2073, 'admin_installments_edit', 2070, 'Edit and Update');
INSERT INTO `sections` VALUES (2074, 'admin_installments_delete', 2070, 'Delete');
INSERT INTO `sections` VALUES (2075, 'admin_installments_settings', 2070, 'Settings');
INSERT INTO `sections` VALUES (2076, 'admin_installments_purchases', 2070, 'Purchases');
INSERT INTO `sections` VALUES (2077, 'admin_installments_overdue_lists', 2070, 'Overdue Installments');
INSERT INTO `sections` VALUES (2078, 'admin_installments_overdue_history', 2070, 'Overdue History');
INSERT INTO `sections` VALUES (2079, 'admin_installments_verification_requests', 2070, 'Verification Requests');
INSERT INTO `sections` VALUES (2080, 'admin_installments_verified_users', 2070, 'Verified Users');
INSERT INTO `sections` VALUES (2081, 'admin_installments_orders', 2070, 'Approve/Reject/Refund Requests');
INSERT INTO `sections` VALUES (2090, 'admin_registration_bonus', NULL, 'Registration Bonus');
INSERT INTO `sections` VALUES (2091, 'admin_registration_bonus_history', 2090, 'History');
INSERT INTO `sections` VALUES (2092, 'admin_registration_bonus_settings', 2090, 'Settings');
INSERT INTO `sections` VALUES (2093, 'admin_registration_bonus_export_excel', 2090, 'Export Excel');
INSERT INTO `sections` VALUES (3000, 'admin_floating_bar', NULL, 'Top/Bottom Floating Bar');
INSERT INTO `sections` VALUES (3001, 'admin_floating_bar_create', 3000, 'Create/Edit');
INSERT INTO `sections` VALUES (3010, 'admin_cashback', NULL, 'Cashback');
INSERT INTO `sections` VALUES (3011, 'admin_cashback_rules', 3010, 'Rules');
INSERT INTO `sections` VALUES (3012, 'admin_cashback_transactions', 3010, 'Transactions');
INSERT INTO `sections` VALUES (3013, 'admin_cashback_history', 3010, 'History');
INSERT INTO `sections` VALUES (3020, 'admin_waitlists', NULL, 'Waitlists');
INSERT INTO `sections` VALUES (3021, 'admin_waitlists_lists', 3020, 'Lists');
INSERT INTO `sections` VALUES (3022, 'admin_waitlists_users', 3020, 'Joined Users');
INSERT INTO `sections` VALUES (3023, 'admin_waitlists_exports', 3020, 'Export excel lists');
INSERT INTO `sections` VALUES (3024, 'admin_waitlists_clear_list', 3020, 'Clear lists');
INSERT INTO `sections` VALUES (3025, 'admin_waitlists_disable', 3020, 'Disable');
INSERT INTO `sections` VALUES (3030, 'admin_gift', NULL, 'Gifts');
INSERT INTO `sections` VALUES (3031, 'admin_gift_history', 3030, 'History');
INSERT INTO `sections` VALUES (3032, 'admin_gift_send_reminder', 3030, 'Send Reminder');
INSERT INTO `sections` VALUES (3033, 'admin_gift_cancel', 3030, 'Cancel');
INSERT INTO `sections` VALUES (3034, 'admin_gift_settings', 3030, 'Settings');
INSERT INTO `sections` VALUES (3035, 'admin_gift_export', 3030, 'Export Excel');

-- ----------------------------
-- Table structure for session_reminds
-- ----------------------------
DROP TABLE IF EXISTS `session_reminds`;
CREATE TABLE `session_reminds`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `session_id` int UNSIGNED NOT NULL,
  `user_id` int UNSIGNED NOT NULL,
  `created_at` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `session_reminds_session_id_foreign`(`session_id`) USING BTREE,
  INDEX `session_reminds_user_id_foreign`(`user_id`) USING BTREE,
  CONSTRAINT `session_reminds_session_id_foreign` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `session_reminds_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of session_reminds
-- ----------------------------

-- ----------------------------
-- Table structure for session_translations
-- ----------------------------
DROP TABLE IF EXISTS `session_translations`;
CREATE TABLE `session_translations`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `session_id` int UNSIGNED NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `session_translations_session_id_foreign`(`session_id`) USING BTREE,
  INDEX `session_translations_locale_index`(`locale`) USING BTREE,
  CONSTRAINT `session_translations_session_id_foreign` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 59 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of session_translations
-- ----------------------------

-- ----------------------------
-- Table structure for sessions
-- ----------------------------
DROP TABLE IF EXISTS `sessions`;
CREATE TABLE `sessions`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `creator_id` int UNSIGNED NOT NULL,
  `webinar_id` int UNSIGNED NULL DEFAULT NULL,
  `chapter_id` int UNSIGNED NULL DEFAULT NULL,
  `reserve_meeting_id` int UNSIGNED NULL DEFAULT NULL,
  `date` int NOT NULL,
  `duration` int NOT NULL,
  `link` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `extra_time_to_join` int UNSIGNED NULL DEFAULT NULL COMMENT 'Specifies that the user can see the join button up to a few minutes after the start time of the webinar.',
  `zoom_start_link` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `zoom_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `session_api` enum('local','big_blue_button','zoom','agora','jitsi','google_meet') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'local',
  `api_secret` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `moderator_secret` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `agora_settings` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `check_previous_parts` tinyint(1) NOT NULL DEFAULT 0,
  `access_after_day` int UNSIGNED NULL DEFAULT NULL,
  `order` int UNSIGNED NULL DEFAULT NULL,
  `status` enum('active','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `created_at` int NOT NULL,
  `updated_at` int NULL DEFAULT NULL,
  `deleted_at` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sessions_webinar_id_foreign`(`webinar_id`) USING BTREE,
  INDEX `sessions_creator_id_foreign`(`creator_id`) USING BTREE,
  INDEX `sessions_chapter_id_foreign`(`chapter_id`) USING BTREE,
  INDEX `sessions_reserve_meeting_id_foreign`(`reserve_meeting_id`) USING BTREE,
  CONSTRAINT `sessions_chapter_id_foreign` FOREIGN KEY (`chapter_id`) REFERENCES `webinar_chapters` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `sessions_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `sessions_reserve_meeting_id_foreign` FOREIGN KEY (`reserve_meeting_id`) REFERENCES `reserve_meetings` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `sessions_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 104 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sessions
-- ----------------------------

-- ----------------------------
-- Table structure for setting_translations
-- ----------------------------
DROP TABLE IF EXISTS `setting_translations`;
CREATE TABLE `setting_translations`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `setting_id` int UNSIGNED NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `setting_translations_setting_id_foreign`(`setting_id`) USING BTREE,
  INDEX `setting_translations_locale_index`(`locale`) USING BTREE,
  CONSTRAINT `setting_translations_setting_id_foreign` FOREIGN KEY (`setting_id`) REFERENCES `settings` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 79 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of setting_translations
-- ----------------------------
INSERT INTO `setting_translations` VALUES (1, 1, 'en', '{\"home\":{\"title\":\"Home\",\"description\":\"home page Description\",\"robot\":\"index\"},\"search\":{\"title\":\"Search\",\"description\":\"search page Description\",\"robot\":\"index\"},\"categories\":{\"title\":\"Category\",\"description\":\"categories page Description\",\"robot\":\"index\"},\"login\":{\"title\":\"Login\",\"description\":\"login page description\",\"robot\":\"index\"},\"register\":{\"title\":\"Register\",\"description\":\"register page Description\",\"robot\":\"index\"},\"about\":{\"title\":\"about page title\",\"description\":\"about page Description\"},\"contact\":{\"title\":\"Contact\",\"description\":\"contact page Description\",\"robot\":\"index\"},\"certificate_validation\":{\"title\":\"Certificate validation\",\"description\":\"Certificate validation description\",\"robot\":\"index\"},\"classes\":{\"title\":\"Courses\",\"description\":\"Courses page Description\",\"robot\":\"index\"},\"blog\":{\"title\":\"Blog\",\"description\":\"Blog page description\",\"robot\":\"index\"},\"instructors\":{\"title\":\"Instructors\",\"description\":\"instructors page Description\",\"robot\":\"index\"},\"organizations\":{\"title\":\"Organizations\",\"description\":\"Organizations page description\",\"robot\":\"index\"},\"instructor_finder_wizard\":{\"title\":\"Instructor finder wizard\",\"description\":\"Instructor finder wizard description\",\"robot\":\"noindex\"},\"instructor_finder\":{\"title\":\"Instructor finder\",\"description\":\"Instructor finder description\",\"robot\":\"index\"},\"reward_courses\":{\"title\":\"Reward courses\",\"description\":\"Reward courses description\",\"robot\":\"index\"},\"products_lists\":{\"title\":\"Store Products\",\"description\":\"Store Products Description\",\"robot\":\"noindex\"},\"reward_products\":{\"title\":\"Reward Products\",\"description\":\"Reward Products Description\",\"robot\":\"noindex\"},\"forum\":{\"title\":\"Forums\",\"description\":\"Forums Description\",\"robot\":\"noindex\"},\"upcoming_courses_lists\":{\"title\":\"Upcoming Course\",\"description\":\"Upcoming courses description\",\"robot\":\"noindex\"}}');
INSERT INTO `setting_translations` VALUES (2, 2, 'en', '{\"Instagram\":{\"title\":\"Instagram\",\"image\":\"\\/store\\/1\\/default_images\\/social\\/instagram.svg\",\"link\":\"https:\\/\\/www.instagram.com\\/devzeros_school\\/\",\"order\":\"1\"},\"Whatsapp\":{\"title\":\"Whatsapp\",\"image\":\"\\/store\\/1\\/default_images\\/social\\/whatsapp.svg\",\"link\":\"https:\\/\\/api.whatsapp.com\\/send?phone=3127834324\",\"order\":\"2\"},\"Facebook\":{\"title\":\"Facebook\",\"image\":\"\\/store\\/1\\/default_images\\/social\\/facebook.svg\",\"link\":\"https:\\/\\/www.facebook.com\\/DevzerosSchool\",\"order\":\"4\"}}');
INSERT INTO `setting_translations` VALUES (3, 4, 'fa', '{\"first_column\":{\"title\":\"\\u0633\\u062a\\u0648\\u0646 \\u0627\\u0648\\u0644\",\"value\":\"<p>\\u0644\\u06cc\\u0646\\u06a9 \\u06f1<\\/p><p>\\u0644\\u06cc\\u0646\\u06a9 \\u06f2<\\/p><p>\\u0644\\u06cc\\u0646\\u06a9 \\u06f3<\\/p>\"},\"second_column\":{\"title\":\"\\u0633\\u062a\\u0648\\u0646 \\u062f\\u0648\\u0645\",\"value\":\"<p>\\u0644\\u06cc\\u0646\\u06a9 1<\\/p><p>\\u0644\\u06cc\\u0646\\u06a9 2<\\/p><p>\\u0644\\u06cc\\u0646\\u06a9 3<\\/p>\"},\"third_column\":{\"title\":\"\\u0633\\u062a\\u0648\\u0646 \\u0633\\u0648\\u0645\",\"value\":\"<p>\\u0644\\u06cc\\u0646\\u06a9 1<\\/p><p>\\u0644\\u06cc\\u0646\\u06a9 \\u06f2<\\/p><p>\\u0644\\u06cc\\u0646\\u06a9 \\u06f3<\\/p>\"},\"forth_column\":{\"title\":\"\\u0633\\u062a\\u0648\\u0646 \\u0686\\u0647\\u0627\\u0631\",\"value\":\"<p>\\u0644\\u06cc\\u0646\\u06a9 1<\\/p><p>\\u0644\\u06cc\\u0646\\u06a9 \\u06f2<\\/p><p>\\u0644\\u06cc\\u0646\\u06a9 \\u06f3<\\/p><p>\\u0644\\u06cc\\u0646\\u06a9 \\u06f4<\\/p>\"}}');
INSERT INTO `setting_translations` VALUES (4, 5, 'en', '{\"site_name\":\"DevZeros School\",\"site_email\":\"no-response@devzeros.com\",\"site_phone\":\"(605)5892742\",\"site_language\":\"ES\",\"register_method\":\"email\",\"default_time_zone\":\"America\\/Bogota\",\"date_format\":\"textual\",\"time_format\":\"12_hours\",\"user_languages\":[\"ES\"],\"rtl_languages\":[\"AR\"],\"fav_icon\":\"\\/store\\/1\\/DevZeroFavicon.png\",\"logo\":\"\\/store\\/1\\/logos school 2_Mesa de trabajo 1 copia.png\",\"footer_logo\":\"\\/store\\/1\\/default_images\\/footer-white.png\",\"rtl_layout\":\"0\",\"preloading\":\"1\",\"hero_section1\":\"0\",\"hero_section2\":\"1\",\"content_translate\":\"0\",\"app_debugbar\":\"0\"}');
INSERT INTO `setting_translations` VALUES (5, 6, 'en', '{\"commission\":\"20\",\"tax\":\"10\",\"minimum_payout\":\"50\",\"currency\":\"USD\",\"currency_position\":\"left\",\"price_display\":\"only_price\"}');
INSERT INTO `setting_translations` VALUES (6, 8, 'en', '{\"title\":\"Joy of learning & teaching...\",\"description\":\"Rocket LMS is a fully-featured educational platform that helps instructors to create and publish video courses, live classes, and text courses and earn money, and helps students to learn in the easiest way.\",\"hero_background\":\"\\/store\\/1\\/default_images\\/hero_1.jpg\"}');
INSERT INTO `setting_translations` VALUES (7, 12, 'en', '{\"css\":null,\"js\":null}');
INSERT INTO `setting_translations` VALUES (8, 14, 'en', '{\"admin_login\":\"\\/store\\/1\\/default_images\\/admin_login.jpg\",\"admin_dashboard\":\"\\/store\\/1\\/default_images\\/admin_dashboard.jpg\",\"login\":\"\\/store\\/1\\/default_images\\/front_login.jpg\",\"register\":\"\\/store\\/1\\/default_images\\/front_register.jpg\",\"remember_pass\":\"\\/store\\/1\\/default_images\\/password_recovery.jpg\",\"verification\":\"\\/store\\/1\\/default_images\\/verification.jpg\",\"search\":\"\\/store\\/1\\/default_images\\/search_cover.png\",\"categories\":\"\\/store\\/1\\/default_images\\/category_cover.png\",\"become_instructor\":\"\\/store\\/1\\/default_images\\/become_instructor.jpg\",\"certificate_validation\":\"\\/store\\/1\\/default_images\\/certificate_validation.jpg\",\"blog\":\"\\/store\\/1\\/default_images\\/blogs_cover.png\",\"instructors\":\"\\/store\\/1\\/default_images\\/instructors_cover.png\",\"organizations\":\"\\/store\\/1\\/default_images\\/organizations_cover.png\",\"dashboard\":\"\\/store\\/1\\/dashboard.png\",\"user_cover\":\"\\/store\\/1\\/default_images\\/default_cover.jpg\",\"instructor_finder_wizard\":\"\\/store\\/1\\/default_images\\/instructor_finder_wizard.jpg\",\"products_lists\":\"\\/store\\/1\\/default_images\\/category_cover.png\",\"upcoming_courses_lists\":\"\\/store\\/1\\/335419394_246438101146421_7903927185410301892_n.jpg\"}');
INSERT INTO `setting_translations` VALUES (9, 15, 'en', '{\"title\":\"Joy of learning & teaching...\",\"description\":\"Rocket LMS is a fully-featured educational platform that helps instructors to create and publish video courses, live classes, and text courses and earn money, and helps students to learn in the easiest way.\",\"hero_background\":\"\\/assets\\/default\\/img\\/home\\/world.png\",\"hero_vector\":\"\\/store\\/1\\/animated-header.json\",\"has_lottie\":\"1\"}');
INSERT INTO `setting_translations` VALUES (10, 20, 'en', '[\"Inappropriate Course Content\",\"Inappropriate Behavior\",\"Policy Violation\",\"Spammy Content\",\"Other\"]');
INSERT INTO `setting_translations` VALUES (11, 22, 'en', '{\"new_comment_admin\":\"7\",\"support_message_admin\":\"10\",\"support_message_replied_admin\":\"11\",\"promotion_plan_admin\":\"29\",\"new_contact_message\":\"26\",\"new_badge\":\"2\",\"change_user_group\":\"3\",\"course_created\":\"4\",\"course_approve\":\"5\",\"course_reject\":\"6\",\"new_comment\":\"7\",\"support_message\":\"8\",\"support_message_replied\":\"9\",\"new_rating\":\"17\",\"webinar_reminder\":\"27\",\"new_financial_document\":\"12\",\"payout_request\":\"13\",\"payout_proceed\":\"14\",\"offline_payment_request\":\"18\",\"offline_payment_approved\":\"19\",\"offline_payment_rejected\":\"20\",\"new_sales\":\"15\",\"new_purchase\":\"16\",\"new_subscribe_plan\":\"21\",\"promotion_plan\":\"28\",\"new_appointment\":\"22\",\"new_appointment_link\":\"23\",\"appointment_reminder\":\"24\",\"meeting_finished\":\"25\",\"new_certificate\":\"30\",\"waiting_quiz\":\"31\",\"waiting_quiz_result\":\"32\",\"payout_request_admin\":\"13\",\"product_new_sale\":\"33\",\"product_new_purchase\":\"34\",\"product_new_comment\":\"35\",\"product_tracking_code\":\"36\",\"product_new_rating\":\"37\",\"product_receive_shipment\":\"38\",\"product_out_of_stock\":\"39\",\"student_send_message\":\"40\",\"instructor_send_message\":\"41\",\"instructor_set_grade\":\"42\",\"send_post_in_topic\":\"44\",\"publish_instructor_blog_post\":\"45\",\"new_comment_for_instructor_blog_post\":\"46\",\"meeting_reserve_reminder\":\"47\",\"subscribe_reminder\":\"48\",\"reminder_gift_to_receipt\":\"52\",\"gift_sender_confirmation\":\"53\",\"gift_sender_notification\":\"54\",\"admin_gift_submission\":\"55\",\"admin_gift_sending_confirmation\":\"56\",\"reminder_installments_before_overdue\":\"57\",\"installment_due_reminder\":\"58\",\"reminder_installments_after_overdue\":\"59\",\"approve_installment_verification_request\":\"60\",\"reject_installment_verification_request\":\"61\",\"paid_installment_step\":\"62\",\"paid_installment_step_for_admin\":\"63\",\"paid_installment_upfront\":\"64\",\"installment_verification_request_sent\":\"65\",\"admin_installment_verification_request_sent\":\"66\",\"instalment_request_submitted\":\"67\",\"instalment_request_submitted_for_admin\":\"68\",\"upcoming_course_submission\":\"69\",\"upcoming_course_submission_for_admin\":\"70\",\"upcoming_course_approved\":\"71\",\"upcoming_course_rejected\":\"72\",\"upcoming_course_published\":\"73\",\"upcoming_course_followed\":\"74\",\"upcoming_course_published_for_followers\":\"75\",\"user_get_cashback\":\"76\",\"user_get_cashback_notification_for_admin\":\"77\",\"bundle_submission\":\"78\",\"bundle_submission_for_admin\":\"79\",\"bundle_approved\":\"80\",\"bundle_rejected\":\"81\",\"new_review_for_bundle\":\"82\",\"registration_bonus_achieved\":\"83\",\"registration_bonus_unlocked\":\"84\",\"registration_bonus_unlocked_for_admin\":\"85\",\"registration_package_activated\":\"86\",\"registration_package_activated_for_admin\":\"87\",\"registration_package_expired\":\"87\",\"contact_message_submission\":\"88\",\"contact_message_submission_for_admin\":\"89\",\"waitlist_submission\":\"90\",\"waitlist_submission_for_admin\":\"91\",\"new_referral_user\":\"92\",\"user_role_change\":\"97\",\"add_to_user_group\":\"98\",\"become_instructor_request_approved\":\"99\",\"become_instructor_request_rejected\":\"100\",\"new_question_in_forum\":\"101\",\"new_answer_in_forum\":\"102\",\"new_appointment_session\":\"103\",\"new_quiz\":\"93\",\"user_get_new_point\":\"94\",\"new_course_notice\":\"96\",\"new_registration\":\"104\",\"new_become_instructor_request\":\"105\",\"new_course_enrollment\":\"106\",\"new_forum_topic\":\"107\",\"new_report_item_for_admin\":\"108\",\"new_item_created\":\"109\",\"new_store_order\":\"110\",\"subscription_plan_activated\":\"111\",\"content_review_request\":\"112\",\"new_user_blog_post\":\"113\",\"new_user_item_rating\":\"114\",\"new_organization_user\":\"115\",\"user_wallet_charge\":\"116\",\"new_user_payout_request\":\"117\",\"new_offline_payment_request\":\"118\",\"user_access_to_content\":\"119\"}');
INSERT INTO `setting_translations` VALUES (12, 23, 'en', '{\"540\":{\"title\":\"Qatar National Bank\",\"image\":\"\\/store\\/1\\/default_images\\/offline_payments\\/Qatar National Bank.png\",\"card_id\":\"2578-4910-3682-6288\",\"account_id\":\"38152294372\",\"iban\":\"QA66QUWW934528129454345775226\"},\"334\":{\"title\":\"State Bank of India\",\"image\":\"\\/store\\/1\\/default_images\\/offline_payments\\/State Bank of India.png\",\"card_id\":\"6282-4518-1237-7641\",\"account_id\":\"56238341127\",\"iban\":\"IN37ABNA2422193788\"},\"jhgDW\":{\"title\":\"JPMorgan\",\"image\":\"\\/store\\/1\\/default_images\\/offline_payments\\/jpmorgan.png\",\"card_id\":\"5012-4518-1772-8911\",\"account_id\":\"46237751125\",\"iban\":\"NL37ABNA2423554788\"}}');
INSERT INTO `setting_translations` VALUES (13, 24, 'en', '{\"background\":\"\\/store\\/1\\/default_images\\/category_cover.png\",\"latitude\":\"43.45905\",\"longitude\":\"11.87300\",\"map_zoom\":\"16\",\"phones\":\"415-716-1166 , 415-716-1167\",\"emails\":\"mail@lms.rocket-soft.org , info@lms.rocket-soft.org\",\"address\":\"4193 Roosevelt Street\\r\\nSan Francisco, CA 94103\"}');
INSERT INTO `setting_translations` VALUES (14, 25, 'en', '{\"latest_classes\":\"1\",\"best_sellers\":\"1\",\"free_classes\":\"1\",\"discount_classes\":\"1\",\"best_rates\":\"1\",\"trend_categories\":\"1\",\"testimonials\":\"1\",\"subscribes\":\"1\",\"blog\":\"1\",\"organizations\":\"1\",\"instructors\":\"1\",\"video_or_image_section\":\"1\",\"find_instructors\":\"1\",\"reward_program\":\"1\"}');
INSERT INTO `setting_translations` VALUES (15, 26, 'en', '{\"02nh9a\":{\"title\":\"Home\",\"link\":\"\\/\",\"order\":\"1\"},\"1cH2kF\":{\"title\":\"Courses\",\"link\":\"\\/classes?sort=newest\",\"order\":\"2\"},\"gGf8Lv\":{\"title\":\"Instructors\",\"link\":\"\\/instructor-finder\",\"order\":\"3\"}}');
INSERT INTO `setting_translations` VALUES (16, 27, 'en', '{\"link\":\"\\/classes\",\"title\":\"Start learning anywhere, anytime...\",\"description\":\"Use Rocket LMS to access high-quality education materials without any limitations in the easiest way.\",\"background\":\"\\/store\\/1\\/default_images\\/home_video_section.png\"}');
INSERT INTO `setting_translations` VALUES (17, 28, 'en', '{\"error_image\":\"\\/store\\/1\\/default_images\\/404.svg\",\"error_title\":\"Page not found!\",\"error_description\":\"Sorry, this page is not available...\"}');
INSERT INTO `setting_translations` VALUES (18, 29, 'en', '{\"link\":\"\\/classes?sort=newest\",\"background\":\"\\/store\\/1\\/sidebar-user.png\"}');
INSERT INTO `setting_translations` VALUES (19, 30, 'en', '{\"status\":\"0\",\"users_affiliate_status\":\"0\",\"affiliate_user_commission\":\"5\",\"store_affiliate_user_commission\":\"5\",\"affiliate_user_amount\":\"20\",\"referred_user_amount\":\"10\",\"referral_description\":\"You can share your affiliate URL you will get the above rewards when a user uses the platform.\"}');
INSERT INTO `setting_translations` VALUES (20, 4, 'en', '{\"first_column\":{\"title\":\"About US\",\"value\":\"<p><font color=\\\"#ffffff\\\">Rocket LMS is a fully-featured learning management system that helps you to run your education business in several hours. This platform helps instructors to create professional education materials and helps students to learn from the best instructors.<\\/font><\\/p>\"},\"second_column\":{\"title\":\"Additional Links\",\"value\":\"<p><a href=\\\"\\/login\\\"><font color=\\\"#ffffff\\\">- Login<\\/font><\\/a><\\/p><p><font color=\\\"#ffffff\\\"><a href=\\\"\\/register\\\"><font color=\\\"#ffffff\\\">- Register<\\/font><\\/a><br><\\/font><\\/p><p><a href=\\\"\\/blog\\\"><font color=\\\"#ffffff\\\">- Blog<\\/font><\\/a><\\/p><p><a href=\\\"\\/contact\\\"><font color=\\\"#ffffff\\\">- Contact us<\\/font><\\/a><\\/p><p><font color=\\\"#ffffff\\\"><a href=\\\"\\/certificate_validation\\\"><font color=\\\"#ffffff\\\">- Certificate validation<\\/font><\\/a><br><\\/font><\\/p><p><font color=\\\"#ffffff\\\"><a href=\\\"\\/become-instructor\\\"><font color=\\\"#ffffff\\\">- Become instructor<\\/font><\\/a><br><\\/font><\\/p><p><a href=\\\"\\/pages\\/terms\\\"><font color=\\\"#ffffff\\\">- Terms &amp; rules<\\/font><\\/a><\\/p><p><a href=\\\"\\/pages\\/about\\\"><font color=\\\"#ffffff\\\">- About us<\\/font><\\/a><br><\\/p>\"},\"third_column\":{\"title\":\"Similar Businesses\",\"value\":\"<p><a href=\\\"https:\\/\\/www.udemy.com\\/\\\" target=\\\"_blank\\\"><font color=\\\"#ffffff\\\">- Udemy<\\/font><\\/a><\\/p><p><a href=\\\"https:\\/\\/www.skillshare.com\\/\\\" target=\\\"_blank\\\"><font color=\\\"#ffffff\\\">- Skillshare<\\/font><\\/a><\\/p><p><a href=\\\"https:\\/\\/www.coursera.org\\/\\\" target=\\\"_blank\\\"><font color=\\\"#ffffff\\\">- Coursera<\\/font><\\/a><\\/p><p><a href=\\\"https:\\/\\/www.linkedin.com\\/learning\\/\\\" target=\\\"_blank\\\"><font color=\\\"#ffffff\\\">- Lynda<\\/font><\\/a><\\/p><p><a href=\\\"https:\\/\\/www.skillsoft.com\\/\\\" target=\\\"_blank\\\"><font color=\\\"#ffffff\\\">- Skillsoft<\\/font><\\/a><\\/p><p><a href=\\\"https:\\/\\/www.udacity.com\\/\\\" target=\\\"_blank\\\"><font color=\\\"#ffffff\\\">- Udacity<\\/font><\\/a><\\/p><p><a href=\\\"https:\\/\\/www.edx.org\\/\\\" target=\\\"_blank\\\"><font color=\\\"#ffffff\\\">- edX<\\/font><\\/a><\\/p><p><a href=\\\"https:\\/\\/www.masterclass.com\\/\\\" target=\\\"_blank\\\"><font color=\\\"#ffffff\\\">- Masterclass<\\/font><\\/a><br><\\/p>\"},\"forth_column\":{\"title\":\"Purchase Rocket LMS\",\"value\":\"<p><a title=\\\"Notnt\\\" href=\\\"https:\\/\\/codecanyon.net\\\"><img style=\\\"width: 200px;\\\" src=\\\"\\/store\\/1\\/default_images\\/envato.png\\\"><\\/a><\\/p>\"}}');
INSERT INTO `setting_translations` VALUES (31, 4, 'ar', '{\"first_column\":{\"title\":\"\\u0645\\u0639\\u0644\\u0648\\u0645\\u0627\\u062a \\u0639\\u0646\\u0627\",\"value\":\"<p><font color=\\\"#ffffff\\\">Rocket LMS \\u0647\\u0648 \\u0646\\u0638\\u0627\\u0645 \\u0625\\u062f\\u0627\\u0631\\u0629 \\u062a\\u0639\\u0644\\u0645 \\u0643\\u0627\\u0645\\u0644 \\u0627\\u0644\\u0645\\u064a\\u0632\\u0627\\u062a \\u064a\\u0633\\u0627\\u0639\\u062f\\u0643 \\u0639\\u0644\\u0649 \\u0625\\u062f\\u0627\\u0631\\u0629 \\u0623\\u0639\\u0645\\u0627\\u0644\\u0643 \\u0627\\u0644\\u062a\\u0639\\u0644\\u064a\\u0645\\u064a\\u0629 \\u0641\\u064a \\u0639\\u062f\\u0629 \\u0633\\u0627\\u0639\\u0627\\u062a. \\u062a\\u0633\\u0627\\u0639\\u062f \\u0647\\u0630\\u0647 \\u0627\\u0644\\u0645\\u0646\\u0635\\u0629 \\u0627\\u0644\\u0645\\u0639\\u0644\\u0645\\u064a\\u0646 \\u0639\\u0644\\u0649 \\u0625\\u0646\\u0634\\u0627\\u0621 \\u0645\\u0648\\u0627\\u062f \\u062a\\u0639\\u0644\\u064a\\u0645\\u064a\\u0629 \\u0627\\u062d\\u062a\\u0631\\u0627\\u0641\\u064a\\u0629 \\u0648\\u062a\\u0633\\u0627\\u0639\\u062f \\u0627\\u0644\\u0637\\u0644\\u0627\\u0628 \\u0639\\u0644\\u0649 \\u0627\\u0644\\u062a\\u0639\\u0644\\u0645 \\u0645\\u0646 \\u0623\\u0641\\u0636\\u0644 \\u0627\\u0644\\u0645\\u062f\\u0631\\u0628\\u064a\\u0646.<\\/font><\\/p>\"},\"second_column\":{\"title\":\"\\u0631\\u0648\\u0627\\u0628\\u0637 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629\",\"value\":\"<p><a href=\\\"\\/login\\\"><span style=\\\"color: #ffffff;\\\">- \\u062a\\u0633\\u062c\\u064a\\u0644 \\u0627\\u0644\\u062f\\u062e\\u0648\\u0644<\\/span><\\/a><\\/p>\\r\\n<p><span style=\\\"color: #ffffff;\\\"><a href=\\\"\\/register\\\"><span style=\\\"color: #ffffff;\\\">- \\u062a\\u0633\\u062c\\u064a\\u0644<\\/span><\\/a><br><\\/span><\\/p>\\r\\n<p><a href=\\\"\\/blog\\\"><span style=\\\"color: #ffffff;\\\">- \\u0645\\u0642\\u0627\\u0644\\u0627\\u062a<\\/span><\\/a><\\/p>\\r\\n<p><a href=\\\"\\/contact\\\"><span style=\\\"color: #ffffff;\\\">- \\u0627\\u062a\\u0635\\u0644 \\u0628\\u0646\\u0627<\\/span><\\/a><\\/p>\\r\\n<p><span style=\\\"color: #ffffff;\\\"><a href=\\\"\\/certificate_validation\\\"><span style=\\\"color: #ffffff;\\\">- \\u0627\\u0644\\u062a\\u062d\\u0642\\u0642 \\u0645\\u0646 \\u0635\\u062d\\u0629 \\u0627\\u0644\\u0634\\u0647\\u0627\\u062f\\u0629<\\/span><\\/a><br><\\/span><\\/p>\\r\\n<p><span style=\\\"color: #ffffff;\\\"><a href=\\\"\\/become-instructor\\\"><span style=\\\"color: #ffffff;\\\">- \\u0623\\u0635\\u0628\\u062d \\u0645\\u062f\\u0631\\u0628\\u0627<\\/span><\\/a><br><\\/span><\\/p>\\r\\n<p><a href=\\\"\\/pages\\/terms\\\"><span style=\\\"color: #ffffff;\\\">- \\u0627\\u0644\\u0634\\u0631\\u0648\\u0637 \\u0648\\u0627\\u0644\\u0642\\u0648\\u0627\\u0639\\u062f<\\/span><\\/a><\\/p>\\r\\n<p><a href=\\\"\\/pages\\/about\\\"><span style=\\\"color: #ffffff;\\\">- \\u0645\\u0639\\u0644\\u0648\\u0645\\u0627\\u062a \\u0639\\u0646\\u0627<\\/span><\\/a><\\/p>\"},\"third_column\":{\"title\":\"\\u0623\\u0639\\u0645\\u0627\\u0644 \\u0645\\u0645\\u0627\\u062b\\u0644\\u0629\",\"value\":\"<p><a href=\\\"https:\\/\\/www.udemy.com\\/\\\" target=\\\"_blank\\\"><font color=\\\"#ffffff\\\">- \\u064a\\u0648\\u062f\\u0645\\u064a<\\/font><\\/a><\\/p><p><a href=\\\"https:\\/\\/www.skillshare.com\\/\\\" target=\\\"_blank\\\"><font color=\\\"#ffffff\\\">- \\u0627\\u0633\\u06a9\\u06cc\\u0644 \\u0634\\u06cc\\u0631<\\/font><\\/a><\\/p><p><a href=\\\"https:\\/\\/www.coursera.org\\/\\\" target=\\\"_blank\\\"><font color=\\\"#ffffff\\\">- \\u0643\\u0631\\u0633 \\u0627\\u064a\\u0631\\u0627<\\/font><\\/a><\\/p><p><a href=\\\"https:\\/\\/www.linkedin.com\\/learning\\/\\\" target=\\\"_blank\\\"><font color=\\\"#ffffff\\\">- \\u0644\\u06cc\\u0646\\u062f\\u0627<\\/font><\\/a><\\/p><p><a href=\\\"https:\\/\\/www.skillsoft.com\\/\\\" target=\\\"_blank\\\"><font color=\\\"#ffffff\\\">- \\u0627\\u0633\\u0643\\u064a\\u0644 \\u0633\\u0641\\u062a<\\/font><\\/a><\\/p><p><a href=\\\"https:\\/\\/www.udacity.com\\/\\\" target=\\\"_blank\\\"><font color=\\\"#ffffff\\\">- \\u0627\\u0648\\u062f\\u0627\\u0633\\u064a\\u062a\\u064a<\\/font><\\/a><\\/p><p><a href=\\\"https:\\/\\/www.edx.org\\/\\\" target=\\\"_blank\\\"><font color=\\\"#ffffff\\\">\\u0627\\u062f\\u0643\\u0633<\\/font><\\/a><\\/p><p><a href=\\\"https:\\/\\/www.masterclass.com\\/\\\" target=\\\"_blank\\\"><font color=\\\"#ffffff\\\">- \\u0645\\u0633\\u062a\\u0631 \\u0643\\u0644\\u0633<\\/font><\\/a><br><\\/p>\"},\"forth_column\":{\"title\":\"\\u0642\\u0645 \\u0628\\u0634\\u0631\\u0627\\u0621 Rocket LMS\",\"value\":\"<p><a title=\\\"Notnt\\\" href=\\\"https:\\/\\/codecanyon.net\\\"><img style=\\\"width: 200px;\\\" src=\\\"\\/store\\/1\\/default_images\\/envato.png\\\"><\\/a><\\/p>\"}}');
INSERT INTO `setting_translations` VALUES (32, 31, 'en', '{\"agora_resolution\":null,\"agora_max_bitrate\":\"2260\",\"agora_min_bitrate\":\"1130\",\"agora_frame_rate\":\"15\",\"agora_live_streaming\":\"0\",\"agora_chat\":\"0\",\"agora_in_free_courses\":\"0\",\"agora_for_meeting\":\"0\",\"meeting_live_stream_type\":\"single\",\"course_live_stream_type\":\"single\",\"new_interactive_file\":\"0\",\"timezone_in_register\":\"1\",\"timezone_in_create_webinar\":\"1\",\"sequence_content_status\":\"0\",\"webinar_assignment_status\":\"0\",\"webinar_private_content_status\":\"0\",\"disable_view_content_after_user_register\":\"0\",\"course_forum_status\":\"0\",\"forums_status\":\"0\",\"direct_classes_payment_button_status\":\"0\",\"direct_bundles_payment_button_status\":\"0\",\"direct_products_payment_button_status\":\"0\",\"cookie_settings_status\":\"0\",\"mobile_app_status\":\"0\",\"maintenance_status\":\"0\",\"maintenance_access_key\":\"key\",\"extra_time_to_join_status\":\"1\",\"extra_time_to_join_default_value\":\"20\",\"show_other_register_method\":\"1\",\"show_certificate_additional_in_register\":\"1\",\"show_google_login_button\":\"1\",\"show_facebook_login_button\":\"1\",\"show_live_chat_widget\":\"0\",\"cashback_active\":\"0\",\"display_cashback_notice_in_the_product_page\":\"0\",\"display_minimum_amount_cashback_notices\":\"0\",\"available_session_apis\":[\"local\",\"zoom\"],\"available_sources\":[\"upload\",\"youtube\",\"vimeo\",\"external_link\",\"google_drive\",\"iframe\",\"s3\"],\"bunny_configs\":[],\"select_the_role_during_registration\":[\"teacher\",\"organization\"],\"waitlist_status\":\"0\",\"upcoming_courses_status\":\"0\"}');
INSERT INTO `setting_translations` VALUES (33, 32, 'en', '{\"image\":\"\\/store\\/1\\/default_images\\/home_sections_banners\\/instructor_finder_banner.jpg\",\"title\":\"Find the best instructor\",\"description\":\"Looking for an instructor? Find the best instructors according to different parameters like gender, skill level, price, meeting type, rating, etc.\\r\\nFind instructors on the map.\",\"button1\":{\"title\":\"Tutor Finder\",\"link\":\"\\/instructor-finder\\/wizard\"},\"button2\":{\"title\":\"Tutors on Map\",\"link\":\"\\/instructor-finder\"}}');
INSERT INTO `setting_translations` VALUES (34, 33, 'en', '{\"image\":\"\\/store\\/1\\/default_images\\/home_sections_banners\\/club_points_banner.png\",\"title\":\"Win Club Points\",\"description\":\"Use Rocket LMS and win club points according to different activities.\\r\\nYou will be able to use your club points to get free prizes and courses. Start using the system now and collect points!\",\"button1\":{\"title\":\"Rewards\",\"link\":\"\\/reward-courses\"},\"button2\":{\"title\":\"Points Club\",\"link\":\"\\/panel\\/rewards\"}}');
INSERT INTO `setting_translations` VALUES (35, 34, 'en', '{\"status\":\"0\",\"exchangeable\":\"1\",\"exchangeable_unit\":\"200\",\"want_more_points_link\":\"\\/pages\\/reward_points_system\"}');
INSERT INTO `setting_translations` VALUES (38, 37, 'en', '{\"status\":\"0\",\"show_packages_during_registration\":\"0\",\"force_user_to_select_a_package\":\"0\",\"enable_home_section\":\"1\"}');
INSERT INTO `setting_translations` VALUES (39, 38, 'en', '{\"status\":\"0\",\"courses_capacity\":\"20\",\"courses_count\":\"5\",\"meeting_count\":\"20\",\"product_count\":\"5\"}');
INSERT INTO `setting_translations` VALUES (40, 39, 'en', '{\"status\":\"0\",\"instructors_count\":\"5\",\"students_count\":\"30\",\"courses_capacity\":\"30\",\"courses_count\":\"10\",\"meeting_count\":\"40\",\"product_count\":\"10\"}');
INSERT INTO `setting_translations` VALUES (41, 40, 'en', '{\"image\":\"\\/store\\/1\\/default_images\\/home_sections_banners\\/become_instructor_banner.jpg\",\"title\":\"Become an instructor\",\"description\":\"Are you interested to be a part of our community?\\r\\nYou can be a part of our community by signing up as an instructor or organization.\",\"button1\":{\"title\":\"Become an Instructor\",\"link\":\"\\/become-instructor\"},\"button2\":{\"title\":\"Registration Packages\",\"link\":\"become-instructor\\/packages\\/\"}}');
INSERT INTO `setting_translations` VALUES (42, 8, 'ar', '{\"title\":\"\\u0645\\u062a\\u0639\\u0629 \\u0627\\u0644\\u062a\\u0639\\u0644\\u0645 \\u0648\\u0627\\u0644\\u062a\\u0639\\u0644\\u064a\\u0645 ...\",\"description\":\"Rocket LMS \\u0639\\u0628\\u0627\\u0631\\u0629 \\u0639\\u0646 \\u0646\\u0638\\u0627\\u0645 \\u0623\\u0633\\u0627\\u0633\\u064a \\u062a\\u0639\\u0644\\u064a\\u0645\\u064a \\u0643\\u0627\\u0645\\u0644 \\u0627\\u0644\\u0645\\u064a\\u0632\\u0627\\u062a \\u064a\\u0633\\u0627\\u0639\\u062f \\u0627\\u0644\\u0645\\u062f\\u0631\\u0628\\u064a\\u0646 \\u0639\\u0644\\u0649 \\u0625\\u0646\\u0634\\u0627\\u0621 \\u0648\\u0646\\u0634\\u0631 \\u062f\\u0648\\u0631\\u0627\\u062a \\u0641\\u064a\\u062f\\u064a\\u0648 \\u0648\\u0641\\u0635\\u0648\\u0644 \\u0645\\u0628\\u0627\\u0634\\u0631\\u0629 \\u0648\\u062f\\u0648\\u0631\\u0627\\u062a \\u0646\\u0635\\u064a\\u0629 \\u0648\\u0643\\u0633\\u0628 \\u0627\\u0644\\u0645\\u0627\\u0644 \\u060c \\u0648\\u064a\\u0633\\u0627\\u0639\\u062f \\u0627\\u0644\\u0637\\u0644\\u0627\\u0628 \\u0639\\u0644\\u0649 \\u0627\\u0644\\u062a\\u0639\\u0644\\u0645 \\u0628\\u0623\\u0633\\u0647\\u0644 \\u0637\\u0631\\u064a\\u0642\\u0629.\",\"hero_background\":\"\\/store\\/1\\/default_images\\/hero_1.jpg\"}');
INSERT INTO `setting_translations` VALUES (43, 8, 'es', '{\"title\":\"Alegr\\u00eda de aprender y ense\\u00f1ar ...\",\"description\":\"Rocket LMS es una plataforma educativa con todas las funciones que ayuda a los instructores a crear y publicar cursos de video, clases en vivo y cursos de texto y ganar dinero, y ayuda a los estudiantes a aprender de la manera m\\u00e1s f\\u00e1cil.\",\"hero_background\":\"\\/store\\/1\\/default_images\\/hero_1.jpg\"}');
INSERT INTO `setting_translations` VALUES (44, 15, 'ar', '{\"title\":\"\\u0645\\u062a\\u0639\\u0629 \\u0627\\u0644\\u062a\\u0639\\u0644\\u0645 \\u0648\\u0627\\u0644\\u062a\\u0639\\u0644\\u064a\\u0645 ...\",\"description\":\"Rocket LMS \\u0639\\u0628\\u0627\\u0631\\u0629 \\u0639\\u0646 \\u0646\\u0638\\u0627\\u0645 \\u0623\\u0633\\u0627\\u0633\\u064a \\u062a\\u0639\\u0644\\u064a\\u0645\\u064a \\u0643\\u0627\\u0645\\u0644 \\u0627\\u0644\\u0645\\u064a\\u0632\\u0627\\u062a \\u064a\\u0633\\u0627\\u0639\\u062f \\u0627\\u0644\\u0645\\u062f\\u0631\\u0628\\u064a\\u0646 \\u0639\\u0644\\u0649 \\u0625\\u0646\\u0634\\u0627\\u0621 \\u0648\\u0646\\u0634\\u0631 \\u062f\\u0648\\u0631\\u0627\\u062a \\u0641\\u064a\\u062f\\u064a\\u0648 \\u0648\\u0641\\u0635\\u0648\\u0644 \\u0645\\u0628\\u0627\\u0634\\u0631\\u0629 \\u0648\\u062f\\u0648\\u0631\\u0627\\u062a \\u0646\\u0635\\u064a\\u0629 \\u0648\\u0643\\u0633\\u0628 \\u0627\\u0644\\u0645\\u0627\\u0644 \\u060c \\u0648\\u064a\\u0633\\u0627\\u0639\\u062f \\u0627\\u0644\\u0637\\u0644\\u0627\\u0628 \\u0639\\u0644\\u0649 \\u0627\\u0644\\u062a\\u0639\\u0644\\u0645 \\u0628\\u0623\\u0633\\u0647\\u0644 \\u0637\\u0631\\u064a\\u0642\\u0629.\",\"hero_background\":\"\\/assets\\/default\\/img\\/home\\/world.png\",\"hero_vector\":\"\\/store\\/1\\/animated-header.json\",\"has_lottie\":\"1\"}');
INSERT INTO `setting_translations` VALUES (45, 15, 'es', '{\"title\":\"\\u00a1Aprende a desarrollar software desde Zeros en DevZeros\'s School!\",\"description\":\"Trabajamos para formar j\\u00f3venes capaces de afrontar los desaf\\u00edos que presenta el mundo de la programaci\\u00f3n y el desarrollo de software.\",\"hero_background\":\"\\/store\\/1\\/topnav_background.jpg\",\"hero_vector\":\"\\/store\\/1\\/animated-header.json\",\"has_lottie\":\"1\"}');
INSERT INTO `setting_translations` VALUES (46, 27, 'ar', '{\"link\":\"\\/classes\",\"title\":\"\\u0627\\u0628\\u062f\\u0623 \\u0627\\u0644\\u062a\\u0639\\u0644\\u0645 \\u0641\\u064a \\u0623\\u064a \\u0645\\u0643\\u0627\\u0646 \\u0648\\u0641\\u064a \\u0623\\u064a \\u0648\\u0642\\u062a ...\",\"description\":\"\\u0627\\u0633\\u062a\\u062e\\u062f\\u0645 Rocket LMS \\u0644\\u0644\\u0648\\u0635\\u0648\\u0644 \\u0625\\u0644\\u0649 \\u0645\\u0648\\u0627\\u062f \\u062a\\u0639\\u0644\\u064a\\u0645\\u064a\\u0629 \\u0639\\u0627\\u0644\\u064a\\u0629 \\u0627\\u0644\\u062c\\u0648\\u062f\\u0629 \\u062f\\u0648\\u0646 \\u0623\\u064a \\u0642\\u064a\\u0648\\u062f \\u0648\\u0628\\u0623\\u0633\\u0647\\u0644 \\u0637\\u0631\\u064a\\u0642\\u0629.\",\"background\":\"\\/store\\/1\\/default_images\\/home_video_section.png\"}');
INSERT INTO `setting_translations` VALUES (47, 27, 'es', '{\"link\":\"\\/classes\",\"title\":\"Empiece a aprender en cualquier lugar, en cualquier momento ...\",\"description\":\"Utilice Rocket LMS para acceder a materiales educativos de alta calidad sin limitaciones de la forma m\\u00e1s sencilla.\",\"background\":\"\\/store\\/1\\/default_images\\/home_video_section.png\"}');
INSERT INTO `setting_translations` VALUES (48, 29, 'ar', '{\"link\":\"\\/classes?sort=newest\",\"background\":\"\\/store\\/1\\/sidebar-user-ar.png\"}');
INSERT INTO `setting_translations` VALUES (49, 29, 'es', '{\"link\":\"\\/classes?sort=newest\",\"background\":\"\\/store\\/1\\/sidebar-user-sp.png\"}');
INSERT INTO `setting_translations` VALUES (50, 4, 'es', '{\"first_column\":{\"title\":\"Sobre Nosotros\",\"value\":\"<p><span style=\\\"color: rgb(255, 255, 255);\\\">DevZeros School es una academia que trabaja arduamente para formar j\\u00f3venes capaces de afrontar los desaf\\u00edos que presenta el mundo de la programaci\\u00f3n, el desarrollo software y el dise\\u00f1o digital.&nbsp;<\\/span><\\/p>\"},\"second_column\":{\"title\":\"Enlaces Adicionales\",\"value\":\"<p>\\r\\n<a href=\\\"\\/login\\\"><span style=\\\"color: rgb(255, 255, 255);\\\">- Acceso<\\/span><\\/a>\\r\\n<\\/p>\\r\\n<p>\\r\\n<span style=\\\"color: #FFFFFF;\\\">\\r\\n<a href=\\\"\\/register\\\"><span style=\\\"color: rgb(255, 255, 255);\\\">- Registrarse<\\/span><\\/a>\\r\\n<\\/span><\\/p>\\r\\n<p><a href=\\\"\\/contact\\\"><span style=\\\"color: rgb(255, 255, 255);\\\">- Contacta con nosotros<\\/span><\\/a><\\/p>\\r\\n<p><a href=\\\"\\/pages\\/terms\\\"><span style=\\\"color: rgb(255, 255, 255);\\\">- T\\u00e9rminos y reglas<\\/span><\\/a><\\/p>\"},\"third_column\":{\"title\":\"DevZeros S.A.S\",\"value\":\"<p><a href=\\\"https:\\/\\/devzeros.com\\/\\\" target=\\\"_blank\\\"><font color=\\\"#FFFFFF\\\">-Devzeros.com<\\/font><\\/a><\\/p><p><a href=\\\"https:\\/\\/www.linkedin.com\\/company\\/74887912\\/admin\\/\\\" target=\\\"_blank\\\"><font color=\\\"#FFFFFF\\\">-LinkedIn<\\/font><\\/a><\\/p><p><br><\\/p>\"},\"forth_column\":{\"title\":null,\"value\":\"<p><img src=\\\"\\/store\\/1\\/DevZero (1)-20.png\\\" style=\\\"width: 25%;\\\"><br><\\/p>\"}}');
INSERT INTO `setting_translations` VALUES (51, 26, 'es', '{\"02nh9a\":{\"title\":\"Inicio\",\"link\":\"\\/\",\"order\":\"1\"},\"1cH2kF\":{\"title\":\"Cursos\",\"link\":\"\\/classes?sort=newest\",\"order\":\"2\"},\"gGf8Lv\":{\"title\":\"Instructores\",\"link\":\"\\/instructor-finder\",\"order\":\"3\"}}');
INSERT INTO `setting_translations` VALUES (52, 26, 'ar', '{\"02nh9a\":{\"title\":\"\\u0627\\u0644\\u0635\\u0641\\u062d\\u0629 \\u0627\\u0644\\u0631\\u0626\\u064a\\u0633\\u064a\\u0629\",\"link\":\"\\/\",\"order\":\"1\"},\"1cH2kF\":{\"title\":\"\\u0627\\u0644\\u062f\\u0648\\u0631\\u0627\\u062a\",\"link\":\"\\/classes?sort=newest\",\"order\":\"2\"},\"gGf8Lv\":{\"title\":\"\\u0627\\u0644\\u0645\\u062f\\u0631\\u0628\\u064a\\u0646\",\"link\":\"\\/instructor-finder\",\"order\":\"3\"}}');
INSERT INTO `setting_translations` VALUES (53, 32, 'ar', '{\"image\":\"\\/store\\/1\\/default_images\\/home_sections_banners\\/instructor_finder_banner.jpg\",\"title\":\"\\u0627\\u0639\\u062b\\u0631 \\u0639\\u0644\\u0649 \\u0623\\u0641\\u0636\\u0644 \\u0645\\u062f\\u0631\\u0628\",\"description\":\"\\u062a\\u0628\\u062d\\u062b \\u0639\\u0646 \\u0645\\u062f\\u0631\\u0628\\u061f \\u0627\\u0639\\u062b\\u0631 \\u0639\\u0644\\u0649 \\u0623\\u0641\\u0636\\u0644 \\u0627\\u0644\\u0645\\u062f\\u0631\\u0628\\u064a\\u0646 \\u0648\\u0641\\u0642\\u064b\\u0627 \\u0644\\u0645\\u0639\\u0627\\u064a\\u064a\\u0631 \\u0645\\u062e\\u062a\\u0644\\u0641\\u0629 \\u0645\\u062b\\u0644 \\u0627\\u0644\\u062c\\u0646\\u0633 \\u0648\\u0645\\u0633\\u062a\\u0648\\u0649 \\u0627\\u0644\\u0645\\u0647\\u0627\\u0631\\u0629 \\u0648\\u0627\\u0644\\u0633\\u0639\\u0631 \\u0648\\u0646\\u0648\\u0639 \\u0627\\u0644\\u0627\\u062c\\u062a\\u0645\\u0627\\u0639 \\u0648\\u0627\\u0644\\u062a\\u0642\\u064a\\u064a\\u0645 \\u0648\\u0645\\u0627 \\u0625\\u0644\\u0649 \\u0630\\u0644\\u0643.\\r\\n\\u0627\\u0628\\u062d\\u062b \\u0639\\u0646 \\u0645\\u062f\\u0631\\u0628\\u064a\\u0646 \\u0639\\u0644\\u0649 \\u0627\\u0644\\u062e\\u0631\\u064a\\u0637\\u0629.\",\"button1\":{\"title\":\"\\u0627\\u0644\\u0628\\u0627\\u062d\\u062b \\u0639\\u0646 \\u0627\\u0644\\u0645\\u0639\\u0644\\u0645\",\"link\":\"\\/instructor-finder\\/wizard\"},\"button2\":{\"title\":\"\\u0645\\u062f\\u0631\\u0633\\u0648\\u0646 \\u0639\\u0644\\u0649 \\u0627\\u0644\\u062e\\u0631\\u064a\\u0637\\u0629\",\"link\":\"\\/instructor-finder\"}}');
INSERT INTO `setting_translations` VALUES (54, 32, 'es', '{\"image\":\"\\/store\\/1\\/default_images\\/home_sections_banners\\/instructor_finder_banner.jpg\",\"title\":\"Encuentra la mejor instructora\",\"description\":\"\\u00bfBuscas un instructor? Encuentre los mejores instructores seg\\u00fan diferentes par\\u00e1metros como g\\u00e9nero, nivel de habilidad, precio, tipo de reuni\\u00f3n, calificaci\\u00f3n, etc.\\r\\nEncuentra instructores en el mapa.\",\"button1\":{\"title\":\"Buscadora de tutores\",\"link\":\"\\/instructor-finder\\/wizard\"},\"button2\":{\"title\":\"Tutores en el mapa\",\"link\":\"\\/instructor-finder\"}}');
INSERT INTO `setting_translations` VALUES (55, 33, 'ar', '{\"image\":\"\\/store\\/1\\/default_images\\/home_sections_banners\\/club_points_banner.png\",\"title\":\"\\u0627\\u0631\\u0628\\u062d \\u0646\\u0642\\u0627\\u0637 \\u0627\\u0644\\u0646\\u0627\\u062f\\u064a\",\"description\":\"\\u0627\\u0633\\u062a\\u062e\\u062f\\u0645 Rocket LMS \\u0648\\u0627\\u0631\\u0628\\u062d \\u0646\\u0642\\u0627\\u0637 \\u0627\\u0644\\u0646\\u0627\\u062f\\u064a \\u0648\\u0641\\u0642\\u064b\\u0627 \\u0644\\u0644\\u0623\\u0646\\u0634\\u0637\\u0629 \\u0627\\u0644\\u0645\\u062e\\u062a\\u0644\\u0641\\u0629.\\r\\n\\u0633\\u062a\\u062a\\u0645\\u0643\\u0646 \\u0645\\u0646 \\u0627\\u0633\\u062a\\u062e\\u062f\\u0627\\u0645 \\u0646\\u0642\\u0627\\u0637 \\u0627\\u0644\\u0646\\u0627\\u062f\\u064a \\u0627\\u0644\\u062e\\u0627\\u0635\\u0629 \\u0628\\u0643 \\u0644\\u0644\\u062d\\u0635\\u0648\\u0644 \\u0639\\u0644\\u0649 \\u062c\\u0648\\u0627\\u0626\\u0632 \\u0648\\u062f\\u0648\\u0631\\u0627\\u062a \\u0645\\u062c\\u0627\\u0646\\u064a\\u0629. \\u0627\\u0628\\u062f\\u0623 \\u0641\\u064a \\u0627\\u0633\\u062a\\u062e\\u062f\\u0627\\u0645 \\u0627\\u0644\\u0646\\u0638\\u0627\\u0645 \\u0627\\u0644\\u0622\\u0646 \\u0648\\u0627\\u062c\\u0645\\u0639 \\u0627\\u0644\\u0646\\u0642\\u0627\\u0637!\",\"button1\":{\"title\":\"\\u0627\\u0644\\u0645\\u0643\\u0627\\u0641\\u0622\\u062a\",\"link\":\"\\/reward-courses\"},\"button2\":{\"title\":\"\\u0646\\u0627\\u062f\\u064a \\u0627\\u0644\\u0646\\u0642\\u0627\\u0637\",\"link\":\"\\/panel\\/rewards\"}}');
INSERT INTO `setting_translations` VALUES (56, 33, 'es', '{\"image\":\"\\/store\\/1\\/default_images\\/home_sections_banners\\/club_points_banner.png\",\"title\":\"Gana puntos del club\",\"description\":\"Utilice Rocket LMS y gane puntos del club seg\\u00fan diferentes actividades.\\r\\nPodr\\u00e1s utilizar tus puntos del club para conseguir premios y cursos gratuitos. \\u00a1Comience a usar el sistema ahora y acumule puntos!\",\"button1\":{\"title\":\"Recompensas\",\"link\":\"\\/reward-courses\"},\"button2\":{\"title\":\"club de puntos\",\"link\":\"\\/panel\\/rewards\"}}');
INSERT INTO `setting_translations` VALUES (57, 40, 'ar', '{\"image\":\"\\/store\\/1\\/default_images\\/home_sections_banners\\/become_instructor_banner.jpg\",\"title\":\"\\u0643\\u0646 \\u0645\\u062f\\u0631\\u0628\\u064b\\u0627\",\"description\":\"\\u0647\\u0644 \\u0623\\u0646\\u062a \\u0645\\u0647\\u062a\\u0645 \\u0628\\u0623\\u0646 \\u062a\\u0643\\u0648\\u0646 \\u062c\\u0632\\u0621\\u064b\\u0627 \\u0645\\u0646 \\u0645\\u062c\\u062a\\u0645\\u0639\\u0646\\u0627\\u061f\\r\\n\\u064a\\u0645\\u0643\\u0646\\u0643 \\u0623\\u0646 \\u062a\\u0643\\u0648\\u0646 \\u062c\\u0632\\u0621\\u064b\\u0627 \\u0645\\u0646 \\u0645\\u062c\\u062a\\u0645\\u0639\\u0646\\u0627 \\u0645\\u0646 \\u062e\\u0644\\u0627\\u0644 \\u0627\\u0644\\u062a\\u0633\\u062c\\u064a\\u0644 \\u0643\\u0645\\u062f\\u0631\\u0628 \\u0623\\u0648 \\u0645\\u0646\\u0638\\u0645\\u0629.\",\"button1\":{\"title\":\"\\u0643\\u0646 \\u0645\\u062f\\u0631\\u0633\\u064b\\u0627\",\"link\":\"\\/become-instructor\"},\"button2\":{\"title\":\"\\u062d\\u0632\\u0645 \\u0627\\u0644\\u062a\\u0633\\u062c\\u064a\\u0644\",\"link\":\"become-instructor\\/packages\\/\"}}');
INSERT INTO `setting_translations` VALUES (58, 40, 'es', '{\"image\":\"\\/store\\/1\\/default_images\\/home_sections_banners\\/become_instructor_banner.jpg\",\"title\":\"Convi\\u00e9rtete en instructora\",\"description\":\"\\u00bfEst\\u00e1s interesado en ser parte de nuestra comunidad?\\r\\nPuedes ser parte de nuestra comunidad registr\\u00e1ndote como instructor u organizaci\\u00f3n.\",\"button1\":{\"title\":\"Convi\\u00e9rtete en instructora\",\"link\":\"\\/become-instructor\"},\"button2\":{\"title\":\"Paquetes de registro\",\"link\":\"become-instructor\\/packages\\/\"}}');
INSERT INTO `setting_translations` VALUES (59, 42, 'en', '{\"primary\":\"#bc3c6e\",\"primary-border\":\"#bc3c6e\",\"primary-hover\":\"#6d1e5e\",\"primary-border-hover\":\"#6d1e5e\",\"primary-btn-shadow\":\"0 3px 6px 0 rgba(109,30,94,0.5)\",\"primary-btn-shadow-hover\":\"0 3px 6px 0 rgba(109,30,94,0.5)\",\"primary-btn-color\":null,\"primary-btn-color-hover\":null,\"secondary\":\"#bc3c6e\",\"secondary-border\":null,\"secondary-hover\":null,\"secondary-border-hover\":null,\"secondary-btn-shadow\":null,\"secondary-btn-shadow-hover\":null,\"secondary-btn-color\":null,\"secondary-btn-color-hover\":null,\"admin_primary\":\"#bc3c6e\"}');
INSERT INTO `setting_translations` VALUES (60, 44, 'en', '{\"cookie_settings_modal_message\":\"<p>When you visit any of our websites, it may store or retrieve information on your browser, mostly in the form of cookies. This information might be about you, your preferences or your device and is mostly used to make the site work as you expect it to. The information does not usually directly identify you, but it can give you a more personalized web experience. Because we respect your right to privacy, you can choose not to allow some types of cookies. Click on the different category headings to find out more and manage your preferences. Please note, that blocking some types of cookies may impact your experience of the site and the services we are able to offer.<\\/p>\",\"cookie_settings_modal_items\":{\"dDRjfkGvQfFzQJpa\":{\"title\":\"Strictly Necessary\",\"description\":\"These cookies are necessary for our website to function properly and cannot be switched off in our systems. They are usually only set in response to actions made by you that amount to a request for services, such as setting your privacy preferences, logging in or filling in forms, or where they\\u2019re essential to providing you with a service you have requested. You cannot opt out of these cookies. You can set your browser to block or alert you about these cookies, but if you do, some parts of the site will not then work. These cookies do not store any personally identifiable information.\",\"required\":\"1\"},\"mOzJowgvTnWFlRzz\":{\"title\":\"Performance Cookies\",\"description\":\"These cookies allow us to count visits and traffic sources so we can measure and improve the performance of our site. They help us to know which pages are the most and least popular and see how visitors move around the site, which helps us optimize your experience. All information these cookies collect is aggregated and therefore anonymous. If you do not allow these cookies we will not be able to use your data in this way.\",\"required\":\"0\"},\"XBMtdYaeSrqMicTH\":{\"title\":\"Functional Cookies\",\"description\":\"These cookies enable the website to provide enhanced functionality and personalization. They may be set by us or by third-party providers whose services we have added to our pages. If you do not allow these cookies then some or all of these services may not function properly.\",\"required\":\"0\"},\"XlLqzsvNpRqdcNWP\":{\"title\":\"Targeting Cookies\",\"description\":\"These cookies may be set through our site by our advertising partners. They may be used by those companies to build a profile of your interests and show you relevant adverts on other sites. They do not store directly personal information but are based on uniquely identifying your browser and internet device. If you do not allow these cookies, you will experience less targeted advertising.\",\"required\":\"0\"}}}');
INSERT INTO `setting_translations` VALUES (61, 41, 'en', '{\"status\":\"0\",\"virtual_product_commission\":\"20\",\"physical_product_commission\":\"10\",\"store_tax\":\"10\",\"possibility_create_virtual_product\":\"1\",\"possibility_create_physical_product\":\"1\",\"shipping_tracking_url\":\"https:\\/\\/www.tracking.my\\/\",\"activate_comments\":\"1\"}');
INSERT INTO `setting_translations` VALUES (62, 46, 'en', '{\"main\":{\"regular\":\"\\/store\\/1\\/fonts\\/Poppins-Regular.ttf\",\"bold\":\"\\/store\\/1\\/fonts\\/Poppins-Bold.ttf\",\"medium\":\"\\/store\\/1\\/fonts\\/Poppins-Medium.ttf\"},\"rtl\":{\"regular\":\"\\/store\\/1\\/fonts\\/Vazir-Regular.woff2\",\"bold\":\"\\/store\\/1\\/fonts\\/Vazir-Bold.woff2\",\"medium\":\"\\/store\\/1\\/fonts\\/Vazir-Medium.woff2\"}}');
INSERT INTO `setting_translations` VALUES (63, 43, 'en', '{\"image\":\"\\/store\\/1\\/default_images\\/forums\\/forum_section.jpg\",\"title\":\"Have a Question? Ask it in forum and get answer\",\"description\":\"Our forums helps you to create your questions on different subjects and communicate with other forum users. Our users will help you to get the best answer!\",\"button1\":{\"title\":\"Create a new topic\",\"link\":\"\\/forums\\/create-topic\"},\"button2\":{\"title\":\"Browse forums\",\"link\":\"\\/forums\"}}');
INSERT INTO `setting_translations` VALUES (64, 45, 'en', '{\"mobile_app_hero_image\":\"\\/store\\/1\\/default_images\\/app_only.png\",\"mobile_app_description\":\"<div>Is an amazing, modern, and clean landing page for showcasing your app or anything else.<\\/div><div><br><\\/div><div>A mobile application or app is a computer program or software application designed to run on a mobile device such as a phone, tablet, or watch. Mobile applications often stand in contrast to desktop applications which are designed to run on desktop computers, and web applications which run in mobile web browsers rather than directly on the mobile device.<\\/div>\",\"mobile_app_buttons\":{\"htQgcSjzjLJlGRyY\":{\"title\":\"Download from Play Store\",\"link\":\"https:\\/\\/play.google.com\\/store\\/games\",\"icon\":\"\\/store\\/1\\/default_images\\/google-play.png\",\"color\":\"primary\"}}}');
INSERT INTO `setting_translations` VALUES (65, 48, 'en', '{\"image\":\"\\/store\\/1\\/default_images\\/ads_modal.png\",\"title\":\"Sales Campaign\",\"description\":\"We have a sales campaign on our promoted courses and products. You can purchase 150 products at a discounted price up to 50% discount.\",\"button1\":{\"title\":\"View Courses\",\"link\":\"\\/classes\"},\"button2\":{\"title\":\"View Products\",\"link\":\"\\/products\"}}');
INSERT INTO `setting_translations` VALUES (66, 52, 'en', '{\"show_guarantee_text\":\"1\",\"guarantee_text\":\"5 Days money back guarantee\",\"user_avatar_style\":\"ui_avatar\",\"default_user_avatar\":\"\\/store\\/1\\/default_images\\/default_profile.jpg\",\"platform_phone_and_email_position\":\"footer\"}');
INSERT INTO `setting_translations` VALUES (67, 47, 'en', '{\"webinar_reminder_schedule\":\"1\",\"meeting_reminder_schedule\":\"1\",\"subscribe_reminder_schedule\":\"48\"}');
INSERT INTO `setting_translations` VALUES (68, 61, 'en', '{\"offline_banks_status\":\"1\"}');
INSERT INTO `setting_translations` VALUES (69, 62, 'en', '{\"status\":\"0\",\"allow_sending_gift_for_courses\":\"1\",\"allow_sending_gift_for_bundles\":\"1\",\"allow_sending_gift_for_products\":\"1\"}');
INSERT INTO `setting_translations` VALUES (70, 63, 'en', '{\"status\":\"0\",\"unlock_registration_bonus_instantly\":\"0\",\"unlock_registration_bonus_with_referral\":\"1\",\"number_of_referred_users\":\"5\",\"enable_referred_users_purchase\":\"1\",\"purchase_amount_for_unlocking_bonus\":\"100\",\"registration_bonus_amount\":\"50\",\"bonus_wallet\":\"balance_wallet\"}');
INSERT INTO `setting_translations` VALUES (71, 57, 'en', '{\"enable_statistics\":\"1\",\"display_default_statistics\":\"1\"}');
INSERT INTO `setting_translations` VALUES (72, 56, 'en', '{\"currency\":\"USD\",\"currency_position\":\"left\",\"currency_separator\":\"dot\",\"currency_decimal\":\"2\",\"multi_currency\":\"0\"}');
INSERT INTO `setting_translations` VALUES (73, 53, 'en', '{\"login_device_limit\":\"1\",\"number_of_allowed_devices\":\"10\",\"admin_panel_url\":\"admin\"}');
INSERT INTO `setting_translations` VALUES (74, 54, 'en', '{\"status\":\"0\",\"disable_course_access_when_user_have_an_overdue_installment\":\"1\",\"disable_all_courses_access_when_user_have_an_overdue_installment\":\"1\",\"disable_instalments_when_the_user_have_an_overdue_installment\":\"1\",\"allow_cancel_verification\":\"1\",\"display_installment_button\":\"1\",\"overdue_interval_days\":\"3\",\"installment_plans_position\":\"top_of_page\",\"reminder_before_overdue_days\":\"3\",\"reminder_after_overdue_days\":\"2\"}');
INSERT INTO `setting_translations` VALUES (75, 58, 'en', '{\"title\":\"We are under maintenance!\",\"image\":\"\\/store\\/1\\/default_images\\/maintenance.png\",\"description\":\"We are working on the platform; It won\'t take a long time. We will try to back as soon as possible.\",\"maintenance_button\":{\"title\":\"Sample Button\",\"link\":\"\\/\"},\"end_date\":1740094200}');
INSERT INTO `setting_translations` VALUES (76, 64, 'en', '{\"term_image\":\"\\/store\\/1\\/default_images\\/registration bonus\\/banner.png\",\"items\":{\"DnrPr\":{\"icon\":\"\\/store\\/1\\/default_images\\/registration bonus\\/step1.svg\",\"title\":\"Sign up\",\"description\":\"Create an account on platform and get $50\"},\"eNMTB\":{\"icon\":\"\\/store\\/1\\/default_images\\/registration bonus\\/step2.svg\",\"title\":\"Refer your friends\",\"description\":\"Refer at least 5 users to the system using your affiliate URL\"},\"fdIUc\":{\"icon\":\"\\/store\\/1\\/default_images\\/registration bonus\\/step3.svg\",\"title\":\"Reach purchase target\",\"description\":\"Each referred user should purchase $100 on the platform\"},\"oeMZr\":{\"icon\":\"\\/store\\/1\\/default_images\\/registration bonus\\/step4.svg\",\"title\":\"Unlock your bonus\",\"description\":\"Your bonus will be unlocked! Enjoy spending...\"}}}');
INSERT INTO `setting_translations` VALUES (77, 55, 'en', '{\"terms_description\":\"<p>Welcome to our website! To ensure the best possible experience for all users, please review and agree to the following terms and rules before using our installment feature:<\\/p><p>Installment Payment Plan: Our website offers an installment payment plan for select courses. By selecting the installment payment option, you agree to pay the full course fee in multiple installments. Each installment payment will be automatically deducted from the payment method you provided on the scheduled dates until the full payment is completed.<\\/p><p>Payment Plan Fees: Our installment payment plan may include a small processing fee for each installment payment. The total processing fee will be disclosed to you before you select the installment payment option.<\\/p><p>Late Payment: If a payment is not received on the scheduled date, a late payment fee may be added to the next scheduled payment.<\\/p><p>Refunds: Once an installment payment is made, it is non-refundable. However, if you wish to cancel your enrollment in the course, you may be eligible for a partial refund according to our Refund Policy.<\\/p><p>Default: If you default on a payment or fail to complete the full payment plan, your access to the course will be revoked, and you may be subject to additional fees and collection efforts.<\\/p><p>Privacy: Your personal and payment information will be kept secure and confidential. We use industry-standard security measures to protect your information.<\\/p><p>Changes to Terms and Rules: We reserve the right to modify these terms and rules at any time. Any changes will be posted on our website and will become effective immediately upon posting.<\\/p><p>By using our installment payment plan, you agree to these terms and rules. If you have any questions or concerns, please contact our support team.<\\/p>\"}');
INSERT INTO `setting_translations` VALUES (78, 59, 'en', '{\"direct_publication_of_courses\":\"1\",\"direct_publication_of_comments\":\"1\",\"direct_publication_of_reviews\":\"1\",\"direct_publication_of_blog\":\"1\"}');

-- ----------------------------
-- Table structure for settings
-- ----------------------------
DROP TABLE IF EXISTS `settings`;
CREATE TABLE `settings`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `page` enum('general','financial','personalization','notifications','seo','customization','other') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'other',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `updated_at` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 65 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of settings
-- ----------------------------
INSERT INTO `settings` VALUES (1, 'seo', 'seo_metas', 1651070958);
INSERT INTO `settings` VALUES (2, 'general', 'socials', 1681403709);
INSERT INTO `settings` VALUES (4, 'other', 'footer', 1632071275);
INSERT INTO `settings` VALUES (5, 'general', 'general', 1683669415);
INSERT INTO `settings` VALUES (6, 'financial', 'financial', 1678734927);
INSERT INTO `settings` VALUES (8, 'personalization', 'home_hero', 1652016269);
INSERT INTO `settings` VALUES (12, 'customization', 'custom_css_js', 1636119881);
INSERT INTO `settings` VALUES (14, 'personalization', 'page_background', 1684002117);
INSERT INTO `settings` VALUES (15, 'personalization', 'home_hero2', 1681422859);
INSERT INTO `settings` VALUES (20, 'other', 'report_reasons', 1632235945);
INSERT INTO `settings` VALUES (22, 'notifications', 'notifications', 1678908168);
INSERT INTO `settings` VALUES (23, 'financial', 'site_bank_accounts', 1617002426);
INSERT INTO `settings` VALUES (24, 'other', 'contact_us', 1664436566);
INSERT INTO `settings` VALUES (25, 'personalization', 'home_sections', 1653226117);
INSERT INTO `settings` VALUES (26, 'other', 'navbar_links', 1681405826);
INSERT INTO `settings` VALUES (27, 'personalization', 'home_video_or_image_box', 1632226618);
INSERT INTO `settings` VALUES (28, 'other', '404', 1678950792);
INSERT INTO `settings` VALUES (29, 'personalization', 'panel_sidebar', 1642355954);
INSERT INTO `settings` VALUES (30, 'financial', 'referral', 1679092066);
INSERT INTO `settings` VALUES (31, 'general', 'features', 1679091992);
INSERT INTO `settings` VALUES (32, 'personalization', 'find_instructors', 1642530710);
INSERT INTO `settings` VALUES (33, 'personalization', 'reward_program', 1645628594);
INSERT INTO `settings` VALUES (34, 'general', 'rewards_settings', 1679091672);
INSERT INTO `settings` VALUES (37, 'financial', 'registration_packages_general', 1679091695);
INSERT INTO `settings` VALUES (38, 'financial', 'registration_packages_instructors', 1679091703);
INSERT INTO `settings` VALUES (39, 'financial', 'registration_packages_organizations', 1679091707);
INSERT INTO `settings` VALUES (40, 'personalization', 'become_instructor_section', 1645345116);
INSERT INTO `settings` VALUES (41, 'general', 'store_settings', 1679091642);
INSERT INTO `settings` VALUES (42, 'personalization', 'theme_colors', 1681417824);
INSERT INTO `settings` VALUES (43, 'personalization', 'forums_section', 1650546951);
INSERT INTO `settings` VALUES (44, 'personalization', 'cookie_settings', 1653487194);
INSERT INTO `settings` VALUES (45, 'personalization', 'mobile_app', 1653489015);
INSERT INTO `settings` VALUES (46, 'personalization', 'theme_fonts', 1680268110);
INSERT INTO `settings` VALUES (47, 'general', 'reminders', 1650982581);
INSERT INTO `settings` VALUES (48, 'other', 'advertising_modal', 1652000772);
INSERT INTO `settings` VALUES (52, 'personalization', 'others_personalization', 1678148917);
INSERT INTO `settings` VALUES (53, 'general', 'security', 1678150584);
INSERT INTO `settings` VALUES (54, 'general', 'installments_settings', 1679091725);
INSERT INTO `settings` VALUES (55, 'general', 'installments_terms_settings', 1679089417);
INSERT INTO `settings` VALUES (56, 'financial', 'currency_settings', 1679093236);
INSERT INTO `settings` VALUES (57, 'personalization', 'statistics', 1678151460);
INSERT INTO `settings` VALUES (58, 'personalization', 'maintenance_settings', 1678873553);
INSERT INTO `settings` VALUES (59, 'general', 'general_options', 1686952982);
INSERT INTO `settings` VALUES (60, 'financial', 'offline_banks_credits', 1676303092);
INSERT INTO `settings` VALUES (61, 'financial', 'offline_banks', 1676304557);
INSERT INTO `settings` VALUES (62, 'general', 'gifts_general_settings', 1679091761);
INSERT INTO `settings` VALUES (63, 'general', 'registration_bonus_settings', 1679091778);
INSERT INTO `settings` VALUES (64, 'general', 'registration_bonus_terms_settings', 1678898719);

-- ----------------------------
-- Table structure for special_offers
-- ----------------------------
DROP TABLE IF EXISTS `special_offers`;
CREATE TABLE `special_offers`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `creator_id` int UNSIGNED NOT NULL,
  `webinar_id` int UNSIGNED NULL DEFAULT NULL,
  `bundle_id` int UNSIGNED NULL DEFAULT NULL,
  `subscribe_id` int UNSIGNED NULL DEFAULT NULL,
  `registration_package_id` int UNSIGNED NULL DEFAULT NULL,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `percent` int UNSIGNED NOT NULL,
  `status` enum('active','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` int UNSIGNED NOT NULL,
  `from_date` int UNSIGNED NOT NULL,
  `to_date` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `special_offers_creator_id_foreign`(`creator_id`) USING BTREE,
  INDEX `special_offers_webinar_id_foreign`(`webinar_id`) USING BTREE,
  INDEX `special_offers_bundle_id_foreign`(`bundle_id`) USING BTREE,
  INDEX `special_offers_subscribe_id_foreign`(`subscribe_id`) USING BTREE,
  INDEX `special_offers_registration_package_id_foreign`(`registration_package_id`) USING BTREE,
  CONSTRAINT `special_offers_bundle_id_foreign` FOREIGN KEY (`bundle_id`) REFERENCES `bundles` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `special_offers_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `special_offers_registration_package_id_foreign` FOREIGN KEY (`registration_package_id`) REFERENCES `registration_packages` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `special_offers_subscribe_id_foreign` FOREIGN KEY (`subscribe_id`) REFERENCES `subscribes` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `special_offers_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of special_offers
-- ----------------------------

-- ----------------------------
-- Table structure for study_plan_chapters
-- ----------------------------
DROP TABLE IF EXISTS `study_plan_chapters`;
CREATE TABLE `study_plan_chapters`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int UNSIGNED NULL DEFAULT NULL,
  `webinar_id` int UNSIGNED NULL DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `order` int NULL DEFAULT NULL,
  `created_at` int UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `webinar_id`(`webinar_id`) USING BTREE,
  CONSTRAINT `study_plan_chapters_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `study_plan_chapters_ibfk_2` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of study_plan_chapters
-- ----------------------------
INSERT INTO `study_plan_chapters` VALUES (10, 1066, 2029, 'Introducción al Diseño UX/UI y Figma', NULL, 1, 1692026679);
INSERT INTO `study_plan_chapters` VALUES (11, 1066, 2029, 'Diseño Visual y Prototipado en Figma', NULL, 2, 1692027019);
INSERT INTO `study_plan_chapters` VALUES (12, 1066, 2029, 'Implementación con HTML y CSS Básico', NULL, 3, 1692027130);
INSERT INTO `study_plan_chapters` VALUES (13, 1066, 2029, 'Diseño Responsivo y Adaptativo', NULL, 4, 1692027429);
INSERT INTO `study_plan_chapters` VALUES (14, 1066, 2029, 'Diseño Accesible e Inclusivo', NULL, 5, 1692027520);
INSERT INTO `study_plan_chapters` VALUES (15, 1066, 2029, 'Proyecto Final y Mejoras Continuas', NULL, 6, 1692027596);
INSERT INTO `study_plan_chapters` VALUES (16, 1067, 2030, 'Introducción al desarrollo web', NULL, 1, 1692031085);
INSERT INTO `study_plan_chapters` VALUES (17, 1067, 2030, 'Desarrollo Front-end con React', NULL, 2, 1692031585);
INSERT INTO `study_plan_chapters` VALUES (18, 1067, 2030, 'Desarrollo Back-end con Laravel', NULL, 3, 1692031707);
INSERT INTO `study_plan_chapters` VALUES (19, 1067, 2030, 'Integración Front-end y Back-end', NULL, 4, 1692031813);
INSERT INTO `study_plan_chapters` VALUES (20, 1067, 2030, 'Desarrollo Avanzado con React y Laravel', NULL, 5, 1692031906);
INSERT INTO `study_plan_chapters` VALUES (21, 1067, 2030, 'Seguridad y Pruebas', NULL, 6, 1692031962);
INSERT INTO `study_plan_chapters` VALUES (22, 1067, 2030, 'Despliegue y Gestión de Aplicaciones', NULL, 7, 1692032038);
INSERT INTO `study_plan_chapters` VALUES (23, 1067, 2030, 'Proyecto Final', NULL, 8, 1692032096);

-- ----------------------------
-- Table structure for study_plan_text_lessons
-- ----------------------------
DROP TABLE IF EXISTS `study_plan_text_lessons`;
CREATE TABLE `study_plan_text_lessons`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `creator_id` int NOT NULL,
  `webinar_id` int NOT NULL,
  `chapter_id` int NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `order` int UNSIGNED NULL DEFAULT NULL,
  `created_at` int UNSIGNED NULL DEFAULT NULL,
  `updated_at` int UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 84 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of study_plan_text_lessons
-- ----------------------------
INSERT INTO `study_plan_text_lessons` VALUES (1, 1066, 2029, 1, 'Introducción al diseño de experiencia de usuario (UX) y diseño de interfaz de usuario (UI)', NULL, 1, 1692025094, NULL);
INSERT INTO `study_plan_text_lessons` VALUES (2, 1066, 2029, 1, 'Introducción a la herramienta Figma: conceptos básicos y funcionalidades', NULL, 2, 1692025368, NULL);
INSERT INTO `study_plan_text_lessons` VALUES (3, 1066, 2029, 1, 'Configuración del espacio de trabajo en Figma', NULL, 3, 1692025425, NULL);
INSERT INTO `study_plan_text_lessons` VALUES (4, 1066, 2029, 1, 'Creación de un primer proyecto de diseño', NULL, 4, 1692025449, NULL);
INSERT INTO `study_plan_text_lessons` VALUES (5, 1066, 2029, 2, 'Principios de diseño visual: color, tipografía, formas y composición', NULL, 5, 1692025502, NULL);
INSERT INTO `study_plan_text_lessons` VALUES (6, 1066, 2029, 2, 'Creación de paletas de colores y selección de fuentes para proyectos UX/UI', NULL, 6, 1692025523, NULL);
INSERT INTO `study_plan_text_lessons` VALUES (7, 1066, 2029, 2, 'Diseño de elementos básicos de interfaz: botones, formularios y elementos de navegación', NULL, 7, 1692025628, NULL);
INSERT INTO `study_plan_text_lessons` VALUES (8, 1066, 2029, 3, 'Investigación de usuarios y definición de objetivos', NULL, 8, 1692025703, NULL);
INSERT INTO `study_plan_text_lessons` VALUES (9, 1066, 2029, 3, 'Creación de buyer personas y customer journey map', NULL, 9, 1692025748, NULL);
INSERT INTO `study_plan_text_lessons` VALUES (10, 1066, 2029, 3, 'Diseño de wireframes y prototipos de baja fidelidad', NULL, 10, 1692025770, NULL);
INSERT INTO `study_plan_text_lessons` VALUES (11, 1066, 2029, 4, 'Creación de prototipos interactivos de alta fidelidad en Figma', NULL, 11, 1692025911, NULL);
INSERT INTO `study_plan_text_lessons` VALUES (12, 1066, 2029, 4, 'Transiciones y animaciones en Figma para mejorar la experiencia del usuario', NULL, 12, 1692025934, NULL);
INSERT INTO `study_plan_text_lessons` VALUES (13, 1066, 2029, 4, 'Pruebas de usabilidad y feedback iterativo', NULL, 13, 1692025957, NULL);
INSERT INTO `study_plan_text_lessons` VALUES (14, 1066, 2029, 5, 'Diseño para diferentes dispositivos: desktop, tablet y móvil', NULL, 14, 1692026015, NULL);
INSERT INTO `study_plan_text_lessons` VALUES (15, 1066, 2029, 5, 'Uso de componentes y estilos reutilizables en Figma', NULL, 15, 1692026032, NULL);
INSERT INTO `study_plan_text_lessons` VALUES (16, 1066, 2029, 5, 'Pruebas de diseño en diferentes resoluciones', NULL, 16, 1692026048, NULL);
INSERT INTO `study_plan_text_lessons` VALUES (17, 1066, 2029, 6, 'Diseño de interfaces complejas y aplicaciones web', NULL, 17, 1692026110, NULL);
INSERT INTO `study_plan_text_lessons` VALUES (18, 1066, 2029, 6, 'Integración de iconografía y recursos externos', NULL, 18, 1692026131, NULL);
INSERT INTO `study_plan_text_lessons` VALUES (19, 1066, 2029, 6, 'Uso de plugins y recursos adicionales en Figma', NULL, 19, 1692026152, NULL);
INSERT INTO `study_plan_text_lessons` VALUES (20, 1066, 2029, 7, 'Importancia de las microinteracciones en el diseño de UI', NULL, 20, 1692026207, NULL);
INSERT INTO `study_plan_text_lessons` VALUES (21, 1066, 2029, 7, 'Creación de microinteracciones en Figma', NULL, 21, 1692026224, NULL);
INSERT INTO `study_plan_text_lessons` VALUES (22, 1066, 2029, 7, 'Animaciones y detalles para mejorar la usabilidad', NULL, 22, 1692026241, NULL);
INSERT INTO `study_plan_text_lessons` VALUES (23, 1066, 2029, 8, 'Diseño accesible y cómo abordar la inclusión en el diseño UX/UI', NULL, 23, 1692026282, NULL);
INSERT INTO `study_plan_text_lessons` VALUES (24, 1066, 2029, 8, 'Herramientas para evaluar y mejorar la accesibilidad', NULL, 24, 1692026303, NULL);
INSERT INTO `study_plan_text_lessons` VALUES (25, 1066, 2029, 8, 'Diseño pensando en diversas capacidades y necesidades', NULL, 25, 1692026320, NULL);
INSERT INTO `study_plan_text_lessons` VALUES (26, 1066, 2029, 10, '-Introducción al diseño de experiencia de usuario (UX) y diseño de interfaz de usuario (UI)', NULL, 26, 1692027856, 1692027856);
INSERT INTO `study_plan_text_lessons` VALUES (27, 1066, 2029, 10, '-Introducción a la herramienta Figma: conceptos básicos y funcionalidades', NULL, 27, 1692027875, 1692027875);
INSERT INTO `study_plan_text_lessons` VALUES (28, 1066, 2029, 10, '-Creación de un primer proyecto de diseño en Figma', NULL, 28, 1692027889, 1692027889);
INSERT INTO `study_plan_text_lessons` VALUES (29, 1066, 2029, 11, '-Principios de diseño visual: color, tipografía, formas y composición', NULL, 29, 1692027907, 1692027907);
INSERT INTO `study_plan_text_lessons` VALUES (30, 1066, 2029, 11, '-Creación de paletas de colores y selección de fuentes para proyectos UX/UI', NULL, 30, 1692028138, 1692028138);
INSERT INTO `study_plan_text_lessons` VALUES (31, 1066, 2029, 11, '-Diseño de elementos básicos de interfaz: botones, formularios y elementos de navegación', NULL, 31, 1692028118, 1692028118);
INSERT INTO `study_plan_text_lessons` VALUES (32, 1066, 2029, 11, '-Prototipado interactivo en Figma: transiciones y animaciones', NULL, 32, 1692028100, 1692028100);
INSERT INTO `study_plan_text_lessons` VALUES (33, 1066, 2029, 12, '-Introducción a HTML: estructura básica de un documento HTML', NULL, 33, 1692028067, 1692028067);
INSERT INTO `study_plan_text_lessons` VALUES (34, 1066, 2029, 12, '-Introducción a CSS: selectores, propiedades y estilizado básico', NULL, 34, 1692028050, 1692028050);
INSERT INTO `study_plan_text_lessons` VALUES (35, 1066, 2029, 12, '-Estructuración de contenido con HTML y aplicación de estilos con CSS', NULL, 35, 1692028038, 1692028038);
INSERT INTO `study_plan_text_lessons` VALUES (36, 1066, 2029, 12, '-Implementación de tus diseños de Figma en HTML y CSS', NULL, 36, 1692027917, 1692027917);
INSERT INTO `study_plan_text_lessons` VALUES (37, 1066, 2029, 13, '-Diseño responsivo: adaptación a diferentes dispositivos y resoluciones', NULL, 37, 1692028026, 1692028026);
INSERT INTO `study_plan_text_lessons` VALUES (38, 1066, 2029, 13, '-Media queries en CSS para crear diseños adaptativos', NULL, 38, 1692028013, 1692028013);
INSERT INTO `study_plan_text_lessons` VALUES (39, 1066, 2029, 13, '-Implementación de diseño responsivo en tus proyectos', NULL, 39, 1692028002, 1692028002);
INSERT INTO `study_plan_text_lessons` VALUES (40, 1066, 2029, 14, '-Diseño considerando la accesibilidad: principios y mejores prácticas', NULL, 40, 1692027988, 1692027988);
INSERT INTO `study_plan_text_lessons` VALUES (41, 1066, 2029, 14, '-Implementación de características accesibles en HTML y CSS', NULL, 41, 1692027974, 1692027974);
INSERT INTO `study_plan_text_lessons` VALUES (42, 1066, 2029, 14, '-Pruebas de usabilidad enfocadas en la accesibilidad', NULL, 42, 1692027964, 1692027964);
INSERT INTO `study_plan_text_lessons` VALUES (43, 1066, 2029, 15, '-Desarrollo completo de un proyecto final desde el diseño en Figma hasta la implementación en HTML y CSS', NULL, 43, 1692027952, 1692027952);
INSERT INTO `study_plan_text_lessons` VALUES (44, 1066, 2029, 15, '-Iteraciones basadas en feedback y pruebas de usabilidad', NULL, 44, 1692027939, 1692027939);
INSERT INTO `study_plan_text_lessons` VALUES (45, 1066, 2029, 15, '-Presentación y demostración del proyecto final', NULL, 45, 1692027926, 1692027926);
INSERT INTO `study_plan_text_lessons` VALUES (46, 1067, 2030, 16, 'Fundamentos de HTML', NULL, 1, 1692031096, NULL);
INSERT INTO `study_plan_text_lessons` VALUES (47, 1067, 2030, 16, 'Fundamentos de CSS', NULL, 2, 1692031109, NULL);
INSERT INTO `study_plan_text_lessons` VALUES (48, 1067, 2030, 16, 'Estructura de un sitio web básico', NULL, 3, 1692031569, NULL);
INSERT INTO `study_plan_text_lessons` VALUES (49, 1067, 2030, 17, 'Introducción a React', NULL, 4, 1692031595, NULL);
INSERT INTO `study_plan_text_lessons` VALUES (50, 1067, 2030, 17, 'Componentes y JSX', NULL, 5, 1692031607, NULL);
INSERT INTO `study_plan_text_lessons` VALUES (51, 1067, 2030, 17, 'State y Props', NULL, 6, 1692031616, NULL);
INSERT INTO `study_plan_text_lessons` VALUES (52, 1067, 2030, 17, 'Manejo de eventos', NULL, 7, 1692031627, NULL);
INSERT INTO `study_plan_text_lessons` VALUES (53, 1067, 2030, 17, 'Routing y navegación en React', NULL, 8, 1692031662, NULL);
INSERT INTO `study_plan_text_lessons` VALUES (54, 1067, 2030, 17, 'Manipulación del DOM con React', NULL, 9, 1692031674, NULL);
INSERT INTO `study_plan_text_lessons` VALUES (55, 1067, 2030, 17, 'Estilizado con CSS en React', NULL, 10, 1692031685, NULL);
INSERT INTO `study_plan_text_lessons` VALUES (56, 1067, 2030, 17, 'Integración con API REST', NULL, 11, 1692031696, NULL);
INSERT INTO `study_plan_text_lessons` VALUES (57, 1067, 2030, 18, 'Introducción a Laravel', NULL, 12, 1692031722, NULL);
INSERT INTO `study_plan_text_lessons` VALUES (58, 1067, 2030, 18, 'Configuración y creación de rutas', NULL, 13, 1692031731, NULL);
INSERT INTO `study_plan_text_lessons` VALUES (59, 1067, 2030, 18, 'Controladores y modelos en Laravel', NULL, 14, 1692031740, NULL);
INSERT INTO `study_plan_text_lessons` VALUES (60, 1067, 2030, 18, 'Interacción con bases de datos usando Eloquent ORM', NULL, 15, 1692031754, NULL);
INSERT INTO `study_plan_text_lessons` VALUES (61, 1067, 2030, 18, 'Validación de datos en Laravel', NULL, 16, 1692031767, NULL);
INSERT INTO `study_plan_text_lessons` VALUES (62, 1067, 2030, 18, 'Autenticación y autorización en Laravel', NULL, 17, 1692031777, NULL);
INSERT INTO `study_plan_text_lessons` VALUES (63, 1067, 2030, 18, 'API RESTful con Laravel', NULL, 18, 1692031788, NULL);
INSERT INTO `study_plan_text_lessons` VALUES (64, 1067, 2030, 18, 'Manipulación de archivos en Laravel', NULL, 19, 1692031799, NULL);
INSERT INTO `study_plan_text_lessons` VALUES (65, 1067, 2030, 19, 'Consumo de APIs en React', NULL, 20, 1692031828, NULL);
INSERT INTO `study_plan_text_lessons` VALUES (66, 1067, 2030, 19, 'Comunicación cliente-servidor', NULL, 21, 1692031837, NULL);
INSERT INTO `study_plan_text_lessons` VALUES (67, 1067, 2030, 19, 'Autenticación y gestión de sesiones en React y Laravel', NULL, 22, 1692031886, NULL);
INSERT INTO `study_plan_text_lessons` VALUES (68, 1067, 2030, 19, 'Uso de tokens y JSON Web Tokens (JWT)', NULL, 23, 1692031894, NULL);
INSERT INTO `study_plan_text_lessons` VALUES (69, 1067, 2030, 20, 'Redux y gestión del estado en React', NULL, 24, 1692031917, NULL);
INSERT INTO `study_plan_text_lessons` VALUES (70, 1067, 2030, 20, 'Optimización y rendimiento en React', NULL, 25, 1692031926, NULL);
INSERT INTO `study_plan_text_lessons` VALUES (71, 1067, 2030, 20, 'Integración de librerías externas en React', NULL, 26, 1692031934, NULL);
INSERT INTO `study_plan_text_lessons` VALUES (72, 1067, 2030, 20, 'Técnicas de optimización y rendimiento en Laravel', NULL, 27, 1692031945, NULL);
INSERT INTO `study_plan_text_lessons` VALUES (73, 1067, 2030, 21, 'Principios de seguridad web', NULL, 28, 1692031978, NULL);
INSERT INTO `study_plan_text_lessons` VALUES (74, 1067, 2030, 21, 'Prevención de ataques comunes (injection, cross-site scripting, etc.)', NULL, 29, 1692032006, NULL);
INSERT INTO `study_plan_text_lessons` VALUES (75, 1067, 2030, 21, 'Pruebas unitarias y de integración en React y Laravel', NULL, 30, 1692032016, NULL);
INSERT INTO `study_plan_text_lessons` VALUES (76, 1067, 2030, 21, 'Herramientas y buenas prácticas de seguridad y pruebas', NULL, 31, 1692032025, NULL);
INSERT INTO `study_plan_text_lessons` VALUES (77, 1067, 2030, 22, 'Configuración de servidores web y alojamiento de aplicaciones', NULL, 32, 1692032057, NULL);
INSERT INTO `study_plan_text_lessons` VALUES (78, 1067, 2030, 22, 'Despliegue de aplicaciones React y Laravel en diferentes entornos', NULL, 33, 1692032065, NULL);
INSERT INTO `study_plan_text_lessons` VALUES (79, 1067, 2030, 22, 'Automatización de tareas con scripts de implementación', NULL, 34, 1692032075, NULL);
INSERT INTO `study_plan_text_lessons` VALUES (80, 1067, 2030, 22, 'Monitoreo y registro de aplicaciones web', NULL, 35, 1692032085, NULL);
INSERT INTO `study_plan_text_lessons` VALUES (81, 1067, 2030, 23, 'Desarrollo de una aplicación web completa utilizando todas las habilidades aprendidas durante el curso', NULL, 36, 1692032114, NULL);
INSERT INTO `study_plan_text_lessons` VALUES (82, 1067, 2030, 23, 'Trabajo en equipo (si es posible) y aplicación de metodologías ágiles', NULL, 37, 1692032125, NULL);
INSERT INTO `study_plan_text_lessons` VALUES (83, 1067, 2030, 23, 'Presentación y demostración del proyecto final', NULL, 38, 1692032136, NULL);

-- ----------------------------
-- Table structure for subscribe_reminds
-- ----------------------------
DROP TABLE IF EXISTS `subscribe_reminds`;
CREATE TABLE `subscribe_reminds`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int UNSIGNED NOT NULL,
  `subscribe_id` int UNSIGNED NOT NULL,
  `created_at` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `subscribe_reminds_subscribe_id_foreign`(`subscribe_id`) USING BTREE,
  INDEX `subscribe_reminds_user_id_foreign`(`user_id`) USING BTREE,
  CONSTRAINT `subscribe_reminds_subscribe_id_foreign` FOREIGN KEY (`subscribe_id`) REFERENCES `subscribes` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `subscribe_reminds_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of subscribe_reminds
-- ----------------------------

-- ----------------------------
-- Table structure for subscribe_translations
-- ----------------------------
DROP TABLE IF EXISTS `subscribe_translations`;
CREATE TABLE `subscribe_translations`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `subscribe_id` int UNSIGNED NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `subscribe_translations_subscribe_id_foreign`(`subscribe_id`) USING BTREE,
  INDEX `subscribe_translations_locale_index`(`locale`) USING BTREE,
  CONSTRAINT `subscribe_translations_subscribe_id_foreign` FOREIGN KEY (`subscribe_id`) REFERENCES `subscribes` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of subscribe_translations
-- ----------------------------

-- ----------------------------
-- Table structure for subscribe_uses
-- ----------------------------
DROP TABLE IF EXISTS `subscribe_uses`;
CREATE TABLE `subscribe_uses`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int UNSIGNED NOT NULL,
  `subscribe_id` int UNSIGNED NOT NULL,
  `webinar_id` int UNSIGNED NULL DEFAULT NULL,
  `bundle_id` int UNSIGNED NULL DEFAULT NULL,
  `sale_id` int UNSIGNED NOT NULL,
  `installment_order_id` int UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `subscribe_uses_user_id_foreign`(`user_id`) USING BTREE,
  INDEX `subscribe_uses_webinar_id_foreign`(`webinar_id`) USING BTREE,
  INDEX `subscribe_uses_subscribe_id_foreign`(`subscribe_id`) USING BTREE,
  INDEX `subscribe_uses_sale_id_foreign`(`sale_id`) USING BTREE,
  INDEX `subscribe_uses_bundle_id_foreign`(`bundle_id`) USING BTREE,
  INDEX `subscribe_uses_installment_order_id_foreign`(`installment_order_id`) USING BTREE,
  CONSTRAINT `subscribe_uses_bundle_id_foreign` FOREIGN KEY (`bundle_id`) REFERENCES `bundles` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `subscribe_uses_installment_order_id_foreign` FOREIGN KEY (`installment_order_id`) REFERENCES `installment_orders` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `subscribe_uses_sale_id_foreign` FOREIGN KEY (`sale_id`) REFERENCES `sales` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `subscribe_uses_subscribe_id_foreign` FOREIGN KEY (`subscribe_id`) REFERENCES `subscribes` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `subscribe_uses_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `subscribe_uses_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of subscribe_uses
-- ----------------------------

-- ----------------------------
-- Table structure for subscribes
-- ----------------------------
DROP TABLE IF EXISTS `subscribes`;
CREATE TABLE `subscribes`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `usable_count` int UNSIGNED NOT NULL,
  `days` int UNSIGNED NOT NULL,
  `price` double(15, 2) UNSIGNED NOT NULL,
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_popular` tinyint(1) NOT NULL DEFAULT 0,
  `infinite_use` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of subscribes
-- ----------------------------

-- ----------------------------
-- Table structure for support_conversations
-- ----------------------------
DROP TABLE IF EXISTS `support_conversations`;
CREATE TABLE `support_conversations`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `support_id` int UNSIGNED NOT NULL,
  `supporter_id` int UNSIGNED NULL DEFAULT NULL,
  `sender_id` int UNSIGNED NULL DEFAULT NULL,
  `attach` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `support_conversations_support_id_foreign`(`support_id`) USING BTREE,
  INDEX `support_conversations_sender_id_foreign`(`sender_id`) USING BTREE,
  INDEX `support_conversations_supporter_id_foreign`(`supporter_id`) USING BTREE,
  CONSTRAINT `support_conversations_sender_id_foreign` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `support_conversations_support_id_foreign` FOREIGN KEY (`support_id`) REFERENCES `supports` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 64 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of support_conversations
-- ----------------------------

-- ----------------------------
-- Table structure for support_department_translations
-- ----------------------------
DROP TABLE IF EXISTS `support_department_translations`;
CREATE TABLE `support_department_translations`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `support_department_id` int UNSIGNED NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `support_department_id`(`support_department_id`) USING BTREE,
  INDEX `support_department_translations_locale_index`(`locale`) USING BTREE,
  CONSTRAINT `support_department_id` FOREIGN KEY (`support_department_id`) REFERENCES `support_departments` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of support_department_translations
-- ----------------------------

-- ----------------------------
-- Table structure for support_departments
-- ----------------------------
DROP TABLE IF EXISTS `support_departments`;
CREATE TABLE `support_departments`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of support_departments
-- ----------------------------

-- ----------------------------
-- Table structure for supports
-- ----------------------------
DROP TABLE IF EXISTS `supports`;
CREATE TABLE `supports`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int UNSIGNED NOT NULL,
  `webinar_id` int UNSIGNED NULL DEFAULT NULL,
  `department_id` int UNSIGNED NULL DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('open','close','replied','supporter_replied') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'open',
  `created_at` int UNSIGNED NULL DEFAULT NULL,
  `updated_at` int UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `supports_user_id_foreign`(`user_id`) USING BTREE,
  INDEX `supports_webinar_id_foreign`(`webinar_id`) USING BTREE,
  INDEX `supports_department_id_foreign`(`department_id`) USING BTREE,
  CONSTRAINT `supports_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `support_departments` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `supports_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `supports_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 35 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of supports
-- ----------------------------

-- ----------------------------
-- Table structure for tags
-- ----------------------------
DROP TABLE IF EXISTS `tags`;
CREATE TABLE `tags`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `webinar_id` int UNSIGNED NULL DEFAULT NULL,
  `bundle_id` int UNSIGNED NULL DEFAULT NULL,
  `upcoming_course_id` int UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `tags_webinar_id_foreign`(`webinar_id`) USING BTREE,
  INDEX `tags_bundle_id_foreign`(`bundle_id`) USING BTREE,
  INDEX `tags_upcoming_course_id_foreign`(`upcoming_course_id`) USING BTREE,
  CONSTRAINT `tags_bundle_id_foreign` FOREIGN KEY (`bundle_id`) REFERENCES `bundles` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `tags_upcoming_course_id_foreign` FOREIGN KEY (`upcoming_course_id`) REFERENCES `upcoming_courses` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `tags_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 6789 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tags
-- ----------------------------
INSERT INTO `tags` VALUES (6711, 'BOOTCAMP ', 2026, NULL, NULL);
INSERT INTO `tags` VALUES (6712, ' .NET CORE ', 2026, NULL, NULL);
INSERT INTO `tags` VALUES (6713, ' REACT', 2026, NULL, NULL);
INSERT INTO `tags` VALUES (6770, 'Programación Básica', 2025, NULL, NULL);
INSERT INTO `tags` VALUES (6779, 'Desarrollo Web', 2030, NULL, NULL);
INSERT INTO `tags` VALUES (6780, 'Full Stack', 2030, NULL, NULL);
INSERT INTO `tags` VALUES (6781, 'Javascript', 2030, NULL, NULL);
INSERT INTO `tags` VALUES (6782, 'HTML', 2030, NULL, NULL);
INSERT INTO `tags` VALUES (6783, 'Laravel', 2030, NULL, NULL);
INSERT INTO `tags` VALUES (6784, 'programación', 2027, NULL, NULL);
INSERT INTO `tags` VALUES (6785, 'niños', 2027, NULL, NULL);
INSERT INTO `tags` VALUES (6786, 'Diseño Web', 2029, NULL, NULL);
INSERT INTO `tags` VALUES (6787, 'Diseño de Intefaz', 2029, NULL, NULL);
INSERT INTO `tags` VALUES (6788, 'Experiencia de Usuario', 2029, NULL, NULL);

-- ----------------------------
-- Table structure for testimonial_translations
-- ----------------------------
DROP TABLE IF EXISTS `testimonial_translations`;
CREATE TABLE `testimonial_translations`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `testimonial_id` int UNSIGNED NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_bio` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `testimonial_translations_testimonial_id_foreign`(`testimonial_id`) USING BTREE,
  INDEX `testimonial_translations_locale_index`(`locale`) USING BTREE,
  CONSTRAINT `testimonial_translations_testimonial_id_foreign` FOREIGN KEY (`testimonial_id`) REFERENCES `testimonials` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of testimonial_translations
-- ----------------------------

-- ----------------------------
-- Table structure for testimonials
-- ----------------------------
DROP TABLE IF EXISTS `testimonials`;
CREATE TABLE `testimonials`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `rate` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `status` enum('active','disable') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'disable',
  `created_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of testimonials
-- ----------------------------

-- ----------------------------
-- Table structure for text_lesson_translations
-- ----------------------------
DROP TABLE IF EXISTS `text_lesson_translations`;
CREATE TABLE `text_lesson_translations`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `text_lesson_id` int UNSIGNED NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `summary` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `text_lesson_id`(`text_lesson_id`) USING BTREE,
  INDEX `text_lesson_translations_locale_index`(`locale`) USING BTREE,
  CONSTRAINT `text_lesson_id` FOREIGN KEY (`text_lesson_id`) REFERENCES `text_lessons` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 184 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of text_lesson_translations
-- ----------------------------
INSERT INTO `text_lesson_translations` VALUES (14, 22, 'es', 'Paradigmas de Programación', 'Imperativa\r\nDescripción\r\nDeclarativa\r\nDescripción', '<p><font style=\"background-color: rgb(255, 255, 255);\" color=\"#000000\"><b>Paradigmas de Programación&nbsp;</b></font></p><p>Imperativa</p><p>Descripción</p><p>Declarativa</p><p>Descripción</p>');
INSERT INTO `text_lesson_translations` VALUES (15, 23, 'es', 'Programación Estructurada', 'Secuencia\r\nSelección o condicional\r\nIteración', '<p><b>Programación Estructurada</b></p><p>Secuencia</p><p>Selección o condicional</p><p>Iteración</p>');
INSERT INTO `text_lesson_translations` VALUES (16, 24, 'es', 'Programación Funcional', 'Descripción', '<p style=\"margin: 15px 0px;\"><b style=\"\"><font color=\"#000000\">Programación Funcional</font></b></p><p>Descripción</p>');
INSERT INTO `text_lesson_translations` VALUES (17, 25, 'es', 'Programación Reactiva', 'Características de la programación reactiva\r\nResponsivos\r\nResilientes\r\nElásticos\r\nOrientados a mensajes', '<ul style=\"font-family: Poppins; padding-left: 2rem; margin-bottom: 1rem; font-size: 16px;\"><p style=\"margin: 15px 0px;\"><font color=\"#000000\">Programación Reactiva</font></p><li style=\"\"><font color=\"#000000\">Características de la programación reactiva</font></li><li style=\"\"><font color=\"#000000\">Responsivos</font></li><li style=\"\"><font color=\"#000000\">Resilientes</font></li><li style=\"\"><font color=\"#000000\">Elásticos</font></li><li style=\"\"><font color=\"#000000\">Orientados a mensajes</font></li></ul>');
INSERT INTO `text_lesson_translations` VALUES (18, 26, 'es', 'Programación orientada a objetos', 'Fundamentos\r\nEncapsulación\r\nHerencia\r\nPolimorfismo\r\nAbstracción\r\nModularidad\r\nReutilización\r\nVisión POO\r\nLenguajes basados en clases', '<ul style=\"font-family: Poppins; padding-left: 2rem; margin-bottom: 1rem; font-size: 16px;\"><p style=\"margin: 15px 0px;\"><b style=\"\"><font color=\"#000000\">Programación orientada a objetos</font></b></p><li style=\"color: rgb(33, 37, 41);\">Fundamentos</li><ul style=\"color: rgb(33, 37, 41); padding-left: 2rem;\"><li><i>Encapsulación</i></li><li><i>Herencia</i></li><li><i>Polimorfismo</i></li><li><i>Abstracción</i></li></ul><li style=\"color: rgb(33, 37, 41);\">Modularidad</li><li style=\"color: rgb(33, 37, 41);\">Reutilización</li><li style=\"color: rgb(33, 37, 41);\">Visión POO</li><li style=\"color: rgb(33, 37, 41);\">Lenguajes basados en clases</li></ul>');
INSERT INTO `text_lesson_translations` VALUES (19, 27, 'es', 'Principios SOLID', 'S   -  Single-responsiblity Principle\r\nO  -  Open-closed Principle\r\nL   -  Liskov Substitution Principle\r\nI    -  Interface Segregation Principle\r\nD  -  Dependency Inversion Principle', '<p><span style=\"font-size: 14px;\"><b>Principios SOLID</b></span></p><p><span style=\"font-size: 14px;\"><b>S</b>&nbsp; &nbsp; &nbsp; Single-responsiblity Principle</span></p><p><span style=\"font-size: 14px;\"><b>O</b>&nbsp; &nbsp; &nbsp;Open-closed Principle</span></p><p><span style=\"font-size: 14px;\"><b>L</b>&nbsp; &nbsp; &nbsp; Liskov Substitution Principle</span></p><p><span style=\"font-size: 14px;\"><b>I</b>&nbsp; &nbsp; &nbsp; &nbsp;Interface Segregation Principle</span></p><p><span style=\"font-size: 14px;\"><b>D</b>&nbsp; &nbsp; &nbsp;Dependency Inversion Principle</span></p>');
INSERT INTO `text_lesson_translations` VALUES (20, 28, 'es', 'Patrones creacionales', 'Abstract Factory\r\nFactory Method\r\nBuilder Separa\r\nPrototype\r\nSingleton', '<ul style=\"font-family: Poppins; padding-left: 2rem; margin-bottom: 1rem; font-size: 16px;\"><p style=\"margin: 15px 0px;\"><font color=\"#000000\">Patrones creacionales</font></p><li style=\"color: rgb(33, 37, 41);\">Abstract Factory</li><li style=\"color: rgb(33, 37, 41);\">Factory Method</li><li style=\"color: rgb(33, 37, 41);\">Builder Separa</li><li style=\"color: rgb(33, 37, 41);\">Prototype</li><li style=\"color: rgb(33, 37, 41);\">Singleton</li></ul>');
INSERT INTO `text_lesson_translations` VALUES (21, 29, 'es', 'Patrones estructurales', 'Adapter\r\nBridge\r\nComposite\r\nDecorator\r\nFacade\r\nFlyeight\r\nProxy', '<ul style=\"padding-left: 2rem; margin-bottom: 1rem;\"><li style=\"\"><font color=\"#212529\" face=\"Poppins\"><span style=\"font-size: 16px;\"><b>Patrones estructurales</b></span></font></li><li style=\"color: rgb(33, 37, 41); font-family: Poppins; font-size: 16px;\">Adapter</li><li style=\"color: rgb(33, 37, 41); font-family: Poppins; font-size: 16px;\">Bridge</li><li style=\"color: rgb(33, 37, 41); font-family: Poppins; font-size: 16px;\">Composite</li><li style=\"color: rgb(33, 37, 41); font-family: Poppins; font-size: 16px;\">Decorator</li><li style=\"color: rgb(33, 37, 41); font-family: Poppins; font-size: 16px;\">Facade</li><li style=\"color: rgb(33, 37, 41); font-family: Poppins; font-size: 16px;\">Flyeight</li><li style=\"color: rgb(33, 37, 41); font-family: Poppins; font-size: 16px;\">Proxy</li></ul>');
INSERT INTO `text_lesson_translations` VALUES (22, 30, 'es', 'Patrones de comportamiento', 'Chain of Responsibility\r\nCommand\r\nInterpreter\r\nIterator\r\nMediator\r\nMemento\r\nObserver\r\nState\r\nTemplate Method\r\nVisitor', '<ul style=\"font-family: Poppins; padding-left: 2rem; margin-bottom: 1rem; color: rgb(33, 37, 41); font-size: 16px;\"><li><b>Patrones de comportamiento</b></li><li><b><br></b></li><li>Chain of Responsibility</li><li>Command</li><li>Interpreter</li><li>Iterator</li><li>Mediator</li><li>Memento</li><li>Observer</li><li>State</li><li>Template Method</li><li>Visitor</li></ul>');
INSERT INTO `text_lesson_translations` VALUES (23, 31, 'es', 'Fundamentos de Bases de Datos', '¿Qué es un software de base de datos?\r\n¿Cuáles son los beneficios de usar un software de base de datos?\r\n¿Qué partes tienes un software de base de datos?\r\n¿Cómo funciona un software de base de datos?\r\n¿Cómo y para qué se utiliza el software de base de datos?\r\n¿Cuáles son los lenguajes de base de datos más importantes?', '<p><span style=\"font-family: Poppins; font-size: 16px;\"><font color=\"#000000\"><b>Fundamentos de Bases de Datos</b></font></span></p><p>¿Qué es un software de base de datos?</p><p>¿Cuáles son los beneficios de usar un software de base de datos?</p><p>¿Qué partes tienes un software de base de datos?</p><p>¿Cómo funciona un software de base de datos?</p><p>¿Cómo y para qué se utiliza el software de base de datos?</p><p>¿Cuáles son los lenguajes de base de datos más importantes?</p>');
INSERT INTO `text_lesson_translations` VALUES (24, 32, 'es', 'SQL', 'Sentencias SQL\r\nSelect\r\nUpdate\r\nCreate\r\nJoin', '<p><span style=\"font-family: Poppins; font-size: 16px;\"><font color=\"#000000\"><b>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;SQL</b></font></span></p><ul style=\"font-family: Poppins; padding-left: 2rem; margin-bottom: 1rem; color: rgb(33, 37, 41); font-size: 16px;\"><ul><li>Sentencias SQL<ul style=\"padding-left: 2rem;\"><ul><li><i>Select</i></li><li><i>Update</i></li><li><i>Create</i></li><li><i>Join</i></li></ul></ul></li></ul></ul>');
INSERT INTO `text_lesson_translations` VALUES (25, 33, 'es', 'NoSQL', 'Descripción', '<ul style=\"font-family: Poppins; padding-left: 2rem; margin-bottom: 1rem; font-size: 16px;\"><p style=\"margin: 15px 0px;\"><font color=\"#000000\"><b>NoSQL</b></font></p><li style=\"color: rgb(33, 37, 41);\">Descripción</li></ul>');
INSERT INTO `text_lesson_translations` VALUES (26, 34, 'es', 'Flujos de trabajo', 'Flujo de trabajo de control de versiones\r\nFlujo de trabajo de git', '<ul style=\"font-family: Poppins; padding-left: 2rem; margin-bottom: 1rem; font-size: 16px;\"><p style=\"margin: 15px 0px;\"><font color=\"#000000\"><b>Flujos de trabajo</b></font></p><li style=\"color: rgb(33, 37, 41);\">Flujo de trabajo de control de versiones</li><li style=\"color: rgb(33, 37, 41);\">Flujo de trabajo de git</li></ul>');
INSERT INTO `text_lesson_translations` VALUES (27, 35, 'es', 'Arquitecturas', '¿Qué es la arquitectura de software?\r\n¿Por qué es importante la arquitectura de software?\r\nPatrones de arquitectura de software.\r\nCómo decidir la cantidad de niveles que debe tener su aplicación.\r\nEscalado horizontal o vertical: ¿cuál es el adecuado para tu aplicación?\r\n¿Monolito o microservicio?\r\n¿Cuándo deberías usar NoSQL o SQL?\r\nElegir el lenguaje de programación adecuado para el trabajo.\r\nCómo convertirse en un arquitecto de software', '<ul style=\"font-family: Poppins; padding-left: 2rem; margin-bottom: 1rem; font-size: 16px;\"><p style=\"margin: 15px 0px;\"><b style=\"\"><font color=\"#000000\">Arquitecturas</font></b></p><li style=\"color: rgb(33, 37, 41);\">¿Qué es la arquitectura de software?</li><li style=\"color: rgb(33, 37, 41);\">¿Por qué es importante la arquitectura de software?</li><li style=\"color: rgb(33, 37, 41);\">Patrones de arquitectura de software.</li><li style=\"color: rgb(33, 37, 41);\">Cómo decidir la cantidad de niveles que debe tener su aplicación.</li><li style=\"color: rgb(33, 37, 41);\">Escalado horizontal o vertical: ¿cuál es el adecuado para tu aplicación?</li><li style=\"color: rgb(33, 37, 41);\">¿Monolito o microservicio?</li><li style=\"color: rgb(33, 37, 41);\">¿Cuándo deberías usar NoSQL o SQL?</li><li style=\"color: rgb(33, 37, 41);\">Elegir el lenguaje de programación adecuado para el trabajo.</li><li style=\"color: rgb(33, 37, 41);\">Cómo convertirse en un arquitecto de software</li></ul>');
INSERT INTO `text_lesson_translations` VALUES (28, 36, 'es', 'Introducción', '¿Qué es la programación?\r\nRamas de la programación\r\nlenguajes de programación', '<ul style=\"font-family: Poppins; padding-left: 2rem; margin-bottom: 1rem; font-size: 16px;\"><p style=\"margin: 15px 0px;\"><b style=\"\"><font color=\"#000000\">Introducción</font></b></p><li style=\"color: rgb(33, 37, 41);\">¿Qué es la programación?</li><li style=\"color: rgb(33, 37, 41);\">Ramas de la programación</li><li style=\"color: rgb(33, 37, 41);\">lenguajes de programación</li></ul>');
INSERT INTO `text_lesson_translations` VALUES (29, 37, 'es', 'Lógica y Conjunto', 'Tablas de Verdad\r\nCompuertas Lógicas', '<ul style=\"font-family: Poppins; padding-left: 2rem; margin-bottom: 1rem; font-size: 16px;\"><p style=\"margin: 15px 0px;\"><b style=\"\"><font color=\"#000000\">Lógica y Conjunto</font></b></p><li style=\"color: rgb(33, 37, 41);\">Tablas de Verdad</li><li style=\"color: rgb(33, 37, 41);\">Compuertas Lógicas</li></ul>');
INSERT INTO `text_lesson_translations` VALUES (30, 38, 'es', 'Algoritmos', '¿Qué es un algoritmo?\r\nDesarrollo de algoritmo con seudocódigo', '<ul style=\"font-family: Poppins; padding-left: 2rem; margin-bottom: 1rem; font-size: 16px;\"><p style=\"margin: 15px 0px;\"><b style=\"\"><font color=\"#000000\">Algoritmos</font></b></p><li style=\"color: rgb(33, 37, 41);\">¿Qué es un algoritmo?</li><li style=\"color: rgb(33, 37, 41);\">Desarrollo de algoritmo con seudocódigo</li></ul>');
INSERT INTO `text_lesson_translations` VALUES (31, 39, 'es', 'Variables y tipo de datos', 'Cómo funciona la persistencia de datos\r\nTipos de datos\r\n¿Qué es una variable?\r\nDeclaración y asignación de variables', '<ul style=\"font-family: Poppins; padding-left: 2rem; margin-bottom: 1rem; font-size: 16px;\"><p style=\"margin: 15px 0px;\"><b style=\"\"><font color=\"#000000\">Variables y tipo de datos</font></b></p><li style=\"color: rgb(33, 37, 41);\">Cómo funciona la persistencia de datos</li><li style=\"color: rgb(33, 37, 41);\">Tipos de datos</li><li style=\"color: rgb(33, 37, 41);\">¿Qué es una variable?</li><li style=\"color: rgb(33, 37, 41);\">Declaración y asignación de variables</li></ul>');
INSERT INTO `text_lesson_translations` VALUES (32, 40, 'es', 'Operadores', 'Operadores aritméticos\r\nJerarquía de operadores\r\nAgrupación de operadores', '<ul style=\"font-family: Poppins; padding-left: 2rem; margin-bottom: 1rem; font-size: 16px;\"><p style=\"margin: 15px 0px;\"><b style=\"\"><font color=\"#000000\">Operadores</font></b></p><li style=\"color: rgb(33, 37, 41);\">Operadores aritméticos</li><li style=\"color: rgb(33, 37, 41);\">Jerarquía de operadores</li><li style=\"color: rgb(33, 37, 41);\">Agrupación de operadores</li></ul>');
INSERT INTO `text_lesson_translations` VALUES (33, 41, 'es', 'Condicionales', 'Condicionales Simples\r\nCondicionales Dobles\r\nCondicionales Anidados\r\nCondicionales Múltiples\r\nSwitch', '<ul style=\"font-family: Poppins; padding-left: 2rem; margin-bottom: 1rem; font-size: 16px;\"><p style=\"margin: 15px 0px;\"><font color=\"#000000\" style=\"\"><b>Condicionales</b></font></p><li style=\"color: rgb(33, 37, 41);\">Condicionales Simples</li><li style=\"color: rgb(33, 37, 41);\">Condicionales Dobles</li><li style=\"color: rgb(33, 37, 41);\">Condicionales Anidados</li><li style=\"color: rgb(33, 37, 41);\">Condicionales Múltiples</li><li style=\"color: rgb(33, 37, 41);\">Switch</li></ul>');
INSERT INTO `text_lesson_translations` VALUES (34, 42, 'es', 'Ciclos', 'For\r\nWhile\r\nDo While', '<hr style=\"box-sizing: border-box; font-family: Poppins; margin-right: 0px; margin-left: 0px; color: rgb(33, 37, 41); background-color: currentcolor; border-top: 0px; opacity: 0.25; height: 1px; font-size: 16px;\"><ul style=\"font-family: Poppins; padding-left: 2rem; margin-bottom: 1rem; font-size: 16px;\"><p style=\"margin: 15px 0px;\"><b style=\"\"><font color=\"#000000\">Ciclos</font></b></p><li style=\"color: rgb(33, 37, 41);\">For</li><li style=\"color: rgb(33, 37, 41);\">While</li><li style=\"color: rgb(33, 37, 41);\">Do While</li></ul>');
INSERT INTO `text_lesson_translations` VALUES (35, 43, 'es', 'Estructura de Datos', 'Array\r\nMatrices\r\nColas\r\nPilas', '<ul style=\"font-family: Poppins; padding-left: 2rem; margin-bottom: 1rem; font-size: 16px;\"><p style=\"margin: 15px 0px;\"><b style=\"\"><font color=\"#000000\">Estructura de Datos</font></b></p><li style=\"color: rgb(33, 37, 41);\">Array</li><li style=\"color: rgb(33, 37, 41);\">Matrices</li><li style=\"color: rgb(33, 37, 41);\">Colas</li><li style=\"color: rgb(33, 37, 41);\">Pilas</li></ul>');
INSERT INTO `text_lesson_translations` VALUES (36, 44, 'es', 'Funciones', 'Definición de una función\r\nModificadores de una función\r\nTipo de retorno de un método\r\nNombre de la función\r\nArgumentos o parámetros de una función\r\nEl bloque de código', '<hr style=\"box-sizing: border-box; font-family: Poppins; margin-right: 0px; margin-left: 0px; color: rgb(33, 37, 41); background-color: currentcolor; border-top: 0px; opacity: 0.25; height: 1px; font-size: 16px;\"><ul style=\"font-family: Poppins; padding-left: 2rem; margin-bottom: 1rem; color: rgb(33, 37, 41); font-size: 16px;\"><p style=\"margin: 15px 0px; color: rgb(189, 61, 111);\">Funciones</p><li>Definición de una función</li><li>Modificadores de una función</li><li>Tipo de retorno de un método</li><li>Nombre de la función</li><li>Argumentos o parámetros de una función</li><li>El bloque de código</li></ul>');
INSERT INTO `text_lesson_translations` VALUES (37, 45, 'es', 'Introducción a .NET y C#', 'NET y C# son dos tecnologías de programación desarrolladas por Microsoft que se utilizan para crear aplicaciones modernas en diversos entornos, como aplicaciones de escritorio, aplicaciones web y aplicaciones móviles.\r\n\r\n.NET es un marco de trabajo de software desarrollado por Microsoft que proporciona un entorno de ejecución para la creación y ejecución de aplicaciones. Con .NET, los desarrolladores pueden crear aplicaciones en varios lenguajes de programación, como C#, F#, Visual Basic y otros. Proporciona un amplio conjunto de bibliotecas y herramientas para el desarrollo de aplicaciones, lo que facilita la creación de aplicaciones de alta calidad y escalables.\r\n\r\nC# (pronunciado \"C-sharp\") es un lenguaje de programación desarrollado por Microsoft que es parte de la plataforma .NET. C# es un lenguaje de programación moderno, orientado a objetos y seguro que se utiliza ampliamente para el desarrollo de aplicaciones en la plataforma .NET. C# es un lenguaje fuertemente tipado y administrado, lo que significa que proporciona un alto nivel de seguridad y rendimiento en la ejecución de aplicaciones.\r\n\r\nC# se utiliza en una amplia variedad de escenarios de desarrollo, incluyendo aplicaciones de escritorio con Windows Forms o WPF, aplicaciones web con ASP.NET, aplicaciones móviles con Xamarin, y aplicaciones en la nube con Azure. Además, C# se integra bien con otros lenguajes de programación en la plataforma .NET, lo que permite a los desarrolladores aprovechar las ventajas de varios lenguajes en un mismo proyecto.', '<p style=\"text-align: justify; \">NET y C# son dos tecnologías de programación desarrolladas por Microsoft que se utilizan para crear aplicaciones modernas en diversos entornos, como aplicaciones de escritorio, aplicaciones web y aplicaciones móviles.</p><p style=\"text-align: justify; \">.NET es un marco de trabajo de software desarrollado por Microsoft que proporciona un entorno de ejecución para la creación y ejecución de aplicaciones. Con .NET, los desarrolladores pueden crear aplicaciones en varios lenguajes de programación, como C#, F#, Visual Basic y otros. Proporciona un amplio conjunto de bibliotecas y herramientas para el desarrollo de aplicaciones, lo que facilita la creación de aplicaciones de alta calidad y escalables.</p><p style=\"text-align: justify; \">C# (pronunciado \"C-sharp\") es un lenguaje de programación desarrollado por Microsoft que es parte de la plataforma .NET. C# es un lenguaje de programación moderno, orientado a objetos y seguro que se utiliza ampliamente para el desarrollo de aplicaciones en la plataforma .NET. C# es un lenguaje fuertemente tipado y administrado, lo que significa que proporciona un alto nivel de seguridad y rendimiento en la ejecución de aplicaciones.</p><p style=\"text-align: justify; \">C# se utiliza en una amplia variedad de escenarios de desarrollo, incluyendo aplicaciones de escritorio con Windows Forms o WPF, aplicaciones web con ASP.NET, aplicaciones móviles con Xamarin, y aplicaciones en la nube con Azure. Además, C# se integra bien con otros lenguajes de programación en la plataforma .NET, lo que permite a los desarrolladores aprovechar las ventajas de varios lenguajes en un mismo proyecto.</p>');
INSERT INTO `text_lesson_translations` VALUES (38, 46, 'es', 'Fundamentos de programación en C#', '1. Sintaxis básica: C# utiliza una sintaxis similar a C y C++, con un enfoque en la legibilidad y claridad del código. Esto incluye la declaración de variables, operadores, estructuras de control de flujo (como if/else, bucles for/while, switch), y la definición de funciones y clases.\r\n\r\n2. Tipos de datos: C# ofrece una amplia gama de tipos de datos, incluyendo tipos primitivos como enteros, flotantes, booleanos, caracteres, así como tipos más complejos como arreglos, listas, diccionarios y clases personalizadas. Los tipos de datos son fundamentales para almacenar y manipular información en una aplicación.\r\n\r\n3. Programación orientada a objetos: C# es un lenguaje de programación orientado a objetos, lo que significa que se basa en el concepto de clases y objetos. Las clases son plantillas para crear objetos, que son instancias de esas clases. C# admite conceptos como herencia, polimorfismo, encapsulamiento y abstracción, lo que permite crear aplicaciones modularizadas y extensibles.\r\n\r\n4. Manejo de excepciones: C# ofrece un sistema de manejo de excepciones para detectar y manejar errores en tiempo de ejecución. Esto permite que las aplicaciones sean más robustas y puedan manejar situaciones inesperadas de manera elegante y controlada.\r\n\r\n5. Programación asincrónica: C# admite programación asincrónica, lo que permite escribir código eficiente y receptivo que puede manejar múltiples tareas en paralelo. Esto es especialmente útil en aplicaciones que requieren operaciones de entrada/salida intensivas, como aplicaciones web y móviles.\r\n\r\n6. Bibliotecas y namespaces: C# incluye una amplia gama de bibliotecas y namespaces (espacios de nombres) que proporcionan funcionalidades adicionales para tareas comunes, como manipulación de archivos, acceso a bases de datos, interacción con el sistema operativo, manejo de UI, entre otros. Los namespaces son agrupaciones lógicas de clases y permiten organizar el código de manera estructurada.\r\n\r\n7. Depuración y pruebas: C# ofrece herramientas de depuración integradas en su entorno de desarrollo, lo que permite identificar y corregir errores en el código durante la etapa de desarrollo. Además, se pueden realizar pruebas unitarias y pruebas de integración para garantizar la calidad del código.\r\n\r\n8. Gestión de memoria: C# utiliza un sistema de recolección de basura (garbage collection) para administrar automáticamente la memoria utilizada por una aplicación, lo que facilita el desarrollo de aplicaciones sin tener que preocuparse por la gestión manual de la memoria.', '<p style=\"text-align: justify; \">1. Sintaxis básica: C# utiliza una sintaxis similar a C y C++, con un enfoque en la legibilidad y claridad del código. Esto incluye la declaración de variables, operadores, estructuras de control de flujo (como if/else, bucles for/while, switch), y la definición de funciones y clases.</p><p style=\"text-align: justify; \">2. Tipos de datos: C# ofrece una amplia gama de tipos de datos, incluyendo tipos primitivos como enteros, flotantes, booleanos, caracteres, así como tipos más complejos como arreglos, listas, diccionarios y clases personalizadas. Los tipos de datos son fundamentales para almacenar y manipular información en una aplicación.</p><p style=\"text-align: justify; \">3. Programación orientada a objetos: C# es un lenguaje de programación orientado a objetos, lo que significa que se basa en el concepto de clases y objetos. Las clases son plantillas para crear objetos, que son instancias de esas clases. C# admite conceptos como herencia, polimorfismo, encapsulamiento y abstracción, lo que permite crear aplicaciones modularizadas y extensibles.</p><p style=\"text-align: justify; \">4. Manejo de excepciones: C# ofrece un sistema de manejo de excepciones para detectar y manejar errores en tiempo de ejecución. Esto permite que las aplicaciones sean más robustas y puedan manejar situaciones inesperadas de manera elegante y controlada.</p><p style=\"text-align: justify; \">5. Programación asincrónica: C# admite programación asincrónica, lo que permite escribir código eficiente y receptivo que puede manejar múltiples tareas en paralelo. Esto es especialmente útil en aplicaciones que requieren operaciones de entrada/salida intensivas, como aplicaciones web y móviles.</p><p style=\"text-align: justify; \">6. Bibliotecas y namespaces: C# incluye una amplia gama de bibliotecas y namespaces (espacios de nombres) que proporcionan funcionalidades adicionales para tareas comunes, como manipulación de archivos, acceso a bases de datos, interacción con el sistema operativo, manejo de UI, entre otros. Los namespaces son agrupaciones lógicas de clases y permiten organizar el código de manera estructurada.</p><p style=\"text-align: justify; \">7. Depuración y pruebas: C# ofrece herramientas de depuración integradas en su entorno de desarrollo, lo que permite identificar y corregir errores en el código durante la etapa de desarrollo. Además, se pueden realizar pruebas unitarias y pruebas de integración para garantizar la calidad del código.</p><p style=\"text-align: justify; \">8. Gestión de memoria: C# utiliza un sistema de recolección de basura (garbage collection) para administrar automáticamente la memoria utilizada por una aplicación, lo que facilita el desarrollo de aplicaciones sin tener que preocuparse por la gestión manual de la memoria.</p>');
INSERT INTO `text_lesson_translations` VALUES (39, 47, 'es', 'Model y Entity Framework', 'Model y Entity Framework son dos conceptos relacionados en el desarrollo de aplicaciones en C# y el entorno de desarrollo .NET. \r\n\r\n1. Modelo (Model): El modelo se refiere a la representación de datos en una aplicación. En el contexto del patrón de diseño Modelo-Vista-Controlador (MVC), el modelo es la capa que se encarga de manejar la lógica de negocio y la interacción con los datos. Esto implica la definición de clases y estructuras de datos que representan los objetos del dominio de la aplicación y la manipulación de los mismos, incluyendo la validación de datos, cálculos y operaciones relacionadas con la lógica de negocio.\r\n\r\n2. Entity Framework: Entity Framework (EF) es una tecnología de mapeo objeto-relacional (ORM) proporcionada por Microsoft para el desarrollo de aplicaciones en .NET. EF permite trabajar con bases de datos relacionales a través de objetos y clases en C#, lo que facilita la persistencia y manipulación de datos en una aplicación. EF se integra con el modelo de la aplicación, permitiendo que las clases y objetos del modelo se mapeen automáticamente a tablas y entidades en una base de datos relacional.\r\n\r\nEl modelo es la representación de datos y la lógica de negocio en una aplicación, mientras que Entity Framework es una tecnología de mapeo objeto-relacional que permite trabajar con bases de datos relacionales a través de objetos y clases en C#, integrándose con el modelo de la aplicación. Entity Framework simplifica la interacción con bases de datos en una aplicación C# y permite una mayor abstracción y flexibilidad en la manipulación de datos en el contexto del modelo de la aplicación.', '<p style=\"text-align: justify; \">Model y Entity Framework son dos conceptos relacionados en el desarrollo de aplicaciones en C# y el entorno de desarrollo .NET.&nbsp;</p><p style=\"text-align: justify; \">1. Modelo (Model): El modelo se refiere a la representación de datos en una aplicación. En el contexto del patrón de diseño Modelo-Vista-Controlador (MVC), el modelo es la capa que se encarga de manejar la lógica de negocio y la interacción con los datos. Esto implica la definición de clases y estructuras de datos que representan los objetos del dominio de la aplicación y la manipulación de los mismos, incluyendo la validación de datos, cálculos y operaciones relacionadas con la lógica de negocio.</p><p style=\"text-align: justify; \">2. Entity Framework: Entity Framework (EF) es una tecnología de mapeo objeto-relacional (ORM) proporcionada por Microsoft para el desarrollo de aplicaciones en .NET. EF permite trabajar con bases de datos relacionales a través de objetos y clases en C#, lo que facilita la persistencia y manipulación de datos en una aplicación. EF se integra con el modelo de la aplicación, permitiendo que las clases y objetos del modelo se mapeen automáticamente a tablas y entidades en una base de datos relacional.</p><p style=\"text-align: justify; \">El modelo es la representación de datos y la lógica de negocio en una aplicación, mientras que Entity Framework es una tecnología de mapeo objeto-relacional que permite trabajar con bases de datos relacionales a través de objetos y clases en C#, integrándose con el modelo de la aplicación. Entity Framework simplifica la interacción con bases de datos en una aplicación C# y permite una mayor abstracción y flexibilidad en la manipulación de datos en el contexto del modelo de la aplicación.</p>');
INSERT INTO `text_lesson_translations` VALUES (40, 48, 'es', 'Dependency Injection', 'La Inyección de Dependencias (Dependency Injection o DI, por sus siglas en inglés) es un patrón de diseño y una técnica de programación que se utiliza en el desarrollo de software para gestionar las dependencias entre los componentes de una aplicación de manera desacoplada y flexible. En el contexto de C# y .NET, la DI es ampliamente utilizada y es una parte integral del enfoque de desarrollo basado en inversion de control (Inversion of Control o IoC).\r\n\r\nHay varios beneficios en el uso de la DI en aplicaciones C#/.NET, como:\r\n\r\n1. Desacoplamiento: La DI reduce el acoplamiento entre los componentes de una aplicación, lo que facilita la reutilización y el mantenimiento del código. Los componentes pueden evolucionar de manera independiente sin afectar a otros componentes que dependen de ellos.\r\n\r\n2. Testabilidad: La DI permite la fácil sustitución de las dependencias por implementaciones simuladas o mock en pruebas unitarias, lo que facilita la realización de pruebas automatizadas y mejora la calidad del código.\r\n\r\n3. Flexibilidad: La DI permite cambiar las implementaciones de las dependencias en tiempo de ejecución, lo que proporciona una mayor flexibilidad en la configuración y comportamiento de la aplicación sin tener que recompilar o modificar el código fuente.\r\n\r\n4. Modularidad: La DI promueve la separación de preocupaciones (Separation of Concerns), lo que permite una mayor modularidad y mantenibilidad del código.', '<p>La Inyección de Dependencias (Dependency Injection o DI, por sus siglas en inglés) es un patrón de diseño y una técnica de programación que se utiliza en el desarrollo de software para gestionar las dependencias entre los componentes de una aplicación de manera desacoplada y flexible. En el contexto de C# y .NET, la DI es ampliamente utilizada y es una parte integral del enfoque de desarrollo basado en inversion de control (Inversion of Control o IoC).</p><p>Hay varios beneficios en el uso de la DI en aplicaciones C#/.NET, como:</p><p>1. Desacoplamiento: La DI reduce el acoplamiento entre los componentes de una aplicación, lo que facilita la reutilización y el mantenimiento del código. Los componentes pueden evolucionar de manera independiente sin afectar a otros componentes que dependen de ellos.</p><p>2. Testabilidad: La DI permite la fácil sustitución de las dependencias por implementaciones simuladas o mock en pruebas unitarias, lo que facilita la realización de pruebas automatizadas y mejora la calidad del código.</p><p>3. Flexibilidad: La DI permite cambiar las implementaciones de las dependencias en tiempo de ejecución, lo que proporciona una mayor flexibilidad en la configuración y comportamiento de la aplicación sin tener que recompilar o modificar el código fuente.</p><p>4. Modularidad: La DI promueve la separación de preocupaciones (Separation of Concerns), lo que permite una mayor modularidad y mantenibilidad del código.</p>');
INSERT INTO `text_lesson_translations` VALUES (41, 49, 'es', 'Login', 'El proceso de login, o inicio de sesión, es una funcionalidad común en muchas aplicaciones, incluyendo aquellas desarrolladas en C# y .NET. El login es el proceso mediante el cual un usuario se autentica en una aplicación proporcionando sus credenciales, como un nombre de usuario y contraseña, para acceder a una cuenta o sistema protegido.\r\n\r\nA continuación se describe un enfoque básico para implementar un proceso de login en una aplicación C#/.NET:\r\n\r\n1. Captura de credenciales: La aplicación debe proporcionar una interfaz de usuario para que el usuario ingrese sus credenciales, como un formulario con campos para el nombre de usuario y contraseña. Los datos ingresados por el usuario se capturan y se envían al servidor para su procesamiento.\r\n\r\n2. Validación de credenciales: En el servidor, se valida que las credenciales proporcionadas sean correctas. Esto puede implicar la verificación de que el nombre de usuario y la contraseña coincidan con los registros almacenados en una base de datos o en otro sistema de almacenamiento seguro. Se debe realizar una verificación segura, como el uso de técnicas de almacenamiento seguro de contraseñas, como la función de hash y salting, para proteger la información del usuario.\r\n\r\n3. Autenticación exitosa: Si las credenciales son válidas, se considera que el usuario ha sido autenticado correctamente. Se puede permitir el acceso a las funcionalidades protegidas de la aplicación, como mostrar información específica del usuario, permitir operaciones de actualización o acceso a recursos restringidos.\r\n\r\nGestión de sesiones: Una vez que el usuario ha sido autenticado, se puede establecer una sesión para mantener su estado de autenticación durante su interacción con la aplicación. Esto puede implicar el uso de técnicas como cookies, tokens o identificadores de sesión para mantener la sesión del usuario activa mientras interactúa con la aplicación.\r\n\r\n4. Manejo de errores: Es importante manejar los posibles errores en el proceso de login, como credenciales inválidas, cuentas bloqueadas, errores de conexión a la base de datos, entre otros. Se deben mostrar mensajes de error adecuados al usuario para informar sobre los problemas y brindar una experiencia de usuario adecuada.\r\n\r\nEs importante tener en cuenta que la seguridad es un aspecto crítico en el proceso de login. Es necesario implementar medidas de seguridad adecuadas para proteger la información del usuario, como el almacenamiento seguro de contraseñas, la protección contra ataques de fuerza bruta o ataques de inyección de SQL, y la gestión segura de sesiones. Se recomienda seguir las mejores prácticas de seguridad y utilizar frameworks de seguridad confiables en el desarrollo de aplicaciones de login en C#/.NET.', '<p style=\"text-align: justify; \">El proceso de login, o inicio de sesión, es una funcionalidad común en muchas aplicaciones, incluyendo aquellas desarrolladas en C# y .NET. El login es el proceso mediante el cual un usuario se autentica en una aplicación proporcionando sus credenciales, como un nombre de usuario y contraseña, para acceder a una cuenta o sistema protegido.</p><p style=\"text-align: justify; \">A continuación se describe un enfoque básico para implementar un proceso de login en una aplicación C#/.NET:</p><p style=\"text-align: justify; \">1. Captura de credenciales: La aplicación debe proporcionar una interfaz de usuario para que el usuario ingrese sus credenciales, como un formulario con campos para el nombre de usuario y contraseña. Los datos ingresados por el usuario se capturan y se envían al servidor para su procesamiento.</p><p style=\"text-align: justify; \">2. Validación de credenciales: En el servidor, se valida que las credenciales proporcionadas sean correctas. Esto puede implicar la verificación de que el nombre de usuario y la contraseña coincidan con los registros almacenados en una base de datos o en otro sistema de almacenamiento seguro. Se debe realizar una verificación segura, como el uso de técnicas de almacenamiento seguro de contraseñas, como la función de hash y salting, para proteger la información del usuario.</p><p style=\"text-align: justify; \">3. Autenticación exitosa: Si las credenciales son válidas, se considera que el usuario ha sido autenticado correctamente. Se puede permitir el acceso a las funcionalidades protegidas de la aplicación, como mostrar información específica del usuario, permitir operaciones de actualización o acceso a recursos restringidos.</p><p style=\"text-align: justify; \">Gestión de sesiones: Una vez que el usuario ha sido autenticado, se puede establecer una sesión para mantener su estado de autenticación durante su interacción con la aplicación. Esto puede implicar el uso de técnicas como cookies, tokens o identificadores de sesión para mantener la sesión del usuario activa mientras interactúa con la aplicación.</p><p style=\"text-align: justify; \">4. Manejo de errores: Es importante manejar los posibles errores en el proceso de login, como credenciales inválidas, cuentas bloqueadas, errores de conexión a la base de datos, entre otros. Se deben mostrar mensajes de error adecuados al usuario para informar sobre los problemas y brindar una experiencia de usuario adecuada.</p><p style=\"text-align: justify; \">Es importante tener en cuenta que la seguridad es un aspecto crítico en el proceso de login. Es necesario implementar medidas de seguridad adecuadas para proteger la información del usuario, como el almacenamiento seguro de contraseñas, la protección contra ataques de fuerza bruta o ataques de inyección de SQL, y la gestión segura de sesiones. Se recomienda seguir las mejores prácticas de seguridad y utilizar frameworks de seguridad confiables en el desarrollo de aplicaciones de login en C#/.NET.</p>');
INSERT INTO `text_lesson_translations` VALUES (42, 50, 'es', 'Programación asincrónica', 'La programación asincrónica es un enfoque de programación que permite realizar tareas de manera concurrente y asíncrona, en lugar de bloquear la ejecución del programa mientras espera a que una tarea se complete. En C# y .NET, la programación asincrónica se puede realizar utilizando las características proporcionadas por el lenguaje y el marco de trabajo.\r\n\r\nLa programación asincrónica es especialmente útil cuando se trabaja con tareas que pueden tardar en completarse, como operaciones de entrada/salida (I/O), llamadas a servicios web, operaciones de base de datos, entre otras, ya que permite que el programa continúe ejecutando otras tareas mientras se espera a que la tarea asincrónica se complete, evitando bloquear la interfaz de usuario o el hilo principal de ejecución.', '<p>La programación asincrónica es un enfoque de programación que permite realizar tareas de manera concurrente y asíncrona, en lugar de bloquear la ejecución del programa mientras espera a que una tarea se complete. En C# y .NET, la programación asincrónica se puede realizar utilizando las características proporcionadas por el lenguaje y el marco de trabajo.</p><p>La programación asincrónica es especialmente útil cuando se trabaja con tareas que pueden tardar en completarse, como operaciones de entrada/salida (I/O), llamadas a servicios web, operaciones de base de datos, entre otras, ya que permite que el programa continúe ejecutando otras tareas mientras se espera a que la tarea asincrónica se complete, evitando bloquear la interfaz de usuario o el hilo principal de ejecución.</p><p>A continuación se describen algunos conceptos fundamentales de la programación asincrónica en C# y .NET:</p><p>Palabras clave \"async\" y \"await\": C# permite marcar un método como asincrónico utilizando la palabra clave \"async\". Dentro de un método asincrónico, se pueden usar operaciones asincrónicas, como llamadas a métodos que retornen \"Task\" o \"Task&lt;T&gt;\", y se puede esperar su finalización utilizando la palabra clave \"await\". El uso de \"await\" permite que el hilo de ejecución se libere y continúe con otras tareas mientras se espera a que la operación asincrónica se complete.</p><p>Tipos de retorno asincrónicos: Los métodos asincrónicos pueden retornar tipos de datos especiales, como \"Task\", que representa una tarea asincrónica que no tiene un resultado, y \"Task&lt;T&gt;\", que representa una tarea asincrónica que produce un resultado de tipo T. Estos tipos de datos permiten manejar el resultado de la operación asincrónica de forma asíncrona.</p><p>Manejo de excepciones asincrónicas: Las excepciones que se producen en operaciones asincrónicas se manejan de manera diferente a las excepciones en operaciones sincrónicas. Se puede utilizar la palabra clave \"try-catch\" en bloques \"async\" para manejar excepciones asincrónicas de forma adecuada.</p><p>Patrones de diseño asincrónicos: C# y .NET proporcionan patrones de diseño asincrónicos, como \"Task-based Asynchronous Pattern\" (TAP) y \"Event-based Asynchronous Pattern\" (EAP), que ofrecen guías y recomendaciones para diseñar y utilizar operaciones asincrónicas de manera eficiente y segura.</p><p>Biblioteca de Tareas (Task Parallel Library - TPL): La TPL es una biblioteca de .NET que proporciona un conjunto de clases y métodos para trabajar con programación asincrónica y paralela en .NET. La TPL ofrece una forma más fácil de escribir código asincrónico y paralelo, abstrayendo los detalles de la gestión de hilos y permitiendo que el sistema determine cómo asignar las tareas a los hilos de manera eficiente.</p><p>La programación asincrónica en C# y .NET es una poderosa herramienta para mejorar el rendimiento y la capacidad de respuesta de las aplicaciones, especialmente en escenarios de operaciones I/O intensivas. Sin embargo, también puede ser compleja y requiere un cuidadoso diseño y manejo de excepciones. Es importante comprender los conceptos y patrones de diseño asincrónicos, así como seguir las mejores prácticas.</p>');
INSERT INTO `text_lesson_translations` VALUES (43, 51, 'es', 'Seguridad de aplicaciones', 'La seguridad de las aplicaciones es un aspecto fundamental en el desarrollo de software para proteger la información y los recursos de una aplicación frente a posibles amenazas y vulnerabilidades. En el contexto de C# y .NET, existen varias consideraciones importantes para asegurar la seguridad de las aplicaciones desarrolladas en estos entornos. Algunos de los principales aspectos son:\r\n\r\n1. Autenticación y autorización: Es fundamental implementar un sólido sistema de autenticación y autorización para controlar el acceso a las funcionalidades y los datos de una aplicación. C# y .NET ofrecen mecanismos como la Autenticación de Windows, la Autenticación basada en formularios y la Autorización basada en roles, que permiten implementar políticas de seguridad para validar la identidad y los privilegios de los usuarios.\r\n\r\n2. Manejo seguro de contraseñas y datos sensibles: Es importante utilizar buenas prácticas para el manejo seguro de contraseñas y otros datos sensibles, como encriptar contraseñas almacenadas en bases de datos, utilizar herramientas de administración de secretos, evitar el almacenamiento de información confidencial en logs y asegurarse de no enviar datos sensibles en la URL o en mensajes de error.\r\n\r\n3. Protección contra ataques comunes: Las aplicaciones C# y .NET pueden ser vulnerables a ataques comunes, como ataques de inyección de SQL, cross-site scripting (XSS), cross-site request forgery (CSRF), entre otros. Es importante implementar medidas de seguridad, como la validación y saneamiento adecuado de inputs del usuario, el uso de mecanismos de prevención de ataques, como anti-XSS y anti-CSRF, y mantener actualizadas las librerías y frameworks utilizados en la aplicación.\r\n\r\n4. Gestión de sesiones y estados: Las sesiones y estados de una aplicación pueden ser vulnerables a ataques, como la suplantación de sesiones, si no se gestionan adecuadamente. Es importante implementar medidas de seguridad, como la generación de identificadores de sesión seguros, el almacenamiento seguro de información de sesión, y la validación y verificación de la integridad de los datos en la sesión.\r\n\r\n5. Protección de la comunicación: La comunicación entre componentes de una aplicación o entre aplicaciones puede ser un punto de vulnerabilidad si no se protege adecuadamente. Es importante utilizar mecanismos de seguridad, como SSL/TLS para la comunicación segura en redes, y firmar y encriptar datos sensibles transmitidos a través de servicios web, APIs u otros canales de comunicación.\r\n\r\n6. Actualización y parches: Es fundamental mantener actualizados los componentes, frameworks y librerías utilizados en la aplicación, así como aplicar parches de seguridad y actualizaciones de software para protegerse contra vulnerabilidades conocidas.\r\n\r\n7. Pruebas de seguridad: Realizar pruebas de seguridad, como pruebas de penetración (pen testing) y análisis de seguridad, para identificar posibles vulnerabilidades y corregirlas antes de la implementación en producción.', '<p style=\"text-align: justify; \">La seguridad de las aplicaciones es un aspecto fundamental en el desarrollo de software para proteger la información y los recursos de una aplicación frente a posibles amenazas y vulnerabilidades. En el contexto de C# y .NET, existen varias consideraciones importantes para asegurar la seguridad de las aplicaciones desarrolladas en estos entornos. Algunos de los principales aspectos son:</p><p style=\"text-align: justify; \">1. Autenticación y autorización: Es fundamental implementar un sólido sistema de autenticación y autorización para controlar el acceso a las funcionalidades y los datos de una aplicación. C# y .NET ofrecen mecanismos como la Autenticación de Windows, la Autenticación basada en formularios y la Autorización basada en roles, que permiten implementar políticas de seguridad para validar la identidad y los privilegios de los usuarios.</p><p style=\"text-align: justify; \">2. Manejo seguro de contraseñas y datos sensibles: Es importante utilizar buenas prácticas para el manejo seguro de contraseñas y otros datos sensibles, como encriptar contraseñas almacenadas en bases de datos, utilizar herramientas de administración de secretos, evitar el almacenamiento de información confidencial en logs y asegurarse de no enviar datos sensibles en la URL o en mensajes de error.</p><p style=\"text-align: justify; \">3. Protección contra ataques comunes: Las aplicaciones C# y .NET pueden ser vulnerables a ataques comunes, como ataques de inyección de SQL, cross-site scripting (XSS), cross-site request forgery (CSRF), entre otros. Es importante implementar medidas de seguridad, como la validación y saneamiento adecuado de inputs del usuario, el uso de mecanismos de prevención de ataques, como anti-XSS y anti-CSRF, y mantener actualizadas las librerías y frameworks utilizados en la aplicación.</p><p style=\"text-align: justify; \">4. Gestión de sesiones y estados: Las sesiones y estados de una aplicación pueden ser vulnerables a ataques, como la suplantación de sesiones, si no se gestionan adecuadamente. Es importante implementar medidas de seguridad, como la generación de identificadores de sesión seguros, el almacenamiento seguro de información de sesión, y la validación y verificación de la integridad de los datos en la sesión.</p><p style=\"text-align: justify; \">5. Protección de la comunicación: La comunicación entre componentes de una aplicación o entre aplicaciones puede ser un punto de vulnerabilidad si no se protege adecuadamente. Es importante utilizar mecanismos de seguridad, como SSL/TLS para la comunicación segura en redes, y firmar y encriptar datos sensibles transmitidos a través de servicios web, APIs u otros canales de comunicación.</p><p style=\"text-align: justify; \">6. Actualización y parches: Es fundamental mantener actualizados los componentes, frameworks y librerías utilizados en la aplicación, así como aplicar parches de seguridad y actualizaciones de software para protegerse contra vulnerabilidades conocidas.</p><p style=\"text-align: justify; \">7. Pruebas de seguridad: Realizar pruebas de seguridad, como pruebas de penetración (pen testing) y análisis de seguridad, para identificar posibles vulnerabilidades y corregirlas antes de la implementación en producción.</p>');
INSERT INTO `text_lesson_translations` VALUES (44, 52, 'es', 'Unit tests', 'Las pruebas unitarias (unit tests) son una práctica fundamental en el desarrollo de software que consiste en escribir pruebas automatizadas para verificar el correcto funcionamiento de unidades individuales de código, como clases, métodos o funciones, de forma aislada. Las pruebas unitarias son parte de las metodologías de desarrollo ágil y se utilizan para mejorar la calidad del código, detectar y corregir errores tempranamente, y garantizar el correcto funcionamiento de las unidades de código en diferentes escenarios.\r\n\r\nAlgunos de los beneficios de utilizar pruebas unitarias en el desarrollo de aplicaciones en C# y .NET son:\r\n\r\n1. Detección temprana de errores: Las pruebas unitarias permiten identificar errores y problemas en el código de forma temprana, antes de que sean integrados en la aplicación, lo que facilita su corrección y evita que se propaguen a otras partes del sistema.\r\n\r\n2. Mejora la calidad del código: Las pruebas unitarias promueven la escritura de código modular, bien estructurado y fácil de mantener, lo que mejora la calidad del código en general.\r\n\r\n3. Facilita la refactorización: Las pruebas unitarias proporcionan una capa de seguridad al realizar cambios en el código, ya que permiten verificar que las funcionalidades existentes sigan funcionando correctamente después de la refactorización.\r\n\r\n4. Permite la automatización de pruebas: Las pruebas unitarias son automatizadas, lo que permite su ejecución rápida y repetible, lo que facilita la detección de errores en un flujo de trabajo de desarrollo continuo (CI/CD).\r\n\r\n5. Documentación del comportamiento del código: Las pruebas unitarias sirven como documentación viva del comportamiento esperado de las unidades de código, lo que facilita la comprensión y colaboración entre los miembros del equipo de desarrollo.', '<p style=\"text-align: justify; \">Las pruebas unitarias (unit tests) son una práctica fundamental en el desarrollo de software que consiste en escribir pruebas automatizadas para verificar el correcto funcionamiento de unidades individuales de código, como clases, métodos o funciones, de forma aislada. Las pruebas unitarias son parte de las metodologías de desarrollo ágil y se utilizan para mejorar la calidad del código, detectar y corregir errores tempranamente, y garantizar el correcto funcionamiento de las unidades de código en diferentes escenarios.</p><p style=\"text-align: justify; \">Algunos de los beneficios de utilizar pruebas unitarias en el desarrollo de aplicaciones en C# y .NET son:</p><p style=\"text-align: justify; \">1. Detección temprana de errores: Las pruebas unitarias permiten identificar errores y problemas en el código de forma temprana, antes de que sean integrados en la aplicación, lo que facilita su corrección y evita que se propaguen a otras partes del sistema.</p><p style=\"text-align: justify; \">2. Mejora la calidad del código: Las pruebas unitarias promueven la escritura de código modular, bien estructurado y fácil de mantener, lo que mejora la calidad del código en general.</p><p style=\"text-align: justify; \">3. Facilita la refactorización: Las pruebas unitarias proporcionan una capa de seguridad al realizar cambios en el código, ya que permiten verificar que las funcionalidades existentes sigan funcionando correctamente después de la refactorización.</p><p style=\"text-align: justify; \">4. Permite la automatización de pruebas: Las pruebas unitarias son automatizadas, lo que permite su ejecución rápida y repetible, lo que facilita la detección de errores en un flujo de trabajo de desarrollo continuo (CI/CD).</p><p style=\"text-align: justify; \">5. Documentación del comportamiento del código: Las pruebas unitarias sirven como documentación viva del comportamiento esperado de las unidades de código, lo que facilita la comprensión y colaboración entre los miembros del equipo de desarrollo.</p>');
INSERT INTO `text_lesson_translations` VALUES (45, 53, 'es', 'principios Solid y Arquitectura Limpia', 'Los principios de código y la arquitectura limpia (Clean Architecture) son conceptos importantes en el desarrollo de software que promueven la creación de código limpio, modular y mantenible. Estos conceptos se basan en una serie de principios y buenas prácticas que buscan mejorar la calidad del código y la capacidad de mantenimiento del software.\r\n\r\n1. SOLID: SOLID es un acrónimo que representa cinco principios de diseño de código orientado a objetos propuestos por Robert C. Martin. Estos principios son:\r\nPrincipio de Responsabilidad Única (SRP): Cada clase o módulo debe tener una única responsabilidad, es decir, una única razón para cambiar.\r\nPrincipio de Abierto/Cerrado (OCP): Las clases o módulos deben estar abiertos para su extensión pero cerrados para su modificación, lo que significa que se deben poder extender o agregar nuevas funcionalidades sin tener que modificar el código existente.\r\nPrincipio de Sustitución de Liskov (LSP): Los objetos de una clase deben ser sustituibles por objetos de una subclase sin afectar la integridad del programa.\r\nPrincipio de Segregación de Interfaces (ISP): Las interfaces deben ser específicas para cada cliente, evitando interfaces demasiado generales o con exceso de funcionalidades.\r\nPrincipio de Inversión de Dependencia (DIP): Las clases deben depender de abstracciones en lugar de depender de implementaciones concretas, lo que permite una mayor flexibilidad y modularidad del código.\r\n\r\n2. Arquitectura limpia (Clean Architecture): La arquitectura limpia es un enfoque de diseño de arquitecturas de software propuesto por Robert C. Martin que busca separar y organizar las diferentes capas de una aplicación de forma clara y modular, con el objetivo de lograr un código limpio, mantenible y testeable. La arquitectura limpia consta de varias capas, como la capa de Interfaz de Usuario, la capa de Aplicación, la capa de Dominio y la capa de Infraestructura, y establece reglas y principios para la interacción entre estas capas.\r\n\r\nAlgunos de los beneficios de seguir los principios de código y la arquitectura limpia en el desarrollo de software en C# y .NET son:\r\n\r\nCódigo limpio: Los principios de código y la arquitectura limpia promueven la escritura de código limpio, modular y bien estructurado, lo que mejora la calidad del código en general y facilita su mantenimiento a lo largo del tiempo.\r\n\r\nMayor capacidad de mantenimiento: Al separar y organizar las diferentes capas de una aplicación de forma clara y modular, la arquitectura limpia permite un mayor nivel de mantenibilidad, lo que facilita la corrección de errores, la incorporación de nuevas funcionalidades y la evolución del software en general.\r\n\r\nMayor testabilidad: El diseño basado en principios de código y la arquitectura limpia favorecen la testabilidad del software, lo que facilita la escritura de pruebas unitarias y de integración, y permite una mayor cobertura de pruebas, lo que a su vez ayuda a garantizar la calidad del software.\r\n\r\nFlexibilidad y extensibilidad: Al seguir los principios de código y la arquitectura limpia, el software tiende a ser más flexible y extensible.', '<p style=\"text-align: justify; \">Los principios de código y la arquitectura limpia (Clean Architecture) son conceptos importantes en el desarrollo de software que promueven la creación de código limpio, modular y mantenible. Estos conceptos se basan en una serie de principios y buenas prácticas que buscan mejorar la calidad del código y la capacidad de mantenimiento del software.</p><p style=\"text-align: justify; \">1. SOLID: SOLID es un acrónimo que representa cinco principios de diseño de código orientado a objetos propuestos por Robert C. Martin. Estos principios son:</p><p style=\"text-align: justify; \">Principio de Responsabilidad Única (SRP): Cada clase o módulo debe tener una única responsabilidad, es decir, una única razón para cambiar.</p><p style=\"text-align: justify; \">Principio de Abierto/Cerrado (OCP): Las clases o módulos deben estar abiertos para su extensión pero cerrados para su modificación, lo que significa que se deben poder extender o agregar nuevas funcionalidades sin tener que modificar el código existente.</p><p style=\"text-align: justify; \">Principio de Sustitución de Liskov (LSP): Los objetos de una clase deben ser sustituibles por objetos de una subclase sin afectar la integridad del programa.</p><p style=\"text-align: justify; \">Principio de Segregación de Interfaces (ISP): Las interfaces deben ser específicas para cada cliente, evitando interfaces demasiado generales o con exceso de funcionalidades.</p><p style=\"text-align: justify; \">Principio de Inversión de Dependencia (DIP): Las clases deben depender de abstracciones en lugar de depender de implementaciones concretas, lo que permite una mayor flexibilidad y modularidad del código.</p><p style=\"text-align: justify; \">2. Arquitectura limpia (Clean Architecture): La arquitectura limpia es un enfoque de diseño de arquitecturas de software propuesto por Robert C. Martin que busca separar y organizar las diferentes capas de una aplicación de forma clara y modular, con el objetivo de lograr un código limpio, mantenible y testeable. La arquitectura limpia consta de varias capas, como la capa de Interfaz de Usuario, la capa de Aplicación, la capa de Dominio y la capa de Infraestructura, y establece reglas y principios para la interacción entre estas capas.</p><p style=\"text-align: justify; \">Algunos de los beneficios de seguir los principios de código y la arquitectura limpia en el desarrollo de software en C# y .NET son:</p><p style=\"text-align: justify; \">Código limpio: Los principios de código y la arquitectura limpia promueven la escritura de código limpio, modular y bien estructurado, lo que mejora la calidad del código en general y facilita su mantenimiento a lo largo del tiempo.</p><p style=\"text-align: justify; \">Mayor capacidad de mantenimiento: Al separar y organizar las diferentes capas de una aplicación de forma clara y modular, la arquitectura limpia permite un mayor nivel de mantenibilidad, lo que facilita la corrección de errores, la incorporación de nuevas funcionalidades y la evolución del software en general.</p><p style=\"text-align: justify; \">Mayor testabilidad: El diseño basado en principios de código y la arquitectura limpia favorecen la testabilidad del software, lo que facilita la escritura de pruebas unitarias y de integración, y permite una mayor cobertura de pruebas, lo que a su vez ayuda a garantizar la calidad del software.</p><p style=\"text-align: justify; \">Flexibilidad y extensibilidad: Al seguir los principios de código y la arquitectura limpia, el software tiende a ser más flexible y extensible.</p>');
INSERT INTO `text_lesson_translations` VALUES (46, 54, 'es', 'Introducción a React', 'React es una biblioteca de JavaScript que se utiliza para construir interfaces de usuario interactivas y reutilizables. Es una de las bibliotecas más populares para el desarrollo de aplicaciones web modernas, especialmente en el ámbito de las aplicaciones de una sola página (SPA) y las aplicaciones de interfaz de usuario rica (UI) que requieren actualizaciones en tiempo real y un alto rendimiento.\r\n\r\nLas principales características de React son:\r\n\r\n1. Componentes: React utiliza un enfoque basado en componentes para construir interfaces de usuario. Los componentes son bloques de construcción reutilizables que representan partes de la interfaz de usuario y pueden ser anidados para construir interfaces de usuario complejas.\r\n\r\n2. Virtual DOM: React utiliza un Virtual DOM (DOM virtual) para optimizar el rendimiento de las actualizaciones de la interfaz de usuario. En lugar de actualizar directamente el DOM real, React actualiza un DOM virtual en memoria y luego sincroniza los cambios con el DOM real de forma eficiente, minimizando la cantidad de actualizaciones necesarias en el DOM real.\r\n\r\n3. Unidireccionalidad de datos: React sigue el principio de unidireccionalidad de datos, lo que significa que los datos fluyen en una sola dirección, de arriba a abajo, a través de la jerarquía de componentes. Esto facilita el seguimiento de cómo los datos se actualizan y se propagan en la interfaz de usuario.\r\n\r\n4. JSX: JSX es una extensión de sintaxis de JavaScript que permite escribir código HTML en JavaScript. React utiliza JSX para definir la estructura de la interfaz de usuario de forma declarativa y visualmente intuitiva.\r\n\r\n5. Re-renderizado eficiente: React utiliza algoritmos eficientes para determinar cuándo y cómo se debe volver a renderizar un componente, lo que ayuda a mejorar el rendimiento de la aplicación al evitar renderizados innecesarios.\r\n\r\n6. Amplia comunidad y ecosistema: React cuenta con una amplia comunidad de desarrolladores y tiene un rico ecosistema de herramientas y librerías complementarias, lo que facilita el desarrollo de aplicaciones web robustas y escalables.', '<p style=\"text-align: justify; \">React es una biblioteca de JavaScript que se utiliza para construir interfaces de usuario interactivas y reutilizables. Es una de las bibliotecas más populares para el desarrollo de aplicaciones web modernas, especialmente en el ámbito de las aplicaciones de una sola página (SPA) y las aplicaciones de interfaz de usuario rica (UI) que requieren actualizaciones en tiempo real y un alto rendimiento.</p><p style=\"text-align: justify; \">Las principales características de React son:</p><p style=\"text-align: justify; \">1. Componentes: React utiliza un enfoque basado en componentes para construir interfaces de usuario. Los componentes son bloques de construcción reutilizables que representan partes de la interfaz de usuario y pueden ser anidados para construir interfaces de usuario complejas.</p><p style=\"text-align: justify; \">2. Virtual DOM: React utiliza un Virtual DOM (DOM virtual) para optimizar el rendimiento de las actualizaciones de la interfaz de usuario. En lugar de actualizar directamente el DOM real, React actualiza un DOM virtual en memoria y luego sincroniza los cambios con el DOM real de forma eficiente, minimizando la cantidad de actualizaciones necesarias en el DOM real.</p><p style=\"text-align: justify; \">3. Unidireccionalidad de datos: React sigue el principio de unidireccionalidad de datos, lo que significa que los datos fluyen en una sola dirección, de arriba a abajo, a través de la jerarquía de componentes. Esto facilita el seguimiento de cómo los datos se actualizan y se propagan en la interfaz de usuario.</p><p style=\"text-align: justify; \">4. JSX: JSX es una extensión de sintaxis de JavaScript que permite escribir código HTML en JavaScript. React utiliza JSX para definir la estructura de la interfaz de usuario de forma declarativa y visualmente intuitiva.</p><p style=\"text-align: justify; \">5. Re-renderizado eficiente: React utiliza algoritmos eficientes para determinar cuándo y cómo se debe volver a renderizar un componente, lo que ayuda a mejorar el rendimiento de la aplicación al evitar renderizados innecesarios.</p><p style=\"text-align: justify; \">6. Amplia comunidad y ecosistema: React cuenta con una amplia comunidad de desarrolladores y tiene un rico ecosistema de herramientas y librerías complementarias, lo que facilita el desarrollo de aplicaciones web robustas y escalables.</p>');
INSERT INTO `text_lesson_translations` VALUES (47, 55, 'es', 'Hooks de React', 'Los Hooks son una característica introducida en React 16.8 que permite a los desarrolladores utilizar el estado y otras características de React en componentes de función, en lugar de tener que utilizar clases de componentes. Los Hooks son funciones especiales que se pueden usar en componentes de función de React para agregar y gestionar el estado, el ciclo de vida y otras características.\r\n\r\nLos Hooks más comunes en React son:\r\n\r\n1. useState: Este Hook permite agregar estado a un componente de función. Permite declarar una variable de estado y una función para actualizarla en el cuerpo de un componente de función. \r\n\r\n2. useEffect: Este Hook permite realizar efectos secundarios en componentes de función, como suscribirse a eventos, hacer llamadas a APIs, o gestionar la actualización del DOM. Se ejecuta después de que el componente se haya renderizado. \r\n\r\n3. useContext: Este Hook permite acceder a un contexto de React en un componente de función, lo que facilita la compartición de datos y funcionalidades en componentes anidados.', '<p style=\"text-align: justify; \">Los Hooks son una característica introducida en React 16.8 que permite a los desarrolladores utilizar el estado y otras características de React en componentes de función, en lugar de tener que utilizar clases de componentes. Los Hooks son funciones especiales que se pueden usar en componentes de función de React para agregar y gestionar el estado, el ciclo de vida y otras características.</p><p style=\"text-align: justify; \">Los Hooks más comunes en React son:</p><p style=\"text-align: justify; \">1. useState: Este Hook permite agregar estado a un componente de función. Permite declarar una variable de estado y una función para actualizarla en el cuerpo de un componente de función.&nbsp;</p><p style=\"text-align: justify; \">2. useEffect: Este Hook permite realizar efectos secundarios en componentes de función, como suscribirse a eventos, hacer llamadas a APIs, o gestionar la actualización del DOM. Se ejecuta después de que el componente se haya renderizado.&nbsp;</p><p style=\"text-align: justify; \">3. useContext: Este Hook permite acceder a un contexto de React en un componente de función, lo que facilita la compartición de datos y funcionalidades en componentes anidados.</p>');
INSERT INTO `text_lesson_translations` VALUES (48, 56, 'es', 'Context API de React', 'El Context API es una característica de React que permite compartir datos y funcionalidades entre componentes en una jerarquía de componentes sin tener que pasar props a través de múltiples niveles. Proporciona una forma más eficiente y limpia de gestionar el estado global en una aplicación de React.\r\n\r\nEl Context API consta de dos partes principales:\r\n\r\n1. Proveedor (Provider): Es un componente de React que se utiliza para crear un contexto y proporcionar los datos que se compartirán a lo largo de la jerarquía de componentes. Se define utilizando el método React.createContext y se utiliza como un componente envolvente alrededor de los componentes que necesitan acceder a los datos del contexto.\r\n\r\n2. Consumidor (Consumer): Es un componente de React que se utiliza para acceder a los datos del contexto proporcionados por el proveedor. Se utiliza dentro de los componentes que necesitan acceder a los datos del contexto, y se suscribe automáticamente a los cambios en el valor del contexto.', '<p style=\"text-align: justify; \">El Context API es una característica de React que permite compartir datos y funcionalidades entre componentes en una jerarquía de componentes sin tener que pasar props a través de múltiples niveles. Proporciona una forma más eficiente y limpia de gestionar el estado global en una aplicación de React.</p><p style=\"text-align: justify; \">El Context API consta de dos partes principales:</p><p style=\"text-align: justify; \">1. Proveedor (Provider): Es un componente de React que se utiliza para crear un contexto y proporcionar los datos que se compartirán a lo largo de la jerarquía de componentes. Se define utilizando el método React.createContext y se utiliza como un componente envolvente alrededor de los componentes que necesitan acceder a los datos del contexto.</p><p style=\"text-align: justify; \">2. Consumidor (Consumer): Es un componente de React que se utiliza para acceder a los datos del contexto proporcionados por el proveedor. Se utiliza dentro de los componentes que necesitan acceder a los datos del contexto, y se suscribe automáticamente a los cambios en el valor del contexto.</p>');
INSERT INTO `text_lesson_translations` VALUES (49, 57, 'es', 'Manejo de estados en React con useReducer y useContext (Redux Lite)', 'El manejo de estados en React es una parte fundamental del desarrollo de aplicaciones, y existen varias formas de hacerlo. Además de los tradicionales estados locales de los componentes y el uso de bibliotecas de manejo de estados externas como Redux, React también proporciona dos hooks nativos para manejar estados globales de manera más sencilla: useReducer y useContext, que a menudo se utilizan en conjunto para crear un patrón similar a Redux, conocido como \"Redux Lite\" o \"Redux simplificado\".', '<p style=\"text-align: justify; \">El manejo de estados en React es una parte fundamental del desarrollo de aplicaciones, y existen varias formas de hacerlo. Además de los tradicionales estados locales de los componentes y el uso de bibliotecas de manejo de estados externas como Redux, React también proporciona dos hooks nativos para manejar estados globales de manera más sencilla: useReducer y useContext, que a menudo se utilizan en conjunto para crear un patrón similar a Redux, conocido como \"Redux Lite\" o \"Redux simplificado\".</p>');
INSERT INTO `text_lesson_translations` VALUES (50, 58, 'es', 'Introducción a React Router', 'React Router es una biblioteca popular de enrutamiento para aplicaciones de React que permite gestionar la navegación y la visualización de diferentes vistas en una aplicación de una sola página (SPA). Proporciona un enfoque declarativo y basado en componentes para el enrutamiento en aplicaciones web, lo que facilita la creación de aplicaciones con múltiples páginas y una navegación suave entre ellas.', '<p style=\"text-align: justify; \">React Router es una biblioteca popular de enrutamiento para aplicaciones de React que permite gestionar la navegación y la visualización de diferentes vistas en una aplicación de una sola página (SPA). Proporciona un enfoque declarativo y basado en componentes para el enrutamiento en aplicaciones web, lo que facilita la creación de aplicaciones con múltiples páginas y una navegación suave entre ellas.</p>');
INSERT INTO `text_lesson_translations` VALUES (51, 59, 'es', 'Creación de múltiples proyectos con interfaces atractivas', 'Crear múltiples proyectos con interfaces atractivas puede ser un proceso emocionante y creativo. Algunos pasos generales son:\r\n\r\n1. Definir el objetivo del proyecto: Antes de comenzar a diseñar la interfaz, es importante tener claro el objetivo del proyecto. ¿Qué quieres lograr con esta interfaz? ¿Cuál es el propósito de tu proyecto? Definir claramente el objetivo del proyecto te ayudará a tomar decisiones de diseño más informadas y a crear una interfaz que se ajuste a tus necesidades y a las de tus usuarios.\r\n\r\n2. Investigar e inspirarse: Realiza una investigación sobre proyectos similares o interfaces que te inspiren. Examina otros proyectos exitosos con interfaces atractivas y toma nota de los elementos de diseño que encuentres interesantes. Puedes obtener inspiración de sitios web, aplicaciones móviles, diseños de interfaz de usuario de productos populares, redes sociales y otros recursos en línea.\r\n\r\n3. Crear un diseño visual atractivo: La apariencia visual de tu proyecto es un factor importante para crear una interfaz atractiva. Puedes utilizar herramientas de diseño como Figma, Sketch o Adobe XD para crear tus diseños. Asegúrate de utilizar colores, tipografía y elementos visuales que se ajusten a la marca y la identidad de tu proyecto. También considera la usabilidad y la accesibilidad al diseñar tu interfaz.\r\n\r\n4. Utilizar una jerarquía clara de contenido: Una interfaz atractiva debe tener una jerarquía clara de contenido, lo que significa que los elementos más importantes o relevantes deben destacar y ser fácilmente accesibles para los usuarios. Utiliza un diseño limpio y organizado, con un flujo de información lógico y coherente. Utiliza títulos, subtítulos, listas y otros elementos visuales para ayudar a los usuarios a entender la estructura y la información presentada en tu proyecto.\r\n\r\n5. Considerar la usabilidad: La usabilidad es un factor clave en la creación de interfaces atractivas. Asegúrate de que tu proyecto sea fácil de usar y de entender para tus usuarios. Considera la navegación, la disposición de los elementos, la claridad de las etiquetas y la capacidad de respuesta en diferentes dispositivos. Haz pruebas de usabilidad con usuarios reales para obtener retroalimentación y realizar ajustes en tu diseño.\r\n\r\n6. Añadir elementos interactivos: Los elementos interactivos, como botones, formularios, animaciones y efectos visuales, pueden hacer que tu interfaz sea más atractiva y atractiva para los usuarios. Asegúrate de añadir elementos interactivos que sean intuitivos y fáciles de usar, y que mejoren la experiencia del usuario en lugar de complicarla.\r\n\r\n7. Optimizar el rendimiento: Asegúrate de que tu proyecto tenga un buen rendimiento en términos de carga rápida de páginas y fluidez en la interacción. Los usuarios suelen abandonar sitios web o aplicaciones lentas o que presentan problemas de rendimiento. Optimiza tus imágenes, utiliza una codificación eficiente y realiza pruebas de rendimiento para asegurarte de que tu proyecto se cargue rápidamente y funcione sin problemas.\r\n\r\n8. Obtener retroalimentación de usuarios: Una vez que hayas creado tu proyecto con una interfaz atractiva, obtén retroalimentación de los usuarios.', '<p style=\"text-align: justify; \">Crear múltiples proyectos con interfaces atractivas puede ser un proceso emocionante y creativo. Algunos pasos generales son:</p><p style=\"text-align: justify; \">1. Definir el objetivo del proyecto: Antes de comenzar a diseñar la interfaz, es importante tener claro el objetivo del proyecto. ¿Qué quieres lograr con esta interfaz? ¿Cuál es el propósito de tu proyecto? Definir claramente el objetivo del proyecto te ayudará a tomar decisiones de diseño más informadas y a crear una interfaz que se ajuste a tus necesidades y a las de tus usuarios.</p><p style=\"text-align: justify; \">2. Investigar e inspirarse: Realiza una investigación sobre proyectos similares o interfaces que te inspiren. Examina otros proyectos exitosos con interfaces atractivas y toma nota de los elementos de diseño que encuentres interesantes. Puedes obtener inspiración de sitios web, aplicaciones móviles, diseños de interfaz de usuario de productos populares, redes sociales y otros recursos en línea.</p><p style=\"text-align: justify; \">3. Crear un diseño visual atractivo: La apariencia visual de tu proyecto es un factor importante para crear una interfaz atractiva. Puedes utilizar herramientas de diseño como Figma, Sketch o Adobe XD para crear tus diseños. Asegúrate de utilizar colores, tipografía y elementos visuales que se ajusten a la marca y la identidad de tu proyecto. También considera la usabilidad y la accesibilidad al diseñar tu interfaz.</p><p style=\"text-align: justify; \">4. Utilizar una jerarquía clara de contenido: Una interfaz atractiva debe tener una jerarquía clara de contenido, lo que significa que los elementos más importantes o relevantes deben destacar y ser fácilmente accesibles para los usuarios. Utiliza un diseño limpio y organizado, con un flujo de información lógico y coherente. Utiliza títulos, subtítulos, listas y otros elementos visuales para ayudar a los usuarios a entender la estructura y la información presentada en tu proyecto.</p><p style=\"text-align: justify; \">5. Considerar la usabilidad: La usabilidad es un factor clave en la creación de interfaces atractivas. Asegúrate de que tu proyecto sea fácil de usar y de entender para tus usuarios. Considera la navegación, la disposición de los elementos, la claridad de las etiquetas y la capacidad de respuesta en diferentes dispositivos. Haz pruebas de usabilidad con usuarios reales para obtener retroalimentación y realizar ajustes en tu diseño.</p><p style=\"text-align: justify; \">6. Añadir elementos interactivos: Los elementos interactivos, como botones, formularios, animaciones y efectos visuales, pueden hacer que tu interfaz sea más atractiva y atractiva para los usuarios. Asegúrate de añadir elementos interactivos que sean intuitivos y fáciles de usar, y que mejoren la experiencia del usuario en lugar de complicarla.</p><p style=\"text-align: justify; \">7. Optimizar el rendimiento: Asegúrate de que tu proyecto tenga un buen rendimiento en términos de carga rápida de páginas y fluidez en la interacción. Los usuarios suelen abandonar sitios web o aplicaciones lentas o que presentan problemas de rendimiento. Optimiza tus imágenes, utiliza una codificación eficiente y realiza pruebas de rendimiento para asegurarte de que tu proyecto se cargue rápidamente y funcione sin problemas.</p><p style=\"text-align: justify; \">8. Obtener retroalimentación de usuarios: Una vez que hayas creado tu proyecto con una interfaz atractiva, obtén retroalimentación de los usuarios.</p>');
INSERT INTO `text_lesson_translations` VALUES (52, 60, 'es', 'Patrones de manejo de estados en React', 'React, como biblioteca de JavaScript para la construcción de interfaces de usuario, ofrece varias opciones para manejar el estado de tus componentes. Algunos patrones populares de manejo de estados en React son:\r\n\r\n1. State local del componente: React permite que los componentes tengan su propio estado local. Se usar el hook useState para declarar una variable de estado en un componente funcional, y luego usarla para almacenar y actualizar el estado local.\r\n\r\n 2. Props y callbacks: Puede pasar datos a través de props desde un componente padre a un componente hijo, y usar callbacks para permitir que el componente hijo notifique cambios al componente padre. Esto es especialmente útil para el flujo de datos de arriba a abajo en la jerarquía de componentes.\r\n\r\n3. Context API: El Context API de React permite compartir datos a través de la jerarquía de componentes sin tener que pasarlos explícitamente a través de props. Puede usar el hook useContext para acceder a los datos de contexto en cualquier componente dentro de un contexto específico.\r\n\r\n4. Librerías de manejo de estados externas: Además de las opciones integradas en React, también puedes usar librerías externas como Redux o MobX para manejar estados más complejos en tu aplicación. Estas librerías ofrecen patrones más avanzados y escalables para el manejo de estados en aplicaciones de gran tamaño.', '<p style=\"text-align: justify; \">React, como biblioteca de JavaScript para la construcción de interfaces de usuario, ofrece varias opciones para manejar el estado de tus componentes. Algunos patrones populares de manejo de estados en React son:</p><p style=\"text-align: justify; \">1. State local del componente: React permite que los componentes tengan su propio estado local. Se usar el hook useState para declarar una variable de estado en un componente funcional, y luego usarla para almacenar y actualizar el estado local.</p><p style=\"text-align: justify; \">&nbsp;2. Props y callbacks: Puede pasar datos a través de props desde un componente padre a un componente hijo, y usar callbacks para permitir que el componente hijo notifique cambios al componente padre. Esto es especialmente útil para el flujo de datos de arriba a abajo en la jerarquía de componentes.</p><p style=\"text-align: justify; \">3. Context API: El Context API de React permite compartir datos a través de la jerarquía de componentes sin tener que pasarlos explícitamente a través de props. Puede usar el hook useContext para acceder a los datos de contexto en cualquier componente dentro de un contexto específico.</p><p style=\"text-align: justify; \">4. Librerías de manejo de estados externas: Además de las opciones integradas en React, también puedes usar librerías externas como Redux o MobX para manejar estados más complejos en tu aplicación. Estas librerías ofrecen patrones más avanzados y escalables para el manejo de estados en aplicaciones de gran tamaño.</p>');
INSERT INTO `text_lesson_translations` VALUES (53, 61, 'es', 'Drag and Drop con React', 'El arrastrar y soltar (Drag and Drop) es una funcionalidad popular en las interfaces de usuario modernas, y React ofrece una forma sencilla de implementarla a través de librerías y API de HTML5.', '<p style=\"text-align: justify; \">El arrastrar y soltar (Drag and Drop) es una funcionalidad popular en las interfaces de usuario modernas, y React ofrece una forma sencilla de implementarla a través de librerías y API de HTML5.&nbsp;</p>');
INSERT INTO `text_lesson_translations` VALUES (54, 62, 'es', 'Escritura de componentes con estilos dinámicos en JSS', 'JSS (JavaScript Style Sheets) es una librería que permite escribir estilos en JavaScript para aplicarlos a componentes de React de forma dinámica. Con JSS, se pueden crear componentes con estilos dinámicos que se ajusten a cambios en el estado o en las propiedades de los componentes.', '<p style=\"text-align: justify; \">JSS (JavaScript Style Sheets) es una librería que permite escribir estilos en JavaScript para aplicarlos a componentes de React de forma dinámica. Con JSS, se pueden crear componentes con estilos dinámicos que se ajusten a cambios en el estado o en las propiedades de los componentes.&nbsp;</p>');
INSERT INTO `text_lesson_translations` VALUES (55, 63, 'es', 'Patrones comunes en React Router', 'React Router es una librería popular para el enrutamiento de aplicaciones de React. Permite manejar la navegación y el enrutamiento de manera declarativa en aplicaciones de una sola página (SPA). Aquí hay algunos patrones comunes que se pueden utilizar con React Router:\r\n\r\n1. Enrutamiento básico: El patrón básico de enrutamiento con React Router implica definir rutas en tu aplicación y renderizar componentes específicos cuando se accede a esas rutas.\r\n\r\n2. Enrutamiento anidado: React Router permite el enrutamiento anidado, lo que significa que permite tener rutas dentro de otras rutas. Esto es útil para crear jerarquías de rutas y componentes en tu aplicación.\r\n\r\n3. Rutas protegidas: Permite utilizar React Router para crear rutas protegidas, es decir, rutas que solo pueden ser accedidas por usuarios autenticados. Permite utilizar un componente de protección de ruta para verificar la autenticación del usuario antes de permitir el acceso a una ruta específica.\r\n\r\n4. Página no encontrada (404): Es común tener una página de error para rutas que no existen en tu aplicación. Puedes utilizar una ruta sin ruta (<Route /> sin path) al final de tus rutas para capturar rutas no encontradas y renderizar una página de error.', '<p style=\"text-align: justify; \">React Router es una librería popular para el enrutamiento de aplicaciones de React. Permite manejar la navegación y el enrutamiento de manera declarativa en aplicaciones de una sola página (SPA). Aquí hay algunos patrones comunes que se pueden utilizar con React Router:</p><p style=\"text-align: justify; \">1. Enrutamiento básico: El patrón básico de enrutamiento con React Router implica definir rutas en tu aplicación y renderizar componentes específicos cuando se accede a esas rutas.</p><p style=\"text-align: justify; \">2. Enrutamiento anidado: React Router permite el enrutamiento anidado, lo que significa que permite tener rutas dentro de otras rutas. Esto es útil para crear jerarquías de rutas y componentes en tu aplicación.</p><p style=\"text-align: justify; \">3. Rutas protegidas: Permite utilizar React Router para crear rutas protegidas, es decir, rutas que solo pueden ser accedidas por usuarios autenticados. Permite utilizar un componente de protección de ruta para verificar la autenticación del usuario antes de permitir el acceso a una ruta específica.</p><p style=\"text-align: justify; \">4. Página no encontrada (404): Es común tener una página de error para rutas que no existen en tu aplicación. Puedes utilizar una ruta sin ruta (&lt;Route /&gt; sin path) al final de tus rutas para capturar rutas no encontradas y renderizar una página de error.</p>');
INSERT INTO `text_lesson_translations` VALUES (56, 64, 'es', 'Trabajo con bibliotecas y herramientas en React', 'Trabajar con bibliotecas y herramientas en React puede ser una parte integral del desarrollo de aplicaciones web modernas. Aquí hay algunas bibliotecas y herramientas populares que se utilizan comúnmente en proyectos de React:\r\n\r\n1. Redux: Redux es una biblioteca de manejo del estado que se utiliza para gestionar el estado de una aplicación de React de forma centralizada. Proporciona un flujo de datos unidireccional y permite manejar de manera eficiente el estado de la aplicación, lo que facilita el seguimiento y actualización del estado en componentes de React. Redux se utiliza ampliamente en aplicaciones grandes y complejas para manejar la lógica de estado de la aplicación.\r\n\r\n2. Axios: Axios es una biblioteca de cliente HTTP que se utiliza para realizar solicitudes HTTP desde aplicaciones de React. Proporciona una API simple y flexible para interactuar con servicios web y realizar operaciones como obtener datos, enviar formularios, etc. Axios se utiliza comúnmente para integrar aplicaciones de React con API externas y realizar llamadas HTTP.\r\n\r\n3. React Router: React Router es una biblioteca de enrutamiento que se utiliza para gestionar la navegación y el enrutamiento en aplicaciones de React. Proporciona componentes para definir rutas y renderizar componentes específicos en función de la ruta actual del navegador. React Router es ampliamente utilizado en aplicaciones de una sola página (SPA) para gestionar la navegación entre diferentes vistas y componentes.\r\n\r\n4. Material-UI: Material-UI es una biblioteca de componentes de interfaz de usuario (UI) que se utiliza para construir interfaces de usuario atractivas y receptivas en aplicaciones de React. Proporciona una amplia variedad de componentes predefinidos como botones, formularios, listas, etc., que siguen el diseño de Material Design de Google. Material-UI facilita la creación de interfaces de usuario modernas y atractivas en aplicaciones de React.\r\n\r\n5. Jest y Enzyme: Jest y Enzyme son herramientas populares de pruebas unitarias para aplicaciones de React. Jest es un marco de pruebas creado por Facebook y Enzyme es una biblioteca de utilidades de pruebas creada por Airbnb. Juntas, estas herramientas permiten escribir y ejecutar pruebas unitarias para componentes de React, lo que ayuda a garantizar la calidad del código y la funcionalidad de la aplicación.\r\n\r\n6. ESLint: ESLint es una herramienta de linting que se utiliza para mantener la calidad del código en aplicaciones de React. Proporciona reglas de linting configurables que ayudan a identificar y corregir errores y malas prácticas en el código. ESLint se integra fácilmente con proyectos de React y ayuda a mantener un código limpio y libre de errores.', '<p>Trabajar con bibliotecas y herramientas en React puede ser una parte integral del desarrollo de aplicaciones web modernas. Algunas bibliotecas y herramientas populares que se utilizan comúnmente en proyectos de React:</p><p>1. Redux: Redux es una biblioteca de manejo del estado que se utiliza para gestionar el estado de una aplicación de React de forma centralizada. Proporciona un flujo de datos unidireccional y permite manejar de manera eficiente el estado de la aplicación, lo que facilita el seguimiento y actualización del estado en componentes de React. Redux se utiliza ampliamente en aplicaciones grandes y complejas para manejar la lógica de estado de la aplicación.</p><p>2. Axios: Axios es una biblioteca de cliente HTTP que se utiliza para realizar solicitudes HTTP desde aplicaciones de React. Proporciona una API simple y flexible para interactuar con servicios web y realizar operaciones como obtener datos, enviar formularios, etc. Axios se utiliza comúnmente para integrar aplicaciones de React con API externas y realizar llamadas HTTP.</p><p>3. React Router: React Router es una biblioteca de enrutamiento que se utiliza para gestionar la navegación y el enrutamiento en aplicaciones de React. Proporciona componentes para definir rutas y renderizar componentes específicos en función de la ruta actual del navegador. React Router es ampliamente utilizado en aplicaciones de una sola página (SPA) para gestionar la navegación entre diferentes vistas y componentes.</p><p>4. Material-UI: Material-UI es una biblioteca de componentes de interfaz de usuario (UI) que se utiliza para construir interfaces de usuario atractivas y receptivas en aplicaciones de React. Proporciona una amplia variedad de componentes predefinidos como botones, formularios, listas, etc., que siguen el diseño de Material Design de Google. Material-UI facilita la creación de interfaces de usuario modernas y atractivas en aplicaciones de React.</p><p>5. Jest y Enzyme: Jest y Enzyme son herramientas populares de pruebas unitarias para aplicaciones de React. Jest es un marco de pruebas creado por Facebook y Enzyme es una biblioteca de utilidades de pruebas creada por Airbnb. Juntas, estas herramientas permiten escribir y ejecutar pruebas unitarias para componentes de React, lo que ayuda a garantizar la calidad del código y la funcionalidad de la aplicación.</p><p>6. ESLint: ESLint es una herramienta de linting que se utiliza para mantener la calidad del código en aplicaciones de React. Proporciona reglas de linting configurables que ayudan a identificar y corregir errores y malas prácticas en el código. ESLint se integra fácilmente con proyectos de React y ayuda a mantener un código limpio y libre de errores.</p>');
INSERT INTO `text_lesson_translations` VALUES (57, 65, 'es', 'Integración de bibliotecas de interfaz de usuario como Material UI y Bootstrap en aplicaciones de React', 'La integración de bibliotecas de interfaz de usuario como Material-UI y Bootstrap en aplicaciones de React implica la instalación de la biblioteca, la importación de los componentes necesarios, el uso de los componentes en los archivos de componentes de React y la personalización de estilos según sea necesario. Esto puede mejorar rápidamente la apariencia y funcionalidad de la aplicación, y facilitar el desarrollo de interfaces de usuario modernas y atractivas.', '<p style=\"text-align: justify; \">La integración de bibliotecas de interfaz de usuario como Material-UI y Bootstrap en aplicaciones de React implica la instalación de la biblioteca, la importación de los componentes necesarios, el uso de los componentes en los archivos de componentes de React y la personalización de estilos según sea necesario. Esto puede mejorar rápidamente la apariencia y funcionalidad de la aplicación, y facilitar el desarrollo de interfaces de usuario modernas y atractivas.</p>');
INSERT INTO `text_lesson_translations` VALUES (58, 66, 'es', 'Patrones y estrategias de diseño en React', 'En el desarrollo de aplicaciones en React, existen varios patrones y estrategias de diseño que pueden ayudar a mejorar la organización, la mantenibilidad y la escalabilidad del código.\r\n\r\n1. Patrón Contenedor y Presentación (Container and Presentational): Este patrón sugiere dividir los componentes en dos tipos: los contenedores (containers) y los presentacionales (presentational). Los componentes contenedores se encargan de la lógica de negocio, la gestión del estado y la interacción con los datos, mientras que los componentes presentacionales se enfocan únicamente en la presentación de la interfaz de usuario. Esto permite una mayor separación de preocupaciones y facilita el mantenimiento y la reutilización de los componentes.\r\n\r\n2. Patrón Render Props: Este patrón se basa en pasar una función como prop a un componente, que luego puede ser utilizada por el componente para renderizar su contenido. Esto permite la reutilización de la lógica de renderizado en varios componentes, evitando la duplicación de código y mejorando la mantenibilidad.\r\n\r\n3. Estrategia de Levantamiento del Estado (Lifting State Up): Este enfoque consiste en mover el estado compartido entre varios componentes hacia un ancestro común en la jerarquía de componentes. Esto permite que los componentes hijos accedan y actualicen el estado a través de props, evitando la duplicación de estado y asegurando que los datos estén sincronizados en la aplicación.\r\n\r\n4. Patrón de Composición (Composition Pattern): Este patrón se basa en la composición de componentes más pequeños y reutilizables para construir componentes más complejos. Los componentes se pueden componer unos dentro de otros, creando una jerarquía de componentes que son fáciles de entender, mantener y reutilizar.\r\n\r\n5. Patrón de Renderizado Condicional: Este patrón se utiliza para renderizar diferentes elementos o componentes según condiciones específicas. Puede ser utilizado para mostrar u ocultar elementos en función del estado de la aplicación, datos del usuario, permisos, entre otros. Esto permite una mayor flexibilidad en la interfaz de usuario y la adaptación dinámica del contenido.\r\n\r\n6. Estrategia de Optimización de Rendimiento: Dado que el rendimiento es un factor importante en las aplicaciones web, es importante tener en cuenta estrategias de optimización de rendimiento en el diseño de las aplicaciones en React. Esto puede incluir la utilización de técnicas como memoización, lazy loading, y shouldComponentUpdate para evitar renderizados innecesarios y mejorar la eficiencia del rendimiento de la aplicación.', '<p style=\"text-align: justify; \">En el desarrollo de aplicaciones en React, existen varios patrones y estrategias de diseño que pueden ayudar a mejorar la organización, la mantenibilidad y la escalabilidad del código.</p><p style=\"text-align: justify; \">1. Patrón Contenedor y Presentación (Container and Presentational): Este patrón sugiere dividir los componentes en dos tipos: los contenedores (containers) y los presentacionales (presentational). Los componentes contenedores se encargan de la lógica de negocio, la gestión del estado y la interacción con los datos, mientras que los componentes presentacionales se enfocan únicamente en la presentación de la interfaz de usuario. Esto permite una mayor separación de preocupaciones y facilita el mantenimiento y la reutilización de los componentes.</p><p style=\"text-align: justify; \">2. Patrón Render Props: Este patrón se basa en pasar una función como prop a un componente, que luego puede ser utilizada por el componente para renderizar su contenido. Esto permite la reutilización de la lógica de renderizado en varios componentes, evitando la duplicación de código y mejorando la mantenibilidad.</p><p style=\"text-align: justify; \">3. Estrategia de Levantamiento del Estado (Lifting State Up): Este enfoque consiste en mover el estado compartido entre varios componentes hacia un ancestro común en la jerarquía de componentes. Esto permite que los componentes hijos accedan y actualicen el estado a través de props, evitando la duplicación de estado y asegurando que los datos estén sincronizados en la aplicación.</p><p style=\"text-align: justify; \">4. Patrón de Composición (Composition Pattern): Este patrón se basa en la composición de componentes más pequeños y reutilizables para construir componentes más complejos. Los componentes se pueden componer unos dentro de otros, creando una jerarquía de componentes que son fáciles de entender, mantener y reutilizar.</p><p style=\"text-align: justify; \">5. Patrón de Renderizado Condicional: Este patrón se utiliza para renderizar diferentes elementos o componentes según condiciones específicas. Puede ser utilizado para mostrar u ocultar elementos en función del estado de la aplicación, datos del usuario, permisos, entre otros. Esto permite una mayor flexibilidad en la interfaz de usuario y la adaptación dinámica del contenido.</p><p style=\"text-align: justify; \">6. Estrategia de Optimización de Rendimiento: Dado que el rendimiento es un factor importante en las aplicaciones web, es importante tener en cuenta estrategias de optimización de rendimiento en el diseño de las aplicaciones en React. Esto puede incluir la utilización de técnicas como memoización, lazy loading, y shouldComponentUpdate para evitar renderizados innecesarios y mejorar la eficiencia del rendimiento de la aplicación.</p>');
INSERT INTO `text_lesson_translations` VALUES (59, 67, 'es', 'Optimización de componentes de React', 'La optimización de componentes en React es importante para asegurar un rendimiento eficiente de la aplicación y evitar renderizaciones innecesarias que puedan impactar negativamente en el rendimiento y la experiencia del usuario.', '<p>Optimización de componentes de React</p><p>La optimización de componentes en React es importante para asegurar un rendimiento eficiente de la aplicación y evitar renderizaciones innecesarias que puedan impactar negativamente en el rendimiento y la experiencia del usuario.</p>');
INSERT INTO `text_lesson_translations` VALUES (60, 68, 'es', 'Integración de React con API', 'La integración de React con una API es un paso importante en el desarrollo de aplicaciones web modernas. Permite obtener y enviar datos entre la interfaz de usuario de React y un servidor remoto para obtener y actualizar información dinámica en la aplicación.', '<p>La integración de React con una API es un paso importante en el desarrollo de aplicaciones web modernas. Permite obtener y enviar datos entre la interfaz de usuario de React y un servidor remoto para obtener y actualizar información dinámica en la aplicación. Aquí hay algunos pasos básicos para integrar React con una API:</p><p>1. Definir endpoints y rutas de la API: Primero, es necesario conocer los endpoints y rutas de la API con la que se desea integrar React. Esto implica comprender la estructura de la API, los métodos de solicitud (como GET, POST, PUT, DELETE) y los datos que se esperan enviar o recibir.</p><p>2. Hacer solicitudes HTTP con Axios o Fetch: En React, se puede utilizar la biblioteca Axios o la función nativa Fetch para hacer solicitudes HTTP a la API. Estas bibliotecas proporcionan métodos para enviar y recibir datos a través de HTTP, como obtener datos de la API, enviar datos de formulario, actualizar datos y eliminar datos.</p><p>3. Manejar respuestas y errores: Es importante manejar las respuestas y errores de las solicitudes HTTP. Esto puede implicar el manejo de códigos de estado HTTP, el procesamiento de datos recibidos en formato JSON u otros formatos, y el manejo de errores de red o errores en la respuesta de la API.</p><p>4. Actualizar el estado de la aplicación: Una vez que se obtienen los datos de la API, es necesario actualizar el estado de la aplicación en React. Esto puede implicar la actualización del estado local del componente para mostrar los datos obtenidos de la API en la interfaz de usuario de React, o enviar datos actualizados a la API para su procesamiento.</p><p>5. Manejar eventos del usuario: En muchos casos, la integración de React con una API implica la interacción del usuario con la interfaz de usuario de React. Esto puede incluir el envío de formularios, clics en botones u otras acciones del usuario. Es importante manejar estos eventos del usuario y enviar los datos a la API para su procesamiento.</p><p>6. Utilizar Hooks o Redux para la gestión del estado global: En aplicaciones más complejas, puede ser útil utilizar Hooks o Redux para la gestión del estado global de la aplicación en lugar de pasar datos y funciones a través de props en múltiples componentes. Esto puede facilitar la gestión de datos obtenidos de la API en diferentes partes de la aplicación y mantener la consistencia en el estado de la aplicación.</p><p>7. Implementar seguridad y autenticación: Dependiendo de los requisitos de seguridad de la aplicación y la API, puede ser necesario implementar medidas de seguridad y autenticación en la integración de React con la API. Esto puede implicar el uso de tokens de autenticación, la implementación de HTTPS, y otras medidas de seguridad para proteger la información sensible y asegurar la autenticación y autorización adecuadas en la comunicación con la API.</p>');
INSERT INTO `text_lesson_translations` VALUES (61, 69, 'es', 'Introducción a Webpack a través de un mini-curso', '¿Qué es Webpack?\r\nWebpack es una herramienta de código abierto utilizada para la construcción y empaquetado de aplicaciones web. Se encarga de administrar y optimizar la carga de recursos en una aplicación, como JavaScript, CSS, imágenes y otros archivos estáticos, en un proceso de compilación. Webpack permite gestionar dependencias, transformar y optimizar archivos, y crear bundles o paquetes de recursos optimizados para su distribución en un servidor de producción.\r\n\r\nConceptos básicos de Webpack:\r\n\r\nEntry Points: Son los puntos de entrada de una aplicación, es decir, los archivos principales que Webpack utiliza para comenzar a construir el grafo de dependencias de la aplicación.\r\nOutput: Es el resultado de la compilación de los archivos de entrada. Webpack genera uno o varios archivos de salida (bundles) que contienen el código optimizado de la aplicación lista para ser distribuida en un servidor de producción.\r\nLoaders: Son módulos que permiten a Webpack procesar archivos diferentes a JavaScript, como CSS, imágenes, fuentes, etc. Los loaders se encargan de transformar estos archivos en módulos de JavaScript que puedan ser incluidos en los bundles de Webpack.\r\nPlugins: Son módulos que extienden las capacidades de Webpack y permiten realizar tareas adicionales en el proceso de compilación, como generar archivos HTML, optimizar recursos, manejar variables de entorno, entre otros.', '<p style=\"text-align: justify; \">¿Qué es Webpack?</p><p style=\"text-align: justify; \">Webpack es una herramienta de código abierto utilizada para la construcción y empaquetado de aplicaciones web. Se encarga de administrar y optimizar la carga de recursos en una aplicación, como JavaScript, CSS, imágenes y otros archivos estáticos, en un proceso de compilación. Webpack permite gestionar dependencias, transformar y optimizar archivos, y crear bundles o paquetes de recursos optimizados para su distribución en un servidor de producción.</p><p style=\"text-align: justify; \">Conceptos básicos de Webpack:</p><p style=\"text-align: justify; \">Entry Points: Son los puntos de entrada de una aplicación, es decir, los archivos principales que Webpack utiliza para comenzar a construir el grafo de dependencias de la aplicación.</p><p style=\"text-align: justify; \">Output: Es el resultado de la compilación de los archivos de entrada. Webpack genera uno o varios archivos de salida (bundles) que contienen el código optimizado de la aplicación lista para ser distribuida en un servidor de producción.</p><p style=\"text-align: justify; \">Loaders: Son módulos que permiten a Webpack procesar archivos diferentes a JavaScript, como CSS, imágenes, fuentes, etc. Los loaders se encargan de transformar estos archivos en módulos de JavaScript que puedan ser incluidos en los bundles de Webpack.</p><p style=\"text-align: justify; \">Plugins: Son módulos que extienden las capacidades de Webpack y permiten realizar tareas adicionales en el proceso de compilación, como generar archivos HTML, optimizar recursos, manejar variables de entorno, entre otros.</p>');
INSERT INTO `text_lesson_translations` VALUES (62, 70, 'es', 'Manejo de eventos DOM en React', 'En React, el manejo de eventos del DOM se realiza de manera similar a como se hace en JavaScript puro, pero con algunas diferencias en la sintaxis y en cómo se gestionan los eventos. Los eventos son gestionados de manera declarativa y se manejan de manera eficiente a través de la virtual DOM, lo que facilita la creación de aplicaciones web interactivas y con un rendimiento óptimo.', '<p style=\"text-align: justify; \">En React, el manejo de eventos del DOM se realiza de manera similar a como se hace en JavaScript puro, pero con algunas diferencias en la sintaxis y en cómo se gestionan los eventos. Los eventos son gestionados de manera declarativa y se manejan de manera eficiente a través de la virtual DOM, lo que facilita la creación de aplicaciones web interactivas y con un rendimiento óptimo.</p>');
INSERT INTO `text_lesson_translations` VALUES (63, 71, 'es', 'Formularios y validaciones complejas en React', 'React ofrece una forma eficiente y declarativa de trabajar con formularios y realizar validaciones complejas. Permite utilizar los estados, props y eventos de los componentes de formulario para gestionar los datos del formulario y realizar validaciones en tiempo real, así como también realizar validaciones en la presentación de datos antes de enviar el formulario. Además, existen bibliotecas de validación populares que ayudan a simplificar el proceso de manejo de formularios y validaciones en tus aplicaciones de React.', '<p>&nbsp;React ofrece una forma eficiente y declarativa de trabajar con formularios y realizar validaciones complejas. Permite utilizar los estados, props y eventos de los componentes de formulario para gestionar los datos del formulario y realizar validaciones en tiempo real, así como también realizar validaciones en la presentación de datos antes de enviar el formulario. Además, existen bibliotecas de validación populares que ayudan a simplificar el proceso de manejo de formularios y validaciones en tus aplicaciones de React.</p>');
INSERT INTO `text_lesson_translations` VALUES (64, 72, 'es', 'Uso de Context API con Hooks en React', 'La Context API en React es una característica que permite compartir datos entre componentes sin necesidad de pasarlos a través de props en la jerarquía de componentes. Con la incorporación de Hooks en React, la Context API se ha vuelto aún más poderosa y fácil de usar.', '<p style=\"text-align: justify; \">La Context API en React es una característica que permite compartir datos entre componentes sin necesidad de pasarlos a través de props en la jerarquía de componentes. Con la incorporación de Hooks en React, la Context API se ha vuelto aún más poderosa y fácil de usar.&nbsp;</p>');
INSERT INTO `text_lesson_translations` VALUES (65, 73, 'es', 'Algoritmos, variables, tipos de datos y operadores aritméticos', 'En un curso de algoritmos, variables, tipos de datos y operadores aritméticos se pueden aprender los conceptos fundamentales de la programación y la matemática básica necesaria para programar.', '<p style=\"border: 0px solid rgb(217, 217, 227); --tw-border-spacing-x:0; --tw-border-spacing-y:0; --tw-translate-x:0; --tw-translate-y:0; --tw-rotate:0; --tw-skew-x:0; --tw-skew-y:0; --tw-scale-x:1; --tw-scale-y:1; --tw-pan-x: ; --tw-pan-y: ; --tw-pinch-zoom: ; --tw-scroll-snap-strictness:proximity; --tw-gradient-from-position: ; --tw-gradient-via-position: ; --tw-gradient-to-position: ; --tw-ordinal: ; --tw-slashed-zero: ; --tw-numeric-figure: ; --tw-numeric-spacing: ; --tw-numeric-fraction: ; --tw-ring-inset: ; --tw-ring-offset-width:0px; --tw-ring-offset-color:#fff; --tw-ring-color:rgba(59,130,246,0.5); --tw-ring-offset-shadow:0 0 transparent; --tw-ring-shadow:0 0 transparent; --tw-shadow:0 0 transparent; --tw-shadow-colored:0 0 transparent; --tw-blur: ; --tw-brightness: ; --tw-contrast: ; --tw-grayscale: ; --tw-hue-rotate: ; --tw-invert: ; --tw-saturate: ; --tw-sepia: ; --tw-drop-shadow: ; --tw-backdrop-blur: ; --tw-backdrop-brightness: ; --tw-backdrop-contrast: ; --tw-backdrop-grayscale: ; --tw-backdrop-hue-rotate: ; --tw-backdrop-invert: ; --tw-backdrop-opacity: ; --tw-backdrop-saturate: ; --tw-backdrop-sepia: ; margin-right: 0px; margin-bottom: 1.25em; margin-left: 0px; font-family: Söhne, ui-sans-serif, system-ui, -apple-system, &quot;Segoe UI&quot;, Roboto, Ubuntu, Cantarell, &quot;Noto Sans&quot;, sans-serif, &quot;Helvetica Neue&quot;, Arial, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;, &quot;Noto Color Emoji&quot;; font-size: 16px; white-space: pre-wrap;\"><font color=\"#000000\" style=\"\"><span style=\"font-family: Nunito;\">En un curso de algoritmos, variables, tipos de datos y operadores aritméticos se pueden aprender los conceptos fundamentales de la programación y la matemática básica necesaria para programar.</span></font></p><div><br></div>');
INSERT INTO `text_lesson_translations` VALUES (66, 74, 'es', 'Introducción a la programación y a la lógica de programación', 'En una introducción a la programación y a la lógica de programación, se pueden aprender los conceptos básicos de la programación, incluyendo la sintaxis y estructuras de programación, la lógica de programación y la resolución de problemas. También se puede aprender a utilizar un lenguaje de programación como Python para implementar algoritmos y soluciones a problemas de programación.', '<p><span style=\"font-family: Nunito; font-size: 16px; white-space: pre-wrap;\"><font color=\"#000000\">En una introducción a la programación y a la lógica de programación, se pueden aprender los conceptos básicos de la programación, incluyendo la sintaxis y estructuras de programación, la lógica de programación y la resolución de problemas. También se puede aprender a utilizar un lenguaje de programación como Python para implementar algoritmos y soluciones a problemas de programación.</font></span></p>');
INSERT INTO `text_lesson_translations` VALUES (67, 75, 'es', 'Estructuras de control de flujo: condicionales y bucles', 'se enfoca en enseñar las herramientas que se utilizan en la programación para controlar el flujo de un programa. Las estructuras de control de flujo son esenciales para crear programas más sofisticados que puedan tomar decisiones y realizar tareas repetitivas.', '<p>se enfoca en enseñar las herramientas que se utilizan en la programación para controlar el flujo de un programa. Las estructuras de control de flujo son esenciales para crear programas más sofisticados que puedan tomar decisiones y realizar tareas repetitivas.</p>');
INSERT INTO `text_lesson_translations` VALUES (68, 76, 'es', 'Resolución de problemas simples utilizando programación', 'Se pueden aprender técnicas para abordar problemas de programación simples, como identificar y descomponer un problema en tareas más pequeñas y manejables, diseñar y planificar un algoritmo para resolver el problema, y luego implementar el algoritmo utilizando un lenguaje de programación.', '<p>En este curso, se pueden aprender técnicas para abordar problemas de programación simples, como identificar y descomponer un problema en tareas más pequeñas y manejables, diseñar y planificar un algoritmo para resolver el problema, y luego implementar el algoritmo utilizando un lenguaje de programación.</p>');
INSERT INTO `text_lesson_translations` VALUES (69, 77, 'es', 'Introducción a Scratch y sus herramientas de programación visual', 'los estudiantes pueden aprender a utilizar la interfaz gráfica de Scratch para crear animaciones, juegos y aplicaciones interactivas. Se pueden explorar los conceptos básicos de programación, como la secuencia de instrucciones, la estructura de control de flujo y los eventos.', '<p>los estudiantes pueden aprender a utilizar la interfaz gráfica de Scratch para crear animaciones, juegos y aplicaciones interactivas. Se pueden explorar los conceptos básicos de programación, como la secuencia de instrucciones, la estructura de control de flujo y los eventos.</p>');
INSERT INTO `text_lesson_translations` VALUES (70, 78, 'es', 'Creación de proyectos simples con Scratch utilizando bloques y eventos', 'Los estudiantes pueden aprender a utilizar la interfaz de Scratch para crear proyectos simples, como juegos y animaciones, utilizando bloques de programación predefinidos. También pueden aprender a utilizar eventos, como el movimiento del ratón o el teclado, para controlar la interactividad en el proyecto.', '<p>Los estudiantes pueden aprender a utilizar la interfaz de Scratch para crear proyectos simples, como juegos y animaciones, utilizando bloques de programación predefinidos. También pueden aprender a utilizar eventos, como el movimiento del ratón o el teclado, para controlar la interactividad en el proyecto.</p>');
INSERT INTO `text_lesson_translations` VALUES (71, 79, 'es', 'Diseño y programación de juegos interactivos y animaciones', 'Se enfoca en enseñar a los estudiantes cómo crear juegos y animaciones interactivas utilizando herramientas de programación y diseño. En este curso, los estudiantes pueden aprender a utilizar lenguajes de programación, como Scratch o Unity, para crear juegos y animaciones.', '<p>&nbsp;Se enfoca en enseñar a los estudiantes cómo crear juegos y animaciones interactivas utilizando herramientas de programación y diseño. En este curso, los estudiantes pueden aprender a utilizar lenguajes de programación, como Scratch o Unity, para crear juegos y animaciones.</p>');
INSERT INTO `text_lesson_translations` VALUES (72, 80, 'es', 'Introducción a los conceptos de programación orientada a objetos', 'los estudiantes pueden aprender los conceptos básicos de la POO, como la encapsulación, la herencia y el polimorfismo. También pueden aprender a utilizar lenguajes de programación que soportan la POO, como Python.', '<p>&nbsp;los estudiantes pueden aprender los conceptos básicos de la POO, como la encapsulación, la herencia y el polimorfismo. También pueden aprender a utilizar lenguajes de programación que soportan la POO, como Python.</p>');
INSERT INTO `text_lesson_translations` VALUES (73, 81, 'es', 'Introducción a Python y sus características', 'se enfoca en enseñar a los estudiantes los fundamentos del lenguaje de programación Python. Python es un lenguaje de programación de alto nivel, interpretado y con una sintaxis sencilla y fácil de aprender.', '<p>se enfoca en enseñar a los estudiantes los fundamentos del lenguaje de programación Python. Python es un lenguaje de programación de alto nivel, interpretado y con una sintaxis sencilla y fácil de aprender.</p>');
INSERT INTO `text_lesson_translations` VALUES (74, 82, 'es', 'Sintaxis básica y estructuras de datos en Python', 'se enfoca en enseñar a los estudiantes los conceptos fundamentales de la sintaxis y las estructuras de datos en el lenguaje de programación Python.', '<p>se enfoca en enseñar a los estudiantes los conceptos fundamentales de la sintaxis y las estructuras de datos en el lenguaje de programación Python.</p>');
INSERT INTO `text_lesson_translations` VALUES (75, 83, 'es', 'Estructuras de control avanzadas: funciones, listas, diccionarios y tuplas', 'los estudiantes pueden aprender a definir y utilizar funciones en Python para modularizar el código y mejorar la reutilización del mismo. También pueden aprender a utilizar las listas, los diccionarios y las tuplas de manera efectiva para manipular datos en programas complejos.', '<p>los estudiantes pueden aprender a definir y utilizar funciones en Python para modularizar el código y mejorar la reutilización del mismo. También pueden aprender a utilizar las listas, los diccionarios y las tuplas de manera efectiva para manipular datos en programas complejos.</p>');
INSERT INTO `text_lesson_translations` VALUES (76, 84, 'es', 'Creación de programas y proyectos utilizando Python', 'los estudiantes pueden aprender a aplicar los conceptos fundamentales de Python, como la sintaxis, las estructuras de datos y las estructuras de control de flujo, para crear programas y proyectos que resuelvan problemas prácticos. También pueden aprender a utilizar diferentes bibliotecas de Python, como NumPy, Pandas y Matplotlib, para manipular datos y crear visualizaciones.', '<p>los estudiantes pueden aprender a aplicar los conceptos fundamentales de Python, como la sintaxis, las estructuras de datos y las estructuras de control de flujo, para crear programas y proyectos que resuelvan problemas prácticos. También pueden aprender a utilizar diferentes bibliotecas de Python, como NumPy, Pandas y Matplotlib, para manipular datos y crear visualizaciones.</p>');
INSERT INTO `text_lesson_translations` VALUES (77, 85, 'es', 'Introducción a los videojuegos y su historia', 'los estudiantes pueden aprender acerca de la evolución de los videojuegos a lo largo del tiempo, desde sus orígenes hasta la actualidad, y cómo han influido en la cultura popular. También pueden aprender acerca de los diferentes géneros de videojuegos y las técnicas utilizadas para crearlos, así como las diferentes plataformas y dispositivos utilizados para jugarlos.', '<p>los estudiantes pueden aprender acerca de la evolución de los videojuegos a lo largo del tiempo, desde sus orígenes hasta la actualidad, y cómo han influido en la cultura popular. También pueden aprender acerca de los diferentes géneros de videojuegos y las técnicas utilizadas para crearlos, así como las diferentes plataformas y dispositivos utilizados para jugarlos.</p>');
INSERT INTO `text_lesson_translations` VALUES (78, 86, 'es', 'Diseño de juegos: mecánicas, historia y personajes', 'Los estudiantes pueden aprender acerca de los diferentes elementos del diseño de juegos, como la narrativa, las mecánicas de juego y los personajes. También pueden aprender a crear una historia interesante que atraiga a los jugadores y los mantenga involucrados en el juego.', '<p>Los estudiantes pueden aprender acerca de los diferentes elementos del diseño de juegos, como la narrativa, las mecánicas de juego y los personajes. También pueden aprender a crear una historia interesante que atraiga a los jugadores y los mantenga involucrados en el juego.&nbsp;</p>');
INSERT INTO `text_lesson_translations` VALUES (79, 87, 'es', 'Herramientas de desarrollo de videojuegos: Construct, GameMaker Studio, RPG Maker', 'Construct, GameMaker Studio y RPG Maker son herramientas de desarrollo de videojuegos que permiten a los usuarios crear juegos sin la necesidad de tener conocimientos avanzados de programación.', '<p>Construct, GameMaker Studio y RPG Maker son herramientas de desarrollo de videojuegos que permiten a los usuarios crear juegos sin la necesidad de tener conocimientos avanzados de programación.</p>');
INSERT INTO `text_lesson_translations` VALUES (80, 88, 'es', 'Creación de un juego simple utilizando herramientas de desarrollo', 'A través de ejercicios prácticos y proyectos, los estudiantes aprenderán los fundamentos de la creación de juegos, incluyendo el diseño de la mecánica del juego, la creación de assets, la programación del juego, las pruebas y ajustes, y la publicación del juego. Este curso también proporcionará una visión general de las herramientas de desarrollo de videojuegos disponibles, incluyendo Construct, GameMaker Studio y RPG Maker, y enseñará cómo utilizarlos para crear juegos de alta calidad y diversión. Al final del curso, los estudiantes habrán creado su propio juego simple que pueden compartir y jugar con amigos y familiares.', '<p>&nbsp;A través de ejercicios prácticos y proyectos, los estudiantes aprenderán los fundamentos de la creación de juegos, incluyendo el diseño de la mecánica del juego, la creación de assets, la programación del juego, las pruebas y ajustes, y la publicación del juego. Este curso también proporcionará una visión general de las herramientas de desarrollo de videojuegos disponibles, incluyendo Construct, GameMaker Studio y RPG Maker, y enseñará cómo utilizarlos para crear juegos de alta calidad y diversión. Al final del curso, los estudiantes habrán creado su propio juego simple que pueden compartir y jugar con amigos y familiares.</p>');
INSERT INTO `text_lesson_translations` VALUES (81, 89, 'es', 'Introducción al desarrollo web: HTML, CSS, JavaScript', 'El curso de Introducción al desarrollo web: HTML, CSS, JavaScript está diseñado para enseñar a los estudiantes los fundamentos del desarrollo web, incluyendo la creación de páginas web utilizando HTML y CSS, y la adición de interactividad y dinamismo utilizando JavaScript.', '<p>El curso de Introducción al desarrollo web: HTML, CSS, JavaScript está diseñado para enseñar a los estudiantes los fundamentos del desarrollo web, incluyendo la creación de páginas web utilizando HTML y CSS, y la adición de interactividad y dinamismo utilizando JavaScript.&nbsp;</p>');
INSERT INTO `text_lesson_translations` VALUES (82, 90, 'es', 'Creación de sitios web básicos utilizando herramientas de desarrollo web', 'A través de ejercicios prácticos y proyectos, los estudiantes aprenderán a crear páginas web con diferentes diseños, formatos y contenido, utilizando las herramientas de desarrollo web más comunes como editores de código y herramientas de diseño. También se enseñarán conceptos básicos de diseño web y UX, y cómo aplicarlos a los proyectos de creación de sitios web.', '<p>A través de ejercicios prácticos y proyectos, los estudiantes aprenderán a crear páginas web con diferentes diseños, formatos y contenido, utilizando las herramientas de desarrollo web más comunes como editores de código y herramientas de diseño. También se enseñarán conceptos básicos de diseño web y UX, y cómo aplicarlos a los proyectos de creación de sitios web.</p>');
INSERT INTO `text_lesson_translations` VALUES (83, 91, 'es', 'Introducción al diseño UX/UI y experiencia de usuario en sitios web', 'El curso de Introducción al diseño UX/UI y experiencia de usuario en sitios web está diseñado para enseñar a los estudiantes los fundamentos del diseño de experiencias de usuario efectivas y atractivas en sitios web. Los estudiantes aprenderán sobre los principios del diseño UX/UI y cómo aplicarlos a la creación de sitios web para mejorar la experiencia del usuario.', '<p>El curso de Introducción al diseño UX/UI y experiencia de usuario en sitios web está diseñado para enseñar a los estudiantes los fundamentos del diseño de experiencias de usuario efectivas y atractivas en sitios web. Los estudiantes aprenderán sobre los principios del diseño UX/UI y cómo aplicarlos a la creación de sitios web para mejorar la experiencia del usuario.</p>');
INSERT INTO `text_lesson_translations` VALUES (84, 92, 'es', 'Creación de sitios web interactivos con JavaScript y bibliotecas de código abierto', 'Los estudiantes aprenderán los conceptos básicos de JavaScript, como variables, operadores, funciones y bucles, y cómo utilizarlos para crear interacciones en una página web. También se presentarán diferentes bibliotecas de código abierto, como jQuery y React, y se enseñará cómo utilizarlas para mejorar la funcionalidad y la interactividad de un sitio web.', '<p>Los estudiantes aprenderán los conceptos básicos de JavaScript, como variables, operadores, funciones y bucles, y cómo utilizarlos para crear interacciones en una página web. También se presentarán diferentes bibliotecas de código abierto, como jQuery y React, y se enseñará cómo utilizarlas para mejorar la funcionalidad y la interactividad de un sitio web.</p>');
INSERT INTO `text_lesson_translations` VALUES (85, 93, 'es', 'Introducción a juegos educativos como Minecraft, Roblox, Kodu, etc.', 'los estudiantes aprenderán sobre los diferentes juegos educativos disponibles y cómo se utilizan en diferentes entornos educativos, desde el aula hasta la formación en línea. Se les enseñará cómo crear experiencias de juego educativas, utilizando herramientas como Minecraft, Roblox, Kodu y otros programas similares.', '<p>los estudiantes aprenderán sobre los diferentes juegos educativos disponibles y cómo se utilizan en diferentes entornos educativos, desde el aula hasta la formación en línea. Se les enseñará cómo crear experiencias de juego educativas, utilizando herramientas como Minecraft, Roblox, Kodu y otros programas similares.</p>');
INSERT INTO `text_lesson_translations` VALUES (86, 94, 'es', 'Diseño y programación de juegos educativos utilizando herramientas de programación de juegos', 'Los estudiantes aprenderán sobre las diferentes herramientas de programación de juegos disponibles, y cómo utilizarlas para crear juegos educativos. Aprenderán a programar personajes y objetos en el juego, cómo agregar actividades educativas en el juego, y cómo crear mundos virtuales y misiones.', '<p>Los estudiantes aprenderán sobre las diferentes herramientas de programación de juegos disponibles, y cómo utilizarlas para crear juegos educativos. Aprenderán a programar personajes y objetos en el juego, cómo agregar actividades educativas en el juego, y cómo crear mundos virtuales y misiones.</p>');
INSERT INTO `text_lesson_translations` VALUES (87, 95, 'es', 'Creación de juegos educativos interactivos y actividades basadas en la temática educativa', 'Los estudiantes aprenderán sobre los diferentes tipos de juegos educativos y cómo seleccionar el formato y el enfoque adecuados para diferentes temas y audiencias. Aprenderán a programar personajes y objetos en el juego, cómo agregar actividades educativas en el juego, y cómo crear mundos virtuales y misiones.', '<p>Los estudiantes aprenderán sobre los diferentes tipos de juegos educativos y cómo seleccionar el formato y el enfoque adecuados para diferentes temas y audiencias. Aprenderán a programar personajes y objetos en el juego, cómo agregar actividades educativas en el juego, y cómo crear mundos virtuales y misiones.</p>');
INSERT INTO `text_lesson_translations` VALUES (88, 96, 'es', 'Desarrollo de un proyecto final basado en las habilidades y conceptos aprendidos en el curso', 'En este proyecto, los estudiantes tendrán la oportunidad de aplicar los conceptos y habilidades que han aprendido durante el curso para crear un juego educativo interactivo completo.', '<p>En este proyecto, los estudiantes tendrán la oportunidad de aplicar los conceptos y habilidades que han aprendido durante el curso para crear un juego educativo interactivo completo.</p>');
INSERT INTO `text_lesson_translations` VALUES (89, 97, 'es', 'Presentación del proyecto final y retroalimentación', 'Es en esta etapa donde los estudiantes tienen la oportunidad de mostrar lo que han aprendido y cómo han aplicado sus habilidades y conocimientos en la creación de un juego educativo interactivo.', '<p>&nbsp;Es en esta etapa donde los estudiantes tienen la oportunidad de mostrar lo que han aprendido y cómo han aplicado sus habilidades y conocimientos en la creación de un juego educativo interactivo.</p>');

-- ----------------------------
-- Table structure for text_lessons
-- ----------------------------
DROP TABLE IF EXISTS `text_lessons`;
CREATE TABLE `text_lessons`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `creator_id` int UNSIGNED NOT NULL,
  `webinar_id` int UNSIGNED NOT NULL,
  `chapter_id` int UNSIGNED NULL DEFAULT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `study_time` int UNSIGNED NULL DEFAULT NULL,
  `accessibility` enum('free','paid') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'free',
  `check_previous_parts` tinyint(1) NOT NULL DEFAULT 0,
  `access_after_day` int UNSIGNED NULL DEFAULT NULL,
  `order` int UNSIGNED NULL DEFAULT NULL,
  `status` enum('active','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `created_at` int UNSIGNED NOT NULL,
  `updated_at` int UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `text_lessons_creator_id_foreign`(`creator_id`) USING BTREE,
  INDEX `text_lessons_webinar_id_foreign`(`webinar_id`) USING BTREE,
  INDEX `text_lessons_chapter_id_foreign`(`chapter_id`) USING BTREE,
  CONSTRAINT `text_lessons_chapter_id_foreign` FOREIGN KEY (`chapter_id`) REFERENCES `webinar_chapters` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `text_lessons_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `text_lessons_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 192 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of text_lessons
-- ----------------------------
INSERT INTO `text_lessons` VALUES (22, 1055, 2025, 43, '/store/1/default_images/categories_icons/code.png', 30, 'paid', 0, NULL, 2, 'active', 1681335172, NULL);
INSERT INTO `text_lessons` VALUES (23, 1055, 2025, 43, '/store/1/default_images/categories_icons/code.png', 60, 'paid', 0, NULL, 3, 'active', 1681335284, NULL);
INSERT INTO `text_lessons` VALUES (24, 1055, 2025, 43, '/store/1/default_images/categories_icons/code.png', 60, 'paid', 0, NULL, 4, 'active', 1681335386, 1681335668);
INSERT INTO `text_lessons` VALUES (25, 1055, 2025, 43, '/store/1/default_images/categories_icons/code.png', 60, 'paid', 0, NULL, 5, 'active', 1681335890, 1681335915);
INSERT INTO `text_lessons` VALUES (26, 1055, 2025, 43, '/store/1/default_images/categories_icons/code.png', 60, 'paid', 0, NULL, 6, 'active', 1681336085, NULL);
INSERT INTO `text_lessons` VALUES (27, 1055, 2025, 44, '/store/1/default_images/categories_icons/code.png', 60, 'paid', 0, NULL, 7, 'active', 1681336369, 1681338257);
INSERT INTO `text_lessons` VALUES (28, 1055, 2025, 45, '/store/1/default_images/categories_icons/code.png', 60, 'paid', 0, NULL, 8, 'active', 1681336501, NULL);
INSERT INTO `text_lessons` VALUES (29, 1055, 2025, 45, '/store/1/default_images/categories_icons/code.png', 60, 'free', 0, NULL, 9, 'active', 1681336569, NULL);
INSERT INTO `text_lessons` VALUES (30, 1055, 2025, 45, '/store/1/default_images/categories_icons/code.png', 60, 'paid', 0, NULL, 10, 'active', 1681336654, NULL);
INSERT INTO `text_lessons` VALUES (31, 1055, 2025, 46, '/store/1/default_images/categories_icons/code.png', 60, 'paid', 0, NULL, 11, 'active', 1681336779, 1681336842);
INSERT INTO `text_lessons` VALUES (32, 1055, 2025, 46, '/store/1/default_images/categories_icons/code.png', 60, 'paid', 0, NULL, 12, 'active', 1681336906, 1681336939);
INSERT INTO `text_lessons` VALUES (33, 1055, 2025, 46, '/store/1/default_images/categories_icons/code.png', 60, 'paid', 0, NULL, 13, 'active', 1681337005, NULL);
INSERT INTO `text_lessons` VALUES (34, 1055, 2025, 47, '/store/1/default_images/categories_icons/code.png', 60, 'free', 0, NULL, 14, 'active', 1681337142, NULL);
INSERT INTO `text_lessons` VALUES (35, 1055, 2025, 48, '/store/1/default_images/categories_icons/code.png', 60, 'free', 0, NULL, 15, 'active', 1681337220, NULL);
INSERT INTO `text_lessons` VALUES (36, 1055, 2025, 42, '/store/1/default_images/categories_icons/code.png', 60, 'paid', 0, NULL, 15, 'active', 1681337335, NULL);
INSERT INTO `text_lessons` VALUES (37, 1055, 2025, 42, '/store/1/default_images/categories_icons/code.png', 60, 'paid', 0, NULL, 16, 'active', 1681337432, NULL);
INSERT INTO `text_lessons` VALUES (38, 1055, 2025, 42, '/store/1/default_images/categories_icons/code.png', 60, 'free', 0, NULL, 17, 'active', 1681337489, NULL);
INSERT INTO `text_lessons` VALUES (39, 1055, 2025, 42, '/store/1/default_images/categories_icons/code.png', 60, 'paid', 0, NULL, 18, 'active', 1681337558, 1681337637);
INSERT INTO `text_lessons` VALUES (40, 1055, 2025, 42, '/store/1/default_images/categories_icons/code.png', 60, 'paid', 0, NULL, 19, 'active', 1681337694, NULL);
INSERT INTO `text_lessons` VALUES (41, 1055, 2025, 42, '/store/1/default_images/categories_icons/code.png', 60, 'paid', 0, NULL, 20, 'active', 1681337752, NULL);
INSERT INTO `text_lessons` VALUES (42, 1055, 2025, 42, '/store/1/default_images/categories_icons/code.png', 60, 'paid', 0, NULL, 21, 'active', 1681337805, NULL);
INSERT INTO `text_lessons` VALUES (43, 1055, 2025, 42, '/store/1/default_images/categories_icons/code.png', 60, 'paid', 0, NULL, 22, 'active', 1681337860, NULL);
INSERT INTO `text_lessons` VALUES (44, 1055, 2025, 42, '/store/1/default_images/categories_icons/code.png', 60, 'paid', 0, NULL, 23, 'active', 1681337908, NULL);
INSERT INTO `text_lessons` VALUES (45, 1016, 2026, 49, '/store/1/react-lenguaje-01.jpg', 195, 'paid', 0, NULL, 1, 'active', 1681481218, 1681493408);
INSERT INTO `text_lessons` VALUES (46, 1016, 2026, 49, '/store/1/react-lenguaje-01.jpg', 195, 'paid', 0, NULL, 2, 'active', 1681481511, 1681493477);
INSERT INTO `text_lessons` VALUES (47, 1016, 2026, 49, '/store/1/react-lenguaje-01.jpg', 195, 'paid', 0, NULL, 3, 'active', 1681481682, 1681493494);
INSERT INTO `text_lessons` VALUES (48, 1016, 2026, 49, '/store/1/react-lenguaje-01.jpg', 215, 'paid', 0, NULL, 4, 'active', 1681481886, 1681493518);
INSERT INTO `text_lessons` VALUES (49, 1016, 2026, 50, '/store/1/react-lenguaje-01.jpg', 195, 'paid', 0, NULL, 5, 'active', 1681482096, 1681493534);
INSERT INTO `text_lessons` VALUES (50, 1016, 2026, 50, '/store/1/react-lenguaje-01.jpg', 195, 'paid', 0, NULL, 6, 'active', 1681482284, 1681497361);
INSERT INTO `text_lessons` VALUES (51, 1016, 2026, 50, '/store/1/react-lenguaje-01.jpg', 195, 'paid', 0, NULL, 7, 'active', 1681482450, 1681497380);
INSERT INTO `text_lessons` VALUES (52, 1016, 2026, 50, '/store/1/react-lenguaje-01.jpg', 215, 'paid', 0, NULL, 8, 'active', 1681482606, 1681497401);
INSERT INTO `text_lessons` VALUES (53, 1016, 2026, 51, '/store/1/react-lenguaje-01.jpg', 195, 'paid', 0, NULL, 9, 'active', 1681482843, 1681518729);
INSERT INTO `text_lessons` VALUES (54, 1016, 2026, 51, '/store/1/react-lenguaje-01.jpg', 195, 'paid', 0, NULL, 10, 'active', 1681483001, 1681497449);
INSERT INTO `text_lessons` VALUES (55, 1016, 2026, 51, '/store/1/react-lenguaje-01.jpg', 195, 'paid', 0, NULL, 11, 'active', 1681483191, 1681497466);
INSERT INTO `text_lessons` VALUES (56, 1016, 2026, 51, '/store/1/react-lenguaje-01.jpg', 215, 'paid', 0, NULL, 12, 'active', 1681483331, 1681497485);
INSERT INTO `text_lessons` VALUES (57, 1016, 2026, 52, '/store/1/react-lenguaje-01.jpg', 260, 'paid', 0, NULL, 13, 'active', 1681483482, 1681497511);
INSERT INTO `text_lessons` VALUES (58, 1016, 2026, 52, '/store/1/react-lenguaje-01.jpg', 260, 'paid', 0, NULL, 14, 'active', 1681483570, 1681497523);
INSERT INTO `text_lessons` VALUES (59, 1016, 2026, 52, '/store/1/react-lenguaje-01.jpg', 280, 'paid', 0, NULL, 15, 'active', 1681483881, 1681497534);
INSERT INTO `text_lessons` VALUES (60, 1016, 2026, 53, '/store/1/react-lenguaje-01.jpg', 195, 'paid', 0, NULL, 16, 'active', 1681484200, 1681497573);
INSERT INTO `text_lessons` VALUES (61, 1016, 2026, 53, '/store/1/react-lenguaje-01.jpg', 195, 'paid', 0, NULL, 17, 'active', 1681484305, 1681497584);
INSERT INTO `text_lessons` VALUES (62, 1016, 2026, 53, '/store/1/react-lenguaje-01.jpg', 195, 'paid', 0, NULL, 18, 'active', 1681484431, 1681497598);
INSERT INTO `text_lessons` VALUES (63, 1016, 2026, 53, '/store/1/react-lenguaje-01.jpg', 215, 'paid', 0, NULL, 19, 'active', 1681484661, 1681497614);
INSERT INTO `text_lessons` VALUES (64, 1016, 2026, 54, '/store/1/react-lenguaje-01.jpg', 90, 'paid', 0, NULL, 20, 'active', 1681485012, 1681497633);
INSERT INTO `text_lessons` VALUES (65, 1016, 2026, 54, '/store/1/react-lenguaje-01.jpg', 90, 'paid', 0, NULL, 21, 'active', 1681485157, 1681497653);
INSERT INTO `text_lessons` VALUES (66, 1016, 2026, 54, '/store/1/react-lenguaje-01.jpg', 90, 'paid', 0, NULL, 22, 'active', 1681485348, 1681497679);
INSERT INTO `text_lessons` VALUES (67, 1016, 2026, 54, '/store/1/react-lenguaje-01.jpg', 90, 'paid', 0, NULL, 23, 'active', 1681485538, 1681497699);
INSERT INTO `text_lessons` VALUES (68, 1016, 2026, 54, '/store/1/react-lenguaje-01.jpg', 90, 'paid', 0, NULL, 24, 'active', 1681485708, 1681497716);
INSERT INTO `text_lessons` VALUES (69, 1016, 2026, 54, '/store/1/react-lenguaje-01.jpg', 90, 'paid', 0, NULL, 25, 'active', 1681485935, 1681497734);
INSERT INTO `text_lessons` VALUES (70, 1016, 2026, 54, '/store/1/react-lenguaje-01.jpg', 90, 'paid', 0, NULL, 26, 'active', 1681486116, 1681497751);
INSERT INTO `text_lessons` VALUES (71, 1016, 2026, 54, '/store/1/react-lenguaje-01.jpg', 90, 'paid', 0, NULL, 27, 'active', 1681486331, 1681497767);
INSERT INTO `text_lessons` VALUES (72, 1016, 2026, 54, '/store/1/react-lenguaje-01.jpg', 80, 'paid', 0, NULL, 28, 'active', 1681486522, 1681497778);
INSERT INTO `text_lessons` VALUES (73, 1016, 2027, 55, '/store/1/programación pa niños_Mesa de trabajo 1 copia.png', 60, 'free', 0, NULL, 1, 'active', 1683249054, NULL);
INSERT INTO `text_lessons` VALUES (74, 1016, 2027, 55, '/store/1/programación pa niños_Mesa de trabajo 1 copia.png', 60, 'free', 0, NULL, 2, 'active', 1683249119, NULL);
INSERT INTO `text_lessons` VALUES (75, 1016, 2027, 55, '/store/1/programación pa niños_Mesa de trabajo 1 copia.png', 60, 'free', 0, NULL, 3, 'active', 1683249183, NULL);
INSERT INTO `text_lessons` VALUES (76, 1016, 2027, 55, '/store/1/programación pa niños_Mesa de trabajo 1 copia.png', 60, 'free', 0, NULL, 4, 'active', 1683249342, NULL);
INSERT INTO `text_lessons` VALUES (77, 1016, 2027, 56, '/store/1/programación pa niños_Mesa de trabajo 1 copia.png', 60, 'free', 0, NULL, 5, 'active', 1683249452, NULL);
INSERT INTO `text_lessons` VALUES (78, 1016, 2027, 56, '/store/1/programación pa niños_Mesa de trabajo 1 copia.png', 60, 'free', 0, NULL, 6, 'active', 1683249536, NULL);
INSERT INTO `text_lessons` VALUES (79, 1016, 2027, 56, '/store/1/programación pa niños_Mesa de trabajo 1 copia.png', 60, 'free', 0, NULL, 7, 'active', 1683249610, NULL);
INSERT INTO `text_lessons` VALUES (80, 1016, 2027, 56, '/store/1/programación pa niños_Mesa de trabajo 1 copia.png', 60, 'free', 0, NULL, 8, 'active', 1683249674, NULL);
INSERT INTO `text_lessons` VALUES (81, 1016, 2027, 57, '/store/1/programación pa niños_Mesa de trabajo 1 copia.png', 60, 'free', 0, NULL, 9, 'active', 1683250022, NULL);
INSERT INTO `text_lessons` VALUES (82, 1016, 2027, 57, '/store/1/programación pa niños_Mesa de trabajo 1 copia.png', 60, 'free', 0, NULL, 10, 'active', 1683250137, NULL);
INSERT INTO `text_lessons` VALUES (83, 1016, 2027, 57, '/store/1/programación pa niños_Mesa de trabajo 1 copia.png', 60, 'free', 0, NULL, 11, 'active', 1683250392, NULL);
INSERT INTO `text_lessons` VALUES (84, 1016, 2027, 57, '/store/1/programación pa niños_Mesa de trabajo 1 copia.png', 60, 'free', 0, NULL, 12, 'active', 1683250445, NULL);
INSERT INTO `text_lessons` VALUES (85, 1016, 2027, 58, '/store/1/programación pa niños_Mesa de trabajo 1 copia.png', 60, 'free', 0, NULL, 13, 'active', 1683250877, NULL);
INSERT INTO `text_lessons` VALUES (86, 1016, 2027, 58, '/store/1/programación pa niños_Mesa de trabajo 1 copia.png', 60, 'free', 0, NULL, 14, 'active', 1683250966, NULL);
INSERT INTO `text_lessons` VALUES (87, 1016, 2027, 58, '/store/1/programación pa niños_Mesa de trabajo 1 copia.png', 60, 'free', 0, NULL, 15, 'active', 1683251053, NULL);
INSERT INTO `text_lessons` VALUES (88, 1016, 2027, 58, '/store/1/programación pa niños_Mesa de trabajo 1 copia.png', 60, 'free', 0, NULL, 16, 'active', 1683251252, NULL);
INSERT INTO `text_lessons` VALUES (89, 1016, 2027, 59, '/store/1/programación pa niños_Mesa de trabajo 1 copia.png', 60, 'free', 0, NULL, 17, 'active', 1683251351, NULL);
INSERT INTO `text_lessons` VALUES (90, 1016, 2027, 59, '/store/1/programación pa niños_Mesa de trabajo 1 copia.png', 60, 'free', 0, NULL, 18, 'active', 1683251528, NULL);
INSERT INTO `text_lessons` VALUES (91, 1016, 2027, 59, '/store/1/programación pa niños_Mesa de trabajo 1 copia.png', 60, 'free', 0, NULL, 19, 'active', 1683251618, NULL);
INSERT INTO `text_lessons` VALUES (92, 1016, 2027, 59, '/store/1/programación pa niños_Mesa de trabajo 1 copia.png', 60, 'free', 0, NULL, 20, 'active', 1683251819, NULL);
INSERT INTO `text_lessons` VALUES (93, 1016, 2027, 60, '/store/1/programación pa niños_Mesa de trabajo 1 copia.png', 60, 'free', 0, NULL, 21, 'active', 1683251915, NULL);
INSERT INTO `text_lessons` VALUES (94, 1016, 2027, 60, '/store/1/programación pa niños_Mesa de trabajo 1 copia.png', 60, 'free', 0, NULL, 22, 'active', 1683251969, NULL);
INSERT INTO `text_lessons` VALUES (95, 1016, 2027, 60, '/store/1/programación pa niños_Mesa de trabajo 1 copia.png', 60, 'free', 0, NULL, 23, 'active', 1683252086, NULL);
INSERT INTO `text_lessons` VALUES (96, 1016, 2027, 61, '/store/1/programación pa niños_Mesa de trabajo 1 copia.png', 60, 'free', 0, NULL, 24, 'active', 1683252172, NULL);
INSERT INTO `text_lessons` VALUES (97, 1016, 2027, 61, '/store/1/programación pa niños_Mesa de trabajo 1 copia.png', 60, 'free', 0, NULL, 25, 'active', 1683252236, NULL);

-- ----------------------------
-- Table structure for text_lessons_attachments
-- ----------------------------
DROP TABLE IF EXISTS `text_lessons_attachments`;
CREATE TABLE `text_lessons_attachments`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `text_lesson_id` int UNSIGNED NOT NULL,
  `file_id` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `text_lessons_attachments_text_lesson_id_foreign`(`text_lesson_id`) USING BTREE,
  INDEX `text_lessons_attachments_file_id_foreign`(`file_id`) USING BTREE,
  CONSTRAINT `text_lessons_attachments_file_id_foreign` FOREIGN KEY (`file_id`) REFERENCES `files` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `text_lessons_attachments_text_lesson_id_foreign` FOREIGN KEY (`text_lesson_id`) REFERENCES `text_lessons` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 31 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of text_lessons_attachments
-- ----------------------------

-- ----------------------------
-- Table structure for ticket_translations
-- ----------------------------
DROP TABLE IF EXISTS `ticket_translations`;
CREATE TABLE `ticket_translations`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `ticket_id` int UNSIGNED NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ticket_translations_ticket_id_foreign`(`ticket_id`) USING BTREE,
  INDEX `ticket_translations_locale_index`(`locale`) USING BTREE,
  CONSTRAINT `ticket_translations_ticket_id_foreign` FOREIGN KEY (`ticket_id`) REFERENCES `tickets` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 27 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ticket_translations
-- ----------------------------

-- ----------------------------
-- Table structure for ticket_users
-- ----------------------------
DROP TABLE IF EXISTS `ticket_users`;
CREATE TABLE `ticket_users`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `ticket_id` int UNSIGNED NOT NULL,
  `user_id` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ticket_users_ticket_id_foreign`(`ticket_id`) USING BTREE,
  INDEX `ticket_users_user_id_foreign`(`user_id`) USING BTREE,
  CONSTRAINT `ticket_users_ticket_id_foreign` FOREIGN KEY (`ticket_id`) REFERENCES `tickets` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `ticket_users_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ticket_users
-- ----------------------------

-- ----------------------------
-- Table structure for tickets
-- ----------------------------
DROP TABLE IF EXISTS `tickets`;
CREATE TABLE `tickets`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `creator_id` int UNSIGNED NOT NULL,
  `webinar_id` int UNSIGNED NULL DEFAULT NULL,
  `bundle_id` int UNSIGNED NULL DEFAULT NULL,
  `start_date` int UNSIGNED NULL DEFAULT NULL,
  `end_date` int UNSIGNED NULL DEFAULT NULL,
  `discount` int NOT NULL,
  `capacity` int NULL DEFAULT NULL,
  `order` int UNSIGNED NULL DEFAULT NULL,
  `created_at` int NOT NULL,
  `updated_at` int NULL DEFAULT NULL,
  `deleted_at` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `tickets_webinar_id_foreign`(`webinar_id`) USING BTREE,
  INDEX `tickets_creator_id_foreign`(`creator_id`) USING BTREE,
  INDEX `tickets_bundle_id_foreign`(`bundle_id`) USING BTREE,
  CONSTRAINT `tickets_bundle_id_foreign` FOREIGN KEY (`bundle_id`) REFERENCES `bundles` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `tickets_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `tickets_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 40 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tickets
-- ----------------------------

-- ----------------------------
-- Table structure for trend_categories
-- ----------------------------
DROP TABLE IF EXISTS `trend_categories`;
CREATE TABLE `trend_categories`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `category_id` int UNSIGNED NOT NULL,
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `color` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `trend_categories_category_id_index`(`category_id`) USING BTREE,
  CONSTRAINT `trend_categories_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of trend_categories
-- ----------------------------

-- ----------------------------
-- Table structure for upcoming_course_filter_option
-- ----------------------------
DROP TABLE IF EXISTS `upcoming_course_filter_option`;
CREATE TABLE `upcoming_course_filter_option`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `upcoming_course_id` int UNSIGNED NOT NULL,
  `filter_option_id` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `upcoming_course_filter_option_upcoming_course_id_foreign`(`upcoming_course_id`) USING BTREE,
  INDEX `upcoming_course_filter_option_filter_option_id_foreign`(`filter_option_id`) USING BTREE,
  CONSTRAINT `upcoming_course_filter_option_filter_option_id_foreign` FOREIGN KEY (`filter_option_id`) REFERENCES `filter_options` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `upcoming_course_filter_option_upcoming_course_id_foreign` FOREIGN KEY (`upcoming_course_id`) REFERENCES `upcoming_courses` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 53 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of upcoming_course_filter_option
-- ----------------------------

-- ----------------------------
-- Table structure for upcoming_course_followers
-- ----------------------------
DROP TABLE IF EXISTS `upcoming_course_followers`;
CREATE TABLE `upcoming_course_followers`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `upcoming_course_id` int UNSIGNED NOT NULL,
  `user_id` int UNSIGNED NOT NULL,
  `created_at` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `upcoming_course_followers_upcoming_course_id_foreign`(`upcoming_course_id`) USING BTREE,
  INDEX `upcoming_course_followers_user_id_foreign`(`user_id`) USING BTREE,
  CONSTRAINT `upcoming_course_followers_upcoming_course_id_foreign` FOREIGN KEY (`upcoming_course_id`) REFERENCES `upcoming_courses` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `upcoming_course_followers_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of upcoming_course_followers
-- ----------------------------

-- ----------------------------
-- Table structure for upcoming_course_reports
-- ----------------------------
DROP TABLE IF EXISTS `upcoming_course_reports`;
CREATE TABLE `upcoming_course_reports`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `upcoming_course_id` int UNSIGNED NOT NULL,
  `user_id` int UNSIGNED NOT NULL,
  `reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `upcoming_course_reports_upcoming_course_id_foreign`(`upcoming_course_id`) USING BTREE,
  INDEX `upcoming_course_reports_user_id_foreign`(`user_id`) USING BTREE,
  CONSTRAINT `upcoming_course_reports_upcoming_course_id_foreign` FOREIGN KEY (`upcoming_course_id`) REFERENCES `upcoming_courses` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `upcoming_course_reports_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of upcoming_course_reports
-- ----------------------------

-- ----------------------------
-- Table structure for upcoming_course_translations
-- ----------------------------
DROP TABLE IF EXISTS `upcoming_course_translations`;
CREATE TABLE `upcoming_course_translations`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `upcoming_course_id` int UNSIGNED NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `seo_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `upcoming_course_translations_upcoming_course_id_foreign`(`upcoming_course_id`) USING BTREE,
  INDEX `upcoming_course_translations_locale_index`(`locale`) USING BTREE,
  CONSTRAINT `upcoming_course_translations_upcoming_course_id_foreign` FOREIGN KEY (`upcoming_course_id`) REFERENCES `upcoming_courses` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of upcoming_course_translations
-- ----------------------------

-- ----------------------------
-- Table structure for upcoming_courses
-- ----------------------------
DROP TABLE IF EXISTS `upcoming_courses`;
CREATE TABLE `upcoming_courses`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `creator_id` int UNSIGNED NOT NULL,
  `teacher_id` int UNSIGNED NOT NULL,
  `category_id` int UNSIGNED NULL DEFAULT NULL,
  `webinar_id` int UNSIGNED NULL DEFAULT NULL COMMENT 'when assigned a course',
  `type` enum('webinar','course','text_lesson') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `thumbnail` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `image_cover` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `video_demo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `video_demo_source` enum('upload','youtube','vimeo','external_link') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `publish_date` bigint UNSIGNED NULL DEFAULT NULL,
  `timezone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `points` int UNSIGNED NULL DEFAULT NULL,
  `capacity` int UNSIGNED NULL DEFAULT NULL,
  `price` double(15, 2) NULL DEFAULT NULL,
  `duration` int UNSIGNED NULL DEFAULT NULL,
  `sections` int UNSIGNED NULL DEFAULT NULL,
  `parts` int UNSIGNED NULL DEFAULT NULL,
  `course_progress` int UNSIGNED NULL DEFAULT NULL,
  `support` tinyint(1) NOT NULL DEFAULT 0,
  `certificate` tinyint(1) NOT NULL DEFAULT 0,
  `include_quizzes` tinyint(1) NOT NULL DEFAULT 0,
  `downloadable` tinyint(1) NOT NULL DEFAULT 0,
  `forum` tinyint(1) NOT NULL DEFAULT 0,
  `message_for_reviewer` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `status` enum('active','pending','is_draft','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'is_draft',
  `created_at` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `upcoming_courses_slug_unique`(`slug`) USING BTREE,
  INDEX `upcoming_courses_creator_id_foreign`(`creator_id`) USING BTREE,
  INDEX `upcoming_courses_teacher_id_foreign`(`teacher_id`) USING BTREE,
  INDEX `upcoming_courses_category_id_foreign`(`category_id`) USING BTREE,
  INDEX `upcoming_courses_webinar_id_foreign`(`webinar_id`) USING BTREE,
  CONSTRAINT `upcoming_courses_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `upcoming_courses_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `upcoming_courses_teacher_id_foreign` FOREIGN KEY (`teacher_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `upcoming_courses_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of upcoming_courses
-- ----------------------------

-- ----------------------------
-- Table structure for user_bank_specification_translations
-- ----------------------------
DROP TABLE IF EXISTS `user_bank_specification_translations`;
CREATE TABLE `user_bank_specification_translations`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_bank_specification_id` int UNSIGNED NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_bank_specification_id`(`user_bank_specification_id`) USING BTREE,
  INDEX `user_bank_specification_translations_locale_index`(`locale`) USING BTREE,
  CONSTRAINT `user_bank_specification_id` FOREIGN KEY (`user_bank_specification_id`) REFERENCES `user_bank_specifications` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_bank_specification_translations
-- ----------------------------
INSERT INTO `user_bank_specification_translations` VALUES (15, 10, 'en', 'Account Holder');
INSERT INTO `user_bank_specification_translations` VALUES (16, 11, 'en', 'Email');
INSERT INTO `user_bank_specification_translations` VALUES (17, 12, 'en', 'Account Holder');
INSERT INTO `user_bank_specification_translations` VALUES (18, 13, 'en', 'Account ID');

-- ----------------------------
-- Table structure for user_bank_specifications
-- ----------------------------
DROP TABLE IF EXISTS `user_bank_specifications`;
CREATE TABLE `user_bank_specifications`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_bank_id` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_bank_specifications_user_bank_id_foreign`(`user_bank_id`) USING BTREE,
  CONSTRAINT `user_bank_specifications_user_bank_id_foreign` FOREIGN KEY (`user_bank_id`) REFERENCES `user_banks` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_bank_specifications
-- ----------------------------
INSERT INTO `user_bank_specifications` VALUES (10, 4);
INSERT INTO `user_bank_specifications` VALUES (11, 4);
INSERT INTO `user_bank_specifications` VALUES (12, 5);
INSERT INTO `user_bank_specifications` VALUES (13, 5);

-- ----------------------------
-- Table structure for user_bank_translations
-- ----------------------------
DROP TABLE IF EXISTS `user_bank_translations`;
CREATE TABLE `user_bank_translations`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_bank_id` int UNSIGNED NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_bank_translations_user_bank_id_foreign`(`user_bank_id`) USING BTREE,
  INDEX `user_bank_translations_locale_index`(`locale`) USING BTREE,
  CONSTRAINT `user_bank_translations_user_bank_id_foreign` FOREIGN KEY (`user_bank_id`) REFERENCES `user_banks` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_bank_translations
-- ----------------------------
INSERT INTO `user_bank_translations` VALUES (6, 4, 'en', 'Paypal');
INSERT INTO `user_bank_translations` VALUES (7, 5, 'en', 'Stripe');

-- ----------------------------
-- Table structure for user_banks
-- ----------------------------
DROP TABLE IF EXISTS `user_banks`;
CREATE TABLE `user_banks`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `logo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_banks
-- ----------------------------
INSERT INTO `user_banks` VALUES (4, '/store/1/default_images/payment gateways/paypal.png', 1678874235);
INSERT INTO `user_banks` VALUES (5, '/store/1/default_images/payment gateways/stripe.png', 1679090196);

-- ----------------------------
-- Table structure for user_selected_bank_specifications
-- ----------------------------
DROP TABLE IF EXISTS `user_selected_bank_specifications`;
CREATE TABLE `user_selected_bank_specifications`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_selected_bank_id` int UNSIGNED NOT NULL,
  `user_bank_specification_id` int UNSIGNED NOT NULL,
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_selected_bank_id_specifications`(`user_selected_bank_id`) USING BTREE,
  INDEX `user_bank_specification_id_specifications`(`user_bank_specification_id`) USING BTREE,
  CONSTRAINT `user_bank_specification_id_specifications` FOREIGN KEY (`user_bank_specification_id`) REFERENCES `user_bank_specifications` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `user_selected_bank_id_specifications` FOREIGN KEY (`user_selected_bank_id`) REFERENCES `user_selected_banks` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_selected_bank_specifications
-- ----------------------------

-- ----------------------------
-- Table structure for user_selected_banks
-- ----------------------------
DROP TABLE IF EXISTS `user_selected_banks`;
CREATE TABLE `user_selected_banks`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int UNSIGNED NOT NULL,
  `user_bank_id` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_selected_banks_user_bank_id_foreign`(`user_bank_id`) USING BTREE,
  INDEX `user_selected_banks_user_id_foreign`(`user_id`) USING BTREE,
  CONSTRAINT `user_selected_banks_user_bank_id_foreign` FOREIGN KEY (`user_bank_id`) REFERENCES `user_banks` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `user_selected_banks_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_selected_banks
-- ----------------------------

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `full_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `role_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `role_id` int UNSIGNED NOT NULL,
  `organ_id` int NULL DEFAULT NULL,
  `mobile` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `bio` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `google_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `facebook_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `remember_token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `logged_count` int UNSIGNED NOT NULL DEFAULT 0,
  `verified` tinyint(1) NOT NULL DEFAULT 0,
  `financial_approval` tinyint(1) NOT NULL DEFAULT 0,
  `installment_approval` tinyint(1) NULL DEFAULT 0,
  `enable_installments` tinyint(1) NULL DEFAULT 1,
  `disable_cashback` tinyint(1) NULL DEFAULT 0,
  `enable_registration_bonus` tinyint(1) NOT NULL DEFAULT 0,
  `registration_bonus_amount` double(15, 2) NULL DEFAULT NULL,
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `avatar_settings` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `cover_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `headline` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `about` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `country_id` int UNSIGNED NULL DEFAULT NULL,
  `province_id` int UNSIGNED NULL DEFAULT NULL,
  `city_id` int UNSIGNED NULL DEFAULT NULL,
  `district_id` int UNSIGNED NULL DEFAULT NULL,
  `location` point NULL,
  `level_of_training` bit(3) NULL DEFAULT NULL,
  `meeting_type` enum('all','in_person','online') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'all',
  `status` enum('active','pending','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `access_content` tinyint(1) NOT NULL DEFAULT 1,
  `language` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `currency` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `timezone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `newsletter` tinyint(1) NOT NULL DEFAULT 0,
  `public_message` tinyint(1) NOT NULL DEFAULT 0,
  `identity_scan` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `certificate` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `commission` int UNSIGNED NULL DEFAULT NULL,
  `affiliate` tinyint(1) NOT NULL DEFAULT 1,
  `can_create_store` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Despite disabling the store feature in the settings, we can enable this feature for that user through the edit page of a user and turning on the store toggle.',
  `ban` tinyint(1) NOT NULL DEFAULT 0,
  `ban_start_at` int UNSIGNED NULL DEFAULT NULL,
  `ban_end_at` int UNSIGNED NULL DEFAULT NULL,
  `offline` tinyint(1) NOT NULL DEFAULT 0,
  `offline_message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_at` int NOT NULL,
  `updated_at` int NULL DEFAULT NULL,
  `deleted_at` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `users_email_unique`(`email`) USING BTREE,
  UNIQUE INDEX `users_mobile_unique`(`mobile`) USING BTREE,
  INDEX `users_country_id_foreign`(`country_id`) USING BTREE,
  INDEX `users_province_id_foreign`(`province_id`) USING BTREE,
  INDEX `users_city_id_foreign`(`city_id`) USING BTREE,
  INDEX `users_district_id_foreign`(`district_id`) USING BTREE,
  CONSTRAINT `users_city_id_foreign` FOREIGN KEY (`city_id`) REFERENCES `regions` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `users_country_id_foreign` FOREIGN KEY (`country_id`) REFERENCES `regions` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `users_district_id_foreign` FOREIGN KEY (`district_id`) REFERENCES `regions` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `users_province_id_foreign` FOREIGN KEY (`province_id`) REFERENCES `regions` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1070 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'Admin', 'admin', 2, NULL, '573127834324', 'admin@devzeros.com', 'CEO DevZeros S.A.S', '$2y$10$3eRjRerG/ZNhtPXeBDVBIeT8r/H8Y9mkMrJfHvaI7fWZWc9GDZE5e', NULL, NULL, '3kE9mzhzp3jxHdq0oWj4Tmm2eosoa8zMcAwITVsdTkEAWgdy1wJSQDzvsQks', 4, 1, 0, 0, 1, 0, 0, NULL, '/store/1/DevZero-01-01.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'all', 'active', 1, 'ES', NULL, 'America/Bogota', 0, 0, NULL, NULL, NULL, 1, 0, 0, NULL, NULL, 0, NULL, 1597826952, 1597826952, NULL);
INSERT INTO `users` VALUES (1014, 'George Hamilton', 'Author Role', 9, NULL, '6104254644', 'Robert@gmail.com', NULL, '$2y$10$UQtinAOPeFdgy81Mxd3z7uGdSz2gsQsh0A3osAkoOb7A6IpjnDH0a', NULL, NULL, NULL, 0, 1, 0, 0, 1, 0, 0, NULL, '/store/1/default_images/testimonials/profile_picture (30).jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'all', 'active', 1, NULL, NULL, 'America/New_York', 0, 0, NULL, NULL, NULL, 1, 0, 0, NULL, NULL, 0, NULL, 1624692024, NULL, NULL);
INSERT INTO `users` VALUES (1016, 'Diego Villa', 'teacher', 4, NULL, '+573013700373', 'diego.villa@devzeros.com', 'Ingeniero de Sistemas', '$2y$10$GcDJDIMc1tyf1O3WTHQgrOx9gQFbHg7JlFDAJe3oq0QWF5DS2JSFW', NULL, NULL, 'SUpuGfOWdQovkbz69cUYBLvipSutm7o5rcUsF4grKD5rYS7eMJIPOvO9r2ri', 0, 1, 1, 0, 1, 0, 0, NULL, '/store/1/profesores/T02GAA5M22K-U02GR1HESE6-3dbcde31c9a3-512.png', NULL, '/store/1016/7.jpg', NULL, NULL, 'Luib, 72 Wern Ddu Lane', 69, 70, 71, 72, ST_GeomFromText('POINT(10.520893646365 -73.331700398826)'), b'111', 'all', 'active', 1, 'ES', NULL, 'America/Bogota', 0, 0, '/store/1016/passport.jpg', '', NULL, 1, 1, 0, NULL, NULL, 0, NULL, 1624817905, NULL, NULL);
INSERT INTO `users` VALUES (1055, 'Carlos Castilla', 'teacher', 4, NULL, NULL, 'carlos.castilla@devzeros.com.co', NULL, '$2y$10$iXUQwEYsJkxKqe/DZ0M4fOu816V98L3qgcrPLab/JNSz2.72CPOiq', NULL, NULL, 'oB2YnCJlo63xrp7s238gVVf6vj5iwN46BENM0XEYjOJt81Ovz8uJPxO2dhWe', 3, 1, 0, 0, 1, 0, 0, NULL, NULL, '{\"color\":\"FFFFFF\",\"background\":\"512da8\"}', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'all', 'active', 1, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, 0, NULL, 1684174239, NULL, NULL);
INSERT INTO `users` VALUES (1060, 'Jairo Tapia', 'user', 1, NULL, '573135816040', 'jairo.tapia@school.devzeros.com', NULL, '$2y$10$NJJOTLp3hL2l0fX4M8LXZuOmT5qPUXF739KMTTpKqWqspXK7kMPhm', NULL, NULL, 'ZbjWnOIRxfS8DmH85dAx7D89OYcnV8s7Repnzq5c8QHIIyQIiQ452iLHOMYp', 3, 0, 0, 0, 1, 0, 0, NULL, NULL, '{\"color\":\"000000\",\"background\":\"03a9f4\"}', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'all', 'active', 1, NULL, NULL, 'America/Bogota', 0, 0, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, 0, NULL, 1686351177, NULL, NULL);
INSERT INTO `users` VALUES (1061, 'Jhonys Andrés Suárez', 'user', 1, NULL, '573242567060', 'jhonnys.suarez@school.devzeros.com', NULL, '$2y$10$JOBNiul4vNlJJ6dX9r0yxO8jsmDUCQ8Ui7XBefNGerF/tNcZ7UXaW', NULL, NULL, NULL, 1, 0, 0, 0, 1, 0, 0, NULL, NULL, '{\"color\":\"000000\",\"background\":\"2962ff\"}', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'all', 'active', 1, NULL, NULL, 'America/Bogota', 0, 0, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, 0, NULL, 1686358648, NULL, NULL);
INSERT INTO `users` VALUES (1062, 'Eduardo Andres Daza', 'user', 1, NULL, NULL, 'eduardo.daza@school.devzeros.com', NULL, '$2y$10$YYg4y5RLCGD.mct/PBmpgOQcJy73bzCoxahtJ1YiEjPuslR4RkDH6', NULL, NULL, 'I0At6lNDVclBG59WnL1p9B9NP93YRIm9xT5PBmoNP42wz9iqkV3HCPFIexAB', 1, 0, 0, 0, 1, 0, 0, NULL, NULL, '{\"color\":\"000000\",\"background\":\"b2ff59\"}', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'all', 'active', 1, NULL, NULL, 'America/Bogota', 0, 0, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, 0, NULL, 1686451851, NULL, NULL);
INSERT INTO `users` VALUES (1063, 'Eduardo Luis Zequeira Gutierrez', 'user', 1, NULL, NULL, 'eduardo.zequeira@school.devzeros.com', NULL, '$2y$10$nyvn52SV2dhEc2wbOXwsQOYWgRuztG8qGCATbIxvzoIW75EDFllVm', NULL, NULL, NULL, 0, 0, 0, 0, 1, 0, 0, NULL, NULL, '{\"color\":\"000000\",\"background\":\"0091ea\"}', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'all', 'active', 1, NULL, NULL, 'America/Bogota', 0, 0, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, 0, NULL, 1687014021, NULL, NULL);
INSERT INTO `users` VALUES (1064, 'Henry Uriel Rojas Vanegas', 'user', 1, NULL, '573234625236', 'henry.rojas@school.devzeros.com', NULL, '$2y$10$cmAQMxgQYG4BDswkV5..QOKNuXe4BoOUDWQyABzt55sWclf7smJ4W', NULL, NULL, 'Uwo93VBMuL1K5q2t76ubMktXQGlx2t1WmIc34M0D0crWTQQmdQU9BI1i5ep2', 2, 0, 0, 0, 1, 0, 0, NULL, NULL, '{\"color\":\"000000\",\"background\":\"0091ea\"}', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'all', 'active', 1, NULL, NULL, 'America/Bogota', 0, 0, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, 0, NULL, 1687488172, NULL, NULL);
INSERT INTO `users` VALUES (1065, 'carlos andrés castilla garcía', 'user', 1, NULL, '573043541475', 'carloscastilla31@gmail.com', NULL, '$2y$10$1uH5yhJLFVc5cQKd5XA1z.UJGB3HKmU0wqoysmLI26yBn4CHlTUVi', NULL, NULL, NULL, 1, 0, 0, 0, 1, 0, 0, NULL, NULL, '{\"color\":\"000000\",\"background\":\"ffcc80\"}', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'all', 'active', 1, NULL, NULL, 'America/Bogota', 0, 0, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, 0, NULL, 1689295012, NULL, NULL);
INSERT INTO `users` VALUES (1066, 'Ronlad Castro', 'teacher', 4, NULL, '3024563759', 'ronlad.castro@devzeros.com', NULL, '$2y$10$i.TldaGk7smFDXY5xax/be.ZT6tC5t6HDE.tMOWZNKcdRV/7xj6t.', NULL, NULL, 'DvZjfZ4boOZtvnak6Ad2Qym8bLByxVYGQfdLaECxD5btghucQMYhWkEUJS99', 1, 1, 0, 0, 1, 0, 0, NULL, NULL, '{\"color\":\"000000\",\"background\":\"ffd600\"}', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'all', 'active', 1, 'ES', NULL, 'America/Bogota', 0, 0, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, 0, NULL, 1692022793, NULL, NULL);
INSERT INTO `users` VALUES (1067, 'Félix Ochoa', 'teacher', 4, NULL, NULL, 'felix.ochoa@devzeros.com', NULL, '$2y$10$EgtpFz2dyWvRnFsk0E294uqMsf16bQQPCBR.VqE8e7G/g5fzh0AeG', NULL, NULL, 'fejmS5PPKiiLmw7ZkpotO27XlnieWunXaAMn2roZR0Ux77feiLRv0lqMSkEp', 1, 1, 0, 0, 1, 0, 0, NULL, NULL, '{\"color\":\"000000\",\"background\":\"eeff41\"}', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'all', 'active', 1, 'ES', NULL, 'America/Bogota', 0, 0, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, 0, NULL, 1692029748, NULL, NULL);
INSERT INTO `users` VALUES (1068, 'Jeiner Robles Noguera', 'user', 1, NULL, '573022236011', 'jeinerrobles53@gmail.com', NULL, '$2y$10$/ssvgt5ySBfLtMSKvv5LLueaysclUT.RylAvbZELg9pVvEjfUkM4q', NULL, NULL, NULL, 1, 0, 0, 0, 1, 0, 0, NULL, NULL, '{\"color\":\"000000\",\"background\":\"ffd600\"}', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'all', 'active', 1, NULL, NULL, 'America/Bogota', 0, 0, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, 0, NULL, 1692889889, NULL, NULL);
INSERT INTO `users` VALUES (1069, 'Diego Alejandro Villa Galvis', 'user', 1, NULL, '573007177986', 'diegoalejandrovillagalvis@gmail.com', NULL, '$2y$10$C3MRI5ij20jcZI3U0shOOO4ZcwAKf6RvhrM39jMOUaNyzXBER9P9i', NULL, NULL, NULL, 1, 0, 0, 0, 1, 0, 0, NULL, NULL, '{\"color\":\"000000\",\"background\":\"ffab00\"}', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'all', 'active', 1, NULL, NULL, 'America/Bogota', 0, 0, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, 0, NULL, 1693425103, NULL, NULL);

-- ----------------------------
-- Table structure for users_badges
-- ----------------------------
DROP TABLE IF EXISTS `users_badges`;
CREATE TABLE `users_badges`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int UNSIGNED NOT NULL,
  `badge_id` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `users_badges_user_id_foreign`(`user_id`) USING BTREE,
  INDEX `users_badges_badge_id_foreign`(`badge_id`) USING BTREE,
  CONSTRAINT `users_badges_badge_id_foreign` FOREIGN KEY (`badge_id`) REFERENCES `badges` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `users_badges_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of users_badges
-- ----------------------------

-- ----------------------------
-- Table structure for users_cookie_security
-- ----------------------------
DROP TABLE IF EXISTS `users_cookie_security`;
CREATE TABLE `users_cookie_security`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int UNSIGNED NOT NULL,
  `type` enum('all','customize') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `settings` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_at` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `users_cookie_security_user_id_foreign`(`user_id`) USING BTREE,
  CONSTRAINT `users_cookie_security_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users_cookie_security
-- ----------------------------

-- ----------------------------
-- Table structure for users_manual_purchase
-- ----------------------------
DROP TABLE IF EXISTS `users_manual_purchase`;
CREATE TABLE `users_manual_purchase`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int UNSIGNED NOT NULL,
  `webinar_id` int UNSIGNED NOT NULL,
  `access` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users_manual_purchase
-- ----------------------------

-- ----------------------------
-- Table structure for users_metas
-- ----------------------------
DROP TABLE IF EXISTS `users_metas`;
CREATE TABLE `users_metas`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `users_metas_user_id_foreign`(`user_id`) USING BTREE,
  CONSTRAINT `users_metas_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 79 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users_metas
-- ----------------------------
INSERT INTO `users_metas` VALUES (1, 1016, 'address', 'Cr 25 # 7B bis 04');
INSERT INTO `users_metas` VALUES (75, 1016, 'gender', 'man');
INSERT INTO `users_metas` VALUES (76, 1016, 'age', '24');
INSERT INTO `users_metas` VALUES (78, 1061, 'certificate_additional', 'O');

-- ----------------------------
-- Table structure for users_occupations
-- ----------------------------
DROP TABLE IF EXISTS `users_occupations`;
CREATE TABLE `users_occupations`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int UNSIGNED NOT NULL,
  `category_id` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `users_occupations_user_id_foreign`(`user_id`) USING BTREE,
  INDEX `users_occupations_category_id_foreign`(`category_id`) USING BTREE,
  CONSTRAINT `users_occupations_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `users_occupations_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1073 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of users_occupations
-- ----------------------------
INSERT INTO `users_occupations` VALUES (1071, 1016, 614);
INSERT INTO `users_occupations` VALUES (1072, 1066, 614);

-- ----------------------------
-- Table structure for users_registration_packages
-- ----------------------------
DROP TABLE IF EXISTS `users_registration_packages`;
CREATE TABLE `users_registration_packages`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int UNSIGNED NOT NULL,
  `instructors_count` int NULL DEFAULT NULL,
  `students_count` int NULL DEFAULT NULL,
  `courses_capacity` int NULL DEFAULT NULL,
  `courses_count` int NULL DEFAULT NULL,
  `meeting_count` int NULL DEFAULT NULL,
  `status` enum('disabled','active') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `users_registration_packages_user_id_foreign`(`user_id`) USING BTREE,
  CONSTRAINT `users_registration_packages_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users_registration_packages
-- ----------------------------

-- ----------------------------
-- Table structure for users_zoom_api
-- ----------------------------
DROP TABLE IF EXISTS `users_zoom_api`;
CREATE TABLE `users_zoom_api`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int UNSIGNED NOT NULL,
  `jwt_token` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `api_key` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `api_secret` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_at` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `users_zoom_api_user_id_foreign`(`user_id`) USING BTREE,
  CONSTRAINT `users_zoom_api_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users_zoom_api
-- ----------------------------

-- ----------------------------
-- Table structure for verifications
-- ----------------------------
DROP TABLE IF EXISTS `verifications`;
CREATE TABLE `verifications`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int UNSIGNED NULL DEFAULT NULL,
  `mobile` char(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `email` char(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `code` char(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `verified_at` int UNSIGNED NULL DEFAULT NULL,
  `expired_at` int UNSIGNED NULL DEFAULT NULL,
  `created_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `verifications_user_id_foreign`(`user_id`) USING BTREE,
  CONSTRAINT `verifications_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 106 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of verifications
-- ----------------------------
INSERT INTO `verifications` VALUES (98, 1060, NULL, 'jairotapia56@hotmail.com', '81039', 1686351209, 1686351259, 1686351178);
INSERT INTO `verifications` VALUES (99, 1061, NULL, 'jhonnys.suarez@school.devzeros.com', '24658', 1686359086, 1686359136, 1686358650);
INSERT INTO `verifications` VALUES (100, 1062, NULL, 'eduardo.daza@school.devzeros.com', '31750', 1686451980, 1686452030, 1686451853);
INSERT INTO `verifications` VALUES (101, 1063, NULL, 'eduardo.zequeira@school.devzeros.com', '33376', 1687014043, 1687014093, 1687014023);
INSERT INTO `verifications` VALUES (102, 1064, NULL, 'henry.rojas@school.devzeros.com', '78705', 1687488198, 1687488248, 1687488174);
INSERT INTO `verifications` VALUES (103, 1065, NULL, 'carloscastilla31@gmail.com', '28703', 1689295027, 1689295077, 1689295014);
INSERT INTO `verifications` VALUES (104, 1068, NULL, 'jeinerrobles53@gmail.com', '89762', 1692889937, 1692889987, 1692889891);
INSERT INTO `verifications` VALUES (105, 1069, NULL, 'diegoalejandrovillagalvis@gmail.com', '54205', 1693425124, 1693425174, 1693425105);

-- ----------------------------
-- Table structure for waitlists
-- ----------------------------
DROP TABLE IF EXISTS `waitlists`;
CREATE TABLE `waitlists`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `webinar_id` int UNSIGNED NOT NULL,
  `user_id` int UNSIGNED NULL DEFAULT NULL,
  `full_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `waitlists_webinar_id_foreign`(`webinar_id`) USING BTREE,
  INDEX `waitlists_user_id_foreign`(`user_id`) USING BTREE,
  CONSTRAINT `waitlists_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `waitlists_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of waitlists
-- ----------------------------

-- ----------------------------
-- Table structure for webinar_assignment_attachments
-- ----------------------------
DROP TABLE IF EXISTS `webinar_assignment_attachments`;
CREATE TABLE `webinar_assignment_attachments`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `creator_id` int UNSIGNED NOT NULL,
  `assignment_id` int UNSIGNED NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `attach` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `webinar_assignment_attachments_assignment_id_foreign`(`assignment_id`) USING BTREE,
  CONSTRAINT `webinar_assignment_attachments_assignment_id_foreign` FOREIGN KEY (`assignment_id`) REFERENCES `webinar_assignments` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of webinar_assignment_attachments
-- ----------------------------

-- ----------------------------
-- Table structure for webinar_assignment_history
-- ----------------------------
DROP TABLE IF EXISTS `webinar_assignment_history`;
CREATE TABLE `webinar_assignment_history`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `instructor_id` int UNSIGNED NOT NULL,
  `student_id` int UNSIGNED NOT NULL,
  `assignment_id` int UNSIGNED NOT NULL,
  `grade` int UNSIGNED NULL DEFAULT NULL,
  `status` enum('pending','passed','not_passed','not_submitted') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `webinar_assignment_history_instructor_id_foreign`(`instructor_id`) USING BTREE,
  INDEX `webinar_assignment_history_student_id_foreign`(`student_id`) USING BTREE,
  INDEX `webinar_assignment_history_assignment_id_foreign`(`assignment_id`) USING BTREE,
  CONSTRAINT `webinar_assignment_history_assignment_id_foreign` FOREIGN KEY (`assignment_id`) REFERENCES `webinar_assignments` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `webinar_assignment_history_instructor_id_foreign` FOREIGN KEY (`instructor_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `webinar_assignment_history_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of webinar_assignment_history
-- ----------------------------

-- ----------------------------
-- Table structure for webinar_assignment_history_messages
-- ----------------------------
DROP TABLE IF EXISTS `webinar_assignment_history_messages`;
CREATE TABLE `webinar_assignment_history_messages`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `assignment_history_id` int UNSIGNED NOT NULL,
  `sender_id` int UNSIGNED NOT NULL,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `file_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `webinar_assignment_history_id`(`assignment_history_id`) USING BTREE,
  CONSTRAINT `webinar_assignment_history_id` FOREIGN KEY (`assignment_history_id`) REFERENCES `webinar_assignment_history` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of webinar_assignment_history_messages
-- ----------------------------

-- ----------------------------
-- Table structure for webinar_assignment_translations
-- ----------------------------
DROP TABLE IF EXISTS `webinar_assignment_translations`;
CREATE TABLE `webinar_assignment_translations`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `webinar_assignment_id` int UNSIGNED NOT NULL,
  `title` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `webinar_assignment_id_translate_foreign`(`webinar_assignment_id`) USING BTREE,
  INDEX `webinar_assignment_translations_locale_index`(`locale`) USING BTREE,
  CONSTRAINT `webinar_assignment_id_translate_foreign` FOREIGN KEY (`webinar_assignment_id`) REFERENCES `webinar_assignments` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of webinar_assignment_translations
-- ----------------------------

-- ----------------------------
-- Table structure for webinar_assignments
-- ----------------------------
DROP TABLE IF EXISTS `webinar_assignments`;
CREATE TABLE `webinar_assignments`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `creator_id` int UNSIGNED NOT NULL,
  `webinar_id` int UNSIGNED NOT NULL,
  `chapter_id` int UNSIGNED NOT NULL,
  `grade` int UNSIGNED NULL DEFAULT NULL,
  `pass_grade` int UNSIGNED NULL DEFAULT NULL,
  `deadline` int UNSIGNED NULL DEFAULT NULL,
  `attempts` int UNSIGNED NULL DEFAULT NULL,
  `check_previous_parts` tinyint(1) NOT NULL DEFAULT 0,
  `access_after_day` int UNSIGNED NULL DEFAULT NULL,
  `status` enum('active','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `webinar_assignments_creator_id_foreign`(`creator_id`) USING BTREE,
  INDEX `webinar_assignments_webinar_id_foreign`(`webinar_id`) USING BTREE,
  INDEX `webinar_assignments_chapter_id_foreign`(`chapter_id`) USING BTREE,
  CONSTRAINT `webinar_assignments_chapter_id_foreign` FOREIGN KEY (`chapter_id`) REFERENCES `webinar_chapters` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `webinar_assignments_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `webinar_assignments_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of webinar_assignments
-- ----------------------------

-- ----------------------------
-- Table structure for webinar_chapter_items
-- ----------------------------
DROP TABLE IF EXISTS `webinar_chapter_items`;
CREATE TABLE `webinar_chapter_items`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int UNSIGNED NOT NULL,
  `chapter_id` int UNSIGNED NOT NULL,
  `item_id` int UNSIGNED NOT NULL,
  `type` enum('file','session','text_lesson','quiz','assignment') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `order` int UNSIGNED NULL DEFAULT NULL,
  `created_at` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `webinar_chapter_items_chapter_id_foreign`(`chapter_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `webinar_chapter_items_chapter_id_foreign` FOREIGN KEY (`chapter_id`) REFERENCES `webinar_chapters` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 382 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of webinar_chapter_items
-- ----------------------------
INSERT INTO `webinar_chapter_items` VALUES (212, 1016, 43, 22, 'text_lesson', 1, 1681335172);
INSERT INTO `webinar_chapter_items` VALUES (213, 1016, 43, 23, 'text_lesson', 2, 1681335284);
INSERT INTO `webinar_chapter_items` VALUES (214, 1016, 43, 24, 'text_lesson', 3, 1681335386);
INSERT INTO `webinar_chapter_items` VALUES (215, 1016, 43, 25, 'text_lesson', 4, 1681335891);
INSERT INTO `webinar_chapter_items` VALUES (216, 1016, 43, 26, 'text_lesson', 5, 1681336085);
INSERT INTO `webinar_chapter_items` VALUES (217, 1016, 44, 27, 'text_lesson', 1, 1681336369);
INSERT INTO `webinar_chapter_items` VALUES (218, 1016, 45, 28, 'text_lesson', 1, 1681336501);
INSERT INTO `webinar_chapter_items` VALUES (219, 1016, 45, 29, 'text_lesson', 2, 1681336569);
INSERT INTO `webinar_chapter_items` VALUES (220, 1016, 45, 30, 'text_lesson', 3, 1681336654);
INSERT INTO `webinar_chapter_items` VALUES (221, 1016, 46, 31, 'text_lesson', 1, 1681336779);
INSERT INTO `webinar_chapter_items` VALUES (222, 1016, 46, 32, 'text_lesson', 2, 1681336906);
INSERT INTO `webinar_chapter_items` VALUES (223, 1016, 46, 33, 'text_lesson', 3, 1681337005);
INSERT INTO `webinar_chapter_items` VALUES (224, 1016, 47, 34, 'text_lesson', 1, 1681337142);
INSERT INTO `webinar_chapter_items` VALUES (225, 1016, 48, 35, 'text_lesson', 1, 1681337220);
INSERT INTO `webinar_chapter_items` VALUES (226, 1016, 42, 36, 'text_lesson', 1, 1681337335);
INSERT INTO `webinar_chapter_items` VALUES (227, 1016, 42, 37, 'text_lesson', 2, 1681337432);
INSERT INTO `webinar_chapter_items` VALUES (228, 1016, 42, 38, 'text_lesson', 3, 1681337489);
INSERT INTO `webinar_chapter_items` VALUES (229, 1016, 42, 39, 'text_lesson', 4, 1681337558);
INSERT INTO `webinar_chapter_items` VALUES (230, 1016, 42, 40, 'text_lesson', 5, 1681337694);
INSERT INTO `webinar_chapter_items` VALUES (231, 1016, 42, 41, 'text_lesson', 6, 1681337752);
INSERT INTO `webinar_chapter_items` VALUES (232, 1016, 42, 42, 'text_lesson', 7, 1681337805);
INSERT INTO `webinar_chapter_items` VALUES (233, 1016, 42, 43, 'text_lesson', 8, 1681337860);
INSERT INTO `webinar_chapter_items` VALUES (234, 1016, 42, 44, 'text_lesson', 9, 1681337908);
INSERT INTO `webinar_chapter_items` VALUES (235, 1016, 49, 45, 'text_lesson', 1, 1681481218);
INSERT INTO `webinar_chapter_items` VALUES (236, 1016, 49, 46, 'text_lesson', 2, 1681481511);
INSERT INTO `webinar_chapter_items` VALUES (237, 1016, 49, 47, 'text_lesson', 3, 1681481682);
INSERT INTO `webinar_chapter_items` VALUES (238, 1016, 49, 48, 'text_lesson', 4, 1681481886);
INSERT INTO `webinar_chapter_items` VALUES (239, 1016, 50, 49, 'text_lesson', 1, 1681482096);
INSERT INTO `webinar_chapter_items` VALUES (240, 1016, 50, 50, 'text_lesson', 2, 1681482284);
INSERT INTO `webinar_chapter_items` VALUES (241, 1016, 50, 51, 'text_lesson', 3, 1681482450);
INSERT INTO `webinar_chapter_items` VALUES (242, 1016, 50, 52, 'text_lesson', 4, 1681482606);
INSERT INTO `webinar_chapter_items` VALUES (243, 1016, 51, 53, 'text_lesson', 1, 1681482843);
INSERT INTO `webinar_chapter_items` VALUES (244, 1016, 51, 54, 'text_lesson', 2, 1681483001);
INSERT INTO `webinar_chapter_items` VALUES (245, 1016, 51, 55, 'text_lesson', 3, 1681483191);
INSERT INTO `webinar_chapter_items` VALUES (246, 1016, 51, 56, 'text_lesson', 4, 1681483331);
INSERT INTO `webinar_chapter_items` VALUES (247, 1016, 52, 57, 'text_lesson', 1, 1681483482);
INSERT INTO `webinar_chapter_items` VALUES (248, 1016, 52, 58, 'text_lesson', 2, 1681483570);
INSERT INTO `webinar_chapter_items` VALUES (249, 1016, 52, 59, 'text_lesson', 3, 1681483881);
INSERT INTO `webinar_chapter_items` VALUES (250, 1016, 53, 60, 'text_lesson', 1, 1681484200);
INSERT INTO `webinar_chapter_items` VALUES (251, 1016, 53, 61, 'text_lesson', 2, 1681484305);
INSERT INTO `webinar_chapter_items` VALUES (252, 1016, 53, 62, 'text_lesson', 3, 1681484431);
INSERT INTO `webinar_chapter_items` VALUES (253, 1016, 53, 63, 'text_lesson', 4, 1681484661);
INSERT INTO `webinar_chapter_items` VALUES (254, 1016, 54, 64, 'text_lesson', 1, 1681485012);
INSERT INTO `webinar_chapter_items` VALUES (255, 1016, 54, 65, 'text_lesson', 2, 1681485157);
INSERT INTO `webinar_chapter_items` VALUES (256, 1016, 54, 66, 'text_lesson', 3, 1681485348);
INSERT INTO `webinar_chapter_items` VALUES (257, 1016, 54, 67, 'text_lesson', 4, 1681485538);
INSERT INTO `webinar_chapter_items` VALUES (258, 1016, 54, 68, 'text_lesson', 5, 1681485708);
INSERT INTO `webinar_chapter_items` VALUES (259, 1016, 54, 69, 'text_lesson', 6, 1681485935);
INSERT INTO `webinar_chapter_items` VALUES (260, 1016, 54, 70, 'text_lesson', 7, 1681486116);
INSERT INTO `webinar_chapter_items` VALUES (261, 1016, 54, 71, 'text_lesson', 8, 1681486331);
INSERT INTO `webinar_chapter_items` VALUES (262, 1016, 54, 72, 'text_lesson', 9, 1681486522);
INSERT INTO `webinar_chapter_items` VALUES (263, 1016, 55, 73, 'text_lesson', 2, 1683249054);
INSERT INTO `webinar_chapter_items` VALUES (264, 1016, 55, 74, 'text_lesson', 1, 1683249119);
INSERT INTO `webinar_chapter_items` VALUES (265, 1016, 55, 75, 'text_lesson', 3, 1683249183);
INSERT INTO `webinar_chapter_items` VALUES (266, 1016, 55, 76, 'text_lesson', 4, 1683249342);
INSERT INTO `webinar_chapter_items` VALUES (267, 1016, 56, 77, 'text_lesson', 1, 1683249452);
INSERT INTO `webinar_chapter_items` VALUES (268, 1016, 56, 78, 'text_lesson', 2, 1683249536);
INSERT INTO `webinar_chapter_items` VALUES (269, 1016, 56, 79, 'text_lesson', 3, 1683249610);
INSERT INTO `webinar_chapter_items` VALUES (270, 1016, 56, 80, 'text_lesson', 4, 1683249674);
INSERT INTO `webinar_chapter_items` VALUES (271, 1016, 57, 81, 'text_lesson', 1, 1683250022);
INSERT INTO `webinar_chapter_items` VALUES (272, 1016, 57, 82, 'text_lesson', 2, 1683250137);
INSERT INTO `webinar_chapter_items` VALUES (273, 1016, 57, 83, 'text_lesson', 3, 1683250392);
INSERT INTO `webinar_chapter_items` VALUES (274, 1016, 57, 84, 'text_lesson', 4, 1683250445);
INSERT INTO `webinar_chapter_items` VALUES (275, 1016, 58, 85, 'text_lesson', 1, 1683250877);
INSERT INTO `webinar_chapter_items` VALUES (276, 1016, 58, 86, 'text_lesson', 2, 1683250966);
INSERT INTO `webinar_chapter_items` VALUES (277, 1016, 58, 87, 'text_lesson', 3, 1683251053);
INSERT INTO `webinar_chapter_items` VALUES (278, 1016, 58, 88, 'text_lesson', 4, 1683251252);
INSERT INTO `webinar_chapter_items` VALUES (279, 1016, 59, 89, 'text_lesson', 1, 1683251351);
INSERT INTO `webinar_chapter_items` VALUES (280, 1016, 59, 90, 'text_lesson', 2, 1683251528);
INSERT INTO `webinar_chapter_items` VALUES (281, 1016, 59, 91, 'text_lesson', 3, 1683251618);
INSERT INTO `webinar_chapter_items` VALUES (282, 1016, 59, 92, 'text_lesson', 4, 1683251819);
INSERT INTO `webinar_chapter_items` VALUES (283, 1016, 60, 93, 'text_lesson', 1, 1683251915);
INSERT INTO `webinar_chapter_items` VALUES (284, 1016, 60, 94, 'text_lesson', 2, 1683251969);
INSERT INTO `webinar_chapter_items` VALUES (285, 1016, 60, 95, 'text_lesson', 3, 1683252086);
INSERT INTO `webinar_chapter_items` VALUES (286, 1016, 61, 96, 'text_lesson', 1, 1683252172);
INSERT INTO `webinar_chapter_items` VALUES (287, 1016, 61, 97, 'text_lesson', 2, 1683252236);

-- ----------------------------
-- Table structure for webinar_chapter_translations
-- ----------------------------
DROP TABLE IF EXISTS `webinar_chapter_translations`;
CREATE TABLE `webinar_chapter_translations`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `webinar_chapter_id` int UNSIGNED NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `webinar_chapter_id`(`webinar_chapter_id`) USING BTREE,
  INDEX `webinar_chapter_translations_locale_index`(`locale`) USING BTREE,
  CONSTRAINT `webinar_chapter_id` FOREIGN KEY (`webinar_chapter_id`) REFERENCES `webinar_chapters` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 80 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of webinar_chapter_translations
-- ----------------------------
INSERT INTO `webinar_chapter_translations` VALUES (43, 42, 'es', 'Programación Básica');
INSERT INTO `webinar_chapter_translations` VALUES (44, 43, 'es', 'Paradigmas de Programación');
INSERT INTO `webinar_chapter_translations` VALUES (45, 44, 'es', 'Principios SOLID');
INSERT INTO `webinar_chapter_translations` VALUES (46, 45, 'es', 'Patrones de Diseño');
INSERT INTO `webinar_chapter_translations` VALUES (47, 46, 'es', 'Base de Datos');
INSERT INTO `webinar_chapter_translations` VALUES (48, 47, 'es', 'Control de Versiones');
INSERT INTO `webinar_chapter_translations` VALUES (49, 48, 'es', 'Arquitectura de Software');
INSERT INTO `webinar_chapter_translations` VALUES (50, 49, 'es', 'Semana 1');
INSERT INTO `webinar_chapter_translations` VALUES (51, 50, 'es', 'Semana 2');
INSERT INTO `webinar_chapter_translations` VALUES (52, 51, 'es', 'Semana 3');
INSERT INTO `webinar_chapter_translations` VALUES (53, 52, 'es', 'Semana 4');
INSERT INTO `webinar_chapter_translations` VALUES (54, 53, 'es', 'Semana 5');
INSERT INTO `webinar_chapter_translations` VALUES (55, 54, 'es', 'Semana 6');
INSERT INTO `webinar_chapter_translations` VALUES (56, 55, 'es', 'Introducción a la programación');
INSERT INTO `webinar_chapter_translations` VALUES (57, 56, 'es', 'Programación con Scratch');
INSERT INTO `webinar_chapter_translations` VALUES (58, 57, 'es', 'Programación con Python');
INSERT INTO `webinar_chapter_translations` VALUES (59, 58, 'es', 'Programación de videojuegos');
INSERT INTO `webinar_chapter_translations` VALUES (60, 59, 'es', 'Desarrollo web');
INSERT INTO `webinar_chapter_translations` VALUES (61, 60, 'es', 'Programación con juegos educativos');
INSERT INTO `webinar_chapter_translations` VALUES (62, 61, 'es', 'Desarrollo de proyectos finales');
INSERT INTO `webinar_chapter_translations` VALUES (78, 77, 'es', 'jhgjg');
INSERT INTO `webinar_chapter_translations` VALUES (79, 78, 'es', 'ejemplo');

-- ----------------------------
-- Table structure for webinar_chapters
-- ----------------------------
DROP TABLE IF EXISTS `webinar_chapters`;
CREATE TABLE `webinar_chapters`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int UNSIGNED NOT NULL,
  `webinar_id` int UNSIGNED NOT NULL,
  `order` int UNSIGNED NULL DEFAULT NULL,
  `check_all_contents_pass` tinyint(1) NOT NULL DEFAULT 0,
  `status` enum('active','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `created_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `webinar_chapters_user_id_foreign`(`user_id`) USING BTREE,
  INDEX `webinar_chapters_webinar_id_foreign`(`webinar_id`) USING BTREE,
  CONSTRAINT `webinar_chapters_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `webinar_chapters_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 79 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of webinar_chapters
-- ----------------------------
INSERT INTO `webinar_chapters` VALUES (42, 1055, 2025, NULL, 0, 'active', 1681333147);
INSERT INTO `webinar_chapters` VALUES (43, 1055, 2025, NULL, 0, 'active', 1681334908);
INSERT INTO `webinar_chapters` VALUES (44, 1055, 2025, NULL, 0, 'active', 1681336175);
INSERT INTO `webinar_chapters` VALUES (45, 1055, 2025, NULL, 0, 'active', 1681336405);
INSERT INTO `webinar_chapters` VALUES (46, 1055, 2025, NULL, 0, 'active', 1681336705);
INSERT INTO `webinar_chapters` VALUES (47, 1055, 2025, NULL, 0, 'active', 1681337069);
INSERT INTO `webinar_chapters` VALUES (48, 1055, 2025, NULL, 0, 'active', 1681337172);
INSERT INTO `webinar_chapters` VALUES (49, 1016, 2026, NULL, 0, 'active', 1681480784);
INSERT INTO `webinar_chapters` VALUES (50, 1016, 2026, NULL, 0, 'active', 1681481908);
INSERT INTO `webinar_chapters` VALUES (51, 1016, 2026, NULL, 0, 'active', 1681482621);
INSERT INTO `webinar_chapters` VALUES (52, 1016, 2026, NULL, 0, 'active', 1681483353);
INSERT INTO `webinar_chapters` VALUES (53, 1016, 2026, NULL, 0, 'active', 1681483909);
INSERT INTO `webinar_chapters` VALUES (54, 1016, 2026, NULL, 0, 'active', 1681484690);
INSERT INTO `webinar_chapters` VALUES (55, 1016, 2027, NULL, 0, 'active', 1683248227);
INSERT INTO `webinar_chapters` VALUES (56, 1016, 2027, NULL, 0, 'active', 1683249381);
INSERT INTO `webinar_chapters` VALUES (57, 1016, 2027, NULL, 0, 'active', 1683249774);
INSERT INTO `webinar_chapters` VALUES (58, 1016, 2027, NULL, 0, 'active', 1683250692);
INSERT INTO `webinar_chapters` VALUES (59, 1016, 2027, NULL, 0, 'active', 1683251271);
INSERT INTO `webinar_chapters` VALUES (60, 1016, 2027, NULL, 0, 'active', 1683251851);
INSERT INTO `webinar_chapters` VALUES (61, 1016, 2027, NULL, 0, 'active', 1683252108);
INSERT INTO `webinar_chapters` VALUES (77, 1016, 2026, NULL, 0, 'active', 1686954820);
INSERT INTO `webinar_chapters` VALUES (78, 1055, 2025, NULL, 0, 'active', 1686954901);

-- ----------------------------
-- Table structure for webinar_extra_description_translations
-- ----------------------------
DROP TABLE IF EXISTS `webinar_extra_description_translations`;
CREATE TABLE `webinar_extra_description_translations`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `webinar_extra_description_id` int UNSIGNED NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `webinar_extra_description_id_foreign`(`webinar_extra_description_id`) USING BTREE,
  INDEX `webinar_extra_description_translations_locale_index`(`locale`) USING BTREE,
  CONSTRAINT `webinar_extra_description_id_foreign` FOREIGN KEY (`webinar_extra_description_id`) REFERENCES `webinar_extra_descriptions` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 43 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of webinar_extra_description_translations
-- ----------------------------

-- ----------------------------
-- Table structure for webinar_extra_descriptions
-- ----------------------------
DROP TABLE IF EXISTS `webinar_extra_descriptions`;
CREATE TABLE `webinar_extra_descriptions`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `creator_id` int UNSIGNED NOT NULL,
  `webinar_id` int UNSIGNED NULL DEFAULT NULL,
  `upcoming_course_id` int UNSIGNED NULL DEFAULT NULL,
  `type` enum('learning_materials','company_logos','requirements') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `order` int UNSIGNED NULL DEFAULT NULL,
  `created_at` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `webinar_extra_descriptions_creator_id_foreign`(`creator_id`) USING BTREE,
  INDEX `webinar_extra_descriptions_webinar_id_foreign`(`webinar_id`) USING BTREE,
  INDEX `webinar_extra_descriptions_upcoming_course_id_foreign`(`upcoming_course_id`) USING BTREE,
  CONSTRAINT `webinar_extra_descriptions_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `webinar_extra_descriptions_upcoming_course_id_foreign` FOREIGN KEY (`upcoming_course_id`) REFERENCES `upcoming_courses` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `webinar_extra_descriptions_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 43 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of webinar_extra_descriptions
-- ----------------------------

-- ----------------------------
-- Table structure for webinar_filter_option
-- ----------------------------
DROP TABLE IF EXISTS `webinar_filter_option`;
CREATE TABLE `webinar_filter_option`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `webinar_id` int UNSIGNED NOT NULL,
  `filter_option_id` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `webinar_filter_option_filter_option_id_foreign`(`filter_option_id`) USING BTREE,
  INDEX `webinar_filter_option_webinar_id_foreign`(`webinar_id`) USING BTREE,
  CONSTRAINT `webinar_filter_option_filter_option_id_foreign` FOREIGN KEY (`filter_option_id`) REFERENCES `filter_options` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `webinar_filter_option_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 11679 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of webinar_filter_option
-- ----------------------------

-- ----------------------------
-- Table structure for webinar_partner_teacher
-- ----------------------------
DROP TABLE IF EXISTS `webinar_partner_teacher`;
CREATE TABLE `webinar_partner_teacher`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `webinar_id` int UNSIGNED NOT NULL,
  `teacher_id` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `webinar_partner_teacher_webinar_id_foreign`(`webinar_id`) USING BTREE,
  INDEX `webinar_partner_teacher_teacher_id_foreign`(`teacher_id`) USING BTREE,
  CONSTRAINT `webinar_partner_teacher_teacher_id_foreign` FOREIGN KEY (`teacher_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `webinar_partner_teacher_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 114 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of webinar_partner_teacher
-- ----------------------------

-- ----------------------------
-- Table structure for webinar_reports
-- ----------------------------
DROP TABLE IF EXISTS `webinar_reports`;
CREATE TABLE `webinar_reports`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int UNSIGNED NOT NULL,
  `webinar_id` int UNSIGNED NOT NULL,
  `reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `webinar_reports_webinar_id_foreign`(`webinar_id`) USING BTREE,
  CONSTRAINT `webinar_reports_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of webinar_reports
-- ----------------------------

-- ----------------------------
-- Table structure for webinar_reviews
-- ----------------------------
DROP TABLE IF EXISTS `webinar_reviews`;
CREATE TABLE `webinar_reviews`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `creator_id` int UNSIGNED NOT NULL,
  `webinar_id` int UNSIGNED NULL DEFAULT NULL,
  `bundle_id` int UNSIGNED NULL DEFAULT NULL,
  `content_quality` int UNSIGNED NOT NULL,
  `instructor_skills` int UNSIGNED NOT NULL,
  `purchase_worth` int UNSIGNED NOT NULL,
  `support_quality` int UNSIGNED NOT NULL,
  `rates` char(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_at` int UNSIGNED NOT NULL,
  `status` enum('pending','active') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `webinar_reviews_webinar_id_foreign`(`webinar_id`) USING BTREE,
  INDEX `webinar_reviews_creator_id_foreign`(`creator_id`) USING BTREE,
  INDEX `webinar_reviews_bundle_id_foreign`(`bundle_id`) USING BTREE,
  CONSTRAINT `webinar_reviews_bundle_id_foreign` FOREIGN KEY (`bundle_id`) REFERENCES `bundles` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `webinar_reviews_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `webinar_reviews_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 43 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of webinar_reviews
-- ----------------------------

-- ----------------------------
-- Table structure for webinar_translations
-- ----------------------------
DROP TABLE IF EXISTS `webinar_translations`;
CREATE TABLE `webinar_translations`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `webinar_id` int UNSIGNED NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `seo_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `webinar_translations_webinar_id_foreign`(`webinar_id`) USING BTREE,
  INDEX `webinar_translations_locale_index`(`locale`) USING BTREE,
  CONSTRAINT `webinar_translations_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 179 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of webinar_translations
-- ----------------------------
INSERT INTO `webinar_translations` VALUES (173, 2025, 'es', 'CURSO BÁSICO DE DESARROLLO', NULL, '<p><span style=\"text-align: center;\"><font color=\"#212529\" face=\"Poppins, sans-serif\"><span style=\"font-size: 16px;\">Aprender las bases de la programación desde cero, a través de nuestras clases presenciales con profesores altamente capacitados y equipos modernos para poner en práctica lo aprendido.</span></font></span></p>');
INSERT INTO `webinar_translations` VALUES (174, 2026, 'es', 'BOOTCAMP .NET CORE AND REACT', NULL, '<p>Este Bootcamp (curso intensivo de programación) ofrece todas las herramientas, lenguajes y técnicas para ejercer como programador web full stack, dominar el fronend, el backend y bases de datos. </p>');
INSERT INTO `webinar_translations` VALUES (175, 2027, 'es', 'PROGRAMACIÓN PARA NIÑOS', 'Curso de programación enfocado a niños entre los 6 y los 11 años', '<p>Este curso tiene como objetivo desarrollar el pensamiento lógico y computacional para la resolución de problemas en, además de fomentar y ejercitar la creatividad, aptitudes básicas que debe tener un programador pero que también les ayudará a desenvolverse de mejor manera frente a los retos que pueden llegar a encontrarse en el día a día. A través de la enseñanza de conceptos básicos como algoritmo, programación, código, entre otros.</p><p>Está pensado para niños entre las edades de 6 y 12 años.</p><p>El curso se enfocará en enseñar a los niños a programar mediante un lenguaje visual y sencillo, adecuado para su edad y nivel de habilidad.</p><p>El curso se enfocará en enseñar a los niños a programar mediante un lenguaje visual y sencillo, adecuado para su edad y nivel de habilidad.</p>');
INSERT INTO `webinar_translations` VALUES (177, 2029, 'es', 'DISEÑO UX/UI Y MAQUETACIÓN WEB', NULL, '<p>El Curso de Diseño UX/UI con Figma te sumergirá en el emocionante mundo del diseño de experiencias y interfaces de usuario, brindándote las habilidades necesarias para crear interfaces atractivas, intuitivas y centradas en el usuario. Durante este programa de 3 meses, explorarás desde los fundamentos esenciales del diseño hasta la implementación práctica de tus creaciones en la web.</p>');
INSERT INTO `webinar_translations` VALUES (178, 2030, 'es', 'CURSO DESARROLLO WEB FULL STACK', NULL, '<p>El Curso Web Full Stack te sumergirá en un viaje acelerado hacia la maestría en el desarrollo web, desde la creación de la interfaz hasta la lógica del servidor. Durante 12 semanas, adquirirás habilidades esenciales y avanzadas que te permitirán construir aplicaciones web completas y dinámicas.</p><p><br></p>');

-- ----------------------------
-- Table structure for webinars
-- ----------------------------
DROP TABLE IF EXISTS `webinars`;
CREATE TABLE `webinars`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `teacher_id` int UNSIGNED NOT NULL,
  `creator_id` int UNSIGNED NOT NULL,
  `category_id` int UNSIGNED NULL DEFAULT NULL,
  `type` enum('webinar','course','text_lesson','classroom_course') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `private` tinyint(1) NOT NULL DEFAULT 0,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `start_date` int NULL DEFAULT NULL,
  `duration` int UNSIGNED NULL DEFAULT NULL,
  `timezone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `thumbnail` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `image_cover` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `video_demo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `video_demo_source` enum('upload','youtube','vimeo','external_link') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `capacity` int UNSIGNED NULL DEFAULT NULL,
  `price` double(15, 2) UNSIGNED NULL DEFAULT NULL,
  `organization_price` double(15, 2) UNSIGNED NULL DEFAULT NULL,
  `support` tinyint(1) NULL DEFAULT 0,
  `certificate` tinyint(1) NOT NULL DEFAULT 0,
  `downloadable` tinyint(1) NULL DEFAULT 0,
  `partner_instructor` tinyint(1) NULL DEFAULT 0,
  `subscribe` tinyint(1) NULL DEFAULT 0,
  `forum` tinyint(1) NOT NULL DEFAULT 0,
  `enable_waitlist` tinyint(1) NOT NULL DEFAULT 0,
  `access_days` int UNSIGNED NULL DEFAULT NULL COMMENT 'Number of days to access the course',
  `points` int NULL DEFAULT NULL,
  `message_for_reviewer` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `status` enum('active','pending','is_draft','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` int NOT NULL,
  `updated_at` int NULL DEFAULT NULL,
  `deleted_at` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `webinars_slug_unique`(`slug`) USING BTREE,
  INDEX `webinars_teacher_id_foreign`(`teacher_id`) USING BTREE,
  INDEX `webinars_category_id_foreign`(`category_id`) USING BTREE,
  INDEX `webinars_slug_index`(`slug`) USING BTREE,
  INDEX `webinars_creator_id_foreign`(`creator_id`) USING BTREE,
  CONSTRAINT `webinars_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `webinars_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `webinars_teacher_id_foreign` FOREIGN KEY (`teacher_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2031 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of webinars
-- ----------------------------
INSERT INTO `webinars` VALUES (2025, 1055, 1055, 614, 'classroom_course', 0, 'Curso-bsico-de-desarrollo', NULL, 7200, 'America/Bogota', '/store/1/Cards Curso/Cursos_Mesa de trabajo 1_Mesa de trabajo 1.png', '/store/1/react-lenguaje-01.jpg', NULL, NULL, 12, 300000.00, NULL, 1, 0, 0, 0, 1, 0, 0, NULL, 10, NULL, 'active', 1681332949, 1692028593, NULL);
INSERT INTO `webinars` VALUES (2026, 1016, 1016, 614, 'course', 0, 'BOOTCAMP-NET-CORE-AND-REACT', NULL, 4800, 'America/Bogota', '/store/1/Sin título-1_Mesa de trabajo 1 copia.png', '/store/1/react-lenguaje-01.jpg', NULL, NULL, 12, 170000.00, NULL, 1, 1, 0, 1, 1, 0, 1, 40, 5, NULL, 'active', 1681480238, 1682085086, NULL);
INSERT INTO `webinars` VALUES (2027, 1016, 1016, 614, 'course', 0, 'programacion-para-niños', NULL, 11520, 'America/Bogota', '/store/1/Cards Curso/Cursos_Mesa de trabajo 1 copia 2.png', '/store/1/ninos-que-tienen-clase-educacion-tecnologica.jpg', NULL, NULL, 12, 170000.00, NULL, 0, 1, 0, 0, 0, 0, 0, NULL, 0, NULL, 'active', 1683227109, 1692036418, NULL);
INSERT INTO `webinars` VALUES (2029, 1066, 1066, 616, 'classroom_course', 0, 'Diseo-UX-UI', NULL, 5760, 'America/Bogota', '/store/1/Cards Curso/Cursos_Mesa de trabajo 1 copia 4-05.png', '/store/1/Cards Curso/bosquejo-borrador-diseno-plantilla-web.jpg', NULL, NULL, 12, 525000.00, NULL, 0, 1, 0, 0, 0, 0, 0, NULL, NULL, NULL, 'active', 1692024533, 1692036497, NULL);
INSERT INTO `webinars` VALUES (2030, 1067, 1067, 616, 'classroom_course', 0, 'CURSO-DESARROLLO-WEB-FULL-STACK', NULL, 7200, 'America/Bogota', '/store/1/Cards Curso/Cursos_Mesa de trabajo 1 copia 4-06.png', '/store/1/Cards Curso/tiro-medio-mujer-que-trabaja-computadora-portatil.jpg', NULL, NULL, 12, 300000.00, NULL, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, 'active', 1692031054, 1692032148, NULL);

SET FOREIGN_KEY_CHECKS = 1;
