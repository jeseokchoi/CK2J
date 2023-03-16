package com.itbank.model;

import java.sql.Date;

//	QNA_REPLY_IDX NOT NULL NUMBER         
//	QNA_IDX       NOT NULL NUMBER         
//	CONTENT       NOT NULL VARCHAR2(3000) 
//	WRITING_DATE  NOT NULL DATE  

public class QnaReplyDTO {
	
	private int qna_reply_idx;
	private int qna_idx;
	private String content;
	private Date writing_date;
	
	private int reply_check;

	
	public int getQna_reply_idx() {
		return qna_reply_idx;
	}
	public void setQna_reply_idx(int qna_reply_idx) {
		this.qna_reply_idx = qna_reply_idx;
	}
	public int getQna_idx() {
		return qna_idx;
	}
	public void setQna_idx(int qna_idx) {
		this.qna_idx = qna_idx;
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
	public int getReply_check() {
		return reply_check;
	}
	public void setReply_check(int reply_check) {
		this.reply_check = reply_check;
	}
	
	

}
