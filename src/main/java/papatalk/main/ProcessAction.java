package papatalk.main;

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

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(
                request.getContextPath() + "/papatalk/main/delete_complete.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");

        UserDao dao = new UserDao();
        int result = dao.updateStatus(user.getUser_name());

        if (result > 0) {
            session.invalidate();

            request.getRequestDispatcher(
                "/papatalk/main/delete_complete.jsp"
            ).forward(request, response);
        } else {
            response.setContentType("text/html; charset=UTF-8");
            response.getWriter().println(
                "アカウントを削除できませんでした。前の画面に戻ってください。");
        }
    }
}