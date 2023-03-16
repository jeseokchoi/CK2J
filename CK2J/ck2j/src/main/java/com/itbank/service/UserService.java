package com.itbank.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itbank.component.Paging;
import com.itbank.model.DeliverAddressDTO;
import com.itbank.model.UserDTO;
import com.itbank.model.UserOrderDTO;
import com.itbank.model.UserOrder_returnDTO;
import com.itbank.repository.UserDAO;

@Service
public class UserService {
	
	@Autowired private UserDAO dao;

	public UserDTO login(UserDTO dto) {
		
		return dao.login(dto);
	}

	public int join(UserDTO dto) {
		return dao.insert(dto);
	}

	public int dupCheck(String inputId) {
		
		return dao.idDupCheck(inputId);
	}

	public List<DeliverAddressDTO> getList(String user_id) {
		return dao.selectList(user_id);
	}

	public int addressRegist(DeliverAddressDTO dto) {
	
		return dao.insertAddress(dto);
	}

	public DeliverAddressDTO getAddress(String userId) {
		
		return dao.addressOne(userId);
	}

	public UserDTO getOne(String userId) {
		
		return dao.selectOne(userId);
	}

	public int modify(UserDTO dto) {
	
		return dao.updateUser(dto);
	}


	public int getCount() {
		
		return dao.getCount();
	}

	public List<UserDTO> getUserList(Paging paging) {
		
		return dao.selectAll(paging);
	}

	public int addressModify(DeliverAddressDTO dto) {
		
		return dao.addressModify(dto);
	}

	public List<UserOrderDTO> getOrderList(String user_id) {
		
		return dao.getOrderList(user_id);
	}

	public List<UserDTO> getUserSearchList(HashMap<String, String> param, Paging paging) {
		param.put("offset",""+paging.getOffset());
		param.put("perPage",""+paging.getPerPage());
		return dao.selectSearchUserList(param);
	}

	public int getCount2(HashMap<String, String> param) {
		return dao.getCount2(param);
	}
	
	public UserDTO findId(UserDTO dto) {
		return dao.find_id(dto);
	}

	public UserDTO findPwd(UserDTO dto) {
		return dao.find_pwd(dto);
	}

	public int changePwd(String user_id, String user_pwd) {
		HashMap<String,String> param = new HashMap<String, String>();
		param.put("user_id",user_id);
		param.put("user_pwd",user_pwd);
		return dao.chanagePwd(param);
	}
	
	
	
	
	
	public UserOrderDTO returnGetList(int userOrder_detail_idx) {
		
		return dao.selectOneProduct(userOrder_detail_idx);
	}

	public int getUserExchange(UserOrderDTO dto) {
		dao.userUpdate2(dto);
		return dao.userUpdate(dto);
	}

	public int getUserRefund(UserOrder_returnDTO dto) {
		
		 		dao.userInsert(dto);
		 return dao.userRefundUpdate(dto);
	}

	public int userOrderListDelete(int user_order_idx) {
		return dao.user_order_listDelete(user_order_idx);
	}

	public int withdraw(String user_id) {
		return dao.deleteUser(user_id);
	}

	public int getOrderIdx(int userOrder_detail_idx) {
		return dao.selectOrderIdx(userOrder_detail_idx);
	}

	public int updateStatusForAdmin(int idx) {
		return dao.updateStatusForAdmin(idx);
	}
}
	


