<%-- 
    Document   : profile
    Created on : May 28, 2023, 8:29:07 PM
    Author     : tuana
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thay đổi thông tin người dùng</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

    <link href="${pageContext.request.contextPath}/admin/assets/css/pagination.css" rel="stylesheet">
    <link rel="apple-touch-icon" sizes="76x76"
          href="${pageContext.request.contextPath}/admin/assets/img/apple-icon.png">
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/admin/assets/img/favicon.ico">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <title>Light Bootstrap Dashboard - Free Bootstrap 4 Admin Dashboard by Creative Tim</title>
    <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no'
          name='viewport'/>
    <!--     Fonts and icons     -->
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200" rel="stylesheet"/>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css"/>
    <!-- CSS Files -->
    <link href="${pageContext.request.contextPath}/user/assets/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="${pageContext.request.contextPath}/user/assets/css/light-bootstrap-dashboard.css?v=2.0.0 "
          rel="stylesheet"/>
    <!-- CSS Just for demo purpose, don't include it in your project -->

    <link href="${pageContext.request.contextPath}/user/assets/css/demo.css" rel="stylesheet"/>
    <style>
        .profile {
            display: flex;
            justify-content: space-between;
        }

        .personal-info,
        .password-change {
            width: 45%;
            padding: 20px;
            background: #fff;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease-in-out;
        }

        .personal-info:hover,
        .password-change:hover {
            transform: translateY(-10px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
        }

        .personal-info h2,
        .password-change h2 {
            margin-top: 0;
            font-weight: 700;
            color: #333;
            text-transform: uppercase;
        }

        .personal-info form,
        .password-change form {
            display: flex;
            flex-direction: column;
        }

        .personal-info label,
        .password-change label {
            margin-bottom: 10px;
            font-weight: 600;
            color: #555;
        }

        .personal-info input[type="text"],
        .personal-info input[type="email"],
        .personal-info input[type="tel"],
        .password-change input[type="text"],
        .password-change input[type="password"] {
            padding: 10px 15px;
            font-size: 16px;
            border-radius: 5px;
            border: none;
            margin-bottom: 20px;
            background: #f7f7f7;
            transition: all 0.3s ease-in-out;
        }

        .personal-info input[type="text"]:focus,
        .personal-info input[type="email"]:focus,
        .personal-info input[type="tel"]:focus,
        .password-change input[type="text"]:focus,
        .password-change input[type="password"]:focus {
            outline: none;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.2);
            background: #f2f2f2;
        }

        .personal-info textarea {
            padding: 10px 15px;
            font-size: 16px;
            border-radius: 5px;
            border: none;
            margin-bottom: 20px;
            background: #f7f7f7;
            transition: all 0.3s ease-in-out;
        }

        .personal-info textarea:focus {
            outline: none;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.2);
            background: #f2f2f2;
        }

        button {
            padding: 10px 30px;
            background: linear-gradient(to right, #ff416c, #ff4b2b);
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: all 0.3s ease-in-out;
        }

        button {
            transform: translateY(-2px);
            box-shadow: 0 5px 10px rgba(255, 105, 135, 0.6);
            background: linear-gradient(to right, #ff4b2b, #ff416c);
        }

    </style>
</head>
<body>
<header>
    <div class="menu">
        <nav class="nav-header">
            <div class="header1">
                <ul>
                    <li><a href="/">Trang chủ</a></li>
                    <li><a href="${(user != null ) ? "order" : "login"}">Đơn hàng</a></li>
                    <li><a href="${(user != null ) ? "transaction" : "login"}">Giao dịch</a></li>
                    <li><a href="contact.jsp">Liên hệ</a></li>
                    <li><a href="#"><i class="fa-solid fa-cart-shopping"></i></a></li>
                    <c:if test="${user != null}">
                        <li><span style="color: #ffffff;font-size: 20px;line-height: 60px">Số dư: <span id="balanceValue">${user.getBalance()}</span></span></li>
                    </c:if>
                    <c:if test="${user != null}">
                        <li><a href="#"><i class="fa-solid fa-circle-user"></i></a>
                            <ul>
                                <li><a href="changeProfile">Thông tin người dùng</a></li>
                                <li><a href="logout">Đăng xuất</a></li>
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

<div id="profile" style="display:none">
    Username:${sessionScope.account.username}
</div>
<div class="profile">
    <div class="personal-info">
        <h3>${message}</h3>
        <h2>Thông tin cá nhân</h2>
        <form action="changeProfile" method="post">
            <label for="customer-id">Tài khoản:</label>
            <input type="text" id="customer-id" name="customer-id" value="${user.getAccount()}" readonly=""><br>

            <label for="email">Email:</label>
            <input type="text" id="email" name="useremail" value="${user.getEmail()}" readonly=""><br>

            <label for="phone-number">Số điện thoại:</label>
            <input type="text" id="phone-number" name="phone-number" value="${user. getPhoneNumber()}"><br>

            <button type="submit" name="option" value="changeProfile">
                Lưu thay đổi
            </button>
        </form>
    </div>

    <div class="password-change">
        <h2>Đổi mật khẩu</h2>
        <form action="changeProfile" method="post">
            <label for="account">Tài khoản:</label>
            <input type="text" id="account" name="account" value="${user.getAccount()}" readonly><br>

            <label for="old-password">Mật khẩu cũ:</label>
            <input type="password" id="old-password" name="old-password">
            <h4 style="color: red">${oldPasswordErr}</h4><br>

            <label for="new-password">Mật khẩu mới:</label>
            <input type="password" id="new-password" name="new-password"><br>

            <label for="re-type-password">Nhập lại mật khẩu mới:</label>
            <input type="password" id="re-type-password" name="re-type-password">
            <h4 style="color: red">${rePasswordErr}</h4><br>

            <button type="submit" name="option" value="changePassword">
                Lưu thay đổi
            </button>
        </form>
    </div>
</div>
<!--   Core JS Files   -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath}/admin/assets/js/core/popper.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/admin/assets/js/core/bootstrap.min.js" type="text/javascript"></script>
<!--  Plugin for Switches, full documentation here: http://www.jque.re/plugins/version3/bootstrap.switch/ -->
<script src="${pageContext.request.contextPath}/admin/assets/js/plugins/bootstrap-switch.js"></script>
<!--  Google Maps Plugin    -->
<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=YOUR_KEY_HERE"></script>
<!--  Chartist Plugin  -->
<script src="${pageContext.request.contextPath}/admin/assets/js/plugins/chartist.min.js"></script>
<!--  Notifications Plugin    -->
<script src="${pageContext.request.contextPath}/admin/assets/js/plugins/bootstrap-notify.js"></script>
<!-- Control Center for Light Bootstrap Dashboard: scripts for the example pages etc -->
<script src="${pageContext.request.contextPath}/admin/assets/js/light-bootstrap-dashboard.js?v=2.0.0 "
        type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/admin/assets/js/demo.js"></script>
<c:if test="${message != null}">
    <script type="text/javascript">
        setTimeout(demo.showNotify('${message}'), 100);
    </script>
</c:if>
<script>
    document.getElementById("balanceValue").innerText = parseInt(document.getElementById("balanceValue").innerText).toLocaleString();
</script>
</body>
</html>