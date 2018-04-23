package org.zerock.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;

@Repository
public class ReplyDAOImpl implements ReplyDAO {
	
	@Inject
	private SqlSession sqlSession;
	
	private static final String namespace = "org.zerock.mapper.replyMapper";

	@Override
	public List<ReplyVO> list(Integer bno) {
		return sqlSession.selectList(namespace + ".list", bno);
	}

	@Override
	public void create(ReplyVO vo) {
		sqlSession.insert(namespace + ".create", vo);
	}

	@Override
	public void update(ReplyVO vo) {
		sqlSession.update(namespace + ".update", vo);
	}

	@Override
	public void delete(Integer rno) {
		sqlSession.delete(namespace + ".delete", rno);
	}

	@Override
	public List<ReplyVO> listCriteria(Integer bno, Criteria cri) {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("bno", bno);
		paramMap.put("cri", cri);
		
		return sqlSession.selectList(namespace + ".listCriteria", paramMap);
	}

	@Override
	public int getTotalReplyCount(Integer bno) {
		return sqlSession.selectOne(namespace + ".getTotalReplyCount", bno);
	}

}
