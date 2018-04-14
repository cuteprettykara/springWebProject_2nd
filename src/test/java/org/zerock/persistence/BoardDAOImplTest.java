package org.zerock.persistence;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNull;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.BoardVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:/applicationContext.xml")
@Transactional
public class BoardDAOImplTest {
	
	private static final Logger logger = LoggerFactory.getLogger(BoardDAOImplTest.class);

	@Inject
	private BoardDAO boardDao;
	
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
	public void testCreate() {
		BoardVO dbBoard = new BoardVO("새로운 글을 넣습니다.", "새로운 글을 넣습니다.", "prettykara");
		boardDao.create(dbBoard);
	}

	@Test
	public void testRead() {
		BoardVO dbBoard = boardDao.read(1);
		
		BoardVO board = new BoardVO(1, "타이틀1", "타이틀1 내용", "prettykara");
		assertEquals(board, dbBoard);
	}
	
	@Test
	public void testUpdate() {
		BoardVO board = new BoardVO(1, "타이틀1_update", "타이틀1 내용_update", "prettykara");
		boardDao.update(board);
		
		BoardVO dbBoard = boardDao.read(1);
		assertEquals(board, dbBoard);
	}
	
	@Test
	public void testDelete() {
		boardDao.delete(1);
		
		BoardVO dbBoard = boardDao.read(1);
		assertNull(dbBoard);
	}
	
	@Test
	public void testListAll() {
		boardDao.listAll();
	}

}
