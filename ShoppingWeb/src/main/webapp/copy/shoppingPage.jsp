<%@page import="com.oohooh.shopping.entities.ShoppingCart"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());

	ShoppingCart sc = (ShoppingCart)request.getSession().getAttribute("shoppingCart");
	
	if(sc != null){
		pageContext.setAttribute("totalMoney", sc.getTotalMoney());
		pageContext.setAttribute("totalNumber", sc.getTotalNumber());
	}else{
		pageContext.setAttribute("totalMoney", "0.00");
		pageContext.setAttribute("totalNumber", 0);
	}
	
%>
<script type="text/javascript" src="${APP_PATH}/static/scripts/jquery-3.2.1.js"></script>
<link rel="stylesheet" href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css">
<script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script type="text/javascript">
	
		$(function(){
			to_page(1);

			$("#price_Filter").click(function(){
				var url = "${APP_PATH}/shoppingPage";
				var pageNo = $("#hidden_pageNo").val();
				var minPrice = $(":text[name=minPrice]").val();
				var maxPrice = $(":text[name=maxPrice]").val();
				$.trim(minPrice);
				$.trim(maxPrice);
				
				var args = {"pageNo":pageNo, "minPrice":minPrice, "maxPrice":maxPrice};
				$.post(url, args, function(result){
					if(result.code == 100){
						build_clothes_div(result);
						build_page_nav(result);
						$("#hidden_minPrice").val(minPrice);
	 					$("#hidden_maxPrice").val(maxPrice);
	 					to_page(1);
					}
				});
				return false;
			});
			
		
		
			function to_page(pn){
				var url = "${APP_PATH}/shoppingPage";
				var minPrice = $("#hidden_minPrice").val();
				var maxPrice = $("#hidden_maxPrice").val();
				var args = {"pageNo":pn, "minPrice":minPrice, "maxPrice":maxPrice};
				$.post(url, args, function(result){
					if(result.code == 100){
						// pageNo 先改再重整內容
						$("#hidden_pageNo").val(pn);
						build_clothes_div(result);
						build_page_nav(result);
						
					}
				});
			}
		
			function build_clothes_div(result){
				$("#clothesContent").empty();
				
				var pageNo = $("#hidden_pageNo").val();
				var minPrice = $("#hidden_minPrice").val();
				var maxPrice = $("#hidden_maxPrice").val();
				
				var clothesSet = result.jsonObject.page.content;
				$.each(clothesSet, function(index, item){
					var itemDiv = $("<div class='caption'></div>").append($("<h5>" + item.clothesName + "</h5>"))
																  .append($("<p><b>$"+ item.price + "</b></p>"));
					
					var img = $("<a href='#'></a>").attr("href", "${APP_PATH}/clothesItem.jsp?clothesId=" + item.clothesId + 
								"&pageNo=" + pageNo + "&minPrice=" + minPrice + "&maxPrice=" + maxPrice)
								.append($("<img src='${APP_PATH}/static/imgs/grey.png' class='img-rounded'>"));
					
					var colDiv = $("<div class='col-sm-6 col-md-4'></div>").append(img)
																		   .append(itemDiv);
					if((index + 1) % 3 == 0){
						$("#clothesContent").append(colDiv).append($("<div class='clearfix'></div>"));
					}else{
						$("#clothesContent").append(colDiv);
					}
				});
			}
		
			function build_page_nav(result){
				$("nav").empty();
				var firstLi = $("<li></li>").append($("<a></a>").append("First").attr("href", "#"));
				var previousLi = $("<li></li>").append($("<a></a>").append("&laquo;").attr("href", "#"));
				if(result.jsonObject.hasPrevious == false){
					firstLi.addClass("disabled");
					previousLi.addClass("disabled");
					
					firstLi.click(function(){ 
						return false;
					});
					previousLi.click(function(){ 
						return false;
					});
				}else{
					firstLi.click(function(){
						to_page(1);
						return false;
					});
					
					previousLi.click(function(){
						to_page(result.jsonObject.page.number + 1 - 1);
						return false;
					});
				}
				
				var nextLi = $("<li></li>").append($("<a></a>").append("&raquo;").attr("href", "#"));
				var lastLi = $("<li></li>").append($("<a></a>").append("Last").attr("href", "#"));
				if(result.jsonObject.hasNext == false){
					nextLi.addClass("disabled");
					lastLi.addClass("disabled");
					
					lastLi.click(function(){ 
						return false;
					});
					nextLi.click(function(){ 
						return false;
					});
				}else{
					lastLi.click(function(){
						to_page(result.jsonObject.page.totalPages);
						return false;
					});
					
					nextLi.click(function(){
						to_page(result.jsonObject.page.number + 1 + 1);
						return false;
					});
				}
				
				var ul = $("<ul></ul>").addClass("pagination");
				
				ul.append(firstLi).append(previousLi);
				
				$.each(result.jsonObject.navigateNum, function(index, item){
					var pageNoLi = $("<li></li>").append($("<a></a>").append(item).attr("href", "#"));	
					
					
					if(result.jsonObject.page.number + 1 == item){
						pageNoLi.addClass("active");
					}
					
					pageNoLi.click(function(){
						to_page(item);
						return false;
					});
					
					ul.append(pageNoLi);
				});
				
				ul.append(nextLi).append(lastLi).appendTo("nav");
			}
			
			var totalMoney = ${totalMoney};
			var totalNumber = ${totalNumber};
			$("#bag_totalMoney").text(" $" + totalMoney);
			$("#bag_totalNumber").text(" (" + totalNumber + ")");
				
		});

</script>
</head>
<body>

	<input type="hidden" id="hidden_pageNo" value="1"/>
	<input type="hidden" id="hidden_minPrice" value="0"/>
	<input type="hidden" id="hidden_maxPrice" value="2147483647"/>

	<div class="container">

		<div class="page-header">
		  <h1>Example page header <small>Subtext for header</small></h1>
		</div>

		<ol class="breadcrumb">
		  <li><a href="index.jsp ">Home</a></li>
		  <li><a href="login.jsp">Login</a></li>
		  <li><a href="register">Register</a></li>
 		  <li><a href="bag">Bag<span id="bag_totalMoney"> $0.00</span><span id="bag_totalNumber"> (0)</span></a></li>
		</ol>
	
		<div class="jumbotron">
			<h1>Hello, world!</h1>
			<p>...</p>
		</div>
		
		<form class="form-inline">
		  <div class="form-group">
		    <div class="input-group">
		      <div class="input-group-addon">$</div>
		      <input type="text" class="form-control" name="minPrice" placeholder="Min Price">
		    </div>
		  </div>
		  -
		  <div class="form-group">
		    <div class="input-group">
		      <div class="input-group-addon">$</div>
		      <input type="text" class="form-control" name="maxPrice" placeholder="Max Price">
		    </div>
		  </div>
		  <button type="submit" class="btn btn-primary" id="price_Filter">Filter</button>
		</form>
		
		<br>
		
		<div class="row" id="clothesContent"></div>
		
		<br>
		
		<nav aria-label="Page navigation"></nav>
		
	</div>
	
</body>
</html>