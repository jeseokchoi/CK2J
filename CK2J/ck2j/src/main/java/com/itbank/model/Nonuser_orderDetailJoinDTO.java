package com.itbank.model;

import java.sql.Date;

public class Nonuser_orderDetailJoinDTO {

	// nonuser_order
	private int nonuser_order_idx;
	private Date order_date;
	private String receiver_name;
	private String address1;
	private String address2;
	private String address3;
	private int order_total_price;
//	private String nonuser_order_status;
	
	// detail
	private int nonuserOrder_detail_idx;  // 비회원 주문의 주문 번호 * 중요
	private int product_opt_idx;
	private int product_count;
//	private int	product_price;
	private String return_reason;
	
	private String order_detail_status;
	
	private String product_size;
	private String product_color;
	
	// product
	private String product_t_img;
	private String product_name;
	private String product_idx;
	private int product_price;
	
	// NonuserOrder_return
//	private String order_return_status;
	

	

	public String getOrder_detail_status() {
		return order_detail_status;
	}

	public String getReturn_reason() {
		return return_reason;
	}

	public void setReturn_reason(String return_reason) {
		this.return_reason = return_reason;
	}

	public String getAddress1() {
		return address1;
	}

	public void setAddress1(String address1) {
		this.address1 = address1;
	}

	public String getAddress2() {
		return address2;
	}

	public void setAddress2(String address2) {
		this.address2 = address2;
	}

	public String getAddress3() {
		return address3;
	}

	public void setAddress3(String address3) {
		this.address3 = address3;
	}

	public void setOrder_detail_status(String order_detail_status) {
		this.order_detail_status = order_detail_status;
	}

	public String getProduct_idx() {
		return product_idx;
	}

	public void setProduct_idx(String product_idx) {
		this.product_idx = product_idx;
	}

//	public String getOrder_return_status() {
//		return order_return_status;
//	}
//
//	public void setOrder_return_status(String order_return_status) {
//		this.order_return_status = order_return_status;
//	}

	public int getNonuser_order_idx() {
		return nonuser_order_idx;
	}

	public void setNonuser_order_idx(int nonuser_order_idx) {
		this.nonuser_order_idx = nonuser_order_idx;
	}

	public Date getOrder_date() {
		return order_date;
	}

	public void setOrder_date(Date order_date) {
		this.order_date = order_date;
	}

	public int getOrder_total_price() {
		return order_total_price;
	}

	public void setOrder_total_price(int order_total_price) {
		this.order_total_price = order_total_price;
	}

	public String getReceiver_name() {
		return receiver_name;
	}

	public void setReceiver_name(String receiver_name) {
		this.receiver_name = receiver_name;
	}

//	public String getNonuser_order_status() {
//		return nonuser_order_status;
//	}
//
//	public void setNonuser_order_status(String nonuser_order_status) {
//		this.nonuser_order_status = nonuser_order_status;
//	}

	public String getProduct_t_img() {
		return product_t_img;
	}

	public void setProduct_t_img(String product_t_img) {
		this.product_t_img = product_t_img;
	}

	public int getNonuserOrder_detail_idx() {
		return nonuserOrder_detail_idx;
	}

	public void setNonuserOrder_detail_idx(int nonuserOrder_detail_idx) {
		this.nonuserOrder_detail_idx = nonuserOrder_detail_idx;
	}

	public int getProduct_opt_idx() {
		return product_opt_idx;
	}

	public void setProduct_opt_idx(int product_opt_idx) {
		this.product_opt_idx = product_opt_idx;
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

	public String getProduct_size() {
		return product_size;
	}

	public void setProduct_size(String product_size) {
		this.product_size = product_size;
	}

	public String getProduct_color() {
		return product_color;
	}

	public void setProduct_color(String product_color) {
		this.product_color = product_color;
	}

	public String getProduct_name() {
		return product_name;
	}

	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	
	
	
}
