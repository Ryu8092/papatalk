
package scoremanager.main;

import bean.Post;
import bean.Replies;
import bean.User;
import dao.PostDAO;
import dao.RepliesDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class PostReplyAction extends Action {

    @Override
    public void execute(
            HttpServletRequest request,
            HttpServletResponse response) throws Exception {

        // セッションからログインユーザーを取得
        HttpSession session = request.getSession(false);

        if (session == null) {
            forward(request, response,
                    "/scoremanager/main/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");

        // ログイン確認
        if (user == null) {
            forward(request, response,
                    "/scoremanager/main/login.jsp");
            return;
        }

        // 管理者確認（user_status：9が管理者）
        if (user.getUser_status() != 9) {
            request.setAttribute(
                    "errorMessage",
                    "管理者のみ返信できます。");

            forward(request, response,
                    "/scoremanager/main/post_list.jsp");
            return;
        }

        // フォームから値を取得
        String postIdStr = request.getParameter("post_id");
        String replyContent = request.getParameter("reply_content");

        // 投稿IDの確認
        int postId;

        try {
            postId = Integer.parseInt(postIdStr);
        } catch (Exception e) {
            request.setAttribute(
                    "errorMessage",
                    "投稿IDが正しくありません。");

            forward(request, response,
                    "/scoremanager/main/post_list.jsp");
            return;
        }

        // 返信内容の確認
        if (replyContent == null || replyContent.trim().isEmpty()) {
            request.setAttribute(
                    "errorMessage",
                    "返信内容を入力してください。");

            showPostDetail(request, response, postId);
            return;
        }

        // 返信内容の前後の空白を削除
        replyContent = replyContent.trim();

        // 返信登録用Beanを作成
        Replies reply = new Replies();

        reply.setPost_id(postId);
        reply.setUser_id(user.getUser_id());
        reply.setReply_content(replyContent);

        // DAOで返信を登録
        RepliesDAO repliesDAO = new RepliesDAO();

        int result = repliesDAO.insert(reply);

        // 登録結果
        if (result > 0) {
            request.setAttribute(
                    "replyMessage",
                    "返信を登録しました。");
        } else {
            request.setAttribute(
                    "errorMessage",
                    "返信の登録に失敗しました。");
        }

        // 投稿詳細と返信一覧を再取得
        showPostDetail(request, response, postId);
    }

    // 投稿詳細画面を再表示する
    private void showPostDetail(
            HttpServletRequest request,
            HttpServletResponse response,
            int postId) throws Exception {

        PostDAO postDAO = new PostDAO();
        RepliesDAO repliesDAO = new RepliesDAO();

        // 投稿情報を取得
        Post post = postDAO.selectId(postId);

        if (post == null) {
            request.setAttribute(
                    "errorMessage",
                    "投稿が見つかりません。");

            forward(request, response,
                    "/scoremanager/main/post_list.jsp");
            return;
        }

        // 返信一覧を取得
        request.setAttribute("post", post);

        request.setAttribute(
                "replyList",
                repliesDAO.selectByPostId(postId));

        forward(request, response,
                "/scoremanager/main/post_details.jsp");
    }

    // JSPへフォワードする
    private void forward(
            HttpServletRequest request,
            HttpServletResponse response,
            String path) throws Exception {

        RequestDispatcher dispatcher =
                request.getRequestDispatcher(path);

        dispatcher.forward(request, response);
    }
}
