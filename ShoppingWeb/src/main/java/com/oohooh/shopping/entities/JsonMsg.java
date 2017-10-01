package com.oohooh.shopping.entities;

import java.util.HashMap;
import java.util.Map;

public class JsonMsg {

	private int code;
	private String msg;
	private Map<String, Object> jsonObject = new HashMap<>();

	public int getCode() {
		return code;
	}

	public void setCode(int code) {
		this.code = code;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public Map<String, Object> getJsonObject() {
		return jsonObject;
	}

	public void setJsonObject(Map<String, Object> jsonObject) {
		this.jsonObject = jsonObject;
	}

	public static JsonMsg success() {
		JsonMsg result = new JsonMsg();
		result.setCode(100);
		result.setMsg("Success !!");
		return result;
	}
	
	public static JsonMsg fail() {
		JsonMsg result = new JsonMsg();
		result.setCode(200);
		result.setMsg("Fail !!");
		return result;
	}
	
	public JsonMsg add(String key, Object value) {
		this.getJsonObject().put(key, value);
		return this;
	}
	
}
