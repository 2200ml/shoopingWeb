package com.oohooh.shopping.service;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.oohooh.shopping.dao.AccountRepository;
import com.oohooh.shopping.entities.Account;
import com.oohooh.shopping.entities.AccountBalance;

@Service
public class AccountService {

	@Autowired
	private AccountRepository accountRepository;
	
	@Transactional
	public Account getByUsername(String username) {
		return accountRepository.getByUsername(username);
	}
	
	@Transactional
	public Account getById(Integer id) {
		return accountRepository.getById(id);
	}
	
	@Transactional
	public void save(Account account) {
		if(account.getId() == null) {
			account.setCreateTime(new Date());
			account.setRole("user");
			
			AccountBalance accountBalance = new AccountBalance();
			account.setAccountBalance(accountBalance);
		}
		accountRepository.saveAndFlush(account);
	}

	

}
