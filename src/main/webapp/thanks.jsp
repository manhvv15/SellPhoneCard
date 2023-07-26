<%--
  Created by IntelliJ IDEA.
  User: nghia
  Date: 7/6/23
  Time: 11:03 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanks</title>
    <link href="${pageContext.request.contextPath}/assets/css/light-bootstrap-dashboard.css?v=2.0.0 "
          rel="stylesheet"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
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
<div class="container" style="margin-top: 300px;">
    <div class="row justify-content-center">
        <h2>Giao dịch hoàn tất-Nạp tiền thành công</h2>
    </div>
    <div class="row justify-content-center">
        <h3>Cảm ơn vì đã tin tưởng chúng tôi</h3><h3>Giờ bạn có thể đóng tab này và tải lại trang web để xem những thay đổi</h3>
    </div>
</div>
<footer class="footer container-fluid" style="background-color: #000000;margin-top: 40px;position: absolute;bottom: 0px;">
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
<script>
    $(document).ready(() => {
        $.ajax({
            url: "/api/v1/depositMoney",
            type: "POST",
            success: function (response) {

            }
        });
    });
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
