package org.zerock.service;

import java.util.Date;

import org.zerock.domain.UserVO;
import org.zerock.dto.LoginDTO;

public interface UserService {
	public UserVO login(LoginDTO dto);
	
	public void keepLogin(String uid, String sessionId, Date next);
	
	public UserVO checkLoginBefore(String value);
}
