<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주민번호 유효성 검사</title>
<!-- bootstrap CDN -->
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css"/> 

<!-- jquery CDN-->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<script type="text/javascript">
$(function(){
    // 앞자리 6자 입력되면 뒷자리로 포커스 이동
    $("#number").on("keyup", function() {
        if ($(this).val().length == 6) {
            $("#number2").focus();
        }
    });

    // 엔터키 누르면 유효성 검사 실행
    $("#number2").on("keypress", function(e) {
        if (e.which === 13) {
            checkJumin();
        }
    });

    function checkJumin() {
        var jumin1 = $("#number").val();
        var jumin2 = $("#number2").val();
        var jumin = jumin1 + jumin2;

        if (jumin.length !== 13) {
            $("#result").text("주민번호는 13자리여야 합니다.").css("color", "red");
            return;
        }

        var weights = [2, 3, 4, 5, 6, 7, 8, 9, 2, 3, 4, 5];
        var sum = 0;

        for (var i = 0; i < 12; i++) {
            sum += parseInt(jumin.charAt(i)) * weights[i];
        }

        var mod = sum % 11;
        var checkDigit = (11 - mod) % 10;
        var lastDigit = parseInt(jumin.charAt(12));

        if (checkDigit === lastDigit) {
            $("#result").text("유효한 주민등록번호입니다.").css("color", "green");
        } else {
            $("#result").text("잘못된 주민등록번호입니다.").css("color", "red");
        }
    }
});
</script>
</head>
<body class="p-4">

<div class="container">
    <h3 class="mb-3">주민등록번호 유효성 검사</h3>

    <div class="mb-3">
        <label for="number" class="form-label">주민번호</label><br/>
        <input type="text" id="number" maxlength="6" class="form-control d-inline w-auto"/> -
        <input type="text" id="number2" maxlength="7" class="form-control d-inline w-auto"/>
    </div>

    <button class="btn btn-primary" onclick="checkJumin()">검사</button>

    <div class="mt-3">
        결과: <span id="result" class="fw-bold"></span>
    </div>
</div>

</body>
</html>
