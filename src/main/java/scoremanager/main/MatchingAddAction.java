package scoremanager.main;
 
import bean.Matching;
import bean.User;
import dao.MatchingDAO;
import dao.MatchingFavoriteDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;
 
public class MatchingAddAction extends Action {
 
    @Override
    public void execute(HttpServletRequest req, HttpServletResponse res)
            throws Exception {
 
        req.setCharacterEncoding("UTF-8");
 
        // セッションを取得
        HttpSession session = req.getSession(false);
 
        // ログイン確認
        if (session == null || session.getAttribute("user") == null) {
            res.sendRedirect(
                req.getContextPath() + "/scoremanager/Login.action"
            );
            return;
        }
 
        // ログイン中のユーザーを取得
        User user = (User) session.getAttribute("user");
 
        // 自分のユーザーID
        int actionUserId = user.getUser_id();
 
        // マッチング相手のユーザーIDを取得
        String targetUserIdStr = req.getParameter("target_user_id");
 
        // 相手のIDが存在しない場合
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
 
        try {
 
            // 相手のユーザーIDを数値に変換
            int targetUserId = Integer.parseInt(targetUserIdStr);
 
            // 不正なIDを確認
            if (targetUserId <= 0) {
 
                session.setAttribute(
                    "matchingMessage",
                    "ユーザー情報が正しくありません。"
                );
 
            }
            // 自分自身とはマッチングできない
            else if (actionUserId == targetUserId) {
 
                session.setAttribute(
                    "matchingMessage",
                    "自分自身とはマッチングできません。"
                );
 
            } else {
 
                // マッチング情報を作成
                Matching matching = new Matching();
 
                matching.setAction_user_id(actionUserId);
                matching.setTarget_user_id(targetUserId);
 
                // マッチングを登録
                MatchingDAO matchingDAO = new MatchingDAO();
 
                int count = matchingDAO.insert(matching);
 
                if (count > 0) {
 
                    // お気に入り情報を削除
                    MatchingFavoriteDAO favoriteDAO =
                        new MatchingFavoriteDAO();
 
                    // アクション側のお気に入りを削除
                    favoriteDAO.deleteAction(
                        actionUserId, targetUserId
                    );
 
                    // ターゲット側のお気に入りを削除
                    favoriteDAO.deleteTarget(
                        actionUserId, targetUserId
                    );
 
                    // 成功メッセージ
                    session.setAttribute(
                        "matchingMessage",
                        "マッチングしました！"
                    );
 
                } else {
 
                    // すでに登録されている場合
                    session.setAttribute(
                        "matchingMessage",
                        "すでにマッチング済みです。"
                    );
 
                }
            }
 
        } catch (NumberFormatException e) {
 
            // ユーザーIDが数値ではない場合
            session.setAttribute(
                "matchingMessage",
                "ユーザー情報が正しくありません。"
            );
 
        } catch (Exception e) {
 
            // データベースなどでエラーが発生した場合
            e.printStackTrace();
 
            session.setAttribute(
                "matchingMessage",
                "マッチングに失敗しました。"
            );
 
        }
 
        // お気に入り通知一覧に戻る
        res.sendRedirect(
            req.getContextPath()
            + "/scoremanager/main/GetFavoriteNotifications.action"
        );
 
    }
}