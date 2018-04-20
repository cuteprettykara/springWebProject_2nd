package org.zerock.service;

import java.util.List;

import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.SearchCriteria;

public interface BoardService {
	public void regist(BoardVO board);
	
	public BoardVO read(Integer bno);
	
	public void modify(BoardVO board);
	
	public void remove(Integer bno);
	
	public List<BoardVO> listAll();
	
	public List<BoardVO> listCriteria(Criteria cri);

	public int getTotalCount();
	
	public List<BoardVO> listSearch(SearchCriteria cri);

	public int getTotalSearchCount(SearchCriteria cri);
}
