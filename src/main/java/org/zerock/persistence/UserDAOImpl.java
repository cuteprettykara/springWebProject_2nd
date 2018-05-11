package org.zerock.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.zerock.domain.UserVO;
import org.zerock.dto.UserDTO;

@Repository
public class UserDAOImpl implements UserDAO {

	@Inject
	private SqlSession sqlSession;
	
	private static final String namespace = "org.zerock.mapper.userMapper";
	
	@Override
	public UserVO login(UserDTO dto) {
		return sqlSession.selectOne(namespace + ".login", dto);
	}

}
