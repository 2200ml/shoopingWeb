<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>jQuery File Upload Example</title>
<base href="${pageContext.request.contextPath }/">

<link rel="stylesheet" href="static/bootstrap-3.3.7-dist/css/bootstrap.min.css">
<link rel="stylesheet" href="static/jQuery-File-Upload-9.19.0/css/jquery.fileupload.css">

<script type="text/javascript" src="static/scripts/jquery-3.2.1.js"></script>
<script src="static/jQuery-File-Upload-9.19.0/js/vendor/jquery.ui.widget.js"></script>

<script src="//blueimp.github.io/JavaScript-Load-Image/js/load-image.all.min.js"></script>

<script src="static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script src="static/jQuery-File-Upload-9.19.0/js/jquery.iframe-transport.js"></script>
<script src="static/jQuery-File-Upload-9.19.0/js/jquery.fileupload.js"></script>
<script src="static/jQuery-File-Upload-9.19.0/js/jquery.fileupload-process.js"></script>
<script src="static/jQuery-File-Upload-9.19.0/js/jquery.fileupload-image.js"></script>
<script src="static/jQuery-File-Upload-9.19.0/js/jquery.fileupload-validate.js"></script>

<script type="text/javascript">
	
	$(function () {
	    var url = "testUpload";
	    var uploadButton = $('<button/>').addClass('btn btn-primary').prop('disabled', true).text('Processing...');
	    uploadButton.on('click', function () {
            var $this = $(this);
            var data = $this.data();
            
            $this.off('click').text('Abort').on('click', function () {
	            $this.remove();
	            data.abort();
            });
            
            data.submit().always(function () {
                $this.remove();
            });
            
        });
	    
	    $("#progress").hide();
	    
	    var fileCount = 0;     
	    
	    $('#fileupload').fileupload({
	        url: url,
	        dataType: 'json',
	        autoUpload: false,
	        acceptFileTypes: /(\.|\/)(gif|jpe?g|png)$/i,
	        maxFileSize: 999000,
	        previewMaxWidth: 300,
	        previewMaxHeight: 300,
	        singleFileUploads:false,
	    }).bind('fileuploadsubmit', function (e, data) {
	        var testName = $('#testName').val();
	        data.formData = {testName: testName};
	        
	    }).on('fileuploadadd', function (e, data) {
	    	
	    	if(fileCount > 3){
	    		$('<span class="text-danger"/>').text("Max 4 files are allowed").appendTo("#files");
				return false;
			}
	    	
	        data.context = $('<div/>').appendTo('#files');
	        $.each(data.files, function (index, file) {
	            var node = $("<p class='fileName'></p>").append($('<span/>').text(file.name));
	            if (!index) {
	                node.append('<br>').append(uploadButton.clone(true).data(data));
	            }
	            node.appendTo(data.context);
	        });
	        
	        $("#progress").show();
	        
	    	fileCount++;
	    	
	    }).on('fileuploadprocessalways', function (e, data) {
	        var index = data.index,
	            file = data.files[index],
	            node = $(data.context.children()[index]);
	        
	        if (file.preview) {
	            node.prepend('<br>').prepend(file.preview);
	        }
	        if (file.error) {
	            node.append('<br>').append($('<span class="text-danger"/>').text(file.error));
	        }
	        if (index + 1 === data.files.length) {
	            data.context.find('button') .text('Upload').prop('disabled', !!data.files.error);
	        }
	    }).on('fileuploadprogressall', function (e, data) {
	        var progress = parseInt(data.loaded / data.total * 100, 10);
	        $('#progress .progress-bar').css(
	            'width',
	            progress + '%'
	        );
	    }).on('fileuploaddone', function (e, data) {
	    	var link = $("<a></a>").attr('target', '_blank').prop('href', "");

	    	$("#files").append(link.append($(".fileName")));
	    	
	    }).on('fileuploadfail', function (e, data) {
	        $.each(data.files, function (index) {
	            var error = $('<span class="text-danger"/>').text('File upload failed.');
	            $(data.context.children()[index]).append('<br>').append(error);
	        });
	    }).prop('disabled', !$.support.fileInput)
	        .parent().addClass($.support.fileInput ? undefined : 'disabled');
	});
		
</script>
</head>
<body>

	<div class="container">  
		<br><br><br>
		
			<span class="btn btn-success fileinput-button">
		        <i class="glyphicon glyphicon-plus"></i>
		        <span>Add files...</span>
		        <input id="fileupload" type="file" name="files[]" multiple>
		    </span>
		    
		    <br><br>
		    
		    <div id="progress" class="progress">
		        <div class="progress-bar progress-bar-success"></div>
		    </div>
		    
		    <div id="files" class="files"></div>
			
			<input type="text" name="testName" value="test" id="testName">
			<br><br>
			
			
				
			
<!-- 			<div class="col-md-4"> -->

<!-- 					<button class="btn btn-light fileinput-button"> -->
<!-- 						<i class="glyphicon glyphicon-pencil"></i> -->
<!-- 					</button> -->
<!-- 					<button class="btn btn-danger fileinput-button"> -->
<!-- 						<i class="glyphicon glyphicon-remove"></i> -->
<!-- 					</button> -->
					
<!-- 				<a href="clothesInfo.jsp?clothesId=1"> -->
<!-- 						<img src="/pic/7636791-1-grey.jpg"> -->
<!-- 				</a> -->
<!-- 				<div class="caption"> -->
<!-- 					<h5>Carhartt WIP College Script T-Shirt</h5> -->
<!-- 					<p><b>$39.48</b></p> -->
<!-- 				</div> -->
<!-- 			</div> -->
		
	</div>
	
</body> 
</html>