package com.oohooh.shopping.service;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Path;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.oohooh.shopping.dao.AccountRepository;
import com.oohooh.shopping.dao.TradeRepository;
import com.oohooh.shopping.entities.Account;
import com.oohooh.shopping.entities.Trade;

@Service
public class TradeService {
	
	@Autowired
	private AccountRepository accountRepository;
	
	@Autowired
	private TradeRepository tradeRepository;
	
	@Transactional(readOnly=true)
	public Page<Trade> getPage(int pageNo, int pageSize, String username) {
		
		Account account = accountRepository.getByUsername(username);
		
		Sort sort = new Sort(Direction.DESC, "tradeTime");
		
		PageRequest pageable = new PageRequest(pageNo - 1, pageSize, sort);
		
		Specification<Trade> specification = new Specification<Trade>() {
			@Override
			public Predicate toPredicate(Root<Trade> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
				Path path = root.get("account");
				Predicate predicate = cb.equal(path, account);
				return predicate;
			}
		};
		
		Page<Trade> page = tradeRepository.findAll(specification, pageable);
		return page;
	}
	
}
