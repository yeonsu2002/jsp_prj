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

<!-- guest, user, admin
guest- 읽기
user- 읽기, 쓰기
user- 읽기, 쓰기, 삭제
-->

<table class="table table-hover">
<thead>
<tr>
	<th>번호</th>
	<th>이름</th>
</tr>
</thead>
<tbody>
<tr>
	<th>1</th>
	<th>일장훈</th>
</tr>
<tr>
	<th>2</th>
	<th>이장훈</th>
</tr>
<tr>
	<th>3</th>
	<th>삼장훈</th>
</tr>

</tbody>
</table>
<c:choose>
<c:when test="${param.role eq 'u' }">
<button class="btn btn-success">읽기</button>
<button class="btn btn-info">쓰기</button>
</c:when>
<c:when test="${param.role eq 'a' }">
<button class="btn btn-success">읽기</button>
<button class="btn btn-info">쓰기</button>
<button class="btn btn-danger">삭제</button>
</c:when>
<c:otherwise>
<button class="btn btn-success">읽기</button>
</c:otherwise>
</c:choose>


<a href="jstl_choose.jsp?role=g">손님</a>
<a href="jstl_choose.jsp?role=u">사용자</a>
<a href="jstl_choose.jsp?role=a">관리자</a>

</div>
</main>
<footer class="text-body-secondary py-5">
<jsp:include page="../common/jsp/footer.jsp"/>  
</footer>


</body>
</html>