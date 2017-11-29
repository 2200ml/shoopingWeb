<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@ include file="/commons/commons-title.jsp" %>
<link rel="stylesheet" href="static/shoppingWeb/clothesInfo.css">
</head>
<script type="text/javascript">

	$(function(){
		
		var clothesId = ${clothesId};
		var url = "clothesInfo";
		var args = {"clothesId":clothesId};
		
		$.post(url, args, function(result){
			if(result.code == 100){
				var itemData = result.jsonObject.clothes;
				$("#item_Name").text(itemData.clothesName);
				$("#item_price").text("$" + itemData.price);
				$("#item_color").text(itemData.color);
				
				if(itemData.picture.pic1 != null){
					//中間大圖
					var pic1 = $("<img/>").attr("src", "/pic/" + itemData.picture.pic1);
					$("<div class='item active'></div>").append(pic1).append($("<div class='carousel-caption'></div>")).appendTo($(".carousel-inner"));
					var pic5 = $("<img/>").attr("src", "/pic/" + itemData.picture.pic1);
					var li1 = $("<li data-slide-to='0' data-target='#carousel-example-generic'></li>").append($("<a href=''></a>")
							.append($("<div class='imgSize'></div>").append(pic5)));
					$(".stacked").append(li1).append($("<br>"));
				}
				if(itemData.picture.pic2 != null){
					var pic2 = $("<img/>").attr("src", "/pic/" + itemData.picture.pic2);
					$("<div class='item'></div>").append(pic2).append($("<div class='carousel-caption'></div>")).appendTo($(".carousel-inner"));
					var pic6 = $("<img/>").attr("src", "/pic/" + itemData.picture.pic2);
					var li2 = $("<li data-slide-to='1' data-target='#carousel-example-generic'></li>").append($("<a href=''></a>")
							.append($("<div class='imgSize'></div>").append(pic6)));
					$(".stacked").append(li2).append($("<br>"))
				}
				if(itemData.picture.pic3 != null){
					var pic3 = $("<img/>").attr("src", "/pic/" + itemData.picture.pic3);
					$("<div class='item'></div>").append(pic3).append($("<div class='carousel-caption'></div>")).appendTo($(".carousel-inner"));
					var pic7 = $("<img/>").attr("src", "/pic/" + itemData.picture.pic3);
					var li3 = $("<li data-slide-to='2' data-target='#carousel-example-generic'></li>").append($("<a href=''></a>")
							.append($("<div class='imgSize'></div>").append(pic7)));
					$(".stacked").append(li3).append($("<br>"))
				}
				if(itemData.picture.pic4 != null){
					var pic4 = $("<img/>").attr("src", "/pic/" + itemData.picture.pic4);
					$("<div class='item'></div>").append(pic4).append($("<div class='carousel-caption'></div>")).appendTo($(".carousel-inner"));
					var pic8 = $("<img/>").attr("src", "/pic/" + itemData.picture.pic4);
					var li4 = $("<li data-slide-to='3' data-target='#carousel-example-generic'></li>").append($("<a href=''></a>")
							.append($("<div class='imgSize'></div>").append(pic8)));
					$(".stacked").append(li4).append($("<br>"))
				}
				
			}else{
				location.href = "index.jsp";
			}
		});
		
		$("#add_to_Cart_btn").click(function(){
			
			$("#select_size").parent().removeClass("has-error");
			$("#select_size").next("span").text("");
			
			//====選擇size校驗====
			if($("#select_size").val() == 0){
				$("#select_size").parent().addClass("has-error");
				$("#select_size").next("span").text("Please select");
				return false;
			}
			
			var url = "addToCart";
			var sizeVal = $("#select_size").val();
			var args = {"clothesId":clothesId, "size":sizeVal, "time":new Date() };
			$.post(url, args, function(result){
				if(result.code == 100){
					$("#bag_totalMoney").text(" $" + result.jsonObject.shoppingCart.totalMoney);
					$("#bag_totalNumber").text(" (" + result.jsonObject.shoppingCart.totalNumber + ")");
				}
			});
			
			//加入購物車後重置size選項
			$("#select_size").val(0);
		});
		
		$("#delete_btn").click(function(){
			var flag = confirm("Are you sure you want to delete?");
			if(flag){
				var url = "deleteClothes";
				var args = {"clothesId" : clothesId};
				$.post(url, args, function(result){
					if(result.code == 100){
						location.href = "index.jsp";
					}
				})
			}
		});
		
		$("#edit_btn").attr("href", "uploadItem/" + clothesId);
	})

</script>
<body>
	
	<div class="container">
		
		<shiro:hasRole name="admin">
		
			<shiro:authenticated>
				<div class="pull-right">
					<br><br>
					<a href ="" class="btn btn-warning" id="edit_btn" role="button">
						<i class="glyphicon glyphicon-pencil"></i>
						<span><fmt:message key="i18n.edit"></fmt:message></span>
					</a>
					
					<button class="btn btn-danger" id="delete_btn">
						<i class="glyphicon glyphicon-remove"></i>
						<span><fmt:message key="i18n.delete"></fmt:message></span>
					</button>
				</div>
			</shiro:authenticated>
			
			<shiro:notAuthenticated>
				<div class="pull-right">
					<br><br>
					<button class="btn btn-warning" disabled="disabled">
						<i class="glyphicon glyphicon-pencil"></i>
						<span><fmt:message key="i18n.edit"></fmt:message></span>
					</button>
					
					<button class="btn btn-danger" disabled="disabled">
						<i class="glyphicon glyphicon-remove"></i>
						<span><fmt:message key="i18n.delete"></fmt:message></span>
					</button>
				</div>
			</shiro:notAuthenticated>
			
		</shiro:hasRole>
		
		<br><br>
		<div class="row">
			<div class="col-md-1">
				<!-- 使用class="stacked"使內容垂直排列 -->
				<ol class="stacked"></ol>
			</div>
				
			<div class="col-md-6">
				<div id="carousel-example-generic" class="carousel slide" data-ride="carousel" data-interval="false">
				
				  <div class="carousel-inner" role="listbox"></div>
				  
				  <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
				    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
				    <span class="sr-only">Previous</span>
				  </a>
				  
				  <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
				    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
				    <span class="sr-only">Next</span>
				  </a>
				  
				</div>
			</div>
			
			<div class="col-md-5">
				<br><br>
				
				<div class="col-md-8 col-md-offset-2">
				 	<h2 id="item_Name"></h2>
				 	<h3><b><span id="item_price"></span></b></h3>
				 	<br>
				 	<h4><fmt:message key="i18n.color"></fmt:message>:&nbsp;&nbsp;<span id="item_color"></span></h4>
				 </div>
				 
			 	<div class="col-md-8 col-md-offset-2">
			 		<h4><fmt:message key="i18n.size"></fmt:message>:</h4>	
					<select class="form-control" id="select_size"><option value="0"><fmt:message key="i18n.select"></fmt:message></option>
						<option value="1">S</option>
						<option value="2">M</option>
						<option value="3">L</option>
						<option value="4">XL</option>
					</select>
					<span class="help-block"></span>
				</div>
				
				<div class="col-md-8 col-md-offset-2">
					<br>
					<button type="button" class="btn btn-primary btn-block" id="add_to_Cart_btn">
						<fmt:message key="i18n.addToBag"></fmt:message>
					</button>
				</div>
				
	 		</div>
		</div>
		
		<div class="foot_height"></div>
		
	</div>

</body>
</html>