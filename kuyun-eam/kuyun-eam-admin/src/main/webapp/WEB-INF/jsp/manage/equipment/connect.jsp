﻿<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="basePath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML>
<html lang="zh-cn">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<jsp:include page="/resources/inc/head.jsp" flush="true"/>
</head>
<body>
<div id="main">
	<div id="connectDialog" class="crudDialog">
		<form id="connectForm" method="post">

			<input type="hidden" name="equipmentId" value="${equipment.equipmentId}">
			<div class="row">
				<div class="col-sm-12">
					<div class="form-group">
						<div class="fg-line">
							<label for="name">设备名称</label>
							<input id="name" type="text" class="form-control" name="name" maxlength="200" value="${equipment.name}" readonly>
						</div>
					</div>
				</div>

				<div class="col-sm-12">
					<div class="form-group">
						<div class="fg-line">
							<select id="protocolId" name="protocolId" style="width: 100%">
								<c:forEach var="protocol" items="${protocols}">
									<option value="${protocol.protocolId}">${protocol.name}</option>
								</c:forEach>
							</select>
						</div>
					</div>
				</div>

				<div class="col-sm-12">
					<div class="form-group">
						<div class="fg-line">
							<label for="heartData">心跳包格式</label>
							<input id="heartData" type="text" class="form-control" name="heartData" maxlength="50" <c:if test="${equipment.heartData != null}"> value="${equipment.heartData}"</c:if>>
						</div>
					</div>
				</div>

				<div class="col-sm-12">
					<div class="form-group">
						<div class="fg-line">
							<label for="IP">IP: 127.0.0.1</label>
						</div>
					</div>
				</div>
				<div class="col-sm-12">
					<div class="form-group">
						<div class="fg-line">
							<label for="port">端口号: 8234</label>
						</div>
					</div>
				</div>
				<div class="col-sm-12">
					<div class="form-group">
						<div class="fg-line">
							<label for="serviceId">接入注册包: ${equipment.equipmentId}</label>
						</div>
					</div>
				</div>

			</div>

			<div class="form-group text-right dialog-buttons">
				<a class="waves-effect waves-button" href="javascript:;" onclick="createSubmit();">保存</a>
				<a class="waves-effect waves-button" href="javascript:;" onclick="connectDialog.close();">取消</a>
			</div>
		</form>
	</div>
	<table id="table"></table>
</div>
<jsp:include page="/resources/inc/footer.jsp" flush="true"/>
<script>
    var $table = $('#table');
    $(function() {
        // bootstrap table初始化
        $table.bootstrapTable({
            url: '${basePath}/manage/equipment/model/property/list/${equipment.equipmentModelId}',
            height: getHeight(),
            striped: true,
            search: true,
            showRefresh: false,
            showColumns: true,
            minimumCountColumns: 2,
            clickToSelect: true,
            detailView: true,
            detailFormatter: 'detailFormatter',
            pagination: true,
            paginationLoop: false,
            sidePagination: 'server',
            silentSort: false,
            smartDisplay: false,
            escape: true,
            searchOnEnterKey: false,
            idField: 'equipmentModelPropertyId',
//		sortName: 'orders',
//        sortOrder: 'desc',
            maintainSelected: true,
            toolbar: '#toolbar',
            columns: [
                {field: 'ck', checkbox: true},
                {field: 'equipmentModelPropertyId', title: '设备模型参数ID', sortable: true, align: 'center'},
                {field: 'name', title: '参数名称'},
                {field: 'dataType', title: '数据类型'},
                {field: 'unit', title: '参数单位'},
               /* {field: 'refreshPeriod', title: '刷新周期'},*/
                {field: 'action', title: '读写指令', align: 'center', formatter: 'actionFormatter', events: 'actionEvents', clickToSelect: false}
            ]
        });
    });
    // 格式化操作按钮
    function actionFormatter(value, row, index) {
        return [
            '<a class="update" href="javascript:;" onclick="readWriteAction()" data-toggle="tooltip" title="Edit"><i class="glyphicon glyphicon-edit"></i></a>　'
        ].join('');
    }

    var readWriteDialog;
    function readWriteAction() {
        var rows = $table.bootstrapTable('getSelections');
        if (rows.length != 1) {
            $.confirm({
                title: false,
                content: '请选择一条记录！',
                autoClose: 'cancel|3000',
                backgroundDismiss: true,
                buttons: {
                    cancel: {
                        text: '取消',
                        btnClass: 'waves-effect waves-button'
                    }
                }
            });
        } else {
            readWriteDialog = $.dialog({
                animationSpeed: 300,
                title: '读写指令',
                columnClass: 'xlarge',
                content: 'url:${basePath}/manage/equipment/modbus/${equipment.equipmentId}/' + rows[0].equipmentModelPropertyId,
                onContentReady: function () {
                    initMaterialInput();
                    $('select').select2();
                }
            });
        }
    }

    function createSubmit() {
        $.ajax({
            type: 'post',
            url: '${basePath}/manage/equipment/connect/${equipment.equipmentId}',
            data: $('#connectForm').serialize(),
            beforeSend: function() {
                if ($('#heartData').val() == '') {
                    $('#heartData').focus();
                    return false;
                }
            },
            success: function(result) {
                if (result.code != 1) {
                    if (result.data instanceof Array) {
                        $.each(result.data, function(index, value) {
                            $.confirm({
                                theme: 'dark',
                                animation: 'rotateX',
                                closeAnimation: 'rotateX',
                                title: false,
                                content: value.errorMsg,
                                buttons: {
                                    confirm: {
                                        text: '确认',
                                        btnClass: 'waves-effect waves-button waves-light'
                                    }
                                }
                            });
                        });
                    } else {
                        $.confirm({
                            theme: 'dark',
                            animation: 'rotateX',
                            closeAnimation: 'rotateX',
                            title: false,
                            content: result.data.errorMsg,
                            buttons: {
                                confirm: {
                                    text: '确认',
                                    btnClass: 'waves-effect waves-button waves-light'
                                }
                            }
                        });
                    }
                } else {
                    $.confirm({
                        theme: 'dark',
                        animation: 'rotateX',
                        closeAnimation: 'rotateX',
                        title: false,
                        content: '保存成功',
                        buttons: {
                            confirm: {
                                text: '确认',
                                btnClass: 'waves-effect waves-button waves-light'
                            }
                        }
                    });
                }
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $.confirm({
                    theme: 'dark',
                    animation: 'rotateX',
                    closeAnimation: 'rotateX',
                    title: false,
                    content: textStatus,
                    buttons: {
                        confirm: {
                            text: '确认',
                            btnClass: 'waves-effect waves-button waves-light'
                        }
                    }
                });
            }
        });
    }
</script>
</body>
</html>