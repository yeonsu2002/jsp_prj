<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="로그아웃"
    %>
    
  <%-- <%@ include file="../common/jsp/login_chk.jsp"%> --%>
   
<%
	session.removeAttribute("name");//세션은 살아있고 값만 삭제
	session.invalidate();//세션 자체 무효화
	response.sendRedirect("use_session_a.jsp");
	
	/* out.println(session.getAttribute("connectTime"));
	out.println(session.getAttribute("ip"));
	out.println(session.getAttribute("name")); */
	
%>
<!-- <meta http-equiv="refresh" content="0; use_sessiona.jsp"> -->
<!-- <script type="text/javascript">
	alert("로그아웃 하셨음");
	location.href="use_session_a.jsp";

</script> -->