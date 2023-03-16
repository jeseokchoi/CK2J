package com.itbank.repository;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.itbank.component.Paging;
import com.itbank.model.ReviewDTO;
import com.itbank.model.ReviewReplyDTO;

@Repository
public interface ReviewDAO {
	int insertReview(ReviewDTO dto);

	List<ReviewDTO> selectList(HashMap<String, Integer> map);

	ReviewDTO selectOne(int product_review_idx);

	int updateReview(ReviewDTO dto);

	int delete(int product_review_idx);

	List<ReviewDTO> getAll(Paging paging);

	int getReviewCount();

	int insertReviewReply(ReviewReplyDTO dto);

	ReviewReplyDTO getReplyOne(int product_review_idx);

	int updateReviewReply(ReviewReplyDTO dto);

	int deleteReviewReply(int review_reply_idx);

}
