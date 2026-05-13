package com.entity;

public class itemdtls {
  private int item_id;
  private String item_name;
  private int  item_quantity;
  private  String price;
  private  String Category;
  private  String  item_status;
  private  String  photoname;
  private  String  email;
  public itemdtls() {
	super();
	// TODO Auto-generated constructor stub
  }
  public itemdtls(String item_name, int item_quantity, String price, String category, String item_status,
		String photoname, String email) {
	super();
	this.item_name = item_name;
	this.item_quantity = item_quantity;
	this.price = price;
	Category = category;
	this.item_status = item_status;
	this.photoname = photoname;
	this.email = email;
  }
  public int getItem_id() {
	return item_id;
  }
  public void setItem_id(int item_id) {
	this.item_id = item_id;
  }
  public String getItem_name() {
	return item_name;
  }
  public void setItem_name(String item_name) {
	this.item_name = item_name;
  }
  public int getItem_quantity() {
	return item_quantity;
  }
  public void setItem_quantity(int item_quantity) {
	this.item_quantity = item_quantity;
  }
  public String getPrice() {
	return price;
  }
  public void setPrice(String price) {
	this.price = price;
  }
  public String getCategory() {
	return Category;
  }
  public void setCategory(String category) {
	Category = category;
  }
  public String getItem_status() {
	return item_status;
  }
  public void setItem_status(String item_status) {
	this.item_status = item_status;
  }
  public String getPhotoname() {
	return photoname;
  }
  public void setPhotoname(String photoname) {
	this.photoname = photoname;
  }
  public String getEmail() {
	return email;
  }
  public void setEmail(String email) {
	this.email = email;
  }
  @Override
  public String toString() {
	return "itemdtls [item_id=" + item_id + ", item_name=" + item_name + ", item_quantity=" + item_quantity + ", price="
			+ price + ", Category=" + Category + ", item_status=" + item_status + ", photoname=" + photoname
			+ ", email=" + email + "]";
  }
  

  
  
}
