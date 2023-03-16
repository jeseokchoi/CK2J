package com.itbank.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itbank.model.NonuserOrder_detailDTO;
import com.itbank.model.NonuserOrder_returnDTO;
import com.itbank.model.Nonuser_orderDTO;
import com.itbank.model.Nonuser_orderDetailJoinDTO;
import com.itbank.repository.Nonuser_orderDAO;

@Service
public class Nonuser_orderService {

	@Autowired
	Nonuser_orderDAO dao;

	public List<Nonuser_orderDTO> nonuserLogin(Nonuser_orderDTO dto) {

		return dao.login(dto);

	}

	public List<Nonuser_orderDetailJoinDTO> getList(Nonuser_orderDTO dto) {
//		주문상품 상세

		return dao.getList(dto);
	}

	public Nonuser_orderDetailJoinDTO getList(int nonuserOrder_detail_idx) {

		return dao.selectOneProduct(nonuserOrder_detail_idx);
	}

//	public int getExchange(Nonuser_orderDetailJoinDTO dto) {
//			//	dao.update2(dto);
//		return dao.update(dto);
//	}

	public int getExchange(Nonuser_orderDetailJoinDTO dto) {
		dao.update2(dto);
		return dao.update(dto);
	}

	public int getRefund(NonuserOrder_returnDTO dto) {
		dao.insert1(dto);
		return dao.nonuserRefundUpdate(dto);
	}

	public int orderListDelete(int nonuser_order_idx) {
		return dao.nonuser_order_listDelete(nonuser_order_idx);

	}

	public int getOrderIdx(int nonuserOrder_detail_idx) {
		return dao.selectOrderIdx(nonuserOrder_detail_idx);
	}

	public int updateStatusForAdmin(int idx) {
		return dao.updateStatusForAdmin(idx);
	}

//	public Nonuser_orderDetailJoinDTO getRefund(int product_opt_idx) {
//		
//		
//		return dao.update(product_opt_idx);
//	}

//	public List<Nonuser_orderDTO> getSearchList(HashMap<String, String> param) {
//		return dao.get;
//	}

}
