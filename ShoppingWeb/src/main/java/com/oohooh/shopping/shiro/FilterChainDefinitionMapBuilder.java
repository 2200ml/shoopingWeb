package com.oohooh.shopping.shiro;

import java.util.LinkedHashMap;

public class FilterChainDefinitionMapBuilder {

	public LinkedHashMap<String, String> buildFilterChainDefinitionMap(){
		LinkedHashMap<String, String> map = new LinkedHashMap<>();

		//==============請求=================
		map.put("/static/**", "anon");
		map.put("/logout", "logout");
		//註冊、登入
		map.put("/shiroLogin", "anon");
		map.put("/register", "anon");
		map.put("/validateUsername", "anon");
		map.put("/login", "anon");
		map.put("/myAccount", "user");
		//首頁、商品
		map.put("/shoppingPage", "anon");
		map.put("/showItem", "anon");
		//購物車
		map.put("/clothesInfo/**", "anon");
		map.put("/addToCart", "anon");
		map.put("/cartItems", "anon");
		map.put("/removeItem", "anon");
		map.put("/updateQty", "anon");
		map.put("/updateSize", "anon");
		map.put("/cart", "anon");
		//上傳
		map.put("/uploadItem", "authc, roles[admin]");
		map.put("/uploadClothes", "authc, roles[admin]");
		map.put("/deleteClothes", "authc, roles[admin]");
		
		//==============頁面=================
		map.put("/index.jsp", "anon");
		map.put("/shoppingPage.jsp", "anon");
		map.put("/cart.jsp", "anon");
		
		//==============測試=================
		map.put("/test/**", "anon");
		map.put("/testUpload", "anon");
		
		map.put("/**", "authc");
		
		return map;
	}
}
