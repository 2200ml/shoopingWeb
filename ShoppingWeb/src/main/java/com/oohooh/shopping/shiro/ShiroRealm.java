package com.oohooh.shopping.shiro;

import java.util.HashSet;
import java.util.Set;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;

import com.oohooh.shopping.entities.Account;
import com.oohooh.shopping.service.AccountService;

public class ShiroRealm extends AuthorizingRealm {

	@Autowired
	AccountService accountService;
	
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
		
		UsernamePasswordToken UPToken = (UsernamePasswordToken) token;
		String username = UPToken.getUsername();
		
		Account authcAccount = accountService.getByUsername(username);
		
		if(authcAccount == null) {
			throw new UnknownAccountException();
		}
		
		Object principal = username;
		Object hashedCredentials = authcAccount.getPassword();
		String realmName = this.getName();
		
		String salt = authcAccount.getSalt();
		ByteSource credentialsSalt = ByteSource.Util.bytes(salt);
		
		SimpleAuthenticationInfo info = new SimpleAuthenticationInfo(principal, hashedCredentials, credentialsSalt, realmName);
		
		return info;
	}

	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
		String username = (String) principals.getPrimaryPrincipal();
		Set<String> roles = new HashSet<String>();
		
		Account authrAccount = accountService.getByUsername(username);
		String[] userRoles = authrAccount.getRole().split(",");

		for(String role : userRoles) {
			roles.add(role);
		}
		
		SimpleAuthorizationInfo info = new SimpleAuthorizationInfo(roles);
		
		return info;
	}
}
