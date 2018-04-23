package org.zerock.persistence;

import java.util.List;

import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;

public interface ReplyDAO {
	public List<ReplyVO> list(Integer bno);
	
	public void create(ReplyVO vo);
	
	public void update(ReplyVO vo);
	
	public void delete(Integer rno);
	
	public List<ReplyVO> listCriteria(Integer bno, Criteria cri);
	
	public int getTotalReplyCount(Integer bno);
}
