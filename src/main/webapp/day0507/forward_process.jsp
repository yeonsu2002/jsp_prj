<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="분기"%>
 
 <%
 request.setCharacterEncoding("UTF-8");//생성하는 parameter에 한글이
 //포함되어있다면 요청시에 charset를 변경하여 전송한다.
 String serverName=request.getServerName();
 String movePage="eng.jsp";
 String lang="english";
 
 
 //scope객체에 속성을 설정하여 값을 전달할 수 있다.
 request.setAttribute("ip", request.getRemoteAddr());
 
 if("localhost".equals(serverName)){
	 movePage="kor.jsp";
	 lang="한국어";
 }//end if
 if("192.168.10.83".equals(serverName)){
	 movePage="eng.jsp";
	 lang="영어";
 }//end if
 
 
 %>
 
<jsp:forward page="<%=movePage %>">
	<jsp:param value="<%=lang%>" name="language"/>
</jsp:forward>