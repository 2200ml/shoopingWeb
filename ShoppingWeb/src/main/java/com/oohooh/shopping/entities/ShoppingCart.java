package com.oohooh.shopping.entities;

import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

public class ShoppingCart {
	
	//key ¬O itemId => clothesId + size
	private Map<Integer, ShoppingCartItem> clothesMap = new HashMap<>();
	
	public void addClothes(Clothes clothes, Integer size) {
		Integer cartItemId = clothes.getClothesId() * 4 + size;
		ShoppingCartItem sci = clothesMap.get(cartItemId);
		
		if(sci == null) {
			sci = new ShoppingCartItem(clothes);
			sci.setItemId(size, clothes);
			sci.setSize(size);
			clothesMap.put(cartItemId, sci);
			
		}else if(sci != null){
			
			if(size == sci.getSize()) {
				sci.increment();
				
			}else if(size != sci.getSize()){
				ShoppingCartItem sci2 = new ShoppingCartItem(clothes);
				sci2.setItemId(size, clothes);
				sci2.setSize(size);
				clothesMap.put(cartItemId, sci2);
			}
		}
		
	}
	
	public Map<Integer, ShoppingCartItem> getClothesMap() {
		return clothesMap;
	}
	
	public Collection<ShoppingCartItem> getItems(){
		return clothesMap.values();
	}
	
	public int getTotalNumber() {
		int total = 0;
		
		for(ShoppingCartItem sci : clothesMap.values()){
			total += sci.getQuantity();
		}
		return total;
	}
	
	public float getTotalMoney() {
		float total = 0;
		for(ShoppingCartItem sci : clothesMap.values()) {
			total += sci.getItemMoney();
		}
		return total;
	}
	
	public void clear() {
		clothesMap.clear();
	}
	
	public void removeItem(Integer id) {
		clothesMap.remove(id);
	}
	
	public void updateItemQuantity(Integer id, int quantity) {
		ShoppingCartItem sci = clothesMap.get(id);
		if(sci != null) {
			sci.setQuantity(quantity);
		}
	}
	
	public void updateItemSize(Clothes clothes, int oldSize, int newSize, int quantity) {
		clothesMap.remove(clothes.getClothesId() * 4 + oldSize);
		ShoppingCartItem sci = new ShoppingCartItem(clothes);
		sci.setItemId(newSize, clothes);
		sci.setSize(newSize);
		sci.setQuantity(quantity);
		clothesMap.put(clothes.getClothesId() * 4 + newSize, sci);
	}
}
