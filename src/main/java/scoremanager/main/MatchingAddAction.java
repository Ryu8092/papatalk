package scoremanager.main;

import bean.Matching;
import bean.User;
import dao.MatchingDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class MatchingAddAction extends Action {

    @Override
    public void execute(HttpServletRequest req, HttpServletResponse res)
            throws Exception {

        req.setCharacterEncoding("UTF-8");

        // ログイン確認
        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            res.sendRedirect(
                req.getContextPath() + "/scoremanager/Login.action"
            );
            return;
        }

        // ログイン中のユーザーを取得
        User user = (User) session.getAttribute("user");

        // ログイン中のユーザーID
        int actionUserId = user.getUser_id();

        // 通知一覧から選択されたユーザーID
        String targetUserIdStr = req.getParameter("target_user_id");

        try {
            if (targetUserIdStr == null || targetUserIdStr.trim().isEmpty()) {
                session.setAttribute(
                    "matchingMessage",
                    "マッチングに失敗しました。"
                );
                res.sendRedirect(
                    req.getContextPath()
                    + "/scoremanager/main/GetFavoriteNotifications.action"
                );
                return;
            }

            int targetUserId = Integer.parseInt(targetUserIdStr);

            // 自分自身とはマッチングできないようにする
            if (actionUserId == targetUserId) {
                session.setAttribute(
                    "matchingMessage",
                    "自分自身とはマッチングできません。"
                );
                res.sendRedirect(
                    req.getContextPath()
                    + "/scoremanager/main/GetFavoriteNotifications.action"
                );
                return;
            }

            // マッチング情報を作成
            Matching matching = new Matching();
            matching.setAction_user_id(actionUserId);
            matching.setTarget_user_id(targetUserId);

            // データベースに登録
            MatchingDAO dao = new MatchingDAO();
            int count = dao.insert(matching);

            // 登録結果
            if (count > 0) {
                session.setAttribute(
                    "matchingMessage",
                    "マッチングしました！"
                );
            } else {
                session.setAttribute(
                    "matchingMessage",
                    "マッチングに失敗しました。"
                );
            }

        } catch (NumberFormatException e) {
            session.setAttribute(
                "matchingMessage",
                "ユーザー情報が正しくありません。"
            );
        }

        // 通知一覧に戻る
        res.sendRedirect(
            req.getContextPath()
            + "/scoremanager/main/GetFavoriteNotifications.action"
        );
    }
}