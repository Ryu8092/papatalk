
package scoremanager.main;

import bean.User;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class LogoutControlAction extends Action {

    @Override
    public void execute(
            HttpServletRequest request,
            HttpServletResponse response) throws Exception {

        String action = request.getParameter("action");

        // セッションを取得
        HttpSession session = request.getSession(false);

        // ログインユーザーを取得
        User user = null;

        if (session != null) {
            user = (User) session.getAttribute("user");
        }

        // ログアウトする場合
        if ("ログアウトする".equals(action)) {

            // ログアウト前にユーザー区分を保存
            int userStatus = 0;

            if (user != null) {
                userStatus = user.getUser_status();
            }

            request.setAttribute("userStatus", userStatus);

            // セッションを破棄
            if (session != null) {
                session.invalidate();
            }

            // ログアウト完了画面へ
            request.getRequestDispatcher(
                    "/scoremanager/main/logout_complete.jsp"
            ).forward(request, response);

        }

        // 戻る場合
        else if ("戻る".equals(action)) {

            if (user != null && user.getUser_status() == 9) {

                request.getRequestDispatcher(
                        "/scoremanager/main/operation_management.jsp"
                ).forward(request, response);

            } else {

                request.getRequestDispatcher(
                        "/scoremanager/main/match_list.jsp"
                ).forward(request, response);

            }

        }

        // その他の場合
        else {

            request.getRequestDispatcher(
                    "/scoremanager/main/logout.jsp"
            ).forward(request, response);

        }
    }
}
