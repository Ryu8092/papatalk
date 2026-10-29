
package scoremanager;

import bean.User;
import dao.UserDao;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class LoginSelectionAction extends Action {

    private UserDao dao = new UserDao();

    public void execute(HttpServletRequest req, HttpServletResponse res)
            throws Exception {

        String password = req.getParameter("password");
        String user_name = req.getParameter("user_name");

        User user = dao.select(password, user_name);

        if (user == null) {
            req.setAttribute("error", "ユーザー名またはパスワードが確認できませんでした。");
            req.setAttribute("user_name", user_name);
            req.getRequestDispatcher("/scoremanager/login.jsp").forward(req, res);
        } else {
            HttpSession session = req.getSession();
            session.setAttribute("user", user);
            
            req.getRequestDispatcher("/scoremanager/main/match_list.jsp")
            .forward(req, res);
        }
    }
}
