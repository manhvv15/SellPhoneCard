<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8"/>
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
    <link href="${pageContext.request.contextPath}/admin/assets/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="${pageContext.request.contextPath}/admin/assets/css/light-bootstrap-dashboard.css?v=2.0.0 "
          rel="stylesheet"/>
    <!-- CSS Just for demo purpose, don't include it in your project -->
    <link href="${pageContext.request.contextPath}/admin/assets/css/demo.css" rel="stylesheet"/>
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
            width: 800px;
            max-height: 600px;
            overflow: scroll;
            padding: 50px;
            box-shadow: 0 5px 30px rgba(0, 0, 0, .30);
            background: #fff;
            visibility: hidden;
            opacity: 0;
            transition: 0.5s;
            z-index: 9999;
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
    <div class="row pl-1" style="width: fit-content;margin-left: auto">
        <button type="button" aria-hidden="true" class="close" data-dismiss="alert" id="closeButton"
                style="cursor: pointer" onclick="showUpdateDiv('')">
            <i class="nc-icon nc-simple-remove" style="font-size: 25px;font-weight: bold;"></i>
        </button>
    </div>
    <form action="transaction" method="post" class="">
        <div class="row">
            <div class="col-md-8 pr-1">
                <div class="form-group">
                    <label>Id</label>
                    <input type="text" class="form-control" id="idInputUpdateDiv"
                           readonly name="id">
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-8 pr-1">
                <div class="form-group">
                    <label>Người dùng</label>
                    <input type="text" class="form-control" id="userInputUpdateDiv"
                           readonly name="seri">
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-8 pr-1">
                <div class="form-group">
                    <label>Ghi chú</label>
                    <textarea class="w-75 form-control" id="noteInputUpdateDiv"
                              style="max-height: 150px;height: 100px;"></textarea>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-8 pl-1">
                <button onclick="showUpdateDiv('')" id="updateButton" type="button" name="option" value="update" class="btn"
                        style="cursor: pointer;background-color: #01b901;color: #ffffff;">
                    Đóng
                </button>
            </div>
        </div>
    </form>
</div>
<div class="wrapper" id="blur">
    <div class="sidebar" data-image="${pageContext.request.contextPath}/admin/assets/img/sidebar-5.jpg">
        -->
        <div class="sidebar-wrapper">
            <div class="logo">
                <a href="/" class="simple-text">
                    SWP391 GROUP5
                </a>
            </div>
            <ul class="nav">
                <li>
                    <a class="nav-link" href="/">
                        <i class="nc-icon nc-chart-pie-35"></i>
                        <p>Dashboard</p>
                    </a>
                </li>
                <li>
                    <a class="nav-link" href="changeProfile">
                        <i class="nc-icon nc-circle-09"></i>
                        <p>Thông tin</p>
                    </a>
                </li>
                <li>
                    <a class="nav-link" href="storage">
                        <i class="nc-icon nc-notes"></i>
                        <p>Kho hàng</p>
                    </a>
                </li>
                <li>
                    <a class="nav-link" href="order">
                        <i class="nc-icon nc-paper-2"></i>
                        <p>Đơn hàng</p>
                    </a>
                </li>
                <li>
                    <a class="nav-link" href="products">
                        <i class="nc-icon nc-atom"></i>
                        <p>Sản phẩm</p>
                    </a>
                </li>
                <li>
                    <a class="nav-link" href="user">
                        <i class="nc-icon nc-circle-09"></i>
                        <p>Người dùng</p>
                    </a>
                </li>
                <li class="nav-item active">
                    <a class="nav-link" href="transaction">
                        <i class="nc-icon nc-bell-55"></i>
                        <p>Giao dịch</p>
                    </a>
                </li>
            </ul>
        </div>
    </div>
    <div class="main-panel">
        <!-- Navbar -->
        <nav class="navbar navbar-expand-lg " color-on-scroll="500">
            <div class="container-fluid">
                <a class="navbar-brand" href="transaction"> Giao dịch </a>
                <div class="collapse navbar-collapse justify-content-end" id="navigation">
                    <form method="get" action="storage">
                        <ul class="nav navbar-nav mr-auto">
                            <li class="dropdown nav-item" style="margin-left: 20px">
                                <select id="typeSelect" name="type" class="h-100 border-0"
                                        style="background-color: transparent;color: #5e5e5e;cursor: pointer">
                                    <option value="">Loại giao dich</option>
                                    <option value="true">Tiền vào</option>
                                    <option value="false">Tiền ra</option>
                                </select>
                            </li>
                            <li class="nav-item dropdown" style="margin-left: 20px">
                                <select id="statusSelect" name="status" class="h-100 border-0"
                                        style="background-color: transparent;color: #5e5e5e;cursor: pointer">
                                    <option value="">Xử lí</option>
                                    <option value="true">Đã xử lí</option>
                                    <option value="false">Chưa xử lí</option>
                                </select>
                            </li>
                            <li class="nav-item" style="margin-left: 20px">
                                <input id="searchInput" type="text" name="search" placeholder="Tìm tên sản phẩm"
                                       class="h-100 border-0"
                                >
                            </li>
                        </ul>
                    </form>
                    <ul class="navbar-nav ml-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="login">
                                <span class="no-icon">Đăng xuất</span>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
        <!-- End Navbar -->
        <div class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-12">
                        <div class="card strpied-tabled-with-hover">
                            <div class="card-body table-full-width table-responsive">
                                <table class="table table-hover table-striped">
                                    <thead>
                                    <th>Mã giao dich</th>
                                    <th>Số tiền</th>
                                    <th>Loại giao dịch</th>
                                    <th>Xử lí</th>
                                    <th>Người tạo giao dịch</th>
                                    <th>Thời gian tạo</th>
                                    </thead>
                                    <tbody>

                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div id="pagination">
            </div>
        </div>
        <footer class="footer">
            <div class="container-fluid">
                <nav>
                    <ul class="footer-menu">
                        <li>
                            <a href="home">
                                Home
                            </a>
                        </li>
                    </ul>
                    <p class="copyright text-center">
                        ©
                        <script>
                            document.write(new Date().getFullYear())
                        </script>
                        SWP391 group5, made with love for a better web
                    </p>
                </nav>
            </div>
        </footer>
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
</body>

<script type="text/javascript">

    $(document).ready(function () {
        $.ajax({
            url: "api/v1/transaction",
            type: "GET",
            dataType: "json",
            success: function (response) {
                loadPagination(JSON.stringify(response.pagination));
                loadContentList(JSON.stringify(response.listTransaction));
            }
        });
    });

    function getData(page) {
        $.ajax({
            url: "api/v1/transaction?page=" + page + "&type=" + $('#typeSelect').val() + "&status=" + $('#statusSelect').val() + "&search=" + $('#searchInput').val(),
            type: "GET",
            dataType: "json",
            success: function (response) {
                loadPagination(JSON.stringify(response.pagination));
                loadContentList(JSON.stringify(response.listTransaction));
            }
        });
    }

    function loadPagination(data) {
        var dataPage = JSON.parse(data);
        console.log(dataPage);
        var pageNumber = parseInt(dataPage.pageNumber);
        var totalPage = parseInt(dataPage.totalPageNumbers);
        document.getElementById('pagination').innerHTML = createPagination(totalPage, pageNumber);
    }

    function loadContentList(data) {
        const tableInfo = document.querySelector(".table");
        var tableBody = tableInfo.querySelector("tbody");
        var list = JSON.parse(data);
        console.log(list);
        var bodyContent = "";
        list.forEach(item => {
            var createdBy = JSON.parse(JSON.stringify(item.createBy));
            var m = new Date(item.createAt);
            var time = m.getFullYear() + "-" +
                ("0" + (m.getMonth() + 1)).slice(-2) + "-" +
                ("0" + m.getDate()).slice(-2) + " " +
                ("0" + m.getHours()).slice(-2) + ":" +
                ("0" + m.getMinutes()).slice(-2) + ":" +
                ("0" + m.getSeconds()).slice(-2);
            bodyContent += "<tr>";
            bodyContent += "<td>" + item.id + "</td>";
            bodyContent += "<td class='price_storage'>" + item.money + "</td>";
            bodyContent += "<td>" + (item.type ? "+" : "-") + "</td>";
            bodyContent += "<td>" + (item.status ? "Đã xử lý" : "Đang chờ xử lý") + "</td>";
            bodyContent += "<td>" + createdBy.account + "</td>";
            bodyContent += "<td>" + time + "</td>"
            bodyContent += `<td> <button class="btn" style="background-color: #01b901;color: #ffffff;cursor: pointer;"onclick='showUpdateDiv(JSON.stringify(` + item + `))'>Thông tin </button> </td>`
            bodyContent += "</tr>";
        });
        tableBody.innerHTML = bodyContent;
        var priceStorage = document.querySelectorAll(".price_storage");
        priceStorage.forEach(p => {
            p.innerText = parseInt(p.innerText).toLocaleString();
        });
    }

    $('#typeSelect').change(() => {
        getData(1);
    });
    $('#statusSelect').change(() => {
        getData(1);
    });
    $('#searchInput').on('input', () => {
        getData(1);
    });

    // Convert price below format 1,000
    var priceStorage = document.querySelectorAll(".price_storage");
    priceStorage.forEach(p => {
        p.innerText = parseInt(p.innerText).toLocaleString();
    });

    function showUpdateDiv(storage) {
        if (storage !== '') {
            var json = JSON.parse(storage);
            var expiredAt = new Date(json.createdAt);
            var timeExpiredAt = expiredAt.getFullYear() + "-" +
                ("0" + (expiredAt.getMonth() + 1)).slice(-2) + "-" +
                ("0" + expiredAt.getDate()).slice(-2) + " " +
                ("0" + expiredAt.getHours()).slice(-2) + ":" +
                ("0" + expiredAt.getMinutes()).slice(-2) + ":" +
                ("0" + expiredAt.getSeconds()).slice(-2);
            json.expiredAt = timeExpiredAt;
            document.getElementById("idInputUpdateDiv").value = json.id;
            document.getElementById("userInputUpdateDiv").value = json.CreatedBy.account;
            document.getElementById("noteInputUpdateDiv").value = json.note;
        }
        var blur = document.getElementById('blur');
        blur.classList.toggle('activete');
        var popup = document.getElementById('popup');
        popup.classList.toggle('activete');
    }

    function createPagination(pages, page) {
        let str = '<ul class="page">';
        let active;
        let pageCutLow = page - 1;
        let pageCutHigh = page + 1;
        // Show the Previous button only if you are on a page other than the first
        if (page > 1) {
            str += '<li onclick="createPagination(' + pages + ', ' + (page - 1) + ');getData(' + (page - 1) + ')" class="page__btn paging"><span>&laquo;</span></li>';
        }
        // Show all the pagination elements if there are less than 6 pages total
        if (pages < 6) {
            for (let p = 1; p <= pages; p++) {
                active = page == p ? "active" : "";
                str += '<li onclick="createPagination(' + pages + ', ' + p + ');getData(' + p + ')" class="page__numbers paging ' + active + '"><span>' + p + '</span></li>';
            }
        }
        // Use "..." to collapse pages outside of a certain range
        else {
            // Show the very first page followed by a "..." at the beginning of the
            // pagination section (after the Previous button)
            if (page > 2) {
                str += `<li onclick="createPagination(` + pages + `, 1);getData(` + 1 + `)" class="page__numbers paging"><span>1</span></li>`;
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
                str += '<li onclick="createPagination(' + pages + ', ' + p + ');getData(' + p + ')" class="page__numbers paging ' + active + '"><span>' + p + '</span></li>';
            }
            // Show the very last page preceded by a "..." at the end of the pagination
            // section (before the Next button)
            if (page < pages - 1) {
                if (page < pages - 2) {
                    str += '<li class="page__dots"><span>...</span></li>';
                }
                str += '<li onclick="createPagination(' + pages + ', ' + pages + ');getData(' + pages + ')" class="page__numbers paging"><span>' + pages + '</span></li>';
            }
        }
        // Show the Next button only if you are on a page other than the last
        if (page < pages) {
            str += '<li onclick="createPagination(' + pages + ', ' + (page + 1) + ');getData(' + (page + 1) + ')" class="page__btn paging"><span>&raquo;</span></li>';
        }
        str += '</ul>';
        // Return the pagination string to be outputted in the pug templates
        document.getElementById('pagination').innerHTML = str;
        return str;
    }
</script>
</html>