package com.oohooh.shopping.handler;

import java.io.File;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.oohooh.shopping.entities.Clothes;
import com.oohooh.shopping.entities.ShoppingCart;
import com.oohooh.shopping.entities.ShoppingCartItem;
import com.oohooh.shopping.service.ClothesService;
import com.oohooh.shopping.utils.JsonMsg;
import com.oohooh.shopping.utils.ShoppingWebUtil;

@Controller
public class ClothesHandler {

	@Autowired
	private ClothesService clothesService;
	
	@ResponseBody
	@RequestMapping("deleteClothes")
	public JsonMsg deleteClothes(@RequestParam("clothesId") Integer clothesId ) {
		String picPath = "D:\\uploadFiles\\pic\\";
		Clothes clothes = clothesService.getClothesById(clothesId);
		String oldPic1Name = clothes.getPicture().getPic1();
		String oldFolderName = oldPic1Name.substring(0, oldPic1Name.lastIndexOf("\\"));
		File oldFileFolder = new File(picPath + oldFolderName);
		
		if(oldFileFolder.exists()) {
			ShoppingWebUtil.deleteFile(oldFileFolder);
		}
		
		clothesService.delete(clothesId);
		return JsonMsg.success();
	}
	
	
	@ResponseBody
	@RequestMapping("/updateQty")
	public JsonMsg updateQty(@RequestParam("clothesId") String clothesIdStr, @RequestParam("size") String sizeStr, 
			@RequestParam("quantity") String quantityStr, HttpServletRequest request) {
		
		ShoppingCart sc = ShoppingWebUtil.getShoppingCart(request);
		
		int clothesId = -1;
		int size = -1;
		int quantity = -1;
		
		try {
			clothesId = Integer.parseInt(clothesIdStr);
			size = Integer.parseInt(sizeStr);
			quantity = Integer.parseInt(quantityStr);
			
			if(clothesId > 0 && size > 0 && quantity > 0) {
				clothesService.updateQty(sc, clothesId, size, quantity);
			}
			
		} catch (Exception e) {}
		
		return JsonMsg.success();
	}
	
	@ResponseBody
	@RequestMapping("/updateSize")
	public JsonMsg updateSize(@RequestParam("clothesId") String clothesIdStr, @RequestParam("oldSize") String oldSizeStr, 
			@RequestParam("newSize") String newSizeStr, @RequestParam("quantity") String quantityStr, 
			HttpServletRequest request) {
		
		ShoppingCart sc = ShoppingWebUtil.getShoppingCart(request);
		
		int clothesId = -1;
		int oldSize = -1;
		int newSize = -1;
		int quantity = -1;
		
		try {
			clothesId = Integer.parseInt(clothesIdStr);
			oldSize = Integer.parseInt(oldSizeStr);
			newSize = Integer.parseInt(newSizeStr);
			quantity = Integer.parseInt(quantityStr);
			
			if(clothesId > 0 && oldSize > 0 && newSize > 0 && quantity > 0) {
				clothesService.updateSize(sc, clothesId, oldSize, newSize, quantity);
			}
			
		} catch (Exception e) {}
		
		return JsonMsg.success();
	}
	
	@ResponseBody
	@RequestMapping("/removeItem")
	public JsonMsg removeItem(@RequestParam("clothesId") String clothesIdStr, @RequestParam("size") String sizeStr, HttpServletRequest request) {
		
		ShoppingCart sc = ShoppingWebUtil.getShoppingCart(request);
		int clothesId = -1;
		int size = -1;
		
		try {
			clothesId = Integer.parseInt(clothesIdStr);
			size = Integer.parseInt(sizeStr);
			
			clothesService.remove(sc, clothesId, size);
		} catch (Exception e) {}
		
		return JsonMsg.success();
	}
	
	@ResponseBody
	@RequestMapping("/cartItems")
	public JsonMsg getCartItems(HttpServletRequest request) {
		ShoppingCart sc = ShoppingWebUtil.getShoppingCart(request);
		
		Collection<ShoppingCartItem> scItems = sc.getItems();
		
		return JsonMsg.success().add("scItems", scItems);
	}
	
	@ResponseBody
	@RequestMapping("/addToCart")
	public JsonMsg addToCart(@RequestParam("clothesId") String clothesIdStr, @RequestParam("size") String sizeStr, HttpServletRequest request) {
		
		ShoppingCart sc = ShoppingWebUtil.getShoppingCart(request);
		int clothesId = -1;
		int size = -1;
		
		try {
			clothesId = Integer.parseInt(clothesIdStr);
			size = Integer.parseInt(sizeStr);
			
			clothesService.addToCart(sc, clothesId, size);
		} catch (Exception e) {}
		
		return JsonMsg.success().add("shoppingCart", sc);
	}
	
	@ResponseBody
	@RequestMapping("/clothesInfo")
	public JsonMsg getClothesInfo(@RequestParam("clothesId") String clothesIdStr) {
		
		int clothesId = -1;
		
		try {
			clothesId = Integer.parseInt(clothesIdStr);
		} catch (Exception e) {}
		
		Clothes clothes = clothesService.getClothesById(clothesId);
		if(clothes == null) {
			return JsonMsg.fail();
		}
		
		return JsonMsg.success().add("clothes", clothes);
	}

	@ResponseBody
	@RequestMapping("/showItem")
	public JsonMsg showItem(@RequestParam(value="pageNo", required=false, defaultValue="1") String pageNoStr,
			@RequestParam(value="pageSize", required=false, defaultValue="6") String pageSizeStr,
			@RequestParam(value="minPrice", required=false) String minPriceStr,
			@RequestParam(value="maxPrice", required=false) String maxPriceStr,
			@RequestParam(value="genderCondition", required=false) String genderCondition,
			@RequestParam(value="categoryCondition", required=false) String categoryCondition,
			@RequestParam(value="queryCondition", required=false) String queryCondition) {
		
		int pageNo = 1;
		int pageSize = 6;
		float minPrice = 0;
		float maxPrice = Float.MAX_VALUE;
		
		try {
			pageNo = Integer.parseInt(pageNoStr);
			if(pageNo < 1) {
				pageNo = 1;
			}
		} catch (Exception e) {}
		
		try {
			pageSize = Integer.parseInt(pageSizeStr);
			if(pageSize < 6) {
				pageSize = 6;
			}
		} catch (Exception e) {}
		
		try {
			minPrice = Float.parseFloat(minPriceStr);
			if(minPrice < 0) {
				minPrice = 0;
			}
		} catch (Exception e) {}
		
		try {
			maxPrice = Float.parseFloat(maxPriceStr);
			if(maxPrice > Float.MAX_VALUE) {
				maxPrice = Float.MAX_VALUE;
			}
		} catch (Exception e) {}
		
		Page<Clothes> page = 
			clothesService.getPageByCondition(pageNo, pageSize, minPrice, maxPrice, genderCondition, categoryCondition, queryCondition);
		
		return JsonMsg.success().add("page", page);
	}
	
	
	@RequestMapping("/shoppingPage")
	public String getShoppingPage(@RequestParam(value="pageNo", required=false, defaultValue="1") String pageNoStr,
			@RequestParam(value="pageSize", required=false, defaultValue="6") String pageSizeStr,
			@RequestParam(value="minPrice", required=false) String minPriceStr,
			@RequestParam(value="maxPrice", required=false) String maxPriceStr,
			@RequestParam(value="genderCondition", required=false) String genderCondition,
			@RequestParam(value="categoryCondition", required=false) String categoryCondition,
			@RequestParam(value="queryCondition", required=false) String queryCondition,
			Map<String, Object> map) {
		
		int pageNo = 1;
		int pageSize = 6;
		float minPrice = 0;
		float maxPrice = Float.MAX_VALUE;
		
		try {
			pageNo = Integer.parseInt(pageNoStr);
			if(pageNo < 1) {
				pageNo = 1;
			}
		} catch (Exception e) {}
		
		try {
			pageSize = Integer.parseInt(pageSizeStr);
			if(pageSize < 6) {
				pageSize = 6;
			}
		} catch (Exception e) {}
		
		try {
			minPrice = Float.parseFloat(minPriceStr);
			if(minPrice < 0) {
				minPrice = 0;
			}
		} catch (Exception e) {}
		
		try {
			maxPrice = Float.parseFloat(maxPriceStr);
			if(maxPrice > Float.MAX_VALUE) {
				maxPrice = Float.MAX_VALUE;
			}
		} catch (Exception e) {}
		
		Page<Clothes> page = 
			clothesService.getPageByCondition(pageNo, pageSize, minPrice, maxPrice, genderCondition, categoryCondition, queryCondition);
		
		List<Integer> navigateNum = ShoppingWebUtil.getNavigateNumber(page);
		
		map.put("page", page);
		map.put("navigateNum", navigateNum);
		map.put("hasPrevious", page.hasPrevious());
		map.put("hasNext", page.hasNext());
		map.put("minPrice", minPrice);
		map.put("maxPrice", maxPrice);
		map.put("genderCondition", genderCondition);
		map.put("categoryCondition", categoryCondition);
		map.put("queryCondition", queryCondition);
		
		return "shoppingPage";
	}
	
}
