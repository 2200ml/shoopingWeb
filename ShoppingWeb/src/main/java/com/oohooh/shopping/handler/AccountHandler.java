package com.oohooh.shopping.handler;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.oohooh.shopping.entities.Account;
import com.oohooh.shopping.service.AccountService;
import com.oohooh.shopping.shiro.EncryptUtil;
import com.oohooh.shopping.utils.JsonMsg;

@Controller
public class AccountHandler {
	
	@Autowired
	private AccountService accountService;
	
	@ModelAttribute
	public void getAccount(@RequestParam(value="id", required=false) Integer id, Map<String, Object> map) {
		if(id != null) {
			Account account = accountService.getById(id);
			map.put("account", account);
		}
	}
	
	@RequestMapping("/myAccount")
	public String myAccountPage() {
		return "myAccount";
	}
	
	@ResponseBody
	@RequestMapping(value="/update/{id}", method=RequestMethod.PUT)
	public JsonMsg update(@Valid Account account, BindingResult result, @RequestParam(value="password", required=false) String password) {
		
		if(result.hasErrors()) {
			Map<String, Object> errorFields = new HashMap<>();
			List<FieldError> errors = result.getFieldErrors();
			for(FieldError fieldError : errors) {
				errorFields.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return JsonMsg.fail().add("errorFields", errorFields);
		}
		
		if(password != null) {
			EncryptUtil.EncryptAccount(account);
		}
		
		accountService.save(account);
		return JsonMsg.success().add("redirect", "myAccount");
	}
	
	@ResponseBody
	@RequestMapping("/update")
	public JsonMsg memberInfo(HttpServletRequest request) {
		String username = (String) request.getSession().getAttribute("username");
		Account account = accountService.getByUsername(username);
		
		return JsonMsg.success().add("account", account);
	}
	
	@RequestMapping(value="/member", method=RequestMethod.GET)
	public String memberInput(Map<String, Object> map) {
		
		List<Object> days = new ArrayList<Object>();
		for(int i = 1; i <= 31; i++){
			if(i < 10){
				days.add("0" + i);
			}else{
				days.add(i);
			}
		}
		
		List<Integer> years = new ArrayList<Integer>();
		for(int i = 2017; i >= 1900; i--){
			years.add(i);
		}
		
		map.put("days", days);
		map.put("years", years);
		
		return "WEB-INF/views/member";
	}
	
	@ResponseBody
	@RequestMapping(value="/validateUsername")
	public JsonMsg validateUsername(@RequestParam(value="username") String username) {
		String regex = "^[a-z0-9_-]{6,16}$";
		if(!username.matches(regex)) {
			return JsonMsg.fail().add("back_va", "Username 必須是 6~16 位 英文數字 - server");
		}
		
		Account account = accountService.getByUsername(username);
		if(account == null) {
			return JsonMsg.success().add("back_va", "Username can use - server");
		}else {
			return JsonMsg.fail().add("back_va", "Username can\'t use - server");
		}
	}
	
	@ResponseBody
	@RequestMapping(value="/register", method=RequestMethod.POST)
	public JsonMsg save(@Valid Account account, BindingResult result) {
		
		String password = account.getPassword();
		String confirmPassword = account.getConfirmPassword();
		
		if(!password.equals(confirmPassword)) {
			FieldError confirmPasswordError = new FieldError("account", "confirmPassword" , "password 與 confirmPassword 不一致");
			result.addError(confirmPasswordError);
		}
		
		if(result.hasErrors()) {
			Map<String, Object> errorFields = new HashMap<>();
			List<FieldError> errors = result.getFieldErrors();
			for(FieldError fieldError : errors) {
				errorFields.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return JsonMsg.fail().add("errorFields", errorFields);
		}
		
		EncryptUtil.EncryptAccount(account);
		accountService.save(account);
		return JsonMsg.success();
	}
	
	@RequestMapping(value="/register", method=RequestMethod.GET)
	public String registerInput(Map<String, Object> map){
		
		List<Object> days = new ArrayList<Object>();
		for(int i = 1; i <= 31; i++){
			if(i < 10){
				days.add("0" + i);
			}else{
				days.add(i);
			}
		}
		
		List<Integer> years = new ArrayList<Integer>();
		for(int i = 2017; i >= 1900; i--){
			years.add(i);
		}
		
		map.put("days", days);
		map.put("years", years);
		
		return "register";
	}

}
