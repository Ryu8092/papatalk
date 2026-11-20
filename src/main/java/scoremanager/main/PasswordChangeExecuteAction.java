package scoremanager.main;
 
import org.mindrot.jbcrypt.BCrypt;

import bean.User;
import dao.UserDao;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;
 
public class PasswordChangeExecuteAction extends Action {
 
    @Override
    public void execute(
            HttpServletRequest request,
            HttpServletResponse response) throws Exception {
 
        request.setCharacterEncoding("UTF-8");
 
        HttpSession session = request.getSession(false);
 
        // ログイン確認
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("Login.action");
            return;
        }
 
        User user = (User) session.getAttribute("user");
 
        // 入力内容取得
        String currentPassword =
                request.getParameter("current_password");
 
        String newPassword =
                request.getParameter("new_password");
 
        String confirmPassword =
                request.getParameter("confirm_password");
        System.out.println(currentPassword);
        System.out.println(newPassword);
        System.out.println(confirmPassword);
        // 未入力チェック
        if (currentPassword == null || currentPassword.isEmpty()
                || newPassword == null || newPassword.isEmpty()
                || confirmPassword == null || confirmPassword.isEmpty()) {
 
            request.setAttribute("error",
                    "すべての項目を入力してください。");
 
            forward(request, response);
            return;
        }
 
        // 新しいパスワードの文字数チェック
        if (newPassword.length() < 8) {
 
            request.setAttribute("error",
                    "新しいパスワードは8文字以上にしてください。");
 
            forward(request, response);
            return;
        }
 
        // 現在と同じパスワードへの変更を防止
        if (currentPassword.equals(newPassword)) {
 
            request.setAttribute("error",
                    "現在とは異なるパスワードを設定してください。");
 
            forward(request, response);
            return;
        }
 
        // 新しいパスワードの一致確認
        if (!newPassword.equals(confirmPassword)) {
 
            request.setAttribute("error",
                    "新しいパスワードと確認用パスワードが一致しません。");
 
            forward(request, response);
            return;
        }
 
        // 現在のパスワードをBCryptで確認
        String hashedCurrentPassword = user.getPassword();
 
        if (hashedCurrentPassword == null
                || !BCrypt.checkpw(
                        currentPassword,
                        hashedCurrentPassword)) {
 
            request.setAttribute("error",
                    "現在のパスワードが正しくありません。");
 
            forward(request, response);
            return;
        }
 
        // 新しいパスワードをBCryptでハッシュ化
        String hashedNewPassword = BCrypt.hashpw(
                newPassword,
                BCrypt.gensalt()
        );
 
        UserDao dao = new UserDao();
 
        // ハッシュ化したパスワードをDBに保存
        int result = dao.update(
                user.getUser_id(),
                hashedNewPassword
        );
 
        if (result == 1) {

            // セッションのユーザー情報を更新
            user.setPassword(hashedNewPassword);
            session.setAttribute("user", user);

            // 成功メッセージ
            request.setAttribute("message", "パスワードを変更しました。");

            // アカウント情報画面へ
            request.getRequestDispatcher(
                    "/scoremanager/main/accountinformation.jsp"
            ).forward(request, response);

        } else {

            request.setAttribute("error",
                    "パスワードの変更に失敗しました。");

            // パスワード変更画面へ
            forward(request, response);
        }
    }
 
    // パスワード変更画面へ戻る
    private void forward(
            HttpServletRequest request,
            HttpServletResponse response) throws Exception {
 
        request.getRequestDispatcher(
        		 "/scoremanager/main/password_change.jsp"
        ).forward(request, response);
    }
}