package com.itbank.repository;

import java.util.List;

import com.itbank.component.Paging;
import com.itbank.model.QnaDTO;
import com.itbank.model.QnaReplyDTO;

public interface QnaDAO {

	List<QnaDTO> selectQnaAll(Paging paging);

	QnaDTO selectQnaView(int qna_idx);

	List<QnaDTO> searchQna(String keyword);

	int addInsert(QnaDTO dto);

	QnaDTO check(QnaDTO dto);

	int getCountPage();

	List<QnaReplyDTO> selectReplyList(int qna_idx);

	int insertReply(QnaReplyDTO dto);

	int deleteReply(int qna_reply_idx);

	int getModify(QnaReplyDTO dto);

	QnaDTO getModdify(int qna_idx);

	int getMmodify(QnaDTO dto);

	int deleteQna(int qna_idx);

	int checkReply(int qna_idx);

	int deleteReply2(int qna_idx);
	
}
