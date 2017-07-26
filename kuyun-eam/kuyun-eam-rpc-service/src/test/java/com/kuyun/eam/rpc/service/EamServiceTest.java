package com.kuyun.eam.rpc.service;


import com.kuyun.eam.dao.model.*;
import com.kuyun.eam.rpc.api.EamApiService;
import com.kuyun.eam.rpc.api.EamEquipmentModelService;
import com.kuyun.eam.rpc.api.EamTicketRecordService;
import com.kuyun.eam.rpc.api.EamTicketService;
import com.kuyun.eam.rpc.api.EamTicketTypeService;
import com.kuyun.eam.rpc.api.EamWarehouseService;
import com.kuyun.eam.vo.EamLocationVO;
import com.kuyun.eam.vo.EamMaintenanceVO;
import com.kuyun.upms.dao.model.UpmsOrganization;

import org.apache.commons.lang.StringUtils;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.transaction.TransactionConfiguration;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 单元测试
 * Created by kuyun on 2017/2/19.
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({
        "classpath:applicationContext.xml",
        "classpath:META-INF/spring/applicationContext-jdbc.xml",
        "classpath:META-INF/spring/applicationContext-listener.xml"
})
@TransactionConfiguration(transactionManager = "transactionManager", defaultRollback = true)
public class EamServiceTest {

    @SuppressWarnings("SpringJavaAutowiringInspection")
    @Autowired
    private EamApiService eamApiService;

    @SuppressWarnings("SpringJavaAutowiringInspection")
    @Autowired
    private EamEquipmentModelService eamEquipmentModelService;

    @SuppressWarnings("SpringJavaAutowiringInspection")
    @Autowired
    private EamWarehouseService warehouseService;
    
    @SuppressWarnings("SpringJavaAutowiringInspection")
    @Autowired
    private EamTicketService eamTicketService;
    
    @SuppressWarnings("SpringJavaAutowiringInspection")
    @Autowired
    private EamTicketRecordService eamTicketRecordService;
    
    @SuppressWarnings("SpringJavaAutowiringInspection")
    @Autowired
    private EamTicketTypeService eamTicketTypeService;
    

    @Test
    public void list() {


//        List<EamMaintenanceVO> maintenances = eamApiService.selectMaintenance(new EamMaintenanceExample());
//        System.out.println("maintenance size = " + maintenances.size());

//        EamEquipmentModelExample eamEquipmentModelExample = new EamEquipmentModelExample();
//        eamEquipmentModelExample.setLimit(10);
//        eamEquipmentModelExample.setOffset(0);
//
//        List<EamEquipmentModel> rows = eamEquipmentModelService.selectByExample(eamEquipmentModelExample);
//
//        System.out.println("rows size = " + rows.size());

//        EamWarehouse warehouse = new EamWarehouse();
//        warehouse.setName("dd");
//
//        warehouseService.insertSelective(warehouse);
//        warehouseService.deleteByPrimaryKey(1);
//
//        EamMaintenanceExample eamMaintenanceExample = new EamMaintenanceExample();
//        eamMaintenanceExample.createCriteria().andMaintenanceIdEqualTo(1).andEquipmentIdEqualTo(1);
//        eamApiService.selectMaintenance(eamMaintenanceExample);

//        eamApiService.selectLocation(new EamLocationVO());
//        eamEquipmentModelService.deleteByPrimaryKey(3);
    		EamTicketType tt = new EamTicketType();
    		tt.setName("手工工单");
    		int pk = eamTicketTypeService.insert(tt);
    		System.out.println("create ticket Type : "+ tt.getName()+" has PK :"+ pk);
    		eamTicketTypeService.deleteByPrimaryKey(pk);
    		System.out.println("delete PK :"+ pk);
    		
    		int offset = 0;
		int limit = 10;
		String sort = "";
		String order = "";
		
    		EamTicketTypeExample eamTicketTypeExample = new EamTicketTypeExample();
    		eamTicketTypeExample.setOffset(offset);
    		eamTicketTypeExample.setLimit(limit);
    		if (!StringUtils.isBlank(sort) && !StringUtils.isBlank(order)) {
    			eamTicketTypeExample.setOrderByClause(sort + ", " + order);
    		}

//    		UpmsOrganization organization = eamUtils.getCurrentUserParentOrignization();
//
//    		if (organization != null){
//    			eamTicketTypeExample.createCriteria().andOrganizationIdEqualTo(organization.getOrganizationId())
//    			.andDeleteFlagEqualTo(Boolean.FALSE);
//    		}


    		List<EamTicketType> rows = eamTicketTypeService.selectByExample(eamTicketTypeExample);
    		long total = eamTicketTypeService.countByExample(eamTicketTypeExample);
    		Map<String, Object> result = new HashMap<>();
    		result.put("rows", rows);
    		result.put("total", total);
    		
    		 
    }

}
