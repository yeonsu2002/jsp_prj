<%@page import="kr.co.sist.member.login.LoginResultDTO"%>
<%@page import="kr.co.sist.member.login.LoginDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    %>
    
<%
//세션에 존재하는 값 얻기
Object obj=session.getAttribute("userData");
if(obj==null){
	//세션에 값이 없다면 페이지를 이동.
	response.sendRedirect("http://192.168.10.83/jsp_prj/index.html");
	return;
}
LoginResultDTO lDTO = (LoginResultDTO)obj;
%>