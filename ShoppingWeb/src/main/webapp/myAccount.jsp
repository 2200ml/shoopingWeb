<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@ include file="/commons/commons-title.jsp" %>
</head>
<body>
	
	<div class="container">
	
		<br><br>
		
		<div class="col-md-offset-4">
			<h2><fmt:message key="i18n.welcome"></fmt:message> <b><shiro:principal></shiro:principal></b></h2>
			<br>
		</div>
		
		<br>
		
		<div class="row">
			<div class="col-md-5 col-md-offset-3">
				<a href ="member" class="btn btn-default btn-block " role="button">
					<span class="glyphicon glyphicon-user pull-left" style='font-size:20px'></span>
					<fmt:message key="i18n.myDetails"></fmt:message>
				</a>
				<br>
			</div>
		</div>
		
		<div class="row">
			<div class="col-md-5 col-md-offset-3">
				<a href ="myOrders" class="btn btn-default btn-block" role="button">
					<span class="glyphicon glyphicon-list-alt pull-left" style='font-size:20px'></span>
					<fmt:message key="i18n.myOrders"></fmt:message>
				</a>
			</div>
		</div>
		
	</div>
	
</body>
</html>