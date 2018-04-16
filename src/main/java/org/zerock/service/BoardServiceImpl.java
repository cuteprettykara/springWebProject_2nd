package org.zerock.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.zerock.domain.BoardVO;
import org.zerock.persistence.BoardDAO;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Inject
	private BoardDAO boardDao;

	@Override
	public void regist(BoardVO board) {
		boardDao.create(board);
	}

	@Override
	public BoardVO read(Integer bno) {
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

}
