<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>달력</title>

<!-- favicon 설정 -->
<link rel="shortcut icon" href="http://192.168.10.83/jsp_prj/common/images/favicon.ico"/>
<!-- bootstrap CDN -->
<link rel="stylesheet" type="text/css"
href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css">
 <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@docsearch/css@3">
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

<style type="text/css">
  #container{ min-height: 600px; margin-top: 30px; margin-left: 20px}
  table { width: 100%; text-align: center; }
  th, td { padding: 10px; }
  td { border: 1px solid #ddd; }
  th { background-color: #f8f9fa; }
</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script> 
</head>
<body>
<header data-bs-theme="dark">
  <div class="collapse text-bg-dark" id="navbarHeader">
    <div class="container">
      <div class="row">
        <div class="col-sm-8 col-md-7 py-4">
          <h4>달력</h4>
        </div>
        <div class="col-sm-4 offset-md-1 py-4">
          <h4>Contact</h4>
          <ul class="list-unstyled">
            <li><a href="https://google.com" class="text-white">구글에서 찾기</a></li>
            <li><a href="https://chatgpt.com/" class="text-white">지피티 찾기</a></li>
          </ul>
        </div>
      </div>
    </div>
  </div>
  <div class="navbar navbar-dark bg-dark shadow-sm">
    <div class="container">
      <a href="index.jsp" class="navbar-brand d-flex align-items-center">
        <strong>달력</strong>
      </a>
    </div>
  </div>
</header>

<main>
  <div id="container">
    <h2><%= Calendar.getInstance().get(Calendar.YEAR) %>년 <%= Calendar.getInstance().get(Calendar.MONTH) + 1 %>월</h2>
    <table class="table table-bordered">
      <thead>
        <tr>
          <th>일</th>
          <th>월</th>
          <th>화</th>
          <th>수</th>
          <th>목</th>
          <th>금</th>
          <th>토</th>
        </tr>
      </thead>
      <tbody>
        <%
          // 현재 날짜를 가져옵니다.
          Calendar cal = Calendar.getInstance();
          int year = cal.get(Calendar.YEAR);
          int month = cal.get(Calendar.MONTH);
          int dayOfMonth = cal.get(Calendar.DAY_OF_MONTH);

          // 해당 월의 첫째 날과 마지막 날을 구합니다.
          cal.set(year, month, 1);
          int firstDayOfWeek = cal.get(Calendar.DAY_OF_WEEK); // 해당 월의 첫 날 요일
          int lastDate = cal.getActualMaximum(Calendar.DAY_OF_MONTH); // 해당 월의 마지막 날짜

          // 첫 날이 일요일인 경우, firstDayOfWeek 값은 1이 됩니다.
          int rowCount = (firstDayOfWeek + lastDate - 1) / 7 + 1; // 전체 주의 개수 계산

          int day = 1; // 1일부터 시작

          // 각 주에 맞게 날짜를 출력
          for (int row = 0; row < rowCount; row++) {
            out.print("<tr>");
            for (int col = 0; col < 7; col++) {
              if (row == 0 && col < firstDayOfWeek - 1) {
                out.print("<td></td>"); // 첫 번째 주의 공백 처리
              } else if (day <= lastDate) {
                out.print("<td>" + day + "</td>");
                day++;
              } else {
                out.print("<td></td>"); // 마지막 주의 공백 처리
              }
            }
            out.print("</tr>");
          }
        %>
      </tbody>
    </table>
  </div>
</main>

<footer class="text-body-secondary py-5">
  <div class="container">
    <p class="float-end mb-1">
      <a href="#">Back to top</a>
    </p>
    <p class="mb-1"><strong style="font-size: 18px">2강의실</strong> 서울특별시 강남구 테헤란로 132(역삼동) 한독약품빌딩 8층 쌍용교육센터 <strong>Tel_02-3482-4632~5</strong> </p>
  </div>
</footer>

</body>
</html>
