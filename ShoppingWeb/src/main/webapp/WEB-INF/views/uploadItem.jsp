<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@ include file="/commons/commons-title.jsp" %>
<link rel="stylesheet" href="static/shoppingWeb/uploadItem.css">

<link rel="stylesheet" href="static/jQuery-File-Upload-9.19.0/css/jquery.fileupload.css">
<script src="static/jQuery-File-Upload-9.19.0/js/vendor/jquery.ui.widget.js"></script>
<script src="static/jQuery-File-Upload-9.19.0/js/load-image.all.min.js"></script>
<script src="static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script src="static/jQuery-File-Upload-9.19.0/js/jquery.iframe-transport.js"></script>
<script src="static/jQuery-File-Upload-9.19.0/js/jquery.fileupload.js"></script>
<script src="static/jQuery-File-Upload-9.19.0/js/jquery.fileupload-process.js"></script>
<script src="static/jQuery-File-Upload-9.19.0/js/jquery.fileupload-image.js"></script>
<script src="static/jQuery-File-Upload-9.19.0/js/jquery.fileupload-validate.js"></script>

<script type="text/javascript">

	$(function () {
		
		var clothesId = "${clothesId}";
		
		if(clothesId > 0){
			var url = "clothesUpdate/" + clothesId;
		}else{
			var url = "uploadClothes";
		}
	    
		//編輯時商品回顯
		if(clothesId > 0){
			var url2 = "clothesInfo";
			var args = {"clothesId" : clothesId}
			$.post(url2, args, function(result){
				if(result.code == 100){
					var clothesData = result.jsonObject.clothes;
					
					if(clothesData.picture.pic1 != null){
						$(".imgArea").eq(0).children("img").hide();
						$(".imgArea").eq(0).append($("<img/>").addClass("imgPreview").attr("src", "/pic/" + clothesData.picture.pic1));
					}
					if(clothesData.picture.pic2 != null){
						$(".imgArea").eq(1).children("img").hide();
						$(".imgArea").eq(1).append($("<img/>").addClass("imgPreview").attr("src", "/pic/" + clothesData.picture.pic2));
					}
					if(clothesData.picture.pic3 != null){
						$(".imgArea").eq(2).children("img").hide();
						$(".imgArea").eq(2).append($("<img/>").addClass("imgPreview").attr("src", "/pic/" + clothesData.picture.pic3));
					}
					if(clothesData.picture.pic4 != null){
						$(".imgArea").eq(3).children("img").hide();
						$(".imgArea").eq(3).append($("<img/>").addClass("imgPreview").attr("src", "/pic/" + clothesData.picture.pic4));
					}
					
					$("#clothesName").val(clothesData.clothesName);
					$("#brand").val(clothesData.brand);
					$("#category").val(clothesData.category);
					$("#gender").val(clothesData.gender);
					$("#price").val(clothesData.price);
					$("#color").val(clothesData.color);
					$("#sizeS").val(clothesData.sizeS);
					$("#sizeM").val(clothesData.sizeM);
					$("#sizeL").val(clothesData.sizeL);
					$("#sizeXL").val(clothesData.sizeXL);
				}
			});
			
			$(".fileinput-button").children("span").text("重新上傳");
			$("#upload_btn").text("Update");
			
		}
		
		$("#progress").hide();
		
	    var fileCount = 0;
	    var imgIndex = 0;
		var fileList = [];

	    $("#fileupload").fileupload({
	        url: url,
	        dataType: 'json',
	        autoUpload: false,
	        acceptFileTypes: /(\.|\/)(gif|jpe?g|png)$/i,
	        maxFileSize: 999000,
	        previewMaxWidth: 300,
	        previewMaxHeight: 300,
	        //限制一次上傳所有檔案
	        singleFileUploads: false,
	        maxNumberOfFiles: 4,

	    }).on('fileuploadadd', function (e, data) {
	    	$("#files").empty();
	    	if(fileCount > 4){
	    		$('<span class="text-danger maxError"/>').text("Max 4 files are allowed").appendTo("#files");
	    		$(".fileinput-button").attr("disabled", "true");
	    		$("#fileupload").hide();
				return false;
			}
	    	fileCount++;
	    	
	    	for (var i = 0; i < data.files.length; i++) {
                fileList.push(data.files[i]);
            }
            
	    }).on('fileuploadprocessalways', function (e, data) {
	    	if(fileCount > 4) {
				return false;
			}else if(fileCount == 4) {
				fileCount++;
			}
	    	
	    	var index = data.index,
            file = data.files[index];
	        if (file.preview) {
	        	var filePreview = $("<div></div>").append(file.preview);
	        	var fileNameNode = $("<p class='fileName'></p>").append($('<span/>').text(data.files[index].name));
 	        	var previewDiv = $("<div></div>").append(filePreview).append(fileNameNode);
 	        	
 	        	if(data.files.length > 0){
 	        		$(".imgArea").eq(index).children("img").hide();
 	        		$(".imgArea").eq(index).append(previewDiv);
 	        		$(".fileinput-button").attr("disabled", "true");
 		    		$("#fileupload").hide();
 	        	}
 	        	
				$(".imgArea").eq(imgIndex).children("img").hide();
				$(".imgArea").eq(imgIndex).append(previewDiv);
	            imgIndex++
	        }
	        if (file.error) {
	        	$("#files").empty();
	            $('<span class="text-danger"/>').text(file.error).appendTo("#files");
	            $("#upload_btn").attr("disabled", "true");
	        }
	        
	        $("#progress").show();
   
		}).on('fileuploadprogressall', function (e, data) {
	        var progress = parseInt(data.loaded / data.total * 100, 10);
	        $('#progress .progress-bar').css(
	            'width',
	            progress + '%'
	        );
	    }).on('fileuploaddone', function (e, data) {
	    	$("#files").empty();
	    	var success = $('<span class="text-success"/>').text('File upload success.');
	    	success.appendTo("#files");
	    }).on('fileuploadfail', function (e, data) {
	    	$("#files").empty();
            var error = $('<span class="text-danger"/>').text('File upload failed.');
            error.appendTo("#files");
	    });
	    
	    $('#upload_btn').click(function(){
	    	if(!validate_add_form()) {
				return false;
			}
	    	if(fileList.length == 0 && clothesId > 0) {
				var url = "clothesUpdate/" + clothesId;
				var args = {"clothesId": clothesId,
						 "clothesName": $("#clothesName").val(),
		   				 "brand": $("#brand").val(),
		   				 "category": $("#category").val(),
		   				 "gender": $("#gender").val(),
		   				 "price": $("#price").val(),
		   				 "color": $("#color").val(),
		   				 "sizeS": $("#sizeS").val(),
		   				 "sizeM": $("#sizeM").val(),
		   				 "sizeL": $("#sizeL").val(),
		   				 "sizeXL": $("#sizeXL").val()};
				$.post(url, args, function(result){
					$("#files").empty();
					if(result.code == 100){
						$('<span class="text-success"/>').text('File update success.').appendTo("#files");
					}
				})		
	    	}
			
	        $("#fileupload").fileupload('send', 
	        		{files:fileList,
	        		 formData: {clothesId: clothesId,
					        	clothesName: $("#clothesName").val(),
				   				brand: $("#brand").val(),
				   				category: $("#category").val(),
				   				gender: $("#gender").val(),
				   				price: $("#price").val(),
				   				color: $("#color").val(),
				   				sizeS: $("#sizeS").val(),
				   				sizeM: $("#sizeM").val(),
				   				sizeL: $("#sizeL").val(),
				   				sizeXL: $("#sizeXL").val()}
	        		});
	        
	        $("#upload_btn").attr("disabled", "true");
	        $(".fileinput-button").attr("disabled", "true");
	        $("#fileupload").attr("disabled", "true");
	    	
	    })
	    
	    $(".fileinput-button").click(function(){
			$(".imgPreview").attr("src", "static/imgs/grey.png");
		});
	    
	    function validate_add_form(){
	    	
	    	if(fileList.length == 0 && clothesId == 0) {
	    		$("#files").empty();
	            var error = $('<span class="text-danger"/>').text('Please add Files');
	            error.appendTo("#files");
	            return false;
			}
	    	
			var clothesName = $("#clothesName").val();
			var reg100 = /^[a-zA-Z0-9-&\'%\/\s]{4,100}$/;
			if(!reg100.test(clothesName)){
				show_validate_msg("#clothesName", "error", "clothesName 不合法 [4-100 英數字]");
				return false;
			}else{
				show_validate_msg("#clothesName", "success", "");
			};
			
			var brand = $("#brand").val();
			var reg32 = /^[a-zA-Z0-9-&\'\/\s]{1,32}$/;
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
	    
	    <br><br>
	    
		<div class="form-horizontal">
		
			<div class="form-group" >
				<div class="row">
				
					<div class="col-md-3" id="file1">
					    <div class="thumbnail">
					    	<div class="imgArea center">
					    		<img src="static/imgs/grey.png" class="imgPreview">
					    	</div>
				      		<div class="caption">
				        		<p><b><fmt:message key="i18n.preview"></fmt:message></b></p>
				      		</div>
					    </div>
		    		</div>
		    		
		    		<div class="col-md-3" id="file2">
					    <div class="thumbnail">
					    	<div class="imgArea center">
					    		<img src="static/imgs/grey.png" class="imgPreview">
					    	</div>
				      		<div class="caption">
				        		<p><b><fmt:message key="i18n.pic"></fmt:message>1</b></p>
				      		</div>
					    </div>
		    		</div>
		    		
		    		<div class="col-md-3" id="file3">
					    <div class="thumbnail">
					    	<div class="imgArea center">
					    		<img src="static/imgs/grey.png" class="imgPreview">
					    	</div>
				      		<div class="caption">
				        		<p><b><fmt:message key="i18n.pic"></fmt:message>2</b></p>
				      		</div>
					    </div>
		    		</div>
		    		
		    		<div class="col-md-3" id="file4">
					    <div class="thumbnail">
					    	<div class="imgArea center">
					    		<img src="static/imgs/grey.png" class="imgPreview">
					    	</div>
				      		<div class="caption">
				        		<p><b><fmt:message key="i18n.pic"></fmt:message>3</b></p>
				      		</div>
					    </div>
		    		</div>
				</div>
			</div>
			
			<div class="form-group">
				<label for="" class="col-md-3 control-label"></label>
				<div class="col-md-6">
					<div id="progress" class="progress">
						<div class="progress-bar progress-bar-success"></div>
					</div>
					<div id="files" class="text-center"></div>
				</div>
			</div>
			
			<div class="form-group">
				<label for="" class="col-md-3 control-label"></label>
				<div class="col-md-6" id="btn_area">
					<button class="btn btn-success fileinput-button">
				        <i class="glyphicon glyphicon-plus"></i>
				        <span><fmt:message key="i18n.addFiles"></fmt:message>...</span>
				        <input id="fileupload" type="file" name="files[]" multiple>
				    </button>
			    </div>
				<br>			    
			</div>

			<div class="form-group">
				<label for="clothesName" class="col-md-3 control-label"><fmt:message key="i18n.clothesName"></fmt:message></label>
				<div class="col-md-6">
					<input type="text" class="form-control" id="clothesName" name="clothesName" placeholder="Clothes Name">
					<span class="help-block"></span>
				</div>
			</div>
			
			<div class="form-group">
				<label for="brand" class="col-md-3 control-label"><fmt:message key="i18n.brand"></fmt:message></label>
				<div class="col-md-6">
					<input type="text" class="form-control" id="brand" name="brand" placeholder="Brand">
					<span class="help-block"></span>
				</div>
			</div>
			
			<div class="form-group">
				<label for="category" class="col-md-3 control-label"><fmt:message key="i18n.category"></fmt:message></label>
				<div class="col-md-6">
					<select class="form-control" id="category" name="category">
						<option value="0"><fmt:message key="i18n.select"></fmt:message></option>
						<option value="T-Shirt"><fmt:message key="i18n.t-shirt"></fmt:message></option>
						<option value="Jeans"><fmt:message key="i18n.jeans"></fmt:message></option>
						<option value="Trousers"><fmt:message key="i18n.trousers"></fmt:message></option>
						<option value="Shirt"><fmt:message key="i18n.shirt"></fmt:message></option>
						<option value="Jackets"><fmt:message key="i18n.jackets&coats"></fmt:message></option>
					</select>
					<span class="help-block"></span>
				</div>
			</div>
			
			<div class="form-group">
				<label for="gender" class="col-md-3 control-label"><fmt:message key="i18n.gender"></fmt:message></label>
				<div class="col-md-6">
					<select class="form-control" id="gender" name="gender">
						<option value="Male"><fmt:message key="i18n.male"></fmt:message></option>
						<option value="Female"><fmt:message key="i18n.female"></fmt:message></option>
					</select>
					<span class="help-block"></span>
				</div>
			</div>
			
			<div class="form-group">
				<label for="price" class="col-md-3 control-label"><fmt:message key="i18n.price"></fmt:message></label>
				<div class="col-md-6">
					<input type="text" class="form-control" id="price" name="price" placeholder="$0.00">
					<span class="help-block"></span>
				</div>
			</div>
			
			<div class="form-group">
				<label for="color" class="col-md-3 control-label"><fmt:message key="i18n.color"></fmt:message></label>
				<div class="col-md-6">
					<input type="text" class="form-control" id="color" name="color" placeholder="color">
					<span class="help-block"></span>
				</div>
			</div>
			
			<div class="form-group row">
			
				<label for="" class="col-md-3 control-label"><fmt:message key="i18n.size"></fmt:message></label>
				<div class="col-md-2">
					<input type="text" class="form-control size" id="sizeS" name="sizeS" placeholder="S stored">
					<span class="help-block"></span>
				</div>
				
				<div class="col-md-2">
					<input type="text" class="form-control size" id="sizeM" name="sizeM" placeholder="M stored">
					<span class="help-block"></span>
				</div>
				
				<div class="col-md-2">
					<input type="text" class="form-control size" id="sizeL" name="sizeL" placeholder="L stored">
					<span class="help-block"></span>
				</div>
				
				<div class="col-md-2">
					<input type="text" class="form-control size" id="sizeXL" name="sizeXL" placeholder="XL stored">
					<span class="help-block"></span>
				</div>
				
			</div>

			<div class="form-group">
				<label class="col-md-3 control-label"></label>
				<div class="col-md-6" id="upload_update_btn_area">
					<button class="btn btn-primary submit" id="upload_btn"><fmt:message key="i18n.upload"></fmt:message></button>
				</div>
			</div>
			
			<div class="foot_height"></div>
			
		</div>
	
	</div>
	
</body>
</html>