package com.itbank.model;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

//*NonuserOder_detail 테이블 ▽

//NONUSERORDER_DETAIL_IDX NOT NULL NUMBER 
//PRODUCT_OPT_IDX         NOT NULL NUMBER 
//NONUSER_ORDER_IDX       NOT NULL NUMBER 
//PRODUCT_COUNT           NOT NULL NUMBER 
//PRODUCT_PRICE           NOT NULL NUMBER 

//* product_opt 테이블에서 값 추출▽

//PRODUCT_SIZE    NOT NULL VARCHAR2(50)  
//PRODUCT_COLOR   NOT NULL VARCHAR2(100) 

public class NonuserOrder_detailDTO {
	
	private int nonuserOrder_detail_idx;
	private int product_opt_idx;
	private String product_name;
	private String product_opt;
	private int nonuser_order_idx;
	private int product_count;
	private int	product_price;
	private String order_detail_status;
	
	private String product_size;
	private String product_color;
	
	private MultipartFile upload_t_file;
	private String product_t_img;
	
	
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	public String getProduct_opt() {
		return product_opt;
	}
	public void setProduct_opt(String product_opt) {
		this.product_opt = product_opt;
	}
	public String getOrder_detail_status() {
		return order_detail_status;
	}
	public void setOrder_detail_status(String order_detail_status) {
		this.order_detail_status = order_detail_status;
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
	public int getNonuser_order_idx() {
		return nonuser_order_idx;
	}
	public void setNonuser_order_idx(int nonuser_order_idx) {
		this.nonuser_order_idx = nonuser_order_idx;
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
	public MultipartFile getUpload_t_file() {
		return upload_t_file;
	}
	public void setUpload_t_file(MultipartFile upload_t_file) {
		this.upload_t_file = upload_t_file;
	}
	public String getProduct_t_img() {
		return product_t_img;
	}
	public void setProduct_t_img(String product_t_img) {
		this.product_t_img = product_t_img;
	}
	
	
	
	
	
	
	
	
	

}
