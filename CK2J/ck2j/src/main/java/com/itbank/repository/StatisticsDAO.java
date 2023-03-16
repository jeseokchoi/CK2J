package com.itbank.repository;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.itbank.model.UserDTO;

@Repository
public interface StatisticsDAO {

	List<UserDTO> selectGender(UserDTO dto);

	List<UserDTO> selectAge(UserDTO dto);

	
}
