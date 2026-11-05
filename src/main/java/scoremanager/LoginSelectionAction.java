
package scoremanager;

import java.util.List;

import bean.User;
import dao.SubscriptionDao;
import dao.UserDao;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class LoginSelectionAction extends Action {

    private UserDao dao = new UserDao();
    private SubscriptionDao subscriptionDao = new SubscriptionDao();

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

            int user_id = user.getUser_id();

            // ログインしたユーザーと同じ都道府県のユーザーを取得
            List<User> userList =
                    dao.selectByPrefecture(user.getPrefecture(), user_id);

            // JSPにユーザー一覧を渡す
            req.setAttribute("userList", userList);

            HttpSession session = req.getSession();

            // ユーザー情報をセッションに格納
            session.setAttribute("user", user);

            // サブスク加入状態を取得
            boolean subscription = subscriptionDao.select(user_id);

            // サブスク状態をセッションに格納
            session.setAttribute("subscription", subscription);

            if (user.getUser_status() == 0) {

                // 一般ユーザー
                req.getRequestDispatcher("/scoremanager/main/match_list.jsp")
                        .forward(req, res);

            } else if (user.getUser_status() == 9) {

                // 管理者
                req.getRequestDispatcher("/scoremanager/admin/admin_main.jsp")
                        .forward(req, res);
            }
        }
    }
}
