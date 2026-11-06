package scoremanager.main;
 
import java.util.List;

import bean.Post;
import bean.Replies;
import dao.PostDAO;
import dao.RepliesDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;
 
public class RetrieveRepliesAction extends Action {
 
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
 
            // クリックされた投稿IDを取得
            String postIdText = req.getParameter("post_id");
 
            // 投稿IDが送られていない場合
            if (postIdText == null || postIdText.trim().isEmpty()) {
                throw new ServletException("投稿IDが指定されていません。");
            }
 
            int postId = Integer.parseInt(postIdText);
 
            // 投稿IDの値を確認
            if (postId <= 0) {
                throw new ServletException("正しい投稿IDを指定してください。");
            }
 
 
            // 投稿一覧から対象の投稿を取得
            PostDAO postsDAO = new PostDAO();
 
            List<Post> allPosts = postsDAO.getAll();
 
            Post selectedPost = null;
 
            for (Post post : allPosts) {
 
                if (post.getPost_id() == postId) {
                    selectedPost = post;
                    break;
                }
            }
 
            // 投稿が存在しない場合
            if (selectedPost == null) {
                throw new ServletException("指定された投稿が見つかりません。");
            }
 
 
            // 返信一覧を取得
            RepliesDAO repliesDAO = new RepliesDAO();
 
            List<Replies> replyList = repliesDAO.select(postId);
 
 
            // JSPに投稿情報を渡す
            req.setAttribute("post", selectedPost);
 
            // JSPに返信一覧を渡す
            req.setAttribute("replyList", replyList);
 
 
            // 返信画面へ移動
            req.getRequestDispatcher(
                "/scoremanager/main/replay.jsp"
            ).forward(req, res);
 
 
        } catch (NumberFormatException e) {
 
            throw new ServletException(
                "投稿IDの形式が正しくありません。",
                e
            );
 
        } catch (Exception e) {
 
            e.printStackTrace();
 
            throw new ServletException(
                "投稿返信画面の取得に失敗しました。",
                e
            );
        }
    }
}