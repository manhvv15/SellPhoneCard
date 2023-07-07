<%-- 
    Document   : home
    Created on : May 26, 2023, 4:43:42 PM
    Author     : hp
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@page import="java.util.ArrayList" %>
<%@page import="model.Supplier" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link href="${pageContext.request.contextPath}/admin/assets/css/light-bootstrap-dashboard.css?v=2.0.0 "
          rel="stylesheet"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
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
                        <li><span style="color: #ffffff;font-size: 20px;line-height: 60px">Số dư: <span
                                id="balanceValue">${user.getBalance()}</span></span></li>
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
<div class="main" style="margin-top: 80px;">
    <div class="content-header container-fluid text-center" style="margin-bottom: 50px;">
        <p style="color: #8a8a8a">[ DỊCH VỤ ]</p>
        <h1 style="color: #000000">MUA THẺ ĐIỆN THOẠI ONLINE</h1>
        <h2 style="color: #000000">MUA THẺ ĐIỆN THOẠI, MUA THẺ CÀO ONLINE GIÁ ĐÚNG</h2>
    </div>
    <div class="container">
        <div class="radio-inputs container justify-content-between" style="margin-bottom: 100px;">
            <c:forEach var="s" items="${imgList}">
                <label style="height: 130px;width: 24%" class="d-flex justify-content-center">
                    <input class="radio-input" type="radio" name="supplier" ${(s.getId() == 1 ? "checked" : "")}
                           value="${s.getId()}">
                    <span class="radio-tile w-100" style="border-radius: 10px;">
                                <span class="radio-icon">
                                    <img style="max-width: 98%;height: auto;object-fit: cover" src="${s.getImage()}"
                                         alt="${s.getName()}"/>
                                </span>
                            </span>
                </label>
            </c:forEach>
        </div>
        <div class="row justify-content-around" style="margin-bottom: 50px;">
            <div class="price-div col-5">
                <div class="row justify-content-between" style="height: fit-content;margin-bottom: 50px">
                    <label style="height: 50px;width: 45%" class="d-flex justify-content-center">
                        <input class="radio-input" type="radio" value="10000" name="price" checked>
                        <span class="radio-tile w-100" style="border-radius: 10px;">
                                <span class="radio-icon">
                                    10.000đ
                                </span>
                            </span>
                    </label>
                    <label style="height: 50px;width: 45%" class="d-flex justify-content-center">
                        <input class="radio-input" type="radio" value="20000" name="price">
                        <span class="radio-tile w-100" style="border-radius: 10px;">
                                <span class="radio-icon">
                                    20.000đ
                                </span>
                            </span>
                    </label>
                </div>
                <div class="row justify-content-between" style="height: fit-content;margin-bottom: 50px">
                    <label style="height: 50px;width: 45%" class="d-flex justify-content-center">
                        <input class="radio-input" type="radio" value="30000" name="price">
                        <span class="radio-tile w-100" style="border-radius: 10px;">
                                <span class="radio-icon">
                                    30.000đ
                                </span>
                            </span>
                    </label>
                    <label style="height: 50px;width: 45%" class="d-flex justify-content-center">
                        <input class="radio-input" type="radio" value="50000" name="price">
                        <span class="radio-tile w-100" style="border-radius: 10px;">
                                <span class="radio-icon">
                                    50.000đ
                                </span>
                            </span>
                    </label>
                </div>
                <div class="row justify-content-between" style="height: fit-content;margin-bottom: 50px">
                    <label style="height: 50px;width: 45%" class="d-flex justify-content-center">
                        <input class="radio-input" type="radio" value="100000" name="price">
                        <span class="radio-tile w-100" style="border-radius: 10px;">
                                <span class="radio-icon">
                                    100.000đ
                                </span>
                            </span>
                    </label>
                    <label style="height: 50px;width: 45%" class="d-flex justify-content-center">
                        <input class="radio-input" type="radio" value="200000" name="price">
                        <span class="radio-tile w-100" style="border-radius: 10px;">
                                <span class="radio-icon">
                                    200.000đ
                                </span>
                            </span>
                    </label>
                </div>
                <div class="row justify-content-between" style="height: fit-content;margin-bottom: 50px">
                    <label style="height: 50px;width: 45%" class="d-flex justify-content-center">
                        <input class="radio-input" type="radio" value="300000" name="price">
                        <span class="radio-tile w-100" style="border-radius: 10px;">
                                <span class="radio-icon">
                                    300.000đ
                                </span>
                            </span>
                    </label>
                    <label style="height: 50px;width: 45%" class="d-flex justify-content-center">
                        <input class="radio-input" type="radio" value="500000" name="price">
                        <span class="radio-tile w-100" style="border-radius: 10px;">
                                <span class="radio-icon">
                                    500.000đ
                                </span>
                            </span>
                    </label>
                </div>
            </div>
            <div id="infoOrder" class="content-product col-5 d-none"
                 style="border: 15px solid #1ca799;border-radius: 10px;height: 550px;box-shadow: 0 5px 10px #5e5e5e">
                <form action="buyCard" method="post" id="frm">
                    <div class="row text-center justify-content-center"
                         style="background-color: #55b3f7;padding: 30px 0;margin-bottom: 20px">
                        <h2 style="color: #ffffff;text-align: center;">Thông tin đơn hàng</h2>
                    </div>
                    <div class="row pr-1 text-center justify-content-center" style="">
                        <label style="font-weight: 700;line-height: 30px;font-size: 17px">Nhà phát hành: </label>
                        <p style="font-weight: 700;line-height: 30px;font-size: 17px;margin-left: 20px;"
                           id="supplierName"></p>
                    </div>
                    <div class="row pr-1 justify-content-center" style="">
                        <label style="font-weight: 700;line-height: 30px;font-size: 17px">Mệnh giá: </label>
                        <p style="font-weight: 700;line-height: 30px;font-size: 17px;margin-left: 20px;"
                           id="priceValue"></p>
                    </div>
                    <div class="row pr-1 justify-content-center" style="">
                        <label style="font-weight: 700;line-height: 30px;font-size: 17px">Số lượng: </label>
                        <input style="width: 80px;margin: 0 20px;height: 30px;border-radius: 5px;border: 0.5px solid #000000;"
                               type="number" maxlength="7" min="1" max="1000000" id="quantityValue" name="quantity"
                               value="1"
                               class="input_card text-center" placeholder="Số lượng thẻ cần mua"
                               title="Số lượng thẻ"
                        >
                    </div>
                    <div class="row pr-1 justify-content-center" style="">
                        <label style="font-weight: 700;line-height: 30px;font-size: 17px;margin-right: 10px;">Email:</label>
                        <input class="col-7" name="email" id="emailValue" value="${user.getEmail()}"
                               style="background-color: #ffffff;border-radius: 5px"
                        ${(user == null) ? "disabled placeholder='Đăng nhập để thanh toán'" : ""}>
                    </div>
                    <div class="row pr-1 justify-content-center" style="margin-top: 20px;">
                        <textarea class="w-75 form-control" id="noteValue" placeholder="Ghi chú cho đơn hàng"
                                  style="max-height: 150px;height: 100px;"></textarea>
                    </div>
                    <div class="row d-flex flex-wrap justify-content-around form-outline w-100"
                         style="position: absolute;bottom: 10px;">
                        <button id="pay" name="option" value="buy" type="button" class="btn"
                                style="cursor: pointer;background-color: #25597b;border-radius: 10px; color: #ffffff;font-weight: 700;line-height:20px;padding: 10px 23px;text-align: center">
                            Thanh toán ngay
                        </button>
                        <button type="button" id="cancelOrder" class="btn"
                                style="cursor: pointer;align-items: flex-start;background-color: #ffffff;border-radius: 10px;color: #ff8c00;font-weight: 700;line-height: 20px;font-size: 17px;padding: 10px 23px;text-align: center;border: 1px solid #ff8c00;">
                            Hủy giao dịch
                        </button>
                    </div>
                </form>
            </div>
        </div>
        <div class="row">
            <div class="quantity-div d-flex flex-wrap" style="margin-left: 10%;width: 90%;">
                <label style="font-size: 18px;font-weight: 500;margin-right: 25px;line-height: 30px;">Số lượng thẻ
                    cần mua</label>
                <span class="down_number" style="cursor: s-resize;">
                        <svg width="40" height="40" viewBox="0 0 40 40"
                             fill="none"
                             xmlns="http://www.w3.org/2000/svg">
                                                <circle cx="20" cy="20" r="20" fill="#1CA799"></circle>
                                                <line x1="10" y1="19" x2="31" y2="19" stroke="white"
                                                      stroke-width="2"></line>
                        </svg>
                    </span>
                <input style="width: 80px;margin: 0 20px;height: 40px;border-radius: 5px;border: 0.5px solid #000000;"
                       type="number" maxlength="7" min="1" max="1000000" id="ctrlsoluongthe" name="quantity"
                       value="1"
                       class="input_card text-center" placeholder="Số lượng" title="Số lượng thẻ"
                >
                <span class="up_number" style="cursor: n-resize;">
                        <svg width="40" height="40" viewBox="0 0 40 40" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                <circle cx="20" cy="20" r="20" fill="#1CA799"></circle>
                                                <line x1="10" y1="20" x2="31" y2="20" stroke="white"
                                                      stroke-width="2"></line>
                                                <line x1="20" y1="30" x2="20" y2="9" stroke="white"
                                                      stroke-width="2"></line>
                        </svg>
                    </span>
            </div>
        </div>
    </div>
    <div class="row justify-content-center d-flex" style="margin-top: 20px;">
        <button id="buyNow-btn" name="option" value="buy" type="button" class="btn"
                style="cursor: pointer;background-color: #1ca799;border-radius: 10px; color: #ffffff;font-weight: 500;line-height: 36px;margin: 0px 20px 0px 0px;padding: 9px 31px;text-align: center">
            Mua ngay
        </button>
        <%--            <button name="option" type="submit" value="addToCart" class="btn" style="cursor: pointer;align-items: flex-start;background-color: #25597b;border-radius: 10px;color: #ffffff;font-weight: 500;line-height: 36px;padding: 9px 31px;text-align: center">--%>
        <%--                Thêm vào giỏ hàng--%>
        <%--            </button>--%>
    </div>

</div>
<footer class="footer" style="background-color: #000000;margin-top: 40px;">
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

<!--   Core JS Files   -->
<script src="${pageContext.request.contextPath}/admin/assets/js/core/jquery.3.2.1.min.js"
        type="text/javascript"></script>
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
        setTimeout(demo.showNotify("${message}"), 100);
    </script>
</c:if>

<script>
    document.getElementById("pay").addEventListener('click', buyProduct);
    setInterval(() =>{
        $.ajax({
            url: "/api/v1/scanNotice",
            dataType: "json",
            success: function (response) {
                var listMessage = JSON.parse(response.listMessage);
                console.log(listMessage);
                $.each(listMessage, function (i, message) {
                    console.log(message);
                    setTimeout(demo.showNotify(message), 1000);
                });
            }
        });
    }, 10000);

    function buyProduct() {
        <c:if test="${user == null}">
        document.querySelector("#frm").submit();
        </c:if>
        var data = {
            price: document.getElementById("priceValue").innerHTML,
            supplier: document.getElementById("supplierName").innerHTML,
            quantity: document.getElementById("quantityValue").value,
            noteValue: document.getElementById("noteValue").value
        };
        $.ajax({
            url: "buyCard",
            type: 'POST',
            data: data,
            dataType: "json",
            success: function (response) {
                setTimeout(demo.showNotify(response.message), 100);
            }
        });
    }

    <c:if test="${user != null}">
    document.getElementById("balanceValue").innerText = parseInt(document.getElementById("balanceValue").innerText).toLocaleString();
    </c:if>

    const quantityInput = document.getElementById("ctrlsoluongthe");
    var quantityDiv = document.querySelector(".quantity-div");
    var upQuantity = quantityDiv.querySelector(".up_number");
    var downQuantity = quantityDiv.querySelector(".down_number");
    var buyNowBtn = document.getElementById("buyNow-btn");

    document.getElementById("cancelOrder").addEventListener('click', function () {
        infoOrder.classList.add("d-none");
    });

    buyNowBtn.addEventListener('click', function () {
        var infoOrder = document.getElementById("infoOrder");
        document.getElementById("supplierName").innerHTML = document.querySelector('input[name="supplier"]:checked').value;
        document.getElementById("priceValue").innerHTML = document.querySelector('input[name="price"]:checked').value;
        document.getElementById("quantityValue").value = quantityInput.value;
        infoOrder.classList.remove("d-none");
    });
    upQuantity.addEventListener('click', function () {
        quantityInput.value = (parseInt(quantityInput.value) + 1);
    });
    downQuantity.addEventListener('click', function () {
        if (parseInt(quantityInput.value) > 1) {
            quantityInput.value = (parseInt(quantityInput.value) - 1);
        }
    });
</script>

</body>

</html>
