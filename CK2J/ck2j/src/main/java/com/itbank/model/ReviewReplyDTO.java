package com.itbank.model;

import java.sql.Date;

public class ReviewReplyDTO {
	
	private int product_review_idx;
	private int review_reply_idx;
	private String content;
	private Date writing_date;
	
	
	public int getProduct_review_idx() {
		return product_review_idx;
	}
	public void setProduct_review_idx(int product_review_idx) {
		this.product_review_idx = product_review_idx;
	}
	public int getReview_reply_idx() {
		return review_reply_idx;
	}
	public void setReview_reply_idx(int review_reply_idx) {
		this.review_reply_idx = review_reply_idx;
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
	
	
}
