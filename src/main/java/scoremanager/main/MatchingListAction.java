package scoremanager.main;
 
import java.util.List;

import bean.User;
import dao.MatchingDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;
 
public class MatchingListAction extends Action {
 
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
 
        // ログインユーザーを取得
        User user = (User) session.getAttribute("user");
 
        int loginUserId = user.getUser_id();
 
        try {
 
            // マッチングDAOを作成
            MatchingDAO dao = new MatchingDAO();
 
            // マッチング成立済みのユーザーを取得
            List<User> matchingList =
                dao.selectMatchingUsers(loginUserId);
 
            // JSPにデータを渡す
            req.setAttribute("matchingList", matchingList);
            req.setAttribute("user", user);
            // マッチング成立済み一覧画面へ
            req.getRequestDispatcher(
                "/scoremanager/main/matching_list.jsp"
            ).forward(req, res);
 
        } catch (Exception e) {
 
            e.printStackTrace();
 
            throw new ServletException(
                "マッチング中一覧の表示に失敗しました。", e
            );
        }
    }
}