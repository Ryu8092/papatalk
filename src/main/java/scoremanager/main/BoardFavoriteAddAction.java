package scoremanager.main;

import bean.MatchingFavorite;
import bean.User;
import dao.MatchingFavoriteDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class BoardFavoriteAddAction extends Action {

    @Override
    public void execute(HttpServletRequest req, HttpServletResponse res)
            throws Exception {

        req.setCharacterEncoding("UTF-8");

        // セッションからログインユーザーを取得
        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            res.sendRedirect(req.getContextPath() + "/scoremanager/Login.action");
            return;
        }

        User loginUser = (User) session.getAttribute("user");

        // ログインユーザーのID
        int actionUserId = loginUser.getUser_id();

        try {

            // イイネする相手のIDを取得
            String targetUserIdText = req.getParameter("target_user_id");

            // 元の投稿IDを取得
            String postIdText = req.getParameter("post_id");

            if (targetUserIdText == null || targetUserIdText.trim().isEmpty()
                    || postIdText == null || postIdText.trim().isEmpty()) {
                throw new ServletException("必要な情報が指定されていません。");
            }

            int targetUserId = Integer.parseInt(targetUserIdText);
            int postId = Integer.parseInt(postIdText);

            if (targetUserId <= 0 || postId <= 0) {
                throw new ServletException("正しいIDを指定してください。");
            }

            // 自分自身にはイイネできない
            if (actionUserId == targetUserId) {

                req.setAttribute(
                    "errorMessage", "自分自身にはイイネできません。"
                );

            } else {

                // イイネ情報を作成
                MatchingFavorite favorite = new MatchingFavorite();

                favorite.setAction_user_id(actionUserId);
                favorite.setTarget_user_id(targetUserId);

                // DAOで登録
                MatchingFavoriteDAO dao = new MatchingFavoriteDAO();

                int count = dao.insert(favorite);

                // 登録結果をJSPに渡す
                if (count == 1) {

                    req.setAttribute(
                        "message", "イイネしました。"
                    );

                } else {

                    req.setAttribute(
                        "errorMessage", "イイネできませんでした。"
                    );

                }
            }

            // 元の投稿の返信一覧へ戻る
            req.getRequestDispatcher(
                "/scoremanager/main/RetrieveReplies.action?post_id=" + postId
            ).forward(req, res);

        } catch (NumberFormatException e) {

            throw new ServletException("IDの形式が正しくありません。", e);

        }
    }
}