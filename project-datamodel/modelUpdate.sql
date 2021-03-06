use kuyun;

SET SQL_SAFE_UPDATES = 0;
SET FOREIGN_KEY_CHECKS=0;

drop table if exists upms_company;
CREATE TABLE `upms_company` (
  `company_id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `address` varchar(50) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `fax` varchar(15) DEFAULT NULL,
  `zip` varchar(10) DEFAULT NULL,
  `www` varchar(20) DEFAULT NULL,
   create_user_id       int,
   create_time          datetime,
   update_user_id       int,
   update_time          datetime,
   delete_flag          boolean,
  PRIMARY KEY (`company_id`),
  KEY `company_company_410d0aac` (`parent_id`),
  CONSTRAINT `parent_id_refs_id_d95e7d2a` FOREIGN KEY (`parent_id`) REFERENCES `upms_company` (`company_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

drop table if exists upms_user_company;
CREATE TABLE `upms_user_company` (
  `user_company_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '编号',
  `user_id` int(10) unsigned NOT NULL COMMENT '用户编号',
  `company_id` int(10) unsigned NOT NULL COMMENT '公司编号',
  PRIMARY KEY (`user_company_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COMMENT='用户公司关联表';

DROP TABLE IF EXISTS `upms_organization_role`;
CREATE TABLE `upms_organization_role` (
  `organization_role_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '编号',
  `organization_id` int(10) unsigned NOT NULL COMMENT '组织编号',
  `role_id` int(10) DEFAULT NULL COMMENT '角色编号',
  PRIMARY KEY (`organization_role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COMMENT='组织角色关联表';

DROP TABLE IF EXISTS `eam_equipment_company`;
create table eam_equipment_company
(
   equipment_company_id int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '编号',
   equipment_id         varchar(32),
   company_id           int,
   create_user_id       int,
   create_time          datetime,
   update_user_id       int,
   update_time          datetime,
   delete_flag          boolean,
   primary key (equipment_company_id)
);

 
  
ALTER TABLE eam_equipment ADD modbus_rtu_period  int;

ALTER TABLE upms_organization ADD company_id  int;

ALTER TABLE eam_equipment change organization_id company_id int;
ALTER TABLE eam_equipment_model change organization_id company_id int;
ALTER TABLE eam_equipment_model_properties change organization_id company_id int;
ALTER TABLE eam_sensor change organization_id company_id int;
ALTER TABLE eam_sensor_data change organization_id company_id int;
ALTER TABLE eam_inventory change organization_id company_id int;
ALTER TABLE eam_warehouse change organization_id company_id int;
ALTER TABLE eam_location change organization_id company_id int;
ALTER TABLE eam_maintenance change organization_id company_id int;
ALTER TABLE eam_parts change organization_id company_id int;
ALTER TABLE eam_parts_category change organization_id company_id int;
ALTER TABLE eam_alarm change organization_id company_id int;
ALTER TABLE eam_alarm_target_user change organization_id company_id int;
ALTER TABLE eam_alarm_record change organization_id company_id int;
ALTER TABLE eam_ticket_type change organization_id company_id int;
ALTER TABLE eam_ticket change organization_id company_id int;
ALTER TABLE eam_ticket_record change organization_id company_id int;

ALTER TABLE mkt_sms_setting change organization_id company_id int;
ALTER TABLE mkt_sms_template change organization_id company_id int;
ALTER TABLE mkt_sms change organization_id company_id int;
ALTER TABLE mkt_sms_user change organization_id company_id int;

ALTER TABLE fd_files change organization_id company_id int;
ALTER TABLE fd_oss_files change organization_id company_id int;


insert eam_equipment_company(equipment_id, company_id, delete_flag)
select equipment_id, company_id, 0 from eam_equipment;

ALTER TABLE eam_equipment DROP COLUMN company_id;

ALTER TABLE eam_sensor DROP grm_variable_order;

insert upms_company (company_id, name, delete_flag)
SELECT organization_id, name, 0 FROM upms_organization;

insert upms_user_company(user_id, company_id)
select user_id, organization_id from upms_user_organization;


INSERT INTO `upms_permission` VALUES ('90', '1', '1', '公司管理', '2', 'upms:company:read', '/manage/company/index', '', '1', '2', '2');
INSERT INTO `upms_permission` VALUES ('91', '1', '90', '新增公司', '3', 'upms:company:create', '/manage/company/create', 'zmdi zmdi-plus', '1', '1489820150404', '1489820150404');
INSERT INTO `upms_permission` VALUES ('92', '1', '90', '编辑公司', '3', 'upms:company:update', '/manage/company/update', 'zmdi zmdi-edit', '1', '1489820178269', '1489820178269');
INSERT INTO `upms_permission` VALUES ('93', '1', '90', '删除公司', '3', 'upms:company:delete', '/manage/company/delete', 'zmdi zmdi-close', '1', '1489820207607', '1489820207607');

INSERT INTO `upms_permission` VALUES ('219', '6', '0', ' 客户管理', '1', null, null, 'zmdi zmdi-collection-text', '1', '219', '219');
INSERT INTO `upms_permission` VALUES ('270', '6', '219', '客户管理', '2', 'eam:company:read',   '/manage/company/index', null, '1', '270', '270');
INSERT INTO `upms_permission` VALUES ('271', '6', '270', '新增客户', '3', 'eam:company:create', '/manage/company/create', 'zmdi zmdi-plus', '1', '1489820150404', '1489820150404');
INSERT INTO `upms_permission` VALUES ('272', '6', '270', '编辑客户', '3', 'eam:company:update', '/manage/company/update', 'zmdi zmdi-edit', '1', '1489820178269', '1489820178269');
INSERT INTO `upms_permission` VALUES ('273', '6', '270', '删除客户', '3', 'eam:company:delete', '/manage/company/delete', 'zmdi zmdi-close', '1', '1489820207607', '1489820207607');

INSERT INTO `upms_permission` VALUES ('280', '6', '205', '数据写入', '3', 'eam:equipmentSensor:write', '/manage/equipment/sensor/', 'zmdi zmdi-edit', '1', '1489820178269', '1489820178269');


RENAME TABLE  eam_sensor_data TO  eam_sensor_data_history;

create index eam_sensor_data_create_time on eam_sensor_data_history (create_time desc);

create table eam_sensor_data
(
   sensor_data_id       int not null auto_increment,
   equipment_id         varchar(32),
   sensor_id            int,
   string_value         varchar(50),
   number_value         decimal(10,2),
   boolean_value        boolean,
   longitude_value      decimal(10,5),
   latitude_value       decimal(10,5),
   create_user_id       int,
   create_time          datetime,
   update_user_id       int,
   update_time          datetime,
   delete_flag          boolean,
   company_id      int,
   primary key (sensor_data_id)
);

CREATE TABLE `eam_alarm_record_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `alarm_id`            int(11),
   equipment_id         varchar(32),
   equipment_model_property_id int,
   alarm_value          varchar(50),
   alarm_status         varchar(10),
   create_user_id       int,
   create_time          datetime,
   update_user_id       int,
   update_time          datetime,
   delete_flag          boolean,
   company_id      int,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE eam_alarm_record ADD alarm_value varchar(50);
ALTER TABLE eam_alarm_record ADD alarm_status varchar(10);
ALTER TABLE eam_alarm_record DROP COLUMN sensor_data_id;

ALTER TABLE eam_alarm_record_history ADD alarm_clear_value    varchar(50);


create table eam_sensor_write_data
(
   id       int not null auto_increment,
   equipment_id         varchar(32),
   sensor_id            int,
   equipment_model_id   int,
   equipment_model_property_id int,
   write_value         varchar(50),
   create_user_id       int,
   create_time          datetime,
   update_user_id       int,
   update_time          datetime,
   delete_flag          boolean,
   company_id      int,
   primary key (id)
);

create table eam_sensor_write_data_history
(
   id       int not null auto_increment,
   equipment_id         varchar(32),
   sensor_id            int,
   equipment_model_id   int,
   equipment_model_property_id int,
   write_value         varchar(50),
   create_user_id       int,
   create_time          datetime,
   update_user_id       int,
   update_time          datetime,
   delete_flag          boolean,
   company_id      int,
   primary key (id)
);


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


ALTER TABLE eam_equipment ADD salve_id  int  comment 'Modbus RTU 从站地址';
--ALTER TABLE eam_sensor DROP COLUMN salve_id;

create table eam_dtu
(
   dtu_id         varchar(32),
   name           varchar(50),
   heart_data           varchar(50) comment '心跳包',
   modbus_rtu_period    int  comment '采集频率',
   create_user_id       int,
   create_time          datetime,
   update_user_id       int,
   update_time          datetime,
   delete_flag          boolean,
   company_id      int,
   primary key (dtu_id)
);

create table eam_dtu_equipment
(
   id                   int not null auto_increment,
   dtu_id               varchar(32),
   equipment_id         varchar(32),
   create_user_id       int,
   create_time          datetime,
   update_user_id       int,
   update_time          datetime,
   delete_flag          boolean,
   company_id      int,
   primary key (id)
);

INSERT INTO `upms_permission` VALUES ('290', '6', '0', 'DTU管理', '1', null, null, 'zmdi zmdi-collection-text', '1', '205', '205');
INSERT INTO `upms_permission` VALUES ('291', '6', '290', 'DTU管理', '2', 'eam:dtu:read',   '/manage/dtu/index', null, '1', '291', '291');
INSERT INTO `upms_permission` VALUES ('292', '6', '291', '新增DTU', '3', 'eam:dtu:create', '/manage/dtu/create', 'zmdi zmdi-plus', '1', '1489820150404', '1489820150404');
INSERT INTO `upms_permission` VALUES ('293', '6', '291', '编辑DTU', '3', 'eam:dtu:update', '/manage/dtu/update', 'zmdi zmdi-edit', '1', '1489820178269', '1489820178269');
INSERT INTO `upms_permission` VALUES ('294', '6', '291', '删除DTU', '3', 'eam:dtu:delete', '/manage/dtu/delete', 'zmdi zmdi-close', '1', '1489820207607', '1489820207607');


create table eam_equipment_category
(
   equipment_category_id   int not null auto_increment,
   name                 varchar(30),
   create_user_id       int,
   create_time          datetime,
   update_user_id       int,
   update_time          datetime,
   delete_flag          boolean,
   company_id           int,
   primary key (equipment_category_id)
);

ALTER TABLE eam_equipment ADD equipment_category_id int;
ALTER TABLE eam_ticket ADD equipment_category_id int;
ALTER TABLE eam_ticket ADD equipment_id int;
ALTER TABLE eam_ticket ADD voice_path int;

INSERT INTO `upms_permission` VALUES ('295', '6', '200', '设备类别', '2', 'eam:equipmentCategory:read',   '/manage/equipment/category/index', null, '1', '202', '202');
INSERT INTO `upms_permission` VALUES ('296', '6', '295', '新增设备类别', '3', 'eam:equipmentCategory:create', '/manage/equipment/category/create', 'zmdi zmdi-plus', '1', '1489820150404', '1489820150404');
INSERT INTO `upms_permission` VALUES ('297', '6', '295', '编辑设备类别', '3', 'eam:equipmentCategory:update', '/manage/equipment/category/update', 'zmdi zmdi-edit', '1', '1489820178269', '1489820178269');
INSERT INTO `upms_permission` VALUES ('298', '6', '295', '删除设备类别', '3', 'eam:equipmentCategory:delete', '/manage/equipment/category/delete', 'zmdi zmdi-close', '1', '1489820207607', '1489820207607');


delete from upms_permission where permission_id >= 2000;


DELIMITER //  

CREATE PROCEDURE update_user_permissions()
BEGIN
  

  DECLARE v_user_id int;
  DECLARE v_permission_id int;

  DECLARE done int;

  delete from upms_user_permission;

  DECLARE cursor_user CURSOR FOR SELECT user_id FROM upms_user;
  DECLARE curson_permission CURSOR FOR SELECT permission_id FROM upms_permission WHERE permission_id >=200 and permission_id <2000;
  
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
  

  OPEN cursor_user;
out_loop:
LOOP
  FETCH cursor_user INTO v_user_id;
  IF done = 1 THEN
    LEAVE out_loop;
  END IF;
  
  open curson_permission;
  inner_loop:LOOP
     
    FETCH curson_permission INTO v_permission_id; 
    IF done = 1 THEN
       LEAVE inner_loop;
     end IF;
     

   set v_line_count  = v_line_count + 1;

   SELECT SUM(purchase_quantity) FROM order_orderline WHERE documentLineItem_id = v_doc_line_id into v_total_purch_qty;   

   if v_total_purch_qty > 0 then
    
    
    if v_expected_quantity > 0 then 
           SET v_quantity = v_expected_quantity;
         end if;

        if v_audit_quantity > 0 then 
           SET v_quantity = v_audit_quantity;
         end if;
    
    
    if v_quantity = v_total_purch_qty then
      SET v_count = v_count +1;
    end if;
    
        if v_total_purch_qty < v_quantity then
      set v_status = '采购中';
    end if;

     end if;
  
  end LOOP inner_loop;
  CLOSE curson_permission; 
   
  /** SET @output_string = concat('count:', v_count, ',line_count:', v_line_count, ',document:', v_doc_id, ',document_line:', v_doc_line_id);
  SELECT @output_string;
  **/

  if v_count = v_line_count then
     set v_status = '采购完成';
   end if;
  
  if v_count > 0 and v_count < v_line_count then
     set v_status = '采购中';
   end if;
   

  update document_document set purch_status = v_status where id = v_doc_id;
  SET done=0;
END LOOP out_loop;
  CLOSE cursor_user;
END//