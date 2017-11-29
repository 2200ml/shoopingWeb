<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@ include file="/commons/commons-title.jsp" %>
<link rel="stylesheet" href="static/shoppingWeb/cart.css">

<script type="text/javascript">

	$(function(){
		
		var totalMoney = ${totalMoney};
		var totalNumber = ${totalNumber};
		
		$("#cart_total_money").text(" $" + totalMoney);
		$("#cart_total_number").text(totalNumber);
		
		if(totalNumber == 0){
			$("#content").empty();
				
			$("<div class='text-center'>").append($("<div class='foot_height'></div>"))
					.append($("<span class='glyphicon glyphicon-briefcase'></span>"))
					.append($("<h3><b><fmt:message key='i18n.bagEmpty'></fmt:message></b></h3>"))
					.appendTo($("#content"));
			return;
		}
			
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
				
				var itemName = item.clothes.clothesName;
				var itemPrice = item.clothes.price;
				var itemId = item.clothes.clothesId;
				var itemPic = item.clothes.picture.pic1
				
				var imgDiv = $("<div class='col-md-2 picDiv'><div>")
						.append($("<a href='clothesInfo.jsp?clothesId=" + itemId + "'></a>")
						.append($("<img src='/pic/" + itemPic + "'/>")));
				
				var priceDiv = $("<div class='row col-md-offset-1 col-md-8'></div>").append($("<h4></h4>")
						.append($("<b></b>").append("$" + itemPrice))
						.append($("<a href='' class='remove_item pull-right'></a>")
						.attr("clothesId", itemId).attr("sizeId", item.size)
						.append($("<span class='glyphicon glyphicon-remove col-md-offset-9'></span>"))));
				
				var itemNameDiv = $("<div class='row col-md-offset-1 col-md-8'></div>").append($("<h4></h4>")
						.append(itemName))
						.append("<br>");
				
				var selectDiv = $("<div class='row col-md-offset-1 col-md-8'>")
						.append($("<label class='col-sm-1' >Size</label>"))
						.append($("<div class='col-sm-3'></div>").append($("<select class='form-control select_size'></select>")
						.attr("clothesId", itemId)
						.attr("qtyId", item.quantity)
						.attr("sizeId", item.size)
						.append($("<option value='1'>S</option>"))
						.append($("<option value='2'>M</option>"))
						.append($("<option value='3'>L</option>"))
						.append($("<option value='4'>XL</option>")).val(item.size)))
						.append($("<label class='col-sm-1'>Qty</label>"))
						.append($("<div class='col-sm-3'></div>").append($("<select class='form-control select_qty'></select>")
						.attr("clothesId", itemId)
						.attr("sizeId", item.size)
						.append($("<option value='1'>1</option>"))
						.append($("<option value='2'>2</option>"))
						.append($("<option value='3'>3</option>"))
						.append($("<option value='4'>4</option>"))
						.append($("<option value='5'>5</option>")).val(item.quantity)));
						
				$("<div class='page-header item_Div'></div>").append($("<div class='row'></div>")
						.append(imgDiv).append(priceDiv).append(itemNameDiv).append(selectDiv))
						.appendTo($("#cart_Items"));
				
			});
			
		}
		
		$(document).on("click", ".remove_item", function(){
			var url = "removeItem";
			var clothesId = $(this).attr("clothesId");
			var size = $(this).attr("sizeId");
			var args = {"clothesId":clothesId, "size": size};
			var remove_row = $(this).parent().parent().parent();
			
			$.post(url, args, function(result){
				if(result.code == 100){
					//remove_row 朝著透明度0 歷時1500毫秒 變化
					remove_row.animate({opacity:'0.0'}, 1500);
					//1500毫秒後執行 location.href='cart.jsp
					setTimeout("location.href='cart.jsp'", 1500);
				}
			});
			
			return false;
		});
		
		$(document).on("change", ".select_qty", function(){
			var url = "updateQty";
			var clothesId = $(this).attr("clothesId");
			var quantity = $(this).val();
			var size = $(this).attr("sizeId");
			
			var args = {"clothesId":clothesId, "size": size, "quantity":quantity};
			
			$.post(url, args, function(result){
				if(result.code == 100){
					location.href = "cart.jsp";
				}
			});
			
		});
		
		$(document).on("change", ".select_size", function(){
			var url = "updateSize";
			var clothesId = $(this).attr("clothesId");
			var quantity = $(this).attr("qtyId");
			var oldSize = $(this).attr("sizeId");
			var newSize = $(this).val();
			
			var args = {"clothesId":clothesId, "oldSize": oldSize, "newSize":newSize, "quantity":quantity};
			
			$.post(url, args, function(result){
				if(result.code == 100){
					location.href = "cart.jsp";
				}
			});
			
		});
		
		$("#check_out").attr("href", "checkout");
		
	})

</script>
</head>
<body>

	<div class="container">

		<div class="row" id="content">
			<div class="col-md-8" id="cart_Items">
				<div class="page-header">
					<h3>
						<b><fmt:message key="i18n.myBag"></fmt:message></b>
						<small class="col-md-offset-6"><fmt:message key="i18n.itemReserved"></fmt:message></small>
					</h3>
				</div>
			</div>
			
			<div class="col-md-4">
				<div class="page-header">
					<h3><b><fmt:message key="i18n.total"></fmt:message></b></h3>
				</div>
				<div>
					<h4><b><fmt:message key="i18n.subTotal"></fmt:message></b><span class="col-md-offset-6" id="cart_total_money"></span></h4>
				</div>
				<br>
				<div>
					<h4><b><fmt:message key="i18n.totalNumber"></fmt:message></b><span class="col-md-offset-6" id="cart_total_number"></span></h4>
				</div>
				<br><br>
				<a href ="" class="btn btn-success btn-block btn-lg" id="check_out" role="button"><fmt:message key="i18n.checkout"></fmt:message></a>
			</div>
		</div>
		
		<div class="foot_height"></div>
		
	</div>	

</body>
</html>