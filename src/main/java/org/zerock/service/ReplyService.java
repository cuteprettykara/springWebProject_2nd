package org.zerock.service;

import java.util.List;

import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;

public interface ReplyService {
	public List<ReplyVO> listReply(Integer bno);

	public void addReply(ReplyVO vo);
	
	public void modifyReply(ReplyVO vo);
	
	public void removeReply(Integer rno);
	
	public List<ReplyVO> listReplyCriteria(Integer bno, Criteria cri);

	public int getTotalReplyCount(Integer bno);
	
}
