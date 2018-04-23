package org.zerock.persistence;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNull;

import java.util.List;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.SearchCriteria;

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
	
/*	@Test
	public void testDelete() {
		boardDao.delete(1);
		
		BoardVO dbBoard = boardDao.read(1);
		assertNull(dbBoard);
	}*/
	
	@Test
	public void testListAll() {
		boardDao.listAll();
	}
	
	@Test
	public void testListPage() {
		int page = 3;
		List<BoardVO> list = boardDao.listPage(page);
		for (BoardVO boardVO : list) {
			logger.info(boardVO.getBno() + ":" + boardVO.getTitle());
		}
	}
	
	@Test
	public void testListCriteria() {
		
		Criteria cri = new Criteria();
		cri.setPage(3);
		cri.setPerPageNum(20);
		
		List<BoardVO> list = boardDao.listCriteria(cri);
		for (BoardVO boardVO : list) {
			logger.info(boardVO.getBno() + ":" + boardVO.getTitle());
		}
	}
	
	@Test
	public void testListSearch() {
		
		SearchCriteria cri = new SearchCriteria();
		cri.setPage(3);
		cri.setPerPageNum(20);
		cri.setSearchType("t");
		cri.setKeyword("한글");
		
		logger.info("=======================================================");
		List<BoardVO> list = boardDao.listSearch(cri);
		for (BoardVO boardVO : list) {
			logger.info(boardVO.getBno() + ":" + boardVO.getTitle());
		}
		logger.info("=======================================================");
		
		logger.info("count : {}", boardDao.getTotalSearchCount(cri));
	}

	@Test
	public void testURI() throws Exception {
		UriComponents uriComponents = 
				UriComponentsBuilder.newInstance()
//				.path("/board/read")
				.queryParam("bno", 12)
				.queryParam("perPageNum", 20)
				.build();
		
		logger.debug("/board/read?bno=12&perPageNum=20");
		logger.debug(uriComponents.toString());
	}
	
	@Test
	public void testURI2() throws Exception {
		UriComponents uriComponents = 
				UriComponentsBuilder.newInstance()
				.path("/{module}/{page}")
				.queryParam("bno", 12)
				.queryParam("perPageNum", 20)
				.build()
				.expand("board", "read")
				.encode();
		
		logger.debug("/board/read?bno=12&perPageNum=20");
		logger.debug(uriComponents.toString());
	}
}
