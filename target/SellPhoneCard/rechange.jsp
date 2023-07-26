<%--
  Created by IntelliJ IDEA.
  User: nghia
  Date: 7/6/23
  Time: 3:00 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Rechange</title>
    <link href="${pageContext.request.contextPath}/assets/css/light-bootstrap-dashboard.css?v=2.0.0 "
          rel="stylesheet"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
    <style>
        input::-webkit-outer-spin-button,
        input::-webkit-inner-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }

        /* Firefox */
        input[type=number] {
            -moz-appearance: textfield;
        }

        .wave-group {
            position: relative;
        }

        .wave-group .input {
            font-size: 16px;
            padding: 10px 10px 10px 5px;
            display: block;
            width: 200px;
            border: none;
            border-bottom: 1px solid #515151;
            background: transparent;
        }

        .wave-group .input:focus {
            outline: none;
        }

        .wave-group .label {
            color: #999;
            font-size: 18px;
            font-weight: normal;
            position: absolute;
            pointer-events: none;
            left: 5px;
            top: 10px;
            display: flex;
        }

        .wave-group .label-char {
            transition: 0.2s ease all;
            transition-delay: calc(var(--index) * .05s);
        }

        .wave-group .input:focus ~ label .label-char,
        .wave-group .input:valid ~ label .label-char {
            transform: translateY(-20px);
            font-size: 14px;
            color: #5264AE;
        }

        .wave-group .bar {
            position: relative;
            display: block;
            width: 200px;
        }

        .wave-group .bar:before, .wave-group .bar:after {
            content: '';
            height: 2px;
            width: 0;
            bottom: 1px;
            position: absolute;
            background: #5264AE;
            transition: 0.2s ease all;
            -moz-transition: 0.2s ease all;
            -webkit-transition: 0.2s ease all;
        }

        .wave-group .bar:before {
            left: 50%;
        }

        .wave-group .bar:after {
            right: 50%;
        }

        .wave-group .input:focus ~ .bar:before,
        .wave-group .input:focus ~ .bar:after {
            width: 50%;
        }

        input::-webkit-outer-spin-button,
        input::-webkit-inner-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }

        /* Firefox */
        input[type=number] {
            -moz-appearance: textfield;
        }
    </style>
</head>
<body>
<header style="height: fit-content">
    <div class="menu" style="height: 60px;">
        <nav class="nav-header">
            <div class="header1">
                <ul>
                    <li><a href="/">Trang chủ</a></li>
                    <li><a href="${(user != null ) ? "order" : "login"}">Đơn hàng</a></li>
                    <li><a href="${(user != null ) ? "transaction" : "login"}">Giao dịch</a></li>
                    <li><a href="contact.jsp">Liên hệ</a></li>
                    <li><a href="${(user != null ) ? "rechange" : "login"}">Nạp tiền</a></li>
                    <c:if test="${user != null}">
                        <li><span style="color: #ffffff;font-size: 20px;line-height: 60px">Số dư: <span
                                id="balanceValue">${user.getBalance()}</span></span></li>
                    </c:if>
                    <c:if test="${user != null}">
                        <li><a href="#" style="height: 100%;"><i style="margin-top: 18px"
                                                                 class="fa-solid fa-circle-user"></i></a>
                            <ul>
                                <li><a href="changeProfile">Thông tin người dùng</a></li>
                                <li><a href="login">Đăng xuất</a></li>
                            </ul>
                        </li>
                    </c:if>
                    <c:if test="${user == null}">
                        <li><a href="login">Đăng nhập</a></li>
                    </c:if>
                </ul>
            </div>
        </nav>
    </div>
</header>
<div class="container justify-content-center d-flex" style="margin-top: 100px;">
    <div class="w-75 content border-dark border"
         style="border-radius: 10px;box-shadow: 0 5px 10px #5e5e5e;padding: 20px;">
        <div class="row text-center justify-content-center"
             style="background-color: #55b3f7;padding: 30px 0;margin-bottom: 20px">
            <h2 style="color: #ffffff;text-align: center;">Nạp tiền</h2>
        </div>
        <div class="row justify-content-center">
            <div class="row w-100 justify-content-center">
                <div class="wave-group" style="width: fit-content">
                    <label class="label">
                        Tài khoản
                    </label> <br>
                    <input readonly required="" type="text" class="input" value="${user.getAccount()}">
                    <span class="bar"></span>
                </div>
            </div>
            <div class="row w-100 justify-content-center" style="margin-top: 30px;">
                <div class="wave-group" style="width: fit-content">
                    <input id="amountInput" required="" type="number" class="input">
                    <span class="bar"></span>
                    <label class="label">
                        <span class="label-char" style="--index: 0">S</span>
                        <span class="label-char" style="--index: 1">ố</span>
                        <span class="label-char" style="--index: 2">&nbsp;</span>
                        <span class="label-char" style="--index: 3">t</span>
                        <span class="label-char" style="--index: 4">i</span>
                        <span class="label-char" style="--index: 5">ề</span>
                        <span class="label-char" style="--index: 6">n</span>
                    </label>
                </div>
            </div>
            <div class="w-100">
                <p id="money"
                   style="color: #757575;font-size: 0.9em;margin-bottom: 0px;margin-top: 5px;text-align: center"></p>
            </div>
            <div class="w-100">
                <p id="warning" style="color: #ff2929;margin-bottom: 0px;margin-top: 5px;text-align: center"></p>
            </div>
            <div class="row w-100 justify-content-center d-flex" style="height: fit-content;margin-top: 20px;">
                <button id="rechange-btn" name="option" value="buy" type="button" class="btn"
                        style="cursor: pointer;background-color: #1ca799;border-radius: 10px; color: #ffffff;font-weight: 500;line-height: 36px;padding: 9px 31px;text-align: center">
                    Nạp vào ví
                </button>
            </div>
        </div>
    </div>
</div>
<footer class="footer container-fluid"
        style="background-color: #000000;margin-top: 40px;position: absolute;bottom: 0px;">
    <div class="container-fluid">
        <nav>
            <ul class="footer-menu">
                <li>
                    <a href="#">
                        Home
                    </a>
                </li>
                <li>
                    <a href="#">
                        Company
                    </a>
                </li>
                <li>
                    <a href="#">
                        Portfolio
                    </a>
                </li>
                <li>
                    <a href="#">
                        Blog
                    </a>
                </li>
            </ul>
            <p class="copyright text-center">
                ©
                <script>
                    document.write(new Date().getFullYear())
                </script>
                SWP391 Group5, made with love for a better web
            </p>
        </nav>
    </div>
</footer>
</body>
<script src="${pageContext.request.contextPath}/js/readMoney.js"></script>
<script>
    var readMoney = new DocTienBangChu();
    $("#amountInput").on('input', () => {
        var amount = $("#amountInput").val();
        $("#money").text(readMoney.doc(amount));
        $("#amountInput").val(amount);
    });
    $("#rechange-btn").click(() => {
        var amount = $("#amountInput").val();
        amount = amount.replaceAll(',', '');

        if (amount == "" || parseInt(amount) < 5000 || parseInt(amount) > 20000000) {
            $("#warning").text("Số tiền lớn hơn 5 nghìn và không quá 20 triệu");
        } else {
            $.ajax({
                url: "/api/v1/payment",
                type: "POST",
                data: {
                    "ordertype": "pay",
                    "amount": amount
                },
                dataType: "json",
                success: function (response) {
                    document.location.href = response.data;
                    demo.showNotify(response.message);
                }
            });
        }

    });
    <c:if test="${user != null}">
    document.getElementById("balanceValue").innerText = parseInt(document.getElementById("balanceValue").innerText).toLocaleString();
    </c:if>
</script>

<script src="${pageContext.request.contextPath}/assets/js/core/popper.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/assets/js/core/bootstrap.min.js" type="text/javascript"></script>
<!--  Plugin for Switches, full documentation here: http://www.jque.re/plugins/version3/bootstrap.switch/ -->
<script src="${pageContext.request.contextPath}/assets/js/plugins/bootstrap-switch.js"></script>
<!--  Google Maps Plugin    -->
<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=YOUR_KEY_HERE"></script>
<!--  Chartist Plugin  -->
<script src="${pageContext.request.contextPath}/assets/js/plugins/chartist.min.js"></script>
<!--  Notifications Plugin    -->
<script src="${pageContext.request.contextPath}/assets/js/plugins/bootstrap-notify.js"></script>
<!-- Control Center for Light Bootstrap Dashboard: scripts for the example pages etc -->
<script src="${pageContext.request.contextPath}/assets/js/light-bootstrap-dashboard.js?v=2.0.0 "
        type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/assets/js/demo.js"></script>
</html>
