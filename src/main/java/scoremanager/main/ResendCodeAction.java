package scoremanager.main;
 
import java.security.SecureRandom;

import bean.PreUsers;
import dao.PreUsersDao;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;
 
public class ResendCodeAction extends Action {
 
    @Override
    public void execute(
            HttpServletRequest request,
            HttpServletResponse response) throws Exception {
 
        request.setCharacterEncoding("UTF-8");
 
        String email = request.getParameter("email");
 
        // メールアドレス確認
        if (email == null || email.isBlank()) {
            request.setAttribute("error",
                    "メールアドレスが確認できません。");
            request.getRequestDispatcher(
                    "/scoremanager/main/authentication_code.jsp")
                    .forward(request, response);
            return;
        }
 
        email = email.trim();
 
        try {
            PreUsersDao dao = new PreUsersDao();
 
            // 仮登録情報を取得
            PreUsers preUser = dao.selectByEmail(email);
 
            if (preUser == null) {
                request.setAttribute("error",
                        "仮登録情報が見つかりません。");
                request.setAttribute("email", email);
                request.getRequestDispatcher(
                        "/scoremanager/main/authentication_code.jsp")
                        .forward(request, response);
                return;
            }
 
            // 新しい6桁の認証コードを生成
            SecureRandom random = new SecureRandom();
            int code = 100000 + random.nextInt(900000);
 
            // データベースの認証コードと発行日時を更新
            int result = dao.updateCode(email, code);
 
            if (result == 0) {
                request.setAttribute("error",
                        "認証コードの更新に失敗しました。");
                request.setAttribute("email", email);
                request.getRequestDispatcher(
                        "/scoremanager/main/authentication_code.jsp")
                        .forward(request, response);
                return;
            }
 
            // メール送信
            MailSender.sendVerificationCode(
                    email, String.valueOf(code));
 
            request.setAttribute("message",
                    "新しい認証コードをメールに送信しました。");
 
        } catch (Exception e) {
            e.printStackTrace();
 
            request.setAttribute("error",
                    "認証コードの再送信に失敗しました。");
        }
 
        request.setAttribute("email", email);
 
        request.getRequestDispatcher(
                "/scoremanager/main/authentication_code.jsp")
                .forward(request, response);
    }
}