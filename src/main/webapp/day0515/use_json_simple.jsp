<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<%
	String name="이장훈";
	int age=25;
	
	//1. Jsonobject 생성: Map기반
	JSONObject json=new JSONObject();
	
	//2.값할당 - 입력한 값은 순서대로 추가되지 않느다. 
	json.put("name", name);
	json.put("age", age);
	
	//3. 값을 가진 JSONObject객체를 String로 얻는다.
	String jsonStr=json.toJSONString();
%>
<%=json%>