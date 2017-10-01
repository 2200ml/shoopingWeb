package com.oohooh.shopping.entities;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

@JsonIdentityInfo(generator = ObjectIdGenerators.IntSequenceGenerator.class)
@Table(name = "Trade")
@Entity
public class Trade {

	private Integer tradeId;
	private Date tradeTime;
	private float tradeMoney;
	private Account account;
	private Set<TradeItem> tradeItems = new HashSet<>();

	@Column(name="Trade_Money")
	public float getTradeMoney() {
		return tradeMoney;
	}

	public void setTradeMoney(float tradeMoney) {
		this.tradeMoney = tradeMoney;
	}

	@GeneratedValue
	@Id
	public Integer getTradeId() {
		return tradeId;
	}

	public void setTradeId(Integer tradeId) {
		this.tradeId = tradeId;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "Trade_Time")
	public Date getTradeTime() {
		return tradeTime;
	}

	public void setTradeTime(Date tradeTime) {
		this.tradeTime = tradeTime;
	}

	@OneToMany(mappedBy = "trade")
	public Set<TradeItem> getTradeItems() {
		return tradeItems;
	}

	public void setTradeItems(Set<TradeItem> tradeItems) {
		this.tradeItems = tradeItems;
	}

	@JoinColumn(name = "Account_id")
	@ManyToOne
	public Account getAccount() {
		return account;
	}

	public void setAccount(Account account) {
		this.account = account;
	}

}
