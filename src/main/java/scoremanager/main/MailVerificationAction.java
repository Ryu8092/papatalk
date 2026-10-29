//アカウント登録
package scoremanager.main;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class MailVerificationAction extends Action {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        request.setCharacterEncoding("UTF-8");

        String email = request.getParameter("email");

        // メールアドレスの入力確認
        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("errorMessage",
                    "メールアドレスを入力してください。");

            request.getRequestDispatcher("email_address.jsp")
                   .forward(request, response);
            return;
        }

        // メール登録処理へリダイレクト
        String url = request.getContextPath()
                + "/scoremanager/main/MailRegistration.action?email="
                + URLEncoder.encode(email, StandardCharsets.UTF_8);

        response.sendRedirect(url);
    }
}