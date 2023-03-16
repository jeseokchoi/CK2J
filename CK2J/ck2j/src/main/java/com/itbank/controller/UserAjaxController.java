package com.itbank.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.itbank.service.UserService;

@RestController
@RequestMapping("/user")
public class UserAjaxController {
	@Autowired private UserService userService;
	
	@GetMapping("/join/dupCheck/{inputId}")
	public String dupCheck(@PathVariable("inputId") String inputId) {
		System.out.println("왔음");
		int row = userService.dupCheck(inputId);
		String msg = row == 1 ? "이미 사용중인 ID입니다" : "사용 가능한 ID입니다";
		System.out.println(row);
		return msg;
	}
	
	// ===================== 0303 ==========================================================================
	@DeleteMapping("/withdraw/{user_id}")
	public int withdraw(@PathVariable("user_id")String user_id, HttpSession session) {
		int row = userService.withdraw(user_id);
		if(row == 1) {
			session.invalidate();
		}
		
		return row;
	}

}
