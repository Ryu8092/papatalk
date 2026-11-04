package scoremanager.main;

import java.util.List;

import bean.User;
import dao.MatchingFavoriteDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class GetFavoriteNotificationsAction extends Action {

    @Override
    public void execute(HttpServletRequest req,
                        HttpServletResponse res) throws Exception {

        req.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession(false);

        // ログイン確認
        if (session == null || session.getAttribute("user") == null) {
            res.sendRedirect(
                req.getContextPath() + "/scoremanager/Login.action");
            return;
        }

        User user = (User) session.getAttribute("user");

        try {

            MatchingFavoriteDAO dao = new MatchingFavoriteDAO();

            // 自分をお気に入り登録した人を取得
            List<User> notificationList =
                dao.selectNotifications(user.getUser_id());

            // JSPに渡す
            req.setAttribute("notificationList", notificationList);
            req.setAttribute("user", user);

            // マッチング完了メッセージを取得
            String matchingMessage =
                (String) session.getAttribute("matchingMessage");

            if (matchingMessage != null) {
                req.setAttribute("matchingMessage", matchingMessage);

                // 一度表示したら削除
                session.removeAttribute("matchingMessage");
            }

            // 通知一覧画面を表示
            req.getRequestDispatcher(
                "/scoremanager/main/favorite_notice.jsp")
                .forward(req, res);

        } catch (Exception e) {

            e.printStackTrace();

            throw new ServletException(
                "お気に入り通知一覧の表示に失敗しました。", e);
        }
    }
}