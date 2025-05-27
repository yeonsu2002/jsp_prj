<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<%@ include file="../common/jsp/site_config.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${ site_name }</title>
<c:import url="${url }/common/jsp/external_file.jsp"/>
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
<c:import url="${url }/common/jsp/header.jsp"/>
</header>
<main>
<div id="container">
<%-- <c:out value="${url }"/><br>
<c:out value="${uploadURL }"/><br>
<c:out value="${logo }"/><br>
<c:out value="${site_name }"/><br> --%>

</div>
</main>
<footer class="text-body-secondary py-5">
<c:import url="${ url }/common/jsp/footer.jsp"/>  
</footer>


</body>
</html>