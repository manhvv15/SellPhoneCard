<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<html>
<head>
    <title>Trang admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-5">
    <h1 class="text-center mb-4">Cấp tiền cho người dùng</h1>

    <form id="transactionForm" action="addmoney" method="post">
        <div class="mb-3">
            <label for="userId" class="form-label">ID Người dùng:</label>
            <input type="text" id="userId" name="userId" value="${user.getId()}" class="form-control" readonly>
        </div>

        <div class="mb-3">
            <label for="userAccount" class="form-label">Tên người dùng:</label>
            <input type="text" id="userAccount" name="userAccount" value="${user.getAccount()}" class="form-control" readonly>
        </div>

        <div class="mb-3">
            <label for="balance" class="form-label">Số tiền cần cấp:</label>
            <input type="number" id="balance" name="balance" class="form-control" required>
        </div>

        <div class="mb-3">
            <label for="note" class="form-label">Ghi chú:</label>
            <input type="text" id="note" name="note" class="form-control" required>
        </div>

        <div class="text-center">
            <button type="submit" class="btn btn-primary">Cấp tiền</button>
        </div>
    </form>

    <div id="result" class="mt-3 text-center"></div>
</div>
<script>
    // Đợi tải xong trang
    $(document).ready(function() {
        // Bắt sự kiện nút submit được nhấn
        $("#transactionForm").submit(function(event) {
            event.preventDefault(); // Ngăn chặn gửi yêu cầu đến máy chủ

            // Thực hiện yêu cầu AJAX để gửi dữ liệu đến máy chủ
            $.ajax({
                url: $(this).attr("user"),
                type: $(this).attr("get"),
                data: $(this).serialize(),
                success: function(response) {
                    // Hiển thị thông báo thành công
                    $("#result").html('<div class="alert alert-success">Cấp tiền thành công!</div>');
                },
                error: function(xhr, status, error) {
                    // Hiển thị thông báo lỗi nếu có lỗi xảy ra
                    $("#result").html('<div class="alert alert-danger">Đã xảy ra lỗi: ' + error + '</div>');
                }
            });
        });
    });
</script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

</body>
</html>
