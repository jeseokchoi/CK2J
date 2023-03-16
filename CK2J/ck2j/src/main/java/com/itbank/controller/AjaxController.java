package com.itbank.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import com.itbank.model.Product_optDTO;
import com.itbank.model.ReviewDTO;
import com.itbank.model.SalesChartDTO;
import com.itbank.service.AjaxService;
import com.itbank.service.ReviewService;
import com.itbank.service.SalesChartService;

@RestController
public class AjaxController {
	
	@Autowired
	private AjaxService ajaxService;
	@Autowired ReviewService reviewService;

	@GetMapping("/board/optCheck/{idx}/{color}")
	public List<Product_optDTO> optCheck(@PathVariable("idx") int product_idx, @PathVariable("color") String color) {
		List<Product_optDTO> optList = ajaxService.selectOpt(product_idx, color);
		return optList;
	}
	
	// =======================================0222=========================================================================
	
	@GetMapping("/product/review/{product_idx}")
	public List<ReviewDTO> review(@PathVariable int product_idx) {
		List<ReviewDTO> list =  reviewService.getList(product_idx);		
		return list;
	}
	@DeleteMapping("/product/review_delete/{product_review_idx}")
	public int review_delete(@PathVariable("product_review_idx") int product_review_idx) {
		int row =reviewService.delete(product_review_idx);	
			return row;
	}
	
	@DeleteMapping("/admin/board/reviewReplyDelete/{review_reply_idx}")
	public int review_reply_delete(@PathVariable("review_reply_idx")int review_reply_idx) {
		System.out.println("여기");
		int row = reviewService.deleteReviewReply(review_reply_idx);
		return row;
	}
	
}
