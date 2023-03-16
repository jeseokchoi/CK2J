package com.itbank.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.itbank.model.NonuserOrder_returnDTO;
import com.itbank.model.Nonuser_orderDTO;
import com.itbank.model.UserOrderDTO;
import com.itbank.model.UserOrder_returnDTO;
import com.itbank.service.OrderService;

@Controller
@RequestMapping("/admin/order")
public class AdminOrderController {

	@Autowired
	private OrderService orderService;
	
	
	@GetMapping("userOrderList")
	public ModelAndView getList() {
		ModelAndView mav = new ModelAndView();
		List<UserOrderDTO> list = orderService.getUserOrderList();
		mav.addObject("list",list);
		return mav;
	}
	@GetMapping("nonuserOrderList")
	public ModelAndView getNonuserOrderList() {
		ModelAndView mav = new ModelAndView();
		List<Nonuser_orderDTO> list = orderService.getNonuserOrderList();
		mav.addObject("list",list);
		return mav;
	}
	
	
	@GetMapping("returnList")
	public ModelAndView getReturnList() {
		ModelAndView mav = new ModelAndView();
		List<UserOrder_returnDTO> userReturnList = orderService.getUserReturnList();
		List<NonuserOrder_returnDTO> nonuserReturnList = orderService.getNonuserReturnList();
		mav.addObject("userReturnList", userReturnList);
		mav.addObject("nonuserReturnList", nonuserReturnList);
		return mav;
	}
	

}
