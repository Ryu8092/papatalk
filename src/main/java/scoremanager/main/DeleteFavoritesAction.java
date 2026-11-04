package scoremanager.main;

import bean.User;
import dao.MatchingFavoriteDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class DeleteFavoritesAction extends Action {

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
            // 解除する相手のユーザーIDを取得
            String targetUserIdStr = req.getParameter("user_id");

            if (targetUserIdStr == null || targetUserIdStr.isBlank()) {
                res.sendRedirect(
                    req.getContextPath()
                    + "/scoremanager/main/FavoriteList.action");
                return;
            }

            int targetUserId = Integer.parseInt(targetUserIdStr);

            // 自分自身を解除対象にしない
            if (user.getUser_id() == targetUserId) {
                res.sendRedirect(
                    req.getContextPath()
                    + "/scoremanager/main/FavoriteList.action");
                return;
            }

            // お気に入りを削除
            MatchingFavoriteDAO dao = new MatchingFavoriteDAO();

            dao.delete(user.getUser_id(), targetUserId);

            // 一覧画面に戻る
            res.sendRedirect(
                req.getContextPath()
                + "/scoremanager/main/FavoriteList.action");

        } catch (Exception e) {
            e.printStackTrace();

            throw new ServletException(
                "お気に入り解除に失敗しました。", e);
        }
    }
}