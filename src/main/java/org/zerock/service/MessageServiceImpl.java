package org.zerock.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.MessageVO;
import org.zerock.persistence.MessageDAO;
import org.zerock.persistence.PointDAO;

@Service
public class MessageServiceImpl implements MessageService {

	@Inject
	private MessageDAO messageDao;
	
	@Inject
	private PointDAO pointDao;
	
	@Override
	@Transactional
	public void addMessage(MessageVO vo) {
		messageDao.create(vo);
		pointDao.updatePoint(vo.getSender(), 10);
		
	}

	@Override
	@Transactional
	public MessageVO readMessage(String uid, Integer mid) {
		messageDao.updateState(mid);
		pointDao.updatePoint(uid, 5);
		
		return messageDao.readMessage(mid);
	}

}
