package com.kuyun.eam.admin.controller.manager;

import com.baidu.unbiz.fluentvalidator.ComplexResult;
import com.baidu.unbiz.fluentvalidator.FluentValidator;
import com.baidu.unbiz.fluentvalidator.ResultCollectors;
import com.kuyun.common.base.BaseController;
import com.kuyun.common.validator.NotNullValidator;
import com.kuyun.eam.common.constant.AlarmType;
import com.kuyun.eam.common.constant.EamResult;
import com.kuyun.eam.dao.model.EamAlarm;
import com.kuyun.eam.rpc.api.EamAlarmService;
import com.kuyun.eam.rpc.api.EamApiService;
import com.kuyun.upms.client.util.BaseEntityUtil;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

import static com.kuyun.eam.common.constant.EamResultConstant.INVALID_LENGTH;
import static com.kuyun.eam.common.constant.EamResultConstant.SUCCESS;

/**
 * 设备控制器
 * Created by kuyun on 2017/4/9.
 */
@Controller
@Api(value = "报警管理", description = "报警管理")
@RequestMapping("/manage/alarm")
public class EamAlarmController extends BaseController {

	private static Logger _log = LoggerFactory.getLogger(EamAlarmController.class);

	@Autowired
	private EamApiService eamApiService;

	@Autowired
	private BaseEntityUtil baseEntityUtil;

	@Autowired
	private EamAlarmService eamAlarmService;

	@ApiOperation(value = "新增报警设置")
	@RequiresPermissions("eam:alarm:create")
	@RequestMapping(value = "/create", method = RequestMethod.POST)
	@ResponseBody
	public Object create(HttpServletRequest request, EamAlarm alarm) {
		String targetUserId = request.getParameter("targetUser");
		Object result = validateAlarm(alarm);
		if (result != null) return result;

		return createOrUpate(targetUserId, alarm);
	}

	private Object createOrUpate(String targetUserId, EamAlarm alarm) {
		int count = 0;
		if (alarm.getAlarmId() != null){
			baseEntityUtil.updateAddtionalValue(alarm);
			count = eamApiService.updateAlarm(targetUserId, alarm);
			_log.info("Update Alarm");
		}else {
			baseEntityUtil.addAddtionalValue(alarm);
			count = eamApiService.createAlarm(targetUserId, alarm);
			_log.info("Create Alarm");
		}
		return new EamResult(SUCCESS, count);
	}

	@ApiOperation(value = "更新报警设置")
	@RequiresPermissions("eam:alarm:update")
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	@ResponseBody
	public Object update(HttpServletRequest request, EamAlarm alarm) {
		String targetUserId = request.getParameter("targetUser");
		return createOrUpate(targetUserId, alarm);
	}

	private Object validateAlarm(EamAlarm alarm) {
		ComplexResult result = null;

		if (AlarmType.VAL_ABOVE.match(alarm.getAlarmType())){
			result = FluentValidator.checkAll()
					.on(alarm.getUpperBound(), new NotNullValidator("X值"))
					.doValidate()
					.result(ResultCollectors.toComplex());

		}else if (AlarmType.VAL_BELOW.match(alarm.getAlarmType())){
			result = FluentValidator.checkAll()
					.on(alarm.getLowerBound(), new NotNullValidator("Y值"))
					.doValidate()
					.result(ResultCollectors.toComplex());

		}

		else if (AlarmType.VAL_ABOVE_BELOW_OFM.match(alarm.getAlarmType())){
			result = FluentValidator.checkAll()
					.on(alarm.getUpperBound(), new NotNullValidator("X值"))
					.on(alarm.getLowerBound(), new NotNullValidator("Y值"))
					.on(alarm.getDuration(), new NotNullValidator("M值"))
					.doValidate()
					.result(ResultCollectors.toComplex());

		}

		else if (AlarmType.VAL_BETWEEN.match(alarm.getAlarmType())){
			result = FluentValidator.checkAll()
					.on(alarm.getUpperBound(), new NotNullValidator("X值"))
					.on(alarm.getLowerBound(), new NotNullValidator("Y值"))
					.doValidate()
					.result(ResultCollectors.toComplex());

		}else if (AlarmType.VAL_ABOVE_BOUND.match(alarm.getAlarmType())){
			result = FluentValidator.checkAll()
					.on(alarm.getUpperBound(), new NotNullValidator("X值"))
					.on(alarm.getDuration(), new NotNullValidator("M值"))
					.doValidate()
					.result(ResultCollectors.toComplex());

		}else if (AlarmType.VAL_BELOW_BOUND.match(alarm.getAlarmType())){
			result = FluentValidator.checkAll()
					.on(alarm.getLowerBound(), new NotNullValidator("Y值"))
					.on(alarm.getDuration(), new NotNullValidator("M值"))
					.doValidate()
					.result(ResultCollectors.toComplex());

		}else if (AlarmType.OFFLINE.match(alarm.getAlarmType())){
			//do nothing
		}

		else if (AlarmType.SWITCH_ON.match(alarm.getAlarmType())){
			//do nothing
		}else if (AlarmType.SWITCH_OFF.match(alarm.getAlarmType())){
			//do nothing
		}

		if (result != null && !result.isSuccess()) {
			return new EamResult(INVALID_LENGTH, result.getErrors());
		}

		return null;
	}

	@ApiOperation(value = "删除报警设置")
	@RequiresPermissions("eam:alarm:update")
	@RequestMapping(value = "/delete/{ids}",method = RequestMethod.GET)
	@ResponseBody
	public Object delete(@PathVariable("ids") String ids) {
		int count = eamAlarmService.deleteByPrimaryKeys(ids);
		return new EamResult(SUCCESS, count);
	}

}