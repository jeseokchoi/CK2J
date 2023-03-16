package com.itbank.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itbank.model.NonuserOrder_detailDTO;
import com.itbank.model.NonuserOrder_returnDTO;
import com.itbank.model.Nonuser_orderDTO;
import com.itbank.model.UserOrderDTO;
import com.itbank.model.UserOrderDetailDTO;
import com.itbank.model.UserOrder_returnDTO;
import com.itbank.repository.OrderDAO;

@Service
public class OrderService {

	@Autowired
	private OrderDAO dao;
	
	public List<UserOrderDTO> getUserOrderList() {
		return dao.selectUserOrderList();
	}

	public List<UserOrderDetailDTO> getUserOrderDetailList(int orderIdx) {
		return dao.selectUserOrderDetailList(orderIdx);
	}
	
	public int getTotal_price() {
		return dao.selectUserOrderTotal_price();
	}

	public int insertUserOrder(UserOrderDTO dto) {
		return dao.insertUserOrder(dto);
	}

	public int getOrderIdx(String user_id) {
		return dao.selectOrderIdx(user_id);
	}

	public int insertUserOrderDetail(UserOrderDetailDTO ddto) {
		return dao.insertUserOrderDetail(ddto);
	}

	public int insertNonuserOrder(Nonuser_orderDTO dto) {
		return dao.insertNonuserOrder(dto);
	}

	public int getNonuserOrderIdx(String nonuser_pwd) {
		return dao.selectNonuserOrderIdx(nonuser_pwd);
	}

	public int insertNonuserOrderDetail(NonuserOrder_detailDTO ddto) {
		return dao.insertNonuserOrderDetail(ddto);
		
	}

	public int statusModi(UserOrderDTO dto) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("user_order_idx", dto.getUser_order_idx());
		map.put("status_for_admin", dto.getStatus_for_admin());
		int row = dao.updateOrderdetailAll(map);
		
		return dao.updateStatusModify(map);
	}

	public int uolDelete(int user_order_idx) {
		return dao.uolDelete(user_order_idx);
	}

	public List<Nonuser_orderDTO> getNonuserOrderList() {
		return dao.selectNonuserOrderList();
	}

	public int updateUserOrderDetail(UserOrderDTO dto) {
		return dao.updateUserOrderDetail(dto);
	}

	public List<NonuserOrder_detailDTO> getNonuserOrderDetailList(int orderIdx) {
		return dao.selectNonuserOrderDetailList(orderIdx);
	}

	public int statusNonuserModi(Nonuser_orderDTO dto) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("nonuser_order_idx", dto.getNonuser_order_idx());
		map.put("status_for_admin", dto.getStatus_for_admin());
		int row = dao.updateNonuserOrderdetailAll(map);
		
		return dao.updateNonuserStatusModify(map);
	}

	public int updateNonuserOrderDetail(Nonuser_orderDTO dto) {
		return dao.updateNonuserOrderDetail(dto);
	}

	public List<UserOrder_returnDTO> getUserReturnList() {
		return dao.selectUserReturnList();
	}

	public List<NonuserOrder_returnDTO> getNonuserReturnList() {
		return dao.selectNonuserReturnList();
	}

}
