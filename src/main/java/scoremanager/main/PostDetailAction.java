
package scoremanager.main;

import java.util.List;

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

public class PostDetailAction extends Action {

    @Override
    public void execute(
        HttpServletRequest request,
        HttpServletResponse response
    ) throws Exception {

        HttpSession session = request.getSession(false);

        // ログイン確認
        if (session == null || session.getAttribute("user") == null) {

            RequestDispatcher dispatcher =
                request.getRequestDispatcher("/login.jsp");

            dispatcher.forward(request, response);
            return;
        }

        User user = (User) session.getAttribute("user");

        // 管理者確認
        if (user.getUser_status() != 9) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        // 投稿ID取得
        String postIdStr = request.getParameter("post_id");

        if (postIdStr == null || !postIdStr.matches("[0-9]+")) {

            response.sendRedirect(
                request.getContextPath()
                + "/scoremanager/main/RetrievePosts.action"
            );

            return;
        }

        int postId;

        try {
            postId = Integer.parseInt(postIdStr);
        } catch (NumberFormatException e) {

            response.sendRedirect(
                request.getContextPath()
                + "/scoremanager/main/RetrievePosts.action"
            );

            return;
        }

        PostDAO postDao = new PostDAO();
        RepliesDAO repliesDao = new RepliesDAO();

        // 投稿情報を取得
        Post post = postDao.selectId(postId);

        if (post == null) {

            response.sendRedirect(
                request.getContextPath()
                + "/scoremanager/main/RetrievePosts.action"
            );

            return;
        }

        // 返信一覧を取得
        List<Replies> replyList =
            repliesDao.selectByPostId(postId);

        request.setAttribute("post", post);
        request.setAttribute("replyList", replyList);

        // 投稿詳細画面へ遷移
        RequestDispatcher dispatcher =
            request.getRequestDispatcher(
                "/scoremanager/main/post_details.jsp"
            );

        dispatcher.forward(request, response);
    }
}
