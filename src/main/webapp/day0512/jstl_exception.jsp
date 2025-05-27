<%@page import="java.util.Random"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<c:import url="http://192.168.10.83/jsp_prj/common/jsp/external_file.jsp"/>
<style type="text/css">
 #container{ min-height: 600px; margin-top: 30px; margin-left: 20px}
</style>

<script type="text/javascript">
$(function(){
	
});//ready



</script>
</head>
<body>
<header data-bs-theme="dark">
<c:import url="http://192.168.10.83/jsp_prj/common/jsp/header.jsp"/>
</header>
<main>
<div id="container">
<c:catch var="e">
<% String msg="JSP Standard Tag Library"; 
	String cls="java.lang.String";
	
	if(new Random().nextBoolean()){
		cls="java.lang.String1";
	}
	Class.forName(cls);
	
%>
<%=msg %>
</c:catch>
<c:if test="${e != null }">
문제가 발생하였습니다. 잠시 후에 다시 시도
<c:out value="${e }"/>
</c:if>
</div>
</main>
<footer class="text-body-secondary py-5">
<c:import url="http://192.168.10.83/jsp_prj/common/jsp/footer.jsp"/>  
</footer>


</body>
</html>