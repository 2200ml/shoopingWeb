package com.oohooh.shopping.service;

import java.util.Date;
import java.util.LinkedHashSet;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.oohooh.shopping.dao.AccountRepository;
import com.oohooh.shopping.dao.ClothesRepository;
import com.oohooh.shopping.dao.TradeItemRepository;
import com.oohooh.shopping.dao.TradeRepository;
import com.oohooh.shopping.entities.Account;
import com.oohooh.shopping.entities.Clothes;
import com.oohooh.shopping.entities.ShoppingCart;
import com.oohooh.shopping.entities.ShoppingCartItem;
import com.oohooh.shopping.entities.Trade;
import com.oohooh.shopping.entities.TradeItem;

@Service
public class AccountBalanceService {

	@Autowired
	private AccountRepository accountRepository;
	
	@Autowired
	private ClothesRepository clothesRepository;
	
	@Autowired
	private TradeRepository tradeRepository;
	
	@Autowired
	private TradeItemRepository tradeItemRepository;
	
	@Transactional(readOnly=true)
	public Account getAccount(String username) {
		Account account = accountRepository.getByUsername(username);
		return account;
	}

	@Transactional
	public void update(ShoppingCart sc, float sum, Account account, float totalMoney) {
		
		Trade trade = new Trade();
		trade.setAccount(account);
		trade.setTradeTime(new Date());
		trade.setTradeMoney(totalMoney);
		tradeRepository.saveAndFlush(trade);
		
		Set<TradeItem> tradeItems = new LinkedHashSet<>();
		
		for(ShoppingCartItem sci : sc.getItems()) {
			int itemQty = sci.getQuantity();
			int itemSize = sci.getSize();
			int sizeStored = this.getStored(sci);
			Integer clothesId = sci.getClothes().getClothesId();
			Clothes clothes = clothesRepository.getByclothesId(clothesId);
			
			TradeItem tradeItem = new TradeItem();
			tradeItem.setClothesName(clothes.getClothesName());
			tradeItem.setBrand(clothes.getBrand());
			tradeItem.setCategory(clothes.getCategory());
			tradeItem.setPrice(clothes.getPrice());
			tradeItem.setColor(clothes.getColor());
			tradeItem.setQuantity(itemQty);
			tradeItem.setGender(clothes.getGender());
			tradeItem.setTrade(trade);
			
			if(itemSize == 1) {
				clothes.setSizeS(sizeStored - itemQty);
				tradeItem.setSize("S");
			}else if(itemSize == 2) {
				clothes.setSizeM(sizeStored - itemQty);
				tradeItem.setSize("M");
			}else if(itemSize == 3) {
				clothes.setSizeL(sizeStored - itemQty);
				tradeItem.setSize("L");
			}else if(itemSize == 4) {
				clothes.setSizeXL(sizeStored - itemQty);
				tradeItem.setSize("XL");
			}
			
			clothesRepository.saveAndFlush(clothes);
			
			tradeItems.add(tradeItem);
		}
		
		tradeItemRepository.save(tradeItems);
		
		account.getAccountBalance().setBalance(sum);
		accountRepository.saveAndFlush(account);
		
		sc.clear();
	}

	
	@Transactional(readOnly=true)
	public int getStored(ShoppingCartItem sci) {
		Integer clothesId = sci.getClothes().getClothesId();
		Clothes clothes = clothesRepository.getByclothesId(clothesId);
		int itemSize = sci.getSize();
		
		int sizeStored = 0;
		if(itemSize == 1) {
			sizeStored = clothes.getSizeS();
		}else if(itemSize == 2) {
			sizeStored = clothes.getSizeM();
		}else if(itemSize == 3) {
			sizeStored = clothes.getSizeL();
		}else if(itemSize == 4) {
			sizeStored = clothes.getSizeXL();
		}
		
		return sizeStored;
	}

}
