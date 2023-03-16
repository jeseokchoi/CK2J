package com.itbank.controller;

import java.util.HashMap;
import java.util.List;

import javax.swing.Spring;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.itbank.component.ProductPaging;
import com.itbank.model.ProductDTO;
import com.itbank.service.Search_Service;


@Controller
@RequestMapping("/search")
public class SearchController {

	@Autowired Search_Service search;
	

	
	@GetMapping("/searchList")
	public ModelAndView search( 
			@RequestParam(defaultValue = "1")Integer page, 
			@RequestParam HashMap<String, String> param) {
		
		System.out.println(param);
		ModelAndView mav = new ModelAndView("/search/searchList");
		int count = search.search_List_count(param);
		
		System.out.println(count + ", " +  page);
		
		ProductPaging paging = new ProductPaging(page, count);
		param.put("perPage", String.valueOf(paging.getPerPage()));
		param.put("offset", String.valueOf(paging.getOffset()));
		
		List<ProductDTO> list = search.search_List(param);
		
		list.forEach(p -> System.out.println(p.getProduct_name()));
		System.out.println("------------");
//		System.out.println(list.get(0).getProduct_t_imgOne());
		mav.addObject("list", list);
		mav.addObject("paging", paging);
		
////		if(param.size() == 0) {
//		if(param == null) {
//			mav.setViewName("/search/errorpage_searchList");
//			String msg = "검색어를 입력해주세요.";
//			mav.addObject("msg",msg);
//			return mav;
//		}
		
		return mav;
	}
	
	
	// 도토꺼 합침.
//	@GetMapping("/searchList")
//	public ModelAndView search( @RequestParam(defaultValue = "1")Integer page, @RequestParam(defaultValue = "0") int sort_method,@RequestParam HashMap<String, String> param) {
//		
//		System.out.println(param);
//		ModelAndView mav = new ModelAndView("/search/searchList");
//		int itemCount = search.getCount(param);
//		System.out.printf("itemcount=%d", itemCount);
//		ProductPaging paging = new ProductPaging(page, itemCount);
//		List<ProductDTO> Product_list = search.getList(param, paging, sort_method);
//		
////		String s = "";
////		if(!param.equals("m_") && !param.equals("w_")) {
////			s = param.substring(param.indexOf("_")+1).toUpperCase();
////		}else {
////			s = "ALL";
////		}
//		
//		
////		mav.addObject("category",s);
//		mav.addObject("param",param);
//		mav.addObject("Product_list", Product_list);
//		mav.addObject("paging", paging);
//		mav.addObject("sort_method", sort_method);
//		
//		List<ProductDTO> list = search.search_List(param); 
//		System.out.println("------------");
//		mav.addObject("list", list);
//
//		return mav;
//	}
//	
//	
//	@GetMapping("/searchList")
//	public ModelAndView search(@RequestParam(defaultValue = "1")Integer page, @RequestParam(defaultValue = "0") int sort_method,@RequestParam HashMap<String, String> param) {
//		
//		int itemCount = search.getCount(param);
//		System.out.printf("itemcount=%d", itemCount);
//		ProductPaging paging = new ProductPaging(page, itemCount);
//		
//		System.out.println(param);
//		ModelAndView mav = new ModelAndView("/search/searchList");
//		List<ProductDTO> list = search.search_List(param); 
//		System.out.println("------------");
////		System.out.println(list.get(0).getProduct_t_imgOne());
//		mav.addObject("list", list);
//		
//////		if(param.size() == 0) {
////		if(param == null) {
////			mav.setViewName("/search/errorpage_searchList");
////			String msg = "검색어를 입력해주세요.";
////			mav.addObject("msg",msg);
////			return mav;
////		}
//		
//		return mav;
//	}
	
	
	
	
}
