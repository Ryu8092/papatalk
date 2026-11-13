
package scoremanager.main;

import java.util.List;

import bean.User;
import dao.MatchingFavoriteDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class RetrieveFavoritesAction extends Action {

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

            // お気に入り一覧を取得
            List<User> favoriteList =
                    dao.select(user.getUser_id());

            // JSPに渡す
            req.setAttribute("favoriteList", favoriteList);
            req.setAttribute("user", user);

            // お気に入り一覧画面を表示
            req.getRequestDispatcher(
                "/scoremanager/main/like_list.jsp")
                .forward(req, res);

        } catch (Exception e) {
            e.printStackTrace();

            throw new ServletException(
                "お気に入り一覧の取得に失敗しました。", e);
        }
    }
}