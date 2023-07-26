var beforeDate = new Date().getTime();

var x = setInterval(function () {
    var now = new Date().getTime();
    var distance = now - beforeDate;

    var timeAvailable = 1000 * 30;

    if (distance >= timeAvailable) {
        clearInterval(x);
        var reSendButton = document.getElementById("reSendButton");
        reSendButton.classList.toggle("button-active");
        reSendButton.type = "submit";
    }
})