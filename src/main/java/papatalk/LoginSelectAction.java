package papatalk;

import bean.User;
import dao.UserDao;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class LoginSelectAction extends Action {
    public void execute(HttpServletRequest request,
                       HttpServletResponse response) throws Exception {

        String user_name = request.getParameter("user_name");
        String password = request.getParameter("password");

        // ユーザーネームの入力確認
        if (user_name == null || user_name.trim().isEmpty()) {
            request.setAttribute("errorMessage",
                    "ユーザーネームを入力してください");
            request.getRequestDispatcher("/papatalk/login.jsp")
                   .forward(request, response);
            return;
        }

        // パスワードの入力確認
        if (password == null || password.isEmpty()) {
            request.setAttribute("errorMessage",
                    "パスワードを入力してください");
            request.getRequestDispatcher("/papatalk/login.jsp")
                   .forward(request, response);
            return;
        }

        // ユーザー情報を確認
        UserDao dao = new UserDao();
        User user = dao.select(password, user_name);

        if (user != null) {
            // ログイン成功
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            request.getRequestDispatcher("/papatalk/main/match_list.jsp")
                   .forward(request, response);
        } else {
            // ログイン失敗
            request.setAttribute("errorMessage",
                    "ユーザーネームまたはパスワードが異なります");
            request.getRequestDispatcher("/papatalk/login.jsp")
                   .forward(request, response);
        }
    }
}