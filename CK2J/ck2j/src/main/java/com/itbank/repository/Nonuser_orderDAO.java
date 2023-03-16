package com.itbank.repository;

import java.util.List;

import com.itbank.model.NonuserOrder_detailDTO;
import com.itbank.model.NonuserOrder_returnDTO;
import com.itbank.model.Nonuser_orderDTO;
import com.itbank.model.Nonuser_orderDetailJoinDTO;

public interface Nonuser_orderDAO {

	List<Nonuser_orderDTO> login(Nonuser_orderDTO dto);

	List<Nonuser_orderDetailJoinDTO> getList(Nonuser_orderDTO dto);

	// Nonuser_orderDetailJoinDTO refund(int product_opt_idx);

	Nonuser_orderDetailJoinDTO selectOneProduct(int product_opt_idx);

	int update(Nonuser_orderDetailJoinDTO dto);

	int insert1(NonuserOrder_returnDTO dto);

	int nonuserRefundUpdate(NonuserOrder_returnDTO dto);

//	int delete1(Nonuser_orderDetailJoinDTO dto);
//
//	int delete2(Nonuser_orderDetailJoinDTO dto);

	int nonuser_order_listDelete(int nonuser_order_idx);

	//int insert2(NonuserOrder_returnDTO dto);

	int update2(Nonuser_orderDetailJoinDTO dto);

	int selectOrderIdx(int nonuserOrder_detail_idx);

	int updateStatusForAdmin(int idx);

	//int update2(Nonuser_orderDetailJoinDTO dto);

//	Nonuser_orderDetailJoinDTO update2(Nonuser_orderDetailJoinDTO dto);

//	List<Nonuser_orderDetailJoinDTO> refund(int product_opt_idx);

}
