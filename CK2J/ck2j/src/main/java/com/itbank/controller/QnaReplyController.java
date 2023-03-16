package com.itbank.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.itbank.component.Paging;
import com.itbank.model.QnaDTO;
import com.itbank.model.QnaReplyDTO;
import com.itbank.service.QnaService;

@RestController
@RequestMapping("/admin")
public class QnaReplyController {

	@Autowired 
	private QnaService qnaService;	
	
	@GetMapping("/board/qnaReply")
	public ModelAndView list(@RequestParam(defaultValue = "1")Integer page) {
		ModelAndView mav = new ModelAndView();
		int qnaCount = qnaService.getCount();
		Paging paging = new Paging(page, qnaCount); 
		List<QnaDTO> list = qnaService.getListAll(paging);
		mav.addObject("list", list);
		mav.addObject("paging", paging);
		return mav;
	}
	@GetMapping("/board/qnaReplyView/{qna_idx}")
	public ModelAndView viewQna(@PathVariable("qna_idx") int qna_idx) {
		ModelAndView mav = new ModelAndView("/admin/board/qnaReplyView");
		QnaDTO dto = qnaService.getQnaView(qna_idx);
		mav.addObject("dto", dto);
		return mav;
	}
	// 02.22
	
	@GetMapping("/board/reply/{qna_idx}")
	public List<QnaReplyDTO> getReplyList(@PathVariable int qna_idx) {
		List<QnaReplyDTO> list = qnaService.getReplyList(qna_idx);
		System.out.println(list);
		return list;
	}
	@PostMapping("/board/reply/{qna_idx}")
	public int writeReply(@RequestBody QnaReplyDTO dto) {
		int row = qnaService.writeReply(dto);
		return row;
	}
	@DeleteMapping("/board/reply/{qna_idx}/{qna_reply_idx}")
	public int deleteReply(@PathVariable("qna_reply_idx") int qna_reply_idx,@PathVariable("qna_idx") int qna_idx) {
		int row = qnaService.deleteReply(qna_reply_idx);
		return row;
	}
	@PutMapping("/board/reply/{qna_idx}")
	public int replyModify(@RequestBody QnaReplyDTO dto) {
		int row = qnaService.modify(dto);
		return row;
	}

	
}
