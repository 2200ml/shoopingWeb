<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@ include file="/commons/commons-title.jsp" %>
<script type="text/javascript">

	$(function(){
		
		var url = "update";
		$.get(url, function(result){
			if(result.code == 100){
				$("#username").text(result.jsonObject.account.username);
				$("#accountBalance").text("$ " + result.jsonObject.account.accountBalance.balance);
				$("#email").val(result.jsonObject.account.email);
				//radio的值需要使用[]包裹
				$("#update_form :radio[name=gender]").val([result.jsonObject.account.gender]);
				$("#id").val(result.jsonObject.account.id)
				
				var birth_year = result.jsonObject.account.birth.split("-")[0];
				var birth_month = result.jsonObject.account.birth.split("-")[1];
				var birth_day = result.jsonObject.account.birth.split("-")[2];
				$("#birth_year").val([birth_year]);
				$("#birth_month").val([birth_month]);
				$("#birth_day").val([birth_day]);
				
			}
		});
		
		
		function validate_add_form(){
			
			var email = $("#email").val();
			var regEmail = 	/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if(!regEmail.test(email)){
				show_validate_msg("#email", "error", "Email格式不正確");
				return false;
			}else{
				show_validate_msg("#email", "success", "")
			}
			
			var birth = $("#birth_day").val() + "-" + $("#birth_month").val() + "-" + $("#birth_year").val();
			var regBirth = /^(0?[1-9]|[1-2][0-9]|3[0-1])-(1[0-2]|0?[1-9])-(19|20)\d{2}$/;   
			if(!regBirth.test(birth)){
				
				if($("#birth_day").val() == 0){
					show_validate_msg("#birth_day", "error", "請選擇");
					return false;
				}else if($("#birth_day").val() != 0){
					show_validate_msg("#birth_day", "success", "");
				}
				
				if($("#birth_month").val() == 0){
					show_validate_msg("#birth_month", "error", "請選擇");
					return false;
				}else if($("#birth_month").val() != 0){
					show_validate_msg("#birth_month", "success", "");
				}
				
				if($("#birth_year").val() == 0){
					show_validate_msg("#birth_year", "error", "請選擇");
					return false;
				}else if($("#birth_year").val() != 0){
					show_validate_msg("#birth_year", "success", "");
				}
				
			}else{
				show_validate_msg("#birth_day", "success", "");
				show_validate_msg("#birth_month", "success", "");
				show_validate_msg("#birth_year", "success", "");
			}
			
			return true;
		};	
		
		function show_validate_msg(ele, status, msg){
			$(ele).parent().removeClass("has-success has-error");
			$(ele).next("span").text("");
			
			if("success" == status){
				$(ele).parent().addClass("has-success");
				$(ele).next("span").text(msg);
			}else if("error" == status){
				$(ele).parent().addClass("has-error");
				$(ele).next("span").text(msg);
			}
		}
		
		$("#submit").click(function(){

			if(!validate_add_form()){
				return false;
			}
			
			var birth = $("#birth_day").val() + "-" + $("#birth_month").val() + "-" + $("#birth_year").val();
			$("#birth_hidden").val(birth);
			
			$.ajax({
				url:"update/" + $("#id").val(),
				type:"POST",
				data:$("#update_form").serialize() + "&_method=PUT",
				success:function(result){
					if(result.code == 100){
						alert("Update Success!!!");
						location.href = result.jsonObject.redirect;
					}else{
						
						if(undefined != result.jsonObject.errorFields.email){
							show_validate_msg("#email", "error", result.jsonObject.errorFields.email);
						}else if(undefined == result.jsonObject.errorFields.email){
							show_validate_msg("#email", "success", "");
						}
						if(undefined != result.jsonObject.errorFields.birth){
							$("#birth-errorMessage").parent().addClass("has-error");
							$("#birth-errorMessage").text("birth是不正確的");
						}else if(undefined == result.jsonObject.errorFields.birth){
							$("#birth-errorMessage").parent().removeClass("has-error");
							$("#birth-errorMessage").text("");
						}
					}
				}
			});
			return false;
		});
		
		$("#change_password_btn").click(function(){
			
			$("#changePasswordModal").modal({
				//點擊背景不會關閉模態框
				backdrop:"static"
			});
		});
		
		$("#close_changePassword").click(function(){
			reset_form("#change_password_form");
		});
		
		$("#save_changePassword").click(function(){
			var password = $("#change_password").val();
			var confirmPassword = $("#change_confirmPassword").val();
			
			var regPassword = /^[a-z0-9_-]{6,16}$/;
			if(!regPassword.test(password)){
				show_validate_msg("#change_password", "error", "password 必須是 6~16 位 英文數字");
				return false;
			}else{
				show_validate_msg("#change_password", "success", "");
			}
			
			if(password != confirmPassword){
				show_validate_msg("#change_confirmPassword", "error", "password 與 confirmPassword 不一致");
				return false;
			}else{
				show_validate_msg("#change_confirmPassword", "success", "");
			}
			
			if(password == confirmPassword){
				$("<input type='hidden' name='password' id='password'/>").appendTo($("#password_Append"));
				$("#password").val(password);
				reset_form("#change_password_form");
				$("#changePasswordModal").modal("hide");
			}
		});
		
		function reset_form(ele){
			$(ele)[0].reset();
			$(ele).find("*").removeClass("has-error has-success");
			$(ele).find(".help-block").text("");
		}
		
	})
	
</script>
</head>
<body>

	<br><br>

	<div class="modal fade" id="changePasswordModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			
			<div class="foot_height"></div>
			
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="myModalLabel"><fmt:message key="i18n.changePassword"></fmt:message></h4>
				</div>
				<div class="modal-body">
				
					<form class="form-horizontal" id="change_password_form">
					 	 <div class="form-group">
					    	<label for="password" class="col-md-4 control-label">
					    		<fmt:message key="i18n.newPassword"></fmt:message>
					    	</label>
					     	<div class="col-md-7">
					      		<input type="password" class="form-control" id="change_password" name="changePassword"/>
					      		<span class="help-block"></span>
					    	</div>
					  	</div>
					  	<div class="form-group">
					    	<label for="confirmPassword" class="col-md-4 control-label">
					    		<fmt:message key="i18n.confirmPassword"></fmt:message>
					    	</label>
					     	<div class="col-md-7">
					      		<input type="password" class="form-control" id="change_confirmPassword" name="changeConfirmPassword"/>
					      		<span class="help-block"></span>
					    	</div>
					  	</div>
					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal" id="close_changePassword">
						<fmt:message key="i18n.close"></fmt:message>
					</button>
					<button type="button" class="btn btn-primary" id="save_changePassword">
						<fmt:message key="i18n.change"></fmt:message>
					</button>
				</div>
			</div>
		</div>
	</div>

	<div class="container">
	
		<div class="col-md-offset-4">
			<h2><fmt:message key="i18n.memberDetails"></fmt:message></h2>
			<br>
		</div>
	
		<form Class="form-horizontal col-md-offset-1" id="update_form">
		
			<input type="hidden" name="id" id="id"/>
		
			<div class="form-group">
				<label for="username" class="col-sm-2 control-label"><fmt:message key="i18n.username"></fmt:message></label>
				<div class="col-sm-6">
					<p class="form-control-static" id="username"></p>
				</div>
			</div>
			
			<div class="form-group">
				<label for="accountBalance" class="col-sm-2 control-label"><fmt:message key="i18n.accountBalance"></fmt:message></label>
				<div class="col-sm-6">
					<p class="form-control-static" id="accountBalance"></p>
				</div>
			</div>
			
			<div class="form-group">
				<label for="password" class="col-sm-2 control-label"><fmt:message key="i18n.password"></fmt:message></label>
				<div class="col-sm-6" id="password_Append">
					<p class="form-control-static">********</p>
				</div>
				<div class="col-sm-2">
					<button type="button" class="btn btn-default" id="change_password_btn"><fmt:message key="i18n.change"></fmt:message></button>
				</div>
			</div>

			<div class="form-group">
				<label for="email" class="col-sm-2 control-label"><fmt:message key="i18n.email"></fmt:message></label>
				<div class="col-sm-6">
					<input type="text" Class="form-control" id="email" name="email"/>
					<span  class="help-block"></span>
				</div>
			</div>
			
			<div class="form-group">
				<label class="col-sm-2 control-label"><fmt:message key="i18n.gender"></fmt:message></label>
				<div class="col-sm-6">
					<label class="radio-inline">
					  <input type="radio" name="gender" id="genderM" value="Male">
					  <fmt:message key="i18n.male"></fmt:message>
					</label>
					<label class="radio-inline">
					  <input type="radio" name="gender" id="genderF" value="Female">
					  <fmt:message key="i18n.female"></fmt:message>
					</label>
				</div>
			</div>
			
			<div class="form-group">
				<label for="birth" class="col-sm-2 control-label"><fmt:message key="i18n.birth"></fmt:message></label>

				<div class="col-sm-2">
					<select class="form-control" id="birth_day"><option value="0">DD</option>
						<c:forEach var="day" items="${days }">
						    <option value="${day}">${day}</option>
						</c:forEach>
					</select>
					<span class="help-block"></span>
				</div>
				<div class="col-sm-2">
					<select class="form-control" id="birth_month"><option value="0">Month</option>
						<option value="01">January</option><option value="02">February</option><option value="03">March</option>
						<option value="04">April</option><option value="05">May</option><option value="06">June</option>
						<option value="07">July</option><option value="08">August</option><option value="09">September</option>
						<option value="10">October</option><option value="11">November</option><option value="12">December</option>
					</select>
					<span class="help-block"></span>
				</div>

				<div class="col-sm-2">
					<select class="form-control" id="birth_year"><option value="0">YYYY</option>
				    	<c:forEach var="year" items="${years }">
						    <option value="${year}">${year}</option>
						</c:forEach>
					</select>
					<span class="help-block"></span>
				</div>
				
				<div class="form-group">
					<div class="col-sm-offset-2 col-sm-4">
						<span class="help-block" id="birth-errorMessage"></span>
					</div>
				</div>
			</div>
			
			<input type="hidden" name="birth" id="birth_hidden"/>
			
			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-10">
					<button type="submit" class="btn btn-default" id="submit"><fmt:message key="i18n.update"></fmt:message></button>
				</div>
			</div>
			
		</form>
		
	</div>
	

</body>
</html>