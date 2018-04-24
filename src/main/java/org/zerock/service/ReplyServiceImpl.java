package org.zerock.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;
import org.zerock.persistence.BoardDAO;
import org.zerock.persistence.ReplyDAO;

@Service
public class ReplyServiceImpl implements ReplyService {
	
	@Inject
	private ReplyDAO replyDao;
	
	@Inject
	private BoardDAO boardDao;

	@Override
	public List<ReplyVO> listReply(Integer bno) {
		return replyDao.list(bno);
	}

	@Override
	@Transactional
	public void addReply(ReplyVO vo) {
		replyDao.create(vo);
		boardDao.updateReplyCnt(vo.getBno(), 1);
	}

	@Override
	public void modifyReply(ReplyVO vo) {
		replyDao.update(vo);
	}

	@Override
	@Transactional
	public void removeReply(Integer rno) {
		int bno = replyDao.getBno(rno);
		replyDao.delete(rno);
		boardDao.updateReplyCnt(bno, -1);
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
