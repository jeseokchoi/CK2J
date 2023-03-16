package com.itbank.service;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itbank.model.CartDTO;
import com.itbank.model.ForPurchaseDTO;
import com.itbank.model.Product_optDTO;
import com.itbank.model.UserDTO;
import com.itbank.model.UserOrderDTO;
import com.itbank.repository.CartDAO;
import com.itbank.repository.ProductDAO;

@Service
public class CartService {

	@Autowired
	private CartDAO dao;
	
	@Autowired
	private ProductDAO productDAO;
	
	public List<CartDTO> getListById(String user_id) {
		return dao.selectCartListById(user_id);
	}

	public int insertCart(HashMap<String, ForPurchaseDTO> param, String cart_value) {
		int row= 0;
		Iterator<String> keys = param.keySet().iterator();
		while(keys.hasNext()) {
			String key = keys.next();
			int product_idx = param.get(key).getItemIdx();
			String color = param.get(key).getItemOpt().split("/")[0];
			String size = param.get(key).getItemOpt().split("/")[1];
			HashMap<String, Object> getProductIdxMap = new HashMap<String, Object>();
			getProductIdxMap.put("product_idx", product_idx);
			getProductIdxMap.put("color", color);
			getProductIdxMap.put("size", size);
			
			int productOptIdx = productDAO.selectOneProductOpt(getProductIdxMap);
			HashMap<String, Object> map = new HashMap<String, Object>();
			
			map.put("product_opt_idx", productOptIdx);
			map.put("cart_value", cart_value);
			map.put("product_count", param.get(key).getItemAmount());
			row += productDAO.insertCart(map);
		}
		
		return row;
	}

	public List<ForPurchaseDTO> getForPurchaseDTOfromCart(String user_id) {
		return dao.selectForPurchaseDTOfromCart(user_id);
	}

	public int deleteCartItem(int product_opt_idx, String user_id) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("product_opt_idx", product_opt_idx);
		map.put("cart_value", user_id);
		return dao.deleteCartItem(map);
	}

	public int getOptIdx(String value) {
		String itemIdx = value.split("_")[0];
		String itemColor = value.split("_")[1].split("/")[0];
		String itemSize = value.split("_")[1].split("/")[1];
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("itemIdx", itemIdx);
		map.put("itemColor", itemColor);
		map.put("itemSize", itemSize);
		return dao.selectOptIdx(map);
	}

	public String get_t_imgByIdx(int itemIdx) {
		return dao.select_t_imgByIdx(itemIdx);
	}

	public int deleteBasket(String user_id) {
		return dao.deleteBasket(user_id);
	}


	
}
