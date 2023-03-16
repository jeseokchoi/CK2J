package com.itbank.model;

public class UserOrderDetailDTO {

	private int userOrder_detail_idx;
	private int product_opt_idx;
	private String product_name;
	private String product_opt;
	private int user_order_idx;
	private int product_count;
	private int product_price;
	private String order_detail_status;

	
	public String getProduct_opt() {
		return product_opt;
	}
	public void setProduct_opt(String product_opt) {
		this.product_opt = product_opt;
	}
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	public int getUserOrder_detail_idx() {
		return userOrder_detail_idx;
	}
	public void setUserOrder_detail_idx(int userOrder_detail_idx) {
		this.userOrder_detail_idx = userOrder_detail_idx;
	}
	public int getProduct_opt_idx() {
		return product_opt_idx;
	}
	public void setProduct_opt_idx(int product_opt_idx) {
		this.product_opt_idx = product_opt_idx;
	}
	public int getUserOrder_idx() {
		return user_order_idx;
	}
	public void setUserOrder_idx(int userOrder_idx) {
		this.user_order_idx = userOrder_idx;
	}
	public int getProduct_count() {
		return product_count;
	}
	public void setProduct_count(int product_count) {
		this.product_count = product_count;
	}
	public int getProduct_price() {
		return product_price;
	}
	public void setProduct_price(int product_price) {
		this.product_price = product_price;
	}
	public String getOrder_detail_status() {
		return order_detail_status;
	}
	public void setOrder_detail_status(String order_detail_status) {
		this.order_detail_status = order_detail_status;
	}
	
	
}
