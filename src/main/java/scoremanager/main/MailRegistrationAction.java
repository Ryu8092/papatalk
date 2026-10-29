//アカウント登録
package scoremanager.main;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.Random;

import bean.User;
import dao.PreUsersDao;
import dao.UserDao;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class MailRegistrationAction extends Action {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        request.setCharacterEncoding("UTF-8");

        String email = request.getParameter("email");
        UserDao udao = new UserDao();
        User u = udao.select(email);
        
        
        if (u != null) {
            request.setAttribute("errorMessage",
                    "そのメールアドレスはすでに使われています");

            request.getRequestDispatcher("email_address.jsp")
                   .forward(request, response);
            return;
        }
        
        

        try {
            // 6桁の認証コードを生成
            Random rand = new Random();
            int code = 100000 + rand.nextInt(900000);

            // 仮登録情報を保存
            PreUsersDao dao = new PreUsersDao();
            dao.insert(email, code);

            // 認証コードをメールで送信
            MailSender.sendVerificationCode(
                    email, String.valueOf(code));

            // 認証コード入力画面へ遷移
            response.sendRedirect(
                    request.getContextPath()
                    + "/scoremanager/main/CodeDisplay.action?email="
                    + URLEncoder.encode(email, StandardCharsets.UTF_8)
            );

        } catch (Exception e) {
            e.printStackTrace();

            request.setAttribute("errorMessage",
                    "メールの送信または仮登録に失敗しました。"
                    + "メールアドレスを確認して、もう一度お試しください。");

            request.getRequestDispatcher("email_address.jsp")
                   .forward(request, response);
        }
    }
}