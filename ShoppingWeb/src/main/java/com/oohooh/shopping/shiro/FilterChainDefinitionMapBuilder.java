package com.oohooh.shopping.shiro;

import java.util.LinkedHashMap;

public class FilterChainDefinitionMapBuilder {

	public LinkedHashMap<String, String> buildFilterChainDefinitionMap(){
		LinkedHashMap<String, String> map = new LinkedHashMap<>();

		//==============�ШD=================
		map.put("/static/**", "anon");
		map.put("/logout", "logout");
		//���U�B�n�J
		map.put("/shiroLogin", "anon");
		map.put("/register", "anon");
		map.put("/validateUsername", "anon");
		map.put("/login", "anon");
		map.put("/myAccount", "user");
		//�����B�ӫ~
		map.put("/shoppingPage", "anon");
		map.put("/showItem", "anon");
		//�ʪ���
		map.put("/clothesInfo/**", "anon");
		map.put("/addToCart", "anon");
		map.put("/cartItems", "anon");
		map.put("/removeItem", "anon");
		map.put("/updateQty", "anon");
		map.put("/updateSize", "anon");
		map.put("/cart", "anon");
		//�W��
		map.put("/uploadItem", "authc, roles[admin]");
		map.put("/uploadClothes", "authc, roles[admin]");
		map.put("/deleteClothes", "authc, roles[admin]");
		
		//==============����=================
		map.put("/index.jsp", "anon");
		map.put("/shoppingPage.jsp", "anon");
		map.put("/cart.jsp", "anon");
		
		//==============����=================
		map.put("/test/**", "anon");
		map.put("/testUpload", "anon");
		
		map.put("/**", "authc");
		
		return map;
	}
}
