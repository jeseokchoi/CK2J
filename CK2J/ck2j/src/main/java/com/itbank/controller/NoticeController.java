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
import com.itbank.model.NoticeDTO;
import com.itbank.service.NoticeService;

@Controller
@RequestMapping("/board")
public class NoticeController {

	@Autowired
	private NoticeService noticeService;
	
	@GetMapping("/notice")
	public ModelAndView list(@RequestParam(defaultValue = "1")Integer page) {
		ModelAndView mav = new ModelAndView();
		int notiCount = noticeService.getCount();
		Paging paging = new Paging(page, notiCount); 
		List<NoticeDTO> list = noticeService.getListAll(paging);
		mav.addObject("list", list);
		mav.addObject("paging", paging);
		return mav;
	}
	@GetMapping("/notiView/{notice_idx}")
	public ModelAndView viewNotice(@PathVariable("notice_idx") int notice_idx) {
		ModelAndView mav = new ModelAndView("/board/notiView");
		NoticeDTO dto = noticeService.getView(notice_idx);
		mav.addObject("dto", dto);
		return mav;
	}
	@PostMapping("/notice")
	public ModelAndView searchNotice(String keyword) {
		ModelAndView mav = new ModelAndView();
		List<NoticeDTO> list = noticeService.getSearchview(keyword);
		mav.addObject("list", list);
		return mav;
	}
}
