package com.itbank.model;

import java.sql.Date;

public class ReviewDTO {
	private int product_review_idx;
	private int product_opt_idx;
	private String user_id;
	private double rate;
	private String content;
	private Date writing_date;
	private String delete_check;
	private int product_idx;
	private String product_color;
	private String product_size;
//=============================================0226=================================================
	
	private int review_reply_idx;
	private String reply_content;
	private Date reply_writing_date;
	
	
	
	public int getProduct_review_idx() {
		return product_review_idx;
	}
	public void setProduct_review_idx(int product_review_idx) {
		this.product_review_idx = product_review_idx;
	}
	public int getProduct_opt_idx() {
		return product_opt_idx;
	}
	public void setProduct_opt_idx(int product_opt_idx) {
		this.product_opt_idx = product_opt_idx;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public double getRate() {
		return rate;
	}
	public void setRate(double rate) {
		this.rate = rate;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getWriting_date() {
		return writing_date;
	}
	public void setWriting_date(Date writing_date) {
		this.writing_date = writing_date;
	}

	public String getDelete_check() {
		return delete_check;
	}
	public void setDelete_check(String delete_check) {
		this.delete_check = delete_check;
	}
	public int getProduct_idx() {
		return product_idx;
	}
	public void setProduct_idx(int product_idx) {
		this.product_idx = product_idx;
	}
	public String getProduct_color() {
		return product_color;
	}
	public void setProduct_color(String product_color) {
		this.product_color = product_color;
	}
	public String getProduct_size() {
		return product_size;
	}
	public void setProduct_size(String product_size) {
		this.product_size = product_size;
	}
	
//=======================================0226=================================================
	
	public int getReview_reply_idx() {
		return review_reply_idx;
	}
	public void setReview_reply_idx(int review_reply_idx) {
		this.review_reply_idx = review_reply_idx;
	}
	public String getReply_content() {
		return reply_content;
	}
	public void setReply_content(String reply_content) {
		this.reply_content = reply_content;
	}
	public Date getReply_writing_date() {
		return reply_writing_date;
	}
	public void setReply_writing_date(Date reply_writing_date) {
		this.reply_writing_date = reply_writing_date;
	}
	
	
	
	
	

}
