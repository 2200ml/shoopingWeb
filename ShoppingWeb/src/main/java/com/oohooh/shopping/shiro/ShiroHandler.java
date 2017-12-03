package com.oohooh.shopping.shiro;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.util.SavedRequest;
import org.apache.shiro.web.util.WebUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.oohooh.shopping.utils.JsonMsg;

@Controller
public class ShiroHandler {
	
	@RequestMapping("/login")
	public String loginPage() {
		return "login";
	}
	
	@ResponseBody
	@RequestMapping("/shiroLogin")
	public JsonMsg login(@RequestParam("username") String username, @RequestParam("password") String password,
			@RequestParam(value="rememberMe", required=false) boolean rememberMe, HttpServletRequest request) {
		
		Subject currentUser = SecurityUtils.getSubject();
		
		if(!currentUser.isAuthenticated()) {
			UsernamePasswordToken token = new UsernamePasswordToken(username, password, rememberMe);
			try {
				currentUser.login(token);
				request.getSession().setAttribute("username", username);
				
				//Shiro提供的記住上一頁的方法
				SavedRequest savedRequest = WebUtils.getSavedRequest(request);
				String url = null;
				
		        if (savedRequest == null || savedRequest.getRequestUrl() == null) {
		        	url = "myAccount";
		        }else {
		        	url = savedRequest.getRequestUrl();
		        }
		        return JsonMsg.success().add("url", url);
		        
			} catch (UnknownAccountException ue) {
				System.out.println("帳號不存在...");
				return JsonMsg.fail();
			} catch (IncorrectCredentialsException ie) {
				System.out.println("密碼錯誤...");
				return JsonMsg.fail();
			} catch (AuthenticationException ae) {
				return JsonMsg.fail();
			}
		}
		
		return JsonMsg.success();
	}
}
