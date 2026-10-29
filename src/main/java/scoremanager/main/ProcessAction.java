
package scoremanager.main;

import bean.User;
import dao.UserDao;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class ProcessAction extends Action {

    @Override
    public void execute(HttpServletRequest request,
                        HttpServletResponse response) throws Exception {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);

        // ログインしていない場合
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(
                request.getContextPath() + "/scoremanager/login.jsp"
            );
            return;
        }

        User user = (User) session.getAttribute("user");

        UserDao dao = new UserDao();

        // アカウントの状態を更新
        int result = dao.updateStatus(user.getUser_id());

        if (result > 0) {

            // ログイン情報を破棄
            session.invalidate();

            // 削除完了画面へ遷移
            request.getRequestDispatcher(
                "/scoremanager/main/delete_complete.jsp"
            ).forward(request, response);

        } else {

            // 削除に失敗した場合
            response.setContentType("text/html; charset=UTF-8");
            response.getWriter().println(
                "アカウントを削除できませんでした。前の画面に戻ってください。"
            );
        }
    }
}
