package com.oohooh.shopping.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import com.oohooh.shopping.entities.Clothes;

public interface ClothesRepository extends JpaRepository<Clothes, Integer>, JpaSpecificationExecutor<Clothes>{
	
	Clothes getByclothesId(Integer clothesId);
	
}
