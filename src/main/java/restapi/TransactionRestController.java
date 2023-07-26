package restapi;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import dal.DAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Transactions;
import model.User;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "TransactionRestController", value = "/api/v1/transaction")
public class TransactionRestController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        HttpSession session = request.getSession();
        if (session.getAttribute("user") != null) {
            String type = "";
            String search = "";
            int page = 1;
            String status = "";
            Gson gson = new Gson();
            JsonObject jsonObject = new JsonObject();
            JsonParser jsonParser = new JsonParser();
            Map<String, String> map = new HashMap<>();

            List<Transactions> list = new ArrayList<>();
            User u = (User) session.getAttribute("user");
            User user = DAO.userDAO.getUserById(u.getId());
            session.setAttribute("user", user);
            type = request.getParameter("type");
            status = request.getParameter("status");
            search = request.getParameter("search");
            String page_raw = request.getParameter("page");
            if (page_raw != null && !page_raw.equals("1")) {
                page = Integer.parseInt(page_raw);
            }
            if (type == null) {
                type = "";
            }
            if (status == null) {
                status = "";
            }
            if (search == null) {
                search = "";
            }

            list = DAO.transactionsDAO.searchTransactions(type, status, search, 0, (page - 1) * 10);
            long totalTransactions = DAO.transactionsDAO.getTotalTransactions(type, status, search, 0);
            double totalPage = Math.ceil((double) totalTransactions / 10);

            map.put("pageNumber", page + "");
            map.put("totalPageNumbers", totalPage + "");
            jsonObject.add("listTransaction", jsonParser.parseString(gson.toJson(list)));
            jsonObject.add("pagination", jsonParser.parseString(gson.toJson(map)));

            response.getWriter().write(gson.toJson(jsonObject));
            response.getWriter().flush();
        } else {
            response.sendRedirect("/logout");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}