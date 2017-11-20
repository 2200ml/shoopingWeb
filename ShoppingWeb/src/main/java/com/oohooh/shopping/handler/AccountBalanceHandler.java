package com.oohooh.shopping.handler;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.oohooh.shopping.entities.Account;
import com.oohooh.shopping.entities.ShoppingCart;
import com.oohooh.shopping.entities.ShoppingCartItem;
import com.oohooh.shopping.service.AccountBalanceService;
import com.oohooh.shopping.utils.JsonMsg;
import com.oohooh.shopping.utils.ShoppingWebUtil;

@Controller
public class AccountBalanceHandler {

	@Autowired
	private AccountBalanceService accountBalanceService;
	
	@ResponseBody
	@RequestMapping("/confirmCheckout")
	public JsonMsg confirmCheckout(HttpServletRequest request) {
		String username = (String) request.getSession().getAttribute("username");
		Account account = accountBalanceService.getAccount(username);
		
		float balance = account.getAccountBalance().getBalance();
		
		ShoppingCart sc = ShoppingWebUtil.getShoppingCart(request);
		float totalMoney = sc.getTotalMoney();
		float sum = balance - totalMoney;
		
		List<ShoppingCartItem> storedErrors = new ArrayList<>();
		
		for(ShoppingCartItem sci : sc.getItems()) {
			int itemQty = sci.getQuantity();
			int itemSize = sci.getSize();
			int sizeStored = accountBalanceService.getStored(sci, itemSize);
			
			if(itemQty > sizeStored) {
				//shoppingCartItem的stored屬性用來儲存商品的庫存
				sci.setStored(sizeStored);
				storedErrors.add(sci);
			}
		}
		
		if(sum < 0) {
			return JsonMsg.fail().add("sumError", "餘額不足");
		}
		
		if(storedErrors.size() > 0) {
			return JsonMsg.fail().add("storedError", storedErrors);
		}
		
		accountBalanceService.update(sc , sum, account, totalMoney);
		
		return JsonMsg.success();
	}
	
	@RequestMapping("/checkout")
	public String checkout(HttpServletRequest request, Map<String, Object> map) {
		String username = (String) request.getSession().getAttribute("username");
		
		Account account = accountBalanceService.getAccount(username);
		map.put("account", account);
		
		return "WEB-INF/views/checkout";
	}
	
}
