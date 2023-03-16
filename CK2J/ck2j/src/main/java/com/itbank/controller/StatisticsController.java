package com.itbank.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.itbank.model.UserDTO;
import com.itbank.service.StatisticsService;

@Controller
@RequestMapping("/admin")
public class StatisticsController {

	@Autowired StatisticsService statistics;
	
	@GetMapping("/statistics/gender")
	public ModelAndView gender(UserDTO dto) {
		ModelAndView mav = new ModelAndView();
		List<UserDTO> list = statistics.getGender(dto);
		
		mav.addObject("list",list);
		return mav;
		
	}
	
	@GetMapping("/statistics/age")
	public ModelAndView age(UserDTO dto) {
		
		ModelAndView mav = new ModelAndView();
		List<UserDTO> list = statistics.getAge(dto);
		
		mav.addObject("list",list);
		
		return mav;
		
	}
}
