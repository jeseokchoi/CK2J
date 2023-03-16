package com.itbank.model;

import java.sql.Date;

public class UserDTO {

	private String user_id;
	private int user_idx;
	private String user_pwd;
	private String user_name;
	private String user_phone;
	private String user_email;
	private String email_check;
	private String user_role;
	private String user_grade;
	private Date user_insertDate;
	private Date user_birth;
	private String user_gender;
	private String user_address1;
	private String user_address2;
	private String user_address3;
	
	//2/27 새봄 추가
	private int cnt;
	private int USER_BIRTH;
	private int age; 
		
	
	public int getCnt() {
			return cnt;
		}
		public void setCnt(int cnt) {
			this.cnt = cnt;
		}
		public int getUSER_BIRTH() {
			return USER_BIRTH;
		}
		public void setUSER_BIRTH(int uSER_BIRTH) {
			USER_BIRTH = uSER_BIRTH;
		}
		public int getAge() {
			return age;
		}
		public void setAge(int age) {
			this.age = age;
		}
	public String getUser_address1() {
		return user_address1;
	}
	public void setUser_address1(String user_address1) {
		this.user_address1 = user_address1;
	}
	public String getUser_address2() {
		return user_address2;
	}
	public void setUser_address2(String user_address2) {
		this.user_address2 = user_address2;
	}
	public String getUser_address3() {
		return user_address3;
	}
	public void setUser_address3(String user_address3) {
		this.user_address3 = user_address3;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public int getUser_idx() {
		return user_idx;
	}
	public void setUser_idx(int user_idx) {
		this.user_idx = user_idx;
	}
	public String getUser_pwd() {
		return user_pwd;
	}
	public void setUser_pwd(String user_pwd) {
		this.user_pwd = user_pwd;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getUser_phone() {
		return user_phone;
	}
	public void setUser_phone(String user_phone) {
		this.user_phone = user_phone;
	}
	public String getUser_email() {
		return user_email;
	}
	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}
	public String getEmail_check() {
		return email_check;
	}
	public void setEmail_check(String email_check) {
		this.email_check = email_check;
	}
	public String getUser_role() {
		return user_role;
	}
	public void setUser_role(String user_role) {
		this.user_role = user_role;
	}
	public String getUser_grade() {
		return user_grade;
	}
	public void setUser_grade(String user_grade) {
		this.user_grade = user_grade;
	}
	public Date getUser_insertDate() {
		return user_insertDate;
	}
	public void setUser_insertDate(Date user_insertDate) {
		this.user_insertDate = user_insertDate;
	}
	public Date getUser_birth() {
		return user_birth;
	}
	public void setUser_birth(Date user_birth) {
		this.user_birth = user_birth;
	}
	public String getUser_gender() {
		return user_gender;
	}
	public void setUser_gender(String user_gender) {
		this.user_gender = user_gender;
	}
	
	
	
}
