package com.itbank.model;

//NONUSERORDER_RETURN_IDX NOT NULL NUMBER         
//NONUSERORDER_DETAIL_IDX NOT NULL NUMBER         
//RETURNTYPE              NOT NULL VARCHAR2(20)   
//RETURN_REASON           NOT NULL VARCHAR2(3000) 
//REASON_IMG              NOT NULL VARCHAR2(300)  
//BANKNAME                         VARCHAR2(30)   
//BANKACCOUNTNAME                  VARCHAR2(20)   
//BANKACCOUNTNUMBER                NUMBER         
//ORDER_RETURN_STATUS              VARCHAR2(50)   

// 교환 환불 이미지 첨부 안하기로함.


public class NonuserOrder_returnDTO {
	
	private int nonuserOrder_refund_idx;
	private int nonuserOrder_detail_idx;
	private String returnType;
	private String return_reason;
	private String reason_img;
	private String bankName;
	private String bankAccountName;
	private int bankAccountNumber;	
	private String order_return_status;
	
	
	
	
	
	
	public int getNonuserOrder_refund_idx() {
		return nonuserOrder_refund_idx;
	}
	public void setNonuserOrder_refund_idx(int nonuserOrder_refund_idx) {
		this.nonuserOrder_refund_idx = nonuserOrder_refund_idx;
	}
	public int getNonuserOrder_detail_idx() {
		return nonuserOrder_detail_idx;
	}
	public void setNonuserOrder_detail_idx(int nonuserOrder_detail_idx) {
		this.nonuserOrder_detail_idx = nonuserOrder_detail_idx;
	}
	
	public String getReturnType() {
		return returnType;
	}
	public void setReturnType(String returnType) {
		this.returnType = returnType;
	}
	public String getReturn_reason() {
		return return_reason;
	}
	public void setReturn_reason(String return_reason) {
		this.return_reason = return_reason;
	}
	public String getReason_img() {
		return reason_img;
	}
	public void setReason_img(String reason_img) {
		this.reason_img = reason_img;
	}

	public String getBankName() {
		return bankName;
	}
	public void setBankName(String bankName) {
		this.bankName = bankName;
	}
	public String getBankAccountName() {
		return bankAccountName;
	}
	public void setBankAccountName(String bankAccountName) {
		this.bankAccountName = bankAccountName;
	}
	public int getBankAccountNumber() {
		return bankAccountNumber;
	}
	public void setBankAccountNumber(int bankAccountNumber) {
		this.bankAccountNumber = bankAccountNumber;
	}
	public String getOrder_return_status() {
		return order_return_status;
	}
	public void setOrder_return_status(String order_return_status) {
		this.order_return_status = order_return_status;
	}
	
	
	
	

}
