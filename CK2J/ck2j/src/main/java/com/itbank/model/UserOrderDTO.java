package com.itbank.model;

import java.sql.Date;


public class UserOrderDTO {
	private int user_order_idx;
	private String user_id;
	private Date order_date;
	private String product_name;
	private String address1;
	private String address2;
	private String address3;
	private int product_idx;
	private int product_opt_idx;
	private int product_count;
	private int order_total_price;
	private String product_t_img;
	private String order_detail_status;

	private int userOrder_detail_idx;
	private String product_size;
	private String product_color;
	private String product_price;
	private String user_name;
	
	
	private int product_total_count;
	private String status_for_admin;
	private String receiver_name;
	private String receiver_phone;
	private String DepositName;
	private String adminBankAccount;
	private String email1;
	private String email2;
	
	
	//새봄  2/26 refund  환불 생성 테이블 때문에 추가 
	private String return_reason;
	
	
	public String getReturn_reason() {
		return return_reason;
	}
	public void setReturn_reason(String return_reason) {
		this.return_reason = return_reason;
	}
	public int getUserOrder_detail_idx() {
		return userOrder_detail_idx;
	}
	public void setUserOrder_detail_idx(int userOrder_detail_idx) {
		this.userOrder_detail_idx = userOrder_detail_idx;
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
	public String getProduct_price() {
		return product_price;
	}
	public void setProduct_price(String product_price) {
		this.product_price = product_price;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public int getProduct_opt_idx() {
		return product_opt_idx;
	}
	public void setProduct_opt_idx(int product_opt_idx) {
		this.product_opt_idx = product_opt_idx;
	}
	public String getEmail1() {
		return email1;
	}
	public void setEmail1(String email1) {
		this.email1 = email1;
	}
	public String getEmail2() {
		return email2;
	}
	public void setEmail2(String email2) {
		this.email2 = email2;
	}
	public String getReceiver_name() {
		return receiver_name;
	}
	public void setReceiver_name(String receiver_name) {
		this.receiver_name = receiver_name;
	}
	public String getReceiver_phone() {
		return receiver_phone;
	}
	public void setReceiver_phone(String receiver_phone) {
		this.receiver_phone = receiver_phone;
	}
	public String getDepositName() {
		return DepositName;
	}
	public void setDepositName(String depositName) {
		DepositName = depositName;
	}
	public String getAdminBankAccount() {
		return adminBankAccount;
	}
	public void setAdminBankAccount(String adminBankAccount) {
		this.adminBankAccount = adminBankAccount;
	}
	public String getStatus_for_admin() {
		return status_for_admin;
	}
	public void setStatus_for_admin(String status_for_admin) {
		this.status_for_admin = status_for_admin;
	}
	public int getProduct_total_count() {
		return product_total_count;
	}
	public void setProduct_total_count(int product_total_count) {
		this.product_total_count = product_total_count;
	}
	public String getProduct_t_img() {
		return product_t_img;
	}
	public void setProduct_t_img(String product_t_img) {
		this.product_t_img = product_t_img;
	}
	private String order_detail_statuse;
	
	public int getUser_order_idx() {
		return user_order_idx;
	}
	public void setUser_order_idx(int user_order_idx) {
		this.user_order_idx = user_order_idx;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public Date getOrder_date() {
		return order_date;
	}
	public void setOrder_date(Date order_date) {
		this.order_date = order_date;
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
	public int getOrder_total_price() {
		return order_total_price;
	}
	public void setOrder_total_price(int order_total_price) {
		this.order_total_price = order_total_price;
	}
	public String getOrder_detail_statuse() {
		return order_detail_statuse;
	}
	public void setOrder_detail_statuse(String order_detail_statuse) {
		this.order_detail_statuse = order_detail_statuse;
	}
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	public int getProduct_count() {
		return product_count;
	}
	public void setProduct_count(int product_count) {
		this.product_count = product_count;
	}
	public int getProduct_idx() {
		return product_idx;
	}
	public void setProduct_idx(int product_idx) {
		this.product_idx = product_idx;
	}
	public String getOrder_detail_status() {
		return order_detail_status;
	}
	public void setOrder_detail_status(String order_detail_status) {
		this.order_detail_status = order_detail_status;
	}
	
}
