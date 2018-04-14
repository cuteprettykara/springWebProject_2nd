package org.zerock.persistence;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.MemberVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:/applicationContext.xml")
@Transactional
public class MemberDAOImplTest {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberDAOImplTest.class);

	@Inject
	MemberDAO memberDao;
	
/*	@Inject
	private DataSource dataSource;
	
	@Before
	public void initialize() {
		ResourceDatabasePopulator populator = new ResourceDatabasePopulator();
		populator.addScript(new ClassPathResource("zerock.sql"));
		DatabasePopulatorUtils.execute(populator, dataSource);
		
		logger.info("### database successfully initialized!");
	}*/
	
	@Test
	public void testGetTime() {
		logger.info("### dao.getTime() : {}", memberDao.getTime());
	}

	@Test
	public void testInsertMember() {
		MemberVO vo = new MemberVO("prettykara2", "2222", "남상범2", "kara@gmail.com");
		
		memberDao.insertMember(vo);
		
		MemberVO dbUser = memberDao.readMember(vo.getUserid());
		
		assertEquals(vo, dbUser);
	}
	
	@Test
	public void testReadMember() {
		MemberVO dbUser = memberDao.readMember("prettykara");
		
		assertNotNull(dbUser);
	}
	
	@Test
	public void testReaddWithPW() {
		MemberVO dbUser = memberDao.readWithPW("prettykara", "1111");
		
		assertNotNull(dbUser);
	}

}
