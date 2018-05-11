package org.zerock.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.zerock.domain.UserVO;
import org.zerock.dto.UserDTO;
import org.zerock.persistence.UserDAO;

@Service
public class UserServiceImpl implements UserService {

	@Inject
	private UserDAO userDao;
	
	@Override
	public UserVO login(UserDTO dto) {
		return userDao.login(dto);
	}

}