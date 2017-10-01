package com.oohooh.shopping.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import com.oohooh.shopping.entities.Trade;

public interface TradeRepository extends JpaRepository<Trade, Integer>, JpaSpecificationExecutor<Trade>{

}
