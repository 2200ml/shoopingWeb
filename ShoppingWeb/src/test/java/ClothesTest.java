import static org.junit.Assert.*;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Path;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.jpa.domain.Specification;

import com.oohooh.shopping.dao.ClothesRepository;
import com.oohooh.shopping.entities.Clothes;

public class ClothesTest {

	ApplicationContext ctx = new ClassPathXmlApplicationContext("applicationContext.xml");
	
	ClothesRepository clothesRepository;
	
	{
		clothesRepository = ctx.getBean(ClothesRepository.class);
	}
	
//	@Test
//	public void testBatch() {
//		for(int i = 21; i <= 40; i++) {
//			Clothes clothes = new Clothes();
//			clothes.setClothesName("ASOS" + i);
//			clothes.setBrand("ASOS");
//			clothes.setCategory("T-Shirt");
//			clothes.setColor("black");
//			float price = (float) (Math.random()*50);
//			clothes.setPrice(price);
//			clothes.setSizeXL(40);
//			clothes.setSizeL(30);
//			clothes.setSizeM(20);
//			clothes.setSizeS(10);
//			
//			clothesRepository.saveAndFlush(clothes);
//		}
//	}
	
	@Test
	public void testClothesRepoitory() {
		int pageNo = 2 - 1;
		int pageSize = 3;
		
		PageRequest pageable = new PageRequest(pageNo, pageSize);
		
		Specification<Clothes> specification = new Specification<Clothes>() {

			@Override
			public Predicate toPredicate(Root<Clothes> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
				Path path = root.get("price");
				Predicate predicate = cb.between(path, 10, 40);
				return predicate;
			}
		};
		
		Page<Clothes> page = clothesRepository.findAll(specification, pageable);
		
		System.out.println("getNumber: " + (page.getNumber()+ 1));
		System.out.println("getTotalElements: " + page.getTotalElements());
		System.out.println("getTotalPages: " + page.getTotalPages());
		System.out.println("getNumberOfElements: " + page.getNumberOfElements());
		
	}

}
