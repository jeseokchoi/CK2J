package com.itbank.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itbank.component.Paging;
import com.itbank.model.NoticeDTO;
import com.itbank.repository.NoticeDAO;

@Service
public class NoticeService {
	
	@Autowired
	private NoticeDAO dao;

	public List<NoticeDTO> getListAll(Paging paging) {
		return dao.selectNotice(paging);
	}

	public NoticeDTO getView(int notice_idx) {
		return dao.selectNotiView(notice_idx);
	}

	public List<NoticeDTO> getSearchview(String keyword) {
		return dao.selectSearch(keyword);
	}

	public int addWrite(NoticeDTO dto) {
		return dao.addInsert(dto);
	}

	public NoticeDTO getModify(int notice_idx) {
		return dao.getModify(notice_idx);
	}

	public int modify(NoticeDTO dto) {
		return dao.listModify(dto);
	}

	public int notiDelete(int notice_idx) {
		return dao.listDelete(notice_idx);
	}

	public int getCount() {
		return dao.notiCountPage();
	}

	
}
