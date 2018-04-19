package org.zerock.persistence;

import java.util.List;

import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;

public interface BoardDAO {
	
	public void create(BoardVO vo);
	
	public BoardVO read(Integer bno);
	
	public void update(BoardVO vo);
	
	public void delete(Integer bno);
	
	public List<BoardVO> listAll();
	
	public List<BoardVO> listPage(int page);

	public List<BoardVO> listCriteria(Criteria cri);
}
