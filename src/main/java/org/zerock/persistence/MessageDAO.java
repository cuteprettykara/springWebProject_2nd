package org.zerock.persistence;

import org.zerock.domain.MessageVO;

public interface MessageDAO {
	public void create(MessageVO vo);
	
	public MessageVO readMessage(Integer mid);
	
	public void updateState(Integer mid);
}
