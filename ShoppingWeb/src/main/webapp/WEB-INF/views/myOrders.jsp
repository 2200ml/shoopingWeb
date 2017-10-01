<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@ include file="/commons/commons-title.jsp" %>
<style type="text/css">

	.glyphicon-list-alt {
		font-size:24px;
	}

</style>
<script type="text/javascript">

	$(function(){
		
		var pageNo = ${page.number} + 1;
		
		to_page();
		
		function to_page(){
			var url = "showTrade";
			var args = {"pageNo":pageNo};
			$.post(url, args, function(result){
				if(result.code == 100){
					if(result.jsonObject.page.totalElements == 0){
						$("#trade_info").empty();
						$("<div class='text-center'>").append($("<div class='foot_height'></div>"))
								.append($("<span class='glyphicon glyphicon-list-alt'></span>"))
								.append($("<h3><b>Your Orders is empty</b></h3>"))
								.appendTo($("#trade_info"));
						return;
					}else{
						build_trade_div(result)
						build_page_nav();
					}
				}
			});
		}
		
		function build_trade_div(result){

			var trades = result.jsonObject.page.content;
			$.each(trades, function(index, item){
				
				var date = new Date(item.tradeTime);
				Y = date.getFullYear() + '-';
				M = (date.getMonth() + 1 < 10 ? '0' + (date.getMonth() + 1) : date.getMonth() + 1) + '-';
				D = (date.getDate() < 10 ? '0' + date.getDate() : date.getDate()) + ' ';
				h = date.getHours() + ':';
				m = date.getMinutes() + ':';
				s = date.getSeconds(); 
				var tradeTime = Y + M + D + h + m + s;
				
				var itemsDiv = $("<div class='panel-body items'></div>");
				
				var tradeInfoDiv = $("<div class='panel-heading tradeTitle'></div>").append($("<h4></h4>").append($("<b>Trade ID: <font color='red'>" + item.tradeId + 
							"</font> &nbsp;&nbsp; | &nbsp;&nbsp; Trade Time: <font color='red'>" + tradeTime + 
							"</font> &nbsp;&nbsp; | &nbsp;&nbsp; Total Money: <font color='red'>$" + item.tradeMoney + 
							"</font></b>")));
				
				var tradeItems = item.tradeItems;
				$.each(tradeItems, function(index, item){
					
					var itemInfoDiv = $("<div class='col-md-9'></div>")
							.append($("<h4></h4>").append(item.clothesName))
							.append($("<p></p>")
							.append($("<b></b>")
							.append("&nbsp;&nbsp;&nbsp; Color: " + item.color + 
									"&nbsp;&nbsp; | &nbsp; Size: " + item.size + 
									"&nbsp;&nbsp; | &nbsp; Gender: " + item.gender + 
									"&nbsp;&nbsp; | &nbsp; Quantity: " + item.quantity)));
					
					itemInfoDiv.appendTo(itemsDiv);
				});
				
				$("<div class='panel panel-default'></div>").append(tradeInfoDiv).append(itemsDiv).appendTo($("#trade_info"));
				
				$(".items").hide();
			});
			
		}
		
		function build_page_nav(){
			$("nav").empty();

			var hasPrevious = ${hasPrevious};
			var hasNext = ${hasNext};
			var previousNo = ${page.number} + 1 - 1;
			
			var firstLi = $("<li></li>").append($("<a></a>").append("First")
					.attr("href", "myOrders?pageNo=" + 1));
			var previousLi = $("<li></li>").append($("<a></a>").append("&laquo;")
					.attr("href", "myOrders?pageNo=" + previousNo));
			
			var prePointLi = $("<li class='prePointLi'></li>").append($("<a></a>").append("<b>...</b>"));
			
			if(hasPrevious == false){
				firstLi.addClass("disabled");
				previousLi.addClass("disabled");
				
				firstLi.hide();
				previousLi.hide();
				prePointLi.hide();
				
				firstLi.click(function(){ 
					return false;
				});
				previousLi.click(function(){ 
					return false;
				});
			}
			
			var nextNo = ${page.number} + 1 + 1;
			var totalPages = ${page.totalPages};
			
			var nextLi = $("<li></li>").append($("<a></a>").append("&raquo;")
					.attr("href", "myOrders?pageNo=" + nextNo));
			var lastLi = $("<li></li>").append($("<a></a>").append("Last")
					.attr("href", "myOrders?pageNo=" + totalPages));
			
			var afterPointLi = $("<li class='afterPointLi'></li>").append($("<a></a>").append("<b>...</b>"));
			
			if(hasNext == false){
				nextLi.addClass("disabled");
				lastLi.addClass("disabled");
				
				nextLi.hide();
				lastLi.hide();
				afterPointLi.hide();
				
				lastLi.click(function(){ 
					return false;
				});
				nextLi.click(function(){ 
					return false;
				});
			}
			
			var ul = $("<ul></ul>").addClass("pagination");
			ul.append(previousLi).append(firstLi).append(prePointLi);
			
			var navigateNum = ${navigateNum};
			var currentPageNo = ${page.number};
			
			$.each(navigateNum, function(index, item){
				var pageNoLi = $("<li></li>").append($("<a></a>").append(item)
						.attr("href", "myOrders?pageNo=" + item));	
				
				if((currentPageNo + 1) == item){
					pageNoLi.addClass("active");
					
					pageNoLi.click(function(){
						return false;
					})
				}
				
				if(item - 1 <= 0){
					firstLi.hide();
					prePointLi.hide();
				}else if(item - 1 == 1) {
					prePointLi.hide();
				}
				
				if(totalPages - item <= 0) {
					lastLi.hide();
					afterPointLi.hide();
				}else if(totalPages - item == 1){
					afterPointLi.hide();
				}
				
				ul.append(pageNoLi);
			});
			
			ul.append(afterPointLi).append(lastLi).append(nextLi).appendTo("nav");
		}
		
		
		$(document).on("click", ".tradeTitle", function(){
			$(this).next().toggle();
		});
		
	})

</script>
</head>
<body>

	<div class="container">
	
		<br><br>
		
		<div id="trade_info"></div>
		<br>
		
		<nav aria-label="Page navigation"></nav>
		
		<div class="foot_height"></div>
		
	</div>

</body>
</html>