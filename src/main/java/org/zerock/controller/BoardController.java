package org.zerock.controller;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.PageMaker;
import org.zerock.service.BoardService;

@Controller
@RequestMapping("/board/*")
public class BoardController {

	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);

	@Inject
	private BoardService service;
	
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
		
		return "redirect:/board/listAll";
	}
	
	@RequestMapping(value="listAll", method=RequestMethod.GET)
	public void listAll(Model model) {
		logger.info("show all list .......");
		model.addAttribute("list", service.listAll());
	}
	
	@RequestMapping(value="listCri", method=RequestMethod.GET)
	public void listAll(Criteria cri, Model model) {
		logger.info("show list page with Criteria .......");
		model.addAttribute("list", service.listCriteria(cri));
	}
	
	@RequestMapping(value="listPage", method=RequestMethod.GET)
	public void listPage(Criteria cri, Model model) {
		model.addAttribute("list", service.listCriteria(cri));
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(service.getTotalCount());
		
		model.addAttribute("pageMaker", pageMaker);
		logger.info("pageMaker : {}", pageMaker );
	}
	
	@RequestMapping(value="readPage", method=RequestMethod.GET)
	public void readForm(@RequestParam Integer bno, @ModelAttribute("cri") Criteria cri, Model model) {
		logger.info("read Form.......");
		
		model.addAttribute(service.read(bno));
	}
	
	@RequestMapping(value="remove", method=RequestMethod.POST)
	public String remove(Integer bno, RedirectAttributes rttr, Criteria cri) {
		logger.info("remove ....... " + cri);
		
		service.remove(bno);

		rttr.addFlashAttribute("msg", "success");
		
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		
		return "redirect:/board/listPage";
	}
	
	@RequestMapping(value="modifyPage", method=RequestMethod.GET)
	public void modifyForm(@RequestParam Integer bno, @ModelAttribute("cri") Criteria cri, Model model) {
		logger.info("modify Form.......");
		
		model.addAttribute(service.read(bno));
	}
	
	@RequestMapping(value="modifyPage", method=RequestMethod.POST)
	public String modify(BoardVO board, RedirectAttributes rttr, Criteria cri) {
		logger.info("modify .......");
		
		service.modify(board);
		
		rttr.addFlashAttribute("msg", "success");
		
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		
		return "redirect:/board/listPage";
	}
	
	
}
