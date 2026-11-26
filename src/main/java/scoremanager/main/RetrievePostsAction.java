
package scoremanager.main;

import java.util.List;

import bean.Post;
import bean.User;
import dao.PostDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class RetrievePostsAction extends Action {

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

        // 管理者以外は利用できない
        if (user.getUser_status() != 9) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        // 投稿一覧を取得
        PostDAO dao = new PostDAO();

        List<Post> postList = dao.getAll();

        request.setAttribute("postList", postList);

        // 投稿一覧画面へ遷移
        RequestDispatcher dispatcher =
            request.getRequestDispatcher(
                "/scoremanager/main/post_list.jsp"
            );

        dispatcher.forward(request, response);
    }
}
