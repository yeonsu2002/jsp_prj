<%@page import="xml0528.CreateDeptXML"%>
<%@ page language="java" contentType="application/xml; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"
    info=""%>
<%
	String flag=request.getParameter("flag");
	CreateDeptXML cdXML=new CreateDeptXML();
	if(flag==null){
		cdXML.webBrowserOutput(out);
	}else{
		cdXML.createDeptFile();
		%>
<?xml version="1.0" encoding ="UTF-8"?>
<root>
<url>http://localhost/jsp_prj/xml0528/db_dept.xml</url>
</root>		
		<%
	}

%>