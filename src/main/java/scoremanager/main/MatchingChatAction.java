package scoremanager.main;

import java.util.List;

import bean.MatchingChat;
import bean.ReportReason;
import bean.User;
import dao.MatchingChatDAO;
import dao.ReportReasonDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class MatchingChatAction extends Action {

    @Override
    public void execute(HttpServletRequest req, HttpServletResponse res)
            throws Exception {

        req.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession(false);

        // ログイン確認
        if (session == null || session.getAttribute("user") == null) {
            res.sendRedirect(
                req.getContextPath() + "/scoremanager/Login.action"
            );
            return;
        }

        User user = (User) session.getAttribute("user");

        // マッチングIDを取得
        String matchIdStr = req.getParameter("match_id");

        if (matchIdStr == null || !matchIdStr.matches("\\d+")) {
            res.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        int matchId = Integer.parseInt(matchIdStr);

        try {

            MatchingChatDAO dao = new MatchingChatDAO();

            // チャット履歴を取得
            List<MatchingChat> chatList = dao.select(matchId);

            req.setAttribute("chatList", chatList);
            req.setAttribute("match_id", matchId);
            req.setAttribute("user", user);
            
            // DBから通報理由一覧を取得してリクエストにセット
            ReportReasonDAO reportReasonDao = new ReportReasonDAO();
            
            List<ReportReason> reportReasons = reportReasonDao.getAll();
            
            req.setAttribute("reportReasons", reportReasons);
            
            // チャット画面へ遷移
            req.getRequestDispatcher(
                "/scoremanager/main/matching_chat.jsp"
            ).forward(req, res);

        } catch (Exception e) {

            e.printStackTrace();

            throw new ServletException(
                "チャット画面の表示に失敗しました。", e
            );
        }
    }
}