﻿<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="basePath" value="${pageContext.request.contextPath}"/>
<div id="createDialog" class="crudDialog">
	<form id="createForm" method="post">

		<div class="row">
			<div class="col-sm-12">
				<div class="form-group">
					<div class="fg-line">
						<label for="name">配件名称</label>
						<input id="name" type="text" class="form-control" name="name" maxlength="20">
					</div>
				</div>
			</div>
			<div class="col-sm-12">
				<div class="form-group">
					<div class="fg-line">
						<select id="categoryId" name="categoryId" style="width: 100%">
							<c:forEach var="category" items="${categoryList}">
								<option value="${category.categoryId}">${category.name}</option>
							</c:forEach>
						</select>
					</div>
				</div>
			</div>
			<div class="col-sm-12">
				<div class="form-group">
					<div class="fg-line">
						<label for="spec">规格</label>
						<input id="spec" type="text" class="form-control" name="spec" maxlength="20">
					</div>
				</div>
			</div>
			<div class="col-sm-12">
				<div class="form-group">
					<div class="fg-line">
						<label for="model">型号</label>
						<input id="model" type="text" class="form-control" name="model" maxlength="20">
					</div>
				</div>
			</div>
			<div class="col-sm-12">
				<div class="form-group">
					<div class="fg-line">
						<label for="unit">单位</label>
						<input id="unit" type="text" class="form-control" name="unit" maxlength="20">
					</div>
				</div>
			</div>
			<div class="col-sm-12">
				<div class="form-group">
					<div class="fg-line">
						<label for="brand">品牌</label>
						<input id="brand" type="text" class="form-control" name="brand" maxlength="20">
					</div>
				</div>
			</div>
		</div>

		<div class="form-group text-right dialog-buttons">
			<a class="waves-effect waves-button" href="javascript:;" onclick="createSubmit();">保存</a>
			<a class="waves-effect waves-button" href="javascript:;" onclick="createDialog.close();">取消</a>
		</div>
	</form>
</div>
<script>
function createSubmit() {
    $.ajax({
        type: 'post',
        url: '${basePath}/manage/part/create',
        data: $('#createForm').serialize(),
        beforeSend: function() {
            if ($('#name').val() == '') {
                $('#name').focus();
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
				createDialog.close();
				$table.bootstrapTable('refresh');
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