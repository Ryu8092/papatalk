package scoremanager;

import bean.User;
import dao.UserDao;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class LoginExecuteAction extends Action {

    public void execute(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws Exception {

        HttpSession session = request.getSession();

        String user_name = request.getParameter("user_name");

        String password = request.getParameter("password");

        UserDao dao = new UserDao();

        User user = dao.select(password, user_name);

        if (user != null) {

            session.setAttribute("user", user);

            String comment = (String) request.getAttribute("comment");

            if (comment != null) {
                request.removeAttribute("comment");
            }

            request.getRequestDispatcher("main/menu.jsp")
                    .forward(request, response);

            return;
        }

        request.setAttribute(
                "comment",
                "ユーザーネームまたはパスワードに異なりがあります"
        );

        request.getRequestDispatcher("login.jsp")
                .forward(request, response);
    }
}