package org.zerock.controller;

import java.util.LinkedHashMap;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.zerock.domain.PageMaker;
import org.zerock.domain.SearchCriteria;
import org.zerock.service.BoardService;

@Controller
@RequestMapping("/sboard/*")
public class SearchBoardController {
	
	private static final Logger logger = LoggerFactory.getLogger(SearchBoardController.class);
	
	@Inject
	private BoardService service;
	
	@ModelAttribute("searchTypeMap")
	public Map<String, String> makeSelect() {
		Map<String, String> searchTypeMap = new LinkedHashMap<String, String>();
		searchTypeMap.put("---", "n");
		searchTypeMap.put("Title", "t");
		searchTypeMap.put("Content", "c");
		searchTypeMap.put("Writer", "w");
		searchTypeMap.put("Title OR Content", "tc");
		searchTypeMap.put("Content OR Writer", "cw");
		searchTypeMap.put("Title OR Content OR Writer", "tcw");
		
		return searchTypeMap;
	}
	
	@RequestMapping(value="list", method=RequestMethod.GET)
	public void listPage(@ModelAttribute("cri") SearchCriteria cri, Model model) {
		model.addAttribute("list", service.listSearch(cri));
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(service.getTotalSearchCount(cri));
		
		model.addAttribute("pageMaker", pageMaker);
		
		logger.info(pageMaker.toString());
	}

}
