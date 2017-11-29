<%@ page import="com.oohooh.shopping.entities.ShoppingCart"%>
<%@ page import="java.util.Locale" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<base href="${pageContext.request.contextPath }/">
<script type="text/javascript" src="static/scripts/jquery-3.2.1.js"></script>
<link rel="stylesheet" href="static/bootstrap-3.3.7-dist/css/bootstrap.min.css">
<script src="static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="static/shoppingWeb/commons.css">

<% 
	ShoppingCart sc = (ShoppingCart)request.getSession().getAttribute("shoppingCart");
	
	if(sc != null){
		pageContext.setAttribute("totalMoney", sc.getTotalMoney());
		pageContext.setAttribute("totalNumber", sc.getTotalNumber());
	}else{
		pageContext.setAttribute("totalMoney", 0);
		pageContext.setAttribute("totalNumber", 0);
	}
	
	Locale locale = (Locale)request.getSession().getAttribute("locale");
	if(locale != null){
		pageContext.setAttribute("locale", locale);
	}else{
		pageContext.setAttribute("locale", "en_US");
	}
	
%>

<script type="text/javascript">

	$(function(){
		
		var totalMoney = ${totalMoney};
		var totalNumber = ${totalNumber};
		$("#bag_totalMoney").text(" $" + totalMoney);
		$("#bag_totalNumber").text(" (" + totalNumber + ")");
		
		var locale = "${locale}";
		$("#language_div").val(locale);
		
		$("#language_div").change(function(){
			var url = "shoppingPage";
			var locale = $(this).val();
			var args = {"locale": locale, "time": new Date()}
			$.post(url, args, function(){
				location.href = "index.jsp";
			});
		});
		
	})
	

</script>

	<div class="container">

		<div class="page-header">
			<div class="row">
				<div class="col-md-8">
					<h1>Example page header <small>Subtext for header</small></h1>
				</div>
				<div class="col-md-2 pull-right">
<%-- 					<a href="shoppingPage?locale=en_US"><fmt:message key="i18n.language_en_us"></fmt:message></a> --%>
<!-- 					<br> -->
<%-- 					<a href="shoppingPage?locale=zh_TW"><fmt:message key="i18n.language_zh_tw"></fmt:message></a> --%>
					<select class="pull-right" id="language_div">
						<option value="en_US">English</option>
						<option value="zh_TW">Traditional Chinese</option>
					</select>
				</div>
			</div>
		</div>
			
		<shiro:user>
			<div class="col-md-12 user">
				<h4 class="pull-right">
					<fmt:message key="i18n.hi"></fmt:message>&nbsp;
					<b><shiro:principal></shiro:principal></b>, 
					<small>
						<a href="logout" class="grey_font"><fmt:message key="i18n.signOut"></fmt:message></a>
					</small>
				</h4>
			</div>
		</shiro:user>
		
		<div>
			<ul class="nav navbar-nav menu-bar">
				<li class="dropdown"><a href="index.jsp"><span class="glyphicon glyphicon-home black_font big_menu"></span></a></li>
				<li class="dropdown">
					<a href="shoppingPage?genderCondition=Female">
						<span class="black_font big_menu">
							<fmt:message key="i18n.women"></fmt:message>
						</span>
					</a>
					<ul class="dropdown-menu">
				    	<li><a href="shoppingPage?genderCondition=Female&categoryCondition=T-Shirt"><fmt:message key="i18n.t-shirt"></fmt:message></a></li>
				        <li><a href="shoppingPage?genderCondition=Female&categoryCondition=Shirt"><fmt:message key="i18n.shirt"></fmt:message></a></li>
				        <li><a href="shoppingPage?genderCondition=Female&categoryCondition=Jeans"><fmt:message key="i18n.jeans"></fmt:message></a></li>
				        <li><a href="shoppingPage?genderCondition=Female&categoryCondition=Trousers"><fmt:message key="i18n.trousers"></fmt:message></a></li>
				        <li><a href="shoppingPage?genderCondition=Female&categoryCondition=Jackets"><fmt:message key="i18n.jackets&coats"></fmt:message></a></li>
					</ul>
				</li>
				  
				<li class="dropdown">
					<a href="shoppingPage?genderCondition=Male">
						<span class="black_font big_menu">
							<fmt:message key="i18n.men"></fmt:message>
						</span>
					</a>
					<ul class="dropdown-menu">
				    	<li><a href="shoppingPage?genderCondition=Male&categoryCondition=T-Shirt"><fmt:message key="i18n.t-shirt"></fmt:message></a></li>
				        <li><a href="shoppingPage?genderCondition=Male&categoryCondition=Shirt"><fmt:message key="i18n.shirt"></fmt:message></a></li>
				        <li><a href="shoppingPage?genderCondition=Male&categoryCondition=Jeans"><fmt:message key="i18n.jeans"></fmt:message></a></li>
				        <li><a href="shoppingPage?genderCondition=Male&categoryCondition=Trousers"><fmt:message key="i18n.trousers"></fmt:message></a></li>
				        <li><a href="shoppingPage?genderCondition=Male&categoryCondition=Jackets"><fmt:message key="i18n.jackets&coats"></fmt:message></a></li>
					</ul>
				</li>
			</ul>
			 
			<ul class="nav navbar-nav pull-right">
				<li class="pull-right">
				  	<a href="cart">
					  	<span class="black_font">
					  		<fmt:message key="i18n.bag"></fmt:message>
						  	<span id="bag_totalMoney"> $0.00</span>
						  	<span id="bag_totalNumber"> (0)</span>
					  	</span>
				  	</a>
				</li>
				<shiro:hasRole name="admin">
					<li><a href="uploadItem"><span class="black_font"><fmt:message key="i18n.uploadItem"></fmt:message></span></a></li>
				</shiro:hasRole>
				<shiro:guest>
			    	<li><a href="login"><span class="black_font"><fmt:message key="i18n.login"></fmt:message></span></a></li>
			    </shiro:guest>
			    <li><a href="register"><span class="black_font"><fmt:message key="i18n.register"></fmt:message></span></a></li>
			    <li><a href="myAccount"><span class="black_font"><fmt:message key="i18n.myAccount"></fmt:message></span></a></li>
			</ul>
		</div>

	</div>
	