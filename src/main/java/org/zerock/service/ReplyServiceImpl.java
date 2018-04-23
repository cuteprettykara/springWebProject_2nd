package org.zerock.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;
import org.zerock.persistence.ReplyDAO;

@Service
public class ReplyServiceImpl implements ReplyService {
	
	@Inject
	private ReplyDAO replyDao;

	@Override
	public List<ReplyVO> listReply(Integer bno) {
		return replyDao.list(bno);
	}

	@Override
	public void addReply(ReplyVO vo) {
		replyDao.create(vo);
	}

	@Override
	public void modifyReply(ReplyVO vo) {
		replyDao.update(vo);
	}

	@Override
	public void removeReply(Integer rno) {
		replyDao.delete(rno);
	}

	@Override
	public List<ReplyVO> listReplyCriteria(Integer bno, Criteria cri) {
		return replyDao.listCriteria(bno, cri);
	}

	@Override
	public int getTotalReplyCount(Integer bno) {
		return replyDao.getTotalReplyCount(bno);
	}
}
