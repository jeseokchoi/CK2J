package com.itbank.controller;


import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.itbank.model.DeliverAddressDTO;
import com.itbank.model.ForPurchaseDTO;
import com.itbank.model.NonuserOrder_detailDTO;
import com.itbank.model.Nonuser_orderDTO;
import com.itbank.model.UserDTO;
import com.itbank.model.UserOrderDTO;
import com.itbank.model.UserOrderDetailDTO;
import com.itbank.service.CartService;
import com.itbank.service.MailService;
import com.itbank.service.OrderService;
import com.itbank.service.ProductService;
import com.itbank.service.UserService;

@RestController
public class ProductAjaxController {
	
	@Autowired
	private CartService cartService;
	
	@Autowired
	private ProductService productService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private OrderService orderService;
	
	private List<ForPurchaseDTO> list = new ArrayList<ForPurchaseDTO>();
	
	@Autowired
	private MailService mailService;
	
	@PostMapping("/product/toPurchase")
	public int ex01(@RequestBody HashMap<String, ForPurchaseDTO> param, HttpSession session) {
		list.removeAll(list);
		UserDTO user = (UserDTO) session.getAttribute("user");
		if(user != null) {
			System.out.println(user.getUser_id());
			DeliverAddressDTO address = userService.getAddress(user.getUser_id());
			if(address != null) {
				user.setUser_address1(address.getUser_address1());
				user.setUser_address2(address.getUser_address2());
				user.setUser_address3(address.getUser_address3());
			}
			session.setAttribute("user", user);
		}
		
		Iterator<String> keys = param.keySet().iterator();
		while(keys.hasNext()) {
			String key = keys.next();
			list.add(param.get(key));
		}
		
		
		if(list != null) {
			return 1;
		}
		return 0;
	
	}
	
	@GetMapping("/product/purchase")
	public ModelAndView purchasePage(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		list.forEach(e -> {
			String t_img_name = productService.getProduct_t_img_one(e.getItemIdx());
			System.out.println("t_img_name = "+t_img_name);
			e.setProduct_t_img(t_img_name);
		});
		
		mav.addObject("list", list);
		System.out.println("list = "+list);
		UserDTO user = (UserDTO) session.getAttribute("user");
		if(user != null) {
			mav.addObject("email1",user.getUser_email().split("@")[0]);
			mav.addObject("email2",user.getUser_email().split("@")[1]);
		}
		if(list.isEmpty()) {
			mav = new ModelAndView("/errorpage");
			String msg = "남아있는 상품이 없습니다. 메인페이지로 이동합니다.";
			mav.addObject("msg",msg);
			return mav;
		}
		return mav;
	}
	@PostMapping("/product/purchase")
	public ModelAndView purchasePage(@RequestParam HashMap<String, String> param, HttpSession session) {
		Iterator<String> keys = param.keySet().iterator();
		
		while(keys.hasNext()) {
			String key = keys.next();
			if(key.equals("multi")) {
				continue;
			}
			list.removeIf(e -> {
				String s = param.get(key);
				int itemIdx = Integer.parseInt(s.split("_")[0]); 
				String itemOpt = s.split("_")[1];
				if(e.getItemIdx() == itemIdx&& e.getItemOpt().equals(itemOpt)) {
					return true;
				}else {
					return false;
				}
			});
		}
		ModelAndView mav = new ModelAndView("redirect:/product/purchase");
		return mav;
	}
	
	@PostMapping("/product/purchasingUser")
	public ModelAndView purchasing(UserOrderDTO dto, HttpSession session) throws IOException {
		ModelAndView mav = new ModelAndView("/user/user_order_complete");
		UserDTO user = (UserDTO) session.getAttribute("user");
		int row1 = orderService.insertUserOrder(dto);
		list.forEach(e -> {
			UserOrderDetailDTO ddto = new UserOrderDetailDTO();
			HashMap<String, Object> map = new HashMap<String, Object>(); 
			map.put("product_idx", e.getItemIdx());
			map.put("color", e.getItemOpt().split("/")[0]);
			map.put("size", e.getItemOpt().split("/")[1]);
			
			int optIdx = productService.getProductOptOne(map);
			int orderIdx = orderService.getOrderIdx(dto.getUser_id());
			ddto.setProduct_opt_idx(optIdx);
			ddto.setUserOrder_idx(orderIdx);
			ddto.setProduct_price(e.getItemPrice());
			ddto.setProduct_count(e.getItemAmount());
			
			orderService.insertUserOrderDetail(ddto);
			int deleteRow = cartService.deleteBasket(user.getUser_id());
		});
		
		// 3/2 주문 확인창 데이터 받기 위해서 요기 수정했음 !!!!!!!!!!!!!!				
			ArrayList<ForPurchaseDTO> clone = new ArrayList<ForPurchaseDTO>(list);
			int sendMail = mailService.sendMailForUserPurchase(user.getUser_email(), clone);
			System.out.println(list);
			mav.addObject("list", clone);		
			
			list.removeAll(list);
			mav.addObject("dto", dto);
		//------------------------------------		
				
		return mav;
	}
	
	@PostMapping("/product/purchasingNonuser")
	public ModelAndView purchasing(Nonuser_orderDTO dto, HttpSession session) throws IOException {
		ModelAndView mav = new ModelAndView("/nonuser/nonuser_order_complete");
		int row1 = orderService.insertNonuserOrder(dto);
		list.forEach(e -> {
			NonuserOrder_detailDTO ddto = new NonuserOrder_detailDTO();
			HashMap<String, Object> map = new HashMap<String, Object>(); 
			map.put("product_idx", e.getItemIdx());
			map.put("color", e.getItemOpt().split("/")[0]);
			map.put("size", e.getItemOpt().split("/")[1]);
			
			int optIdx = productService.getProductOptOne(map);
			int orderIdx = orderService.getNonuserOrderIdx(dto.getNonuser_pwd());
			ddto.setProduct_opt_idx(optIdx);
			ddto.setNonuser_order_idx(orderIdx);
			ddto.setProduct_price(e.getItemPrice());
			ddto.setProduct_count(e.getItemAmount());
			
			orderService.insertNonuserOrderDetail(ddto);
		});
		session.removeAttribute("cartList");
		
		// 3/2 주문 확인창 데이터 받기 위해서 요기 수정했음 !!!!!!!!!!!!!!		
				ArrayList<ForPurchaseDTO> clone = new ArrayList<ForPurchaseDTO>(list);
				String email = dto.getEmail1() + "@" + dto.getEmail2();
				int orderIdx = orderService.getNonuserOrderIdx(dto.getNonuser_pwd());
				int sendMail = mailService.sendMailForNonuserPurchase(email, clone, dto, orderIdx);
				System.out.println(list);
				System.out.println("----------------");
				System.out.println(clone);
				mav.addObject("list", clone);

				list.removeAll(list);
				mav.addObject("dto", dto);
		//------------------------------------		
		return mav;
	}
	
	@PostMapping("/product/toBasket")
	@SuppressWarnings("unchecked")
	public int toBasket(@RequestBody HashMap<String, ForPurchaseDTO> param, HttpSession session) {
		UserDTO user = (UserDTO) session.getAttribute("user");
		int row = 0;
		if(user != null) {
			row = cartService.insertCart(param, user.getUser_id());
		}else {
			List<ForPurchaseDTO> cartList = new ArrayList<ForPurchaseDTO>();
			Iterator<String> keys = param.keySet().iterator();
			while(keys.hasNext()) {
				String key = keys.next();
				cartList.add(param.get(key));
			}
			
			if(session.getAttribute("cartList") == null) {
				session.setAttribute("cartList", cartList);
			}else {
				List<ForPurchaseDTO> ScartList = (List<ForPurchaseDTO>) session.getAttribute("cartList");
				ScartList.addAll(cartList);
				session.setAttribute("cartList", ScartList);
			}
			row = 1;
		}
		
		return row;
	
	}
	
}
