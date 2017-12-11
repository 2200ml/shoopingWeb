package com.oohooh.shopping.aop;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;

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
