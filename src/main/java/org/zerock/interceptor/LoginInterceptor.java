package org.zerock.interceptor;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginInterceptor extends HandlerInterceptorAdapter {
	
	private static final String LOGIN = "login";
	
	private static final Logger logger = LoggerFactory.getLogger(LoginInterceptor.class);
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();
		
		if (session.getAttribute(LOGIN) != null) {
			logger.info("clear login data before.");
			session.removeAttribute(LOGIN);
		}
		
		return true;
	}
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		
		HttpSession session = request.getSession();
		Object userVO = modelAndView.getModel().get("userVO");
		
		if (userVO != null) {
			logger.info("new login success.");
			session.setAttribute(LOGIN, userVO);
			
			if (request.getParameter("useCookie") != null) {
				logger.info("remember me...");
				Cookie loginCookie = new Cookie("loginCookie", session.getId());
				loginCookie.setPath("/");
				loginCookie.setMaxAge(60 * 5);	// 5분
				response.addCookie(loginCookie);
			}
			 
			Object dest = session.getAttribute("dest");
			
			logger.info("dest : {}", dest);
			
			response.sendRedirect(dest == null ? "/sboard/list" : (String) dest);
		}
	}
}
