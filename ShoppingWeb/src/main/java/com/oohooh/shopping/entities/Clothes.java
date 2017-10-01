package com.oohooh.shopping.entities;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;

@Entity
public class Clothes {

	private Integer clothesId;

	private String clothesName;

	private float price;

	private String category;

	private String brand;

	private String color;

	private String gender;

	//各種size的庫存
	private Integer sizeS;
	private Integer sizeM;
	private Integer sizeL;
	private Integer sizeXL;
	
	private Picture picture;
	
	@JoinColumn(name="picture_Id", unique=true)
	@OneToOne(cascade = { CascadeType.ALL })
	public Picture getPicture() {
		return picture;
	}

	public void setPicture(Picture picture) {
		this.picture = picture;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	@GeneratedValue
	@Id
	@Column(name = "clothes_Id")
	public Integer getClothesId() {
		return clothesId;
	}

	public void setClothesId(Integer clothesId) {
		this.clothesId = clothesId;
	}

	@Column(name = "clothes_Name")
	public String getClothesName() {
		return clothesName;
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

	@Column(name = "Size_S")
	public Integer getSizeS() {
		return sizeS;
	}

	public void setSizeS(Integer sizeS) {
		this.sizeS = sizeS;
	}

	@Column(name = "Size_M")
	public Integer getSizeM() {
		return sizeM;
	}

	public void setSizeM(Integer sizeM) {
		this.sizeM = sizeM;
	}

	@Column(name = "Size_L")
	public Integer getSizeL() {
		return sizeL;
	}

	public void setSizeL(Integer sizeL) {
		this.sizeL = sizeL;
	}

	@Column(name = "Size_XL")
	public Integer getSizeXL() {
		return sizeXL;
	}

	public void setSizeXL(Integer sizeXL) {
		this.sizeXL = sizeXL;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

}
