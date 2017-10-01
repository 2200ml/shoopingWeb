package com.oohooh.shopping.entities;


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Table(name = "Trade_Item")
@Entity
public class TradeItem {

	private Integer tradeItemId;
	private int quantity;
	private String size;
	private String clothesName;
	private float price;
	private String category;
	private String brand;
	private String color;
	private String gender;
	private Trade trade;
	// private Clothes clothes;  若與clothes建立關聯關係，當clothes被刪除時會發生錯誤

	@Column(name = "Clothes_Name")
	public String getClothesName() {
		return clothesName;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public void setClothesName(String clothesName) {
		this.clothesName = clothesName;
	}

	public float getPrice() {
		return price;
	}

	public void setPrice(float price) {
		this.price = price;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getBrand() {
		return brand;
	}

	public void setBrand(String brand) {
		this.brand = brand;
	}

	public String getColor() {
		return color;
	}

	public void setColor(String color) {
		this.color = color;
	}

	public String getSize() {
		return size;
	}

	public void setSize(String size) {
		this.size = size;
	}

	@GeneratedValue
	@Id
	public Integer getTradeItemId() {
		return tradeItemId;
	}

	public void setTradeItemId(Integer tradeItemId) {
		this.tradeItemId = tradeItemId;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	@JoinColumn(name = "Trade_id")
	@ManyToOne
	public Trade getTrade() {
		return trade;
	}

	public void setTrade(Trade trade) {
		this.trade = trade;
	}

}
