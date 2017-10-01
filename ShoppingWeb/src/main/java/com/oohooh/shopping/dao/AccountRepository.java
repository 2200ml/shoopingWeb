package com.oohooh.shopping.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.oohooh.shopping.entities.Account;

public interface AccountRepository extends JpaRepository<Account, Integer> {
	
	Account getByUsername(String username);

	Account getById(Integer id);
	
}
