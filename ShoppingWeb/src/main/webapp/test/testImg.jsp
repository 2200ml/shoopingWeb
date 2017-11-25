<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@ include file="/commons/commons-title.jsp" %>
<style type="text/css">

	.carousel {
    	height: 655px;
    	width: 513px;
	}
	
	.carousel-control.left, .carousel-control.right {
	   background-image:none;
	}
	
	.imgSize {
		height: 60px; 
		width: 48px;
	}
	
	 ol li {
		list-style-type:none;
	}
	
/* 	.carousel-control.left, .carousel-control.right { */
/* 	   background-image:none !important; */
/* 	   filter:none !important; */
/* 	} */

</style>
</head>
<body>
		
	<div class="container">
			
			<div class="row">
				<div class="col-md-1">
				<ol class="stacked">
					<li data-slide-to="0" data-target="#carousel-example-generic">
						<a href="">
							<div class="imgSize">
								<img src="static/imgs/t-shirt/8459039-1-heathergrey.jpg" style="width: 100%; height: 100%">
							</div>
						</a>
					</li>
					<br>
					<li data-slide-to="1" data-target="#carousel-example-generic">
						<a href="">
							<div class="imgSize">
								<img src="static/imgs/t-shirt/8459039-2.jpg" style="width: 100%; height: 100%">
							</div>
						</a>
					</li>
					<br>
					<li data-slide-to="2" data-target="#carousel-example-generic">
						<a href="">
							<div class="imgSize">
								<img src="static/imgs/t-shirt/8459039-3.jpg" style="width: 100%; height: 100%">
							</div>
						</a>
					</li>
					<br>
					<li data-slide-to="3" data-target="#carousel-example-generic">
						<a href="">
							<div class="imgSize">
								<img src="static/imgs/t-shirt/8459039-4.jpg" style="width: 100%; height: 100%">
							</div>
						</a>
					</li>
				</ol>
				</div>
				
				<div class="col-md-6">
					<div id="carousel-example-generic" class="carousel slide" data-ride="carousel" data-interval="false">
					  <div class="carousel-inner" role="listbox">
					  
					    <div class="item active">
					      <img src="static/imgs/t-shirt/8459039-1-heathergrey.jpg">
					      <div class="carousel-caption">
					      </div>
					    </div>
					    
					    <div class="item">
					      <img src="static/imgs/t-shirt/8459039-2.jpg">
					      <div class="carousel-caption">
					      </div>
					    </div>
					    
					    <div class="item">
					      <img src="static/imgs/t-shirt/8459039-3.jpg">
					      <div class="carousel-caption">
					      </div>
					    </div>
					    
					    <div class="item">
					      <img src="static/imgs/t-shirt/8459039-4.jpg">
					      <div class="carousel-caption">
					      </div>
					    </div>
					    
					  </div>
					  
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
				
		</div>
		
		
		
		
	</div>
		
</body>
</html>