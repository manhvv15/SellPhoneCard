package controller;

import dal.DAO;
import dal.StorageDAO;
import dal.UserDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Order;
import model.Storage;
import model.User;

import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "ManagerUserController", value = "/user")
public class ManagerUserController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("isAdmin") != null) {
            boolean isAdmin = false;
            isAdmin = (boolean) session.getAttribute("isAdmin");
            //Information
            if (isAdmin) {
                String page_raw = request.getParameter("page");
                String status_raw = request.getParameter("account");
                String search_raw = request.getParameter("search");
                //khởi tạo biến
                int productId = -1;
                String search = "%";
                String status = "%";
                int page = 1;
                int id = -1;
                List<User> list;
                if (page_raw != null && !page_raw.equals("1") && !page_raw.isEmpty()) {
                    page = Integer.parseInt(page_raw);
                }
                if (search_raw != null && !search_raw.isEmpty()) {
                    search += (search_raw + "%");
                }

                if (status_raw != null && !status_raw.equals("all")) {
                    status += (status_raw + "%");
                }

                //list distinct status
                List<String> listAccount = new ArrayList<>();
                listAccount = DAO.orderDAO.getDistinctStatus();
                //getAllOrder
                list = DAO.userDAO.getAllUser();
                long totalOrder = DAO.orderDAO.totalOrder(status, search);
                double totalPage = (double) totalOrder / 10;
                request.setAttribute("totalPageNumbers", Math.ceil(totalPage));
                request.setAttribute("pageNumber", page);
                request.setAttribute("listStatus", listAccount);
                request.setAttribute("listUser", list);
//
                request.getRequestDispatcher("admin/users.jsp").forward(request, response);
            } else {
                response.sendRedirect("login");
            }
        }


    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws
            ServletException, IOException {
//        HttpSession session = request.getSession();
//        String option = request.getParameter("option");
//
//        User user = (User) session.getAttribute("user");
//        String page = request.getParameter("page");
//        if (option.equals("update")) {
//            String id_raw = request.getParameter("id");
//            String account = request.getParameter("account");
//            String email = request.getParameter("email");
//            String balance = request.getParameter("balance");
//            try {
//                Long id = Long.parseLong(id_raw);
//                User user1 = UserDAO.userDAO.getUserById(id);
//                user1.setAccount(account);
//                user1.set(cardNumber);
//                user1.setExpiredAt(Timestamp.valueOf(expiredAt));
//                user1.setUpdatedAt(Timestamp.valueOf(LocalDateTime.now()));
//
//                storageDAO.update(user);
//                System.out.println("Update storage success");
//                request.setAttribute("message", "Cập nhật thông tin sản phẩm thành công");
//            } catch (NumberFormatException e) {
//                request.setAttribute("message", "Cập nhật thông tin sản phẩm thất bại");
//                System.out.println(e.getMessage());
//            } catch (Exception e) {
//                request.setAttribute("message", "Cập nhật thông tin sản phẩm thất bại, hạn sử dụng không đúng format \"năm-tháng-ngày giờ:phút:giây\"");
//                System.out.println(e.getMessage());
//            }
//        } else {
//            String id_raw = request.getParameter("id");
//            try {
//                Long id = Long.parseLong(id_raw);
//                Storage storage = storageDAO.getStorageById(id);
//                storage.setDelete(true);
//                storage.setDeletedAt(Timestamp.valueOf(LocalDateTime.now()));
//                storage.setDeletedBy(user);
//                storageDAO.delete(storage);
//                System.out.println("Delete storage success");
//                request.setAttribute("message", "Xóa sản phẩm thành công");
//            } catch (Exception e) {
//                request.setAttribute("message", "Xóa sản phẩm thất bại");
//                System.out.println(e.getMessage());
//            }
//        }
//        Long totalStorage = storageDAO.getTotalStorage(-1, -1, "%");
//        double totalPages = (double) totalStorage / 10;
//        if (page == null || page.isEmpty()) {
//            List<Storage> list = storageDAO.getListStorageForPage(0);
//            request.setAttribute("listStorage", list);
//            request.setAttribute("totalPageNumbers", Math.ceil(totalPages));
//            request.setAttribute("pageNumber", 1);
//        } else {
//            List<Storage> list = storageDAO.getListStorageForPage((Integer.parseInt(page) * 10) - 10);
//            request.setAttribute("totalPageNumbers", Math.ceil(totalPages));
//            request.setAttribute("listStorage", list);
//            request.setAttribute("pageNumber", page);
//        }
//        request.getRequestDispatcher("admin/users.jsp").forward(request, response);
    }

}