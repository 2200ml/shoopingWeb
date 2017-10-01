package com.oohooh.shopping.entities;

public class ShoppingCartItem {

	private Integer itemId;

	private Clothes clothes;

	private int quantity;

	private Integer size;

	private int stored;

	public int getStored() {
		return stored;
	}

	public void setStored(int stored) {
		this.stored = stored;
	}

	public Integer getItemId() {
		return itemId;
	}

	//因有4種size clothesId * 4 + size 後就不會有ItemId重複的情況
	public void setItemId(Integer size, Clothes clothes) {
		this.itemId = clothes.getClothesId() * 4 + size;
	}

	public Integer getSize() {
		return size;
	}

	public void setSize(Integer size) {
		this.size = size;
	}

	public ShoppingCartItem(Clothes clothes) {
		this.clothes = clothes;
		this.quantity = 1;
	}

	public Clothes getClothes() {
		return clothes;
	}

	public void setClothes(Clothes clothes) {
		this.clothes = clothes;
	}

	public float getItemMoney() {
		return quantity * clothes.getPrice();
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public int getQuantity() {
		return quantity;
	}

	public void increment() {
		quantity++;
	}
}
