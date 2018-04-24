package org.zerock.service;

import org.zerock.domain.MessageVO;

public interface MessageService {
	public void addMessage(MessageVO vo);
	
	public MessageVO readMessage(String uid, Integer mid);
}
