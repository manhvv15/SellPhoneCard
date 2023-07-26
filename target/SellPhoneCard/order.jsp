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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link href="${pageContext.request.contextPath}/admin/assets/css/demo.css" rel="stylesheet"/>
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
    <div class="row pl-1" style="width: fit-content;margin-left: auto">
        <button type="button" aria-hidden="true" class="close" data-dismiss="alert"
                style="cursor: pointer" onclick="showUpdateDiv('', '', '')">
            <i class="nc-icon nc-simple-remove" style="font-size: 25px;font-weight: bold;"></i>
        </button>
    </div>
    <div class="row">
        <div class="col-md-8 pr-1">
            <div class="form-group">
                <input name="page" value='${pageNumber}' class="d-none">
                <label>Id</label>
                <input type="text" class="form-control" id="idInputUpdateDiv"
                       readonly name="id">
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-8 pr-1">
            <div class="form-group">
                <label>Sản phẩm đã mua</label>
                <input type="text" class="form-control" id="productInputUpdateDiv"
                       readonly name="id">
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-8 pr-1">
            <div class="form-group">
                <label>Trạng thái đơn hàng</label>
                <input type="text" class="form-control" id="statusInputUpdateDiv"
                       readonly name="id">
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-8 pr-1">
            <div class="form-group">
                <label>Giá sản phẩm</label>
                <input type="text" class="form-control" id="productPriceInputUpdateDiv"
                       readonly name="id">
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-8 pr-1">
            <div class="form-group">
                <label>Số lượng</label>
                <input type="text" class="form-control" id="quantityInputUpdateDiv"
                       readonly name="id">
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-8 pr-1">
            <div class="form-group">
                <label>Thành tiền</label>
                <input type="text" class="form-control" id="priceInputUpdateDiv"
                       readonly name="id">
            </div>
        </div>
    </div>
    <div class="row">
        <table class="table">
            <thead>
            <tr>
                <th>ID</th>
                <th>Số Seri</th>
                <th>Sô thẻ</th>
            </tr>
            </thead>
            <tbody>

            </tbody>
        </table>
    </div>
    <div class="row">
        <div class="pr-1">
            <button onclick="showUpdateDiv('', '', '')" type="button" name="option" id="closeButton" value="update"
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
                <form method="get" action="order">
                    <ul class="nav navbar-nav mr-auto">
                        <li class="dropdown nav-item" style="margin-left: 10px">
                            <select id="statusSelect" name="status" class="h-100 border-0"
                                    style="background-color: transparent;color: #5e5e5e;cursor: pointer">
                                <option value="all">Trạng thái</option>
                                <c:forEach var="status" items="${listStatus}">
                                    <option class="dropdown-item" ${(status).equals(param.status) ? "selected" : ""}
                                            value="${status}">${status}</option>
                                </c:forEach>
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
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="login">
                            <span class="no-icon">Log out</span>
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
                <div class=" col-md-12">
                    <div class="card strpied-tabled-with-hover">
                        <div class="card-header ">
                            <h4 class="card-title">Đơn hàng</h4>
                            <p class="card-category">Chi tiết đơn đặt hàng</p>
                        </div>
                        <div class="card-body table-full-width table-responsive">
                            <table class="table table-hover table-striped">
                                <thead>
                                <th>Mã đơn hàng</th>
                                <th>Tên sản phẩm</th>
                                <th>Số lượng</th>
                                <th>Trạng thái đơn hàng</th>
                                <th>Số tiền</th>
                                <th>Tổng thanh toán</th>
                                <th>Thời gian tạo đơn hàng</th>
<%--                                <th>Người bán</th>--%>
                                <th>Hành động</th>
                                </thead>
                                <tbody>
                                <c:forEach var="order" items="${listOrder}">
                                    <tr>
                                        <td>${order.getId()}</td>
                                        <c:set var="quantity" value="${1}"/>
                                        <c:set var="index" value="${0}"/>
                                        <c:forEach var="storage" items="${order.getListStorage()}">

                                            <c:if test="${index == 0}">
                                                <td>
                                                        ${storage.getProduct().getName()}
                                                </td>
                                            </c:if>
                                            <c:if test="${index >= 1 && !storage.getProduct().getName().equals(order.getListStorage().get(index - 1).getProduct().getName())}">

                                                <td>
                                                        ${storage.getProduct().getName()}
                                                </td>
                                                <td>
                                                        ${quantity}
                                                </td>
                                                <c:set var="quantity" value="${1}"/>
                                            </c:if>
                                            <c:if test="${index >= 1 && storage.getProduct().getName().equals(order.getListStorage().get(index - 1).getProduct().getName())}">
                                                <c:set var="quantity" value="${quantity + 1}"/>
                                            </c:if>
                                            <c:set var="index" value="${index + 1}"/>
                                            <c:if test="${index == order.getListStorage().size()}">
                                                <td>
                                                        ${quantity}
                                                </td>
                                            </c:if>
                                        </c:forEach>
                                        <td>${order.getStatus()}</td>
                                        <td class="price_order">${order.getTotalAmount()}</td>
                                        <td class="price_order">${order.getTotalAmount() * quantity}</td>
                                        <td>${order.getCreatedAt()}</td>
<%--                                        <td>${order.getCreatedBy().getAccount()}</td>--%>
                                        <td>
                                            <button class="btn"
                                                    style="background-color: #6188e2;color: #ffffff;cursor: pointer;"
                                                    onclick='showUpdateDiv(JSON.stringify(${order.toJson()}), "${order.getListStorage().get(0).getProduct().getName()}", ${order.getListStorage().get(0).getProduct().getPrice()})'>
                                                Chi tiết sản phẩm
                                            </button>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div id="pagination">
        </div>

        <footer class="footer" style=" position: fixed;bottom: 0;">
            <div class="container-fluid">
                <nav>

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
<script src="${pageContext.request.contextPath}/admin/assets/js/core/jquery.3.2.1.min.js"
        type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/admin/assets/js/core/popper.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/admin/assets/js/core/bootstrap.min.js"
        type="text/javascript"></script>
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
        setTimeout(demo.showNotify("${message}"), 100);
    </script>
</c:if>
</div>
</body>


<script type="text/javascript">
    document.getElementById("balanceValue").innerText = parseInt(document.getElementById("balanceValue").innerText).toLocaleString();

    function showUpdateDiv(order, name, price) {
        if (order !== '' && name !== '' && price !== '') {
            const div = document.getElementById("popup");
            var orderValue = JSON.parse(order);
            console.log(orderValue);
            var listStorage = JSON.parse(JSON.stringify((orderValue.listStorage)));
            console.log(listStorage);
            document.getElementById("idInputUpdateDiv").value = orderValue.id;
            document.getElementById("productInputUpdateDiv").value = name;
            document.getElementById("statusInputUpdateDiv").value = orderValue.status;
            document.getElementById("productPriceInputUpdateDiv").value = price;
            document.getElementById("quantityInputUpdateDiv").value = listStorage.length;
            document.getElementById("priceInputUpdateDiv").value = parseInt(price) * parseInt(listStorage.length);
            var tableContent = div.querySelector(".table");
            var bodyContent = tableContent.querySelector("tbody");
            var content = "";
            for (var s in listStorage) {
                var storage = JSON.parse(JSON.stringify(listStorage[s]));
                content += "<tr>";
                content += "<td>" + storage.id + "</td>";
                content += "<td>" + storage.serialNumber + "</td>";
                content += "<td>" + storage.cardNumber + "</td>";
                content += "</tr>"
            }
            bodyContent.innerHTML = content;
        }
        var blur = document.getElementById('blur');
        blur.classList.toggle('activete');
        var popup = document.getElementById('popup');
        popup.classList.toggle('activete');
    }

    let pages = ${totalPageNumbers};

    document.getElementById('pagination').innerHTML = createPagination(pages, ${pageNumber});

    function createPagination(pages, page) {
        let str = '<ul class="page">';
        let active;
        let pageCutLow = page - 1;
        let pageCutHigh = page + 1;
        var statusSelect = document.getElementById("statusSelect").options[document.getElementById("statusSelect").selectedIndex].value;
        var searchValue = document.getElementById("searchInput").value;
        // Show the Previous button only if you are on a page other than the first
        if (page > 1) {
            str += '<li onclick="createPagination(pages, ' + (page - 1) + ')" class="page__btn"><a href="order?page=' + (page - 1) + '&status=' + statusSelect + '&search=' + searchValue + '" class="w-100 h-100 d-flex text-justify justify-content-center"><span>&laquo;</span></a></li>';
        }
        // Show all the pagination elements if there are less than 6 pages total
        if (pages < 6) {
            for (let p = 1; p <= pages; p++) {
                active = page == p ? "active" : "";
                str += '<li onclick="createPagination(pages, ' + p + ')" class="page__numbers ' + active + '"><a href="order?page=' + p + '&status=' + statusSelect + '&search=' + searchValue + '" class="w-100 h-100 d-flex text-justify justify-content-center"><span>' + p + '</span></a></li>';
            }
        }
        // Use "..." to collapse pages outside of a certain range
        else {
            // Show the very first page followed by a "..." at the beginning of the
            // pagination section (after the Previous button)
            if (page > 2) {
                str += '<li onclick="createPagination(pages, 1)" class="page__numbers"><a href="order?page=1&status=' + statusSelect + '&search=' + searchValue + '" class="w-100 h-100 d-flex text-justify justify-content-center"><span>1</span></a></li>';
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
                str += '<li onclick="createPagination(pages, ' + p + ')" class="page__numbers ' + active + '"><a href="order?page=' + p + '&status=' + statusSelect + '&search=' + searchValue + '" class="w-100 h-100 d-flex text-justify justify-content-center"><span>' + p + '</span></a></li>';
            }
            // Show the very last page preceded by a "..." at the end of the pagination
            // section (before the Next button)
            if (page < pages - 1) {
                if (page < pages - 2) {
                    str += '<li class="page__dots"><span>...</span></li>';
                }
                str += '<li onclick="createPagination(pages, pages)" class="page__numbers"><a href="order?page=' + pages + '&status=' + statusSelect + '&search=' + searchValue + '" class="w-100 h-100 d-flex text-justify justify-content-center"><span>' + pages + '</span></a></li>';
            }
        }
        // Show the Next button only if you are on a page other than the last
        if (page < pages) {
            str += '<li onclick="createPagination(pages, ' + (page + 1) + ')" class="page__btn"><a href="order?page=' + (page + 1) + '&status=' + statusSelect + '&search=' + searchValue + '" class="w-100 h-100 d-flex text-justify justify-content-center"><span>&raquo;</span></a></li>';
        }
        str += '</ul>';
        // Return the pagination string to be outputted in the pug templates
        document.getElementById('pagination').innerHTML = str;
        return str;
    }
    // Convert price below format 1,000
    var priceStorage = document.querySelectorAll(".price_order");
    priceStorage.forEach(p => {
        p.innerText = parseInt(p.innerText).toLocaleString();
    });

</script>
</html>
