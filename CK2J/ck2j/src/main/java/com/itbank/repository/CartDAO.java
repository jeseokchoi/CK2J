package com.itbank.repository;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.itbank.model.CartDTO;
import com.itbank.model.ForPurchaseDTO;
import com.itbank.model.Product_optDTO;

@Repository
public interface CartDAO {

	List<CartDTO> selectCartListById(String user_id);

	Product_optDTO selectProductOptOne(int product_opt_idx);

	List<ForPurchaseDTO> selectForPurchaseDTOfromCart(String user_id);

	List<ForPurchaseDTO> deleteCartItem(String itemIdx, String itemColor, String itemSize, String user_id);

	int selectOptIdx(HashMap<String, Object> map);

	int deleteCartItem(HashMap<String, Object> map);

	String select_t_imgByIdx(int itemIdx);

	int deleteBasket(String user_id);

	
}
