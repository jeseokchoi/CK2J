package com.itbank.model;

import java.sql.Date;

//	QNA_IDX       NOT NULL NUMBER         
//	USER_ID       NOT NULL VARCHAR2(30)   
//	QNA_PASSWORD           VARCHAR2(100)  
//	QNA_TITLE     NOT NULL VARCHAR2(300)  
//	QNA_CONTENT   NOT NULL VARCHAR2(4000) 
//	QNA_WRITEDATE NOT NULL DATE           
//	QNA_SECRET    NOT NULL VARCHAR2(10) 

public class QnaDTO {
	
	private int qna_idx;
	private String user_id;
	private String qna_password;
	private String qna_title;
	private String qna_content;
	private Date qna_writeDate;
	private String qna_secret;

	private int reply_check;
	
	
	public int getQna_idx() {
		return qna_idx;
	}
	public void setQna_idx(int qna_idx) {
		this.qna_idx = qna_idx;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getQna_password() {
		return qna_password;
	}
	public void setQna_password(String qna_password) {
		this.qna_password = qna_password;
	}
	public String getQna_title() {
		return qna_title;
	}
	public void setQna_title(String qna_title) {
		this.qna_title = qna_title;
	}
	public String getQna_content() {
		return qna_content;
	}
	public void setQna_content(String qna_content) {
		this.qna_content = qna_content;
	}
	public Date getQna_writeDate() {
		return qna_writeDate;
	}
	public void setQna_writeDate(Date qna_writeDate) {
		this.qna_writeDate = qna_writeDate;
	}
	public String getQna_secret() {
		return qna_secret;
	}
	public void setQna_secret(String qna_secret) {
		this.qna_secret = qna_secret;
	}
	public int getReply_check() {
		return reply_check;
	}
	public void setReply_check(int reply_check) {
		this.reply_check = reply_check;
	}

	
}
