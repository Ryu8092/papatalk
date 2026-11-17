package scoremanager.main;
 
import bean.User;
import dao.MatchingChatDAO;
import dao.MatchingDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;
 
public class MatchingDeleteAction extends Action {
 
    @Override
    public void execute(
            HttpServletRequest req,
            HttpServletResponse res) throws Exception {
 
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
 
        // マッチングID取得
        String id = req.getParameter("match_id");
 
        if (id == null || !id.matches("[0-9]+")) {
            res.sendRedirect(
                req.getContextPath()
                + "/scoremanager/main/MatchingList.action"
            );
            return;
        }
 
        int matchId = Integer.parseInt(id);
 
        MatchingDAO matchingDAO = new MatchingDAO();
        MatchingChatDAO chatDAO = new MatchingChatDAO();
 
        // マッチングが存在し、自分が参加しているか確認
        if (matchingDAO.existsMatching(matchId, user.getUser_id())) {
 
            // チャット履歴を削除
            chatDAO.deleteByMatchId(matchId);
 
            // マッチング情報を削除
            matchingDAO.delete(matchId, user.getUser_id());
        }
 
        // マッチング一覧に戻る
        res.sendRedirect(
            req.getContextPath()
            + "/scoremanager/main/MatchingList.action"
        );
    }
}