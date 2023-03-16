package com.itbank.controller;


import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.itbank.model.NonuserOrder_detailDTO;
import com.itbank.model.NonuserOrder_returnDTO;
import com.itbank.model.Nonuser_orderDTO;
import com.itbank.model.Nonuser_orderDetailJoinDTO;

import com.itbank.service.Nonuser_orderService;
import com.zaxxer.hikari.util.SuspendResumeLock;

@Controller
@RequestMapping("/nonuser")
public class NonuserController {

	@Autowired Nonuser_orderService nonuser_OrderService;
	
	@GetMapping("/orderList")
	@SuppressWarnings("unchecked")
	public ModelAndView Check(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		
		// 비회원 로그인 정보를 불러와서 없으면 로그인으로 리다이렉트 하는 코드 (시작)
		Nonuser_orderDTO nonuserLoginDTO = (Nonuser_orderDTO) session.getAttribute("nonuserLoginDTO");
		List<Nonuser_orderDTO> nonuserCheck = (List<Nonuser_orderDTO>) session.getAttribute("nonuserLogin");
		
		System.out.println("===로그인 결과===");
		System.out.println(nonuserLoginDTO);
		System.out.println(nonuserCheck);
		

		if(nonuserLoginDTO == null) {
			mav.setViewName("redirect:/nonuser/login");
			return mav;
		}
		
		
		System.out.println("nonuserLoginDTO=" + nonuserLoginDTO.getNonuser_order_idx());
		List<Nonuser_orderDetailJoinDTO> list = nonuser_OrderService.getList(nonuserLoginDTO);
		
		System.out.println("list="+list);
		
		
		mav.addObject("list", list);
		
		return mav;
		
	}
	
	@GetMapping("/login")
	public void login() {}
	
	@PostMapping("/login")
	public ModelAndView login (Nonuser_orderDTO dto, HttpSession session) throws BindException{
		ModelAndView mav = new ModelAndView("redirect:/nonuser/orderList");
		List<Nonuser_orderDTO> nonuserLogin = nonuser_OrderService.nonuserLogin(dto);
		
		System.out.println(dto);
		session.setAttribute("nonuserLogin", nonuserLogin);
		session.setAttribute("nonuserLoginDTO", dto); //3가지 값만 있고
		
		if(nonuserLogin.size() == 0) {
			mav.setViewName("/errorpage_nonuser");
			String msg = "일치하는 주문번호와 성명 ,비밀번호가 존재하지 않습니다.";
			mav.addObject("msg",msg);
			return mav;
		}
		
		return mav;
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
	
	@ExceptionHandler(BindException.class)
	public ModelAndView bindException(BindException e) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/errorpage_nonuser");
		String msg = "일치하는 주문번호와 성명 ,비밀번호가 존재하지 않습니다.";
		mav.addObject("msg",msg);
		return mav;
	}

	// 교환/환불 버튼을 누르면 그 한개 제품만 데이터를 넘겨 받아서 띄워줌. 
	@GetMapping("/nonuser_return/{product_opt_idx}/{product_idx}/{nonuserOrder_detail_idx}")
	public ModelAndView nonuser_return(@PathVariable("product_opt_idx")int product_opt_idx,@PathVariable("product_idx")int product_idx ,@PathVariable("nonuserOrder_detail_idx") int nonuserOrder_detail_idx) {
	
		ModelAndView mav = new ModelAndView("/nonuser/nonuser_return");
		
		Nonuser_orderDetailJoinDTO list = nonuser_OrderService.getList(nonuserOrder_detail_idx); // 원래는  product_opt_idx 받았었음.
		//
		
		mav.addObject("list", list);
		
		System.out.println("-----------------------1아래 product_idx-----");
		System.out.println(list.getProduct_idx());
		System.out.println("----------1아래 product_opt_idx------------------");
		System.out.println(list.getProduct_opt_idx());
		System.out.println("----------1아래 NonuserOrder_detail_idx------------------");
		System.out.println(list.getNonuserOrder_detail_idx());
		System.out.println("----------1제품 선택해서 불러오기 끝------------------");
		return mav;
	}
	
	// 사이즈, 컬러 교환을 하고 나면 , 그 값을 데이터에서 수정해서 띄워줌. 제품의 옵션 idx 로 값을 구문.
	@PostMapping("/exchange/{product_opt_idx}/{product_idx}/{nonuserOrder_detail_idx}") 
	public ModelAndView exchange(@PathVariable("product_opt_idx")int product_opt_idx ,@PathVariable("product_idx")int product_idx,@PathVariable("nonuserOrder_detail_idx") int nonuserOrder_detail_idx, Nonuser_orderDetailJoinDTO dto) {
		ModelAndView mav = new ModelAndView("redirect:/nonuser/orderList");
		int row = nonuser_OrderService.getExchange(dto);
		mav.addObject("msg", "modify:" + (row != 0 ? "성공" : "실패"));
		if(row != 0) {
			int idx = nonuser_OrderService.getOrderIdx(nonuserOrder_detail_idx);
			int row2 = nonuser_OrderService.updateStatusForAdmin(idx);
		}
		return mav;
	}
	
	
	
	
	@PostMapping("/refund/{product_opt_idx}/{product_idx}/{nonuserOrder_detail_idx}")
	public ModelAndView refund(NonuserOrder_returnDTO dto) {
		ModelAndView mav = new ModelAndView("redirect:/nonuser/orderList");
		int row = nonuser_OrderService.getRefund(dto);
		mav.addObject("msg", "modify:" + (row != 0 ? "성공" : "실패"));
		if(row != 0) {
			int idx = nonuser_OrderService.getOrderIdx(dto.getNonuserOrder_detail_idx());
			int row2 = nonuser_OrderService.updateStatusForAdmin(idx);
		}
		return mav;
	}
	
	// 주문건 전체 삭제 
	
	@GetMapping("/orderListDelete/{nonuser_order_idx}")
	public String delete(@PathVariable("nonuser_order_idx")int nonuser_order_idx) {
		int row = nonuser_OrderService.orderListDelete(nonuser_order_idx);
		System.out.println(row != 0 ? "삭제성공":"삭제실패");
		return "redirect:/nonuser/orderList";
	}
	
		
}
