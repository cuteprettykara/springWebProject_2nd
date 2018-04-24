package org.zerock.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.zerock.domain.MessageVO;

@Repository
public class MessageDAOImpl implements MessageDAO {

	@Inject
	private SqlSession sqlSession;
	
	private static final String namespace = "org.zerock.mapper.MessageMapper";
	
	@Override
	public void create(MessageVO vo) {
		sqlSession.insert(namespace + ".create", vo);

	}

	@Override
	public MessageVO readMessage(Integer mid) {
		return sqlSession.selectOne(namespace + ".readMessage", mid);
	}

	@Override
	public void updateState(Integer mid) {
		sqlSession.update(namespace + ".updateState", mid);
	}

}
