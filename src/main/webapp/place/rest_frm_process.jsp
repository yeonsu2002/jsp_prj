<%@page import="kr.co.sist.place.PlaceService"%>
<%@page import="java.util.Random"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info=""%>
<%@ include file="../common/jsp/site_config.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../common/jsp/login_chk.jsp"%><!-- 로그인 체크 -->
<%-- <%
LoginResultDTO ld=new LoginResultDTO();
ld.setId(new Random().nextBoolean()?"zoo1234": "kim1234");
session.setAttribute("userData", ld);
%> --%>
<%
request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="rDTO" class="kr.co.sist.place.RestDTO"
	scope="page" />
<jsp:setProperty name="rDTO" property="*" />
<%
//useBean으로 입력되는 파라미터는  subject content만 존재 
rDTO.setId(((LoginResultDTO) session.getAttribute("userData")).getId());
rDTO.setIp(request.getRemoteAddr());

PlaceService ps = new PlaceService();
pageContext.setAttribute("writeFlag", ps.addRestaurant(rDTO));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><c:out value="${ site_name }" /></title>

<script type="text/javascript">
	<c:choose>
	<c:when test="${ writeFlag }">
	alert("글쓰기 완료");
	location.href = "${ url }/place/restaurant_list.jsp";
	</c:when>
	<c:otherwise>
	alert("글쓰기 실패");
	history.back();
	</c:otherwise>
	</c:choose>
</script>

</head>
<body>

</body>
</html>