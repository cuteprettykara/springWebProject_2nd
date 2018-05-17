package org.zerock.service;

import java.util.Date;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.zerock.domain.UserVO;
import org.zerock.dto.LoginDTO;
import org.zerock.persistence.UserDAO;

@Service
public class UserServiceImpl implements UserService {

	@Inject
	private UserDAO userDao;
	
	@Override
	public UserVO login(LoginDTO dto) {
		return userDao.login(dto);
	}

	@Override
	public void keepLogin(String uid, String sessionId, Date next) {
		userDao.keepLogin(uid, sessionId, next);
	}

	@Override
	public UserVO checkLoginBefore(String value) {
		return userDao.checkUserWithSessionKey(value);
	}

}
