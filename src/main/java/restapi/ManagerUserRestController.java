package restapi;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import dal.DAO;
import dal.StorageDAO;
import dal.UserDAO;
import jakarta.persistence.criteria.CriteriaBuilder;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Storage;
import model.Supplier;
import model.User;

import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "ManagerUserRestController", value = "/api/v1/users")
public class ManagerUserRestController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String page_raw = request.getParameter("page");
        String status_raw = request.getParameter("status");
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
        List<String> listStatus = new ArrayList<>();
        listStatus = DAO.orderDAO.getDistinctStatus();
        //getAllOrder
        list = DAO.userDAO.getAllUser();
        long totalOrder = DAO.orderDAO.totalOrder(status, search);
        double totalPage = (double) totalOrder / 10;
        response.setContentType("application/json");
        JsonObject responseData = new JsonObject();
        JsonParser jsonParser = new JsonParser();
        Gson gson = new Gson();
        Map<String, String> map = new HashMap<>();
        map.put("pageNumber", String.valueOf(page));
        map.put("totalPageNumbers", String.valueOf(Math.ceil(totalPage)));
        responseData.add("listUser", jsonParser.parseString(gson.toJson(list)));
        responseData.add("pagination", jsonParser.parseString(gson.toJson(map)));
//        responseData.add("listProduct", jsonParser.parseString(gson.toJson(listProduct)));
//        responseData.add("listSupplier", jsonParser.parseString(gson.toJson(listSupplier)));
        response.getWriter().println(gson.toJson(responseData));
        response.getWriter().flush();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        UserDAO userDAO = new UserDAO();
//        User user = (User) session.getAttribute("user");
        int id = Integer.parseInt(request.getParameter("id"));
        String account = request.getParameter("account");
        String password = request.getParameter("password");
        int role = Integer.parseInt(request.getParameter("role"));
        String email = request.getParameter("email");
//        Timestamp createdAt = Timestamp.valueOf(request.getParameter("createdAt"));
        int balance = Integer.parseInt(request.getParameter("balance"));
        String phoneNumber = request.getParameter("phoneNumber");
        boolean isActive = Boolean.parseBoolean(request.getParameter("isActive"));
        Map<String, String> map = new HashMap<>();
        response.setContentType("application/json");
        Gson gson = new Gson();
        try {

            User user = new User();
            user.setId(id);
            user.setAccount(account);
            user.setPassword(password);
            user.setRole(role);
            user.setEmail(email);
//            user.setCreatedAt(createdAt);
            user.setBalance(balance);
            user.setPhoneNumber(phoneNumber);
            user.setActive(isActive);
            userDAO.update(user, id);
            System.out.println("Update user success");
            map.put("message", "Cập nhật thông tin người dùng thành công");
        } catch (NumberFormatException e) {
            map.put("message", "Cập nhật thông tin người dùng thất bại");
            System.out.println(e.getMessage());
        } catch (Exception e) {
            map.put("message", "Cập nhật thông tin người dùng thất bại, hạn sử dụng không đúng format \"năm-tháng-ngày giờ:phút:giây\"");
            System.out.println(e.getMessage());
        }

        response.getWriter().write(gson.toJson(map));
        response.getWriter().flush();
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        String id_raw = request.getParameter("id");
        Map<String, String> map = new HashMap<>();
        response.setContentType("application/json");
        Gson gson = new Gson();
        try {
            long id = Long.parseLong(id_raw);
            Storage storage = DAO.storageDAO.getStorageById(id);
            storage.setDelete(true);
            storage.setDeletedAt(Timestamp.valueOf(LocalDateTime.now()));
            storage.setDeletedBy(user);
            DAO.storageDAO.delete(storage);
            System.out.println("Delete storage success");
            map.put("message", "Xóa sản phẩm thành công");
        } catch (Exception e) {
            map.put("message", "Xóa sản phẩm thất bại");
            System.out.println(e.getMessage());
        }
        response.getWriter().write(gson.toJson(map));
        response.getWriter().flush();
    }
}

