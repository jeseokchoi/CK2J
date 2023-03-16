package com.itbank.repository;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.itbank.model.SalesChartDTO;


@Repository
public interface SalesChartDAO {

	List<SalesChartDTO> getOrderList(String category);

}
