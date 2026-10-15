
package scoremanager;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class LoginAction extends Action {

    @Override
    public void execute(HttpServletRequest req, HttpServletResponse res)
            throws Exception {

        String userName = req.getParameter("user_name");
        String password = req.getParameter("password");

        if ("admin".equals(userName) && "1234".equals(password)) {
            res.sendRedirect(req.getContextPath() + "/scoremanager/home.jsp");
        } else {
            req.setAttribute("errorMessage",
                    "ユーザー名またはパスワードが間違っています");
            req.getRequestDispatcher("/scoremanager/login.jsp")
                    .forward(req, res);
        }
        }
}
