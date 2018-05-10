package org.zerock.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.SearchCriteria;

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

	@Override
	public List<BoardVO> listPage(int page) {
		if (page <= 0) page = 1;
		
		page = (page - 1) * 10;
		
		return sqlSession.selectList(namespace + ".listPage", page);
	}

	@Override
	public List<BoardVO> listCriteria(Criteria cri) {
		return sqlSession.selectList(namespace + ".listCriteria", cri);
	}
	
	@Override
	public List<BoardVO> listSearch(SearchCriteria cri) {
		return sqlSession.selectList(namespace + ".listSearch", cri);
	}

	@Override
	public int getTotalCount() {
		return sqlSession.selectOne(namespace + ".getTotalCount");
	}

	@Override
	public int getTotalSearchCount(SearchCriteria cri) {
		return sqlSession.selectOne(namespace + ".getTotalSearchCount", cri);
	}

	@Override
	public void updateReplyCnt(Integer bno, int amount) {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("bno", bno);
		paramMap.put("amount", amount);
		
		sqlSession.update(namespace + ".updateReplyCnt", paramMap);		
	}

	@Override
	public void updateViewCnt(Integer bno) {
		sqlSession.update(namespace + ".updateViewCnt", bno);
	}

	@Override
	public void addAttach(String fullName) {
		sqlSession.insert(namespace+ ".addAttach", fullName);
	}

	@Override
	public void addAttach(String fullName, Integer bno) {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("bno", bno);
		paramMap.put("fullName", fullName);
		
		sqlSession.insert(namespace+ ".addAttachWithBno", paramMap);
	}

	@Override
	public List<String> getAttach(Integer bno) {
		return sqlSession.selectList(namespace + ".getAttach", bno);
	}

	@Override
	public void deleteAttach(Integer bno) {
		sqlSession.delete(namespace+ ".deleteAllAttach", bno);
	}

	@Override
	public void deleteAttach(String fullName, Integer bno) {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("bno", bno);
		paramMap.put("fullName", fullName);
		
		sqlSession.delete(namespace+ ".deleteAttach", paramMap);
	}

}
