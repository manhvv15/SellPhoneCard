package restapi;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import dal.DAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Product;
import model.Supplier;
import model.User;

import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name = "HomeRestController", urlPatterns = "/api/v1/home")
public class HomeRestController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get user and update new User to session
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        User newUser = null;
        if (user != null) {
            newUser = DAO.userDAO.getUserById(user.getId());
            session.removeAttribute("user");
            session.setAttribute("user", newUser);
        }

        // Set response content type to json
        response.setContentType("application/json");

        // Get list supplier and product
        String supplier = request.getParameter("supplier");
        int supplierId = 1;
        if (supplier != null && !supplier.equals("1")) {
            supplierId = Integer.parseInt(supplier);
        }
        ArrayList<Supplier> listSupplier = DAO.supplierDAO.getListSupplier();
        ArrayList<Product> listProduct = DAO.productDAO.getListProductBySupplier(supplierId);
        // Add attribute to response json
        JsonObject jsonObject = new JsonObject();
        Gson gson = new Gson();
        jsonObject.addProperty("user", gson.toJson(newUser));
        jsonObject.addProperty("supplierId", gson.toJson(supplierId));
        jsonObject.addProperty("listSupplier", gson.toJson(listSupplier));
        jsonObject.addProperty("listProduct", gson.toJson(listProduct));

        response.getWriter().write(gson.toJson(jsonObject));
        response.getWriter().flush();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}