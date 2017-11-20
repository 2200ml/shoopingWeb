package com.oohooh.shopping.utils;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.data.domain.Page;

import com.oohooh.shopping.entities.ShoppingCart;

public class ShoppingWebUtil {

	public static void deleteFile(File file) {
	    if (file.isDirectory()) {
	        for (File subFile : file.listFiles()) {
	            deleteFile(subFile);
	        }
	    }
	    file.delete();
	}
	
	public static ShoppingCart getShoppingCart(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		
		ShoppingCart sc = (ShoppingCart) session.getAttribute("shoppingCart");
		
		if(sc == null) {
			sc = new ShoppingCart();
			session.setAttribute("shoppingCart", sc);
		}
		
		return sc;
	}
	
	public static List<Integer> getNavigateNumber(Page page) {
		List<Integer> navigateNum = new ArrayList<>();
		int pageNo = page.getNumber() + 1;
		
		if(page.getTotalPages() < 5) {
			for(int i = 1; i <= page.getTotalPages(); i++) {
				navigateNum.add(i - 1, i);
			}
		}else {
			if(pageNo > 2 && pageNo <= page.getTotalPages()) {
				if(pageNo + 1 == page.getTotalPages()) {
					navigateNum.add(0, pageNo - 3);
					navigateNum.add(1, pageNo - 2);
					navigateNum.add(2, pageNo - 1);
					navigateNum.add(3, pageNo);
					navigateNum.add(4, pageNo + 1);
				}else if(pageNo == page.getTotalPages()) {
					navigateNum.add(0, pageNo - 4);
					navigateNum.add(1, pageNo - 3);
					navigateNum.add(2, pageNo - 2);
					navigateNum.add(3, pageNo - 1);
					navigateNum.add(4, pageNo);
				}else {
					navigateNum.add(0, pageNo - 2);
					navigateNum.add(1, pageNo - 1);
					navigateNum.add(2, pageNo);
					navigateNum.add(3, pageNo + 1);
					navigateNum.add(4, pageNo + 2);
				}
			}else if(pageNo <= 2) {
				navigateNum.add(0, 1);
				navigateNum.add(1, 2);
				navigateNum.add(2, 3);
				navigateNum.add(3, 4);
				navigateNum.add(4, 5);
			}
		}
	
		return navigateNum;
	}
}
