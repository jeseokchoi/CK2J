package com.itbank.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.itbank.component.ProductPaging;
import com.itbank.model.ProductDTO;
import com.itbank.model.ReviewDTO;
import com.itbank.model.UserDTO;
import com.itbank.service.ProductService;
import com.itbank.service.ReviewService;

@Controller
@RequestMapping("/product")
public class ProductController {

	@Autowired
	private ProductService productService;
	
	@Autowired 
	private ReviewService reviewService;
	
	@GetMapping("/productList/{cat}")
	public ModelAndView productList(@PathVariable("cat") String cat, @RequestParam(defaultValue = "1")Integer page, @RequestParam(defaultValue = "0") int sort_method) {
		ModelAndView mav = new ModelAndView("/product/productList");
		int itemCount = productService.getCount(cat);
		System.out.printf("itemcount=%d", itemCount);
		ProductPaging paging = new ProductPaging(page, itemCount);
		List<ProductDTO> list = productService.getList(cat, paging, sort_method);
		
		String s = "";
		if(!cat.equals("m_") && !cat.equals("w_")) {
			s = cat.substring(cat.indexOf("_")+1).toUpperCase();
		}else {
			s = "ALL";
		}
		
		mav.addObject("category",s);
		mav.addObject("cat",cat);
		mav.addObject("list", list);
		mav.addObject("paging", paging);
		mav.addObject("sort_method", sort_method);
		return mav;
	}
	@GetMapping("/view/{idx}")
	public ModelAndView viewItem(@PathVariable("idx") int idx) {
		ModelAndView mav = new ModelAndView("/product/view");
		ProductDTO dto = productService.getDTO(idx);
		List<String> colors = productService.getProductColorOpt(dto.getProduct_idx());
		mav.addObject("dto", dto);
		mav.addObject("colors", colors);
		return mav;
	}
	@GetMapping("/review_write")
	public void reivew_write() {}
	
	@PostMapping("/review_write")
	public ModelAndView review_write(ReviewDTO dto,String product_idx, String product_opt_idx,HttpSession session) {
		ModelAndView mav = new ModelAndView("/errorpage");
		
		System.out.println("dto.getUser_id()="+dto.getUser_id());
		System.out.println("getContent="+dto.getContent());
		System.out.println("product_opt_idx="+product_opt_idx);
		System.out.println("getRate="+dto.getRate());
		
		
		dto.setProduct_opt_idx(Integer.parseInt(product_opt_idx));
		dto.setProduct_idx(Integer.parseInt(product_idx));
		dto.setUser_id(((UserDTO)session.getAttribute("user")).getUser_id());
		int row = reviewService.reviewWrite(dto);
		System.out.println( row == 1? "리뷰작성 성공":"리뷰 작성실패😭");
		if(row != 1) {
			String msg = "리뷰작성에 실패하였습니다.😭";
			mav.addObject("msg",msg);
			return mav;
		}
		
		String msg = "리뷰가 정상적으로 등록 되었습니다. 감사합니다.😍";
		String url = "/user/userOrder";
		mav.addObject("msg",msg);
		mav.addObject("url",url);
		return mav;
	}
	@GetMapping("/review_modify/{product_review_idx}")
	public ModelAndView review_modify(@PathVariable("product_review_idx")int product_review_idx) {
		ModelAndView mav = new ModelAndView("/product/review_modify");
		ReviewDTO dto = reviewService.getOne(product_review_idx);
		mav.addObject("dto",dto);
		return mav;
	}
	@PostMapping("/review_modify/{product_review_idx}")
	public ModelAndView review_modify(ReviewDTO dto,@PathVariable("product_review_idx")int product_review_idx) {
		int idx = dto.getProduct_idx();
		System.out.println("idx = " + idx);
		ModelAndView mav = new ModelAndView("/errorpage");
		String url = "/product/view/" + idx;
		dto.setProduct_review_idx(product_review_idx);
		int row = reviewService.modifyReview(dto);
		System.out.println(row == 1 ?"리뷰 수정 성공":"리뷰 수정 실패");
		
		if(row != 1) {
			String msg = "리뷰 수정에 실패 하였습니다.";
			mav.addObject("msg",msg);
			mav.addObject("url",url);
		}
		String msg = "리뷰 수정 성공 하였습니다.";
		mav.addObject("url",url);
		mav.addObject("msg",msg);
		return mav;
	}
	@GetMapping("/purchaseComplete")
	public void purchaseComplete() {}
}
