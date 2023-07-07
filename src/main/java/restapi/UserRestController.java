package restapi;

import com.google.gson.Gson;
import dal.DAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.User;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "UserRestController", value = "/api/v1/users")
public class UserRestController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        Map<String, String> map = new HashMap<>();
        Gson gson = new Gson();
        if (user == null) {
            map.put("message", "Vui lòng đăng nhập để sử dụng chức năng");
            response.getWriter().write(gson.toJson(map));
            response.getWriter().flush();
        } else {
            int page = 1;
            String searchName = "%";
            int isActive = -1;
            String page_raw = request.getParameter("page");
            String search = request.getParameter("search");
            String isActive_raw = request.getParameter("isActive");
            if(page_raw != null && !page_raw.equals("1")) {
                page = Integer.parseInt(page_raw);
            }
            if (search != null && !search.isEmpty()) {
                searchName += (search + "%");
            }
            if (isActive_raw != null && !isActive_raw.equals("all")) {
                isActive = Integer.parseInt(isActive_raw);
            }
            List<User> listUser = DAO.userDAO.searchUsers(searchName, ((page - 1) * 10), isActive);
            int totalUsers = DAO.userDAO.getTotalUsers(user.getId());
            double totalPages = Math.ceil((double) totalUsers / 10);
            map.put("message", gson.toJson(""));
            map.put("listUser", gson.toJson(listUser));
            map.put("totalPages", gson.toJson(totalPages));
            map.put("pageCurrent", gson.toJson(page));
            response.getWriter().write(gson.toJson(map));
            response.getWriter().flush();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
