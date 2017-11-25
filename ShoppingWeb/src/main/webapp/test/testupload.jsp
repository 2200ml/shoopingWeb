<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@ include file="/commons/commons-title.jsp" %>
<link rel="stylesheet" href="static/jQuery-File-Upload-9.19.0/css/jquery.fileupload.css">
<script src="static/jQuery-File-Upload-9.19.0/js/vendor/jquery.ui.widget.js"></script>
<script src="//blueimp.github.io/JavaScript-Load-Image/js/load-image.all.min.js"></script>
<script src="static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script src="static/jQuery-File-Upload-9.19.0/js/jquery.iframe-transport.js"></script>
<script src="static/jQuery-File-Upload-9.19.0/js/jquery.fileupload.js"></script>
<script src="static/jQuery-File-Upload-9.19.0/js/jquery.fileupload-process.js"></script>
<script src="static/jQuery-File-Upload-9.19.0/js/jquery.fileupload-image.js"></script>
<script src="static/jQuery-File-Upload-9.19.0/js/jquery.fileupload-validate.js"></script>

<%
	Integer clothesId = (Integer)request.getAttribute("clothesId");
	if(clothesId == null){
		request.setAttribute("clothesId", 0);
	}
%>
<style type="text/css">

	.center {
	  width: auto;
	  display: table;
	  margin-left: auto;
	  margin-right: auto;
	}
	.text-center {
	  text-align: center;
	}
	
	.imgPreview {
		width:250px;
		hight:300px;
	}
	
</style>

<script type="text/javascript">

	$(function () {
		
// 		var clothesId = ${clothesId};
		
// 		if(clothesId > 0){
// 			var url = "clothesUpdate/" + clothesId;
// 		}else{
// 			var url = "uploadClothes";
// 		}
	    
// 		if(clothesId > 0){
// 			var url2 = "clothesInfo";
// 			var args = {"clothesId" : clothesId}
// 			$.post(url2, args, function(result){
// 				if(result.code == 100){
// 					var clothesData = result.jsonObject.clothes;
					
// 					$(".imgArea").eq(0).children("img").hide();
// 					$(".imgArea").eq(0).append($("<img/>").addClass("imgPreview").attr("src", "/pic/" + clothesData.picture.pic1));
// 					$(".imgArea").eq(1).children("img").hide();
// 					$(".imgArea").eq(1).append($("<img/>").addClass("imgPreview").attr("src", "/pic/" + clothesData.picture.pic2));
// 					$(".imgArea").eq(2).children("img").hide();
// 					$(".imgArea").eq(2).append($("<img/>").addClass("imgPreview").attr("src", "/pic/" + clothesData.picture.pic3));
// 					$(".imgArea").eq(3).children("img").hide();
// 					$(".imgArea").eq(3).append($("<img/>").addClass("imgPreview").attr("src", "/pic/" + clothesData.picture.pic4));
					
// 					$("#clothesName").val(clothesData.clothesName);
// 					$("#brand").val(clothesData.brand);
// 					$("#category").val(clothesData.category);
// 					$("#gender").val(clothesData.gender);
// 					$("#price").val(clothesData.price);
// 					$("#color").val(clothesData.color);
// 					$("#sizeS").val(clothesData.sizeS);
// 					$("#sizeM").val(clothesData.sizeM);
// 					$("#sizeL").val(clothesData.sizeL);
// 					$("#sizeXL").val(clothesData.sizeXL);
// 				}
// 			});
// 		}
		
// 	    var fileCount = 0;
// 	    var imgIndex = 0;
// 		var fileList = [];
	    	
		var imageUpload = {
			    init: function (selector, context, options) {

			        selector = selector || '.file-upload';
			        context = context || $('.entry');

			        var filesList = [];
			        var url = "uploadClothes";

			        $(selector).fileupload(options || {
			            url: url,
			            type: 'POST',
			            dataType: 'json',
			            autoUpload: false,
			            acceptFileTypes: /(\.|\/)(gif|jpe?g|png)$/i,
				        maxFileSize: 999000,
				        previewMaxWidth: 300,
				        previewMaxHeight: 300,
			            singleFileUploads: false,
// 			            formData: {clothesId: clothesId,
// 				        	clothesName: $("#clothesName").val(),
// 			   				brand: $("#brand").val(),
// 			   				category: $("#category").val(),
// 			   				gender: $("#gender").val(),
// 			   				price: $("#price").val(),
// 			   				color: $("#color").val(),
// 			   				sizeS: $("#sizeS").val(),
// 			   				sizeM: $("#sizeM").val(),
// 			   				sizeL: $("#sizeL").val(),
// 			   				sizeXL: $("#sizeXL").val()},

			            add: function (e, data) {
			            	alert("123");
			                for (var i = 0; i < data.files.length; i++) {
			                    filesList.push(data.files[i]);
			                }

			                return false;
			            }
			        }).on('change', function () {
			        	alert("456");
			            $(this).fileupload('add', {
			                fileInput: $(selector)
			            });
			        });

			        $('#save_btn').click(function (e) {
			        	alert("789");
			            e.preventDefault();

			            $(selector).fileupload('send', {files: filesList});
			        });
			    }
			};
		
// 	    $(".form-horizontal").fileupload({
// 		        url: url,
// 		        dataType: 'json',
// 		        autoUpload: false,
// 		        acceptFileTypes: /(\.|\/)(gif|jpe?g|png)$/i,
// 		        maxFileSize: 999000,
// 		        previewMaxWidth: 300,
// 		        previewMaxHeight: 300,
// 		        singleFileUploads:false,
// 		        fileInput: $(".form-horizontal"),

// 		    }).on('fileuploadadd', function (e, data) {
// 				fileList.push(data.files[0]);
	            
// 		    }).on('fileuploadprocessalways', function (e, data) {
// 		    	if(fileCount > 4) {
// 					return false;
// 				}else if(fileCount == 4) {
// 					fileCount++;
// 				}
// 	            file = data.files[0];
// 		        if (file.preview) {
// 		        	var filePreview = $("<div></div>").append(file.preview);
// 		        	var fileNameNode = $("<p class='fileName'></p>").append($('<span/>').text(data.files[0].name));
// 	 	        	var previewDiv = $("<div></div>").append(filePreview).append(fileNameNode);
					
// // 					$(ele).find(".imgArea").children("img").hide();
// // 					$(ele).find(".imgArea").append(filePreview);
// // 					$(ele).find(".imgArea").append(fileNameNode);
					
// 		            imgIndex++
// 		        }
// 		        if (file.error) {
// 		            $('<span class="text-danger"/>').text(file.error).appendTo("#files");
// 		        }
// 			})
	    
	    
// 	    $('#upload_btn').click(function(){
// 	    	if(!validate_add_form()) {
// 				return false;
// 			}
// 	        file_upload.fileupload('send', 
// 	        		{files:fileList,
// 	        		 formData: {clothesId: clothesId,
// 					        	clothesName: $("#clothesName").val(),
// 				   				brand: $("#brand").val(),
// 				   				category: $("#category").val(),
// 				   				gender: $("#gender").val(),
// 				   				price: $("#price").val(),
// 				   				color: $("#color").val(),
// 				   				sizeS: $("#sizeS").val(),
// 				   				sizeM: $("#sizeM").val(),
// 				   				sizeL: $("#sizeL").val(),
// 				   				sizeXL: $("#sizeXL").val()}
// 	        		});
// 	    })
	    
	    function validate_add_form(){
	    	
			var clothesName = $("#clothesName").val();
			var reg100 = /^[a-zA-Z0-9-&\s]{4,100}$/;
			if(!reg100.test(clothesName)){
				show_validate_msg("#clothesName", "error", "clothesName 不合法 [4-100 英數字]");
				return false;
			}else{
				show_validate_msg("#clothesName", "success", "");
			};
			
			var brand = $("#brand").val();
			var reg32 = /^[a-zA-Z0-9-&\s]{1,32}$/;
			if(!reg32.test(brand)){
				show_validate_msg("#brand", "error", "brand 不合法 [1-32 英數字]");
				return false;
			}else{
				show_validate_msg("#brand", "success", "");
			}
			
			var category = $("#category").val();
			if(category == 0){
				show_validate_msg("#category", "error", "請選擇");
				return false;
			}else{
				show_validate_msg("#category", "success", "");
			}
			
			var price = $("#price").val();
			var regMoney = /^(([1-9]\d*)(\.\d{1,2})?)$|(0\.0?([1-9]\d?))$/;
			if(!regMoney.test(price)){
				show_validate_msg("#price", "error", "price 不合法 [不能為0, 小數點只到第2位]");
				return false;
			}else{
				show_validate_msg("#price", "success", "");
			}
			
			var color = $("#color").val();
			if(!reg32.test(color)){
				show_validate_msg("#color", "error", "color 不合法");
				return false;
			}else{
				show_validate_msg("#color", "success", "");
			}
			
			var regSize = /^\d{1,2}$/;
			var sizeS = $("#sizeS").val();
			var sizeM = $("#sizeM").val();
			var sizeL = $("#sizeL").val();
			var sizeXL = $("#sizeXL").val();
			if(!regSize.test(sizeS)){
				show_validate_msg("#sizeS", "error", "size 只能是0~99");
				return false;
			}else{
				show_validate_msg("#sizeS", "success", "");
			}
			if(!regSize.test(sizeM)){
				show_validate_msg("#sizeM", "error", "size 只能是0~99");
				return false;
			}else{
				show_validate_msg("#sizeM", "success", "");
			}
			if(!regSize.test(sizeL)){
				show_validate_msg("#sizeL", "error", "size 只能是0~99");
				return false;
			}else{
				show_validate_msg("#sizeL", "success", "");
			}
			if(!regSize.test(sizeXL)){
				show_validate_msg("#sizeXL", "error", "size 只能是0~99");
				return false;
			}else{
				show_validate_msg("#sizeXL", "success", "");
			}
			
			return true;
		};
		
		function show_validate_msg(ele, status, msg){
			$(ele).parent().removeClass("has-success has-error");
			$(ele).next("span").text("");
			
			if("success" == status){
				$(ele).parent().addClass("has-success");
				$(ele).next("span").text(msg);
			}else if("error" == status){
				$(ele).parent().addClass("has-error");
				$(ele).next("span").text(msg);
			}
		}
		
	});
	
</script>
</head>
<body>

	<div class="container">   
	    
<!-- 		<form class="form-horizontal"> -->
		
<!-- 			<div class="form-group" > -->
<!-- 				<div class="row"> -->
				
<!-- 					<div class="col-md-3" class="entry"> -->
<!-- 					    <div class="thumbnail"> -->
<!-- 					    	<div class="imgArea center"> -->
<!-- 					    		<img src="static/imgs/grey.png" class=".imgPreview"> -->
<!-- 					    	</div> -->
<!-- 				      		<div class="caption"> -->
<!-- 				        		<p><b>預覽圖</b></p> -->
<!-- 				        		<p> -->
<!-- 					        		<button class="btn btn-success fileinput-button"> -->
<!-- 								        <i class="glyphicon glyphicon-plus"></i> -->
<!-- 								        <span>Add files...</span> -->
<!-- 								        <input type="file" name="file1" class="file-upload"> -->
<!-- 								    </button> -->
<!-- 				        		</p> -->
<!-- 				      		</div> -->
<!-- 					    </div> -->
<!-- 		    		</div> -->
		    		
<!-- 		    		<div class="col-md-3" class="entry"> -->
<!-- 					    <div class="thumbnail" value="thumbnail"> -->
<!-- 					    	<div class="imgArea center"> -->
<!-- 					    		<img src="static/imgs/grey.png" class=".imgPreview"> -->
<!-- 					    	</div> -->
<!-- 				      		<div class="caption" value="caption"> -->
<!-- 				        		<p><b>附圖P1</b></p> -->
<!-- 				        		<p value="p"> -->
<!-- 					        		<button class="btn btn-success fileinput-button" value="button"> -->
<!-- 								        <i class="glyphicon glyphicon-plus"></i> -->
<!-- 								        <span>Add files...</span> -->
<!-- 								        <input type="file" name="file2" class="file-upload"> -->
<!-- 								    </button> -->
<!-- 				        		</p> -->
<!-- 				      		</div> -->
<!-- 					    </div> -->
<!-- 		    		</div> -->
		    		
<!-- 		    		<div class="col-md-3" class="entry"> -->
<!-- 					    <div class="thumbnail"> -->
<!-- 					    	<div class="imgArea center"> -->
<!-- 					    		<img src="static/imgs/grey.png" class=".imgPreview"> -->
<!-- 					    	</div> -->
<!-- 				      		<div class="caption"> -->
<!-- 				        		<p><b>附圖P2</b></p> -->
<!-- 				        		<p> -->
<!-- 					        		<button class="btn btn-success fileinput-button"> -->
<!-- 								        <i class="glyphicon glyphicon-plus"></i> -->
<!-- 								        <span>Add files...</span> -->
<!-- 								        <input type="file" name="file3" class="file-upload"> -->
<!-- 								    </button>  -->
<!-- 				        		</p> -->
<!-- 				      		</div> -->
<!-- 					    </div> -->
<!-- 		    		</div> -->
		    		
<!-- 		    		<div class="col-md-3" class="entry"> -->
<!-- 					    <div class="thumbnail"> -->
<!-- 					    	<div class="imgArea center"> -->
<!-- 					    		<img src="static/imgs/grey.png" class=".imgPreview"> -->
<!-- 					    	</div> -->
<!-- 				      		<div class="caption"> -->
<!-- 				        		<p><b>附圖P3</b></p> -->
<!-- 				        		<p> -->
<!-- 					        		<button class="btn btn-success fileinput-button"> -->
<!-- 								        <i class="glyphicon glyphicon-plus"></i> -->
<!-- 								        <span>Add files...</span> -->
<!-- 								        <input type="file" name="file4" class="file-upload"> -->
<!-- 								    </button> -->
<!-- 				        		</p> -->
<!-- 				      		</div> -->
<!-- 					    </div> -->
<!-- 		    		</div> -->
<!-- 				</div> -->
<!-- 			</div> -->

<!-- 			<div class="form-group"> -->
<!-- 				<label for="clothesName" class="col-md-3 control-label">Clothes Name</label> -->
<!-- 				<div class="col-md-6"> -->
<!-- 					<input type="text" class="form-control" id="clothesName" name="clothesName" placeholder="Clothes Name"> -->
<!-- 					<span class="help-block"></span> -->
<!-- 				</div> -->
<!-- 			</div> -->
			
<!-- 			<div class="form-group"> -->
<!-- 				<label for="brand" class="col-md-3 control-label">Brand</label> -->
<!-- 				<div class="col-md-6"> -->
<!-- 					<input type="text" class="form-control" id="brand" name="brand" placeholder="Brand"> -->
<!-- 					<span class="help-block"></span> -->
<!-- 				</div> -->
<!-- 			</div> -->
			
<!-- 			<div class="form-group"> -->
<!-- 				<label for="category" class="col-md-3 control-label">Category</label> -->
<!-- 				<div class="col-md-6"> -->
					<select class="form-control" id="category" name="category"><option value="0">Please select</option>
						<option value="T-Shirt">T-Shirt</option>
						<option value="Jeans">Jeans</option>
						<option value="Trousers">Trousers</option>
						<option value="Shirt">Shirt</option>
						<option value="Jackets">Jackets</option>
<!-- 					</select> -->
<!-- 					<span class="help-block"></span> -->
<!-- 				</div> -->
<!-- 			</div> -->
			
<!-- 			<div class="form-group"> -->
<!-- 				<label for="gender" class="col-md-3 control-label">Gender</label> -->
<!-- 				<div class="col-md-6"> -->
<!-- 					<select class="form-control" id="gender" name="gender"> -->
						<option value="Male">Male</option>
						<option value="Female">Female</option>
<!-- 					</select> -->
<!-- 					<span class="help-block"></span> -->
<!-- 				</div> -->
<!-- 			</div> -->
			
<!-- 			<div class="form-group"> -->
<!-- 				<label for="price" class="col-md-3 control-label">Price</label> -->
<!-- 				<div class="col-md-6"> -->
<!-- 					<input type="text" class="form-control" id="price" name="price" placeholder="$0.00"> -->
<!-- 					<span class="help-block"></span> -->
<!-- 				</div> -->
<!-- 			</div> -->
			
<!-- 			<div class="form-group"> -->
<!-- 				<label for="color" class="col-md-3 control-label">Color</label> -->
<!-- 				<div class="col-md-6"> -->
<!-- 					<input type="text" class="form-control" id="color" name="color" placeholder="color"> -->
<!-- 					<span class="help-block"></span> -->
<!-- 				</div> -->
<!-- 			</div> -->
			
<!-- 			<div class="form-group row"> -->
			
<!-- 				<label for="" class="col-md-3 control-label">Size</label> -->
<!-- 				<div class="col-md-2"> -->
<!-- 					<input type="text" class="form-control size" id="sizeS" name="sizeS" placeholder="S stored"> -->
<!-- 					<span class="help-block"></span> -->
<!-- 				</div> -->
				
<!-- 				<div class="col-md-2"> -->
<!-- 					<input type="text" class="form-control size" id="sizeM" name="sizeM" placeholder="M stored"> -->
<!-- 					<span class="help-block"></span> -->
<!-- 				</div> -->
				
<!-- 				<div class="col-md-2"> -->
<!-- 					<input type="text" class="form-control size" id="sizeL" name="sizeL" placeholder="L stored"> -->
<!-- 					<span class="help-block"></span> -->
<!-- 				</div> -->
				
<!-- 				<div class="col-md-2"> -->
<!-- 					<input type="text" class="form-control size" id="sizeXL" name="sizeXL" placeholder="XL stored"> -->
<!-- 					<span class="help-block"></span> -->
<!-- 				</div> -->
				
<!-- 			</div> -->

<!-- 			<div class="form-group"> -->
<!-- 				<label class="col-md-3 control-label"></label> -->
<!-- 				<div class="col-md-6"> -->
<!-- 					<button class="btn btn-primary submit" id="upload_btn">Upload</button> -->
<!-- 				</div> -->
<!-- 			</div> -->
			
<!-- 			<br><br><br><br> -->
<!-- 		</form> -->
	
	<form id="entry_form" class="entry-form" role="form">
	    <div class="entry">
	        ...
	        <input type="file" class="file-upload" name="files0[]" multiple>
	        ...
	    </div>
	    <div class="entry">
	        ...
	        <input type="file" class="file-upload" name="files1[]" multiple>
	        ...
	    </div>
	    <div class="entry">
	        ...
	        <input type="file" class="file-upload" name="files2[]" multiple>
	        ...
	    </div>
	</form>
	
	<div class="col-xs-6 col-sm-4">
	    <button id="save_btn" class="btn btn-lg btn-block">Save</button>
	</div>
	
	</div>
	
</body>
</html>