<%--
  Created by IntelliJ IDEA.
  User: dmngh
  Date: 5/19/2023
  Time: 11:14 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false"%>
<html>
<head>
    <title>Active Account</title>
    <link rel="stylesheet" href="css/register.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="js/activeAccount.js"></script>
</head>
<body>
<div class="root">
    <div class="app">
        <div class="row">
            <div class="signup">
                <div class="signup-title">
                    <h1>Active</h1>
                </div>
                <div class="signup-detail">
                    <div class="signup-form">
                        <form id="form-signup" method="post" action="activeAccount">
                            <div class="form-row">
                                <div class="label"><h3>Account</h3></div>
                                <div class="input-area">
                                    <input style="font-size: 1.5em" id="account-input" type="text"
                                           name="account" value="${user.getAccount()}" readonly><br>
                                    <p style="color: red;">${accountMessageErr}</p>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="label"><h3>Token</h3></div>
                                <div class="input-area">
                                    <input style="font-size: 1.5em" type="text"
                                           name="tokenInput"><br>
                                    <p style="color: red;">${tokenMessageErr}</p>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="label"><h3>Mã Captcha</h3></div>
                                <div class="input-area" style="display: flex">
                                    <img style="height: 40px;background-image: url('images/backgroundCaptcha.png')"
                                         id="captchaImg"
                                         src="/captcha-servlet">
                                    <div class="captcha-div">
                                        <div style="display: block">
                                            <input id="captcha-input"
                                                   style="font-size: 1.5em;font-weight: bold;width: 30%;margin-right: 2px;height: 40px;"
                                                   type="text"
                                                   maxlength="5" placeholder="input" name="captchaInput">
                                            <button type="button" onclick="refreshCaptcha()" id="refresh-button"
                                                    style="cursor: pointer;height: 68%;"><i style="font-size: 1.5em;"
                                                                                            class="fa fa-refresh"></i>
                                            </button>
                                        </div>
                                        <p style="color: red;" id="captcha-validate" class="message-error">${captchaMessageErr}</p>
                                    </div>
                                </div>
                            </div>
                            <div class="form-row">
                                <button type="submit"
                                        style="font-size: 1.2em;cursor: pointer;padding: 5px;" name="option"
                                        value="confirm">
                                    <i class="fa fa-check"></i> Xác nhận
                                </button>
                                <button type="button" id="reSendButton" class="reSendButton"
                                        style="font-size: 1.2em;padding: 5px;" name="option"
                                        value="sendAgain">
                                    <i class="fa fa-send-o"></i> Gửi lại mã xác nhận
                                </button>
                            </div>
                        </form>
                        <div class="form-row">
                            <p style="color: red;font-size: 1.2em;">${messageErrForSendMail}</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="js/register.js"></script>
</body>
</html>
