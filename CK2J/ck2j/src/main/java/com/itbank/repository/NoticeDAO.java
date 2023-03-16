package com.itbank.repository;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.itbank.component.Paging;
import com.itbank.model.NoticeDTO;

@Repository
public interface NoticeDAO {

	List<NoticeDTO> selectNotice(Paging paging);

	NoticeDTO selectNotiView(int notice_idx);

	List<NoticeDTO> selectSearch(String keyword);

	int addInsert(NoticeDTO dto);

	NoticeDTO getModify(int notice_idx);

	int listModify(NoticeDTO dto);

	int listDelete(int notice_idx);

	int notiCountPage();
	
}
