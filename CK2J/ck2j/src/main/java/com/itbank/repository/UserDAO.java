package com.itbank.repository;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.itbank.component.Paging;
import com.itbank.model.DeliverAddressDTO;
import com.itbank.model.UserDTO;
import com.itbank.model.UserOrderDTO;
import com.itbank.model.UserOrder_returnDTO;

@Repository
public interface UserDAO {

	UserDTO login(UserDTO dto);

	int insert(UserDTO dto);

	int idDupCheck(String inputId);

	List<DeliverAddressDTO> selectList(String user_id);

	int insertAddress(DeliverAddressDTO dto);

	DeliverAddressDTO addressOne(String userId);

	UserDTO selectOne(String userId);

	int updateUser(UserDTO dto);

	int getCount();

	List<UserDTO> selectAll(Paging paging);

	int addressModify(DeliverAddressDTO dto);

	List<UserOrderDTO> getOrderList(String user_id);
	
	List<UserDTO> selectSearchUserList(HashMap<String, String> param);

	int getCount2(HashMap<String, String> param);
	
	UserDTO find_id(UserDTO dto);

	UserDTO find_pwd(UserDTO dto);

	int chanagePwd(HashMap<String, String> param);
	
	
	//2.20 교환 할 상품 하나 선택해서 띄우기 
	UserOrderDTO selectOneProduct(int userOrder_detail_idx);
	
	// 교환
	int userUpdate(UserOrderDTO dto);
	
	// 환불1
	int userInsert(UserOrder_returnDTO dto);
	
	// 환불2  '환불진행중' 글자업데이트 
	int userRefundUpdate(UserOrder_returnDTO dto);
	
	// 배송 전 주문 전체 취소
	int user_order_listDelete(int user_order_idx);


	// 2/26추가  교환  하면 refund 테이블에 상태 추가되는 구문!!!!!!!!!
	int userUpdate2(UserOrderDTO dto);

	int deleteUser(String user_id);

	int selectOrderIdx(int userOrder_detail_idx);

	int updateStatusForAdmin(int idx);
	

}
