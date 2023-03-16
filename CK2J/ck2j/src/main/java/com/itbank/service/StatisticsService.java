package com.itbank.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itbank.model.UserDTO;
import com.itbank.repository.StatisticsDAO;

@Service
public class StatisticsService {

	@Autowired  StatisticsDAO dao;
	
	public List<UserDTO> getGender(UserDTO dto) {

		return dao.selectGender(dto);
	}

	public List<UserDTO> getAge(UserDTO dto) {
		return dao.selectAge(dto);
	}

	
	
}
