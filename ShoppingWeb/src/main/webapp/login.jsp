<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Login Page</title>
<%@ include file="/commons/commons-title.jsp" %>
<script type="text/javascript">

	$(function(){
		
		$(":submit").click(function(){
			
			var username = $("#username").val();
			var password = $("#password").val();
			var rememberMe = $("#rememberMe").val();
			
		  	var url = "shiroLogin";
		 	var args = {"username":username, "password":password, "rememberMe":rememberMe};
			$.post(url, args, function(result){
				if(result.code == 100){
					
					if(undefined != result.jsonObject.url){
						location.href = result.jsonObject.url;
					}else{
						//防止session失效時找不到savedRequest儲存的網頁
						location.href = "myAccount.jsp";
					}
			    }
				else if(result.code == 200){
					$("#errorInfo").parent().addClass("has-error");
					$("#errorInfo").text("帳號或密碼錯誤");
			    }
			});
			
		  return false;
		});
	})
	
</script>
</head>
<body>

	<div class="container">
		
		<br><br>
		
		<div class="col-md-offset-5">
			<h2><fmt:message key="i18n.login"></fmt:message></h2>
			<br>
		</div>
		
		<form class="form-horizontal col-md-offset-2">
			
			<div class="form-group">
				<label for="username" class="col-md-2 control-label"><fmt:message key="i18n.username"></fmt:message></label>
				<div class="col-md-5">
					<input type="text" class="form-control" id="username" name="username" placeholder="username">
					<span  class="help-block"></span>
				</div>
			</div>

			<div class="form-group">
				<label for="password" class="col-md-2 control-label"><fmt:message key="i18n.password"></fmt:message></label>
				<div class="col-md-5">
					<input type="password" class="form-control" id="password" name="password" placeholder="password">
					<span class="help-block"></span>
				</div>
			</div>
			
			<div class="form-group">
				<div class="col-md-offset-2 col-md-10">
					<span class="help-block" id="errorInfo"></span>
				</div>
			</div>

			<div class="form-group">
				<div class="col-md-offset-2 col-md-10">
					<div class="checkbox">
						<label><input type="checkbox" name="rememberMe" id="rememberMe"><fmt:message key="i18n.rememberMe"></fmt:message></label>
					</div>
				</div>
			</div>

			<div class="form-group">
				<div class="col-md-offset-2 col-md-10">
					<button type="submit" id="submit" class="btn btn-default"><fmt:message key="i18n.signIn"></fmt:message></button>
				</div>
			</div>

		</form>

	</div>
	
</body>
</html>