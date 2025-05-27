<%@page import="kr.co.sist.member.MemberService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- favicon 설정 -->
<link rel="shortcut icon" href="http://192.168.10.83/html_prj/common/images/favicon.ico">
<!--site 기본 CSS -->
<link rel="stylesheet" type="text/css"
	href="http://192.168.10.83/html_prj/common/css/main_v250409.css">
<!--bootstrap CDN -->
<link rel="stylesheet" type="text/css"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css">
<style type="text/css">
	#wrap{position: relative; margin: 0px auto; width: 505px; height: 305px;}
	#background{background: #fff url("http://192.168.10.83/jsp_prj/member/images/id_background.png") no-repeat;
		width: 505px; height: 305px;}
	#inputDiv{width: 325px; position: absolute; top: 103px; left: 19px;}
	#inputDiv2 {
    width: 100%;
    position: absolute;
    top: 180px;
    left: 0;
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 10px;
  }
</style>

<!-- jquery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>

<script type="text/javascript">
$(function() {
	  // 중복확인 버튼 클릭
	  $('#btn').click(function() {
		  chkNull();
	    
	  });
	  $('#id').keydown(function(evt) {
		  if(evt.which == 13){
		  chkNull();			  
		  }
	    
	  });

	  // 사용 버튼 클릭
	  $('#btn2').click(function() {
	    const id = $('#tempId').val();
	    
	    opener.document.frm.id.value = id;
	    window.close();
	  });//click
	});//ready
	

function chkNull() {
	 const id = $('input[name="id"]').val();
	 
	    if(id.replace(/ /g,"") == ""){
	    	alert("아이디 필수 입력");
	    $('#id').val('');
	    	return;
	    }
	    $('#frm').submit();
}
</script>
</head>
<body>

<div id="wrap">
	<div id="background">
		<div id="inputDiv">
		<form action="id_dup.jsp" name="subFrm" id="frm" action="id_dup.jsp">
		<label for="id">아이디</label>
		<input type="text" name="id" id="id" autofocus="autofocus">
		<input type="text" style="display: none;"/>
		<input type="button" value="중복확인" name="btn" id="btn" class="btn btn-primary btn-sm" >
		</form>
		</div>
		
		<c:if test="${ not empty param.id }">
		<%
			String id=request.getParameter("id");
	
			MemberService ms=new MemberService();
			boolean idFlag=ms.searchId(id);
			pageContext.setAttribute("idFlag", idFlag);
			
		%>
		
		<<div id="inputDiv2">
      	<form name="subFrm2" id="subFrm2">
        	<span id="showID"><c:out value="${param.id }"/></span>는
        	사용
        	<c:set var="msg" value="가능"/>
        	<c:set var="color" value="#0000FF"/>
        	<c:if test="${ idFlag }">
        	<c:set var="color" value="#FF0000"/>
        	<c:set var="msg" value="불가능"/>
        	</c:if>
        	<span style="color:${color}"><c:out value="${ msg }"/></span>합니다.
        	<input type="hidden" value="${param.id }" name="tempId" id="tempId"/>
        	
        	<c:if test="${ not  idFlag }">
        	<input type="button" value="사용" class="btn btn-success btn-sm" id="btn2"/>
        	</c:if>
      	</form>
    	</div>
		
		</c:if>
	</div>
</div>

</body>
</html>