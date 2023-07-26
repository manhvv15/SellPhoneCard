<%-- 
    Document   : contact
    Created on : Jun 20, 2023, 4:27:48 AM
    Author     : Admin
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page isELIgnored="false" %>
<!doctype html>
<html lang="en">
<head>
    <title>Contact Form 04</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <link href='https://fonts.googleapis.com/css?family=Roboto:400,100,300,700' rel='stylesheet' type='text/css'>

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">

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
<section class="ftco-section">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-6 text-center mb-5">
                <h2 class="heading-section">Liên hệ</h2>
            </div>
        </div>
        <div class="row justify-content-center">
            <div class="col-md-10">
                <div class="wrapper">
                    <div class="row no-gutters">
                        <div class="col-md-6">
                            <div class="contact-wrap w-100 p-lg-5 p-4">
                                <h3 class="mb-4">Nếu có thắc mắc, hãy gửi cho chúng tôi</h3>
                                <div class="mb-4">
                                    ${error}
                                </div>
                                <form action="contact" method="get" id="contactForm" name="contactForm" class="contactForm">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <input type="text" class="form-control" name="name" id="name"
                                                       placeholder="User name">
                                            </div>
                                        </div>
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <input type="email" class="form-control" name="email" id="email"
                                                       placeholder="Email">
                                            </div>
                                        </div>
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <input type="text" class="form-control" name="subject" id="subject"
                                                       placeholder="Tiêu đề">
                                            </div>
                                        </div>
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <textarea name="message" class="form-control" id="message" cols="30"
                                                          rows="6" placeholder="Nội dung"></textarea>
                                            </div>
                                        </div>
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <input type="submit" value="Send Message" class="btn btn-primary">
                                                <div class="submitting"></div>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <div class="col-md-6 d-flex align-items-stretch">
                            <div class="info-wrap w-100 p-lg-5 p-4 img">
                                <h3>Liên hệ với chúng tôi</h3>
                                <p class="mb-4"></p>
                                <div class="dbox w-100 d-flex align-items-start">
                                    <div class="icon d-flex align-items-center justify-content-center">
                                        <span class="fa fa-map-marker"></span>
                                    </div>
                                    <div class="text pl-3">
                                        <p><span>Địa chỉ:</span> Đại học FPT, Khu Giáo dục và Đào tạo – Khu Công nghệ cao Hòa Lạc – Km29 Đại lộ Thăng Long, H. Thạch Thất, TP. Hà Nội</p>
                                    </div>
                                </div>
                                <div class="dbox w-100 d-flex align-items-center">
                                    <div class="icon d-flex align-items-center justify-content-center">
                                        <span class="fa fa-phone"></span>
                                    </div>
                                    <div class="text pl-3">
                                        <p><span>Số điện thoại:</span> + 84 398 896 461</p>
                                    </div>
                                </div>
                                <div class="dbox w-100 d-flex align-items-center">
                                    <div class="icon d-flex align-items-center justify-content-center">
                                        <span class="fa fa-paper-plane"></span>
                                    </div>
                                    <div class="text pl-3">
                                        <p><span>Email:</span> swp391grou5@gmail.com </p>
                                    </div>
                                </div>
                                <div class="dbox w-100 d-flex align-items-center">
                                    <div class="icon d-flex align-items-center justify-content-center">
                                        <span class="fa fa-globe"></span>
                                    </div>
                                    <div class="text pl-3">
                                        <p><span>Website</span> <a href="#"></a></p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!--<script src="js/jquery.min.js"></script>-->
<script src="js/popper.js"></script>
<script src="js/bootstrap.min.js"></script>
<!--<script src="js/jquery.validate.min.js"></script>-->
<script>
    <c:if test="${user != null}">
    document.getElementById("balanceValue").innerText = parseInt(document.getElementById("balanceValue").innerText).toLocaleString();
    </c:if>
</script>
</body>
</html>