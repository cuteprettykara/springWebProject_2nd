package org.zerock.persistence;

import org.zerock.domain.MemberVO;

public interface MemberDAO {
	
	public String getTime();
	
	public void insertMember(MemberVO vo);
	
	public MemberVO readMember(String userid);
	
	public MemberVO readWithPW(String userid, String userpw);
}
