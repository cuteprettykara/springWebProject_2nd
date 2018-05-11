package org.zerock.service;

import org.zerock.domain.UserVO;
import org.zerock.dto.UserDTO;

public interface UserService {
	public UserVO login(UserDTO dto);
}
