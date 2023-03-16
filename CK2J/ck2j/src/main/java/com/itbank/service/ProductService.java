package com.itbank.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itbank.component.ProductPaging;
import com.itbank.model.ProductDTO;
import com.itbank.model.Product_optDTO;
import com.itbank.model.Product_t_imgDTO;
import com.itbank.repository.ProductDAO;

@Service
public class ProductService {
	
	@Autowired
	private ProductDAO dao;

	public List<ProductDTO> getList(String cat, ProductPaging paging, int sort_method) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("cat", cat);
		map.put("offset", paging.getOffset()+"");
		map.put("perPage", paging.getPerPage()+"");
		
		List<ProductDTO> list = null;
		List<String> tList = null;
		if(sort_method == 0) {
			list = dao.selectList(map);
			tList = dao.select_t_img(map);
		}else if(sort_method == 1) {
			list = dao.selectListSortByLowPrice(map);
			tList = dao.select_t_imgSortByLowPrice(map);
		}else if(sort_method == 2) {
			list = dao.selectListSortByhighPrice(map);
			tList = dao.select_t_imgSortByhighPrice(map);
		}
		
		for(int i = 0; i < list.size(); i++) {
			List<String> li = new ArrayList<String>();
			li.add(tList.get(i));
			list.get(i).setProduct_t_img(li);
		}
		return list;
	}

	public ProductDTO getDTO(int idx) {
		ProductDTO dto = dao.selectOne(idx);
		dto.setProduct_t_img(dao.selectTImgList(idx));
		dto.setProduct_d_img(dao.selectDImgList(idx));
		return dto;
	}

	public int insertProductDTO(ProductDTO dto) {
		return dao.insertProductDTO(dto);
	}

	public int getProductIdx(ProductDTO dto) {
		return dao.selectProductIdx(dto);
	}

	public List<Product_t_imgDTO> getHomeList() {
		return dao.selectHomeList();
	}

	public List<ProductDTO> getProductListAll() {
		return dao.selectProductListAll();
	}

	public List<ProductDTO> getSearchProductList(HashMap<String, String> param) {
		return dao.selectSearchProductList(param);
	}

	public int getCount(String cat) {
		return dao.getCount(cat);
	}
	
	public int modifyProduct(ProductDTO dto) {
		return dao.updateProduct(dto);
	}

	public int insertProductOpt(ProductDTO dto) {
		int row = 0;
		String[] colorArr = dto.getColorOptForUpload().split("/");
		String[] sizeArr = dto.getSizeOptForUpload().split("/");
		for(int i = 0; i < colorArr.length; i++) {
			for(int j = 0; j < sizeArr.length; j++) {
				HashMap<String, String> param = new HashMap<String, String>();
				param.put("idx", dto.getProduct_idx()+"");
				param.put("color", colorArr[i]);
				param.put("size", sizeArr[j]);
				int row2 = dao.insertProductOpt(param);
			}
		}
		return 0;
	}

	public List<String> getProductColorOpt(int idx) {
		return dao.selectProductColorOpt(idx);
	}

	public List<String> getProductSizeOpt(int idx) {
		return dao.selectProductSizeOpt(idx);
	}

	public List<Product_optDTO> getProductOpt(int productIdx) {
		return dao.selectProductOpt(productIdx);
	}

	public int updateProduct_opt(HashMap<String, String> map) {
		return dao.updateProduct_opt(map);
	}

	public int deleteProductOpt(int idx) {
		return dao.deleteProductOpt(idx);		
	}

	public int deleteProduct(int idx) {
		return dao.deleteProduct(idx);
	}

	public int getProductOptOne(HashMap<String, Object> map) {
		return dao.selectProductOptOne(map);
	}

	public String getProduct_t_img_one(int itemIdx) {
		return dao.selectProduct_t_img_one(itemIdx);
	}


}
