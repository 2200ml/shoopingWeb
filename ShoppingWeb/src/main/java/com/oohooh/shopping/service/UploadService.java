package com.oohooh.shopping.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.oohooh.shopping.dao.ClothesRepository;
import com.oohooh.shopping.entities.Clothes;

@Service
public class UploadService {

	@Autowired
	private ClothesRepository clothesRepository;

	@Transactional
	public void saveAndUpdate(Clothes clothes) {
		clothesRepository.saveAndFlush(clothes);
	}

	@Transactional(readOnly=true)
	public Clothes getById(Integer clothesId) {
		return clothesRepository.getByclothesId(clothesId);
	}
	
}
