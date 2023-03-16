package com.itbank.repository;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.itbank.model.ProductDTO;

@Repository
public interface SearchDAO {

	// 검색어 맞는 상품 리스트 찾는 쿼리
	List<ProductDTO> search_List(HashMap<String, String> param);
//	// 검색어에 맞는 썸네일 찾아오는 쿼리
//	List<ProductDTO> search_List1(HashMap<String, String> param);

// 페지징, 조건별 검색 정렬 
	int getCount(HashMap<String, String> param);

	List<ProductDTO> selectList(HashMap<String, String> map);

	List<String> select_t_img(HashMap<String, String> map);

	List<ProductDTO> selectListSortByLowPrice(HashMap<String, String> map);

	List<String> select_t_imgSortByLowPrice(HashMap<String, String> param);

	List<ProductDTO> selectListSortByhighPrice(HashMap<String, String> map);

	List<String> select_t_imgSortByhighPrice(HashMap<String, String> param);

// 여기까지 ----------------▲
	
}
