
package scoremanager.main;

import dao.UserDao;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class UpdateAction extends Action {

    @Override
    public void execute(HttpServletRequest request,
                        HttpServletResponse response)
            throws Exception {

        // セッション取得
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(
                request.getContextPath()
                + "/scoremanager/main/Operation.action"
            );
            return;
        }

        // 通報されたユーザーIDを取得
        String reportedUserId =
            request.getParameter("reported_user_id");

        if (reportedUserId == null || reportedUserId.isEmpty()) {

            request.setAttribute(
                "errorMessage",
                "停止対象のユーザーが指定されていません。"
            );

            request.getRequestDispatcher(
                "/scoremanager/main/report_details.jsp"
            ).forward(request, response);

            return;
        }

        int reported_user_id;

        try {

            reported_user_id = Integer.parseInt(reportedUserId);

            if (reported_user_id <= 0) {
                throw new NumberFormatException();
            }

        } catch (NumberFormatException e) {

            request.setAttribute(
                "errorMessage",
                "停止対象のユーザーIDが不正です。"
            );

            request.getRequestDispatcher(
                "/scoremanager/main/report_details.jsp"
            ).forward(request, response);

            return;
        }

        // DAO
        UserDao dao = new UserDao();

        // 通報されたユーザーのアカウントを停止
        int result = dao.releaseBan(reported_user_id);

        if (result > 0) {

            // 停止成功
            request.getRequestDispatcher(
                "/scoremanager/main/report_complete.jsp"
            ).forward(request, response);

        } else {

            // すでに停止済み、または対象ユーザーが存在しない
            request.setAttribute(
                "errorMessage",
                "このユーザーはすでに停止されているか、存在しません。"
            );

            request.getRequestDispatcher(
                "/scoremanager/main/report_details.jsp"
            ).forward(request, response);
        }
    }
}
