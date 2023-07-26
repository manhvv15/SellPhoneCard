<!-- admin_page.jsp -->
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Trang admin</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css"
          integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
</head>
<body>
    <div class="container">
        <div class="">
            <h2>Danh sách người dùng</h2>
            <table class="table">
                <thead>
                    <tr>
                        <th>Id</th>
                        <th>Account</th>
                        <th>Email</th>
                        <th>Balance</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody id="load_data">

                </tbody>

            </table>
        </div>
    </div>
    <!-- Button trigger modal -->
<%--    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModalLong">--%>
<%--        Launch demo modal--%>
<%--    </button>--%>

    <!-- Modal -->
    <div class="modal fade" id="exampleModalLong" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLongTitle">Modal title</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <table class="table">
                        <thead>
                        <tr>
                            <th>Id</th>
                            <th>Account</th>
                            <th>Email</th>
                            <th>Balance</th>
                            <th>Action</th>
                        </tr>
                        </thead>
                        <tbody id="load_user">

                        </tbody>

                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary">Save changes</button>
                </div>
            </div>
        </div>
    </div>
    <script>
        $(document).ready(function(){
            LoadData();
            $('body').on('click', '.btnView',function (){
                var id = $(this).data('id');
                GetDataById(id);
            });
        });
        function LoadData() {
            $.ajax({
                url: "api/v1/user",
                type: "GET",
                success: function (data) {
                    // Extract the listUser array and pagination object from the JSON response
                    var listUser = data.listUser;
                    var pagination = data.pagination;

                    // Create the table rows for each user in the listUser array
                    var str = "";
                    $.each(listUser, function (i, item) {
                        str += "<tr>";
                        str += "<td>" + item.id + "</td>"; // id
                        str += "<td>" + item.account + "</td>";
                        str += "<td>" + item.email + "</td>";
                        str += "<td>" + item.balance + "</td>";
                        str += "<td><a class='btn btn-success btnView ' data-id = '"+ item.id+"' >Xem chi tiết</a></td>";
                        str += "</tr>";
                    });

                    // Populate the table body with the generated rows
                    $("#load_data").html(str);

                    // You can also use pagination data if needed
                    console.log("Page Number:", pagination.pageNumber);
                    console.log("Total Page Numbers:", pagination.totalPageNumbers);
                },
                error: function (error) {
                    console.log("Error loading data:", error);
                },
            });
        }
        // function LoadData(){
        //     $.ajax({
        //         url: "/api/v1/user",
        //         type : "GET",
        //         success: function (rs){
        //             console.log(rs);
        //             var str = "";
        //             $.each(rs, function (i,  item){
        //                 str += "<tr>";
        //                 str += "<td>" + (i + 1) + "</td>"; //id
        //                 str += "<td>" + item.account + "</td>";
        //                 str += "<td>" + item.email + "</td>";
        //                 str += "<td>" + item.balance + "</td>";
        //                 str += "</tr>";
        //             });
        //             $("#load_data").html(str);
        //         }
        //
        //     });
        // }
        function  GetDataById(id){
            $.ajax({
                url: "api/v1/user" ,
                type: "GET",
                data : {id,id},
                success:function (user){
                    var modalBody = $(".modal-body");
                    modalBody.html("<p><strong>ID: </strong>" + user.id + "</p>");
                    modalBody.append("<p><strong>Account: </strong>" + user.account + "</p>");
                    modalBody.append("<p><strong>Email: </strong>" + user.email + "</p>");
                    modalBody.append("<p><strong>Balance: </strong>" + user.balance + "</p>");
                    $("#exampleModalLong").modal('show');
                },
                error: function (error) {
                    console.log("Error loading data:", error);
                },
            });
        }
    </script>
</body>
</html>
