package com.oohooh.shopping.handler;

import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.oohooh.shopping.entities.Trade;
import com.oohooh.shopping.service.TradeService;
import com.oohooh.shopping.utils.JsonMsg;
import com.oohooh.shopping.utils.ShoppingWebUtil;

@Controller
public class TradeHandler {
	
	@Autowired
	private TradeService tradeService;
	
	@ResponseBody
	@RequestMapping("/showTrade")
	public JsonMsg showTrade(@RequestParam(name="pageNo", required = false, defaultValue = "1") String pageNoStr, 
			HttpServletRequest request, Locale locale) {
		
		int pageNo = 1;
		int pageSize = 5;
		
		try {
			pageNo = Integer.parseInt(pageNoStr);
			if(pageNo < 1) {
				pageNo = 1;
			}
		} catch (Exception e) {}
		
		String username = (String) request.getSession().getAttribute("username");
		
		Page<Trade> page = tradeService.getPage(pageNo, pageSize, username);
		
		return JsonMsg.success().add("page", page);
	}
	
	@RequestMapping("/myOrders")
	public String getTradePage(@RequestParam(name="pageNo", required = false, defaultValue = "1") String pageNoStr,
			@RequestParam(name="pageSize", required = false, defaultValue = "5") String pageSizeStr,
			Map<String, Object> map, HttpServletRequest request) {
		
		int pageNo = 1;
		int pageSize = 5;
		
		try {
			pageNo = Integer.parseInt(pageNoStr);
			if(pageNo < 1) {
				pageNo = 1;
			}
		} catch (Exception e) {}
		
		try {
			pageSize = Integer.parseInt(pageSizeStr);
			if(pageSize < 5) {
				pageSize = 5;
			}
		} catch (Exception e) {}
		
		String username = (String) request.getSession().getAttribute("username");
		
		Page<Trade> page = tradeService.getPage(pageNo, pageSize, username);
		
		List<Integer> navigateNum = ShoppingWebUtil.getNavigateNumber(page);
		
		map.put("page", page);
		map.put("navigateNum", navigateNum);
		map.put("hasPrevious", page.hasPrevious());
		map.put("hasNext", page.hasNext());
		
		return "WEB-INF/views/myOrders";
	}
	
}
