package restapi;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import dal.DAO;
import dal.StorageDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.*;

import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "OrderRestAPIController", value = "/api/v1/order")
public class OrderRestAPIController extends HttpServlet {
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
        list = DAO.orderDAO.getAllOrder(status, search, (page - 1) * 10);
        long totalOrder = DAO.orderDAO.totalOrder(status, search);
        double totalPage = (double) totalOrder / 10;
        response.setContentType("application/json");
        JsonObject responseData = new JsonObject();
        JsonParser jsonParser = new JsonParser();
        Gson gson = new Gson();
        Map<String, String> map = new HashMap<>();
        map.put("pageNumber", String.valueOf(page));
        map.put("totalPageNumbers", String.valueOf(Math.ceil(totalPage)));
        responseData.add("listOrder", jsonParser.parseString(gson.toJson(list)));
        responseData.add("pagination", jsonParser.parseString(gson.toJson(map)));
        responseData.add("listStatus", jsonParser.parseString(gson.toJson(listStatus)));

        response.getWriter().println(gson.toJson(responseData));
        response.getWriter().flush();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        StorageDAO storageDAO = new StorageDAO();
        User user = (User) session.getAttribute("user");
        String id_raw = request.getParameter("id");
        String serialNumber = request.getParameter("seri");
        String cardNumber = request.getParameter("cardNumber");
        String expiredAt = request.getParameter("expiredAt");
        Map<String, String> map = new HashMap<>();
        response.setContentType("application/json");
        Gson gson = new Gson();
        try {
            Long id = Long.parseLong(id_raw);
            Storage storage = storageDAO.getStorageById(id);
            storage.setSerialNumber(serialNumber);
            storage.setCardNumber(cardNumber);
            storage.setExpiredAt(Timestamp.valueOf(expiredAt));
            storage.setUpdatedAt(Timestamp.valueOf(LocalDateTime.now()));
            storage.setUpdatedBy(user);
            storageDAO.update(storage);
            System.out.println("Update storage success");
            map.put("message", "Cập nhật thông tin sản phẩm thành công");
        } catch (NumberFormatException e) {
            map.put("message", "Cập nhật thông tin sản phẩm thất bại");
            System.out.println(e.getMessage());
        } catch (Exception e) {
            map.put("message", "Cập nhật thông tin sản phẩm thất bại, hạn sử dụng không đúng format \"năm-tháng-ngày giờ:phút:giây\"");
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
