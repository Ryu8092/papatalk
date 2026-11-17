package scoremanager.main;
 
import bean.PreUsers;
import dao.PreUsersDao;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;
 
public class DeletePreUserAction extends Action {
 
    @Override
    public void execute(
            HttpServletRequest request,
            HttpServletResponse response) throws Exception {
 
        request.setCharacterEncoding("UTF-8");
 
        // メールアドレスを取得
        String email = request.getParameter("email");
 
        try {
 
            // メールアドレスの入力チェック
            if (email == null || email.isBlank()) {
 
                request.getSession().setAttribute(
                    "errorMessage",
                    "メールアドレスを取得できませんでした。"
                );
 
                response.sendRedirect(
                    request.getContextPath()
                    + "/scoremanager/main/email_address.jsp"
                );
                return;
            }
 
            email = email.trim();
 
            // 仮登録情報を削除
            PreUsers preUsers = new PreUsers();
            preUsers.setEmail(email);
 
            PreUsersDao dao = new PreUsersDao();
 
            int result = dao.delete(preUsers);
 
            if (result == 0) {
 
                // 削除対象が存在しなかった場合
                request.getSession().setAttribute(
                    "errorMessage",
                    "削除する仮登録情報が見つかりませんでした。"
                );
            }
 
            // 古い成功メッセージを削除
            request.getSession().removeAttribute("message");
 
        } catch (Exception e) {
 
            e.printStackTrace();
 
            // 削除失敗
            request.getSession().setAttribute(
                "errorMessage",
                "仮登録情報の削除に失敗しました。もう一度お試しください。"
            );
        }
 
        // メールアドレス入力画面に戻る
        response.sendRedirect(
            request.getContextPath()
            + "/scoremanager/main/email_address.jsp"
        );
    }
}