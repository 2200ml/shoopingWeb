<%@ page import="com.oohooh.shopping.entities.ShoppingCart"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>

<base href="${pageContext.request.contextPath }/">
<script type="text/javascript" src="static/scripts/jquery-3.2.1.js"></script>
<link rel="stylesheet" href="static/bootstrap-3.3.7-dist/css/bootstrap.min.css">
<script src="static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<style type="text/css">
	
	.black_font {
		color:black;
		font-color:black;
	}
	
	.big_menu {
		font-size:20px;
	}
	
	li.dropdown:hover > a, 
	li.dropdown:hover > a:hover,
	li.dropdown:hover > a:focus {
	    background-color: rgb(231, 231, 231);
	    color: rgb(85, 85, 85);
	}
	
	li.dropdown:hover > .dropdown-menu {
	    display: block;
	}
	
	.dropdown-menu {
		border-top: 2px solid black;
	}
	
	.navbar-nav li a {
	    line-height: 38px;
	    height: 35px;
	    padding-top: 0;
	}
	
	.navbar-nav li {
		background-color: white;
	}
	
	.nav > li > a:hover{
   		background-color:white;
   		text-decoration: underline;
	}
	
	.page-header{
		margin-bottom:5px;
	}
	
	.user {
		height:30px;
	}
	
	#search_form {
		margin-top:30px;
	}
	
	#custom-search-input button{
	    margin: 2px 0 0 0;
	    background: none;
	    border: 0;
	    color: #666666;
	    padding: 0 8px 0 10px;
	    border-left: solid 1px #ccc;
	}
	
	#custom-search-input input{
	    border: 0px !important;
	    margin:0 3px;
	    width:200px;
	}

	input,select,button:focus {
		outline:none !important;
		box-shadow:none !important;
		border:1px solid #ccc !important;
	}
	
	#custom-search-input{
	    padding: 5px;
	    border: solid 1px #E4E4E4;
	    background-color: #fff;
	}	
	
	div,input,button,a,select {
		border-radius:0px !important;
	}
	
	.foot_height {
		height:200px;
	}
	
	.pagination li a {
		color:black;
		border:1px solid black;
		margin-right: 5px;
	}
	
	.pagination li a:hover {
		color:black;
 		background-color:white;
		text-decoration: underline;
		border:1px solid black;
	}
	
	.pagination li.prePointLi a,
	.pagination li.afterPointLi a {
		border:0px;
	}
	
	.pagination li.prePointLi a:hover,
	.pagination li.afterPointLi a:hover {
		text-decoration: none;
	}
	
	.pagination li.active a{
		background-color: grey;
		border-color:black;
	}
	
	.pagination li.active a:hover{
		background-color: grey;
		border-color:black;
		text-decoration: none;
	}
	
</style>

<% 
	ShoppingCart sc = (ShoppingCart)request.getSession().getAttribute("shoppingCart");
	
	if(sc != null){
		pageContext.setAttribute("totalMoney", sc.getTotalMoney());
		pageContext.setAttribute("totalNumber", sc.getTotalNumber());
	}else{
		pageContext.setAttribute("totalMoney", 0);
		pageContext.setAttribute("totalNumber", 0);
	}
%>

<script type="text/javascript">

	$(function(){
		var totalMoney = ${totalMoney};
		var totalNumber = ${totalNumber};
		$("#bag_totalMoney").text(" $" + totalMoney);
		$("#bag_totalNumber").text(" (" + totalNumber + ")");
	})

</script>

	<div class="container">

		<div class="page-header">
			<h1>Example page header <small>Subtext for header</small></h1>
		</div>
		
			
		<shiro:user>
			<div class="col-md-12 user">
				<h4 class="pull-right">
					Hi&nbsp;
					<b><shiro:principal></shiro:principal></b>, 
					<small>
						<a href="logout" style="color:grey">sign out</a>
					</small>
				</h4>
			</div>
		</shiro:user>
		
		<div>
			<ul class="nav navbar-nav menu-bar">
				<li class="dropdown"><a href="index.jsp"><span class="glyphicon glyphicon-home black_font big_menu"></span></a></li>
				<li class="dropdown">
					<a href="shoppingPage?genderCondition=Female"><span class="black_font big_menu">WOMEN</span></a>
					<ul class="dropdown-menu">
				    	<li><a href="shoppingPage?genderCondition=Female&categoryCondition=T-Shirt">T-Shirt</a></li>
				        <li><a href="shoppingPage?genderCondition=Female&categoryCondition=Shirt">Shirt</a></li>
				        <li><a href="shoppingPage?genderCondition=Female&categoryCondition=Jeans">Jeans</a></li>
				        <li><a href="shoppingPage?genderCondition=Female&categoryCondition=Trousers">Trousers</a></li>
				        <li><a href="shoppingPage?genderCondition=Female&categoryCondition=Jackets">Jackets & Coats</a></li>
					</ul>
				</li>
				  
				<li class="dropdown">
					<a href="shoppingPage?genderCondition=Male"><span class="black_font big_menu">MEN</span></a>
					<ul class="dropdown-menu">
				    	<li><a href="shoppingPage?genderCondition=Male&categoryCondition=T-Shirt">T-Shirt</a></li>
				        <li><a href="shoppingPage?genderCondition=Male&categoryCondition=Shirt">Shirt</a></li>
				        <li><a href="shoppingPage?genderCondition=Male&categoryCondition=Jeans">Jeans</a></li>
				        <li><a href="shoppingPage?genderCondition=Male&categoryCondition=Trousers">Trousers</a></li>
				        <li><a href="shoppingPage?genderCondition=Male&categoryCondition=Jackets">Jackets & Coats</a></li>
					</ul>
				</li>
			</ul>
			 
			<ul class="nav navbar-nav pull-right">
				<li class="pull-right">
				  	<a href="cart.jsp">
					  	<span class="black_font">Bag
						  	<span id="bag_totalMoney"> $0.00</span>
						  	<span id="bag_totalNumber"> (0)</span>
					  	</span>
				  	</a>
				</li>
				<shiro:hasRole name="admin">
					<li><a href="uploadItem"><span class="black_font">Upload Item</span></a></li>
				</shiro:hasRole>
				<shiro:guest>
			    	<li><a href="login.jsp"><span class="black_font">Login</span></a></li>
			    </shiro:guest>
			    <li><a href="register"><span class="black_font">Register</span></a></li>
			    <li><a href="myAccount.jsp"><span class="black_font">My Account</span></a></li>
			</ul>
		</div>

	</div>
	