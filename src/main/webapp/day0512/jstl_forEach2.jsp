<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../common/jsp/external_file.jsp"/>

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
<jsp:include page="../common/jsp/header.jsp"/>
</header>
<main>
<div id="container">
<%
//1. 배열 생성 
String[] names={"이장훈","박인배", "양준수","이호빈","주현석"};
//2. scope 객체 저장=> EL에서 사용할 수 있음.
pageContext.setAttribute("names", names);
%>
<!-- 3.출력  -->
<ul>
<c:forEach var="name" items="${names }" varStatus="i">
<li>
<c:out value="${i.index } ${i.count } ${i.first } ${i.last }"></c:out>
<c:out value="${name }"></c:out>
</li>
<c:if test="${i.last }">
총: <c:out value="${i.count }"/>명
</c:if>
</c:forEach>
</ul>
<a href="jstl_forEach2.jsp?name=kim&name=park&name=choi">요청</a>
<div>
<c:forEach var="name" items="${paramValues.name }" varStatus="i">
<c:out value="${i.count }"/>
<input type="radio" name="name" value="${name}"/><c:out value="${name}"/>
</c:forEach>
</div>
</div>
</main>
<footer class="text-body-secondary py-5">
<jsp:include page="../common/jsp/footer.jsp"/>  
</footer>


</body>
</html>