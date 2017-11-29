<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@ include file="/commons/commons-title.jsp" %>
<link rel="stylesheet" href="static/shoppingWeb/checkout.css">
<script type="text/javascript">

	$(function(){
	
		var totalMoney = ${totalMoney};
		
		var userBalance = ${account.accountBalance.balance };
		$("#user_balance_info").append($("<h4 id='sum_error'></h4>")
							   .append("<fmt:message key='i18n.yourBalance'></fmt:message>: $ " + userBalance));
		
		get_cart_info();
		
		function get_cart_info(){
			var url = "cartItems";
			$.post(url, function(result){
				if(result.code == 100){
					build_cart_item(result);
				}
			});
		}
		
		function build_cart_item(result){
			
			var scItems = result.jsonObject.scItems;
			$.each(scItems, function(index, item){

				var itemSize;
				
				if(item.size == 1){
					itemSize = "S";
				}else if(item.size == 2){
					itemSize = "M";
				}else if(item.size == 3){
					itemSize = "L";
				}else if(item.size == 4){
					itemSize = "XL";
				}
				
				var itemInfoDiv = $("<div class='col-md-9'></div>")
						.append($("<h4></h4>").append(item.clothes.clothesName))
						.append($("<p></p>")
						.append($("<b></b>")
						.append("<fmt:message key='i18n.color'></fmt:message>: " + item.clothes.color + 
								"&nbsp;&nbsp; | <fmt:message key='i18n.size'></fmt:message>: " + itemSize + 
								"&nbsp;&nbsp; | <fmt:message key='i18n.quantity'></fmt:message>: " + item.quantity + 
								"&nbsp;&nbsp;&nbsp;&nbsp; $ " + item.itemMoney)));
				
				$("<div class='page-header item_Div'></div>")
						.append($("<div class='row errorMessage'></div>").attr("id", item.itemId)
						.append(itemInfoDiv))
						.appendTo($("#cart_Items"));
			});
		}
		
		$("#confirm").click(function(){
			$(".storedErrorMessage").remove();
			$("#sum_error b").remove();
			
			var url = "confirmCheckout";
			$.post(url, function(result){
				if(result.code == 100){
					alert("Checkout Success !!");
					location.href = "index.jsp";
				}else{
					if(undefined != result.jsonObject.storedError){
						$.each(result.jsonObject.storedError, function(index, item){
							$("<div class='col-md-2 storedErrorMessage'></div>")
							.append($("<h4><b><font color='red'>Inventory shortage</font></b></h4>"))
							.append($("<h5><b><font color='red'>stored: " + item.stored + "</font></b></h5>"))
							.appendTo($("#" + item.itemId));
						});
					}
					if(undefined != result.jsonObject.sumError){
						$("<b></b>")
							.append($("<font color='red'></font>")
							.append("&nbsp;&nbsp;&nbsp;" + result.jsonObject.sumError + " &nbsp;&nbsp;[ 應付金額為 $ " + totalMoney + " ]"))
							.appendTo($("#sum_error"));
					}
				}
					
			});
			
		});
			
		
	})

</script>
</head>
<body>

	<div class="container">
	
		<div class="page-header" id="user_balance_info"></div>
	
		<div id="cart_Items"></div>
	
		<div class="col-md-offset-8 ">
			<h4>
				<fmt:message key="i18n.payable"></fmt:message>: $ ${totalMoney} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<button class="btn btn-default" type="submit" id="confirm"><fmt:message key="i18n.confirm"></fmt:message></button>
			</h4>
		</div>
		
		<div class="foot_height"></div>
	
	</div>

</body>
</html>