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
@RequestMapping("/admin")
public class AdNoticeController {

	@Autowired
	private NoticeService noticeService;
	
	@GetMapping("/board/adNotice")
	public ModelAndView list(@RequestParam(defaultValue = "1")Integer page) {
		ModelAndView mav = new ModelAndView();
		int noticeCount =noticeService.getCount();
		Paging paging = new Paging(page, noticeCount);
		List<NoticeDTO> list = noticeService.getListAll(paging);
		mav.addObject("list", list);
		mav.addObject("paging", paging);
		return mav;
	}
	@GetMapping("/board/adNoticeView/{notice_idx}")
	public ModelAndView viewNotice(@PathVariable("notice_idx") int notice_idx) {
		ModelAndView mav = new ModelAndView("/admin/board/adNoticeView");
		NoticeDTO dto = noticeService.getView(notice_idx);
		mav.addObject("dto", dto);
		return mav;
	}
	@PostMapping("/board/notice")
	public ModelAndView searchNotice(String keyword) {
		ModelAndView mav = new ModelAndView();
		List<NoticeDTO> list = noticeService.getSearchview(keyword);
		mav.addObject("list", list);
		return mav;
	}
	@GetMapping("/board/adNoticeWrite")
	public void noticeWrite() {}
	
	@PostMapping("/board/adNoticeWrite")
	public String noticeWrite(NoticeDTO dto) {
		int row = noticeService.addWrite(dto);
		return "redirect:/admin/board/adNotice";
	}
	@GetMapping("/board/adNotiModify/{notice_idx}")
	public ModelAndView notiModify(@PathVariable("notice_idx") int notice_idx) {
		ModelAndView mav = new ModelAndView("/admin/board/adNotiModify");
		NoticeDTO dto = noticeService.getModify(notice_idx);
		mav.addObject("dto", dto);
		return mav;
	}
	@PostMapping("/board/adNotiModify/{notice_idx}")
	public String notiModify(NoticeDTO dto) {
		int row = noticeService.modify(dto);
		return "redirect:/admin/board/adNoticeView/{notice_idx}";
	}
	@GetMapping("/board/adNotiDelete/{notice_idx}")
	public String notiDelete(@PathVariable("notice_idx") int notice_idx) {
		int row = noticeService.notiDelete(notice_idx);
		return "redirect:/admin/board/adNotice";
	}
}
