<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@page import="java.util.ArrayList" %>
<%@page import="model.Supplier" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <link href="${pageContext.request.contextPath}/assets/css/pagination.css" rel="stylesheet">
    <link rel="apple-touch-icon" sizes="76x76"
          href="${pageContext.request.contextPath}/assets/img/apple-icon.png">
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/img/favicon.ico">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <title>Light Bootstrap Dashboard - Free Bootstrap 4 Admin Dashboard by Creative Tim</title>
    <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no'
          name='viewport'/>
    <!--     Fonts and icons     -->
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200" rel="stylesheet"/>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css"/>
    <!-- CSS Files -->
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="${pageContext.request.contextPath}/assets/css/light-bootstrap-dashboard.css?v=2.0.0 "
          rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link href="${pageContext.request.contextPath}/assets/css/demo.css" rel="stylesheet"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
    <style>
        #blur.activete {
            filter: blur(20px);
            pointer-events: none;
            user-select: none;
        }

        #popup {
            position: fixed;
            top: 40%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 600px;
            padding: 50px;
            box-shadow: 0 5px 30px rgba(0, 0, 0, .30);
            background: #fff;
            visibility: hidden;
            opacity: 0;
            transition: 0.5s;
            z-index: 9999;
            max-height: 600px;
            overflow: scroll;
        }

        #popup.activete {
            top: 50%;
            visibility: visible;
            opacity: 1;
            transform: 0.5s;
        }
    </style>
</head>
<body>
<div id="popup">
    <div class="table-container">
        <table class="table">
            <tr>
                <th>Người tạo</th>
                <td style="background-color: #ddd;"><span id="createdBy"></span></td>
            </tr>
            <tr>
                <th>Số tiền</th>
                <td><span id="priceValue"></span></td>
            </tr>
            <tr>
                <th>Loại giao dịch</th>
                <td style="background-color: #ddd;"><span id="type"></span></td>
            </tr>
            <tr>
                <th>Xử lí</th>
                <td><span id="status"></span></td>
            </tr>

            <tr>
                <th>Thời gian tạo</th>
                <td style="background-color: #ddd;"><span id="createdAt"></span></td>
            </tr>
            <tr>
                <th>Thời gian cập nhật</th>
                <td><span id="updatedAt"></span></td>
            </tr>
        </table>
    </div>
    <div class="row">
        <div class="pr-1">
            <button onclick="toggle('')" type="button" name="option" id="closeButton" value="update"
                    class="btn"
                    style="cursor: pointer;background-color: #01b901;color: #ffffff;">
                Đóng
            </button>
        </div>
    </div>
</div>
<div class="wrapper" id="blur">
    <header style="height: 60px;">
        <div class="menu">
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
                            <li><a href="#"><i class="fa-solid fa-circle-user"></i></a>
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
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg col-sm-" color-on-scroll="100">
        <div class="container-fluid">
            <a class="navbar-brand" href="/"> HOME 🌐 </a>
            <div class="collapse navbar-collapse justify-content-end" id="navigation">
                <form method="get" action="transaction">
                    <ul class="nav navbar-nav mr-auto">
                        <li class="dropdown nav-item" style="margin-left: 10px">
                            <select id="typeSelect" name="type" class="h-100 border-0"
                                    style="background-color: transparent;color: #5e5e5e;cursor: pointer">
                                <option value="">Loại giao dich</option>
                                <option ${param.type == "true" ? "selected" : ""} value="true">Tiền vào</option>
                                <option ${param.type == "false" ? "selected" : ""} value="false">Tiền ra</option>
                            </select>
                        </li>
                        <li class="dropdown nav-item" style="margin-left: 10px">
                            <select id="statusSelect" name="status" class="h-100 border-0"
                                    style="background-color: transparent;color: #5e5e5e;cursor: pointer">
                                <option value="">Xử lí</option>
                                <option ${param.status == "true" ? "selected" : ""} value="true">Đã xử lí</option>
                                <option ${param.status == "false" ? "selected" : ""} value="false">Chưa xử lí</option>
                            </select>
                        </li>
                        <li class="nav-item" style="margin-left: 10px">
                            <input type="text" id="searchInput" name="search" placeholder="Tìm kiếm "
                                   class="h-50 border-0"
                                   value="${param.search}">
                            <button type="submit" class="nav-link border-0" style="cursor: pointer">
                                <i class="nc-icon nc-zoom-split"></i>
                                <span class="d-lg-block">&nbsp;Search</span>
                            </button>
                        </li>
                    </ul>
                </form>
            </div>
        </div>
    </nav>
    <div class="content">
        <div class="container-fluid">
            <div class="row">
                <div class=" col-md-12">
                    <div class="card strpied-tabled-with-hover">
                        <div class="card-header ">
                            <h4 class="card-title">Giao dịch</h4>
                            <p class="card-category">Lịch sử giao dịch</p>
                        </div>
                        <div class="card-body table-full-width table-responsive">
                            <table class="table table-hover table-striped">
                                <tr>
                                    <th>Mã giao dich</th>
                                    <th>Số tiền</th>
                                    <th>Loại giao dịch</th>
                                    <th>Xử lí</th>
                                    <th>Ghi chú giao dịch</th>
                                    <th>Người tạo giao dịch</th>
                                    <th>Thời gian tạo</th>
                                    <th>Cập nhật cuối</th>
                                </tr>

                                <c:forEach var="at" items="${list}">
                                    <tr>
                                        <td>${at.getId()}</td>
                                        <td>${at.getMoney()}</td>
                                        <c:if test="${at.isType()==true}">
                                            <td>+</td>
                                        </c:if>
                                        <c:if test="${at.isType()==false}">
                                            <td>-</td>
                                        </c:if>
                                        <c:if test="${at.isStatus()==true}">
                                            <td>Đã xử lí</td>
                                        </c:if>
                                        <c:if test="${at.isStatus()==false}">
                                            <td>Chưa xử lí</td>
                                        </c:if>
                                        <td>${at.getNote()}</td>
                                        <td>${at.getUser().getAccount()}</td>
                                        <td>${at.getCreateAt()}</td>
                                        <td>${at.getUpdatedAt()}</td>
<%--                                        <td>--%>
<%--                                            <button class="btn"--%>
<%--                                                    style="background-color: #6188e2;color: #ffffff;cursor: pointer;"--%>
<%--                                                    onclick=''>--%>
<%--                                                Chi tiết--%>
<%--                                            </button>--%>
<%--                                        </td>--%>
                                    </tr>
                                </c:forEach>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div id="pagination">

        </div>
    </div>
</div>
</body>
<script>
    document.getElementById("balanceValue").innerText = parseInt(document.getElementById("balanceValue").innerText).toLocaleString();
    let pages = ${totalPageNumbers};

    document.getElementById('pagination').innerHTML = createPagination(pages, ${pageNumber});

    function createPagination(pages, page) {
        let str = '<ul class="page">';
        let active;
        let pageCutLow = page - 1;
        let pageCutHigh = page + 1;
        var statusSelect = document.getElementById("statusSelect").value;
        var typeSelect = document.getElementById("typeSelect").value;
        var searchValue = document.getElementById("searchInput").value;
        // Show the Previous button only if you are on a page other than the first
        if (page > 1) {
            str += '<li onclick="createPagination(pages, ' + (page - 1) + ')" class="page__btn"><a href="transaction?page=' + (page - 1) + '&status=' + statusSelect + '&search=' + searchValue + '&type=' + typeSelect + '" class="w-100 h-100 d-flex text-justify justify-content-center"><span>&laquo;</span></a></li>';
        }
        // Show all the pagination elements if there are less than 6 pages total
        if (pages < 6) {
            for (let p = 1; p <= pages; p++) {
                active = page == p ? "active" : "";
                str += '<li onclick="createPagination(pages, ' + p + ')" class="page__numbers ' + active + '"><a href="transaction?page=' + p + '&status=' + statusSelect + '&search=' + searchValue + '&type=' + typeSelect + '" class="w-100 h-100 d-flex text-justify justify-content-center"><span>' + p + '</span></a></li>';
            }
        }
        // Use "..." to collapse pages outside of a certain range
        else {
            // Show the very first page followed by a "..." at the beginning of the
            // pagination section (after the Previous button)
            if (page > 2) {
                str += '<li onclick="createPagination(pages, 1)" class="page__numbers"><a href="transaction?page=1&status=' + statusSelect + '&search=' + searchValue + '&type=' + typeSelect + '" class="w-100 h-100 d-flex text-justify justify-content-center"><span>1</span></a></li>';
                if (page > 3) {
                    str += `<li class="page__dots"><span>...</span></li>`;
                }
            }
            // Determine how many pages to show after the current page index
            if (page === 1) {
                pageCutHigh += 2;
            } else if (page === 2) {
                pageCutHigh += 1;
            }
            // Determine how many pages to show before the current page index
            if (page === pages) {
                pageCutLow -= 2;
            } else if (page === pages - 1) {
                pageCutLow -= 1;
            }
            // Output the indexes for pages that fall inside the range of pageCutLow
            // and pageCutHigh
            for (let p = pageCutLow; p <= pageCutHigh; p++) {
                if (p === 0) {
                    p += 1;
                }
                if (p > pages) {
                    continue
                }
                active = page == p ? "active" : "";
                str += '<li onclick="createPagination(pages, ' + p + ')" class="page__numbers ' + active + '"><a href="transaction?page=' + p + '&status=' + statusSelect + '&search=' + searchValue + '&type=' + typeSelect + '" class="w-100 h-100 d-flex text-justify justify-content-center"><span>' + p + '</span></a></li>';
            }
            // Show the very last page preceded by a "..." at the end of the pagination
            // section (before the Next button)
            if (page < pages - 1) {
                if (page < pages - 2) {
                    str += '<li class="page__dots"><span>...</span></li>';
                }
                str += '<li onclick="createPagination(pages, pages)" class="page__numbers"><a href="transaction?page=' + pages + '&status=' + statusSelect + '&search=' + searchValue + '&type=' + typeSelect + '" class="w-100 h-100 d-flex text-justify justify-content-center"><span>' + pages + '</span></a></li>';
            }
        }
        // Show the Next button only if you are on a page other than the last
        if (page < pages) {
            str += '<li onclick="createPagination(pages, ' + (page + 1) + ')" class="page__btn"><a href="transaction?page=' + (page + 1) + '&status=' + statusSelect + '&search=' + searchValue + '&type=' + typeSelect + '" class="w-100 h-100 d-flex text-justify justify-content-center"><span>&raquo;</span></a></li>';
        }
        str += '</ul>';
        // Return the pagination string to be outputted in the pug templates
        document.getElementById('pagination').innerHTML = str;
        return str;
    }
</script>
</html>