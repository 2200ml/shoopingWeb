package com.oohooh.shopping.service;

import java.util.ArrayList;
import java.util.List;

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

import com.oohooh.shopping.dao.ClothesRepository;
import com.oohooh.shopping.entities.Clothes;
import com.oohooh.shopping.entities.ShoppingCart;

@Service
public class ClothesService {

	@Autowired
	private ClothesRepository clothesRepository;

	@Transactional(readOnly=true)
	public Clothes getClothesById(Integer clothesId) {
		return clothesRepository.getByclothesId(clothesId);
	}

	@Transactional
	public void addToCart(ShoppingCart sc, int clothesId, Integer size) {
		Clothes clothes = clothesRepository.getByclothesId(clothesId);
		
		if(clothes != null) {
			sc.addClothes(clothes, size);
		}
	}

	@Transactional
	public void remove(ShoppingCart sc, Integer clothesId, Integer size) {
		Clothes clothes = clothesRepository.getByclothesId(clothesId);
		
		if(clothes != null) {
			sc.removeItem(clothesId * 4 + size);
		}
	}

	@Transactional
	public void updateQty(ShoppingCart sc, int clothesId, int size, int quantity) {
		Clothes clothes = clothesRepository.getByclothesId(clothesId);
		
		if(clothes != null) {
			sc.updateItemQuantity(clothesId * 4 + size, quantity);
		}
	}
	
	@Transactional
	public void updateSize(ShoppingCart sc, int clothesId, int oldSize, int newSize, int quantity) {
		Clothes clothes = clothesRepository.getByclothesId(clothesId);
		
		if(clothes != null) {
			sc.updateItemSize(clothes, oldSize, newSize, quantity);
		}
	}
	
	@Transactional
	public void delete(Integer clothesId) {
		clothesRepository.delete(clothesId);
	}
	
	@Transactional
	public Page<Clothes> getPageByCondition(int pageNo, int pageSize, float minPrice, float maxPrice,
			String genderCondition, String categoryCondition, String queryCondition) {

		Sort sort = new Sort(Direction.DESC, "clothesId");
		
		PageRequest pageable = new PageRequest(pageNo - 1, pageSize, sort);
		
		Specification<Clothes> specification = new Specification<Clothes>() {

			@Override
			public Predicate toPredicate(Root<Clothes> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
				Path genderPath = root.get("gender");
				Path categoryPath = root.get("category");
				Path pricePath = root.get("price");
				Path namePath = root.get("clothesName");
				
				List<Predicate> predicates = new ArrayList<Predicate>();
				
				if(genderCondition != null && genderCondition != "") {
					predicates.add(cb.equal(genderPath, genderCondition));
				}
				if(categoryCondition != null && categoryCondition != "") {
					predicates.add(cb.equal(categoryPath, categoryCondition));
				}
				if(queryCondition != null && queryCondition != "") {
					predicates.add(cb.like(namePath,"%" + queryCondition + "%"));
				}
				
				predicates.add(cb.between(pricePath, minPrice, maxPrice));
				
				return cb.and(predicates.toArray(new Predicate[predicates.size()]));
			}
		};
		
		Page<Clothes> page = clothesRepository.findAll(specification, pageable);
		
		return page;
	}

}	
