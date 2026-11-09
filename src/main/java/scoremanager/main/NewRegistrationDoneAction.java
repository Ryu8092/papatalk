package scoremanager.main;
 
import bean.Post;
import bean.User;
import dao.PostDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;
 
public class NewRegistrationDoneAction extends Action {
 
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
 
            // フォームから入力内容を取得
            String title = req.getParameter("title");
            String content = req.getParameter("content");
 
            // 入力チェック
            if (title == null || title.trim().isEmpty()
                    || content == null || content.trim().isEmpty()) {
 
                req.setAttribute(
                    "errorMessage",
                    "タイトルと投稿内容を入力してください。"
                );
 
                req.getRequestDispatcher(
                    "/scoremanager/main/newpost.jsp"
                ).forward(req, res);
 
                return;
            }
 
            // Postsオブジェクトを作成
            Post post = new Post();
 
            // 投稿情報を設定
            post.setUser_id(user.getUser_id());
            post.setPost_title(title.trim());
            post.setPost_content(content.trim());
 
            // DAOを使ってデータベースに登録
            PostDAO dao = new PostDAO();
 
            int insertCount = dao.insert(post);
 
            // 登録結果を確認
            if (insertCount > 0) {
 
                // 投稿完了Actionへ移動
                req.getRequestDispatcher(
                    "/scoremanager/main/RegistrationComplete.action"
                ).forward(req, res);
 
            } else {
 
                req.setAttribute(
                    "errorMessage",
                    "投稿に失敗しました。もう一度お試しください。"
                );
 
                req.getRequestDispatcher(
                    "/scoremanager/main/newpost.jsp"
                ).forward(req, res);
            }
 
        } catch (Exception e) {
 
            e.printStackTrace();
 
            throw new ServletException(
                "投稿の登録に失敗しました。",
                e
            );
        }
    }
}