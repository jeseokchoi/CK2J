package com.itbank.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.itbank.component.Paging;
import com.itbank.model.QnaDTO;
import com.itbank.model.QnaReplyDTO;
import com.itbank.service.QnaService;

@Controller
@RequestMapping("/board")
public class QnaController {
	
	@Autowired
	private QnaService qnaService;

	@GetMapping("/qna")
	public ModelAndView list(@RequestParam(defaultValue = "1")Integer page) {
		ModelAndView mav = new ModelAndView();
		int qnaCount = qnaService.getCount();
		Paging paging = new Paging(page, qnaCount); 
		List<QnaDTO> list = qnaService.getListAll(paging);
		mav.addObject("list", list);
		mav.addObject("paging", paging);
		return mav;
	}
	@GetMapping("/qnaView/{qna_idx}")
	public ModelAndView viewQna(@PathVariable("qna_idx") int qna_idx) {
		// 02.23
		ModelAndView mav = new ModelAndView("/board/qnaView");
		QnaDTO dto = qnaService.getQnaView(qna_idx);
		List<QnaReplyDTO> list = qnaService.getReplyList(qna_idx);
		mav.addObject("dto", dto);
		mav.addObject("list", list);
		return mav;
	}
	@PostMapping("/qna")
	public ModelAndView searchQna(String keyword) {
		ModelAndView mav = new ModelAndView();
		List<QnaDTO> list = qnaService.getSearch(keyword);
		mav.addObject("list", list);
		return mav;
	}
	@GetMapping("/qnaWrite")
	public void qnaWrite() {}
	
	@PostMapping("/qnaWrite")
	public String qnaWrite(QnaDTO dto) {
		int row = qnaService.addWrite(dto);
		return "redirect:/board/qna";
	}
	@GetMapping("/qnaPassword/{qna_idx}")
	public String qnaPassword() {
		return "/board/qnaPassword";
	}
		
	@PostMapping("/qnaPassword/{qna_idx}")
	public ModelAndView checkPassword(QnaDTO ob, @PathVariable("qna_idx") int qna_idx) {
		ob.setQna_idx(qna_idx);
		QnaDTO dto = qnaService.check(ob);
		 
		 if(dto == null) {
			 ModelAndView mav = new ModelAndView("board/qnaPassword");
			 mav.addObject("error", "비밀번호가 일치하지 않습니다");
			 return mav;
		 }else {
			// 02.23
			 ModelAndView mav = new ModelAndView("board/qnaView");
			 List<QnaReplyDTO> list = qnaService.getReplyList(qna_idx);
			 mav.addObject("dto",dto);
 			 mav.addObject("list", list);
			 return mav;
		 }
	}

	// 02.24
	
	@GetMapping("/qnaModify/{qna_idx}")
	public ModelAndView qnaModify(@PathVariable("qna_idx") int qna_idx) {
		ModelAndView mav = new ModelAndView("board/qnaModify");
		QnaDTO dto = qnaService.getModify(qna_idx);
		mav.addObject("dto", dto);
		return mav;
	}
	@PostMapping("/qnaModify/{qna_idx}")
	public String qnaModify(QnaDTO dto) {
		int row = qnaService.getModdify(dto);
		return "redirect:/board/qnaView/{qna_idx}";
	}
	@GetMapping("/qnaDelete/{qna_idx}")
	public String qnaDelete(@PathVariable("qna_idx") int qna_idx) {
		int check = qnaService.checkReply(qna_idx);
		System.out.println(check);
		if(check > 0) {
			System.out.println("여기옴");
			int i = qnaService.deleteReply2(qna_idx);
			System.out.println("여기도 옴?");
			System.out.println("qna_idx = " + qna_idx);
			int row = qnaService.qnaDelete(qna_idx);
			System.out.println("여기 끝");
		}else {
			int row = qnaService.qnaDelete(qna_idx);
		}
			
		
		return "redirect:/board/qna";
	}
	
	
	
}
