package com.itbank.model;

import java.sql.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

//NONUSER_ORDER_IDX    NOT NULL NUMBER       
//ORDER_DATE           NOT NULL DATE         
//ADDRESS1             NOT NULL VARCHAR2(20) 
//ADDRESS2             NOT NULL VARCHAR2(50) 
//ADDRESS3             NOT NULL VARCHAR2(50) 
//ORDER_TOTAL_PRICE    NOT NULL NUMBER       
//RECEIVER_NAME        NOT NULL VARCHAR2(20) 
//RECEIVER_PHONE       NOT NULL VARCHAR2(20) 
//NONUSER_ORDER_STATUS          VARCHAR2(50) 
//NONUSER_PWD          NOT NULL VARCHAR2(20) 

public class Nonuser_orderDTO {
	

	private int nonuser_order_idx;
	private Date order_date;
	private String address1;
	private String address2;
	private String address3;
	
	
	private String product_name;
	private int product_idx;
	private int product_opt_idx;
	private int product_count;
	private int nonuserOrder_detail_idx;
	private String product_size;
	private String product_color;
	private String product_price;
	
	private int order_total_price;
	private String receiver_name;
	private String receiver_phone;
	private String nonuser_order_status;
	private String order_detail_status;
	private String nonuser_pwd;
	private List<MultipartFile> upload_t_file;
	private List<MultipartFile> upload_d_file;
	private List<String> product_t_img;
	private List<String> product_d_img;
	
	private int product_total_count;
	private String status_for_admin;
	private String DepositName;
	private String adminBankAccount;
	private String email1;
	private String email2;
	
	
	public String getOrder_detail_status() {
		return order_detail_status;
	}
	public void setOrder_detail_status(String order_detail_status) {
		this.order_detail_status = order_detail_status;
	}
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	public int getProduct_idx() {
		return product_idx;
	}
	public void setProduct_idx(int product_idx) {
		this.product_idx = product_idx;
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
	public int getNonuserOrder_detail_idx() {
		return nonuserOrder_detail_idx;
	}
	public void setNonuserOrder_detail_idx(int nonuserOrder_detail_idx) {
		this.nonuserOrder_detail_idx = nonuserOrder_detail_idx;
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
	public int getProduct_total_count() {
		return product_total_count;
	}
	public void setProduct_total_count(int product_total_count) {
		this.product_total_count = product_total_count;
	}
	public String getStatus_for_admin() {
		return status_for_admin;
	}
	public void setStatus_for_admin(String status_for_admin) {
		this.status_for_admin = status_for_admin;
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
	public String getNonuser_order_status() {
		return nonuser_order_status;
	}
	public void setNonuser_order_status(String nonuser_order_status) {
		this.nonuser_order_status = nonuser_order_status;
	}
	
	
	public String getNonuser_pwd() {
		return nonuser_pwd;
	}
	public void setNonuser_pwd(String nonuser_pwd) {
		this.nonuser_pwd = nonuser_pwd;
	}
	public List<MultipartFile> getUpload_t_file() {
		return upload_t_file;
	}
	public void setUpload_t_file(List<MultipartFile> upload_t_file) {
		this.upload_t_file = upload_t_file;
	}
	public List<MultipartFile> getUpload_d_file() {
		return upload_d_file;
	}
	public void setUpload_d_file(List<MultipartFile> upload_d_file) {
		this.upload_d_file = upload_d_file;
	}
	public List<String> getProduct_t_img() {
		return product_t_img;
	}
	public void setProduct_t_img(List<String> product_t_img) {
		this.product_t_img = product_t_img;
	}
	public List<String> getProduct_d_img() {
		return product_d_img;
	}
	public void setProduct_d_img(List<String> product_d_img) {
		this.product_d_img = product_d_img;
	}
	
	
	
	
	

}
