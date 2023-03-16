package com.itbank.controller;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.itbank.model.NonuserOrder_detailDTO;
import com.itbank.model.Nonuser_orderDTO;
import com.itbank.model.SalesChartDTO;
import com.itbank.model.UserOrderDTO;
import com.itbank.model.UserOrderDetailDTO;
import com.itbank.service.OrderService;
import com.itbank.service.SalesChartService;

@RestController
@RequestMapping("/admin")
public class AdminAjaxController {
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private SalesChartService salesChartService;

	
	
	@GetMapping("/getTotal_price")
	public String getTotal_price() {
		
		int i = orderService.getTotal_price();
		return i+"";
	}
	
	@GetMapping("order/userOrderDetail/{orderIdx}")
	public List<UserOrderDetailDTO> getUserOrderDetail(@PathVariable("orderIdx") int orderIdx) {
		List<UserOrderDetailDTO> list = orderService.getUserOrderDetailList(orderIdx);
		return list;
	}
	@GetMapping("order/nonuserOrderDetail/{orderIdx}")
	public List<NonuserOrder_detailDTO> getNonuserOrderDetail(@PathVariable("orderIdx") int orderIdx) {
		List<NonuserOrder_detailDTO> list = orderService.getNonuserOrderDetailList(orderIdx);
		return list;
	}
	@PostMapping("/userOrderDetail")
	public int updateUserOrderDetail(@RequestBody UserOrderDTO dto) {
		int row = orderService.updateUserOrderDetail(dto);
		return row;
	}
	@PostMapping("/nonuserOrderDetail")
	public int updateUserOrderDetail(@RequestBody Nonuser_orderDTO dto) {
		int row = orderService.updateNonuserOrderDetail(dto);
		return row;
	}
	
//	0228 제석
	@PostMapping("/userOrderList")
	public int getStatusModi(@RequestBody UserOrderDTO dto) {
		int row = orderService.statusModi(dto);
		return row;
	}
	@PostMapping("/nonuserOrderList")
	public int getStatusModi(@RequestBody Nonuser_orderDTO dto) {
		int row = orderService.statusNonuserModi(dto);
		return row;
	}
	
	@DeleteMapping("/order/userOrderList/{user_order_idx}")
	public int uolDelete(@PathVariable("user_order_idx") int user_order_idx) {
		int row = orderService.uolDelete(user_order_idx);
		return row;
	}
	
	@GetMapping("/getSalesChart/{category}")
	public List<SalesChartDTO> getSales(@PathVariable("category") String category){
		System.out.println(category);
		List<SalesChartDTO> list = salesChartService.getOrderList(category);
		return list;
	}
}
