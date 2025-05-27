<%@page import="kr.co.sist.board.PageNationDTO"%>
<%@page import="kr.co.sist.board.BoardUtil"%>
<%@page import="kr.co.sist.place.RestDTO"%>
<%@page import="kr.co.sist.place.PlaceService"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<%@ include file="../common/jsp/site_config.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="rDTO" class="kr.co.sist.board.RangeDTO" scope="page" />
<jsp:setProperty name="rDTO" property="*" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><c:out value="${ site_name }" /></title>

<c:import url="${ url }/common/jsp/external_file.jsp" />


<style type="text/css">
 #container{ min-height: 600px; margin-top: 30px; margin-left: 20px; }
 a { text-decoration: none; color: #333; }
 a:hover { color: #5A90D0; }
 
 .pagiPrevMark { color: #FF0000; }
 .pagiNextMark { color: #FF0000; }
 .pagiCurrent { font-weight: bold; font-size: 20px; }
 .pagiNotCurrent { font-weight: normal; }
</style>

<script type="text/javascript">
$(function(){
	
	$("#btnSearch").click(function(){
		var keyword = $("#keyword").val();
		
		if(keyword == ""){
			alert("검색 키워드는 필수 입력");
			//early return
			return;
		} //end if
		
	}); //click
	
}); // ready
</script>

</head>
<body>
<header data-bs-theme="dark">

<c:import url="${ url }/common/jsp/header.jsp" />

</header>
<main>
<div id="container">
<%
PlaceService ps = new PlaceService();
// 총 게시물의 수
int totalCount = 0;
totalCount = ps.totalCount(rDTO);

// 한 화면에 출력할 게시물의 수
int pageScale = 0;
pageScale = ps.pageScale();

// 총 페이지의 수
int totalPage = 0;
totalPage = ps.totalPage(totalCount, pageScale);
// 0,1,2,3,4,5,6,7,8,9
/*
if(totalCnt%pageScale != 0){
	// 나머지가 존재하는 수
	// 16/10=1+1(나머지 6개의 글을 보여주기위한 페이지)
	totalPage++;
} //end if
*/

// 현재 페이지 숫자
/* String tempPage = request.getParameter("currentPage");
System.out.println( "현재 페이지 숫자 : "+tempPage ); */

// 페이지 게시물 시작 번호
int startNum;
startNum = ps.startNum(pageScale, rDTO);

// 페이지 게시물 끝 번호
int endNum;
endNum = ps.endNum(pageScale, rDTO);

// 게시물 리스트
List<RestDTO> restList = ps.searchAllRestaurant(rDTO);

System.out.println("총 페이지 수 : "+totalPage);
pageContext.setAttribute("totalCount", totalCount);
pageContext.setAttribute("pageScale", pageScale);
pageContext.setAttribute("totalPage", totalPage);
pageContext.setAttribute("startNum", rDTO.getStartNum());
pageContext.setAttribute("endNum", rDTO.getEndNum());
pageContext.setAttribute("restList", restList);
pageContext.setAttribute("fieldText", rDTO.getFieldText());

%>
맛집 전체 <c:out value="${ totalPage }" />건

	<div style="text-align: right;">
		<a href="rest_write_frm.jsp" class="btn btn-info btn-sm">맛집 추가</a>
	</div>
		
	<table class="table table-hover">
		<thead>
			<tr style="text-align: center;">
				<th style="width: 80px;">번호</th>
				<th style="width: 350px;">식당명</th>
				<th style="width: 320px;">메인 메뉴</th>
				<th style="width: 100px;">작성자</th>
				<th style="width: 200px;">작성일</th>
			</tr>
		</thead>
		<tbody>
		<c:if test="${ empty restList }">
			<tr>
				<td colspan="5" style="text-align: center;">
					등록된 맛집이 없습니다.<br>
					<img src="../login/images/login_fail.jpg" style="width: 60px;" />
					<br>
					<a href="rest_write_frm.jsp">맛집 등록</a>
				</td>
			</tr>
		</c:if>
		<c:forEach var="restDTO" items="${ restList }" varStatus="i">
			<tr>
				<td><c:out value="${ totalCount-(rDTO.currentPage-1)*pageScale-i.index }" /></td>
				<td><a href="rest_detail.jsp?num=${ restDTO.rest_num }&currentPage=${ rDTO.currentPage }${ queryStr }"><c:out value="${ restDTO.restaurant }" /></a></td>
				<td><c:out value="${ restDTO.menu }" /></td>
				<td><c:out value="${ restDTO.id }" /></td>
				<td><fmt:formatDate value="${ restDTO.input_date }"
					pattern="yyyy-MM-dd a HH:mm:ss" /></td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</div>

<div id="searchDiv" style="text-align: center;">
	<form action="restaurant_list.jsp" id="searchFrm" method="get">
		<select name="field" id="field">
			<c:forEach var="field" items="${ fieldText }" varStatus="i">
			<option value="${ i.index }">
				<c:out value="${ field }" />
			</option>
			</c:forEach>
		</select>
		<input type="text" name="keyword" id="keyword" />
		<input type="text" style="display:none;" />
		<input type="button" value="검색" id="btnSearch" class="btn btn-success btn-sm" />
	</form>
</div>
	
<%-- 
<div id="paginationDiv">
	<c:forEach var="i" begin="1" end="${ totalPage }" step="1">
		[<a href="board_list.jsp?currentPage=${ i }"><c:out value="${ i }" /></a>]
	</c:forEach>
</div> --%>
	
<div id="paginationDiv" style="text-align: center;">
<%
PageNationDTO pDTO = new PageNationDTO(3, rDTO.getCurrentPage(), totalPage, "rest_list.jsp",
		rDTO.getField(), rDTO.getKeyword());
%>
<%= BoardUtil.pagination(pDTO) %>
</div>

</main>

<footer class="text-body-secondary py-5">

<c:import url="${ url }/common/jsp/footer.jsp" />

</footer>


</body>
</html>