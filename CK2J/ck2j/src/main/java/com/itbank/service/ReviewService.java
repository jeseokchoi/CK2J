package com.itbank.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itbank.component.Paging;
import com.itbank.model.ReviewDTO;
import com.itbank.model.ReviewReplyDTO;
import com.itbank.repository.ReviewDAO;

@Service
public class ReviewService {
	
	@Autowired private ReviewDAO dao;

	public int reviewWrite(ReviewDTO dto) {
		
		return dao.insertReview(dto);
	}

	public List<ReviewDTO> getList(int product_idx) {
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("product_idx", product_idx);
		return dao.selectList(map);
	}

	public ReviewDTO getOne(int product_review_idx) {
	
		return dao.selectOne(product_review_idx);
	}

	public int modifyReview(ReviewDTO dto) {
		
		return dao.updateReview(dto);
	}

	public int delete(int product_review_idx) {
		return dao.delete(product_review_idx);
	}

	public List<ReviewDTO> getAll(Paging paging) {
		return dao.getAll(paging);
	}

	public int getReviewCount() {
		
		return dao.getReviewCount();
	}

	public int addReviewReply(ReviewReplyDTO dto) {
		return dao.insertReviewReply(dto);
	}

	public ReviewReplyDTO getReplyone(int product_review_idx) {
		return dao.getReplyOne(product_review_idx);
	}

	public int updateReviewReply(ReviewReplyDTO dto) {
		return dao.updateReviewReply(dto);
	}

	public int deleteReviewReply(int review_reply_idx) {
		return dao.deleteReviewReply(review_reply_idx);
	}

}
