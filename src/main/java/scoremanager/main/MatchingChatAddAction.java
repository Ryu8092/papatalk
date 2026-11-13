
package scoremanager.main;

import bean.MatchingChat;
import bean.User;
import dao.MatchingChatDAO;
import dao.MatchingDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class MatchingChatAddAction extends Action {

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

        User user = (User) session.getAttribute("user");
        int loginUserId = user.getUser_id();

        // パラメータ取得
        String matchIdStr = req.getParameter("match_id");
        String content = req.getParameter("content");

        // match_idの確認
        int matchId;

        try {
            matchId = Integer.parseInt(matchIdStr);
        } catch (NumberFormatException | NullPointerException e) {
            res.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        // メッセージの空白チェック
        if (content == null || content.trim().isEmpty()) {
            res.sendRedirect(
                req.getContextPath()
                + "/scoremanager/main/MatchingChat.action?match_id="
                + matchId
            );
            return;
        }

        content = content.trim();

        // 文字数チェック
        if (content.length() > 1000) {
            res.sendRedirect(
                req.getContextPath()
                + "/scoremanager/main/MatchingChat.action?match_id="
                + matchId
            );
            return;
        }

        try {
            // ログインユーザーがマッチングの参加者か確認
            MatchingDAO matchingDAO = new MatchingDAO();

            if (!matchingDAO.existsMatching(matchId, loginUserId)) {
                res.sendError(HttpServletResponse.SC_FORBIDDEN);
                return;
            }

            // チャット情報を作成
            MatchingChat chat = new MatchingChat();
            chat.setMatch_id(matchId);
            chat.setUser_id(loginUserId);
            chat.setContent(content);

            // DBに登録
            MatchingChatDAO chatDAO = new MatchingChatDAO();
            int count = chatDAO.insert(chat);

            if (count > 0) {
                // 登録後、チャット画面へ戻る
                res.sendRedirect(
                    req.getContextPath()
                    + "/scoremanager/main/MatchingChat.action?match_id="
                    + matchId
                );
            } else {
                throw new Exception("メッセージの登録に失敗しました。");
            }

        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }
}
