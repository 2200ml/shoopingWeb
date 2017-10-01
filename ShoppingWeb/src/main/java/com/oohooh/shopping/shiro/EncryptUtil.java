package com.oohooh.shopping.shiro;

import org.apache.shiro.crypto.SecureRandomNumberGenerator;
import org.apache.shiro.crypto.hash.SimpleHash;

import com.oohooh.shopping.entities.Account;

public class EncryptUtil {

	private static String algorithmName = "MD5";
	
	private static int hashIterations = 1024;
	
	public static Account EncryptAccount(Account account) {
		
		SecureRandomNumberGenerator secureRandomNumberGenerator = new SecureRandomNumberGenerator();
		
		String salt = account.getUsername() + secureRandomNumberGenerator.nextBytes().toHex();
		
		String password = new SimpleHash(algorithmName, account.getPassword(), salt, hashIterations).toHex();
		
		account.setSalt(salt);
		
		account.setPassword(password);
		
		return account;
	}
	
}
