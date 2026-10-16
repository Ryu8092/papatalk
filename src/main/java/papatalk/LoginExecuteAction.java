
package papatalk;

import bean.User;
import dao.UserDao;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class LoginExecuteAction extends Action {

    @Override
    public void execute(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws Exception {

        String user_name = request.getParameter("user_name");
        String password = request.getParameter("password");

        UserDao dao = new UserDao();
        User user = dao.select(password, user_name);

        if (user != null) {

            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            request.getRequestDispatcher(
                    "/scoremanager/main/menu.jsp"
            ).forward(request, response);

            return;
        }

        request.setAttribute(
                "comment",
                "ユーザーネームまたはパスワードが違います"
        );

        request.getRequestDispatcher(
                "/scoremanager/login.jsp"
        ).forward(request, response);
    }
}
