package scoremanager.main;
 
import java.util.List;

import bean.User;
import dao.UserDao;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;
 
public class GetUserAction extends Action {
 
    @Override
    public void execute(HttpServletRequest req, HttpServletResponse res)
            throws Exception {
 
        HttpSession session = req.getSession(false);
 
        if (session == null || session.getAttribute("user") == null) {
            res.sendRedirect(
                req.getContextPath() + "/scoremanager/login.jsp"
            );
            return;
        }
 
        User loginUser = (User) session.getAttribute("user");
 
        String childAge = req.getParameter("child_age");
        String fatherAge = req.getParameter("father_age");
        String region = req.getParameter("region");
        String destination = req.getParameter("destination");
        String hobbies = req.getParameter("hobbies");
 
        UserDao dao = new UserDao();
 
        List<User> userList = dao.select(
            childAge,
            fatherAge,
            region,
            destination,
            hobbies,
            loginUser.getUser_id()
        );
 
        req.setAttribute("userList", userList);
        req.setAttribute("childAge", childAge);
        req.setAttribute("fatherAge", fatherAge);
        req.setAttribute("region", region);
        req.setAttribute("destination", destination);
        req.setAttribute("hobbies", hobbies);
 
        req.getRequestDispatcher(
            "/scoremanager/main/match_list.jsp"
        ).forward(req, res);
    }
}