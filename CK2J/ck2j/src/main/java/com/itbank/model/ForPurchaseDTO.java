package com.itbank.model;

public class ForPurchaseDTO {

	private int itemIdx;
	private String itemName;
	private String itemOpt;
	private int itemAmount;
	private int itemPrice;
	private int itemEachPrice;
	private String product_t_img;
	
	
	public int getItemEachPrice() {
		return itemEachPrice;
	}
	public void setItemEachPrice(int itemEachPrice) {
		this.itemEachPrice = itemEachPrice;
	}
	public String getProduct_t_img() {
		return product_t_img;
	}
	public void setProduct_t_img(String product_t_img) {
		this.product_t_img = product_t_img;
	}
	public int getItemIdx() {
		return itemIdx;
	}
	public void setItemIdx(int itemIdx) {
		this.itemIdx = itemIdx;
	}
	public String getItemName() {
		return itemName;
	}
	public void setItemName(String itemName) {
		this.itemName = itemName;
	}
	public String getItemOpt() {
		return itemOpt;
	}
	public void setItemOpt(String itemOpt) {
		this.itemOpt = itemOpt;
	}
	public int getItemAmount() {
		return itemAmount;
	}
	public void setItemAmount(int itemAmount) {
		this.itemAmount = itemAmount;
	}
	public int getItemPrice() {
		return itemPrice;
	}
	public void setItemPrice(int itemPrice) {
		this.itemPrice = itemPrice;
	}
}
