package scoremanager.main;
 
import java.util.List;

import bean.User;
import dao.UserDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;
 
public class MatchListAction extends Action {
 
    @Override
    public void execute(HttpServletRequest req, HttpServletResponse res)
            throws Exception {
 
        // 文字コードを設定
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
 
        // ログインしたユーザーのID
        int loginUserId = user.getUser_id();
 
        try {
 
            // UserDaoを作成
            UserDao dao = new UserDao();
 
            // ログインしたユーザーと同じ都道府県のユーザーを取得
            List<User> userList =
                dao.selectByPrefecture(user.getPrefecture(), loginUserId);
 
            // JSPにユーザー一覧を渡す
            req.setAttribute("userList", userList);
 
            // ログインユーザーの情報を渡す
            req.setAttribute("user", user);
 
            // match_list.jspに画面遷移
            req.getRequestDispatcher(
                "/scoremanager/main/match_list.jsp"
            ).forward(req, res);
 
        } catch (Exception e) {
 
            e.printStackTrace();
 
            throw new ServletException(
                "マッチング一覧の表示に失敗しました。", e
            );
        }
    }
}