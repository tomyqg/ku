package com.kuyun.eam.admin.controller.manager;

import com.baidu.unbiz.fluentvalidator.ComplexResult;
import com.baidu.unbiz.fluentvalidator.FluentValidator;
import com.baidu.unbiz.fluentvalidator.ResultCollectors;
import com.google.common.base.Splitter;
import com.kuyun.common.base.BaseController;
import com.kuyun.common.validator.LengthValidator;
import com.kuyun.eam.common.constant.EamResult;
import com.kuyun.eam.common.constant.EamResultConstant;
import com.kuyun.eam.common.constant.TicketSearchCategory;
import com.kuyun.eam.common.constant.TicketStatus;
import com.kuyun.eam.dao.model.*;
import com.kuyun.eam.rpc.api.*;
import com.kuyun.eam.vo.EamEquipmentVO;
import com.kuyun.eam.vo.EamTicketVO;
import com.kuyun.upms.client.util.BaseEntityUtil;
import com.kuyun.upms.dao.model.UpmsUser;
import com.kuyun.upms.dao.model.UpmsUserCompany;
import com.kuyun.upms.rpc.api.UpmsApiService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.apache.commons.lang.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.datetime.DateFormatter;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

import java.util.*;

import static com.kuyun.eam.common.constant.EamResultConstant.SUCCESS;


public abstract class EamTicketBaseController extends BaseController {

    private static Logger _log = LoggerFactory.getLogger(EamTicketController.class);
    @Autowired
    public EamApiService eamApiService;
    @Autowired
    private BaseEntityUtil baseEntityUtil;
    @Autowired
    public EamTicketTypeService eamTicketTypeService;

    @Autowired
    public EamEquipmentCategoryService eamEquipmentCategoryService;

    @Autowired
    public EamEquipmentService eamEquipmentService;

    @Autowired
    public UpmsApiService upmsApiService;

    @Autowired
    private EamTicketRecordService eamTicketRecordService;

    @Autowired
    public com.kuyun.fileuploader.rpc.api.FileUploaderService fileUploaderService;

	public void setTicketInfo( int id, ModelMap modelMap) {
		EamTicketExample ete = new EamTicketExample();
		ete.createCriteria().andTicketIdEqualTo(id);
		EamTicketVO eamTicket = eamApiService.selectTicket(ete).get(0);
		modelMap.put("ticket", eamTicket);
		
		//retrieve the image list
		List<String> imageList =  new ArrayList<String>();
		if(eamTicket.getImagePath() != null) {
			for (String uuid : Splitter.on(',')
					.trimResults()
					.omitEmptyStrings()
					.split(eamTicket.getImagePath())) {
				imageList.add(fileUploaderService.getServerInfo().getEndpoint_show() + "/" + uuid);
			}
		}
		modelMap.put("imageList", imageList);

		//retrieve the voice list
		List<String> voiceList =  new ArrayList<String>();
		if(eamTicket.getVoicePath() != null) {
			for (String uuid : Splitter.on(',')
					.trimResults()
					.omitEmptyStrings()
					.split(eamTicket.getVoicePath())) {
				voiceList.add(fileUploaderService.getServerInfo().getEndpoint_show() + "/" + uuid);
			}
		}
		modelMap.put("voiceList", voiceList);

        EamTicketRecordExample etre = new EamTicketRecordExample();
		etre.createCriteria().andTicketIdEqualTo(id);
		etre.setOrderByClause("eam_ticket_record_create_time desc");

		List<EamTicketRecord> records = eamTicketRecordService.selectByExample(etre);
		modelMap.put("records", records);
	}

    public void selectTicketUpdate(ModelMap modelMap){
        List<UpmsUser> users = upmsApiService.selectUsersByUserId(baseEntityUtil.getCurrentUser().getUserId());

        modelMap.put("users", users);
        List<EamTicketType> types = eamTicketTypeService.selectByExample(new EamTicketTypeExample());
        modelMap.put("ticketTypes", types);

        List<EamEquipmentCategory> cats = eamEquipmentCategoryService.selectByExample(new EamEquipmentCategoryExample());
        modelMap.addAttribute("equipmentCategorys", cats);

        EamEquipmentVO equipmentVO = new EamEquipmentVO();
        UpmsUserCompany company = baseEntityUtil.getCurrentUserCompany();
        if (company != null){
            equipmentVO.setCompanyId(company.getCompanyId());
        }
        List<EamEquipmentVO> rows = eamApiService.selectEquipments(equipmentVO);
        modelMap.addAttribute("equipments", rows);

        modelMap.put("uploadServer", fileUploaderService.getServerInfo());
    }

    public int getCurrUserId(){
		return baseEntityUtil.getCurrentUser().getUserId();
	}

}