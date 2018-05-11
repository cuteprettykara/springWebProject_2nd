package org.zerock.persistence;

import org.zerock.domain.UserVO;
import org.zerock.dto.UserDTO;

public interface UserDAO {
	public UserVO login(UserDTO dto);
}
