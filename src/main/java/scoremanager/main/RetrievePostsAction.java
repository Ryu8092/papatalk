package scoremanager.main;
 
import java.util.ArrayList;
import java.util.List;

import bean.Post;
import dao.PostDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;
 
public class RetrievePostsAction extends Action {
 
    @Override
    public void execute(HttpServletRequest req, HttpServletResponse res)
            throws Exception {
 
        req.setCharacterEncoding("UTF-8");
 
        // ログイン確認
        HttpSession session = req.getSession(false);
 
        if (session == null || session.getAttribute("user") == null) {
            res.sendRedirect(req.getContextPath() + "/scoremanager/Login.action");
            return;
        }
 
        try {
 
            // DAOを使って投稿一覧を取得
            PostDAO dao = new PostDAO();
 
            List<Post> allPosts = dao.getAll();
 
            List<Post> postList = new ArrayList<>();
 
            // 閲覧期限を確認
            for (Post post : allPosts) {
 
                if (post.getView_limit() != null
                        && post.getView_limit().getTime() < System.currentTimeMillis()) {
 
                    continue;
                }
 
                postList.add(post);
            }
 
            // JSPに投稿一覧を渡す
            req.setAttribute("postList", postList);
 
            // 掲示板トップ画面へ移動
            req.getRequestDispatcher(
                "/scoremanager/main/bulletinboard_top.jsp"
            ).forward(req, res);
 
        } catch (Exception e) {
 
            e.printStackTrace();
 
            throw new ServletException(
                "掲示板の投稿一覧の取得に失敗しました。",
                e
            );
        }
    }
}