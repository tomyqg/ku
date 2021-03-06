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

#系统设置
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

INSERT INTO `upms_permission` VALUES ('210', '6', '0', '报警设置', '1', null, null, 'zmdi zmdi-collection-text', '1', '210', '210');
INSERT INTO `upms_permission` VALUES ('211', '6', '210', '报警管理', '2', 'eam:alarm:read',   '/manage/alarm/index', null, '1', '211', '211');
INSERT INTO `upms_permission` VALUES ('212', '6', '211', '新增报警', '3', 'eam:alarm:create', '/manage/alarm/create', 'zmdi zmdi-plus', '1', '1489820150404', '1489820150404');
INSERT INTO `upms_permission` VALUES ('213', '6', '211', '编辑报警', '3', 'eam:alarm:update', '/manage/alarm/update', 'zmdi zmdi-edit', '1', '1489820178269', '1489820178269');
INSERT INTO `upms_permission` VALUES ('214', '6', '211', '删除报警', '3', 'eam:alarm:delete', '/manage/alarm/delete', 'zmdi zmdi-close', '1', '1489820207607', '1489820207607');

INSERT INTO `upms_permission` VALUES ('215', '6', '0', '数据采集', '1', null, null, 'zmdi zmdi-collection-text', '1', '210', '210');
INSERT INTO `upms_permission` VALUES ('216', '6', '215', '数据采集', '2', 'eam:equipment:update',   '/manage/equipment/collect/index', null, '1', '216', '216');
INSERT INTO `upms_permission` VALUES ('217', '6', '216', '启动', '3', 'eam:equipment:update', '/manage/equipment/collect/start', 'zmdi zmdi-plus', '1', '1489820150404', '1489820150404');
INSERT INTO `upms_permission` VALUES ('218', '6', '216', '停止', '3', 'eam:equipment:update', '/manage/equipment/collect/stop', 'zmdi zmdi-edit', '1', '1489820178269', '1489820178269');


INSERT INTO `upms_permission` VALUES ('220', '6', '0', ' 仓储管理', '1', null, null, 'zmdi zmdi-collection-text', '1', '220', '220');
INSERT INTO `upms_permission` VALUES ('221', '6', '220', '仓库管理', '2', 'eam:warehouse:read',   '/manage/warehouse/index', null, '1', '221', '221');
INSERT INTO `upms_permission` VALUES ('222', '6', '221', '新增仓库', '3', 'eam:warehouse:create', '/manage/warehouse/create', 'zmdi zmdi-plus', '1', '1489820150404', '1489820150404');
INSERT INTO `upms_permission` VALUES ('223', '6', '221', '编辑仓库', '3', 'eam:warehouse:update', '/manage/warehouse/update', 'zmdi zmdi-edit', '1', '1489820178269', '1489820178269');
INSERT INTO `upms_permission` VALUES ('224', '6', '221', '删除仓库', '3', 'eam:warehouse:delete', '/manage/warehouse/delete', 'zmdi zmdi-close', '1', '1489820207607', '1489820207607');

INSERT INTO `upms_permission` VALUES ('225', '6', '220', '仓位管理', '2', 'eam:location:read',   '/manage/location/index', null, '1', '225', '225');
INSERT INTO `upms_permission` VALUES ('226', '6', '225', '新增仓位', '3', 'eam:location:create', '/manage/location/create', 'zmdi zmdi-plus', '1', '1489820150404', '1489820150404');
INSERT INTO `upms_permission` VALUES ('227', '6', '225', '编辑仓位', '3', 'eam:location:update', '/manage/location/update', 'zmdi zmdi-edit', '1', '1489820178269', '1489820178269');
INSERT INTO `upms_permission` VALUES ('228', '6', '225', '删除仓位', '3', 'eam:location:delete', '/manage/location/delete', 'zmdi zmdi-close', '1', '1489820207607', '1489820207607');

INSERT INTO `upms_permission` VALUES ('229', '6', '220', '库存管理', '2', 'eam:inventory:read',   '/manage/inventory/index', null, '1', '229', '229');
INSERT INTO `upms_permission` VALUES ('230', '6', '229', '新增库存明细', '3', 'eam:inventory:create', '/manage/inventory/create', 'zmdi zmdi-plus', '1', '1489820150404', '1489820150404');
INSERT INTO `upms_permission` VALUES ('231', '6', '229', '编辑库存明细', '3', 'eam:inventory:update', '/manage/inventory/update', 'zmdi zmdi-edit', '1', '1489820178269', '1489820178269');
INSERT INTO `upms_permission` VALUES ('232', '6', '229', '删除库存明细', '3', 'eam:inventory:delete', '/manage/inventory/delete', 'zmdi zmdi-close', '1', '1489820207607', '1489820207607');

INSERT INTO `upms_permission` VALUES ('240', '6', '0', '备品备件', '1', null, null, 'zmdi zmdi-collection-text', '1', '240', '240');
INSERT INTO `upms_permission` VALUES ('241', '6', '240', '配件类别管理', '2', 'eam:partCategory:read',   '/manage/part/category/index', null, '1', '241', '241');
INSERT INTO `upms_permission` VALUES ('242', '6', '241', '新增配件类别', '3', 'eam:partCategory:create', '/manage/part/category/create', 'zmdi zmdi-plus', '1', '1489820150404', '1489820150404');
INSERT INTO `upms_permission` VALUES ('243', '6', '241', '编辑配件类别', '3', 'eam:partCategory:update', '/manage/part/category/update', 'zmdi zmdi-edit', '1', '1489820178269', '1489820178269');
INSERT INTO `upms_permission` VALUES ('244', '6', '241', '删除配件类别', '3', 'eam:partCategory:delete', '/manage/part/category/delete', 'zmdi zmdi-close', '1', '1489820207607', '1489820207607');

INSERT INTO `upms_permission` VALUES ('245', '6', '240', '配件管理', '2', 'eam:part:read',   '/manage/part/index', null, '1', '245', '245');
INSERT INTO `upms_permission` VALUES ('246', '6', '245', '新增配件', '3', 'eam:part:create', '/manage/part/create', 'zmdi zmdi-plus', '1', '1489820150404', '1489820150404');
INSERT INTO `upms_permission` VALUES ('247', '6', '245', '编辑配件', '3', 'eam:part:update', '/manage/part/update', 'zmdi zmdi-edit', '1', '1489820178269', '1489820178269');
INSERT INTO `upms_permission` VALUES ('248', '6', '245', '删除配件', '3', 'eam:part:delete', '/manage/part/delete', 'zmdi zmdi-close', '1', '1489820207607', '1489820207607');

INSERT INTO `upms_permission` VALUES ('250', '6', '200', '设备模型参数', '2', 'eam:equipmentModelProperty:read',   '/manage/equipmentmodel/property/index', null, '1', '202', '202');
INSERT INTO `upms_permission` VALUES ('251', '6', '250', '新增设备模型参数', '3', 'eam:equipmentModelProperty:create', '/manage/equipment/model/property/create', 'zmdi zmdi-plus', '1', '1489820150404', '1489820150404');
INSERT INTO `upms_permission` VALUES ('252', '6', '250', '编辑设备模型参数', '3', 'eam:equipmentModelProperty:update', '/manage/equipment/model/property/update', 'zmdi zmdi-edit', '1', '1489820178269', '1489820178269');
INSERT INTO `upms_permission` VALUES ('253', '6', '250', '删除设备模型参数', '3', 'eam:equipmentModelProperty:delete', '/manage/equipment/model/property/delete', 'zmdi zmdi-close', '1', '1489820207607', '1489820207607');



INSERT INTO `upms_permission` VALUES ('260', '6', '0', ' 维保管理', '1', null, null, 'zmdi zmdi-collection-text', '1', '260', '260');
INSERT INTO `upms_permission` VALUES ('261', '6', '260', '设备维保', '2', 'eam:maintain:read',   '/manage/maintain/index', null, '1', '261', '261');
INSERT INTO `upms_permission` VALUES ('262', '6', '261', '新增设备维保', '3', 'eam:maintain:create', '/manage/maintain/create', 'zmdi zmdi-plus', '1', '1489820150404', '1489820150404');
INSERT INTO `upms_permission` VALUES ('263', '6', '261', '编辑设备维保', '3', 'eam:maintain:update', '/manage/maintain/update', 'zmdi zmdi-edit', '1', '1489820178269', '1489820178269');
INSERT INTO `upms_permission` VALUES ('264', '6', '261', '删除设备维保', '3', 'eam:maintain:delete', '/manage/maintain/delete', 'zmdi zmdi-close', '1', '1489820207607', '1489820207607');

INSERT INTO `upms_permission` VALUES ('219', '6', '0', ' 客户管理', '1', null, null, 'zmdi zmdi-collection-text', '1', '219', '219');
INSERT INTO `upms_permission` VALUES ('270', '6', '219', '客户管理', '2', 'eam:company:read',   '/manage/company/index', null, '1', '270', '270');
INSERT INTO `upms_permission` VALUES ('271', '6', '270', '新增客户', '3', 'eam:company:create', '/manage/company/create', 'zmdi zmdi-plus', '1', '1489820150404', '1489820150404');
INSERT INTO `upms_permission` VALUES ('272', '6', '270', '编辑客户', '3', 'eam:company:update', '/manage/company/update', 'zmdi zmdi-edit', '1', '1489820178269', '1489820178269');
INSERT INTO `upms_permission` VALUES ('273', '6', '270', '删除客户', '3', 'eam:company:delete', '/manage/company/delete', 'zmdi zmdi-close', '1', '1489820207607', '1489820207607');

INSERT INTO `upms_permission` VALUES ('280', '6', '205', '数据写入', '3', 'eam:equipmentSensor:write', '/manage/equipment/sensor/', 'zmdi zmdi-edit', '1', '1489820178269', '1489820178269');


INSERT INTO `upms_permission` VALUES ('290', '6', '0', 'DTU管理', '1', null, null, 'zmdi zmdi-collection-text', '1', '205', '205');
INSERT INTO `upms_permission` VALUES ('291', '6', '290', 'DTU管理', '2', 'eam:dtu:read',   '/manage/dtu/index', null, '1', '291', '291');
INSERT INTO `upms_permission` VALUES ('292', '6', '291', '新增DTU', '3', 'eam:dtu:create', '/manage/dtu/create', 'zmdi zmdi-plus', '1', '1489820150404', '1489820150404');
INSERT INTO `upms_permission` VALUES ('293', '6', '291', '编辑DTU', '3', 'eam:dtu:update', '/manage/dtu/update', 'zmdi zmdi-edit', '1', '1489820178269', '1489820178269');
INSERT INTO `upms_permission` VALUES ('294', '6', '291', '删除DTU', '3', 'eam:dtu:delete', '/manage/dtu/delete', 'zmdi zmdi-close', '1', '1489820207607', '1489820207607');

INSERT INTO `upms_permission` VALUES ('295', '6', '200', '设备类别', '2', 'eam:equipmentCategory:read',   '/manage/equipment/category/index', null, '1', '202', '202');
INSERT INTO `upms_permission` VALUES ('296', '6', '295', '新增设备类别', '3', 'eam:equipmentCategory:create', '/manage/equipment/category/create', 'zmdi zmdi-plus', '1', '1489820150404', '1489820150404');
INSERT INTO `upms_permission` VALUES ('297', '6', '295', '编辑设备类别', '3', 'eam:equipmentCategory:update', '/manage/equipment/category/update', 'zmdi zmdi-edit', '1', '1489820178269', '1489820178269');
INSERT INTO `upms_permission` VALUES ('298', '6', '295', '删除设备类别', '3', 'eam:equipmentCategory:delete', '/manage/equipment/category/delete', 'zmdi zmdi-close', '1', '1489820207607', '1489820207607');


# prepare ticket menu items, id start with 300 

INSERT INTO `upms_permission` VALUES ('300', '6', '0', '工单管理', '1', null, null, 'zmdi zmdi-collection-text', '1', '220', '300');
INSERT INTO `upms_permission` VALUES ('310', '6', '300', '工单类型', '2', 'eam:ticketType:read',   '/manage/ticket/type/index', null, '1', '221', '310');
INSERT INTO `upms_permission` VALUES ('311', '6', '310', '新增类型', '3', 'eam:ticketType:create', '/manage/ticket/type/create', 'zmdi zmdi-plus', '1', '1489820150404', '311');
INSERT INTO `upms_permission` VALUES ('312', '6', '310', '编辑类型', '3', 'eam:ticketType:update', '/manage/ticket/type/update', 'zmdi zmdi-edit', '1', '1489820178269', '312');
INSERT INTO `upms_permission` VALUES ('313', '6', '310', '删除类型', '3', 'eam:ticketType:delete', '/manage/ticket/type/delete', 'zmdi zmdi-close', '1', '1489820207607', '313');

INSERT INTO `upms_permission` VALUES ('320', '6', '300', '我的未处理工单', '2', 'eam:ticket:read',   '/manage/ticket/index?category=myOpen', null, '1', '225', '320');
INSERT INTO `upms_permission` VALUES ('330', '6', '300', '我的全部工单', '2', 'eam:ticket:read',   '/manage/ticket/index?category=myAll', null, '1', '225', '330');
INSERT INTO `upms_permission` VALUES ('340', '6', '300', '未处理工单', '2', 'eam:ticket:read',   '/manage/ticket/index?category=open', null, '1', '225', '340');
INSERT INTO `upms_permission` VALUES ('350', '6', '300', '全部工单', '2', 'eam:ticket:read',   '/manage/ticket/index?category=all', null, '1', '225', '350');
INSERT INTO `upms_permission` VALUES ('351', '6', '350', '新增工单', '3', 'eam:ticket:create', '/manage/ticket/create', 'zmdi zmdi-plus', '1', '1489820150404', '1489820150404');
INSERT INTO `upms_permission` VALUES ('352', '6', '350', '编辑工单', '3', 'eam:ticket:update', '/manage/ticket/update', 'zmdi zmdi-edit', '1', '1489820178269', '1489820178269');
INSERT INTO `upms_permission` VALUES ('353', '6', '350', '解决工单（不需处理）', '3', 'eam:ticket:noNeedOperation', '/manage/ticket/noNeedOperation', 'zmdi zmdi-close', '1', '1489820207607', '1489820207607');


INSERT INTO `upms_permission` VALUES ('400', '6', '0', '知识管理', '1', null, null, 'zmdi zmdi-collection-text', '1', '400', '400');
INSERT INTO `upms_permission` VALUES ('401', '6', '400', '知识搜索', '2', 'eam:knowledge:read',   '/manage/knowledge/index', null, '1', '270', '270');
INSERT INTO `upms_permission` VALUES ('402', '6', '400', '培训视频', '2', 'eam:trainingVideo:read',   '/manage/knowledge/training/video/index', null, '1', '270', '270');
INSERT INTO `upms_permission` VALUES ('403', '6', '402', '新增培训视频', '3', 'eam:trainingVideo:create', '/manage/knowledge/training/video/create', 'zmdi zmdi-plus', '1', '1489820150404', '1489820150404');
INSERT INTO `upms_permission` VALUES ('404', '6', '402', '编辑培训视频', '3', 'eam:trainingVideo:update', '/manage/knowledge/training/video/update', 'zmdi zmdi-edit', '1', '1489820178269', '1489820178269');
INSERT INTO `upms_permission` VALUES ('405', '6', '402', '删除培训视频', '3', 'eam:trainingVideo:delete', '/manage/knowledge/training/video/delete', 'zmdi zmdi-close', '1', '1489820207607', '1489820207607');

INSERT INTO `upms_permission` VALUES ('406', '6', '400', '培训文档', '2', 'eam:trainingDoc:read',   '/manage/knowledge/training/doc/index', null, '1', '270', '270');
INSERT INTO `upms_permission` VALUES ('407', '6', '406', '新增培训文档', '3', 'eam:trainingDoc:create', '/manage/knowledge/training/doc/create', 'zmdi zmdi-plus', '1', '1489820150404', '1489820150404');
INSERT INTO `upms_permission` VALUES ('408', '6', '406', '编辑培训文档', '3', 'eam:trainingDoc:update', '/manage/knowledge/training/doc/update', 'zmdi zmdi-edit', '1', '1489820178269', '1489820178269');
INSERT INTO `upms_permission` VALUES ('409', '6', '406', '删除培训文档', '3', 'eam:trainingDoc:delete', '/manage/knowledge/training/doc/delete', 'zmdi zmdi-close', '1', '1489820207607', '1489820207607');

INSERT INTO `upms_permission` VALUES ('410', '6', '400', '保养知识', '2', 'eam:maintainKnowledge:read',   '/manage/knowledge/maintain/index', null, '1', '270', '270');
INSERT INTO `upms_permission` VALUES ('411', '6', '410', '新增保养知识', '3', 'eam:maintainKnowledge:create', '/manage/knowledge/maintain/create', 'zmdi zmdi-plus', '1', '1489820150404', '1489820150404');
INSERT INTO `upms_permission` VALUES ('412', '6', '410', '编辑保养知识', '3', 'eam:maintainKnowledge:update', '/manage/knowledge/maintain/update', 'zmdi zmdi-edit', '1', '1489820178269', '1489820178269');
INSERT INTO `upms_permission` VALUES ('413', '6', '410', '删除保养知识', '3', 'eam:maintainKnowledge:delete', '/manage/knowledge/maintain/delete', 'zmdi zmdi-close', '1', '1489820207607', '1489820207607');

INSERT INTO `upms_permission` VALUES ('414', '6', '400', '维修知识', '2', 'eam:repairKnowledge:read',   '/manage/knowledge/repair/index', null, '1', '270', '270');
INSERT INTO `upms_permission` VALUES ('415', '6', '414', '新增维修知识', '3', 'eam:repairKnowledge:create', '/manage/knowledge/repair/create', 'zmdi zmdi-plus', '1', '1489820150404', '1489820150404');
INSERT INTO `upms_permission` VALUES ('416', '6', '414', '编辑维修知识', '3', 'eam:repairKnowledge:update', '/manage/knowledge/repair/update', 'zmdi zmdi-edit', '1', '1489820178269', '1489820178269');
INSERT INTO `upms_permission` VALUES ('417', '6', '414', '删除维修知识', '3', 'eam:repairKnowledge:delete', '/manage/knowledge/repair/delete', 'zmdi zmdi-close', '1', '1489820207607', '1489820207607');

INSERT INTO `upms_permission` VALUES ('418', '6', '400', '设备手册', '2', 'eam:equipmentManual:read',   '/manage/knowledge/manual/index', null, '1', '270', '270');
INSERT INTO `upms_permission` VALUES ('419', '6', '418', '新增设备手册', '3', 'eam:equipmentManual:create', '/manage/knowledge/manual/create', 'zmdi zmdi-plus', '1', '1489820150404', '1489820150404');
INSERT INTO `upms_permission` VALUES ('420', '6', '418', '编辑设备手册', '3', 'eam:equipmentManual:update', '/manage/knowledge/manual/update', 'zmdi zmdi-edit', '1', '1489820178269', '1489820178269');
INSERT INTO `upms_permission` VALUES ('421', '6', '418', '删除设备手册', '3', 'eam:equipmentManual:delete', '/manage/knowledge/manual/delete', 'zmdi zmdi-close', '1', '1489820207607', '1489820207607');


TRUNCATE TABLE `eam_ticket_type`;
INSERT INTO `eam_ticket_type` VALUES (11,'警报工单',1,'2017-07-26 15:51:51',1,'2017-07-26 15:51:51',0,1),(12,'其它工单',1,'2017-07-26 15:52:15',1,'2017-07-26 15:52:15',0,1),(13,'手工工单',1,'2017-07-26 16:23:15',1,'2017-07-26 16:23:15',0,1);
# end prepare ticket menu item

TRUNCATE TABLE `eam_protocol`;
INSERT INTO `eam_protocol` VALUES (1, 'Modbus RTU', '118.89.140.11', 8234);
INSERT INTO `eam_protocol` VALUES (2, 'Modbus TCP', '118.89.140.11', 8233);
INSERT INTO `eam_protocol` VALUES (3, 'MQTT', '118.89.140.11', 8232);
INSERT INTO `eam_protocol` VALUES (4, '巨控', 'www.yunplc.com', 7080);

