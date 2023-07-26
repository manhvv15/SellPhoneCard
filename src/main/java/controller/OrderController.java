package controller;

import com.oracle.wls.shaded.org.apache.xpath.operations.Or;
import dal.DAO;
import dal.OrderDAO;
import dal.StorageDAO;
import dal.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Order;
import model.Product;
import model.Storage;
import model.User;

import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "OrderController", urlPatterns = "/order")
public class OrderController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        if (session.getAttribute("user") != null) {
            boolean isAdmin = false;
            isAdmin = (session.getAttribute("isAdmin") != null ? ((boolean) session.getAttribute("isAdmin")) : false);
            //Information
            if (isAdmin) {
                String page_raw = request.getParameter("page");
                String status_raw = request.getParameter("status");
                String search_raw = request.getParameter("search");
                //khởi tạo biến
                int productId = -1;
                String search = "%";
                String status = "%";
                int page = 1;
                int id = -1;
                List<Order> list;
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
                List<String> listStatus = DAO.orderDAO.getDistinctStatus();
//                listStatus = DAO.orderDAO.getDistinctStatus();
                //getAllOrder
                list = DAO.orderDAO.getAllOrder(status, search, (page - 1) * 10);
                long totalOrder = DAO.orderDAO.totalOrder(status, search);
                double totalPage = (double) totalOrder / 10;
                request.setAttribute("totalPageNumbers", Math.ceil(totalPage));
                request.setAttribute("pageNumber", page);
                request.setAttribute("listStatus", listStatus);
                request.setAttribute("listOrder", list);
//
                request.getRequestDispatcher("admin/order.jsp").forward(request, response);
            } else {
                User u = (User) session.getAttribute("user");
                User user = DAO.userDAO.getUserById(u.getId());
                session.setAttribute("user", user);
                String page_raw = request.getParameter("page");
                String status_raw = request.getParameter("status");
                String search_raw = request.getParameter("search");
                //khởi tạo biến
                int productId = -1;
                String search = "%";
                String status = "%";
                int page = 1;
                int id = -1;
                List<Order> list;
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
                List<String> listStatus = new ArrayList<>();
                listStatus = DAO.orderDAO.getDistinctStatus();
                //getAllOrder

                list = DAO.orderDAO.getAllOrderWithUser(status, search, (page - 1) * 10,user.getId());
                long totalOrder = DAO.orderDAO.totalOrderByUser(status, search, user.getId());
                double totalPage = (double) totalOrder / 10;
                request.setAttribute("totalPageNumbers", Math.ceil(totalPage));
                request.setAttribute("pageNumber", page);
                request.setAttribute("listStatus", listStatus);
                request.setAttribute("listOrder", list);
                request.getRequestDispatcher("order.jsp").forward(request, response);
            }
        } else {
            response.sendRedirect("login");
        }


    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String option = request.getParameter("option");
        OrderDAO orderDAO = new OrderDAO();
        User user = (User) session.getAttribute("user");
        if (option.equals("delete")) {
            String id_raw = request.getParameter("id");
            try {
                Long id = Long.parseLong(id_raw);
                Order order = orderDAO.getOrderById(id);
                order.setDelete(true);
                order.setDeletedAt(Timestamp.valueOf(LocalDateTime.now()));
                order.setDeletedBy(user);
                orderDAO.delete(order);
                System.out.println("Delete order success");
                request.setAttribute("message", "Xóa sản phẩm thành công ");

            } catch (Exception e) {
                request.setAttribute("message", "Xóa sản phẩm thất bại ");
                System.out.println(e.getMessage());
            }
        }

        boolean isAdmin = (boolean) session.getAttribute("isAdmin");
        //Information
        String page_raw = request.getParameter("page");
        String status_raw = request.getParameter("status");
        String search_raw = request.getParameter("search");
        //khởi tạo biến
        int productId = -1;
        String search = "%";
        String status = "%";
        int page = 1;
        int id = -1;
        List<Order> list;
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
        List<String> listStatus = new ArrayList<>();
        listStatus = orderDAO.getDistinctStatus();
        //getAllOrder
        list = orderDAO.getAllOrder(status, search, (page - 1) * 10);
        long totalOrder = orderDAO.totalOrder(status, search);
        double totalPage = (double) totalOrder / 10;
        request.setAttribute("totalPageNumbers", Math.ceil(totalPage));
        request.setAttribute("pageNumber", page);
        request.setAttribute("listStatus", listStatus);
        request.setAttribute("listOrder", list);
        request.getRequestDispatcher("admin/order.jsp").forward(request, response);
    }
}