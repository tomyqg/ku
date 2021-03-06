package com.kuyun.eam.admin.controller.manager;

import com.baidu.unbiz.fluentvalidator.ComplexResult;
import com.baidu.unbiz.fluentvalidator.FluentValidator;
import com.baidu.unbiz.fluentvalidator.ResultCollectors;
import com.kuyun.common.base.BaseController;
import com.kuyun.common.validator.LengthValidator;
import com.kuyun.eam.common.constant.EamResult;
import com.kuyun.eam.common.constant.TicketStatus;
import com.kuyun.eam.dao.model.EamTicket;
import com.kuyun.eam.dao.model.EamTicketAppointedRecord;
import com.kuyun.eam.dao.model.EamTicketAppointedRecordExample;
import com.kuyun.eam.rpc.api.EamApiService;
import com.kuyun.eam.rpc.api.EamTicketAppointedRecordService;
import com.kuyun.eam.rpc.api.EamTicketService;
import com.kuyun.eam.vo.EamTicketAppointVO;
import com.kuyun.upms.client.util.BaseEntityUtil;
import com.kuyun.upms.dao.model.UpmsUser;
import com.kuyun.upms.dao.model.UpmsUserCompany;
import com.kuyun.upms.dao.vo.UpmsOrgUserVo;
import com.kuyun.upms.rpc.api.UpmsApiService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.apache.commons.lang.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.kuyun.eam.common.constant.EamResultConstant.INVALID_LENGTH;
import static com.kuyun.eam.common.constant.EamResultConstant.SUCCESS;

/**
 * 设备模型控制器
 * Created by kuyun on 2017/4/9.
 */
@Controller
@Api(value = "工单委派管理", description = "工单委派管理")
@RequestMapping("/manage/ticket/{ticketId}/appoint")
public class EamTicketAppointController extends EamTicketBaseController {

	private static Logger _log = LoggerFactory.getLogger(EamTicketAppointController.class);
	
	@Autowired
	private EamTicketService eamTicketService;

	@Autowired
	private EamTicketAppointedRecordService eamTicketAppointRecordService;

	@Autowired
	private UpmsApiService upmsApiService;

	@Autowired
	private BaseEntityUtil baseEntityUtil;

	@Autowired
	private EamApiService eamApiService;

	@ApiOperation(value = "工单委派管理首页")
	@RequiresPermissions("eam:ticketAppointedRecord:read")
	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public String index(@PathVariable("ticketId") int ticketId, ModelMap modelMap) {
		modelMap.addAttribute("ticketId", ticketId);
		return "/manage/ticket/appoint/index.jsp";
	}

	@ApiOperation(value = "工单委派列表")
	@RequiresPermissions("eam:ticketAppointedRecord:read")
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	@ResponseBody
	public Object list(@PathVariable("ticketId") int ticketId,
			@RequestParam(required = false, defaultValue = "0", value = "offset") int offset,
			@RequestParam(required = false, defaultValue = "10", value = "limit") int limit,
			@RequestParam(required = false, value = "sort") String sort,
			@RequestParam(required = false, value = "order") String order) {
		EamTicketAppointedRecordExample eamTicketAppointRecordExample = new EamTicketAppointedRecordExample();
		eamTicketAppointRecordExample.setOffset(offset);
		eamTicketAppointRecordExample.setLimit(limit);
		EamTicketAppointedRecordExample.Criteria criteria = eamTicketAppointRecordExample.createCriteria();
		criteria.andTicketIdEqualTo(ticketId);
		criteria.andDeleteFlagEqualTo(Boolean.FALSE);

		if (!StringUtils.isBlank(sort) && !StringUtils.isBlank(order)) {
			eamTicketAppointRecordExample.setOrderByClause(sort + " " + order);
		}

		UpmsUserCompany company = baseEntityUtil.getCurrentUserCompany();

		if (company != null){
			criteria.andCompanyIdEqualTo(company.getCompanyId());
		}


		List<EamTicketAppointVO> rows = eamApiService.selectTicketAppointRecord(eamTicketAppointRecordExample);
		long total = eamTicketAppointRecordService.countByExample(eamTicketAppointRecordExample);
		Map<String, Object> result = new HashMap<>();
		result.put("rows", rows);
		result.put("total", total);
		return result;
	}

	@ApiOperation(value = "新增工单委派")
	@RequiresPermissions("eam:ticketAppointedRecord:create")
	@RequestMapping(value = "/create", method = RequestMethod.GET)
	public String create(@PathVariable("ticketId") int ticketId, ModelMap modelMap) {
		modelMap.addAttribute("ticketId", ticketId);

        UpmsOrgUserVo orgUserVo = new UpmsOrgUserVo();
        UpmsUserCompany company = baseEntityUtil.getCurrentUserCompany();
        if (company != null){
            orgUserVo.setCompanyId(company.getCompanyId());
        }
        orgUserVo.setOrgName("维修部");

		List<UpmsOrgUserVo> users = upmsApiService.selectOrgUsersByOrgNameCompanyId( orgUserVo);
		modelMap.put("users", users);
        setTicketInfo(  ticketId,  modelMap);
		return "/manage/ticket/appoint/create.jsp";
	}

	@ApiOperation(value = "新增工单委派")
	@RequiresPermissions("eam:ticketAppointedRecord:create")
	@RequestMapping(value = "/create", method = RequestMethod.POST)
	@ResponseBody
	public Object create(EamTicketAppointedRecord ticketAppointRecord) {
		baseEntityUtil.addAddtionalValue(ticketAppointRecord);
		int count = eamTicketAppointRecordService.insertSelective(ticketAppointRecord);
		ticketToProcess(ticketAppointRecord.getTicketId());
		return new EamResult(SUCCESS, count);
	}

	@ApiOperation(value = "拒绝工单委派")
	@RequiresPermissions("eam:ticketAppointedRecord:create")
	@RequestMapping(value = "/reject", method = RequestMethod.GET)
	@ResponseBody
	public Object reject(EamTicketAppointedRecord ticketAppointRecord) {
		ComplexResult result = FluentValidator.checkAll()
				.on(ticketAppointRecord.getRejectCommont(), new LengthValidator(1, 20, "工单委派拒绝原因不能为空"))
				.doValidate()
				.result(ResultCollectors.toComplex());
		if (!result.isSuccess()) {
			return new EamResult(INVALID_LENGTH, result.getErrors());
		}
		baseEntityUtil.addAddtionalValue(ticketAppointRecord);
		int count = eamTicketAppointRecordService.insertSelective(ticketAppointRecord);
		int c2= ticketInit(ticketAppointRecord.getTicketId());
		return new EamResult(SUCCESS, count);
	}

	@ApiOperation(value = "删除工单委派")
	@RequiresPermissions("eam:ticketAppointedRecord:delete")
	@RequestMapping(value = "/delete/{ids}",method = RequestMethod.GET)
	@ResponseBody
	public Object delete(@PathVariable("ticketId") int ticketId, @PathVariable("ids") String ids) {
		int count = eamTicketAppointRecordService.deleteByPrimaryKeys(ids);
		ticketInit(ticketId);
		return new EamResult(SUCCESS, count);
	}

	@ApiOperation(value = "删除工单委派")
	@RequiresPermissions("eam:ticketAppointedRecord:delete")
	@RequestMapping(value = "/delete",method = RequestMethod.GET)
	@ResponseBody
	public Object delete(@PathVariable("ticketId") int ticketId) {
		EamTicketAppointedRecordExample eamTicketAppointRecordExample = new EamTicketAppointedRecordExample();
		EamTicketAppointedRecordExample.Criteria criteria = eamTicketAppointRecordExample.createCriteria();
		criteria.andTicketIdEqualTo(ticketId);
		criteria.andDeleteFlagEqualTo(Boolean.FALSE);
		int count = eamTicketAppointRecordService.deleteByExample(eamTicketAppointRecordExample);
		int c2=ticketInit(ticketId);
		return new EamResult(SUCCESS, count);
	}

//	@ApiOperation(value = "修改工单委派")
//	@RequiresPermissions("eam:ticketAppointedRecord:update")
//	@RequestMapping(value = "/update/{id}", method = RequestMethod.GET)
//	public String update(@PathVariable("id") int id, ModelMap modelMap) {
//		EamTicketAppointedRecord eamTicketAppointRecord = eamTicketAppointRecordService.selectByPrimaryKey(id);
//		modelMap.put("ticketAppointRecord", eamTicketAppointRecord);
//		return "/manage/ticket/appoint/update.jsp";
//	}
//
//	@ApiOperation(value = "修改工单委派")
//	@RequiresPermissions("eam:ticketAppointedRecord:update")
//	@RequestMapping(value = "/update/{id}", method = RequestMethod.POST)
//	@ResponseBody
//	public Object update(@PathVariable("id") int id, EamTicketAppointedRecord ticketAppointRecord) {
//		ComplexResult result = FluentValidator.checkAll()
//				.on(ticketAppointRecord.getRejectCommont(), new LengthValidator(1, 20, "工单委派拒绝原因不能为空"))
//				.doValidate()
//				.result(ResultCollectors.toComplex());
//		if (!result.isSuccess()) {
//			return new EamResult(INVALID_LENGTH, result.getErrors());
//		}
//		ticketAppointRecord.setId(id);
//		baseEntityUtil.updateAddtionalValue(ticketAppointRecord);
//		int count = eamTicketAppointRecordService.updateByPrimaryKeySelective(ticketAppointRecord);
//		return new EamResult(SUCCESS, count);
//	}

	public int ticketInit(int ticketId){
		return updateTicketStatus( ticketId, TicketStatus.INIT.getName());
	}

	public int ticketToProcess(int ticketId){
		return updateTicketStatus( ticketId, TicketStatus.TO_PROCESS.getName());
	}
	public int ticketProcess(int ticketId){
		return updateTicketStatus( ticketId, TicketStatus.PROCESSING.getName());
	}
	public int ticketResolved(int ticketId){
		return updateTicketStatus( ticketId, TicketStatus.RESOLVED.getName());
	}
	public int ticketComplete(int ticketId){
		return updateTicketStatus( ticketId, TicketStatus.COMPLETE.getName());
	}
	public int updateTicketStatus(int ticketId, String status){
		EamTicket ticket=new EamTicket();
		ticket.setTicketId(ticketId);
		ticket.setStatus(status);
		return eamTicketService.updateByPrimaryKeySelective(ticket);
	}

	public int completeTicket(int ticketId){
		EamTicket ticket=new EamTicket();
		ticket.setTicketId(ticketId);
		ticket.setStatus(TicketStatus.COMPLETE.getName());
		return eamTicketService.updateByPrimaryKeySelective(ticket);
	}
}