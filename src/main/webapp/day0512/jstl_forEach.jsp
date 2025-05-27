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
<select>
<option value="none">---선택---</option>
<c:forEach var="i" begin="1" end="100" step="1">
<option value="${i}"><c:out value="${i}"/></option>
</c:forEach>
</select>

<%-- forEach로 인덱스를 사용할 때에는 증가하는 값만 가능: error 
<c:forEach var="i" begin="10" end="0" step="-1">
<c:out value="$[i]"/>
</c:forEach> --%>

</div>
</main>
<footer class="text-body-secondary py-5">
<jsp:include page="../common/jsp/footer.jsp"/>  
</footer>


</body>
</html>