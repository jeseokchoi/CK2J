package com.itbank.service;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.itbank.model.ProductDTO;
import com.itbank.model.Product_t_imgDTO;
import com.itbank.repository.ProductDAO;

@Service
public class FileService {
	
	@Autowired
	private ProductDAO productDAO;
	
	private String saveDirectory;
			
	public FileService() {
		String linuxPath = "/itemImg";
		String windowsPath = "C:\\itemImg";
		
		String sep = File.separator;	// 파일 경로 구분자 : windows(\), linux(/)
		
		saveDirectory = "\\".equals(sep) ? windowsPath : linuxPath;
		File dir = new File(saveDirectory);
		System.out.println("saveDirectory = " + saveDirectory);
		if(dir.exists() == false) {
			dir.mkdirs();
		}
	}	
	public int tFileUpload(MultipartFile file, String cat, int product_idx, int idx) {
		
		// t_img 파일 이름 생성
		String fileName = cat + "_" + product_idx + "_t_"+idx +"."+ file.getContentType().split("/")[1];
		System.out.println("fileName = "+fileName);
		
		// t_img 테이블에 데이터 생성
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("fileName", fileName);
		param.put("product_idx", product_idx+"");
		int row = productDAO.insertTImg(param);
		
		File dest = new File(saveDirectory, fileName);
		
		try {
			file.transferTo(dest);
			return 1;
			
		} catch (IllegalStateException | IOException e) {e.printStackTrace();}
		
		return 0;
	}
	
	public int dFileUpload(MultipartFile file, String cat, int product_idx, int idx) {
		
		// t_img 파일 이름 생성
		String fileName = cat + "_" + product_idx + "_d_"+idx +"."+ file.getContentType().split("/")[1];
		System.out.println("fileName = "+fileName);
		
		// t_img 테이블에 데이터 생성
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("fileName", fileName);
		param.put("product_idx", product_idx+"");
		int row = productDAO.insertDImg(param);
		
		File dest = new File(saveDirectory, fileName);
		
		try {
			file.transferTo(dest);
			return 1;
			
		} catch (IllegalStateException | IOException e) {e.printStackTrace();}
		
		return 0;
	}
	

public int modifydMultipleFile(ProductDTO dto, int idx) {
	List<MultipartFile> tList = dto.getUpload_t_file();
	List<MultipartFile> dList = dto.getUpload_d_file();
	tList.removeIf(file -> file.getSize() == 0);
	dList.removeIf(file -> file.getSize() == 0);
	dto.setUpload_t_file(tList);
	dto.setUpload_d_file(dList);
	
	int row = 0;
	if(dto.getUpload_t_file().size() != 0) {
		int rowDelete = productDAO.deleteTImg(idx);
		String[] tArr = dto.getT_imgForDelete().split("/");
		for(int i = 0; i < tArr.length; i++) {
			File oldFile = new File(saveDirectory, tArr[i]);
			if(oldFile.exists()) {
				oldFile.delete();
			}
		}
		for(int i = 0; i < dto.getUpload_t_file().size(); i++) {
			row += tFileUpload(dto.getUpload_t_file().get(i), dto.getProduct_code(), idx, i+1);
			File oldFile = new File(saveDirectory, tArr[i]);
		}
	}
	
	if(dto.getUpload_d_file().size() != 0) {
		int rowDelete = productDAO.deleteDImg(idx);
		String[] dArr = dto.getD_imgForDelete().split("/");
		for(int i = 0; i < dArr.length; i++) {
			File oldFile = new File(saveDirectory, dArr[i]);
			if(oldFile.exists()) {
				oldFile.delete();
			}
		}
		for(int i = 0; i < dto.getUpload_d_file().size(); i++) {
			row += dFileUpload(dto.getUpload_d_file().get(i), dto.getProduct_code(), idx, i+1);
		}
	}
	
	return row;
}
	public int uploadMultipleFile(ProductDTO dto, int idx) {
		List<MultipartFile> tList = dto.getUpload_t_file();
		List<MultipartFile> dList = dto.getUpload_d_file();
		tList.removeIf(file -> file.getSize() == 0);
		dList.removeIf(file -> file.getSize() == 0);
		dto.setUpload_t_file(tList);
		dto.setUpload_d_file(dList);
		
		int row = 0;
		
		if(dto.getUpload_t_file().size() != 0) {
			for(int i = 0; i < dto.getUpload_t_file().size(); i++) {
				row += tFileUpload(dto.getUpload_t_file().get(i), dto.getProduct_code(), idx, i+1);
			}
		}
		
		if(dto.getUpload_d_file().size() != 0) {
			for(int i = 0; i < dto.getUpload_d_file().size(); i++) {
				row += dFileUpload(dto.getUpload_d_file().get(i), dto.getProduct_code(), idx, i+1);
			}
		}
//		for(int i = 0; i < dto.getUpload_t_file().size(); i++) {
//			row += tFileUpload(dto.getUpload_t_file().get(i), dto.getProduct_code(), idx, i+1);
//		}
//		for(int i = 0; i < dto.getUpload_d_file().size(); i++) {
//			row += dFileUpload(dto.getUpload_d_file().get(i), dto.getProduct_code(), idx, i+1);
//		}
		
		
		return row;
	}

}
