<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register</title>
    <script
            src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"
            integrity="sha512-fD9DI5bZwQxOi7MhYWnnNPlvXdp/2Pj3XSTRrFs5FQa4mizyGLnJcN6tuvUS6LbmgN1ut+XGSABKvjN0H6Aoow=="
            crossorigin="anonymous"
            referrerpolicy="no-referrer"
    ></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gradient-to-tr from-cyan-300 to-purple-600">
<div class="root">
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
    <div class="flex items-center justify-center min-h-screen">
        <div class="bg-white p-4 rounded-md w-96">
            <div class="flex items-center justify-center flex-col">
                <h1 class="font-bold text-2xl mb-8">Sign Up</h1>
                <div class="w-full">
                    <div>
                        <form
                                id="form-signup"
                                method="post"
                                action="register"
                                class="flex items-center justify-center flex-col"
                        >
                            <div class="w-full mb-2">
                                <h3 class="font-semibold mb-1">
                                    Tài khoản
                                </h3>
                                <div
                                        class="flex justify-center flex-col"
                                >
                                    <input
                                            id="account-input"
                                            type="text"
                                            name="account"
                                            value="${account}"
                                            class="border border-neutral-300 py-1 px-2 focus:border-neutral-800 !outline-none transition-all rounded-md mb-1 h-10"
                                    />
                                    <p
                                            id="account-validate"
                                            class="text-red-600"
                                    >
                                        ${accountMessageErr}
                                    </p>
                                </div>
                            </div>

                            <div class="w-full mb-2">
                                <h3 class="font-semibold mb-1">
                                    Mật khẩu
                                </h3>
                                <div
                                        class="flex justify-center flex-col"
                                >
                                    <input
                                            id="password-input"
                                            type="password"
                                            name="password"
                                            value="${password}"
                                            class="border border-neutral-300 py-1 px-2 focus:border-neutral-800 !outline-none transition-all rounded-md mb-1 h-10"
                                    />
                                    <p
                                            id="password-validate"
                                            class="text-red-600"
                                    >
                                        ${passwordMessageErr}
                                    </p>
                                </div>
                            </div>
                            <div class="w-full mb-2">
                                <h3 class="font-semibold mb-1">
                                    Email
                                </h3>
                                <div
                                        class="flex justify-center flex-col"
                                >
                                    <input
                                            id="email-input"
                                            type="text"
                                            name="email"
                                            value="${email}"
                                            class="border border-neutral-300 py-1 px-2 focus:border-neutral-800 !outline-none transition-all rounded-md mb-1 h-10"
                                    />
                                    <p
                                            id="email-validate"
                                            class="text-red-600"
                                    >
                                        ${emailMessageErr}
                                    </p>
                                </div>
                            </div>
                            <div
                                    class="w-full flex justify-center flex-col mb-4"
                            >
                                <div class="flex justify-between gap-2">
                                    <div class="flex-[50%] w-full">
                                        <h3 class="font-semibold mb-2">
                                            Captcha
                                        </h3>
                                        <img
                                                id="captchaImg"
                                                src="captcha-servlet"
                                                alt="captcha"
                                                class="h-15 w-30"
                                        />
                                    </div>
                                    <div class="flex-[50%]">
                                        <h3 class="font-semibold mb-2">
                                            Nhập mã captcha
                                        </h3>
                                        <div
                                                class="flex justify-between"
                                        >
                                            <input
                                                    id="captcha-input"
                                                    type="text"
                                                    maxlength="5"
                                                    name="captcha"
                                                    class="peer flex-[80%] w-full border-y border-l border-neutral-300 p-1 focus:border-neutral-800 !outline-none transition-all rounded-l-md mb-1 h-10"
                                            />
                                            <button
                                                    type="button"
                                                    onclick="refreshCaptcha()"
                                                    id="refresh-button"
                                                    class="peer-focus:border-neutral-800 flex-[20%] border-y border-r rounded-r-md border-neutral-300 h-10 bg-neutral-500 text-white"
                                            >
                                                        <span
                                                                class="hover:animate-spin w-full h-full flex items-center justify-center"
                                                        >
                                                            <i
                                                                    class="fa fa-refresh"
                                                            ></i>
                                                        </span>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                <p
                                        id="captcha-validate"
                                        class="text-red-600"
                                >
                                    ${captchaMessageErr}
                                </p>
                            </div>
                            <button
                                    id="submit-button"
                                    type="button"
                                    onclick="submitData()"
                                    class="bg-gradient-to-tr from-cyan-500 to-purple-600 text-white font-semibold px-4 py-2 rounded-md mb-4"
                            >
                                Đăng ký
                            </button>
                            <p class="text-sm">
                                Đã có tài khoản?
                                <a
                                        href="login"
                                        class="font-semibold text-black/70 hover:text-black transition-all"
                                >Đăng nhập</a
                                >
                            </p>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <footer
            class="flex items-center justify-center h-32 bg-neutral-100"
    >
        <p class="font-semibold">Powered by: SWP391-Group5 ©2023</p>
    </footer>
</div>
<script src="js/register.js"></script>
</body>
</html>
