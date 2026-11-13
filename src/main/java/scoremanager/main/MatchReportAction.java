
package scoremanager.main;

import java.util.List;

import bean.MatchingChat;
import bean.Report;
import bean.User;
import dao.MatchingChatDAO;
import dao.MatchingDAO;
import dao.ReportDao;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class MatchReportAction extends Action {

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

        // フォームから値を取得
        String matchIdStr = req.getParameter("match_id");
        String chatIdStr = req.getParameter("chat_id");
        String reasonIdStr = req.getParameter("report_reason_id");
        String content = req.getParameter("content");

        int matchId;
        int chatId;
        int reasonId;

        // IDの数値チェック
        try {
            matchId = Integer.parseInt(matchIdStr);
            chatId = Integer.parseInt(chatIdStr);
            reasonId = Integer.parseInt(reasonIdStr);

            if (matchId <= 0 || chatId <= 0 || reasonId <= 0) {
                throw new NumberFormatException();
            }

        } catch (NumberFormatException | NullPointerException e) {
            res.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        // 通報内容のチェック
        if (content == null || content.trim().isEmpty()
                || content.trim().length() > 1000) {

            res.sendRedirect(
                req.getContextPath()
                + "/scoremanager/main/MatchingChat.action?match_id="
                + matchId
            );
            return;
        }

        content = content.trim();

        // DAO
        MatchingDAO matchingDAO = new MatchingDAO();
        MatchingChatDAO chatDAO = new MatchingChatDAO();
        ReportDao reportDAO = new ReportDao();

        // マッチング参加者か確認
        if (!matchingDAO.existsMatching(matchId, loginUserId)) {
            res.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        // 指定されたマッチングのチャット一覧を取得
        List<MatchingChat> chatList = chatDAO.select(matchId);

        MatchingChat targetChat = null;

        // 通報対象のチャットを特定
        for (MatchingChat chat : chatList) {
            if (chat.getChat_id() == chatId) {
                targetChat = chat;
                break;
            }
        }

        // チャットが存在しない場合
        if (targetChat == null) {
            res.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        // 自分のチャットは通報できない
        if (targetChat.getUser_id() == loginUserId) {
            res.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        // 通報情報を作成
        Report report = new Report();

        report.setReporter_user_id(loginUserId);
        report.setReported_user_id(targetChat.getUser_id());

        report.setReport_reason_id(reasonId);

        // 1：マッチング
        report.setReport_content_id(1);

        // 通報対象のチャット本文
        report.setReport_content(targetChat.getContent());

        // 通報者が入力した詳細内容
        report.setContent(content);

        // 0：未対応
        report.setState(0);

        // 通報登録
        int count = reportDAO.insert(report);

        if (count > 0) {
            res.sendRedirect(
                req.getContextPath()
                + "/scoremanager/main/MatchingChat.action?match_id="
                + matchId
            );
        } else {
            throw new Exception("通報の登録に失敗しました。");
        }
    }
}
