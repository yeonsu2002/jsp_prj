<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<%@ include file="../common/jsp/site_config.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><c:out value="${ site_name }" /></title>

<c:import url="${ url }/common/jsp/external_file.jsp" />


<style type="text/css">
 #container{ min-height: 600px; margin-top: 30px; margin-left: 20px}

</style>

<script type="text/javascript">
$(function(){
	$("#btn").click(function(){
		$.ajax({
			url:"../xml0527/hello.xml",
			type:"GET",
			
			dataType="XML",
			error:function(xhr){
				$("#output").html("<strong>문제발생 잠시후 다시시도</strong>");
				console.log(xhr.status);
			},
			success:function(xmlDoc){
				//파싱
				//1.parsing 할 노드 찾기
				var msgNode=$(xmlDoc).find("msg");
				var msg=msgNode.text();
				$("output").html("<strong>"+msg+"</strong>");
			}
			
		});//ajax
	});
	
	
}); // ready
</script>

</head>
<body>
<header data-bs-theme="dark">

<c:import url="${ url }/common/jsp/header.jsp" />

</header>
<main>
<div id="container">
<input type="button" value="반복 node parsing" id="btn" class="btn btn-success"/>
<div id="output"></div>

</div>
</main>
<footer class="text-body-secondary py-5">
<c:import url="${ url }/common/jsp/footer.jsp" />
</footer>
</body>
</html>