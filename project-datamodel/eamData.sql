/** menu setting
设备管理
   创建设备模型
   添加设备

 设备维保

 仓储管理
   仓库
   仓位
   库存明细

备品备件
   配件类别
   配件
   配件入库
   配件出库


 CREATE TABLE `upms_permission` (
  `permission_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '编号',
  `system_id` int(10) unsigned NOT NULL COMMENT '所属系统',
  `pid` int(10) DEFAULT NULL COMMENT '所属上级',
  `name` varchar(20) DEFAULT NULL COMMENT '名称',
  `type` tinyint(4) DEFAULT NULL COMMENT '类型(1:目录,2:菜单,3:按钮)',
  `permission_value` varchar(50) DEFAULT NULL COMMENT '权限值',
  `uri` varchar(100) DEFAULT NULL COMMENT '路径',
  `icon` varchar(50) DEFAULT NULL COMMENT '图标',
  `status` tinyint(4) DEFAULT NULL COMMENT '状态(0:禁止,1:正常)',
  `ctime` bigint(20) DEFAULT NULL COMMENT '创建时间',
  `orders` bigint(20) DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`permission_id`)
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8mb4 COMMENT='权限';
**/

use kuyun;
SET SQL_SAFE_UPDATES = 0;
SET FOREIGN_KEY_CHECKS=0;

-- 系统设置
delete from upms_system where system_id = 6;
INSERT INTO `upms_system` VALUES ('6', 'zmdi zmdi-cloud', '/resources/kuyun-admin/images/kuyun-oss.png', '#0B8DE5', 'http://eam.kuyun.cn:9999', '1', 'kuyun-eam-admin', '设备管理系统', '设备管理系统', '6', '6');

delete from upms_permission where permission_id >= 200;

INSERT INTO `upms_permission` VALUES ('200', '6', '0', '设备及模型管理', '1', null, null, 'zmdi zmdi-collection-text', '1', '200', '200');
INSERT INTO `upms_permission` VALUES ('201', '6', '200', '设备模型管理', '2', 'eam:equipmentModel:read',   '/manage/equipment/model/index', null, '1', '201', '201');
INSERT INTO `upms_permission` VALUES ('202', '6', '201', '新增设备模型', '3', 'eam:equipmentModel:create', '/manage/equipment/model/create', 'zmdi zmdi-plus', '1', '1489820150404', '1489820150404');
INSERT INTO `upms_permission` VALUES ('203', '6', '201', '编辑设备模型', '3', 'eam:equipmentModel:update', '/manage/equipment/model/update', 'zmdi zmdi-edit', '1', '1489820178269', '1489820178269');
INSERT INTO `upms_permission` VALUES ('204', '6', '201', '删除设备模型', '3', 'eam:equipmentModel:delete', '/manage/equipment/model/delete', 'zmdi zmdi-close', '1', '1489820207607', '1489820207607');

INSERT INTO `upms_permission` VALUES ('205', '6', '200', '设备信息管理', '2', 'eam:equipment:read',   '/manage/equipment/index', null, '1', '205', '205');
INSERT INTO `upms_permission` VALUES ('206', '6', '205', '新增设备', '3', 'eam:equipment:create', '/manage/equipment/create', 'zmdi zmdi-plus', '1', '1489820150404', '1489820150404');
INSERT INTO `upms_permission` VALUES ('207', '6', '205', '编辑设备', '3', 'eam:equipment:update', '/manage/equipment/update', 'zmdi zmdi-edit', '1', '1489820178269', '1489820178269');
INSERT INTO `upms_permission` VALUES ('208', '6', '205', '删除设备', '3', 'eam:equipment:delete', '/manage/equipment/delete', 'zmdi zmdi-close', '1', '1489820207607', '1489820207607');
INSERT INTO `upms_permission` VALUES ('209', '6', '205', '设备接入', '3', 'eam:equipment:update', '/manage/equipment/connect', 'zmdi zmdi-edit', '1', '1489820178269', '1489820178269');


INSERT INTO `upms_permission` VALUES ('213', '6', '0', ' 仓储管理', '1', null, null, 'zmdi zmdi-collection-text', '1', '200', '200');
INSERT INTO `upms_permission` VALUES ('214', '6', '213', '仓库管理', '2', 'eam:warehouse:read',   '/manage/warehouse/index', null, '1', '213', '213');
INSERT INTO `upms_permission` VALUES ('215', '6', '214', '新增仓库', '3', 'eam:warehouse:create', '/manage/warehouse/create', 'zmdi zmdi-plus', '1', '1489820150404', '1489820150404');
INSERT INTO `upms_permission` VALUES ('216', '6', '214', '编辑仓库', '3', 'eam:warehouse:update', '/manage/warehouse/update', 'zmdi zmdi-edit', '1', '1489820178269', '1489820178269');
INSERT INTO `upms_permission` VALUES ('217', '6', '214', '删除仓库', '3', 'eam:warehouse:delete', '/manage/warehouse/delete', 'zmdi zmdi-close', '1', '1489820207607', '1489820207607');

INSERT INTO `upms_permission` VALUES ('218', '6', '213', '仓位管理', '2', 'eam:location:read',   '/manage/location/index', null, '1', '218', '218');
INSERT INTO `upms_permission` VALUES ('219', '6', '218', '新增仓位', '3', 'eam:location:create', '/manage/location/create', 'zmdi zmdi-plus', '1', '1489820150404', '1489820150404');
INSERT INTO `upms_permission` VALUES ('220', '6', '218', '编辑仓位', '3', 'eam:location:update', '/manage/location/update', 'zmdi zmdi-edit', '1', '1489820178269', '1489820178269');
INSERT INTO `upms_permission` VALUES ('221', '6', '218', '删除仓位', '3', 'eam:location:delete', '/manage/location/delete', 'zmdi zmdi-close', '1', '1489820207607', '1489820207607');

INSERT INTO `upms_permission` VALUES ('222', '6', '213', '库存管理', '2', 'eam:inventory:read',   '/manage/inventory/index', null, '1', '222', '222');
INSERT INTO `upms_permission` VALUES ('223', '6', '222', '新增库存明细', '3', 'eam:inventory:create', '/manage/inventory/create', 'zmdi zmdi-plus', '1', '1489820150404', '1489820150404');
INSERT INTO `upms_permission` VALUES ('224', '6', '222', '编辑库存明细', '3', 'eam:inventory:update', '/manage/inventory/update', 'zmdi zmdi-edit', '1', '1489820178269', '1489820178269');
INSERT INTO `upms_permission` VALUES ('225', '6', '222', '删除库存明细', '3', 'eam:inventory:delete', '/manage/inventory/delete', 'zmdi zmdi-close', '1', '1489820207607', '1489820207607');

INSERT INTO `upms_permission` VALUES ('226', '6', '0', '备品备件', '1', null, null, 'zmdi zmdi-collection-text', '1', '226', '226');
INSERT INTO `upms_permission` VALUES ('227', '6', '226', '配件类别管理', '2', 'eam:partCategory:read',   '/manage/part/category/index', null, '1', '227', '227');
INSERT INTO `upms_permission` VALUES ('228', '6', '227', '新增配件类别', '3', 'eam:partCategory:create', '/manage/part/category/create', 'zmdi zmdi-plus', '1', '1489820150404', '1489820150404');
INSERT INTO `upms_permission` VALUES ('229', '6', '227', '编辑配件类别', '3', 'eam:partCategory:update', '/manage/part/category/update', 'zmdi zmdi-edit', '1', '1489820178269', '1489820178269');
INSERT INTO `upms_permission` VALUES ('230', '6', '227', '删除配件类别', '3', 'eam:partCategory:delete', '/manage/part/category/delete', 'zmdi zmdi-close', '1', '1489820207607', '1489820207607');

INSERT INTO `upms_permission` VALUES ('231', '6', '226', '配件管理', '2', 'eam:part:read',   '/manage/part/index', null, '1', '231', '231');
INSERT INTO `upms_permission` VALUES ('232', '6', '231', '新增配件', '3', 'eam:part:create', '/manage/part/create', 'zmdi zmdi-plus', '1', '1489820150404', '1489820150404');
INSERT INTO `upms_permission` VALUES ('233', '6', '231', '编辑配件', '3', 'eam:part:update', '/manage/part/update', 'zmdi zmdi-edit', '1', '1489820178269', '1489820178269');
INSERT INTO `upms_permission` VALUES ('234', '6', '231', '删除配件', '3', 'eam:part:delete', '/manage/part/delete', 'zmdi zmdi-close', '1', '1489820207607', '1489820207607');

INSERT INTO `upms_permission` VALUES ('235', '6', '201', '设备模型参数', '2', 'eam:equipmentModelProperty:read',   '/manage/equipmentmodel/property/index', null, '1', '235', '235');
INSERT INTO `upms_permission` VALUES ('236', '6', '235', '新增设备模型参数', '3', 'eam:equipmentModelProperty:create', '/manage/equipment/model/property/create', 'zmdi zmdi-plus', '1', '1489820150404', '1489820150404');
INSERT INTO `upms_permission` VALUES ('237', '6', '235', '编辑设备模型参数', '3', 'eam:equipmentModelProperty:update', '/manage/equipment/model/property/update', 'zmdi zmdi-edit', '1', '1489820178269', '1489820178269');
INSERT INTO `upms_permission` VALUES ('238', '6', '235', '删除设备模型参数', '3', 'eam:equipmentModelProperty:delete', '/manage/equipment/model/property/delete', 'zmdi zmdi-close', '1', '1489820207607', '1489820207607');

INSERT INTO `upms_permission` VALUES ('239', '6', '0', ' 维保管理', '1', null, null, 'zmdi zmdi-collection-text', '1', '239', '239');
INSERT INTO `upms_permission` VALUES ('240', '6', '239', '设备维保', '2', 'eam:maintain:read',   '/manage/maintain/index', null, '1', '240', '240');
INSERT INTO `upms_permission` VALUES ('241', '6', '240', '新增设备维保', '3', 'eam:maintain:create', '/manage/maintain/create', 'zmdi zmdi-plus', '1', '1489820150404', '1489820150404');
INSERT INTO `upms_permission` VALUES ('242', '6', '240', '编辑设备维保', '3', 'eam:maintain:update', '/manage/maintain/update', 'zmdi zmdi-edit', '1', '1489820178269', '1489820178269');
INSERT INTO `upms_permission` VALUES ('243', '6', '240', '删除设备维保', '3', 'eam:maintain:delete', '/manage/maintain/delete', 'zmdi zmdi-close', '1', '1489820207607', '1489820207607');



DELETE FROM `eam_protocol`
INSERT INTO `eam_protocol` VALUES (1, 'Modbus RTU', '127.0.0.1', 8234);
INSERT INTO `eam_protocol` VALUES (2, 'MQTT', '127.0.0.1', 8233);
