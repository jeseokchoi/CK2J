package com.itbank.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itbank.component.ProductPaging;
import com.itbank.model.ProductDTO;
import com.itbank.repository.SearchDAO;

@Service
public class Search_Service {

	@Autowired SearchDAO dao;

	public List<ProductDTO> search_List(HashMap<String, String> param) {
//			   dao.search_List1(param);
		return dao.search_List(param);
	}

	public int getCount(HashMap<String, String> param) {
		return dao.getCount(param);
	}

	public List<ProductDTO> getList(HashMap<String, String> param, ProductPaging paging, int sort_method) {
		HashMap<String, String> map = new HashMap<String, String>();
//		map.put("param", param);
		map.put("offset", paging.getOffset()+"");
		map.put("perPage", paging.getPerPage()+"");
		
		List<ProductDTO> list = null;
		List<String> tList = null;
		if(sort_method == 0) {
			list = dao.selectList(map);
			tList = dao.select_t_img(map);
		}else if(sort_method == 1) {
			list = dao.selectListSortByLowPrice(map);
			tList = dao.select_t_imgSortByLowPrice(param);
		}else if(sort_method == 2) {
			list = dao.selectListSortByhighPrice(map);
			tList = dao.select_t_imgSortByhighPrice(param);
		}
		
		for(int i = 0; i < list.size(); i++) {
			List<String> li = new ArrayList<String>();
			li.add(tList.get(i));
			list.get(i).setProduct_t_img(li);
		}
		return list;
	}

	public int search_List_count(HashMap<String, String> param) {
		return dao.getCount(param);
	}
	
}
