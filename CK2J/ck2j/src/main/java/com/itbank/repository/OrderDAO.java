package com.itbank.repository;

import java.util.HashMap;
import java.util.List;

import com.itbank.model.NonuserOrder_detailDTO;
import com.itbank.model.NonuserOrder_returnDTO;
import com.itbank.model.Nonuser_orderDTO;
import com.itbank.model.UserOrderDTO;
import com.itbank.model.UserOrderDetailDTO;
import com.itbank.model.UserOrder_returnDTO;

public interface OrderDAO {

	List<UserOrderDTO> selectUserOrderList();

	int selectUserOrderTotal_price();

	List<UserOrderDetailDTO> selectUserOrderDetailList(int orderIdx);

	int insertUserOrder(UserOrderDTO dto);

	int selectOrderIdx(String user_id);

	int insertUserOrderDetail(UserOrderDetailDTO ddto);

	int insertNonuserOrder(Nonuser_orderDTO dto);

	int selectNonuserOrderIdx(String nonuser_pwd);

	int insertNonuserOrderDetail(NonuserOrder_detailDTO ddto);
	
	int updateStatusModify(HashMap<String, Object> map);

	int updateOrderdetailAll(HashMap<String, Object> map);

	int uolDelete(int user_order_idx);

	List<Nonuser_orderDTO> selectNonuserOrderList();

	int updateUserOrderDetail(UserOrderDTO dto);

	List<NonuserOrder_detailDTO> selectNonuserOrderDetailList(int orderIdx);

	int updateNonuserOrderdetailAll(HashMap<String, Object> map);

	int updateNonuserStatusModify(HashMap<String, Object> map);

	int updateNonuserOrderDetail(Nonuser_orderDTO dto);

	List<UserOrder_returnDTO> selectUserReturnList();

	List<NonuserOrder_returnDTO> selectNonuserReturnList();
}
