function refreshCaptcha() {
    fetch('captcha-servlet', {
        method: 'POST'
    })
        .then(Response => Response.blob())
        .then(Blob => {
            const imageURL = URL.createObjectURL(Blob);
            const imageElement = document.getElementById("captchaImg");
            imageElement.src = imageURL;
        })
        .catch(Error => console.error(Error))
}

var activeValidate = false

if (activeValidate) {

}

function submitData() {
    var accountInput = document.getElementById("account-input");
    var passwordInput = document.getElementById("password-input");
    var emailInput = document.getElementById("email-input");
    var captchaInput = document.getElementById("captcha-input")
    var confPasswordInput = document.getElementById("confPassword-input");


    var accountValidate = document.getElementById("account-validate");
    var paswordValidate = document.getElementById("password-validate");
    var emailValidate = document.getElementById("email-validate");
    var captchaValidate = document.getElementById("captcha-validate");
    var confPasswordValidate = document.getElementById("confPassword-validate")

    //Pattern check validate
    var passwordRegex = new RegExp("^(((?=.*[a-z])(?=.*[A-Z]))|((?=.*[a-z])(?=.*[0-9]))|((?=.*[A-Z])(?=.*[0-9])))(?!.*[!@#$%^&*])(?=.{6,})");
    var accountRegex = new RegExp("(?!.*[!@#$%^&*])(?=.{3})");
    var emailRegex = new RegExp("^(((?=.*[a-z])|(?=.*[0-9])|(?=.*[A-Z])))(?=.*[!@#$%^&*])(?=.*@)");
    var confPasswordRegex = new RegExp("^(((?=.*[a-z])(?=.*[A-Z]))|((?=.*[a-z])(?=.*[0-9]))|((?=.*[A-Z])(?=.*[0-9])))(?!.*[!@#$%^&*])(?=.{6,})");


    var success = true;
    if (accountInput.value == "") {
        accountValidate.style.display = "block";
        accountValidate.innerHTML = "Account không được để trống";
        success = false;
    } else {
        if (!accountRegex.test(accountInput.value)) {
            accountValidate.style.display = "block";
            accountValidate.innerHTML = "Account chứa ký tự không hợp lệ hoặc chưa đủ 3 ký tự!!";
            success = false;
        } else {
            accountValidate.style.display = "none";
        }
    }
    if (emailInput.value == "") {
        emailValidate.style.display = "block";
        emailValidate.innerHTML = "Email không được để trống";
        success = false;
    } else {
        if (!emailRegex.test(emailInput.value)) {
            emailValidate.style.display = "block";
            emailValidate.innerHTML = "Email Không đúng định dạng!";
            success = false;
        } else {
            emailValidate.style.display = "none";
        }
    }
    if (captchaInput.value == "") {
        captchaValidate.style.display = "block";
        captchaValidate.innerHTML = "Captcha không được để trống";
        success = false;
    } else {
        captchaValidate.style.display = "none";
    }
    if (passwordInput.value == "") {
        paswordValidate.style.display = "block";
        paswordValidate.innerHTML = "Password không được để trống";
        success = false;
    } else {
        if (!passwordRegex.test(passwordInput.value)) {
            paswordValidate.style.display = "block";
            paswordValidate.innerHTML = "Password phải bao gồm cả chữ và số đồng thời ít nhất 6 ký tự (Không cho phép ký tự đặc biệt)!!";
            success = false;
        } else {
            paswordValidate.style.display = "none";
        }
    }
    // if (confPasswordInput.value == "") {
    //     confPasswordValidate.style.display = "block";
    //     confPasswordValidate.innerHTML = "Password không được để trống";
    //     success = false;
    // } else {
    //     if (!confPasswordRegex.test(confPasswordInput.value)) {
    //         confPasswordValidate.style.display = "block";
    //         confPasswordValidate.innerHTML = "Password phải bao gồm cả chữ và số đồng thời ít nhất 6 ký tự (Không cho phép ký tự đặc biệt)!!";
    //         success = false;
    //     } else {
    //         confPasswordValidate.style.display = "none";
    //     }
    // }

    if (success) {
        document.getElementById("form-signup").submit();
    }
}