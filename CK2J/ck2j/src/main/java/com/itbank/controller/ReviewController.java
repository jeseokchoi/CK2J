package com.itbank.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.itbank.component.Paging;
import com.itbank.model.ReviewDTO;
import com.itbank.model.ReviewReplyDTO;
import com.itbank.service.ReviewService;

@Controller
public class ReviewController {
	
// =========================================== 0226 =========================================================
	@Autowired private ReviewService reviewService;
	
	@GetMapping("/admin/board/reviewManage")
	public ModelAndView reviewManange(@RequestParam(defaultValue ="1")Integer page) {
		ModelAndView mav = new ModelAndView();
		int reviewCount = reviewService.getReviewCount();
		Paging paging = new Paging(page, reviewCount);
		List<ReviewDTO> list = reviewService.getAll(paging);
		mav.addObject("list",list);
		mav.addObject("paging",paging);
		return mav;
	}
	
	@GetMapping("/admin/board/reviewLook/{product_review_idx}")
	public ModelAndView reviewLook(@PathVariable("product_review_idx")int product_review_idx) {
		ModelAndView mav =  new ModelAndView("/admin/board/reviewLook");
		ReviewDTO dto = reviewService.getOne(product_review_idx);
		ReviewReplyDTO dto2 = reviewService.getReplyone(product_review_idx);
		mav.addObject("dto",dto);
		mav.addObject("dto2",dto2);
		return mav;
	}
	
	@PostMapping("/admin/board/reviewLook/{product_review_idx}")
	public ModelAndView reviewReply(ReviewReplyDTO dto) {
		System.out.println("여기");
		ModelAndView mav =  new ModelAndView("/errorpage");
		int row = reviewService.addReviewReply(dto);
		if(row == 1) {
			String msg="리뷰 답글이 정상적으로 등록 되었습니다.❤️";
			String url="/admin/board/reviewManage";
			mav.addObject("msg",msg);
			mav.addObject("url",url);
			return mav;
		}
		String msg="리뷰 등록 실패.😥";
		String url="/admin/board/reviewManage";
		mav.addObject("msg",msg);
		mav.addObject("url",url);
		return mav;
	}
	
	@GetMapping("/admin/board/reviewReplyModify/{product_review_idx}")
	public ModelAndView reviewReplyModify(@PathVariable("product_review_idx")int product_review_idx) {
		ModelAndView mav = new ModelAndView("/admin/board/reviewReplyModify");
		ReviewReplyDTO dto = reviewService.getReplyone(product_review_idx);
		mav.addObject("dto",dto);	
		return mav;
	}
	// =============================== 0226 ===================================================
	@PostMapping("/admin/board/reviewReplyModify/{product_review_idx}")
	public ModelAndView reviewReplyModify(ReviewReplyDTO dto) {
		ModelAndView mav = new ModelAndView("/errorpage");
		int row = reviewService.updateReviewReply(dto);
		String url="/admin/board/reviewLook/"+dto.getProduct_review_idx();
		mav.addObject("url",url);
		if(row == 1) {
			String msg = "리뷰가 정상적으로 수정 되었습니다. 😊";
			mav.addObject("msg",msg);
			return mav;
		}
		String msg = "리뷰 수정 실패 😥";
		mav.addObject("msg",msg);
		return mav;
	}


}
