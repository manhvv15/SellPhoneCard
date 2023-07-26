package controller;

import dal.OrderDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "DeleteController", urlPatterns = "/delete")
public class DeleteController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long oid = Long.parseLong(request.getParameter("oid"));
        OrderDAO orderDAO = new OrderDAO();
        orderDAO.deleteOrder(oid);
        response.sendRedirect("order");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}