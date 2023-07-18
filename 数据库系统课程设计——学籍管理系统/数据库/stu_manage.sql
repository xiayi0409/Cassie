/*
 Navicat MySQL Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80030
 Source Host           : localhost:3306
 Source Schema         : stu_manage

 Target Server Type    : MySQL
 Target Server Version : 80030
 File Encoding         : 65001

 Date: 08/07/2023 05:57:48
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `ID` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `passwd` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `nickname` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `avatar` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `position` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `token` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (1, 'admin', '123456', '管理员', 'admin@qq.com', '12345678', 'https://cdn.jsdelivr.net/gh/inkwall233/imgcdn/avatar.jpg', '管理员', 'uesr-admin-123');
INSERT INTO `admin` VALUES (2, 'custom', '123456', '用户', 'custom@qq.com', '123456', 'https://i2.100024.xyz/2023/06/27/12c3oq3.webp', '用户', 'user-admin-234');

-- ----------------------------
-- Table structure for change_
-- ----------------------------
DROP TABLE IF EXISTS `change_`;
CREATE TABLE `change_`  (
  `ID` int NOT NULL AUTO_INCREMENT,
  `STUDENTID` int NOT NULL,
  `CHANGE` int NOT NULL,
  `REC_TIME` date NOT NULL,
  `DESCRIPTION` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL,
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `STUDENTID`(`STUDENTID`) USING BTREE,
  INDEX `CHANGE`(`CHANGE`) USING BTREE,
  CONSTRAINT `CHANGE` FOREIGN KEY (`CHANGE`) REFERENCES `change_code` (`CODE`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `STUDENTID` FOREIGN KEY (`STUDENTID`) REFERENCES `student` (`STUDENTID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 7013 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of change_
-- ----------------------------
INSERT INTO `change_` VALUES (1, 2020210006, 0, '2019-06-23', '成绩优异');
INSERT INTO `change_` VALUES (2, 2020210007, 1, '2019-10-01', '疾病');
INSERT INTO `change_` VALUES (3, 2020210008, 2, '2020-01-22', '当兵归来');
INSERT INTO `change_` VALUES (4, 2020210009, 3, '2019-09-16', '学分未修满');
INSERT INTO `change_` VALUES (5, 2020210010, 4, '2020-11-21', '正常毕业');
INSERT INTO `change_` VALUES (6, 2020210011, 3, '2018-11-21', '作弊');
INSERT INTO `change_` VALUES (7, 2020210012, 2, '2019-09-16', '当兵归来');
INSERT INTO `change_` VALUES (8, 2020210013, 1, '2019-02-21', '家庭原因');
INSERT INTO `change_` VALUES (9, 2020210014, 4, '2020-04-21', '正常毕业');
INSERT INTO `change_` VALUES (10, 2020210015, 2, '2021-04-01', 'gap期满');
INSERT INTO `change_` VALUES (11, 2020210016, 0, '2019-10-01', '协议转专业');
INSERT INTO `change_` VALUES (12, 2020210001, 5, '2020-09-01', NULL);
INSERT INTO `change_` VALUES (13, 2020210002, 5, '2020-09-01', NULL);
INSERT INTO `change_` VALUES (14, 2020210003, 5, '2020-09-01', NULL);
INSERT INTO `change_` VALUES (15, 2020210004, 5, '2020-09-01', NULL);
INSERT INTO `change_` VALUES (16, 2020210005, 5, '2020-09-01', NULL);
INSERT INTO `change_` VALUES (17, 2020210017, 5, '2020-09-01', NULL);
INSERT INTO `change_` VALUES (18, 2020210018, 5, '2020-09-01', NULL);
INSERT INTO `change_` VALUES (19, 2020210019, 5, '2020-09-01', NULL);
INSERT INTO `change_` VALUES (20, 2020210020, 5, '2020-09-01', NULL);

-- ----------------------------
-- Table structure for change_code
-- ----------------------------
DROP TABLE IF EXISTS `change_code`;
CREATE TABLE `change_code`  (
  `CODE` int NOT NULL,
  `DESCRIPTION` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`CODE`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of change_code
-- ----------------------------
INSERT INTO `change_code` VALUES (0, '转系');
INSERT INTO `change_code` VALUES (1, '休学');
INSERT INTO `change_code` VALUES (2, '复学');
INSERT INTO `change_code` VALUES (3, '退学');
INSERT INTO `change_code` VALUES (4, '毕业');
INSERT INTO `change_code` VALUES (5, '正常');

-- ----------------------------
-- Table structure for class
-- ----------------------------
DROP TABLE IF EXISTS `class`;
CREATE TABLE `class`  (
  `ID` int NOT NULL,
  `NAME` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `MONITOR` int NOT NULL,
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `MONITOR`(`MONITOR`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of class
-- ----------------------------
INSERT INTO `class` VALUES (0, '计算机科学与技术', 0);
INSERT INTO `class` VALUES (1, '网络工程', 0);
INSERT INTO `class` VALUES (2, '信息安全', 0);
INSERT INTO `class` VALUES (3, '音乐与舞蹈学', 0);
INSERT INTO `class` VALUES (4, '美术学', 0);
INSERT INTO `class` VALUES (5, '设计学', 0);
INSERT INTO `class` VALUES (6, '汉语国际教育', 0);
INSERT INTO `class` VALUES (7, '日语', 0);
INSERT INTO `class` VALUES (8, '翻译', 0);
INSERT INTO `class` VALUES (9, '电气工程及其自动化', 0);
INSERT INTO `class` VALUES (10, '电子信息工程', 0);
INSERT INTO `class` VALUES (11, '通信工程', 0);
INSERT INTO `class` VALUES (12, '应用化学', 0);
INSERT INTO `class` VALUES (13, '化学工程与工艺', 0);
INSERT INTO `class` VALUES (14, '环境工程', 0);

-- ----------------------------
-- Table structure for count
-- ----------------------------
DROP TABLE IF EXISTS `count`;
CREATE TABLE `count`  (
  `nameid` int NOT NULL,
  `studentcount` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`nameid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of count
-- ----------------------------
INSERT INTO `count` VALUES (1, '566');

-- ----------------------------
-- Table structure for course
-- ----------------------------
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course`  (
  `courseid` int NOT NULL,
  `class` float NOT NULL,
  `coursename` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_as_cs NOT NULL,
  PRIMARY KEY (`courseid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_as_cs ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of course
-- ----------------------------
INSERT INTO `course` VALUES (1, 5, '高等数学');
INSERT INTO `course` VALUES (2, 2, '大学英语');
INSERT INTO `course` VALUES (3, 0.5, '大学体育');
INSERT INTO `course` VALUES (4, 0.25, '形势与政策');
INSERT INTO `course` VALUES (5, 4.5, '数据结构');
INSERT INTO `course` VALUES (6, 1, '艺术欣赏');
INSERT INTO `course` VALUES (7, 4, '设计艺术');
INSERT INTO `course` VALUES (8, 3, '基础日语');

-- ----------------------------
-- Table structure for department
-- ----------------------------
DROP TABLE IF EXISTS `department`;
CREATE TABLE `department`  (
  `ID` int NOT NULL,
  `NAME` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of department
-- ----------------------------
INSERT INTO `department` VALUES (0, '计算机科学与工程学院');
INSERT INTO `department` VALUES (1, '艺术学院');
INSERT INTO `department` VALUES (2, '外国语学院');
INSERT INTO `department` VALUES (3, '信息与电气工程学院');
INSERT INTO `department` VALUES (4, '化学化工学院');

-- ----------------------------
-- Table structure for grade
-- ----------------------------
DROP TABLE IF EXISTS `grade`;
CREATE TABLE `grade`  (
  `ID` int NOT NULL AUTO_INCREMENT,
  `STUDENTID` int NULL DEFAULT NULL,
  `courseid` int NULL DEFAULT NULL,
  `GRADE` int NULL DEFAULT NULL,
  `STATUS` varchar(5) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `STUDEN`(`STUDENTID`) USING BTREE,
  INDEX `courseid`(`courseid`) USING BTREE,
  CONSTRAINT `courseid` FOREIGN KEY (`courseid`) REFERENCES `course` (`courseid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `STUDEN` FOREIGN KEY (`STUDENTID`) REFERENCES `student` (`STUDENTID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 200331 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of grade
-- ----------------------------
INSERT INTO `grade` VALUES (2, 2020210002, 1, 0, '作弊');
INSERT INTO `grade` VALUES (3, 2020210003, 1, NULL, '缺考');
INSERT INTO `grade` VALUES (4, 2020210004, 1, 91, '正常');
INSERT INTO `grade` VALUES (5, 2020210005, 1, 92, '正常');
INSERT INTO `grade` VALUES (6, 2020210006, 1, 93, '正常');
INSERT INTO `grade` VALUES (8, 2020210008, 1, 95, '正常');
INSERT INTO `grade` VALUES (9, 2020210009, 1, 0, '作弊');
INSERT INTO `grade` VALUES (10, 2020210010, 1, NULL, '缺考');
INSERT INTO `grade` VALUES (11, 2020210011, 1, 49, '正常');
INSERT INTO `grade` VALUES (12, 2020210012, 1, 0, '作弊');
INSERT INTO `grade` VALUES (13, 2020210013, 1, 45, '正常');
INSERT INTO `grade` VALUES (14, 2020210014, 1, 60, '正常');
INSERT INTO `grade` VALUES (15, 2020210015, 1, 88, '正常');
INSERT INTO `grade` VALUES (16, 2020210016, 1, 94, '正常');
INSERT INTO `grade` VALUES (17, 2020210017, 1, 95, '正常');
INSERT INTO `grade` VALUES (18, 2020210018, 1, 56, '正常');
INSERT INTO `grade` VALUES (19, 2020210019, 1, 47, '正常');
INSERT INTO `grade` VALUES (20, 2020210020, 1, 0, '作弊');
INSERT INTO `grade` VALUES (21, 2020210021, 2, 88, '正常');
INSERT INTO `grade` VALUES (22, 2020210022, 3, 70, '正常');
INSERT INTO `grade` VALUES (23, 2020210023, 3, NULL, '缺考');
INSERT INTO `grade` VALUES (24, 2020210024, 4, 67, '正常');
INSERT INTO `grade` VALUES (25, 2020210025, 4, 0, '作弊');
INSERT INTO `grade` VALUES (26, 2020210026, 3, 78, '正常');
INSERT INTO `grade` VALUES (27, 2020210027, 7, 67, '正常');
INSERT INTO `grade` VALUES (28, 2020210028, 5, NULL, '缺考');
INSERT INTO `grade` VALUES (29, 2020210029, 4, 65, '正常');
INSERT INTO `grade` VALUES (30, 2020210030, 6, 89, '正常');
INSERT INTO `grade` VALUES (31, 2020210031, 5, 77, '正常');
INSERT INTO `grade` VALUES (32, 2020210032, 4, NULL, '缺考');
INSERT INTO `grade` VALUES (33, 2020210033, 5, 0, '作弊');
INSERT INTO `grade` VALUES (34, 2020210034, 5, 0, '作弊');
INSERT INTO `grade` VALUES (35, 2020210035, 5, 67, '正常');
INSERT INTO `grade` VALUES (36, 2020210036, 7, 77, '正常');
INSERT INTO `grade` VALUES (37, 2020210037, 8, 77, '正常');
INSERT INTO `grade` VALUES (38, 2020210038, 8, 56, '正常');
INSERT INTO `grade` VALUES (39, 2020210039, 5, 66, '正常');
INSERT INTO `grade` VALUES (40, 2020210040, 7, 89, '正常');
INSERT INTO `grade` VALUES (41, 2020210041, 8, 67, '正常');
INSERT INTO `grade` VALUES (42, 2020210042, 5, 87, '正常');
INSERT INTO `grade` VALUES (43, 2020210043, 6, 0, '作弊');
INSERT INTO `grade` VALUES (44, 2020210044, 7, 0, '作弊');
INSERT INTO `grade` VALUES (45, 2020210045, 6, 57, '正常');
INSERT INTO `grade` VALUES (46, 2020210046, 7, 88, '正常');
INSERT INTO `grade` VALUES (47, 2020210047, 7, 77, '正常');
INSERT INTO `grade` VALUES (48, 2020210048, 5, 86, '正常');
INSERT INTO `grade` VALUES (49, 2020210049, 7, 57, '正常');
INSERT INTO `grade` VALUES (51, 2020210051, 4, NULL, '缺考');
INSERT INTO `grade` VALUES (52, 2020210052, 8, 0, '作弊');
INSERT INTO `grade` VALUES (53, 2020210053, 8, 76, '正常');
INSERT INTO `grade` VALUES (54, 2020210054, 4, 46, '正常');
INSERT INTO `grade` VALUES (55, 2020210055, 8, 88, '正常');
INSERT INTO `grade` VALUES (56, 2020210056, 7, NULL, '缺考');
INSERT INTO `grade` VALUES (57, 2020210057, 8, NULL, '缺考');
INSERT INTO `grade` VALUES (58, 2020210058, 8, 89, '正常');
INSERT INTO `grade` VALUES (59, 2020210059, 8, 78, '正常');
INSERT INTO `grade` VALUES (60, 2020210060, 6, 77, '正常');
INSERT INTO `grade` VALUES (61, 2020210061, 7, 67, '正常');
INSERT INTO `grade` VALUES (62, 2020210062, 8, 65, '正常');
INSERT INTO `grade` VALUES (63, 2020210063, 8, 97, '正常');
INSERT INTO `grade` VALUES (64, 2020210064, 8, NULL, '缺考');
INSERT INTO `grade` VALUES (65, 2020210065, 5, NULL, '缺考');
INSERT INTO `grade` VALUES (66, 2020210066, 6, 66, '正常');
INSERT INTO `grade` VALUES (67, 2020210067, 7, 0, '作弊');
INSERT INTO `grade` VALUES (68, 2020210068, 6, 68, '正常');
INSERT INTO `grade` VALUES (69, 2020210069, 3, 78, '正常');
INSERT INTO `grade` VALUES (70, 2020210070, 7, NULL, '缺考');
INSERT INTO `grade` VALUES (71, 2020210071, 5, 76, '正常');
INSERT INTO `grade` VALUES (72, 2020210072, 6, 87, '正常');
INSERT INTO `grade` VALUES (73, 2020210073, 7, 67, '正常');
INSERT INTO `grade` VALUES (74, 2020210074, 6, 74, '正常');
INSERT INTO `grade` VALUES (75, 2020210075, 7, 0, '作弊');
INSERT INTO `grade` VALUES (76, 2020210076, 5, 87, '正常');
INSERT INTO `grade` VALUES (77, 2020210077, 8, 56, '正常');
INSERT INTO `grade` VALUES (78, 2020210078, 5, 86, '正常');
INSERT INTO `grade` VALUES (79, 2020210079, 5, NULL, '缺考');
INSERT INTO `grade` VALUES (80, 2020210080, 7, 0, '作弊');
INSERT INTO `grade` VALUES (81, 2020210081, 5, 75, '正常');
INSERT INTO `grade` VALUES (82, 2020210082, 7, 65, '正常');
INSERT INTO `grade` VALUES (83, 2020210083, 6, NULL, '缺考');
INSERT INTO `grade` VALUES (84, 2020210084, 7, 87, '正常');
INSERT INTO `grade` VALUES (85, 2020210085, 7, 87, '正常');
INSERT INTO `grade` VALUES (86, 2020210086, 6, 0, '作弊');
INSERT INTO `grade` VALUES (87, 2020210087, 6, 0, '作弊');
INSERT INTO `grade` VALUES (88, 2020210088, 4, 76, '正常');
INSERT INTO `grade` VALUES (89, 2020210089, 3, 87, '正常');
INSERT INTO `grade` VALUES (91, 2020210091, 4, 76, '正常');
INSERT INTO `grade` VALUES (92, 2020210092, 6, 87, '正常');
INSERT INTO `grade` VALUES (93, 2020210093, 8, 76, '正常');
INSERT INTO `grade` VALUES (94, 2020210094, 6, NULL, '缺考');
INSERT INTO `grade` VALUES (95, 2020210095, 7, 79, '正常');
INSERT INTO `grade` VALUES (96, 2020210096, 3, 88, '正常');
INSERT INTO `grade` VALUES (98, 2020210098, 6, 78, '正常');
INSERT INTO `grade` VALUES (99, 2020210099, 2, 82, '正常');
INSERT INTO `grade` VALUES (100, 2020210100, 5, 87, '正常');

-- ----------------------------
-- Table structure for punish_levels
-- ----------------------------
DROP TABLE IF EXISTS `punish_levels`;
CREATE TABLE `punish_levels`  (
  `CODE` int NOT NULL,
  `DESCRIPTION` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`CODE`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of punish_levels
-- ----------------------------
INSERT INTO `punish_levels` VALUES (0, '警告');
INSERT INTO `punish_levels` VALUES (1, '严重警告');
INSERT INTO `punish_levels` VALUES (2, '记过');
INSERT INTO `punish_levels` VALUES (3, '记大过');
INSERT INTO `punish_levels` VALUES (4, '开除');

-- ----------------------------
-- Table structure for punishment
-- ----------------------------
DROP TABLE IF EXISTS `punishment`;
CREATE TABLE `punishment`  (
  `ID` int NOT NULL AUTO_INCREMENT,
  `STUDENTID` int NOT NULL,
  `LEVELS` int NOT NULL,
  `REC_TIME` date NOT NULL,
  `ENABLE` varchar(5) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DESCRIPTION` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `STUDENTID3`(`STUDENTID`) USING BTREE,
  INDEX `LEVELS2`(`LEVELS`) USING BTREE,
  CONSTRAINT `LEVELS2` FOREIGN KEY (`LEVELS`) REFERENCES `punish_levels` (`CODE`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `STUDENTID3` FOREIGN KEY (`STUDENTID`) REFERENCES `student` (`STUDENTID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 34007 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of punishment
-- ----------------------------
INSERT INTO `punishment` VALUES (1, 2020210008, 0, '2019-12-01', '否', '旷课');
INSERT INTO `punishment` VALUES (2, 2020210009, 1, '2019-08-22', '否', '迟到');
INSERT INTO `punishment` VALUES (3, 2020210010, 2, '2019-10-17', '否', '考试作弊');
INSERT INTO `punishment` VALUES (4, 2020210011, 3, '2019-06-01', '是', '旷课');
INSERT INTO `punishment` VALUES (5, 2020210012, 4, '2019-10-13', '是', '迟到');
INSERT INTO `punishment` VALUES (6, 2020210013, 4, '2019-05-11', '否', '考试作弊');
INSERT INTO `punishment` VALUES (7, 2020210014, 3, '2019-05-08', '是', '考试作弊');
INSERT INTO `punishment` VALUES (8, 2020210015, 2, '2019-07-10', '否', '打架');
INSERT INTO `punishment` VALUES (9, 2020210016, 1, '2019-03-10', '是', '旷课');
INSERT INTO `punishment` VALUES (10, 2020210017, 0, '2019-04-06', '否', '迟到');

-- ----------------------------
-- Table structure for reward
-- ----------------------------
DROP TABLE IF EXISTS `reward`;
CREATE TABLE `reward`  (
  `ID` int NOT NULL AUTO_INCREMENT,
  `STUDENTID` int NOT NULL,
  `LEVELS` int NOT NULL,
  `REC_TIME` date NOT NULL,
  `DESCRIPTION` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `STUDENTID2`(`STUDENTID`) USING BTREE,
  INDEX `LEVELS`(`LEVELS`) USING BTREE,
  CONSTRAINT `LEVELS` FOREIGN KEY (`LEVELS`) REFERENCES `reward_levels` (`CODE`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `STUDENTID2` FOREIGN KEY (`STUDENTID`) REFERENCES `student` (`STUDENTID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 17557 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of reward
-- ----------------------------
INSERT INTO `reward` VALUES (1, 2020210001, 0, '2019-07-27', '优秀团支书');
INSERT INTO `reward` VALUES (2, 2020210002, 1, '2019-10-23', '三好学生');
INSERT INTO `reward` VALUES (3, 2020210003, 2, '2019-09-14', '学习标兵');
INSERT INTO `reward` VALUES (4, 2020210004, 3, '2019-03-01', '学院比赛');
INSERT INTO `reward` VALUES (5, 2020210005, 4, '2019-06-29', '演讲比赛');
INSERT INTO `reward` VALUES (6, 2020210006, 5, '2019-03-14', '优秀团支书');
INSERT INTO `reward` VALUES (7, 2020210007, 6, '2019-05-05', '三好学生');
INSERT INTO `reward` VALUES (8, 2020210008, 1, '2020-07-13', '学习标兵');
INSERT INTO `reward` VALUES (9, 2020210009, 2, '2019-09-28', '学院比赛');
INSERT INTO `reward` VALUES (10, 2020210010, 3, '2021-01-20', '三好学生');

-- ----------------------------
-- Table structure for reward_levels
-- ----------------------------
DROP TABLE IF EXISTS `reward_levels`;
CREATE TABLE `reward_levels`  (
  `CODE` int NOT NULL,
  `DESCRIPTION` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`CODE`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of reward_levels
-- ----------------------------
INSERT INTO `reward_levels` VALUES (0, '校特等奖学金');
INSERT INTO `reward_levels` VALUES (1, '校一等奖学金');
INSERT INTO `reward_levels` VALUES (2, '校二等奖学金');
INSERT INTO `reward_levels` VALUES (3, '校三等奖学金');
INSERT INTO `reward_levels` VALUES (4, '系一等奖学金');
INSERT INTO `reward_levels` VALUES (5, '系二等奖学金');
INSERT INTO `reward_levels` VALUES (6, '系三等奖学金');

-- ----------------------------
-- Table structure for sports
-- ----------------------------
DROP TABLE IF EXISTS `sports`;
CREATE TABLE `sports`  (
  `studentid` int NOT NULL,
  `height` double(20, 1) NULL DEFAULT NULL,
  `weight` double(20, 1) NULL DEFAULT NULL,
  `vital` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_as_cs NULL DEFAULT NULL,
  `jump` double(20, 1) NULL DEFAULT NULL,
  `sitreach` double(20, 1) NULL DEFAULT NULL,
  `run1000` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_as_cs NULL DEFAULT NULL,
  `run800` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_as_cs NULL DEFAULT NULL,
  `situp` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_as_cs NULL DEFAULT NULL,
  `pullup` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_as_cs NULL DEFAULT NULL,
  PRIMARY KEY (`studentid`) USING BTREE,
  CONSTRAINT `id` FOREIGN KEY (`studentid`) REFERENCES `student` (`STUDENTID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_as_cs ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sports
-- ----------------------------
INSERT INTO `sports` VALUES (1999999999, 189.0, 56.0, '1245', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sports` VALUES (2000000000, 178.0, 56.0, '3452', NULL, 17.0, NULL, NULL, NULL, NULL);
INSERT INTO `sports` VALUES (2020210001, 155.0, 55.0, '4567', 180.0, 34.0, '3\'44\'\'', '4\'56\'\'', '78', '');
INSERT INTO `sports` VALUES (2020210002, 157.0, 45.0, '1890', 173.0, 18.0, NULL, '3\'04\'\'', '41', NULL);
INSERT INTO `sports` VALUES (2020210003, 177.0, 51.0, '1780', 200.0, 14.0, NULL, '3\'21\'\'', '43', NULL);
INSERT INTO `sports` VALUES (2020210004, 188.0, 60.0, '2246', 168.0, 0.0, '3\'40\'\'', '', NULL, '5');
INSERT INTO `sports` VALUES (2020210005, 178.0, 50.0, '4526', 168.0, 1.0, NULL, '2\'56\'\'', '40', NULL);
INSERT INTO `sports` VALUES (2020210006, 189.0, 61.0, '2457', 151.0, 3.0, '3\'01\'\'', NULL, NULL, '1');
INSERT INTO `sports` VALUES (2020210008, 187.0, 70.0, '3452', 179.0, 6.0, NULL, '2\'58\'\'', '38', NULL);
INSERT INTO `sports` VALUES (2020210009, 167.0, 55.0, '2356', 189.0, 12.0, '3\'32\'\'', NULL, NULL, '8');
INSERT INTO `sports` VALUES (2020210010, 177.0, 63.0, '1356', 190.0, 14.0, NULL, '3\'04\'\'', '27', NULL);
INSERT INTO `sports` VALUES (2020210011, 179.0, 66.0, '4573', 201.0, 20.0, NULL, '3\'21\'\'', '45', NULL);
INSERT INTO `sports` VALUES (2020210012, 156.0, 51.0, '2346', 178.0, 2.0, NULL, '3\'04\'\'', '51', NULL);
INSERT INTO `sports` VALUES (2020210013, 167.0, 49.0, '1909', 188.0, 0.0, '3\'01\'\'', NULL, NULL, '12');
INSERT INTO `sports` VALUES (2020210014, 160.0, 67.0, '4350', 210.0, 1.0, '3\'12\'\'', NULL, NULL, '20');
INSERT INTO `sports` VALUES (2020210015, 155.0, 56.0, '4821', 185.0, 4.0, '3\'01\'\'\r\n', NULL, NULL, '1');
INSERT INTO `sports` VALUES (2020210016, 167.0, 49.0, '2385', 167.0, 6.0, NULL, '3\'04\'\'', '35', NULL);
INSERT INTO `sports` VALUES (2020210017, 160.0, 58.0, '1997', 176.0, 2.0, '3\'01\'\'', NULL, NULL, '18');
INSERT INTO `sports` VALUES (2020210018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sports` VALUES (2020210028, 156.0, 56.0, '3252', NULL, 12.0, '4\'33\'\'', NULL, NULL, '6');
INSERT INTO `sports` VALUES (2022218090, 166.0, 52.0, '3452', NULL, 23.0, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student`  (
  `STUDENTID` int NOT NULL,
  `NAME` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `SEX` enum('男','女') CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `CLASS` int NOT NULL,
  `DEPARTMENT` int NOT NULL,
  `BIRTHDAY` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `NATIVE_PLACE` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`STUDENTID`) USING BTREE,
  INDEX `CLASS`(`CLASS`) USING BTREE,
  INDEX `DEPARTMENT`(`DEPARTMENT`) USING BTREE,
  CONSTRAINT `CLASS` FOREIGN KEY (`CLASS`) REFERENCES `class` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `DEPARTMENT` FOREIGN KEY (`DEPARTMENT`) REFERENCES `department` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES (1999999999, '测试项', '女', 6, 2, '06-16', '北京');
INSERT INTO `student` VALUES (2000000000, '修改', '女', 10, 3, '06-10', '北京');
INSERT INTO `student` VALUES (2020210001, '修改', '女', 4, 1, '5-15', '上海');
INSERT INTO `student` VALUES (2020210002, '冯滢', '女', 13, 4, '12-28', '贵州');
INSERT INTO `student` VALUES (2020210003, '赵娟', '女', 6, 2, '4-8', '青海');
INSERT INTO `student` VALUES (2020210004, '吴彪', '男', 2, 0, '9-13', '辽宁');
INSERT INTO `student` VALUES (2020210005, '吴蕊', '女', 8, 2, '2-16', '四川');
INSERT INTO `student` VALUES (2020210006, '王和', '男', 12, 4, '9-5', '青海');
INSERT INTO `student` VALUES (2020210007, '吴维', '男', 1, 0, '2-8', '广西');
INSERT INTO `student` VALUES (2020210008, '杨茗秀', '女', 4, 1, '7-26', '山西');
INSERT INTO `student` VALUES (2020210009, '王克泰', '男', 2, 0, '11-29', '海南');
INSERT INTO `student` VALUES (2020210010, '吴姬淑', '女', 13, 4, '6-23', '重庆');
INSERT INTO `student` VALUES (2020210011, '冯英燕', '女', 6, 2, '1-12', '陕西');
INSERT INTO `student` VALUES (2020210012, '郑羽秀', '女', 5, 1, '1-11', '浙江');
INSERT INTO `student` VALUES (2020210013, '蒋辰斌', '男', 4, 1, '9-14', '青海');
INSERT INTO `student` VALUES (2020210014, '周栋', '男', 3, 1, '4-19', '广西');
INSERT INTO `student` VALUES (2020210015, '冯志弘', '男', 11, 3, '7-20', '江苏');
INSERT INTO `student` VALUES (2020210016, '吴枝秋', '女', 11, 3, '8-6', '浙江');
INSERT INTO `student` VALUES (2020210017, '朱坚', '男', 10, 3, '11-13', '湖北');
INSERT INTO `student` VALUES (2020210018, '孙艺', '女', 7, 2, '6-27', '安徽');
INSERT INTO `student` VALUES (2020210019, '沈卿', '女', 7, 2, '10-26', '河南');
INSERT INTO `student` VALUES (2020210020, '蒋梁泰', '男', 11, 3, '2-3', '湖南');
INSERT INTO `student` VALUES (2020210021, '沈楠行', '男', 9, 3, '1-11', '甘肃');
INSERT INTO `student` VALUES (2020210022, '朱维', '男', 14, 4, '6-28', '四川');
INSERT INTO `student` VALUES (2020210023, '杨宁茗', '女', 8, 2, '12-4', '河北');
INSERT INTO `student` VALUES (2020210024, '杨以', '男', 10, 3, '8-18', '云南');
INSERT INTO `student` VALUES (2020210025, '陈滢', '女', 14, 4, '5-17', '重庆');
INSERT INTO `student` VALUES (2020210026, '钱德致', '男', 2, 0, '9-28', '重庆');
INSERT INTO `student` VALUES (2020210027, '钱娜筠', '女', 1, 0, '7-1', '江苏');
INSERT INTO `student` VALUES (2020210028, '张家清', '男', 2, 0, '9-8', '香港');
INSERT INTO `student` VALUES (2020210029, '李希', '女', 1, 0, '4-27', '北京');
INSERT INTO `student` VALUES (2020210030, '王航克', '男', 0, 0, '10-27', '海南');
INSERT INTO `student` VALUES (2020210031, '杨雄彪', '男', 1, 0, '11-9', '河南');
INSERT INTO `student` VALUES (2020210032, '赵莺茗', '女', 6, 2, '3-20', '江苏');
INSERT INTO `student` VALUES (2020210033, '陈舒', '女', 5, 1, '8-25', '湖南');
INSERT INTO `student` VALUES (2020210034, '张坚鹏', '男', 4, 1, '1-21', '安徽');
INSERT INTO `student` VALUES (2020210035, '沈蕊', '女', 8, 2, '8-21', '山东');
INSERT INTO `student` VALUES (2020210036, '吴义', '男', 2, 0, '12-19', '福建');
INSERT INTO `student` VALUES (2020210037, '钱艳聪', '女', 4, 1, '5-18', '广东');
INSERT INTO `student` VALUES (2020210038, '吴楠', '男', 0, 0, '9-7', '海南');
INSERT INTO `student` VALUES (2020210039, '王维', '男', 4, 1, '2-26', '重庆');
INSERT INTO `student` VALUES (2020210040, '沈航志', '男', 0, 0, '4-16', '江西');
INSERT INTO `student` VALUES (2020210041, '冯宁', '女', 5, 1, '7-20', '浙江');
INSERT INTO `student` VALUES (2020210042, '郑琬悦', '女', 6, 2, '6-19', '安徽');
INSERT INTO `student` VALUES (2020210043, '韩雄腾', '男', 9, 3, '3-14', '广东');
INSERT INTO `student` VALUES (2020210044, '王旭', '男', 10, 3, '3-28', '江苏');
INSERT INTO `student` VALUES (2020210045, '韩融馥', '女', 3, 1, '12-8', '甘肃');
INSERT INTO `student` VALUES (2020210046, '陈雅珊', '女', 12, 4, '3-26', '内蒙古');
INSERT INTO `student` VALUES (2020210047, '周志启', '男', 4, 1, '7-5', '贵州');
INSERT INTO `student` VALUES (2020210048, '郑姬岚', '女', 4, 1, '6-13', '山东');
INSERT INTO `student` VALUES (2020210049, '冯坚腾', '男', 0, 0, '11-4', '福建');
INSERT INTO `student` VALUES (2020210051, '韩克', '男', 14, 4, '1-23', '湖北');
INSERT INTO `student` VALUES (2020210052, '吴士', '男', 14, 4, '4-29', '青海');
INSERT INTO `student` VALUES (2020210053, '沈策', '男', 2, 0, '7-25', '广东');
INSERT INTO `student` VALUES (2020210054, '韩辰泽', '男', 14, 4, '8-28', '甘肃');
INSERT INTO `student` VALUES (2020210055, '朱思蕊', '女', 12, 4, '4-1', '浙江');
INSERT INTO `student` VALUES (2020210056, '张德', '男', 2, 0, '4-16', '河北');
INSERT INTO `student` VALUES (2020210057, '蒋珠', '女', 7, 2, '8-10', '广东');
INSERT INTO `student` VALUES (2020210058, '冯友', '男', 1, 0, '6-27', '辽宁');
INSERT INTO `student` VALUES (2020210059, '陈泰', '男', 0, 0, '4-6', '安徽');
INSERT INTO `student` VALUES (2020210060, '钱德', '男', 0, 0, '2-12', '黑龙江');
INSERT INTO `student` VALUES (2020210061, '陈钧', '男', 10, 3, '4-14', '吉林');
INSERT INTO `student` VALUES (2020210062, '蒋欢薇', '女', 12, 4, '1-10', '湖北');
INSERT INTO `student` VALUES (2020210063, '韩秋融', '女', 3, 1, '12-8', '河南');
INSERT INTO `student` VALUES (2020210064, '王媛欢', '女', 14, 4, '4-27', '河南');
INSERT INTO `student` VALUES (2020210065, '周霭', '女', 7, 2, '12-14', '广东');
INSERT INTO `student` VALUES (2020210066, '吴澜', '女', 13, 4, '5-22', '海南');
INSERT INTO `student` VALUES (2020210067, '陈启致', '男', 4, 1, '12-17', '山西');
INSERT INTO `student` VALUES (2020210068, '吴聪雅', '女', 13, 4, '12-8', '河南');
INSERT INTO `student` VALUES (2020210069, '赵思', '女', 5, 1, '7-9', '山西');
INSERT INTO `student` VALUES (2020210070, '张翔清', '男', 11, 3, '12-4', '香港');
INSERT INTO `student` VALUES (2020210071, '吴家', '男', 0, 0, '3-18', '甘肃');
INSERT INTO `student` VALUES (2020210072, '陈策辰', '男', 2, 0, '6-25', '湖北');
INSERT INTO `student` VALUES (2020210073, '王庆德', '男', 2, 0, '5-12', '河南');
INSERT INTO `student` VALUES (2020210074, '郑庆朋', '男', 10, 3, '6-1', '浙江');
INSERT INTO `student` VALUES (2020210075, '韩建', '男', 11, 3, '8-13', '陕西');
INSERT INTO `student` VALUES (2020210076, '朱霄伊', '女', 8, 2, '5-14', '黑龙江');
INSERT INTO `student` VALUES (2020210077, '周彪', '男', 10, 3, '8-6', '湖南');
INSERT INTO `student` VALUES (2020210078, '吴媛欣', '女', 5, 1, '9-13', '福建');
INSERT INTO `student` VALUES (2020210079, '赵辰维', '男', 11, 3, '10-9', '广东');
INSERT INTO `student` VALUES (2020210080, '张霄伊芬', '女', 5, 1, '2-24', '云南');
INSERT INTO `student` VALUES (2020210081, '李榕致', '男', 10, 3, '11-15', '江西');
INSERT INTO `student` VALUES (2020210082, '王咏', '女', 6, 2, '7-18', '四川');
INSERT INTO `student` VALUES (2020210083, '赵鹏栋', '男', 4, 1, '9-12', '福建');
INSERT INTO `student` VALUES (2020210084, '李晨家', '男', 10, 3, '12-28', '四川');
INSERT INTO `student` VALUES (2020210085, '朱伦以', '男', 10, 3, '6-9', '辽宁');
INSERT INTO `student` VALUES (2020210086, '钱友士', '男', 2, 0, '9-29', '重庆');
INSERT INTO `student` VALUES (2020210087, '冯融静', '女', 6, 2, '2-25', '西藏');
INSERT INTO `student` VALUES (2020210088, '李楠', '男', 10, 3, '4-29', '北京');
INSERT INTO `student` VALUES (2020210089, '朱飞策', '男', 2, 0, '9-21', '湖南');
INSERT INTO `student` VALUES (2020210090, '杨玉', '女', 12, 4, '3-12', '江苏');
INSERT INTO `student` VALUES (2020210091, '孙若', '男', 2, 0, '10-7', '云南');
INSERT INTO `student` VALUES (2020210092, '王以', '男', 1, 0, '12-11', '内蒙古');
INSERT INTO `student` VALUES (2020210093, '冯眉园', '女', 6, 2, '8-21', '江西');
INSERT INTO `student` VALUES (2020210094, '冯蕊竹', '女', 3, 1, '11-29', '辽宁');
INSERT INTO `student` VALUES (2020210095, '朱霭', '女', 6, 2, '8-9', '湖北');
INSERT INTO `student` VALUES (2020210096, '蒋旭', '男', 14, 4, '8-22', '贵州');
INSERT INTO `student` VALUES (2020210097, '吴飘', '女', 14, 4, '8-25', '北京');
INSERT INTO `student` VALUES (2020210098, '蒋飞', '男', 1, 0, '11-27', '江西');
INSERT INTO `student` VALUES (2020210099, '陈钧', '男', 0, 0, '1-24', '北京');
INSERT INTO `student` VALUES (2020210100, '吴欣宁', '女', 5, 1, '4-20', '海南');
INSERT INTO `student` VALUES (2020210101, '吴彪辰', '男', 10, 3, '6-17', '安徽');
INSERT INTO `student` VALUES (2020210102, '蒋晨', '男', 9, 3, '2-20', '吉林');
INSERT INTO `student` VALUES (2020210103, '沈凝', '女', 12, 4, '7-2', '重庆');
INSERT INTO `student` VALUES (2020210104, '钱雄钧', '男', 11, 3, '12-13', '新疆');
INSERT INTO `student` VALUES (2020210105, '郑维晨', '男', 2, 0, '3-10', '江西');
INSERT INTO `student` VALUES (2020210106, '吴琰', '女', 13, 4, '12-10', '云南');
INSERT INTO `student` VALUES (2020210107, '冯珊馨', '女', 5, 1, '10-23', '澳门');
INSERT INTO `student` VALUES (2020210108, '钱莺苑', '女', 8, 2, '9-3', '安徽');
INSERT INTO `student` VALUES (2020210109, '韩磊', '男', 11, 3, '5-17', '北京');
INSERT INTO `student` VALUES (2020210110, '吴柔', '女', 8, 2, '4-7', '广东');
INSERT INTO `student` VALUES (2020210111, '冯彬以', '男', 10, 3, '6-14', '湖北');
INSERT INTO `student` VALUES (2020210112, '张楠行', '男', 9, 3, '1-3', '湖南');
INSERT INTO `student` VALUES (2020210113, '孙泽', '男', 1, 0, '5-26', '江苏');
INSERT INTO `student` VALUES (2020210114, '周悦欢', '女', 6, 2, '3-12', '青海');
INSERT INTO `student` VALUES (2020210115, '钱辰', '男', 10, 3, '11-25', '湖南');
INSERT INTO `student` VALUES (2020210116, '冯眉卿', '女', 4, 1, '4-22', '上海');
INSERT INTO `student` VALUES (2020210117, '冯雅珊', '女', 13, 4, '10-24', '天津');
INSERT INTO `student` VALUES (2020210118, '吴筠菁', '女', 7, 2, '2-25', '江苏');
INSERT INTO `student` VALUES (2020210119, '周时克', '男', 1, 0, '8-5', '江苏');
INSERT INTO `student` VALUES (2020210120, '吴博', '男', 0, 0, '12-1', '湖南');
INSERT INTO `student` VALUES (2020210121, '韩竹馥', '女', 4, 1, '5-28', '安徽');
INSERT INTO `student` VALUES (2020210122, '张楠', '男', 2, 0, '8-8', '江西');
INSERT INTO `student` VALUES (2020210123, '陈义', '男', 5, 1, '7-4', '甘肃');
INSERT INTO `student` VALUES (2020210124, '杨民', '男', 1, 0, '8-11', '江西');
INSERT INTO `student` VALUES (2020210125, '韩岚馨', '女', 14, 4, '9-1', '宁夏');
INSERT INTO `student` VALUES (2020210126, '杨翔', '男', 1, 0, '7-12', '黑龙江');
INSERT INTO `student` VALUES (2020210127, '赵克', '男', 9, 3, '11-2', '广东');
INSERT INTO `student` VALUES (2020210128, '王栋', '男', 14, 4, '12-20', '北京');
INSERT INTO `student` VALUES (2020210129, '周泰泽', '男', 0, 0, '11-22', '新疆');
INSERT INTO `student` VALUES (2020210130, '张维兴', '男', 3, 1, '10-29', '宁夏');
INSERT INTO `student` VALUES (2020210131, '蒋富', '男', 0, 0, '4-2', '贵州');
INSERT INTO `student` VALUES (2020210132, '蒋以德', '男', 1, 0, '4-9', '安徽');
INSERT INTO `student` VALUES (2020210133, '蒋柔丽', '女', 14, 4, '3-1', '甘肃');
INSERT INTO `student` VALUES (2020210134, '孙君', '女', 14, 4, '10-6', '重庆');
INSERT INTO `student` VALUES (2020210135, '郑飞', '男', 2, 0, '10-4', '海南');
INSERT INTO `student` VALUES (2020210136, '吴媛', '女', 8, 2, '10-4', '云南');
INSERT INTO `student` VALUES (2020210137, '蒋韵梦', '女', 9, 3, '11-3', '广西');
INSERT INTO `student` VALUES (2020210138, '朱航德', '男', 1, 0, '4-23', '海南');
INSERT INTO `student` VALUES (2020210139, '冯树', '男', 1, 0, '8-11', '吉林');
INSERT INTO `student` VALUES (2020210140, '赵以弘', '男', 0, 0, '5-29', '广东');
INSERT INTO `student` VALUES (2020210141, '李泽伦', '男', 12, 4, '8-19', '云南');
INSERT INTO `student` VALUES (2020210142, '吴朋', '男', 11, 3, '11-29', '安徽');
INSERT INTO `student` VALUES (2020210143, '吴飞树', '男', 0, 0, '8-12', '江西');
INSERT INTO `student` VALUES (2020210144, '韩筠', '女', 8, 2, '9-21', '浙江');
INSERT INTO `student` VALUES (2020210145, '沈岚珊', '女', 7, 2, '10-15', '青海');
INSERT INTO `student` VALUES (2020210146, '周弘', '男', 1, 0, '10-26', '重庆');
INSERT INTO `student` VALUES (2020210147, '王伦旭', '男', 2, 0, '6-4', '广西');
INSERT INTO `student` VALUES (2020210148, '杨朋彬', '男', 13, 4, '10-6', '辽宁');
INSERT INTO `student` VALUES (2020210149, '杨琬', '女', 9, 3, '9-16', '广西');
INSERT INTO `student` VALUES (2020210150, '韩策', '男', 0, 0, '5-6', '贵州');
INSERT INTO `student` VALUES (2020210151, '张媛岚', '女', 14, 4, '7-12', '海南');
INSERT INTO `student` VALUES (2020210152, '吴义', '男', 14, 4, '11-27', '广西');
INSERT INTO `student` VALUES (2020210153, '吴琛', '男', 12, 4, '11-13', '贵州');
INSERT INTO `student` VALUES (2020210154, '郑鸣友', '男', 0, 0, '6-22', '浙江');
INSERT INTO `student` VALUES (2020210155, '李园', '女', 8, 2, '5-4', '甘肃');
INSERT INTO `student` VALUES (2020210156, '沈泽', '男', 13, 4, '7-29', '福建');
INSERT INTO `student` VALUES (2020210157, '孙家', '男', 8, 2, '3-5', '吉林');
INSERT INTO `student` VALUES (2020210158, '韩行', '男', 14, 4, '8-25', '贵州');
INSERT INTO `student` VALUES (2020210159, '朱丽岚', '女', 9, 3, '7-17', '安徽');
INSERT INTO `student` VALUES (2020210160, '钱磊', '男', 9, 3, '10-25', '上海');
INSERT INTO `student` VALUES (2020210161, '陈翔', '男', 0, 0, '8-4', '天津');
INSERT INTO `student` VALUES (2020210162, '郑若坚', '男', 11, 3, '12-2', '北京');
INSERT INTO `student` VALUES (2020210163, '郑莺', '女', 5, 1, '12-8', '河南');
INSERT INTO `student` VALUES (2020210164, '张玲枫', '女', 5, 1, '10-26', '重庆');
INSERT INTO `student` VALUES (2020210165, '赵华月', '女', 8, 2, '6-7', '安徽');
INSERT INTO `student` VALUES (2020210166, '杨启坚', '男', 10, 3, '8-5', '山东');
INSERT INTO `student` VALUES (2020210167, '陈兴', '男', 11, 3, '4-1', '西藏');
INSERT INTO `student` VALUES (2020210168, '李士', '男', 11, 3, '1-10', '辽宁');
INSERT INTO `student` VALUES (2020210169, '张建树', '男', 10, 3, '1-1', '福建');
INSERT INTO `student` VALUES (2020210170, '赵弘', '男', 2, 0, '1-1', '北京');
INSERT INTO `student` VALUES (2020210171, '张博', '男', 11, 3, '11-2', '四川');
INSERT INTO `student` VALUES (2020210172, '王启', '男', 10, 3, '12-2', '福建');
INSERT INTO `student` VALUES (2020210173, '王芸', '女', 3, 1, '6-26', '甘肃');
INSERT INTO `student` VALUES (2020210174, '杨柔琴', '女', 7, 2, '12-13', '福建');
INSERT INTO `student` VALUES (2020210175, '郑朋', '男', 11, 3, '12-5', '上海');
INSERT INTO `student` VALUES (2020210176, '吴琛坚', '男', 10, 3, '7-6', '贵州');
INSERT INTO `student` VALUES (2020210177, '蒋悦悦', '女', 6, 2, '8-1', '江西');
INSERT INTO `student` VALUES (2020210178, '蒋巧巧', '女', 6, 2, '9-13', '黑龙江');
INSERT INTO `student` VALUES (2020210179, '韩斌', '男', 12, 4, '10-18', '北京');
INSERT INTO `student` VALUES (2020210180, '吴霄伊', '女', 7, 2, '8-10', '吉林');
INSERT INTO `student` VALUES (2020210181, '孙琛辰', '男', 9, 3, '11-7', '四川');
INSERT INTO `student` VALUES (2020210182, '杨志', '男', 11, 3, '8-23', '湖北');
INSERT INTO `student` VALUES (2020210183, '吴红', '女', 12, 4, '1-4', '四川');
INSERT INTO `student` VALUES (2020210184, '李伦', '男', 13, 4, '10-26', '湖北');
INSERT INTO `student` VALUES (2020210185, '王晓馨', '女', 4, 1, '5-18', '广东');
INSERT INTO `student` VALUES (2020210186, '王园', '女', 8, 2, '12-28', '河南');
INSERT INTO `student` VALUES (2020210187, '李庆炎盛', '男', 13, 4, '1-24', '重庆');
INSERT INTO `student` VALUES (2020210188, '吴钧', '男', 10, 3, '8-15', '黑龙江');
INSERT INTO `student` VALUES (2020210189, '吴德庆', '男', 0, 0, '5-3', '广东');
INSERT INTO `student` VALUES (2020210190, '周枝静', '女', 3, 1, '8-2', '福建');
INSERT INTO `student` VALUES (2020210191, '韩辰友', '男', 10, 3, '11-1', '安徽');
INSERT INTO `student` VALUES (2020210192, '沈建弘', '男', 2, 0, '9-22', '湖南');
INSERT INTO `student` VALUES (2020210193, '沈琛伦', '男', 10, 3, '10-12', '福建');
INSERT INTO `student` VALUES (2020210194, '吴维伦', '男', 0, 0, '11-14', '上海');
INSERT INTO `student` VALUES (2020210195, '周君', '女', 14, 4, '7-13', '江苏');
INSERT INTO `student` VALUES (2020210196, '杨艳燕', '女', 7, 2, '2-10', '香港');
INSERT INTO `student` VALUES (2020210197, '吴月晓', '女', 6, 2, '2-13', '青海');
INSERT INTO `student` VALUES (2020210198, '杨眉', '女', 4, 1, '5-22', '云南');
INSERT INTO `student` VALUES (2020210199, '赵苑', '女', 5, 1, '10-17', '贵州');
INSERT INTO `student` VALUES (2020210200, '钱飞伦', '男', 10, 3, '1-27', '上海');
INSERT INTO `student` VALUES (2020210201, '韩义', '男', 11, 3, '3-12', '山东');
INSERT INTO `student` VALUES (2020210202, '赵冰', '女', 8, 2, '7-27', '湖北');
INSERT INTO `student` VALUES (2020210203, '钱维克', '男', 2, 0, '6-25', '重庆');
INSERT INTO `student` VALUES (2020210204, '李锦', '女', 2, 0, '6-17', '宁夏');
INSERT INTO `student` VALUES (2020210205, '吴策', '男', 11, 3, '4-25', '四川');
INSERT INTO `student` VALUES (2020210206, '钱秀', '女', 4, 1, '7-5', '重庆');
INSERT INTO `student` VALUES (2020210207, '郑惠', '女', 11, 3, '8-2', '湖北');
INSERT INTO `student` VALUES (2020210208, '朱泽', '男', 5, 1, '5-9', '宁夏');
INSERT INTO `student` VALUES (2020210209, '孙梁克', '男', 12, 4, '12-26', '广西');
INSERT INTO `student` VALUES (2020210210, '吴坚冠', '男', 5, 1, '5-2', '河南');
INSERT INTO `student` VALUES (2020210211, '孙飘', '女', 4, 1, '9-9', '黑龙江');
INSERT INTO `student` VALUES (2020210212, '赵梦莎蓉', '女', 9, 3, '6-4', '安徽');
INSERT INTO `student` VALUES (2020210213, '沈冰荔', '女', 9, 3, '6-1', '江苏');
INSERT INTO `student` VALUES (2020210214, '朱美影', '女', 4, 1, '3-6', '贵州');
INSERT INTO `student` VALUES (2020210215, '吴萍馨', '女', 14, 4, '12-11', '内蒙古');
INSERT INTO `student` VALUES (2020210216, '周媛', '女', 4, 1, '2-7', '山东');
INSERT INTO `student` VALUES (2020210217, '蒋飞', '男', 10, 3, '8-7', '湖北');
INSERT INTO `student` VALUES (2020210218, '韩旭', '男', 4, 1, '5-10', '福建');
INSERT INTO `student` VALUES (2020210219, '李腾', '男', 0, 0, '6-24', '四川');
INSERT INTO `student` VALUES (2020210220, '杨克伦', '男', 2, 0, '2-23', '福建');
INSERT INTO `student` VALUES (2020210221, '沈冠', '男', 8, 2, '4-10', '宁夏');
INSERT INTO `student` VALUES (2020210222, '赵航民', '男', 10, 3, '1-24', '陕西');
INSERT INTO `student` VALUES (2020210223, '张行', '男', 14, 4, '7-21', '陕西');
INSERT INTO `student` VALUES (2020210224, '郑丽翠', '女', 3, 1, '9-8', '河北');
INSERT INTO `student` VALUES (2020210225, '杨钧', '男', 2, 0, '1-21', '青海');
INSERT INTO `student` VALUES (2020210226, '张融红', '女', 10, 3, '7-18', '甘肃');
INSERT INTO `student` VALUES (2020210227, '孙巧', '女', 8, 2, '11-8', '贵州');
INSERT INTO `student` VALUES (2020210228, '冯冠富', '男', 1, 0, '7-4', '河南');
INSERT INTO `student` VALUES (2020210229, '吴楠栋', '男', 1, 0, '2-1', '广西');
INSERT INTO `student` VALUES (2020210230, '钱伦', '男', 14, 4, '5-4', '湖南');
INSERT INTO `student` VALUES (2020210231, '吴惠婕', '女', 3, 1, '2-16', '湖南');
INSERT INTO `student` VALUES (2020210232, '沈园欣', '女', 3, 1, '8-1', '贵州');
INSERT INTO `student` VALUES (2020210233, '吴以弘', '男', 4, 1, '7-6', '福建');
INSERT INTO `student` VALUES (2020210234, '李兴', '男', 12, 4, '10-1', '河北');
INSERT INTO `student` VALUES (2020210235, '李若', '男', 13, 4, '12-11', '湖北');
INSERT INTO `student` VALUES (2020210236, '钱彬鸣', '男', 2, 0, '7-20', '安徽');
INSERT INTO `student` VALUES (2020210237, '朱苑', '女', 6, 2, '10-4', '海南');
INSERT INTO `student` VALUES (2020210238, '沈卿蕊', '女', 8, 2, '6-5', '吉林');
INSERT INTO `student` VALUES (2020210239, '李民磊', '男', 0, 0, '12-5', '湖北');
INSERT INTO `student` VALUES (2020210240, '吴玉', '女', 13, 4, '3-26', '河南');
INSERT INTO `student` VALUES (2020210241, '冯泽', '男', 2, 0, '12-24', '陕西');
INSERT INTO `student` VALUES (2020210242, '郑民行', '男', 2, 0, '11-26', '海南');
INSERT INTO `student` VALUES (2020210243, '吴致', '男', 10, 3, '6-24', '广东');
INSERT INTO `student` VALUES (2020210244, '朱枫', '女', 12, 4, '4-6', '河南');
INSERT INTO `student` VALUES (2020210245, '赵琰苑', '女', 5, 1, '8-2', '江西');
INSERT INTO `student` VALUES (2020210246, '蒋欣纯', '女', 3, 1, '8-17', '江苏');
INSERT INTO `student` VALUES (2020210247, '钱若斌', '男', 8, 2, '5-15', '陕西');
INSERT INTO `student` VALUES (2020210248, '王以鸣', '男', 9, 3, '10-8', '河南');
INSERT INTO `student` VALUES (2020210249, '张竹', '女', 5, 1, '4-21', '浙江');
INSERT INTO `student` VALUES (2020210250, '吴泽', '男', 10, 3, '11-29', '河南');
INSERT INTO `student` VALUES (2020210251, '韩栋', '男', 2, 0, '12-18', '内蒙古');
INSERT INTO `student` VALUES (2020210252, '韩钧义', '男', 10, 3, '9-28', '河南');
INSERT INTO `student` VALUES (2020210253, '冯和维', '男', 0, 0, '11-15', '湖南');
INSERT INTO `student` VALUES (2020210254, '蒋彪和', '男', 9, 3, '3-21', '广西');
INSERT INTO `student` VALUES (2020210255, '蒋悦', '女', 4, 1, '11-29', '湖北');
INSERT INTO `student` VALUES (2020210256, '张家泰', '男', 5, 1, '1-18', '浙江');
INSERT INTO `student` VALUES (2020210257, '吴清钧', '男', 0, 0, '2-10', '甘肃');
INSERT INTO `student` VALUES (2020210258, '吴致琛', '男', 10, 3, '9-20', '山东');
INSERT INTO `student` VALUES (2020210259, '蒋珊', '女', 7, 2, '6-10', '广东');
INSERT INTO `student` VALUES (2020210260, '赵可萍', '女', 8, 2, '7-6', '浙江');
INSERT INTO `student` VALUES (2020210261, '孙欣', '女', 13, 4, '12-2', '四川');
INSERT INTO `student` VALUES (2020210262, '王融宜', '女', 6, 2, '11-9', '新疆');
INSERT INTO `student` VALUES (2020210263, '孙澜', '女', 7, 2, '1-7', '安徽');
INSERT INTO `student` VALUES (2020210264, '吴锦', '女', 0, 0, '10-3', '广东');
INSERT INTO `student` VALUES (2020210265, '李丽咏', '女', 4, 1, '2-5', '吉林');
INSERT INTO `student` VALUES (2020210266, '陈风', '男', 0, 0, '10-17', '北京');
INSERT INTO `student` VALUES (2020210267, '韩昭', '女', 3, 1, '10-22', '河南');
INSERT INTO `student` VALUES (2020210268, '孙伦时', '男', 9, 3, '1-6', '海南');
INSERT INTO `student` VALUES (2020210269, '吴栋雄', '男', 9, 3, '9-14', '江西');
INSERT INTO `student` VALUES (2020210270, '李泽', '男', 10, 3, '10-21', '河北');
INSERT INTO `student` VALUES (2020210271, '沈雅', '女', 14, 4, '9-27', '安徽');
INSERT INTO `student` VALUES (2020210272, '吴慧', '女', 7, 2, '10-25', '新疆');
INSERT INTO `student` VALUES (2020210273, '李朋行', '男', 1, 0, '8-24', '湖南');
INSERT INTO `student` VALUES (2020210274, '钱磊时', '男', 12, 4, '5-16', '江西');
INSERT INTO `student` VALUES (2020210275, '陈荔', '女', 3, 1, '2-8', '河南');
INSERT INTO `student` VALUES (2020210276, '李姬', '女', 8, 2, '6-11', '重庆');
INSERT INTO `student` VALUES (2020210277, '赵雄翔', '男', 1, 0, '5-6', '上海');
INSERT INTO `student` VALUES (2020210278, '蒋梦', '女', 7, 2, '2-15', '河南');
INSERT INTO `student` VALUES (2020210279, '朱寒', '女', 1, 0, '1-3', '海南');
INSERT INTO `student` VALUES (2020210280, '冯彪博', '男', 10, 3, '9-26', '贵州');
INSERT INTO `student` VALUES (2020210281, '王航', '男', 7, 2, '4-16', '浙江');
INSERT INTO `student` VALUES (2020210282, '王启航', '男', 11, 3, '8-5', '山西');
INSERT INTO `student` VALUES (2020210283, '周宜', '女', 4, 1, '10-28', '新疆');
INSERT INTO `student` VALUES (2020210284, '朱玲凝', '女', 4, 1, '1-15', '广东');
INSERT INTO `student` VALUES (2020210285, '赵羽', '女', 13, 4, '12-2', '福建');
INSERT INTO `student` VALUES (2020210286, '李德', '男', 2, 0, '4-13', '新疆');
INSERT INTO `student` VALUES (2020210287, '沈雄启', '男', 9, 3, '7-1', '浙江');
INSERT INTO `student` VALUES (2020210288, '沈良', '男', 2, 0, '11-3', '甘肃');
INSERT INTO `student` VALUES (2020210289, '杨飞致', '男', 11, 3, '2-11', '湖北');
INSERT INTO `student` VALUES (2020210290, '吴融澜', '女', 12, 4, '12-25', '北京');
INSERT INTO `student` VALUES (2020210291, '蒋艺', '女', 7, 2, '10-4', '西藏');
INSERT INTO `student` VALUES (2020210292, '吴眉', '女', 8, 2, '5-25', '安徽');
INSERT INTO `student` VALUES (2020210293, '吴冠', '男', 2, 0, '10-11', '浙江');
INSERT INTO `student` VALUES (2020210294, '张辰', '男', 12, 4, '4-10', '福建');
INSERT INTO `student` VALUES (2020210295, '赵伦', '男', 2, 0, '11-4', '陕西');
INSERT INTO `student` VALUES (2020210296, '杨腾兴', '男', 11, 3, '5-25', '山东');
INSERT INTO `student` VALUES (2020210297, '朱苑琬', '女', 14, 4, '10-3', '山东');
INSERT INTO `student` VALUES (2020210298, '钱清', '男', 11, 3, '6-16', '天津');
INSERT INTO `student` VALUES (2020210299, '李悦', '女', 7, 2, '6-5', '台湾');
INSERT INTO `student` VALUES (2020210300, '韩博晨', '男', 1, 0, '8-21', '云南');
INSERT INTO `student` VALUES (2020210301, '李翠', '女', 8, 2, '12-25', '山西');
INSERT INTO `student` VALUES (2020210302, '郑薇红', '女', 7, 2, '6-2', '浙江');
INSERT INTO `student` VALUES (2020210303, '陈泰', '男', 8, 2, '12-29', '上海');
INSERT INTO `student` VALUES (2020210304, '钱旭坚', '男', 2, 0, '5-28', '安徽');
INSERT INTO `student` VALUES (2020210305, '杨德雄', '男', 8, 2, '5-1', '云南');
INSERT INTO `student` VALUES (2020210306, '孙维', '男', 0, 0, '10-13', '河南');
INSERT INTO `student` VALUES (2020210307, '孙美玲', '女', 4, 1, '2-29', '广西');
INSERT INTO `student` VALUES (2020210308, '沈朋', '男', 11, 3, '8-14', '福建');
INSERT INTO `student` VALUES (2020210309, '钱梁', '男', 9, 3, '1-9', '重庆');
INSERT INTO `student` VALUES (2020210310, '郑苑咏', '女', 12, 4, '10-20', '江西');
INSERT INTO `student` VALUES (2020210311, '沈坚', '男', 1, 0, '3-28', '贵州');
INSERT INTO `student` VALUES (2020210312, '陈行策', '男', 12, 4, '8-1', '广东');
INSERT INTO `student` VALUES (2020210313, '蒋美', '女', 8, 2, '8-16', '江苏');
INSERT INTO `student` VALUES (2020210314, '蒋坚行', '男', 1, 0, '10-2', '湖南');
INSERT INTO `student` VALUES (2020210315, '李惠', '女', 12, 4, '3-22', '福建');
INSERT INTO `student` VALUES (2020210316, '王芝玉', '女', 7, 2, '6-18', '湖南');
INSERT INTO `student` VALUES (2020210317, '张霭晓', '女', 14, 4, '1-1', '广东');
INSERT INTO `student` VALUES (2020210318, '吴静', '女', 9, 3, '3-13', '内蒙古');
INSERT INTO `student` VALUES (2020210319, '孙树', '男', 2, 0, '3-7', '浙江');
INSERT INTO `student` VALUES (2020210320, '吴时', '男', 12, 4, '4-20', '贵州');
INSERT INTO `student` VALUES (2020210321, '杨启以', '男', 10, 3, '7-15', '浙江');
INSERT INTO `student` VALUES (2020210322, '孙飘', '女', 6, 2, '10-27', '福建');
INSERT INTO `student` VALUES (2020210323, '朱眉韵', '女', 12, 4, '5-13', '河南');
INSERT INTO `student` VALUES (2020210324, '杨枫', '女', 2, 0, '9-5', '上海');
INSERT INTO `student` VALUES (2020210325, '韩菁', '女', 13, 4, '8-23', '广西');
INSERT INTO `student` VALUES (2020210326, '王彪', '男', 2, 0, '10-16', '福建');
INSERT INTO `student` VALUES (2020210327, '陈红', '女', 3, 1, '5-18', '宁夏');
INSERT INTO `student` VALUES (2020210328, '张树兴', '男', 2, 0, '6-4', '黑龙江');
INSERT INTO `student` VALUES (2020210329, '郑清时', '男', 11, 3, '3-5', '山东');
INSERT INTO `student` VALUES (2020210330, '杨竹', '女', 8, 2, '7-22', '四川');
INSERT INTO `student` VALUES (2020210331, '孙风友', '男', 10, 3, '9-7', '陕西');
INSERT INTO `student` VALUES (2020210332, '王华', '女', 11, 3, '1-11', '广西');
INSERT INTO `student` VALUES (2020210333, '周启', '男', 3, 1, '10-26', '广西');
INSERT INTO `student` VALUES (2020210334, '韩欢', '女', 5, 1, '1-24', '福建');
INSERT INTO `student` VALUES (2020210335, '郑琛维', '男', 1, 0, '10-21', '西藏');
INSERT INTO `student` VALUES (2020210336, '沈彬和', '男', 8, 2, '7-11', '山西');
INSERT INTO `student` VALUES (2020210337, '赵行', '男', 0, 0, '3-9', '河南');
INSERT INTO `student` VALUES (2020210338, '赵馨霄伊', '女', 10, 3, '3-10', '湖北');
INSERT INTO `student` VALUES (2020210339, '吴良致', '男', 4, 1, '5-12', '甘肃');
INSERT INTO `student` VALUES (2020210340, '李树', '男', 1, 0, '12-10', '宁夏');
INSERT INTO `student` VALUES (2020210341, '吴栋磊', '男', 9, 3, '5-1', '上海');
INSERT INTO `student` VALUES (2020210342, '孙德', '男', 2, 0, '4-19', '云南');
INSERT INTO `student` VALUES (2020210343, '李行', '男', 10, 3, '12-17', '广西');
INSERT INTO `student` VALUES (2020210344, '吴炎盛', '男', 2, 0, '6-1', '吉林');
INSERT INTO `student` VALUES (2020210345, '周伦朋', '男', 0, 0, '3-25', '北京');
INSERT INTO `student` VALUES (2020210346, '杨树楠', '男', 5, 1, '12-23', '甘肃');
INSERT INTO `student` VALUES (2020210347, '李伦若', '男', 2, 0, '3-16', '山东');
INSERT INTO `student` VALUES (2020210348, '冯秀', '女', 3, 1, '2-16', '江西');
INSERT INTO `student` VALUES (2020210349, '郑维泰', '男', 4, 1, '2-25', '海南');
INSERT INTO `student` VALUES (2020210350, '蒋翔', '男', 0, 0, '3-9', '江西');
INSERT INTO `student` VALUES (2020210351, '赵姬亚', '女', 12, 4, '10-23', '江西');
INSERT INTO `student` VALUES (2020210352, '李莺', '女', 11, 3, '6-21', '黑龙江');
INSERT INTO `student` VALUES (2020210353, '李娟莺', '女', 12, 4, '7-2', '浙江');
INSERT INTO `student` VALUES (2020210354, '周秋', '女', 12, 4, '2-27', '海南');
INSERT INTO `student` VALUES (2020210355, '孙昭红', '女', 14, 4, '5-25', '吉林');
INSERT INTO `student` VALUES (2020210356, '周德致', '男', 0, 0, '1-21', '湖北');
INSERT INTO `student` VALUES (2020210357, '孙朋以', '男', 11, 3, '7-20', '宁夏');
INSERT INTO `student` VALUES (2020210358, '吴育纯', '女', 14, 4, '3-20', '安徽');
INSERT INTO `student` VALUES (2020210359, '冯泰行', '男', 4, 1, '7-3', '青海');
INSERT INTO `student` VALUES (2020210360, '孙友', '男', 11, 3, '10-13', '云南');
INSERT INTO `student` VALUES (2020210361, '韩琛致', '男', 3, 1, '11-14', '福建');
INSERT INTO `student` VALUES (2020210362, '陈腾', '男', 10, 3, '3-9', '江苏');
INSERT INTO `student` VALUES (2020210363, '王磊', '男', 11, 3, '6-2', '重庆');
INSERT INTO `student` VALUES (2020210364, '孙博', '男', 11, 3, '11-14', '江苏');
INSERT INTO `student` VALUES (2020210365, '冯希馥', '女', 12, 4, '6-25', '贵州');
INSERT INTO `student` VALUES (2020210366, '冯薇昭', '女', 14, 4, '10-25', '浙江');
INSERT INTO `student` VALUES (2020210367, '王清', '男', 1, 0, '9-21', '江苏');
INSERT INTO `student` VALUES (2020210368, '孙良德', '男', 0, 0, '10-14', '香港');
INSERT INTO `student` VALUES (2020210369, '吴以泰', '男', 9, 3, '10-12', '云南');
INSERT INTO `student` VALUES (2020210370, '吴希', '女', 12, 4, '4-5', '吉林');
INSERT INTO `student` VALUES (2020210371, '周芳', '女', 3, 1, '12-23', '四川');
INSERT INTO `student` VALUES (2020210372, '吴士', '男', 0, 0, '9-26', '山东');
INSERT INTO `student` VALUES (2020210373, '李韵', '女', 8, 2, '10-9', '甘肃');
INSERT INTO `student` VALUES (2020210374, '李义栋', '男', 2, 0, '12-10', '贵州');
INSERT INTO `student` VALUES (2020210375, '孙民腾', '男', 6, 2, '9-26', '湖北');
INSERT INTO `student` VALUES (2020210376, '李彬', '男', 10, 3, '8-17', '云南');
INSERT INTO `student` VALUES (2020210377, '吴琛', '男', 9, 3, '2-4', '湖南');
INSERT INTO `student` VALUES (2020210378, '钱建', '男', 13, 4, '4-10', '广东');
INSERT INTO `student` VALUES (2020210379, '吴馨美', '女', 12, 4, '11-13', '宁夏');
INSERT INTO `student` VALUES (2020210380, '吴栋雄', '男', 2, 0, '9-15', '甘肃');
INSERT INTO `student` VALUES (2020210381, '吴良伦', '男', 2, 0, '9-23', '广东');
INSERT INTO `student` VALUES (2020210382, '赵媛', '女', 13, 4, '8-13', '江苏');
INSERT INTO `student` VALUES (2020210383, '钱磊', '男', 14, 4, '6-15', '新疆');
INSERT INTO `student` VALUES (2020210384, '郑建庆', '男', 10, 3, '9-16', '福建');
INSERT INTO `student` VALUES (2020210385, '杨悦', '女', 14, 4, '2-26', '山西');
INSERT INTO `student` VALUES (2020210386, '蒋德', '男', 9, 3, '3-3', '河北');
INSERT INTO `student` VALUES (2020210387, '韩志良', '男', 10, 3, '9-7', '广东');
INSERT INTO `student` VALUES (2020210388, '孙园丽', '女', 13, 4, '12-28', '甘肃');
INSERT INTO `student` VALUES (2020210389, '冯雄彬', '男', 2, 0, '6-14', '辽宁');
INSERT INTO `student` VALUES (2020210390, '杨飘', '女', 7, 2, '3-14', '湖北');
INSERT INTO `student` VALUES (2020210391, '蒋馥', '女', 6, 2, '5-7', '河北');
INSERT INTO `student` VALUES (2020210392, '韩红', '女', 6, 2, '1-4', '广西');
INSERT INTO `student` VALUES (2020210393, '杨泽飞', '男', 2, 0, '4-22', '江苏');
INSERT INTO `student` VALUES (2020210394, '陈伦', '男', 2, 0, '11-13', '宁夏');
INSERT INTO `student` VALUES (2020210395, '孙彬彪', '男', 9, 3, '3-14', '云南');
INSERT INTO `student` VALUES (2020210396, '吴伦', '男', 0, 0, '5-4', '江西');
INSERT INTO `student` VALUES (2020210397, '钱影', '女', 3, 1, '8-2', '甘肃');
INSERT INTO `student` VALUES (2020210398, '张飞梁', '男', 0, 0, '12-10', '安徽');
INSERT INTO `student` VALUES (2020210399, '朱启志', '男', 11, 3, '9-2', '陕西');
INSERT INTO `student` VALUES (2020210400, '杨雄', '男', 10, 3, '5-10', '江苏');
INSERT INTO `student` VALUES (2020210401, '周家富', '男', 11, 3, '10-29', '云南');
INSERT INTO `student` VALUES (2020210402, '韩若', '男', 3, 1, '7-9', '广西');
INSERT INTO `student` VALUES (2020210403, '周志', '男', 1, 0, '12-21', '新疆');
INSERT INTO `student` VALUES (2020210404, '王鸣', '男', 2, 0, '12-23', '海南');
INSERT INTO `student` VALUES (2020210405, '蒋飞鸣', '男', 1, 0, '5-22', '广西');
INSERT INTO `student` VALUES (2020210406, '沈和', '男', 2, 0, '8-5', '湖南');
INSERT INTO `student` VALUES (2020210407, '杨鸣兴', '男', 13, 4, '3-21', '新疆');
INSERT INTO `student` VALUES (2020210408, '沈民楠', '男', 9, 3, '6-6', '河南');
INSERT INTO `student` VALUES (2020210409, '冯羽', '女', 4, 1, '2-5', '河南');
INSERT INTO `student` VALUES (2020210410, '冯蕊', '女', 7, 2, '10-28', '广西');
INSERT INTO `student` VALUES (2020210411, '周友', '男', 12, 4, '11-14', '湖北');
INSERT INTO `student` VALUES (2020210412, '孙朋', '男', 11, 3, '9-27', '广东');
INSERT INTO `student` VALUES (2020210413, '朱朋钧', '男', 2, 0, '2-21', '江苏');
INSERT INTO `student` VALUES (2020210414, '陈秋欢', '女', 4, 1, '7-8', '安徽');
INSERT INTO `student` VALUES (2020210415, '赵竹咏', '女', 12, 4, '4-28', '湖北');
INSERT INTO `student` VALUES (2020210416, '杨致弘', '男', 14, 4, '4-12', '江西');
INSERT INTO `student` VALUES (2020210417, '吴克', '男', 1, 0, '3-14', '浙江');
INSERT INTO `student` VALUES (2020210418, '周博民', '男', 7, 2, '6-25', '黑龙江');
INSERT INTO `student` VALUES (2020210419, '孙行', '男', 9, 3, '7-14', '内蒙古');
INSERT INTO `student` VALUES (2020210420, '王行富', '男', 2, 0, '8-1', '新疆');
INSERT INTO `student` VALUES (2020210421, '蒋霄伊枫', '女', 7, 2, '3-22', '北京');
INSERT INTO `student` VALUES (2020210422, '张良克', '男', 1, 0, '7-21', '贵州');
INSERT INTO `student` VALUES (2020210423, '陈丽瑗', '女', 7, 2, '7-6', '云南');
INSERT INTO `student` VALUES (2020210424, '沈宁', '女', 5, 1, '6-24', '甘肃');
INSERT INTO `student` VALUES (2020210425, '韩志', '男', 10, 3, '5-16', '江苏');
INSERT INTO `student` VALUES (2020210426, '王苑芳', '女', 5, 1, '1-1', '山西');
INSERT INTO `student` VALUES (2020210427, '杨霄伊', '女', 8, 2, '5-19', '云南');
INSERT INTO `student` VALUES (2020210428, '王清', '男', 11, 3, '2-1', '天津');
INSERT INTO `student` VALUES (2020210429, '王泰', '男', 4, 1, '10-20', '贵州');
INSERT INTO `student` VALUES (2020210430, '张斌以', '男', 9, 3, '2-17', '湖南');
INSERT INTO `student` VALUES (2020210431, '孙腾家', '男', 2, 0, '9-5', '湖北');
INSERT INTO `student` VALUES (2020210432, '郑策', '男', 2, 0, '5-18', '陕西');
INSERT INTO `student` VALUES (2020210433, '韩鹏炎盛', '男', 1, 0, '12-12', '云南');
INSERT INTO `student` VALUES (2020210434, '蒋富以', '男', 2, 0, '4-26', '西藏');
INSERT INTO `student` VALUES (2020210435, '陈磊', '男', 11, 3, '6-23', '河南');
INSERT INTO `student` VALUES (2020210436, '冯志庆', '男', 10, 3, '6-13', '甘肃');
INSERT INTO `student` VALUES (2020210437, '王珠', '女', 5, 1, '12-22', '河北');
INSERT INTO `student` VALUES (2020210438, '孙羽', '女', 2, 0, '2-28', '浙江');
INSERT INTO `student` VALUES (2020210439, '王梁', '男', 10, 3, '7-10', '湖北');
INSERT INTO `student` VALUES (2020210440, '王泽', '男', 10, 3, '6-20', '江西');
INSERT INTO `student` VALUES (2020210441, '孙丽咏', '女', 12, 4, '7-19', '贵州');
INSERT INTO `student` VALUES (2020210442, '杨旭', '男', 0, 0, '3-5', '甘肃');
INSERT INTO `student` VALUES (2020210443, '李和彬', '男', 11, 3, '3-21', '山西');
INSERT INTO `student` VALUES (2020210444, '蒋翔', '男', 0, 0, '8-10', '河南');
INSERT INTO `student` VALUES (2020210445, '韩翔坚', '男', 14, 4, '1-16', '江苏');
INSERT INTO `student` VALUES (2020210446, '张弘', '男', 2, 0, '2-18', '山东');
INSERT INTO `student` VALUES (2020210447, '韩若启', '男', 9, 3, '5-9', '黑龙江');
INSERT INTO `student` VALUES (2020210448, '孙富', '男', 0, 0, '2-18', '广西');
INSERT INTO `student` VALUES (2020210449, '张瑗滢', '女', 6, 2, '6-4', '广西');
INSERT INTO `student` VALUES (2020210450, '郑宜', '女', 14, 4, '4-27', '湖北');
INSERT INTO `student` VALUES (2020210451, '郑晓', '女', 12, 4, '9-13', '甘肃');
INSERT INTO `student` VALUES (2020210452, '郑榕榕', '男', 7, 2, '11-11', '福建');
INSERT INTO `student` VALUES (2020210453, '蒋琰巧', '女', 12, 4, '1-23', '河南');
INSERT INTO `student` VALUES (2020210454, '张风', '男', 0, 0, '6-2', '甘肃');
INSERT INTO `student` VALUES (2020210455, '蒋风', '男', 8, 2, '1-10', '香港');
INSERT INTO `student` VALUES (2020210456, '冯冠鸣', '男', 10, 3, '8-2', '湖南');
INSERT INTO `student` VALUES (2020210457, '杨庆伦', '男', 1, 0, '2-27', '上海');
INSERT INTO `student` VALUES (2020210458, '王飘', '女', 6, 2, '5-4', '湖南');
INSERT INTO `student` VALUES (2020210459, '陈飞', '男', 11, 3, '2-22', '山东');
INSERT INTO `student` VALUES (2020210460, '王友腾', '男', 9, 3, '2-18', '贵州');
INSERT INTO `student` VALUES (2020210461, '郑博', '男', 10, 3, '2-3', '浙江');
INSERT INTO `student` VALUES (2020210462, '王岚韵', '女', 4, 1, '6-23', '云南');
INSERT INTO `student` VALUES (2020210463, '周清', '男', 2, 0, '8-5', '黑龙江');
INSERT INTO `student` VALUES (2020210464, '吴楠若', '男', 10, 3, '5-19', '上海');
INSERT INTO `student` VALUES (2020210465, '吴腾', '男', 10, 3, '9-4', '广东');
INSERT INTO `student` VALUES (2020210466, '吴可', '女', 12, 4, '2-5', '湖南');
INSERT INTO `student` VALUES (2020210467, '陈慧', '女', 13, 4, '9-16', '湖南');
INSERT INTO `student` VALUES (2020210468, '张钧', '男', 9, 3, '2-14', '浙江');
INSERT INTO `student` VALUES (2020210469, '蒋思育', '女', 6, 2, '6-11', '河南');
INSERT INTO `student` VALUES (2020210470, '张翔雄', '男', 9, 3, '11-6', '江西');
INSERT INTO `student` VALUES (2020210471, '钱梁榕', '男', 9, 3, '10-21', '江苏');
INSERT INTO `student` VALUES (2020210472, '钱聪菁', '女', 6, 2, '5-23', '云南');
INSERT INTO `student` VALUES (2020210473, '王行', '男', 0, 0, '8-21', '广东');
INSERT INTO `student` VALUES (2020210474, '陈艺思', '女', 5, 1, '5-18', '浙江');
INSERT INTO `student` VALUES (2020210475, '冯纯', '女', 7, 2, '12-5', '吉林');
INSERT INTO `student` VALUES (2020210476, '周士', '男', 2, 0, '6-23', '四川');
INSERT INTO `student` VALUES (2020210477, '钱晓艺', '女', 7, 2, '11-9', '福建');
INSERT INTO `student` VALUES (2020210478, '韩鸣', '男', 0, 0, '3-16', '北京');
INSERT INTO `student` VALUES (2020210479, '沈启', '男', 2, 0, '10-26', '海南');
INSERT INTO `student` VALUES (2020210480, '李旭行', '男', 1, 0, '12-27', '贵州');
INSERT INTO `student` VALUES (2020210481, '杨建建', '男', 2, 0, '5-11', '广东');
INSERT INTO `student` VALUES (2020210482, '周榕', '男', 12, 4, '3-2', '贵州');
INSERT INTO `student` VALUES (2020210483, '李兴', '男', 11, 3, '11-18', '湖北');
INSERT INTO `student` VALUES (2020210484, '蒋坚旭', '男', 7, 2, '12-22', '辽宁');
INSERT INTO `student` VALUES (2020210485, '王和', '男', 10, 3, '10-8', '陕西');
INSERT INTO `student` VALUES (2020210486, '蒋清', '男', 0, 0, '9-20', '山东');
INSERT INTO `student` VALUES (2020210487, '郑民泰', '男', 11, 3, '7-28', '云南');
INSERT INTO `student` VALUES (2020210488, '杨朋旭', '男', 2, 0, '8-28', '湖南');
INSERT INTO `student` VALUES (2020210489, '朱树兴', '男', 9, 3, '7-3', '江西');
INSERT INTO `student` VALUES (2020210490, '王琰霭', '女', 14, 4, '12-23', '贵州');
INSERT INTO `student` VALUES (2020210491, '沈秀', '女', 3, 1, '7-18', '北京');
INSERT INTO `student` VALUES (2020210492, '吴雄时', '男', 3, 1, '3-3', '海南');
INSERT INTO `student` VALUES (2020210493, '郑博', '男', 2, 0, '10-1', '云南');
INSERT INTO `student` VALUES (2020210494, '郑磊', '男', 1, 0, '6-27', '广东');
INSERT INTO `student` VALUES (2020210495, '王秀', '女', 3, 1, '7-15', '海南');
INSERT INTO `student` VALUES (2020210496, '王维', '男', 11, 3, '7-13', '北京');
INSERT INTO `student` VALUES (2020210497, '吴飞清', '男', 10, 3, '3-29', '北京');
INSERT INTO `student` VALUES (2020210498, '钱艳', '女', 12, 4, '1-29', '宁夏');
INSERT INTO `student` VALUES (2020210499, '吴琛启', '男', 2, 0, '4-25', '江西');
INSERT INTO `student` VALUES (2020210500, '孙竹筠', '女', 8, 2, '4-19', '内蒙古');
INSERT INTO `student` VALUES (2020210501, '吴莎蓉', '女', 0, 0, '9-26', '江西');
INSERT INTO `student` VALUES (2020210502, '周德', '男', 9, 3, '11-16', '江苏');
INSERT INTO `student` VALUES (2020210503, '韩栋晨', '男', 9, 3, '6-28', '吉林');
INSERT INTO `student` VALUES (2020210504, '赵岚芝', '女', 6, 2, '10-7', '湖北');
INSERT INTO `student` VALUES (2020210505, '沈义', '男', 0, 0, '7-12', '湖北');
INSERT INTO `student` VALUES (2020210506, '蒋飞', '男', 12, 4, '7-16', '贵州');
INSERT INTO `student` VALUES (2020210507, '李克', '男', 10, 3, '7-27', '福建');
INSERT INTO `student` VALUES (2020210508, '周辰建', '男', 8, 2, '9-4', '吉林');
INSERT INTO `student` VALUES (2020210509, '周腾翔', '男', 10, 3, '6-16', '黑龙江');
INSERT INTO `student` VALUES (2020210510, '沈朋', '男', 11, 3, '1-22', '西藏');
INSERT INTO `student` VALUES (2020210511, '赵维', '男', 2, 0, '3-8', '湖南');
INSERT INTO `student` VALUES (2020210512, '沈钧', '男', 9, 3, '3-11', '北京');
INSERT INTO `student` VALUES (2020210513, '冯淑羽', '女', 13, 4, '9-12', '吉林');
INSERT INTO `student` VALUES (2020210514, '吴致泽', '男', 2, 0, '9-6', '甘肃');
INSERT INTO `student` VALUES (2020210515, '赵泰', '男', 11, 3, '10-19', '吉林');
INSERT INTO `student` VALUES (2020210516, '沈克', '男', 2, 0, '3-3', '重庆');
INSERT INTO `student` VALUES (2020210517, '吴惠', '女', 6, 2, '12-25', '江西');
INSERT INTO `student` VALUES (2020210518, '吴栋鸣', '男', 2, 0, '2-22', '四川');
INSERT INTO `student` VALUES (2020210519, '钱钧博', '男', 1, 0, '12-2', '江西');
INSERT INTO `student` VALUES (2020210520, '孙旭建', '男', 7, 2, '8-27', '浙江');
INSERT INTO `student` VALUES (2020210521, '陈坚磊', '男', 11, 3, '3-1', '海南');
INSERT INTO `student` VALUES (2020210522, '吴翠', '女', 6, 2, '2-8', '四川');
INSERT INTO `student` VALUES (2020210523, '沈霄伊', '女', 6, 2, '3-6', '重庆');
INSERT INTO `student` VALUES (2020210524, '蒋毓雅', '女', 3, 1, '11-2', '河南');
INSERT INTO `student` VALUES (2020210525, '钱纯悦', '女', 14, 4, '6-27', '广西');
INSERT INTO `student` VALUES (2020210526, '孙梦', '女', 5, 1, '2-2', '江西');
INSERT INTO `student` VALUES (2020210527, '钱玉', '女', 10, 3, '9-27', '黑龙江');
INSERT INTO `student` VALUES (2020210528, '陈泰鸣', '男', 0, 0, '6-5', '北京');
INSERT INTO `student` VALUES (2020210529, '郑旭兴', '男', 13, 4, '6-7', '江西');
INSERT INTO `student` VALUES (2020210530, '朱秋思', '女', 7, 2, '6-9', '上海');
INSERT INTO `student` VALUES (2020210531, '蒋风磊', '男', 9, 3, '10-18', '湖北');
INSERT INTO `student` VALUES (2020210532, '孙克', '男', 11, 3, '6-29', '甘肃');
INSERT INTO `student` VALUES (2020210533, '张娜', '女', 8, 2, '2-11', '福建');
INSERT INTO `student` VALUES (2020210534, '韩栋', '男', 14, 4, '5-23', '云南');
INSERT INTO `student` VALUES (2020210535, '王树鹏', '男', 8, 2, '4-25', '青海');
INSERT INTO `student` VALUES (2020210536, '王枝', '女', 11, 3, '3-12', '湖北');
INSERT INTO `student` VALUES (2020210537, '韩坚风', '男', 11, 3, '6-4', '云南');
INSERT INTO `student` VALUES (2020210538, '沈庆克', '男', 2, 0, '11-16', '甘肃');
INSERT INTO `student` VALUES (2020210539, '吴霄伊', '女', 8, 2, '2-11', '湖南');
INSERT INTO `student` VALUES (2020210540, '李朋策', '男', 11, 3, '4-21', '江西');
INSERT INTO `student` VALUES (2020210541, '沈婕', '女', 7, 2, '9-23', '宁夏');
INSERT INTO `student` VALUES (2020210542, '蒋芝', '女', 0, 0, '7-8', '浙江');
INSERT INTO `student` VALUES (2020210543, '蒋雄翔', '男', 11, 3, '9-15', '安徽');
INSERT INTO `student` VALUES (2020210544, '吴娜', '女', 1, 0, '3-9', '福建');
INSERT INTO `student` VALUES (2020210545, '郑欢', '女', 8, 2, '2-4', '上海');
INSERT INTO `student` VALUES (2020210546, '钱德建', '男', 1, 0, '10-26', '上海');
INSERT INTO `student` VALUES (2020210547, '王姬园', '女', 10, 3, '10-27', '浙江');
INSERT INTO `student` VALUES (2020210548, '张荔玲', '女', 7, 2, '5-25', '福建');
INSERT INTO `student` VALUES (2020210549, '吴斌朋', '男', 12, 4, '12-11', '湖南');
INSERT INTO `student` VALUES (2020210550, '吴鹏', '男', 11, 3, '10-16', '浙江');
INSERT INTO `student` VALUES (2020210551, '吴良', '男', 10, 3, '4-18', '广东');
INSERT INTO `student` VALUES (2020210552, '吴欢', '女', 3, 1, '12-1', '江苏');
INSERT INTO `student` VALUES (2020210553, '陈欢玲', '女', 8, 2, '1-16', '山东');
INSERT INTO `student` VALUES (2020210554, '王莺', '女', 7, 2, '10-27', '河南');
INSERT INTO `student` VALUES (2020210555, '王纯瑗', '女', 7, 2, '1-28', '内蒙古');
INSERT INTO `student` VALUES (2020210556, '韩泰', '男', 2, 0, '6-19', '北京');
INSERT INTO `student` VALUES (2020210557, '蒋树', '男', 2, 0, '3-29', '广东');
INSERT INTO `student` VALUES (2020210558, '孙晨', '男', 9, 3, '9-26', '湖北');
INSERT INTO `student` VALUES (2020210559, '钱博若', '男', 2, 0, '7-28', '湖南');
INSERT INTO `student` VALUES (2020210560, '朱毓娟', '女', 3, 1, '11-21', '北京');
INSERT INTO `student` VALUES (2020210561, '赵鹏晨', '男', 1, 0, '3-26', '江西');
INSERT INTO `student` VALUES (2020210562, '周风', '男', 10, 3, '9-29', '山西');
INSERT INTO `student` VALUES (2020210563, '赵弘鸣', '男', 14, 4, '10-11', '浙江');
INSERT INTO `student` VALUES (2020218090, '王夏伊', '女', 0, 0, '2002-4-9', '江苏');
INSERT INTO `student` VALUES (2022218090, '报告测试', '女', 7, 2, '07-23', '北京');

-- ----------------------------
-- View structure for v_course
-- ----------------------------
DROP VIEW IF EXISTS `v_course`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_course` AS select `student`.`STUDENTID` AS `studentid`,`student`.`NAME` AS `name`,`student`.`SEX` AS `sex`,`class`.`NAME` AS `class`,`department`.`NAME` AS `department`,`grade`.`GRADE` AS `GRADE`,`grade`.`STATUS` AS `STATUS`,`course`.`coursename` AS `coursename`,`course`.`class` AS `credit` from ((((`student` join `class` on((`student`.`CLASS` = `class`.`ID`))) join `department` on((`student`.`DEPARTMENT` = `department`.`ID`))) join `grade` on((`student`.`STUDENTID` = `grade`.`STUDENTID`))) join `course` on((`grade`.`courseid` = `course`.`courseid`)));

-- ----------------------------
-- View structure for v_punishment
-- ----------------------------
DROP VIEW IF EXISTS `v_punishment`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_punishment` AS select `punish_levels`.`DESCRIPTION` AS `level`,`punishment`.`REC_TIME` AS `REC_TIME`,`punishment`.`DESCRIPTION` AS `DESCRIPTION`,`student`.`NAME` AS `NAME`,`student`.`STUDENTID` AS `STUDENTID` from ((`punishment` join `punish_levels` on((`punishment`.`LEVELS` = `punish_levels`.`CODE`))) join `student` on((`punishment`.`STUDENTID` = `student`.`STUDENTID`)));

-- ----------------------------
-- View structure for v_reward
-- ----------------------------
DROP VIEW IF EXISTS `v_reward`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_reward` AS select `reward`.`REC_TIME` AS `REC_TIME`,`reward`.`DESCRIPTION` AS `DESCRIPTION`,`reward_levels`.`DESCRIPTION` AS `level`,`student`.`STUDENTID` AS `STUDENTID`,`student`.`NAME` AS `NAME` from ((`reward` join `reward_levels` on((`reward`.`LEVELS` = `reward_levels`.`CODE`))) join `student` on((`reward`.`STUDENTID` = `student`.`STUDENTID`)));

-- ----------------------------
-- View structure for v_sports
-- ----------------------------
DROP VIEW IF EXISTS `v_sports`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_sports` AS select distinct `student`.`STUDENTID` AS `STUDENTID`,`student`.`NAME` AS `NAME`,`student`.`SEX` AS `SEX`,`sports`.`height` AS `height`,`sports`.`weight` AS `weight`,`sports`.`vital` AS `vital`,`sports`.`jump` AS `jump`,`sports`.`sitreach` AS `sitreach`,`sports`.`run1000` AS `run1000`,`sports`.`run800` AS `run800`,`sports`.`situp` AS `situp`,`sports`.`pullup` AS `pullup` from (`student` join `sports` on((`student`.`STUDENTID` = `sports`.`studentid`)));

-- ----------------------------
-- View structure for v_status
-- ----------------------------
DROP VIEW IF EXISTS `v_status`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_status` AS select `student`.`STUDENTID` AS `studentid`,`student`.`NAME` AS `name`,`student`.`SEX` AS `sex`,`department`.`NAME` AS `xueyuan`,`class`.`NAME` AS `classname`,`change_code`.`DESCRIPTION` AS `stu_status`,`change_`.`DESCRIPTION` AS `stu_reason`,`change_`.`REC_TIME` AS `change_time` from ((((`change_code` join `change_` on((`change_code`.`CODE` = `change_`.`CHANGE`))) join `student` on((`student`.`STUDENTID` = `change_`.`STUDENTID`))) join `department` on((`student`.`DEPARTMENT` = `department`.`ID`))) join `class` on((`student`.`CLASS` = `class`.`ID`)));

-- ----------------------------
-- View structure for v_student
-- ----------------------------
DROP VIEW IF EXISTS `v_student`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_student` AS select `student`.`STUDENTID` AS `STUDENTID`,`student`.`NAME` AS `NAME`,`student`.`SEX` AS `SEX`,`class`.`NAME` AS `class`,`department`.`NAME` AS `department`,`student`.`BIRTHDAY` AS `BIRTHDAY`,`student`.`NATIVE_PLACE` AS `NATIVE_PLACE` from ((`student` join `class` on((`student`.`CLASS` = `class`.`ID`))) join `department` on((`student`.`DEPARTMENT` = `department`.`ID`)));

-- ----------------------------
-- Procedure structure for find_course
-- ----------------------------
DROP PROCEDURE IF EXISTS `find_course`;
delimiter ;;
CREATE PROCEDURE `find_course`(IN `coursename` VARCHAR(255))
BEGIN
	#Routine body goes here...
	
	SELECT
		s.studentid,
		s.name,
		s.sex,
		s.department,
		s.class,
		c.class as credit,
		g.status,
		g.grade
	FROM
		grade g
		INNER JOIN student s ON g.studentid = s.studentid
		INNER JOIN course c ON g.courseid = c.courseid
	WHERE
		c.coursename = coursename;
		
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table student
-- ----------------------------
DROP TRIGGER IF EXISTS `student_insert_trigger`;
delimiter ;;
CREATE TRIGGER `student_insert_trigger` AFTER INSERT ON `student` FOR EACH ROW BEGIN
    -- 更新学生总人数
    UPDATE `count` SET studentcount = studentcount + 1 WHERE nameid = 1;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table student
-- ----------------------------
DROP TRIGGER IF EXISTS `student_delete_trigger`;
delimiter ;;
CREATE TRIGGER `student_delete_trigger` AFTER DELETE ON `student` FOR EACH ROW BEGIN
    -- 更新学生总人数
    UPDATE `count` SET studentcount = studentcount - 1 WHERE nameid = 1;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
