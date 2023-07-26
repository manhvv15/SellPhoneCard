package restapi;

import com.google.gson.Gson;
import dal.DAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Notice;
import model.User;

import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "BuyCardRestController", urlPatterns = "/api/v1/scanNotice")
public class ScanNotice extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");
        response.setContentType("application/json");
        Map<String, String> map = new HashMap<>();
        Gson gson = new Gson();
        ArrayList<String> content = new ArrayList<>();
        if (user != null) {
            List<Notice> notices = DAO.noticeDAO.getListNoticeByUser(user.getId());
            for (Notice notice : notices) {
                notice.setSeen(true);
                notice.setUpdatedAt(Timestamp.valueOf(LocalDateTime.now()));
                notice.setUpdatedBy(user);
                DAO.noticeDAO.update(notice);
                content.add(notice.getSubject() + "\n" + notice.getContent());
            }
            if (content.isEmpty()) {
                map.put("listMessage", "");
            } else {
                map.put("listMessage", gson.toJson(content));
            }
        } else {
            map.put("listMessage", "");
        }

        response.getWriter().write(gson.toJson(map));
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }
}