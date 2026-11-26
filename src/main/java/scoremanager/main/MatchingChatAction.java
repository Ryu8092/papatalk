package scoremanager.main;
 
import java.util.List;

import bean.MatchingChat;
import bean.ReportReason;
import bean.User;
import dao.MatchingChatDAO;
import dao.MatchingDAO;
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
        res.setCharacterEncoding("UTF-8");
 
        HttpSession session = req.getSession(false);
 
        // ログイン確認
        if (session == null || session.getAttribute("user") == null) {
            res.sendError(HttpServletResponse.SC_UNAUTHORIZED);
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
 
            // マッチング参加者か確認
            MatchingDAO matchingDAO = new MatchingDAO();
 
            if (!matchingDAO.existsMatching(matchId, user.getUser_id())) {
                res.sendError(HttpServletResponse.SC_FORBIDDEN);
                return;
            }
 
            MatchingChatDAO dao = new MatchingChatDAO();
 
            // チャット履歴を取得
            List<MatchingChat> chatList = dao.select(matchId);
 
            // 自動更新の場合
            if ("true".equals(req.getParameter("ajax"))) {
 
                res.setContentType("application/json; charset=UTF-8");
 
                StringBuilder json = new StringBuilder();
                json.append("[");
 
                for (int i = 0; i < chatList.size(); i++) {
 
                    MatchingChat chat = chatList.get(i);
 
                    if (i > 0) {
                        json.append(",");
                    }
 
                    json.append("{");
                    json.append("\"chat_id\":").append(chat.getChat_id()).append(",");
                    json.append("\"user_id\":").append(chat.getUser_id()).append(",");
                    json.append("\"nickname\":\"")
                        .append(escapeJson(chat.getNickname())).append("\",");
                    json.append("\"content\":\"")
                        .append(escapeJson(chat.getContent())).append("\",");
                    json.append("\"create_at\":\"")
                        .append(chat.getCreate_at() == null
                            ? ""
                            : chat.getCreate_at().toString())
                        .append("\"");
                    json.append("}");
                }
 
                json.append("]");
 
                res.getWriter().write(json.toString());
                return;
            }
 
            // 通常の画面表示
            req.setAttribute("chatList", chatList);
            req.setAttribute("match_id", matchId);
            req.setAttribute("user", user);
 
            // DBから通報理由一覧を取得してリクエストにセット
            ReportReasonDAO reportReasonDao = new ReportReasonDAO();
 
            List<ReportReason> reportReasons = reportReasonDao.getAll();
 
            req.setAttribute("reportReasons", reportReasons);
 
            // チャット画面へ遷移
            req.getRequestDispatcher(
                "/scoremanager/main/chat_match.jsp"
            ).forward(req, res);
 
        } catch (Exception e) {
 
            e.printStackTrace();
 
            throw new ServletException(
                "チャット画面の表示に失敗しました。", e
            );
        }
    }
 
    // JSON用の文字列変換
    private String escapeJson(String value) {
 
        if (value == null) {
            return "";
        }
 
        return value
            .replace("\\", "\\\\")
            .replace("\"", "\\\"")
            .replace("\n", "\\n")
            .replace("\r", "\\r")
            .replace("\t", "\\t");
    }
}