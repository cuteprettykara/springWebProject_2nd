package org.zerock.controller;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.BoardVO;
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
	
	@RequestMapping(value="readPage", method=RequestMethod.GET)
	public void readForm(@RequestParam Integer bno, @ModelAttribute("cri") SearchCriteria cri, Model model) {
		logger.info("read Form.......");
		
		model.addAttribute(service.read(bno));
	}
	
	@RequestMapping(value="removePage", method=RequestMethod.POST)
	public String remove(Integer bno, RedirectAttributes rttr, SearchCriteria cri) {
		logger.info("remove ....... " + cri);
		
		service.remove(bno);

		rttr.addFlashAttribute("msg", "success");
		
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("searchType", cri.getSearchType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/sboard/list";
	}

	@RequestMapping(value="modifyPage", method=RequestMethod.GET)
	public void modifyForm(@RequestParam Integer bno, @ModelAttribute("cri") SearchCriteria cri, Model model) {
		logger.info("modify Form.......");
		
		model.addAttribute(service.read(bno));
	}
	
	@RequestMapping(value="modifyPage", method=RequestMethod.POST)
	public String modify(BoardVO board, RedirectAttributes rttr, SearchCriteria cri) {
		logger.info("modify .......");
		
		service.modify(board);
		
		rttr.addFlashAttribute("msg", "success");
		
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("searchType", cri.getSearchType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/sboard/list";
	}
	
	@RequestMapping(value="register", method=RequestMethod.GET)
	public void registerForm() {
		logger.info("registerForm .......");
	}
	
	@RequestMapping(value="register", method=RequestMethod.POST)
	public String register(BoardVO board, RedirectAttributes rttr) {
		logger.info("register .......");
		logger.info(board.toString());
		
		service.regist(board);
		rttr.addFlashAttribute("msg", "success");
		
		return "redirect:/sboard/list";
	}
	
	@ResponseBody
	@RequestMapping("/getAttach/{bno}")
	public List<String> getAttach(@PathVariable Integer bno) throws Exception {
		return service.getAttach(bno);
	}
}
