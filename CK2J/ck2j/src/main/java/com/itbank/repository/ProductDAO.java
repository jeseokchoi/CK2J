package com.itbank.repository;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.itbank.model.ProductDTO;
import com.itbank.model.Product_optDTO;
import com.itbank.model.Product_t_imgDTO;

@Repository
public interface ProductDAO {

	List<ProductDTO> selectList(HashMap<String, String> map);

	List<String> select_t_img(HashMap<String, String> map);

	ProductDTO selectOne(int idx);

	List<String> selectTImgList(int idx);

	List<String> selectDImgList(int idx);
	
	List<Product_optDTO> selectOpt(HashMap<String, String> param);

	int insertProductDTO(ProductDTO dto);

	int selectProductIdx(ProductDTO dto);

	int insertTImg(HashMap<String, String> param);

	int insertDImg(HashMap<String, String> param);

	List<Product_t_imgDTO> selectHomeList();

	List<ProductDTO> selectProductListAll();

	List<ProductDTO> selectSearchProductList(HashMap<String, String> param);
	
	int getCount(String cat);
	
	List<ProductDTO> selectListSortByLowPrice(HashMap<String, String> map);

	List<String> select_t_imgSortByLowPrice(HashMap<String, String> map);

	List<ProductDTO> selectListSortByhighPrice(HashMap<String, String> map);

	List<String> select_t_imgSortByhighPrice(HashMap<String, String> map);

	int updateProduct(ProductDTO dto);

	int insertProductOpt(HashMap<String, String> param);

	List<String> selectProductColorOpt(int idx);

	List<String> selectProductSizeOpt(int idx);

	List<Product_optDTO> selectProductOpt(int productIdx);

	int updateProduct_opt(HashMap<String, String> map);

	int deleteProductOpt(int idx);

	int deleteTImg(int idx);

	int deleteDImg(int idx);

	int deleteProduct(int idx);

	int selectOneProductOpt(HashMap<String, Object> getProductIdxMap);

	int insertCart(HashMap<String, Object> map);

	int selectProductOptOne(HashMap<String, Object> map);

	String selectProduct_t_img_one(int itemIdx);
	
}
