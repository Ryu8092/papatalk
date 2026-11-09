package scoremanager.main;
 
import java.util.List;

import bean.Post;
import bean.User;
import dao.PostDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;
 
public class GetPostHistoryAction extends Action {
 
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
 
        try {
 
            // ログイン中のユーザー情報を取得
            User user = (User) session.getAttribute("user");
 
            // ログイン中のユーザーIDを取得
            int userId = user.getUser_id();
 
            // PostsDAOを作成
            PostDAO dao = new PostDAO();
 
            // ログイン中のユーザーの投稿履歴を取得
            List<Post> postList = dao.select(userId);
 
            // 投稿履歴をJSPに渡す
            req.setAttribute("postList", postList);
 
            // 投稿履歴画面へ移動
            req.getRequestDispatcher(
                "/scoremanager/main/bulletin_boar_history.jsp"
            ).forward(req, res);
 
        } catch (Exception e) {
 
            e.printStackTrace();
 
            throw new ServletException(
                "投稿履歴の取得に失敗しました。",
                e
            );
        }
    }
}
 