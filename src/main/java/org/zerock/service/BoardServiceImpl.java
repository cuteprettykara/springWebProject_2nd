package org.zerock.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.SearchCriteria;
import org.zerock.persistence.BoardDAO;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Inject
	private BoardDAO boardDao;

	@Override
	@Transactional
	public void regist(BoardVO board) {
		boardDao.create(board);
		
		String[] files = board.getFiles();
		
		if (files == null) return;
		
		for (String fileName : files) {
			boardDao.addAttach(fileName);
		}
	}

	@Transactional(isolation=Isolation.READ_COMMITTED)
	@Override
	public BoardVO read(Integer bno) {
		boardDao.updateViewCnt(bno);
		return boardDao.read(bno);
	}

	@Override
	public void modify(BoardVO board) {
		boardDao.update(board);
	}

	@Override
	public void remove(Integer bno) {
		boardDao.delete(bno);
	}

	@Override
	public List<BoardVO> listAll() {
		return boardDao.listAll();
	}

	@Override
	public List<BoardVO> listCriteria(Criteria cri) {
		return boardDao.listCriteria(cri);
	}

	@Override
	public int getTotalCount() {
		return boardDao.getTotalCount();
	}

	@Override
	public List<BoardVO> listSearch(SearchCriteria cri) {
		return boardDao.listSearch(cri);
	}

	@Override
	public int getTotalSearchCount(SearchCriteria cri) {
		return boardDao.getTotalSearchCount(cri);
	}

	@Override
	public List<String> getAttach(Integer bno) {
		return boardDao.getAttach(bno);
	}

	@Override
	public void addAttach(String fullName, Integer bno) {
		boardDao.addAttach(fullName, bno);
	}

	@Override
	public void deleteAttach(String fullName, Integer bno) {
		boardDao.deleteAttach(fullName, bno);
	}

}
