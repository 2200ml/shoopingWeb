package com.oohooh.shopping.aop;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;

import com.oohooh.shopping.entities.Clothes;

@Aspect
@Component
public class AdminLoggingAspect {
	
	@Pointcut("execution(* com.oohooh.shopping.handler.UploadHandler.deleteClothes(..)) && args(request, clothesName, ..) || "
			+ "execution(* com.oohooh.shopping.handler.UploadHandler.uploadClothes(..)) && args(request, clothesName, ..) || "
			+ "execution(* com.oohooh.shopping.handler.UploadHandler.clothesUpdate(..)) && args(request, clothesName, ..)")
	public void adminAdvice(HttpServletRequest request, String clothesName) {}
	
	@AfterReturning("adminAdvice(request, clothesName)")
	public void deleteAndUploadAdvice(JoinPoint joinPoint, HttpServletRequest request, String clothesName) {
		
		String methodName = joinPoint.getSignature().getName();
		String username = (String) request.getSession().getAttribute("username");
		
		System.out.println("User [ " + username + " ] invoke [ " + methodName + " ] , "
				+ "The ClothesName [ " + clothesName + " ] , Time: [ " + new Date() + " ] " );
	}
	
}
