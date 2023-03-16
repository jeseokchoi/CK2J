package com.itbank.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itbank.component.Paging;
import com.itbank.model.QnaDTO;
import com.itbank.model.QnaReplyDTO;
import com.itbank.repository.QnaDAO;

@Service
public class QnaService {
	
	@Autowired
	private QnaDAO dao;

	public List<QnaDTO> getListAll(Paging paging) {
		return dao.selectQnaAll(paging);
	}

	public QnaDTO getQnaView(int qna_idx) {
		return dao.selectQnaView(qna_idx);
	}

	public List<QnaDTO> getSearch(String keyword) {
		return dao.searchQna(keyword);
	}

	public int addWrite(QnaDTO dto) {
		return dao.addInsert(dto);
	}

	public QnaDTO check(QnaDTO dto) {
		return dao.check(dto);
	}

	public int getCount() {
		return dao.getCountPage();
	}

	public List<QnaReplyDTO> getReplyList(int qna_idx) {
		return dao.selectReplyList(qna_idx);
	}

	public int writeReply(QnaReplyDTO dto) {
		return dao.insertReply(dto);
	}

	public int deleteReply(int qna_reply_idx) {
		return dao.deleteReply(qna_reply_idx);
	}

	public int modify(QnaReplyDTO dto) {
		return dao.getModify(dto);
	}

	public QnaDTO getModify(int qna_idx) {
		return dao.getModdify(qna_idx);
	}

	public int getModdify(QnaDTO dto) {
		return dao.getMmodify(dto);
	}

	public int qnaDelete(int qna_idx) {
		return dao.deleteQna(qna_idx);
	}

	public int checkReply(int qna_idx) {
		return dao.checkReply(qna_idx);
	}

	public int deleteReply2(int qna_idx) {
		return dao.deleteReply2(qna_idx);
		
	}
	
}
