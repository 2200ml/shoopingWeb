<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Register</title>
<%@ include file="/commons/commons-title.jsp" %>
<script type="text/javascript">

	$(function(){
		
		function validate_add_form(){
			
			var username = $("#username").val();
			var regName = /^[a-z0-9_-]{6,16}$/;
			if(!regName.test(username)){
				show_validate_msg("#username", "error", "username 必須是 6~16 位 英文數字");
				return false;
			}else{
				show_validate_msg("#username", "success", "");
			};
			
			var password = $("#password").val();
			var regPassword = /^[a-z0-9_-]{6,16}$/;
			if(!regPassword.test(password)){
				show_validate_msg("#password", "error", "password 必須是 6~16 位 英文數字");
				return false;
			}else{
				show_validate_msg("#password", "success", "");
			}
			
			var confirmPassword = $("#confirmPassword").val();
			if(password != confirmPassword){
				show_validate_msg("#confirmPassword", "error", "password 與 confirmPassword 不一致");
				return false;
			}else{
				show_validate_msg("#confirmPassword", "success", "");
			}
			
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
				}
				else if($("#birth_day").val() != 0){
					show_validate_msg("#birth_day", "success", "");
				}
				
				if($("#birth_month").val() == 0){
					show_validate_msg("#birth_month", "error", "請選擇");
					return false;
				}
				else if($("#birth_month").val() != 0){
					show_validate_msg("#birth_month", "success", "");
				}
				
				if($("#birth_year").val() == 0){
					show_validate_msg("#birth_year", "error", "請選擇");
					return false;
				}
				else if($("#birth_year").val() != 0){
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
		
		$("#username").change(function(){
			var val = $(this).val();
			val = $.trim(val);
			$(this).val(val);
			var $this = $(this);
			
			if(val != "") {
				var url = "validateUsername";
				var args = {"username": val, "time": new Date()};
				$.post(url, args, function(result){
					if(result.code == 100){
						show_validate_msg("#username", "success", result.jsonObject.back_va);
						//必須為SAVE按鈕添加屬性判斷username是否異常，否則按下SAVE按鈕username就算出異常還是可以繼續之後的步驟。
						$(":submit").attr("ajax_va", "success");
					}
					else if(result.code == 200){
						show_validate_msg("#username", "error", result.jsonObject.back_va);
						$(":submit").attr("ajax_va", "error");
					}
				});
			}
		});
		
		$(":submit").click(function(){
			
			//要放在if(!validate_add_form())前面 否則沒作用
			if($(":submit").attr("ajax_va") == "error"){
				return false;
			}
			
			if(!validate_add_form()){
				return false;
			}
			
			var username = $("#username").val();
			var password = $("#password").val();
			var confirmPassword = $("#confirmPassword").val();
			var email = $("#email").val();
			var gender = $("#register_form :radio[name=gender]:checked").val();
			var birth =  $("#birth_day").val() + "-" + $("#birth_month").val() + "-" + $("#birth_year").val();
			
			var url = "register";
			var args = {"username":username, "password":password, "confirmPassword":confirmPassword,
					"email":email, "gender":gender, "birth":birth};
			
			$.post(url, args, function(result){
				if(result.code == 100){
					reset_form("#register_form");
					alert("Register Success !!");
					location.href = "index.jsp";
				}else{
					//後端校驗的錯誤訊息
					if(undefined != result.jsonObject.errorFields.username){
						show_validate_msg("#username", "error", result.jsonObject.errorFields.username);
					}else if(undefined == result.jsonObject.errorFields.username){
						show_validate_msg("#username", "success", "");
					}
					
					if(undefined != result.jsonObject.errorFields.password){
						show_validate_msg("#password", "error", result.jsonObject.errorFields.password);
					}else if(undefined == result.jsonObject.errorFields.password){
						show_validate_msg("#password", "success", "");
					}
					
					if(undefined != result.jsonObject.errorFields.confirmPassword){
						show_validate_msg("#confirmPassword", "error", result.jsonObject.errorFields.confirmPassword);
					}else if(undefined == result.jsonObject.errorFields.confirmPassword){
						show_validate_msg("#confirmPassword", "success", "");
					}
					
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
			});
			
			return false;
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

	<div class="container">
	
		<br><br>
		
		<div class="col-md-offset-5">
			<h2>Register</h2>
			<br>
		</div>
		
		<form class="form-horizontal col-md-offset-2" id="register_form">
		
			<div class="form-group">
				<label for="username" class="col-sm-2 control-label">Username</label>
				<div class="col-sm-6">
					<input type="text" class="form-control" id="username" name="username" placeholder="Username (size:6-16)">
					<span class="help-block"></span>
				</div>
			</div>
			
			<div class="form-group">
				<label for="password" class="col-sm-2 control-label">Password</label>
				<div class="col-sm-6">
					<input type="password" class="form-control" id="password" name="password" placeholder="Password (size:6-16)">
					<span class="help-block"></span>
				</div>
			</div>
			
			<div class="form-group">
				<label for="confirmPassword" class="col-sm-2 control-label">ConfirmPassword</label>
				<div class="col-sm-6">
					<input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="confirmPassword (size:6-16)">
					<span class="help-block"></span>
				</div>
			</div>
			
			<div class="form-group">
				<label for="email" class="col-sm-2 control-label">Email</label>
				<div class="col-sm-6">
					<input type="text" class="form-control" id="email" name="email" placeholder="XXX@XXX.XXX">
					<span  class="help-block"></span>
				</div>
			</div>
			
			<div class="form-group">
				<label class="col-sm-2 control-label">Gender</label>
				<div class="col-sm-6">
					<label class="radio-inline">
					  <input type="radio" name="gender" id="genderM" value="Male" checked="checked"> Male
					</label>
					<label class="radio-inline">
					  <input type="radio" name="gender" id="genderF" value="Female"> Female
					</label>
				</div>
			</div>
			
			<div class="form-group">
				<label for="birth" class="col-sm-2 control-label">Birth</label>

				<div class="col-sm-2">
					<select class="form-control" id="birth_day"><option value="0">DD</option>
						<c:forEach var="day" items="${days}">
						    <option value="${day}">${day}</option>
						</c:forEach>
					</select>
					<span class="help-block"></span>
				</div>
				
				<div class="col-sm-2">
					<select class="form-control" id="birth_month"><option value="0">Month</option>
						<option value="1">January</option><option value="2">February</option><option value="3">March</option>
						<option value="4">April</option><option value="5">May</option><option value="6">June</option>
						<option value="7">July</option><option value="8">August</option><option value="9">September</option>
						<option value="10">October</option><option value="11">November</option><option value="12">December</option>
					</select>
					<span class="help-block"></span>
				</div>

				<div class="col-sm-2">
					<select class="form-control" id="birth_year"><option value="0">YYYY</option>
						<c:forEach var="year" items="${years}">
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
			
			
			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-10">
					<button type="submit" class="btn btn-default">Save</button>
				</div>
			</div>
			
			
		</form>
	</div>

</body>
</html>