package com.itbank.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.itbank.model.ForPurchaseDTO;
import com.itbank.model.UserDTO;
import com.itbank.service.CartService;
import com.itbank.service.ProductService;

@Controller
@RequestMapping("/product")
public class CartController {
	
	@Autowired
	private CartService cartService;
	@Autowired
	private ProductService productService;
	private List<ForPurchaseDTO> fpList = new ArrayList<ForPurchaseDTO>();
	
	@GetMapping("/cart")
	@SuppressWarnings("unchecked")
	public ModelAndView cartList(HttpSession session) {
		ModelAndView mav = new ModelAndView("/product/cart");
		List<ForPurchaseDTO> list = (List<ForPurchaseDTO>) session.getAttribute("cartList");
		list.forEach(e -> {
			e.setProduct_t_img(cartService.get_t_imgByIdx(e.getItemIdx()));
		});
		mav.addObject("list", list);
		return mav;
	}
	
	// 카트 비회원 처음 	
	@ExceptionHandler(NullPointerException.class)
	public ModelAndView NullPointerException(NullPointerException e, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/errorpage_nonuserCart");
		String msg = "장바구니에 상품이 없습니다.";
		mav.addObject("msg",msg);
		return mav;
	}
	
	
	@GetMapping("/cart/{user_id}")
	public ModelAndView cartList(@PathVariable("user_id") String user_id) {
		ModelAndView mav = new ModelAndView("/product/cart");
		List<ForPurchaseDTO> list = cartService.getForPurchaseDTOfromCart(user_id);
		fpList = list;
		mav.addObject("list", list);
		return mav;
	}
	@GetMapping("/cart/delete")
	@SuppressWarnings("unchecked")
	public ModelAndView deleteFromCart(String value, HttpSession session) {
		UserDTO user = (UserDTO) session.getAttribute("user");
		if(user != null) {
			ModelAndView mav = new ModelAndView("redirect:/product/cart/"+user.getUser_id());
			int product_opt_idx = cartService.getOptIdx(value);
			int row = cartService.deleteCartItem(product_opt_idx,user.getUser_id());
			mav.addObject("list", fpList);
			return mav;
		}else {
			List<ForPurchaseDTO> cartList = (List<ForPurchaseDTO>) session.getAttribute("cartList");
			cartList.removeIf(e -> {
				if(e.getItemIdx() == Integer.parseInt(value.split("_")[0]) && e.getItemOpt().equals(value.split("_")[1])) {
					return true;
				}else {
					return false;
				}
			});
			session.setAttribute("cartList", cartList);
			ModelAndView mav = new ModelAndView("redirect:/product/cart");
			return mav;
		}
	}
	
	@PostMapping("/cart/{user_id}")
	public ModelAndView cartToPurchase() {
		ModelAndView mav = new ModelAndView("/");
		System.out.println();
		return mav;
	}
}
