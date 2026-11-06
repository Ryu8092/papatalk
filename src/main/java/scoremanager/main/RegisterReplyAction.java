package scoremanager.main;
 
import bean.Replies;
import bean.User;
import dao.RepliesDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;
 
public class RegisterReplyAction extends Action {
 
    @Override
    public void execute(HttpServletRequest req, HttpServletResponse res)
            throws Exception {
 
        req.setCharacterEncoding("UTF-8");
 
        // ログイン情報を取得
        HttpSession session = req.getSession(false);
 
        if (session == null || session.getAttribute("user") == null) {
            res.sendRedirect(
                req.getContextPath() + "/scoremanager/Login.action"
            );
            return;
        }
 
        try {
            // ログインユーザーを取得
            User user = (User) session.getAttribute("user");
 
            int userId = user.getUser_id();
 
            // フォームから送られた値を取得
            String postIdText = req.getParameter("post_id");
            String replyContent = req.getParameter("reply_content");
 
            // 投稿IDの確認
            if (postIdText == null || postIdText.trim().isEmpty()) {
                throw new ServletException("投稿IDが指定されていません。");
            }
 
            int postId = Integer.parseInt(postIdText);
 
            if (postId <= 0) {
                throw new ServletException("正しい投稿IDを指定してください。");
            }
 
            // 返信内容の確認
            if (replyContent == null || replyContent.trim().isEmpty()) {
                res.sendRedirect(
                    req.getContextPath()
                    + "/scoremanager/main/RetrieveReplies.action?post_id="
                    + postId
                );
                return;
            }
 
            replyContent = replyContent.trim();
 
            if (replyContent.length() > 500) {
                throw new ServletException("返信は500文字以内で入力してください。");
            }
 
            // Repliesに返信情報を設定
            Replies reply = new Replies();
 
            reply.setPost_id(postId);
            reply.setUser_id(userId);
            reply.setReply_content(replyContent);
 
            // データベースに返信を登録
            RepliesDAO dao = new RepliesDAO();
 
            int insertCount = dao.insert(reply);
 
            if (insertCount > 0) {
 
                // 登録成功後、同じ投稿の返信画面に戻る
                res.sendRedirect(
                    req.getContextPath()
                    + "/scoremanager/main/RetrieveReplies.action?post_id="
                    + postId
                );
 
            } else {
                throw new ServletException("返信の登録に失敗しました。");
            }
 
        } catch (NumberFormatException e) {
            throw new ServletException("投稿IDの形式が正しくありません。", e);
 
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("返信の登録中にエラーが発生しました。", e);
        }
    }
}