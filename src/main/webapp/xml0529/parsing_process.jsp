<%@page import="xml0529.RssVO"%>
<%@page import="xml0529.ParsingRSS"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<%@ include file="../common/jsp/site_config.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String paramUrl=request.getParameter("url");
ParsingRSS pRss=new ParsingRSS();
RssVO rVO=pRss.parsing(paramUrl);
pageContext.setAttribute("rVO", rVO);
%>
<%-- <%=paramUrl %> --%>
<div id="newsInfo">
<ul>
	<li><h3><c:out value="${rVO.title}"/></h3></li>
	<li>작성일 : <c:out value="${rVO.pubDate}"/></li>
</ul>
</div>
<div id="newscontent">
<c:if test="${ empty rVO.itemList }" >
<strong>준비된 기사가 없습니다.</strong>
</c:if>
<c:if test="${ not empty rVO.itemList }" >
<c:forEach var="item" items="${ rVO.itemList}" varStatus="i">
<table>
<tr>
	<td style="width: 5%"><c:out value="${ i.count }"/>번호</td>
	<td style="width: 75%"><a href="${ item.link }"><c:out value="${ item.title }"/></a></td>
	<td style="width: 20%"><c:out value="${ item.pubDate }"/></td>
</tr>
<tr>
	<td colspan="3">
	<div style="width:100%; height: 50px; overflow: auto">
	<c:out value="${ item.description }"/></div>
	</td>
</tr>
</table>
</c:forEach>
</c:if>
</div>