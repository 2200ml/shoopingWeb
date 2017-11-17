<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@ include file="/commons/commons-title.jsp" %>
<style type="text/css">
	
	.jumbotron {
		margin-bottom:20px;
	}
	
	.grey_font {
		font-size:14px;
		color:grey;
	}
	
	.grey_font a{
		font-size:14px;
		font-color:grey;
		color:grey;
		text-decoration: underline;
	}
	
	.page_change {
		line-height:34px;
	}
	
	.form-control:focus{
		outline: none;
		box-shadow:none;
		border:1px solid #ccc;
	}
	
	.jumbotron {
		padding-bottom:30px;
		padding-right:30px !important;
	}
	
	.itemImgSize {
		height: 370px; 
		width: 290px;
	}
	
	.itemImgSize img {
		width: 100%;
		height: 100%
	}
	
</style>

<script type="text/javascript">
	
		$(function(){
			
			var pageNo = ${page.number} + 1;
			var pageSize = ${page.size};
			var minPrice = ${minPrice};
			var maxPrice = ${maxPrice};
			//請求域中的物件若為空會報錯，需使用""包裹
			var genderCondition = "${genderCondition}";
			var categoryCondition = "${categoryCondition}";
			var queryCondition = "${queryCondition}"
			
			to_page();
		
			//========價格過濾============
			var textMinPrice = $(":text[name=minPrice]").val();
			var textMaxPrice = $(":text[name=maxPrice]").val();
			$.trim(textMinPrice);
			$.trim(textMaxPrice);
			
			$("#price_Filter").attr("href", "shoppingPage?pageSize=" + pageSize + "&minPrice=" + textMinPrice + "&maxPrice=" + textMaxPrice + 
					"&genderCondition=" + genderCondition + "&categoryCondition=" + categoryCondition + "&queryCondition=" + queryCondition);
			
			//=========商品查詢=============
			var textQueryCondition = $(":text[name=queryCondition]").val();
			$.trim(textQueryCondition);
			
			$("#query_btn").attr("href", "shoppingPage?queryCondition=" + textQueryCondition);
			
			//=============================
				
			function to_page(){
				var url = "showItem";
				var args = {"pageNo":pageNo, "pageSize":pageSize, "minPrice":minPrice, "maxPrice":maxPrice,
						"genderCondition": genderCondition, "categoryCondition":categoryCondition, "queryCondition":queryCondition};
				$.post(url, args, function(result){
					if(result.code == 100){
						build_clothes_div(result);
						build_page_nav();
					}
				});
			}
		
			function build_clothes_div(result){
				$("#clothesContent").empty();
				
				var clothesSet = result.jsonObject.page.content;
				$.each(clothesSet, function(index, item){
					var itemDiv = $("<div class='caption'></div>").append($("<h5>" + item.clothesName + "</h5>"))
																  .append($("<p><b>$"+ item.price + "</b></p>"));
					
					//使用虛擬路徑的方式存取圖片 /pic/
					var img = $("<a href='#'></a>").attr("href", "clothesInfo.jsp?clothesId=" + item.clothesId)
								.append($("<div class='itemImgSize'></div>")
								.append($("<img src='/pic/" + item.picture.pic1 + "'>"))); 
					
					var colDiv = $("<div class='col-md-4'></div>").append(img).append(itemDiv);
					
					//使用 clearfix 將每列顯示3筆圖片後換行並排列整齊 
					if((index + 1) % 3 == 0){
						$("#clothesContent").append(colDiv).append($("<div class='clearfix'></div>"));
					}else{
						$("#clothesContent").append(colDiv);
					}
				});
			}
		
			function build_page_nav(){
				$("nav").empty();

				var hasPrevious = ${hasPrevious};
				var hasNext = ${hasNext};
				var previousNo = ${page.number} + 1 - 1;
				
				var pageParameter = "&pageSize=" + pageSize + "&minPrice=" + minPrice + "&maxPrice=" + maxPrice + 
					"&genderCondition=" + genderCondition + "&categoryCondition=" + categoryCondition + "&queryCondition=" + queryCondition;
				
				var firstLi = $("<li></li>").append($("<a></a>").append("1")
						.attr("href", "shoppingPage?pageNo=" + 1 + pageParameter));
				var previousLi = $("<li></li>").append($("<a></a>").append("&laquo; Previous")
						.attr("href", "shoppingPage?pageNo="+ previousNo + pageParameter));
				
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
				
				var nextLi = $("<li></li>").append($("<a></a>").append("Next &raquo;")
						.attr("href", "shoppingPage?pageNo="+ nextNo + pageParameter));
				var lastLi = $("<li></li>").append($("<a></a>").append(totalPages)
						.attr("href", "shoppingPage?pageNo="+ totalPages + pageParameter));
				
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
							.attr("href", "shoppingPage?pageNo="+ item + pageParameter));	
					
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
			
			//========展示個數=========
			var sizeParameter = "&minPrice=" + minPrice + "&maxPrice=" + maxPrice + 
				"&genderCondition=" + genderCondition + "&categoryCondition=" + categoryCondition + "&queryCondition=" + queryCondition;
			
			$("#6_page").attr("href", "shoppingPage?pageNo=1&pageSize=6" + sizeParameter);
			
			$("#12_page").attr("href", "shoppingPage?pageNo=1&pageSize=12" + sizeParameter);
			
			$("#24_page").attr("href", "shoppingPage?pageNo=1&pageSize=24" + sizeParameter);
			
		})

</script>
</head>
<body>

	<div class="container">
		
		<div class="jumbotron">
			<div class="row">
				<div>
					<h1>Hello, world! Hello Github!</h1>
				</div>
				<div class="col-md-4 pull-right">
					<form id="search_form">
		                <div class="pull-right" id="custom-search-input">
		                    <input type="text" name="queryCondition" placeholder="Search">
		                    <a href="#" id="query_btn"><button><i class="glyphicon glyphicon-search"></i></button></a>
		                </div>
			        </form>
		        </div>
	        </div>
		</div>
		
		<div class="row">
			<form class="form-inline col-md-8">
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
			  <input type="hidden" name="pageSize" value="${page.size }"/>
			  <input type="hidden" name="genderCondition" value="${genderCondition }"/>
			  <input type="hidden" name="categoryCondition" value="${categoryCondition }"/>
			  <input type="hidden" name="queryCondition" value="${queryCondition }"/>
			  <a href="#" id="price_Filter"><button class="btn btn-primary">Filter</button></a>
			</form>
			
			<div class="col-md-4 page_change">
				<span class="grey_font pull-right">${page.totalElements } result | 
					<c:if test="${page.size == 6 }">
						<span class="grey_font">
							<a href="" id="12_page">view 12 per page</a>
						</span> |
						<span class="grey_font">
							<a href="" id="24_page">view 24 per page</a>
						</span> 
					</c:if>
					<c:if test="${page.size == 12 }">
						<span class="grey_font">
							<a href="" id="6_page">view 6 per page</a>
						</span> |
						<span class="grey_font">
							<a href="" id="24_page">view 24 per page</a>
						</span> 
					</c:if>
					<c:if test="${page.size == 24 }">
						<span class="grey_font">
							<a href="" id="6_page">view 6 per page</a>
						</span> |
						<span class="grey_font">
							<a href="" id="12_page">view 12 per page</a>
						</span> 
					</c:if>
				</span>
			</div>
			
		</div>
		
		<br>
		
		<div class="row" id="clothesContent"></div>
		
		<br>
		
		<nav aria-label="Page navigation"></nav>
		
		<div class="foot_height"></div>
		
	</div>
	
</body>
</html>