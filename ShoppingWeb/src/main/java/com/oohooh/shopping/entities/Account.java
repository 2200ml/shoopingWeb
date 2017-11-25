package com.oohooh.shopping.entities;

import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Past;
import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.format.annotation.DateTimeFormat;

@Table(name = "Account")
@Entity
public class Account {

	private Integer id;

	@Pattern(regexp = "^[a-z0-9_-]{6,16}$", message = "username �����O 6~16 �� �^��Ʀr")
	@NotEmpty(message = "����ť�")
	private String username;

	@Email(message = "Email�榡�����T")
	@NotEmpty(message = "����ť�")
	private String email;

	@Pattern(regexp = "^[a-z0-9_-]{6,255}$", message = "password �����O 6~16 �� �^��Ʀr")
	@NotEmpty(message = "����ť�")
	private String password;

	private String confirmPassword;

	//@DateTimeFormat �N�����ǹL�Ӫ��r���ର���w�榡��Date����
	@DateTimeFormat(pattern = "dd-MM-yyyy")
	@Past
	@NotNull(message = "�п��")
	private Date birth;

	private String gender;

	private Date createTime;

	private String salt;

	private String role;

	private AccountBalance accountBalance;

	@JoinColumn(name = "balance_id", unique = true)
//	�K�[(cascade = { CascadeType.ALL })�ѨM object references an unsaved transient instance - save the transient instance beforeQuery flushing ���~
	@OneToOne(cascade = { CascadeType.ALL })
	public AccountBalance getAccountBalance() {
		return accountBalance;
	}

	public void setAccountBalance(AccountBalance accountBalance) {
		this.accountBalance = accountBalance;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getSalt() {
		return salt;
	}

	public void setSalt(String salt) {
		this.salt = salt;
	}

	@GeneratedValue
	@Id
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	//@Temporal ���w����b�ƾڮw���x�s���榡
	@Temporal(TemporalType.DATE)
	public Date getBirth() {
		return birth;
	}

	public void setBirth(Date birth) {
		this.birth = birth;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "Create_Time")
	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	@Transient
	public String getConfirmPassword() {
		return confirmPassword;
	}

	public void setConfirmPassword(String confirmPassword) {
		this.confirmPassword = confirmPassword;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

}
