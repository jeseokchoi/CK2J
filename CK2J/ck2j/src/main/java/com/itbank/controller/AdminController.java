package com.itbank.controller;

import java.util.HashMap;
import java.util.Iterator;
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
import com.itbank.model.ProductDTO;
import com.itbank.model.Product_optDTO;
import com.itbank.model.UserDTO;
import com.itbank.service.FileService;
import com.itbank.service.ProductService;
import com.itbank.service.UserService;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired private FileService fileService;
	@Autowired private ProductService productService;
	@Autowired private UserService userService;
	
	@GetMapping("/index")
	public void index() {}
	
	@GetMapping("/product/uploadFile")
	public void uploadFile() {}

	@PostMapping("/product/uploadFile")
	public String uploadFile(ProductDTO dto) {
		int row1 = productService.insertProductDTO(dto);
		int idx = productService.getProductIdx(dto);
		fileService.uploadMultipleFile(dto, idx);
		dto.setProduct_idx(idx);
		int row2 = productService.insertProductOpt(dto);
		return "redirect:/admin/product/productList";
	}
	
	@GetMapping("/product/modify/{productIdx}")
	public ModelAndView modifyProduct(@PathVariable("productIdx") int productIdx) {
		ModelAndView mav = new ModelAndView("/admin/product/modify");
		List<String> colorList = productService.getProductColorOpt(productIdx);
		List<String> sizeList = productService.getProductSizeOpt(productIdx);
		String colors = "";
		for(int i = 0; i < colorList.size(); i++) {
			colors += i != colorList.size()-1 ? colorList.get(i) + "/" : colorList.get(i); 
		}
		String sizes = "";
		for(int i = 0; i < sizeList.size(); i++) {
			sizes += i != sizeList.size()-1 ? sizeList.get(i) + "/" : sizeList.get(i); 
		}
		ProductDTO dto = productService.getDTO(productIdx);
		dto.setColorOptForUpload(colors);
		dto.setSizeOptForUpload(sizes);
		mav.addObject("dto", dto);
		return mav;
	}
	
	@PostMapping("/product/modify/{productIdx}")
	public ModelAndView modifyProduct(ProductDTO dto) {
		ModelAndView mav = new ModelAndView("redirect:/admin/product/productList");
		int row1 = productService.modifyProduct(dto);
		if(!dto.getSizeOptForUpload().equals(dto.getSizeOptForUploadForCompare()) || !dto.getColorOptForUpload().equals(dto.getColorOptForUploadForCompare())) {
			System.out.println("옵션지움");
			int row2 = productService.deleteProductOpt(dto.getProduct_idx());
			int row3 = productService.insertProductOpt(dto);
		}
		int row3 = fileService.modifydMultipleFile(dto, dto.getProduct_idx());
		System.out.println(dto);
		return mav;
	}
	@GetMapping("/product/optStock/{productIdx}")
	public ModelAndView optStock(@PathVariable("productIdx") int productIdx) {
		ModelAndView mav = new ModelAndView("admin/product/optStock");
		List<Product_optDTO> list = productService.getProductOpt(productIdx);
		mav.addObject("list", list);
		return mav;
	}
	
	@PostMapping("/product/optStock/{productIdx}")
	public ModelAndView optStock(@RequestParam HashMap<String, String> param, @PathVariable("productIdx") int productIdx) {
		ModelAndView mav = new ModelAndView("redirect:/admin/product/modify/"+productIdx);
		Iterator<String> keys = param.keySet().iterator();
		System.out.println(param);
		while(keys.hasNext()) {
			String key = keys.next();
			System.out.println(key);
			HashMap<String, String> map = new HashMap<String, String>();
			String color = key.split("/")[0];
			String size = key.split("/")[1];
			
			map.put("product_idx", productIdx+"");
			map.put("color", color);
			map.put("size", size);
			map.put("count", param.get(key));
			int row = productService.updateProduct_opt(map);
		}
		return mav;
	}
	
	@GetMapping("/userManage")
	public ModelAndView userManage(@RequestParam HashMap<String, String> param,@RequestParam(defaultValue ="1")Integer page) {
		ModelAndView mav = new ModelAndView();
		System.out.println(param);
		System.out.println(page);
		
		Iterator<String> keys = param.keySet().iterator();
		String s = "&";
		while(keys.hasNext()) {
			String key = keys.next();
			s += key +"="+ param.get(key)+"&"; 
		}
		System.out.println("s="+s);
		
		if(param.get("keyword") != null) {	
			int userCount = userService.getCount2(param);
			Paging paging = new Paging(page, userCount, 20);
			List<UserDTO> list = userService.getUserSearchList(param,paging);
			mav.addObject("list",list);
			mav.addObject("paging",paging);
			mav.addObject("searchParam",s);
			return mav;
		}else{		
		int userCount = userService.getCount();
		Paging paging = new Paging(page, userCount, 20);
		List<UserDTO> list = userService.getUserList(paging);
		mav.addObject("list",list);
		mav.addObject("paging",paging);
		return mav;
		}
	}
	
	@GetMapping("/userModify")
	public ModelAndView userModify(String user_id) {
		ModelAndView mav = new ModelAndView();
		UserDTO dto = userService.getOne(user_id);
		mav.addObject("dto",dto);
		
		return mav;
	}
	@PostMapping("/userModify")
	public ModelAndView userModify(UserDTO dto) {
		ModelAndView mav = new ModelAndView("/errorpage");
		int row = userService.modify(dto);
		System.out.println(row ==1 ?"회원수정성공":"회원 수정 실패");
		String url="/admin/userManage";
		mav.addObject("msg","회원정보가 수정되었습니다.");		
		mav.addObject("url",url);
		return mav;
	}
	
	@GetMapping("/product/productList")
	public ModelAndView productList() {
		ModelAndView mav = new ModelAndView();
		List<ProductDTO> list = productService.getProductListAll();
		mav.addObject("list", list);
		return mav;
	} 
	
	@PostMapping("/product/productList")
	public ModelAndView productList(@RequestParam HashMap<String, String> param) {
		ModelAndView mav = new ModelAndView();
		System.out.println(param);
		List<ProductDTO> list = productService.getSearchProductList(param);
		mav.addObject("list", list);
		mav.addObject("allList", "allList");
		return mav;
	}
	
	@GetMapping("/product/delete/{idx}")
	public ModelAndView deleteProduct(@PathVariable("idx") int idx) {
		ModelAndView mav = new ModelAndView("redirect:/admin/product/productList");
		int row = productService.deleteProduct(idx);
		return mav;
	}
	
	@GetMapping("/accounting/sales")
	public void total_sales() {}
	
}
