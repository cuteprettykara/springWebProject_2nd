package org.zerock.controller;

import javax.inject.Inject;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations= {
		"classpath:applicationContext.xml",
		"file:webapp/WEB-INF/zerock-servlet.xml"
})
public class SampleControllerTest {

	private static final Logger logger = LoggerFactory.getLogger(SampleControllerTest.class);

	@Inject
	private WebApplicationContext wac;
	
	private MockMvc mockMvc;
	
	@Before
	public void setup() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(this.wac).build();
		logger.info("setup.............");
	}
	
	
	@Test
	public void testDoA() throws Exception {
		mockMvc.perform(MockMvcRequestBuilders.get("/doA"));
	}

	@Test
	public void testDoB() throws Exception {
		mockMvc.perform(MockMvcRequestBuilders.get("/doB"));
	}

	@Test
	public void testDoC() throws Exception {
		mockMvc.perform(MockMvcRequestBuilders.get("/doC"))
			.andExpect(MockMvcResultMatchers.status().isOk())
			.andExpect(MockMvcResultMatchers.forwardedUrl("/WEB-INF/views/result.jsp"));
			
	}
	/*
	@Test
	public void testDoD() {
		fail("Not yet implemented");
	}
*/
	@Test
	public void testDoE() throws Exception {
		mockMvc.perform(MockMvcRequestBuilders.get("/doE"))
		.andExpect(MockMvcResultMatchers.status().isMovedTemporarily())
		.andExpect(MockMvcResultMatchers.redirectedUrl("/doF"));
	}
	/*
	@Test
	public void testDoF() {
		fail("Not yet implemented");
	}

	@Test
	public void testDoJSON() {
		fail("Not yet implemented");
	}*/

}
