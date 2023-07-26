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
import model.Product;
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

@WebServlet(name = "StorageRestController", value = "/api/v1/storage")
public class StorageRestController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String page_raw = request.getParameter("page");
        String supplier_raw = request.getParameter("supplier");
        String price_raw = request.getParameter("price");
        String search_raw = request.getParameter("search");
        int price = -1;
        int productId = -1;
        String search = "%";
        int page = 1;
        int supplierId = -1;
        Long totalStorage = (long) 0;
        boolean loadListStorage = true;
        List<Integer> listProduct = DAO.storageDAO.getListDistinctProductWithPrice();
        List<Supplier> listSupplier = DAO.supplierDAO.getListSupplier();
        List<Storage> list = null;
        if (page_raw != null) {
            page = Integer.parseInt(page_raw);
        }
        if (search_raw != null && !search_raw.isEmpty()) {
            search += (search_raw + "%");
        }
        if (price_raw != null && !price_raw.equals("all")) {
            price = Integer.parseInt(price_raw);
        }
        if (supplier_raw != null && !supplier_raw.equals("all")) {
            supplierId = Integer.parseInt(supplier_raw);
        }
        list = DAO.storageDAO.searchStorage(price, supplierId, search, (page - 1) * 10);

        totalStorage = (long) DAO.storageDAO.getTotalStorage(price, supplierId, search);

        if ((search_raw != null && !search_raw.isEmpty()) || (price_raw != null && !price_raw.equals("all")) || (supplier_raw != null && !supplier_raw.equals("all"))) {
            if (totalStorage <= 1) {
                page = 1;
            }
        }
        double totalPages = (double) totalStorage / 10;
        response.setContentType("application/json");
        JsonObject responseData = new JsonObject();
        JsonParser jsonParser = new JsonParser();
        Gson gson = new Gson();
        Map<String, String> map = new HashMap<>();
        map.put("pageNumber", String.valueOf(page));
        map.put("totalPageNumbers", String.valueOf(Math.ceil(totalPages)));
        responseData.add("listStorage", jsonParser.parseString(gson.toJson(list)));
        responseData.add("pagination", jsonParser.parseString(gson.toJson(map)));
        responseData.add("listProduct", jsonParser.parseString(gson.toJson(listProduct)));
        responseData.add("listSupplier", jsonParser.parseString(gson.toJson(listSupplier)));
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
