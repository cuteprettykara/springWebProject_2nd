package org.zerock.persistence;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.persistence.MemberDAO;
import org.zerock.web.domain.MemberVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:/applicationContext.xml")
public class MemberDAOImplTest {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberDAOImplTest.class);

	@Inject
	MemberDAO memberDao;
	
	@Test
	public void testGetTime() {
		logger.info("dao.getTime() : {}", memberDao.getTime());
	}

	@Test
	public void testInsertMember() {
		MemberVO vo = new MemberVO("user00", "user00", "USER00", "user00@aaa.com");
		
		memberDao.insertMember(vo);
	}

}
