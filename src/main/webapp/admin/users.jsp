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
            width: 600px;
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

        #popupDelete {
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
        }

        #popupDelete.activete {
            top: 50%;
            visibility: visible;
            opacity: 1;
            transform: 0.5s;
        }
        #popupAddMoney {
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
        }
        #popupAddMoney.activete {
            top: 50%;
            visibility: visible;
            opacity: 1;
            transform: 0.5s;
        }
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   */
    </style>
</head>

<body>
<div id="popupDelete">
    <h4 style="text-align: center"><b>Bạn có chắc muốn xóa chứ</b></h4>
    <form action="storage" method="post" class="justify-content-around d-flex">
        <input name="id" id="idInputDeleteDiv" class="d-none">
        <input name="page" id="pageInputDeleteDiv" value='${request.getParameter("page")}' class="d-none">
        <button id="deleteButton" class="btn" type="button" name="option" value="delete"
                style="background-color: #cc2127;color: #ffffff;cursor: pointer;">
            Xóa
        </button>
        <button type="button" class="btn" id="closeButtonDelete" onclick="showDeleteAlert(-1)"
                style="cursor: pointer;background-color: #01b901;color: #ffffff;">
            Hủy
        </button>
    </form>
</div>

<%--show thông tin chi tiết users --%>
<div id="popup">
    <div class="row pl-1" style="width: fit-content;margin-left: auto">
        <button type="button" aria-hidden="true" class="close" data-dismiss="alert" id="closeButton"
                style="cursor: pointer" onclick="showUpdateDiv('')">
            <i class="nc-icon nc-simple-remove" style="font-size: 25px;font-weight: bold;"></i>
        </button>
    </div>
    <form action="storage" method="post" class="">
        <div class="row">
            <div class="col-md-8 pr-1">
                <div class="form-group">
                    <input name="page" id="pageInputUpdateDiv" value='${param.page}' class="d-none">
                    <label>Id</label>
                    <input type="text" class="form-control" id="idInputUpdateDiv"
                           readonly name="id">
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-8 pr-1">
                <div class="form-group">
                    <label>Tên người dùng</label>
                    <input type="text" class="form-control" id="accountInputUpdateDiv"
                           readonly name="account">
                </div>
            </div>
        </div>
        <label hidden="hidden">Password</label>
        <input type="text" class="form-control" id="passwordInputUpdateDiv"
               hidden="hidden" name="password">
        <%--                    lấy role--%>
        <label hidden="hidden">Role</label>
        <input type="text" class="form-control" id="roleInputUpdateDiv"
               hidden="hidden" name="role">
        <div class="row">
            <div class="col-md-8 pr-1">
                <div class="form-group">
                    <label>Email</label>
                    <input type="text" class="form-control" id="emailInputUpdateDiv"
                           name="email">
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-8 pr-1">
                <div class="form-group">
                    <label>Số tiền</label>
                    <input type="text" class="form-control" id="balanceInputUpdateDiv"
                           name="balance">
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-8 pr-1">
                <div class="form-group">
                    <label>Số điện thoại</label>
                    <input type="text" class="form-control" id="phoneInputUpdateDiv"
                           name="phone">
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-8 pr-1">
                <div class="form-group">
                    <label>Trạng thái</label>
                    <input type="text" class="form-control" id="isActiveInputUpdateDiv"
                           name="isActive">
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-8 pr-1">
                <button id="updateButton" type="button" name="option" value="update" class="btn"
                        style="cursor: pointer;background-color: #01b901;color: #ffffff;">
                    Cập nhật
                </button>
            </div>
        </div>
    </form>
</div>


<%--show add money--%>
<div id="popupAddMoney">
    <div class="row pl-1" style="width: fit-content;margin-left: auto">
        <button type="button" aria-hidden="true" class="close" data-dismiss="alert" id="closeButton1"
                style="cursor: pointer" onclick="showAddMoneyDiv('')">
            <i class="nc-icon nc-simple-remove" style="font-size: 25px;font-weight: bold;"></i>
        </button>
    </div>
    <form action="addmoney" method="POST" class="">
        <div class="row">
            <div class="col-md-8 pr-1">
                <div class="form-group">
                    <input name="page" id="pageInputUpdateDiv1" value='${param.page}' class="d-none">
                    <label>Id</label>
                    <input type="text" class="form-control" id="idInput"
                           readonly name="userId">
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-8 pr-1">
                <div class="form-group">
                    <label>Tên người dùng</label>
                    <input type="text" class="form-control" id="accountInput"
                           readonly name="account">
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-8 pr-1">
                <div class="form-group">
                    <label>Số tiền cần nạp</label>
                    <input type="text" class="form-control" id="balanceInput"
                            name="balance" required>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-8 pr-1">
                <area class="form-group">
                    <label>Ghi chú</label>
                    <input  type="text" class="form-control" id="noteInput"
                                  name="note">

            </div>
        </div>
        <div class="row">
            <div class="col-md-8 pr-1">
                <button  type="button" name="option" value="update" class="btn"
                        style="cursor: pointer;background-color: #01b901;color: #ffffff;">
                    Nạp tiền
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
                <li class="nav-item active">
                    <a class="nav-link" href="user">
                        <i class="nc-icon nc-circle-09"></i>
                        <p>Người dùng</p>
                    </a>
                </li>
                <li>
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
                <a class="navbar-brand" href="user"> Người dùng </a>
                <div class="collapse navbar-collapse justify-content-end" id="navigation">
                    <form method="get" action="storage">
                        <ul class="nav navbar-nav mr-auto">
                            <li class="dropdown nav-item" style="margin-left: 20px">
                                <select id="priceSelect" name="price" class="h-100 border-0"
                                        style="background-color: transparent;color: #5e5e5e;cursor: pointer">
                                    <option value="all">Mệnh giá</option>
                                </select>
                            </li>
                            <li class="nav-item dropdown" style="margin-left: 20px">
                                <select id="supplierSelect" name="supplier" class="h-100 border-0"
                                        style="background-color: transparent;color: #5e5e5e;cursor: pointer">
                                    <option value="all">Nhà phát hành</option>
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
                            <div class="card-header ">
                                <h4 class="card-title">Người dùng</h4>
                                <p class="card-category">Trang admin quản lí người dùng</p>
                            </div>
                            <div class="card-body table-full-width table-responsive">
                                <table class="table table-hover table-striped">
                                    <thead>
                                    <th>ID</th>
                                    <th>Tên account</th>
                                    <th>Phone</th>
                                    <th>Email</th>
                                    <th>Ballance</th>
                                    <th>Hành động</th>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="user" items="${listUser}">
                                        <tr>
                                            <td>${user.getId()}</td>
                                            <td>${user.getAccount()}</td>
                                            <td>${user.getPhoneNumber()}</td>
                                            <td>${user.getEmail()}</td>
                                            <td class="ballace_user">${user.getBalance()}</td>

                                            <td>
                                                <button class="btn"
                                                        style="background-color: #01b901;color: #ffffff;cursor: pointer;"
                                                        onclick='showUpdateDiv(JSON.stringify(${user.toJson()}))'>
                                                    Thông tin
                                                </button>
                                            </td>

<%--                                            <td>--%>
<%--                                                <button class="btn"--%>
<%--                                                        style="background-color: #d5d71e;color: #ffffff;cursor: pointer;"--%>
<%--                                                        onclick='showAddMoneyDiv(JSON.stringify(${user.toJson()}))'>--%>
<%--                                                    Nạp tiền--%>
<%--                                                </button>--%>
<%--                                            </td>--%>

                                            <form action="addmoney" method="get">
                                                <input type="hidden" name="userId" value="${user.getId()}">
                                                <td>
                                                    <button class="btn"
                                                            style="background-color: #d7d70e;color: #ffffff;cursor: pointer;"
                                                            onclick='showUpdateDiv1(JSON.stringify(${user.toJson()}))'>
                                                        Nạp tiền
                                                    </button>
                                                </td>
                                            </form>


                                                <%--                                            <td>--%>
                                                <%--                                                <button class="btn"--%>
                                                <%--                                                        style="background-color: #cc2127;color: #ffffff;cursor: pointer;"--%>
                                                <%--                                                        onclick="showDeleteAlert(${user.getId()})">--%>
                                                <%--                                                    Xóa--%>
                                                <%--                                                </button>--%>
                                                <%--                                            </td>--%>

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
            url: "api/v1/users",
            type: "GET",
            dataType: "json",
            success: function (response) {
                loadPagination(JSON.stringify(response.pagination));
                loadContentList(JSON.stringify(response.listUser));
            }
        });
    });

    $('#updateButton').click(updateUser);
    $('#addMoneyButton').click(addMoneyUser);
    // $('#deleteButton').click(deleteStorage);

    function updateUser() {
        var data = {
            id: $('#idInputUpdateDiv').val(),
            account: $('#accountInputUpdateDiv').val(),
            password: $('#passwordInputUpdateDiv').val(),
            role: $('#roleInputUpdateDiv').val(),
            email: $('#emailInputUpdateDiv').val(),
            // createdAt: $('#createdAtInputUpdateDiv').val(),
            balance: $('#balanceInputUpdateDiv').val(),
            phoneNumber: $('#phoneInputUpdateDiv').val(),
            isActive: $('#isActiveInputUpdateDiv').val()

        };
        var page = $('#pagination.page.active span').text();
        console.log(page);
        $.ajax({
            url: "api/v1/users",
            type: "POST",
            data: data,
            dataType: "json",
            success: function (response) {
                setTimeout(demo.showNotify(response.message), 100);
                getData(1);
            }
        });
    }
    function addMoneyUser() {
        var data = {
            id: $('#idInputUpdateDiv').val(),
            account: $('#accountInputUpdateDiv').val(),
            // password: $('#passwordInputUpdateDiv').val(),
            // role: $('#roleInputUpdateDiv').val(),
            // email: $('#emailInputUpdateDiv').val(),
            // createdAt: $('#createdAtInputUpdateDiv').val(),
            // balance: $('#balanceInputUpdateDiv').val(),
            // phoneNumber: $('#phoneInputUpdateDiv').val(),
            // isActive: $('#isActiveInputUpdateDiv').val()

        };
        var page = $('#pagination.page.active span').text();
        console.log(page);
        $.ajax({
            url: "api/v1/users",
            type: "POST",
            data: data,
            dataType: "json",
            success: function (response) {
                setTimeout(demo.showNotify(response.message), 100);
                getData(1);
            }
        });
    }
    // function deleteStorage() {
    //     var data = {
    //         id: $('#idInputDeleteDiv').val()
    //     };
    //     $.ajax({
    //         url: "api/v1/user?id=" + data.id,
    //         type: "DELETE",
    //         data: data,
    //         dataType: "json",
    //         success: function (response) {
    //             setTimeout(demo.showNotify(response.message), 100);
    //             getData(1);
    //         }
    //     });
    // }

    function getData(page) {
        $.ajax({
            url: "api/v1/users?page=" + page,
            type: "GET",
            dataType: "json",
            success: function (response) {
                loadPagination(JSON.stringify(response.pagination));
                loadContentList(JSON.stringify(response.listUser));
            }
        });
    }

    function loadPagination(data) {
        var dataPage = JSON.parse(data);
        var pageNumber = parseInt(dataPage.pageNumber);
        var totalPage = parseInt(dataPage.totalPageNumbers);
        document.getElementById("pageInputDeleteDiv").value = pageNumber;
        document.getElementById("pageInputUpdateDiv").value = pageNumber;
        document.getElementById("pageInputUpdateDiv1").value = pageNumber;
        document.getElementById('pagination').innerHTML = createPagination(totalPage, pageNumber);
    }

    // function loadlistProduct(data) {
    //     var listProduct = JSON.parse(data);
    //     $.each(listProduct, function (i, product) {
    //         $('#priceSelect').append($('<option>').val(product)
    //             .text(parseInt(product).toLocaleString()));
    //     });
    // }

    // function loadListSupplier(data) {
    //     var listProduct = JSON.parse(data);
    //     $.each(listProduct, function (i, supplier) {
    //         $('#supplierSelect').append($('<option>').val(supplier.id)
    //             .text(supplier.name));
    //     });
    // }

    // function loadContentList(data) {
    //     const tableInfo = document.querySelector(".table");
    //     var tableBody = tableInfo.querySelector("tbody");
    //     var list = JSON.parse(data);
    //     var bodyContent = "";
    //     list.forEach(item => {
    //         var id = JSON.parse(JSON.stringify(item.id));
    //         var account = JSON.parse(JSON.stringify(item.account));
    //         var email = JSON.parse(JSON.stringify(item.email));
    //         var balance = JSON.parse(JSON.stringify(item.balance));
    //         var isActive = JSON.parse(JSON.stringify(item.isActive));
    //         // var m = new Date(item.createdAt);
    //         // var time = m.getFullYear() + "-" +
    //         //     ("0" + (m.getMonth() + 1)).slice(-2) + "-" +
    //         //     ("0" + m.getDate()).slice(-2) + " " +
    //         //     ("0" + m.getHours()).slice(-2) + ":" +
    //         //     ("0" + m.getMinutes()).slice(-2) + ":" +
    //         //     ("0" + m.getSeconds()).slice(-2);
    //         // var expiredAt = new Date(item.expiredAt);
    //         var user = JSON.stringify(item);
    //         bodyContent += "<tr>";
    //         bodyContent += "<td>" + item.id + "</td>";
    //         bodyContent += "<td>" + item.account + "</td>";
    //         bodyContent += "<td>" + item.email + "</td>";
    //         bodyContent += "<td class='price_storage'>" + item.balance + "</td>";
    //         // bodyContent += "<td>" + time + "</td>";
    //         // bodyContent += "<td>" + createdBy.account + "</td>";
    //         bodyContent += `<td> <button class="btn" style="background-color: #01b901;color: #ffffff;cursor: pointer;"onclick='showUpdateDiv(JSON.stringify(` + user + `))'>Thông tin </button> </td>`
    //         bodyContent += `<td> <button class="btn" style="background-color: #cc2127;color: #ffffff;cursor: pointer;" onclick="showDeleteAlert(` + item.id + `)"> Nạp tiền  </button>  </td>`
    //         bodyContent += "</tr>";
    //     });
    //     tableBody.innerHTML = bodyContent;
    //     var priceStorage = document.querySelectorAll(".price_storage");
    //     priceStorage.forEach(p => {
    //         p.innerText = parseInt(p.innerText).toLocaleString();
    //     });
    // }

    $('#priceSelect').change(() => {
        getData(1);
    });
    $('#supplierSelect').change(() => {
        getData(1);
    })
    $('#searchInput').on('input', () => {
        getData(1);
    })

    // Convert price below format 1,000
    var priceStorage = document.querySelectorAll(".ballace_user");
    priceStorage.forEach(p => {
        p.innerText = parseInt(p.innerText).toLocaleString();
    });

    // function showDeleteAlert(id) {
    //     if (parseInt(id) > 0) {
    //         document.getElementById("idInputDeleteDiv").value = id;
    //     }
    //     var blur = document.getElementById('blur');
    //     blur.classList.toggle('activete');
    //     var popup = document.getElementById('popupDelete');
    //     popup.classList.toggle('activete');
    // }

    function showUpdateDiv(user) {
        if (user !== '') {
            const div = document.getElementById("updateDiv");
            const closeButton = document.getElementById("closeButton");
            const body = document.querySelector(".wrapper");
            var json = JSON.parse(user);
            console.log(json);
            // var expiredAt = new Date(json.expiredAt);
            // var timeExpiredAt = expiredAt.getFullYear() + "-" +
            //     ("0" + (expiredAt.getMonth() + 1)).slice(-2) + "-" +
            //     ("0" + expiredAt.getDate()).slice(-2) + " " +
            //     ("0" + expiredAt.getHours()).slice(-2) + ":" +
            //     ("0" + expiredAt.getMinutes()).slice(-2) + ":" +
            //     ("0" + expiredAt.getSeconds()).slice(-2);
            // json.expiredAt = timeExpiredAt;
            document.getElementById("idInputUpdateDiv").value = json.id;
            document.getElementById("accountInputUpdateDiv").value = json.account;
            document.getElementById("passwordInputUpdateDiv").value = json.password;
            document.getElementById("roleInputUpdateDiv").value = json.role;
            document.getElementById("emailInputUpdateDiv").value = json.email;
            // document.getElementById("createdAtInputUpdateDiv").value = json.createdAt;
            document.getElementById("balanceInputUpdateDiv").value = json.balance;
            document.getElementById("phoneInputUpdateDiv").value = json.phoneNumber;
            document.getElementById("isActiveInputUpdateDiv").value = json.isActive;

        }
        var blur = document.getElementById('blur');
        blur.classList.toggle('activete');
        var popup = document.getElementById('popup');
        popup.classList.toggle('activete');
    }
    function showAddMoneyDiv(user) {
        if (user !== '') {
            const div = document.getElementById("showAddMoneyDiv");
            const closeButton1 = document.getElementById("closeButton1");
            const body = document.querySelector(".wrapper");
            var json = JSON.parse(user);
            console.log(json);
            // var expiredAt = new Date(json.expiredAt);
            // var timeExpiredAt = expiredAt.getFullYear() + "-" +
            //     ("0" + (expiredAt.getMonth() + 1)).slice(-2) + "-" +
            //     ("0" + expiredAt.getDate()).slice(-2) + " " +
            //     ("0" + expiredAt.getHours()).slice(-2) + ":" +
            //     ("0" + expiredAt.getMinutes()).slice(-2) + ":" +
            //     ("0" + expiredAt.getSeconds()).slice(-2);
            // json.expiredAt = timeExpiredAt;
            document.getElementById("idInput").value = json.id;
            document.getElementById("accountInput").value = json.account;


        }
        var blur = document.getElementById('blur');
        blur.classList.toggle('activete');
        var popupAddMoney = document.getElementById('popupAddMoney');
        popupAddMoney.classList.toggle('activete');
    }

    $("#isActiveInputUpdateDiv").on('change', function() {
        if ($(this).is(':checked')) {
            $(this).attr('value', 'true');
        }
        else {
            $(this).attr('value', 'false');
        }});

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
