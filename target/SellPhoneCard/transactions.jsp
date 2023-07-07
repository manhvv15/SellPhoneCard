<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@page import="java.util.ArrayList" %>
<%@page import="model.Supplier" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
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
        table {
            border-collapse: collapse;
            width: 100%;

        }

        th, td {
            border: 1px solid black;
            padding: 8px;
            text-align: left;
        }

        #updateDiv {
            display: none;
            position: fixed;
            top: -100%;
            left: 50%;
            transform: translateX(-50%);
            background-color: #ebc8fa;
            padding: 20px;
            transition: top 0.3s;
            z-index: 9999;
            border-radius: 10px;
            box-shadow: #464646 0 0 7px;
        }

        #deleteDiv {
            display: none;
            position: fixed;
            top: -100%;
            left: 50%;
            transform: translateX(-50%);
            background-color: #ebc8fa;
            padding: 20px;
            transition: top 0.3s;
            z-index: 9999;
            border-radius: 10px;
            box-shadow: #464646 0 0 7px;
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
                        <li><span
                                style="color: #ffffff;font-size: 20px;line-height: 60px">Số dư: ${user.getBalance()}</span>
                        </li>
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
<h1 style="justify-content: center;
            align-items: center;
            text-align: center;color: rgb(52, 86, 142);">Lịch sử giao dịch</h1>

<table>
    <tr>
        <th>Mã giao dich</th>
        <th>Số tiền</th>
        <th>Loại giao dịch</th>
        <th>Xử lí</th>
        <th>Ghi chú giao dịch</th>
        <th>Người tạo giao dịch</th>
        <th>Thời gian tạo</th>
        <th>Cập nhật cuối</th>
        <th>Hành động</th>
    </tr>

    <c:forEach var="at" items="${list}">
        <tr>
            <th>${at.getId()}</th>
            <th>${at.getMoney()}</th>
            <c:if test="${at.isType()==true}">
                <th>+</th>
            </c:if>
            <c:if test="${at.isType()==false}">
                <th>-</th>
            </c:if>
            <c:if test="${at.isStatus()==true}">
                <th>Đã xử lí</th>
            </c:if>
            <c:if test="${at.isStatus()==false}">
                <th>Chưa xử lí</th>
            </c:if>
            <th>${at.getNote()}</th>
            <th>${at.getUser().getAccount()}</th>
            <th>${at.getCreateAt()}</th>
            <th>${at.getUpdatedAt()}</th>
            <td><a href="detailHistory?id=${at.getId()}">Thông tin</a></td>
        </tr>
    </c:forEach>

    <c:forEach begin="${1}" end="${soTrang}" var="i">
        <a class="${i==page?"active":""}" href="transaction?page=${i}">${i}</a>
    </c:forEach>

</table>

<div class="main-panel">
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg " color-on-scroll="500">
        <div class="container-fluid">

            <div class="collapse navbar-collapse justify-content-end" id="navigation">
                <form method="get" action="transaction">
                    <ul class="nav navbar-nav mr-auto" style="background-color: white">
                        <li class="dropdown nav-item" style="margin-left: 10px; background-color:white ">
                            <select name="type" class="h-100 border-0"
                                    style="background-color: transparent;color: #5e5e5e;cursor: pointer">
                                <option value="">Loại giao dich</option>
                                <option value="true">Tiền vào</option>
                                <option value="false">Tiền ra</option>
                            </select>
                        </li>
                        <li class="nav-item dropdown" style="margin-left: 10px;background-color:white ">
                            <select name="status" class="h-100 border-0"
                                    style="background-color: transparent;color: #5e5e5e;cursor: pointer">
                                <option value="">Xử lí</option>
                                <option value="true">Đã xử lí</option>
                                <option value="false">Chưa xử lí</option>
                            </select>
                        </li>
                        <form ation="transaction">
                            <li class="nav-item" style="margin-left: 10px;background-color:white ">
                                <input type="text" name="search" placeholder="Tìm giao dịch" class="h-50 border-0"
                                       value="${param.search}">
                                <button type="submit" name="searchSubmit" value="search" class="nav-link border-0"
                                        style="cursor: pointer">
                                    <i class="nc-icon nc-zoom-split"></i>
                                    <span class="d-lg-block">&nbsp;Search</span>
                                </button>
                            </li>
                        </form>
                    </ul>
                </form>
            </div>
        </div>
    </nav>
</body>
</html>