package com.itbank.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itbank.model.SalesChartDTO;
import com.itbank.model.UserOrderDTO;
import com.itbank.repository.SalesChartDAO;
@Service
public class SalesChartService {
 @Autowired private SalesChartDAO dao;

public List<SalesChartDTO> getOrderList(String category) {

	return dao.getOrderList(category);
}
 
}
