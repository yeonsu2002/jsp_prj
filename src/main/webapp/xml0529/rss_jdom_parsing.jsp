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
ol,ul,li{display: none}
</style>

<script type="text/javascript">
$(function(){
}); // ready
</script>

</head>
<body>
<header data-bs-theme="dark">

<c:import url="${ url }/common/jsp/header.jsp" />

</header>
<main>
<div id="container">
<div id="jtbcRssWrap">
<div id="jtbcRssHeader">
<%
String[] link={"issue","section/10","section/20","section/30","section/40","section/50","section/60","section/70","section/80"};
String[] title={"이슈", "정치","경제","사회","국제","문화", "연예","스포츠","날씨"};

%>
<table class="table">
<tr>
<%for(int i=0; i<link.length; i++){%>
<td><a href="rss_jdom_parsing.jsp?url=<%=link[i]%>"><%=title[i] %></a></td>

<%} %>


</tr>
</table>
</div>
<div id="jtbcRssContainer">
<c:if test="${ not empty param.url}">
<c:import url="parsing_process.jsp"/>
</c:if>
</div>
</div>
</div>

</main>

<footer class="text-body-secondary py-5">

<c:import url="${ url }/common/jsp/footer.jsp" />

</footer>


</body>
</html>