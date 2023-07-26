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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
        #blur.activete {
            filter: blur(20px);
            pointer-events: none;
            user-select: none;
        }

        #listErrorDiv {
            position: fixed;
            top: 40%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 800px;
            max-height: 800px;
            padding: 50px;
            box-shadow: 0 5px 30px rgba(0, 0, 0, .30);
            background: #fff;
            visibility: hidden;
            opacity: 0;
            transition: 0.5s;
            z-index: 999;
        }

        #listErrorDiv.activete {
            top: 50%;
            visibility: visible;
            opacity: 1;
            transform: 0.5s;
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
            z-index: 999;
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
            z-index: 999;
        }

        #popupDelete.activete {
            top: 50%;
            visibility: visible;
            opacity: 1;
            transform: 0.5s;
        }

        #popupAddProduct {
            position: fixed;
            top: 40%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 800px;
            padding: 50px;
            box-shadow: 0 5px 30px rgba(0, 0, 0, .30);
            background: #fff;
            visibility: hidden;
            opacity: 0;
            transition: 0.5s;
            z-index: 999;
        }

        #popupAddProduct.activete {
            top: 50%;
            visibility: visible;
            opacity: 1;
            transform: 0.5s;
        }

        #addProductButton {
            display: inline-block;
            border-radius: 7px;
            border: none;
            background: #1875FF;
            color: white;
            font-family: inherit;
            text-align: center;
            font-size: 13px;
            box-shadow: 0px 14px 56px -11px #1875FF;
            width: 12em;
            padding: 1em;
            transition: all 0.4s;
            cursor: pointer;
        }

        #addProductButton span {
            cursor: pointer;
            display: inline-block;
            position: relative;
            transition: 0.4s;
        }

        #addProductButton span:after {
            content: 'sản phẩm';
            position: absolute;
            opacity: 0;
            top: 0;
            right: -20px;
            transition: 0.7s;
        }

        #addProductButton:hover span {
            padding-right: 4.6em;
        }

        #addProductButton:hover span:after {
            opacity: 4;
            right: 0;
        }
    </style>
</head>

<body>
<div id="popupDelete">
    <h4 style="text-align: center"><b>Bạn có chắc muốn xóa chứ</b></h4>
    <form action="storage" method="post" class="justify-content-around d-flex">
        <input name="id" id="idInputDeleteDiv" class="d-none">
        <input name="page" id="pageInputDeleteDiv" class="d-none">
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

<div id="popupAddProduct">
    <%--    <form action="products" method="post" enctype="multipart/form-data">--%>
    <div class="row pl-1" style="width: fit-content;margin-left: auto">
        <button type="button" aria-hidden="true" class="close" data-dismiss="alert" id="closeAddProductButton"
                style="cursor: pointer" onclick="showAddDiv()">
            <i class="nc-icon nc-simple-remove" style="font-size: 25px;font-weight: bold;"></i>
        </button>
    </div>
    <div class="row" style="margin-bottom: 10px;">
        <div class="col-md-8 pr-1">
            <label>Nhà phát hành: </label>
            <select id="supplierSelectAddProduct" name="supplierSelect" class="h-100 border-0"
                    style="background-color: transparent;color: #5e5e5e;cursor: pointer">
            </select>
            <input type="text" name="supplierInput" id="supplierInputAddProduct" class="d-none">
            <button type="button" style="border: 0.5px solid #1b1e21;border-radius: 5px;cursor: pointer" onclick="function changeSupplier() {
                var supplierInput = document.getElementById('supplierInputAddProduct');
                var supplierSelect = document.getElementById('supplierSelectAddProduct');
                var productSelect = document.getElementById('productSelectAddProduct');
                var productInput = document.getElementById('productInputAddProduct');
                supplierSelect.classList.toggle('d-none');
                supplierInput.classList.toggle('d-none');
                document.getElementById('imageDiv').classList.toggle('d-none');
                document.getElementById('imageDiv').value = '';
                if (supplierInput.classList.contains('d-none')) {
                    supplierInput.value = '';

                } else {
                    supplierSelect.value = '';
                }
                if (supplierSelect.classList.contains('d-none')) {
                    if (!productSelect.classList.contains('d-none')) {
                        productSelect.classList.toggle('d-none');
                        productInput.classList.toggle('d-none');
                    }
                }
                if (productInput.classList.contains('d-none')) {
                    if (!document.getElementById('productPrice').classList.contains('d-none')) {
                        document.getElementById('productPrice').classList.toggle('d-none');
                        document.getElementById('productPrice').value = '';
                    }
                } else {
                    if (document.getElementById('productPrice').classList.contains('d-none')) {
                        document.getElementById('productPrice').classList.toggle('d-none');

                    }
                }
            }
            changeSupplier()">
                <span><i class="fa fa-plus"></i></span>
            </button>
        </div>
    </div>
    <div id="imageDiv" class="row d-none" style="margin-bottom: 10px;">
        <label>Đường dẫn ảnh: </label>
        <input id="image" type="text" name="image">
    </div>
    <div class="row" style="margin-bottom: 10px;">
        <div class="col-md-8 pr-1">
            <label>Sản phẩm: </label>
            <select id="productSelectAddProduct" name="productSelect" class="h-100 border-0"
                    style="background-color: transparent;color: #5e5e5e;cursor: pointer">
            </select>
            <input type="text" name="productInput" id="productInputAddProduct" class="d-none">
            <button type="button" style="border: 0.5px solid #1b1e21;border-radius: 5px;cursor: pointer" onclick="function changeProduct() {
                var supplierInput = document.getElementById('supplierInputAddProduct');
                var supplierSelect = document.getElementById('supplierSelectAddProduct');
                var productSelect = document.getElementById('productSelectAddProduct');
                var productInput = document.getElementById('productInputAddProduct');
                productSelect.classList.toggle('d-none');
                productInput.classList.toggle('d-none');
                if (productInput.classList.contains('d-none')) {
                    if (!document.getElementById('productPrice').classList.contains('d-none')) {
                        document.getElementById('productPrice').classList.toggle('d-none');
                        document.getElementById('productPrice').value = '';
                    } else {
                        document.getElementById('productPrice').value = '';
                    }
                    productInput.value = '';
                } else {
                    if (document.getElementById('productPrice').classList.contains('d-none')) {
                        document.getElementById('productPrice').classList.toggle('d-none');
                        document.getElementById('productPrice').value = '';
                    } else {
                        document.getElementById('productPrice').value = '';
                    }
                    productSelect.value = '';
                }
                // if (!productInput.classList.contains('d-none')) {
                //     document.getElementById('productPrice').classList.toggle('d-none');
                // }
                if (supplierSelect.classList.contains('d-none')) {
                    if (!productSelect.classList.contains('d-none')) {
                        productSelect.classList.toggle('d-none');
                        // productInput.classList.toggle('d-none');
                    }
                }
            }
            changeProduct()">
                <span id="buttonAddSupplier"><i class="fa fa-plus"></i></span>
            </button>
        </div>
    </div>
    <div id="productPrice" class="row d-none" style="margin-bottom: 10px;">
        <div class="col-md-8 pr-1">
            <label>Giá: </label>
            <input id="price" type="number" name="productPrice">
        </div>
    </div>
    <div class="row" style="margin-bottom: 10px;">
        <div class="col-md-8 pr-1">
            <label>Chọn file excel: </label>
            <input id="fileData" type="text" name="fileData" class="d-none">
            <input id="fileInput" type="file"
                   accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, application/vnd.ms-excel">
        </div>
    </div>
    <div class="row d-flex justify-content-around" style="margin-bottom: 10px;">
        <button type="button" aria-hidden="true" class=""
                style="color: white;cursor: pointer;border-radius: 5px;background-color: #ef2b65;padding: 0 10px;"
                onclick="showAddDiv()">
            Đóng
        </button>
        <button id="submitProductButton" type="button" name="option" value="add" class="btn"
                style="cursor: pointer;background-color: #01b901;color: #ffffff;">
            Thêm
        </button>
    </div>
    <%--    </form>--%>
</div>
<div id="listErrorDiv" style="overflow: scroll;">
    <div class="row pl-1" style="width: fit-content;margin-left: auto">
        <button type="button" aria-hidden="true" class="close" data-dismiss="alert" id="closeAddProductButton"
                style="cursor: pointer" onclick="showErrorList('')">
            <i class="nc-icon nc-simple-remove" style="font-size: 25px;font-weight: bold;"></i>
        </button>
    </div>
    <div class="row d-flex justify-content-center">
        <div class="row">
            <h2 style="color: red">Sản phẩm đã loại bỏ do trùng lặp</h2>
        </div>
        <table style="">
            <thead>
            <tr>
                <th style="height: 30px;font-size: 1.5em;margin: 0px">Số Seri</th>
                <th style="height: 30px;font-size: 1.5em;margin: 0px">Số thẻ</th>
            </tr>
            </thead>
            <tbody id="listErrorDivTable" class="w-100 justify-content-around">

            </tbody>
        </table>
    </div>
    <div class="row pr-1" style="margin-top: 20px;">
        <button type="button" aria-hidden="true" class=""
                style="color: white;cursor: pointer;border-radius: 5px;background-color: #ef2b65;padding: 10px 10px;"
                onclick="showErrorList('')">
            Đóng
        </button>
    </div>
</div>
<div id="popup">
    <div class="row pl-1" style="width: fit-content;margin-left: auto">
        <button type="button" aria-hidden="true" class="close" data-dismiss="alert" id="closeButton"
                style="cursor: pointer" onclick="showUpdateDiv('')">
            <i class="nc-icon nc-simple-remove" style="font-size: 25px;font-weight: bold;"></i>
        </button>
    </div>
    <form action="products" method="post" class="">
        <div class="row">
            <div class="col-md-8 pr-1">
                <div class="form-group">
                    <input name="page" id="pageInputUpdateDiv" class="d-none">
                    <label>Id</label>
                    <input type="text" class="form-control" id="idInputUpdateDiv"
                           readonly name="id">
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-8 pr-1">
                <div class="form-group">
                    <label>Tên</label>
                    <input type="text" class="form-control" id="nameInputUpdateDiv"
                           name="name">
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-8 pr-1">
                <div class="form-group">
                    <label>Giá</label>
                    <input type="number" class="form-control" id="priceInputUpdateDiv"
                           name="price">
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-8 pr-1">
                <div class="form-group">
                    <label>Số lượng còn lại</label>
                    <input type="number" class="form-control" id="quantityInputUpdateDiv"
                           name="quantity">
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
                <li class="nav-item active">
                    <a class="nav-link" href="products">
                        <i class="nc-icon nc-atom"></i>
                        <p>Sản phẩm</p>
                    </a>
                </li>
                <li>
                    <a class="nav-link" href="users">
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
                <a class="navbar-brand" href="products"> Sản phẩm </a>
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
                <div class="row d-flex justify-content-center" style="margin-bottom: 20px;">
                    <button id="addProductButton" style="vertical-align:middle">
                        <span>Thêm</span>
                    </button>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="card strpied-tabled-with-hover">
                            <div class="card-body table-full-width table-responsive">
                                <table class="table table-hover table-striped">
                                    <thead>
                                    <th>ID</th>
                                    <th>Ảnh</th>
                                    <th>Tên sản phẩm</th>
                                    <th>Giá</th>
                                    <th>Số lượng</th>
                                    <th>Tạo lúc</th>
                                    <th>Tạo bởi</th>
                                    <th>Hành động</th>
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
                            <a href="/">
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
<script src="${pageContext.request.contextPath}/js/xlsx.full.min.js"></script>
<script type="text/javascript">

    $(document).ready(function () {
        $.ajax({
            url: "api/v1/products",
            type: "GET",
            dataType: "json",
            success: function (response) {
                loadPagination(JSON.stringify(response.pagination));
                loadContentList(JSON.stringify(response.listProduct));
                loadlistProduct(JSON.stringify(response.listPrice));
                loadListSupplier(JSON.stringify(response.listSupplier));
                loadListProductForAddDiv(JSON.stringify(response.listProductBySubblier));
            }
        });
    });

    function loadListProductForAddDiv(data) {
        var listProduct = JSON.parse(data);
        $('#productSelectAddProduct').empty();
        $.each(listProduct, function (i, product) {
            $('#productSelectAddProduct').append($('<option>').val(product.id)
                .text(product.name));
        });
    }

    $("#supplierSelectAddProduct").change(() => {
        getData(1)
    });

    $('#submitProductButton').click(uploadProduct);

    $('#addProductButton').click(showAddDiv);

    $('#updateButton').click(updateStorage);

    $('#deleteButton').click(deleteStorage);

    function readFile() {
        const fileInput = document.getElementById('fileInput');

        if (!fileInput.files.length) {
            alert('Vui lòng chọn một file');
            return;
        }

        const file = fileInput.files[0];
        const reader = new FileReader();

        reader.onload = function (event) {
            const data = event.target.result;
            const workbook = XLSX.read(data, {type: 'binary'});
            const sheetName = workbook.SheetNames[0]; // Assuming you want to read the first sheet

            const sheet = workbook.Sheets[sheetName];
            const jsonData = XLSX.utils.sheet_to_json(sheet);
            displayData(jsonData);

        };
        reader.readAsBinaryString(file);
    }

    function displayData(data) {
        var fileData = document.getElementById("fileData");
        fileData.value = JSON.stringify(data, null, 2);
        var data = {
            supplierSelect: $("#supplierSelectAddProduct").val(),
            supplierInput: $("#supplierInputAddProduct").val(),
            productSelect: $("#productSelectAddProduct").val(),
            productInput: $("#productInputAddProduct").val(),
            option: $("#submitProductButton").val(),
            image: $("#image").val(),
            productPrice: $("#price").val(),
            fileData: $('#fileData').val(),
        };
        $.ajax({
            url: "/api/v1/products",
            type: "POST",
            data: data,
            dataType: "json",
            success: function (response) {
                setTimeout(demo.showNotify(response.message), 100);
                console.log(response.errorList);
                if (response.errorList != null && response.errorList != "") {
                    showErrorList(JSON.stringify(response.errorList));
                }
            }
        });

    }

    function uploadProduct() {
        readFile();
    }

    function showErrorList(data) {
        showAddDiv();
        var blur = document.getElementById('blur');
        blur.classList.toggle('activete');
        var popup = document.getElementById('listErrorDiv');
        popup.classList.toggle('activete');
        if (data != '') {
            var tableBody = document.getElementById("listErrorDivTable");
            var list = JSON.parse(data);
            var bodyContent = "";
            list.forEach(item => {
                console.log(item);
                bodyContent += "<tr class=' w-100 justify-content-around' style='display: flex;border-top: 0.5px solid #000000;margin-bottom: 10px'>";
                bodyContent += "<td style='margin-right: 30px;height: 30px;display: flex;font-size: 1.5em'>" + item.serialNumber + "</td>";
                bodyContent += "<td style='height: 30px;font-size: 1.5em'>" + item.cardNumber + "</td>";
                bodyContent += "</tr>";
            });
            tableBody.innerHTML = bodyContent;
        }
    }

    function showAddDiv() {
        var blur = document.getElementById('blur');
        blur.classList.toggle('activete');
        var popup = document.getElementById('popupAddProduct');
        popup.classList.toggle('activete');
    }

    function updateStorage() {
        var data = {
            id: $('#idInputUpdateDiv').val(),
            name: $('#nameInputUpdateDiv').val(),
            price: $('#priceInputUpdateDiv').val(),
            quantity: $('#quantityInputUpdateDiv').val(),
        };
        $.ajax({
            url: "/api/v1/products",
            type: "POST",
            data: data,
            dataType: "json",
            success: function (response) {
                setTimeout(demo.showNotify(response.message), 100);
                console.log(response.message);
                getData(1);
            }
        });
    }

    function deleteStorage() {
        var data = {
            id: $('#idInputDeleteDiv').val()
        };
        $.ajax({
            url: "api/v1/products?id=" + data.id,
            type: "DELETE",
            data: data,
            dataType: "json",
            success: function (response) {
                setTimeout(demo.showNotify(response.message), 100);
                getData(1);
            }
        });
    }

    function getData(page) {
        console.log("getData");
        $.ajax({
            url: "api/v1/products?page=" + page + "&supplier=" + $('#supplierSelect').val() + "&price=" + $('#priceSelect').val() + "&search=" + $('#searchInput').val() + "&supplierAddProduct=" + $('#supplierSelectAddProduct').val(),
            type: "GET",
            dataType: "json",
            success: function (response) {
                loadPagination(JSON.stringify(response.pagination));
                loadContentList(JSON.stringify(response.listProduct));
                loadListProductForAddDiv(JSON.stringify(response.listProductBySubblier));
            }
        });
    }

    function loadPagination(data) {
        var dataPage = JSON.parse(data);
        var pageNumber = parseInt(dataPage.pageNumber);
        var totalPage = parseInt(dataPage.totalPageNumbers);
        document.getElementById("pageInputDeleteDiv").value = pageNumber;
        document.getElementById("pageInputUpdateDiv").value = pageNumber;
        document.getElementById('pagination').innerHTML = createPagination(totalPage, pageNumber);
    }

    function loadlistProduct(data) {
        var listProduct = JSON.parse(data);
        $.each(listProduct, function (i, product) {
            $('#priceSelect').append($('<option>').val(product)
                .text(parseInt(product).toLocaleString()));
        });
    }

    function loadListSupplier(data) {
        var listProduct = JSON.parse(data);
        $.each(listProduct, function (i, supplier) {
            $('#supplierSelect').append($('<option>').val(supplier.id)
                .text(supplier.name));
            $('#supplierSelectAddProduct').append($('<option>').val(supplier.id)
                .text(supplier.name));
        });
    }

    function loadContentList(data) {
        const tableInfo = document.querySelector(".table");
        var tableBody = tableInfo.querySelector("tbody");
        var list = JSON.parse(data);
        var bodyContent = "";
        list.forEach(item => {
            var createdBy = JSON.parse(JSON.stringify(item.createdBy));
            var m = new Date(item.createdAt);
            var time = m.getFullYear() + "-" +
                ("0" + (m.getMonth() + 1)).slice(-2) + "-" +
                ("0" + m.getDate()).slice(-2) + " " +
                ("0" + m.getHours()).slice(-2) + ":" +
                ("0" + m.getMinutes()).slice(-2) + ":" +
                ("0" + m.getSeconds()).slice(-2);
            var storage = JSON.stringify(item);
            bodyContent += "<tr>";
            bodyContent += "<td>" + item.id + "</td>";
            bodyContent += "<td><img style='width: 100px;' src='" + item.supplier.image + "'>"
            bodyContent += "<td>" + item.name + "</td>";
            bodyContent += "<td class='price_storage'>" + item.price + "</td>";
            bodyContent += "<td class='price_storage'>" + item.quantity + "</td>";
            bodyContent += "<td>" + time + "</td>";
            bodyContent += "<td>" + createdBy.account + "</td>";
            bodyContent += `<td> <button class="btn" style="background-color: #01b901;color: #ffffff;cursor: pointer;"onclick='showUpdateDiv(JSON.stringify(` + storage + `))'>Thông tin </button> </td>`
            bodyContent += `<td> <button class="btn" style="background-color: #cc2127;color: #ffffff;cursor: pointer;" onclick="showDeleteAlert(` + item.id + `)"> Xóa  </button>  </td>`
            bodyContent += "</tr>";
        });
        tableBody.innerHTML = bodyContent;
        var priceStorage = document.querySelectorAll(".price_storage");
        priceStorage.forEach(p => {
            p.innerText = parseInt(p.innerText).toLocaleString();
        });
    }

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
    var priceStorage = document.querySelectorAll(".price_storage");
    priceStorage.forEach(p => {
        p.innerText = parseInt(p.innerText).toLocaleString();
    });

    function showDeleteAlert(id) {
        if (parseInt(id) > 0) {
            document.getElementById("idInputDeleteDiv").value = id;
        }
        var blur = document.getElementById('blur');
        blur.classList.toggle('activete');
        var popup = document.getElementById('popupDelete');
        popup.classList.toggle('activete');
    }

    function showUpdateDiv(storage) {
        if (storage !== '') {
            var json = JSON.parse(storage);
            var expiredAt = new Date(json.expiredAt);
            var timeExpiredAt = expiredAt.getFullYear() + "-" +
                ("0" + (expiredAt.getMonth() + 1)).slice(-2) + "-" +
                ("0" + expiredAt.getDate()).slice(-2) + " " +
                ("0" + expiredAt.getHours()).slice(-2) + ":" +
                ("0" + expiredAt.getMinutes()).slice(-2) + ":" +
                ("0" + expiredAt.getSeconds()).slice(-2);
            json.expiredAt = timeExpiredAt;
            document.getElementById("idInputUpdateDiv").value = json.id;
            document.getElementById("nameInputUpdateDiv").value = json.name;
            document.getElementById("priceInputUpdateDiv").value = json.price;
            document.getElementById("quantityInputUpdateDiv").value = json.quantity;
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