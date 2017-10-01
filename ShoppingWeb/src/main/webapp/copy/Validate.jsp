<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<script type="text/javascript">
	
	function validate_add_form(){
		
		var clothesName = $("#clothesName").val();
		var reg100 = /^[a-z0-9-\s]{4,100}$/;
		if(!reg100.test(clothesName)){
			show_validate_msg("#clothesName", "error", "clothesName 不合法 [4-100 英數字]");
			return false;
		}else{
			show_validate_msg("#clothesName", "success", "");
		};
		
		var brand = $("#brand").val();
		var reg32 = /^[a-z0-9-]{1,32}$/;
		if(!regBrand.test(brand)){
			show_validate_msg("#brand", "error", "brand 不合法");
			return false;
		}else{
			show_validate_msg("#brand", "success", "");
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
		
		var category = $("#category").val();
		if(category == 0){
			show_validate_msg("#category", "error", "請選擇");
			return false;
		}else{
			show_validate_msg("#category", "success", "");
		}

		var regSize = /^/d{2}$/;
		var size = $(".size").val();
		if(!regSize.text(size)){
			show_validate_msg(".size", "error", "size 只能是0~99");
			return false;
		}else{
			show_validate_msg(".size", "success", "");
		}
		
		
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
	
</script>
