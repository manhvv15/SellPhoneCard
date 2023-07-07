<%-- 
    Document   : detailHistory
    Created on : Jun 15, 2023, 2:52:52 PM
    Author     : caoqu
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
        .table {
            margin: auto;
            margin-top: 170px;
            align-items: center;
            border-collapse: collapse;
            width: 50%;
            font-size: 16px;
            text-align: center;
            color: #333;
        }

        .table th {
            font-weight: bold;
            font-size: 18px;
            background-color: #ddd; /* Màu nền của header */
        }

        .table tr:nth-child(even) {
            background-color: #f2f2f2; /* Màu nền của các dòng chẵn */
        }

        td, th {
            padding: 12px;
            border: 1px solid #ccc;
        }

        td:hover {
            background-color: #ddd;
        }

        .table-container {
            margin-bottom: 30px;
            margin-left: 75px;
            margin-right: 75px;
        }

        .return-button {
            background-color: #4CAF50;
            color: white;
            border: 2px solid #4CAF50;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 5px;
            margin-left: 75px;
        }

        .return-button:hover {
            background-color: #3e8e41;
            border: 2px solid #3e8e41;
        }


    </style>
</head>
<body style="background: linear-gradient(90.4deg, rgb(248, 52, 246) 0.6%, rgb(152, 38, 252) 90%)">
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
<c:forEach items="${listDetail}" var="c">
    <form>

        <div class="table-container">
            <table class="table">
                <tr>
                    <th>Người tạo</th>
                    <td style="background-color: #ddd;">${c.getUser().getAccount()}</td>
                </tr>
                <tr>
                    <th>Số tiền</th>
                    <td>${c.getMoney()}</td>
                </tr>
                <tr>
                    <th>Loại giao dịch</th>
                    <c:if test="${c.isType()==true}">
                        <td style="background-color: #ddd;">+</td>
                    </c:if>
                    <c:if test="${c.isType()==false}">
                        <td style="background-color: #ddd;">-</td>
                    </c:if>
                </tr>
                <tr>
                    <th>Xử lí</th>
                    <c:if test="${c.isStatus()==true}">
                        <td>Đã xử lí</td>
                    </c:if>
                    <c:if test="${c.isStatus()==false}">
                        <td>Chưa xử lí</td>
                    </c:if>
                </tr>

                <tr>
                    <th>Thời gian tạo</th>
                    <td style="background-color: #ddd;">${c.getCreateAt()}</td>
                </tr>
                <tr>
                    <th>Thời gian cập nhật</th>
                    <td>${c.getUpdatedAt()}</td>
                </tr>

            </table>
        </div>
    </form>

</c:forEach>

</body>
<script>
    document.getElementById("balanceValue").innerText = parseInt(document.getElementById("balanceValue").innerText).toLocaleString();
</script>
</html>