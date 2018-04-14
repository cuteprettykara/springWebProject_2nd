package org.zerock.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.zerock.domain.BoardVO;

@Repository
public class BoardDAOImpl implements BoardDAO {
	
	@Inject
	private SqlSession sqlSession;
	
	private static final String namespace = "org.zerock.mapper.boardMapper";
	
	@Override
	public void create(BoardVO vo) {
		sqlSession.insert(namespace + ".create", vo);
	}

	@Override
	public BoardVO read(Integer bno) {
		return sqlSession.selectOne(namespace + ".read", bno);
	}

	@Override
	public void update(BoardVO vo) {
		sqlSession.update(namespace + ".update", vo);
	}

	@Override
	public void delete(Integer bno) {
		sqlSession.delete(namespace+ ".delete", bno);
	}

	@Override
	public List<BoardVO> listAll() {
		return sqlSession.selectList(namespace + ".listAll");
	}

}
