package scoremanager.main;

import bean.User;
import dao.UserDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class BanScreenDisplayAction extends Action {

    @Override
    public void execute(HttpServletRequest req,
                        HttpServletResponse res) throws Exception {

        try {
            // 対象ユーザーIDを取得
            int user_id = Integer.parseInt(
                    req.getParameter("user_id"));

            // UserDaoからユーザー情報を取得
            UserDao dao = new UserDao();

            User user = dao.selectUser(user_id);

            // BAN状態でなければ表示しない
            if (user.getUser_status() != 1) {
                req.setAttribute("errorMessage",
                        "このユーザーはBANされていません。");
            }

            // JSPにユーザー情報を渡す
            req.setAttribute("target_user", user);

            // 詳細画面へ遷移
            req.getRequestDispatcher(
                    "/scoremanager/main/ban_details_screen.jsp")
                    .forward(req, res);

        } catch (Exception e) {
            e.printStackTrace();

            throw new ServletException(
                    "BANユーザー詳細画面の表示に失敗しました。", e);
        }
    }
}