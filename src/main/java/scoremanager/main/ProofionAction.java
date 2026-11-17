// アカウント登録・メール認証
package scoremanager.main;
 
import java.sql.Timestamp;

import bean.PreUsers;
import dao.PreUsersDao;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;
 
public class ProofionAction extends Action {
 
    @Override
    public void execute(
            HttpServletRequest request,
            HttpServletResponse response) throws Exception {
 
        request.setCharacterEncoding("UTF-8");
 
        try {
 
            // メールアドレスと認証コードを取得
            String email = request.getParameter("email");
            String code = request.getParameter("code");
 
            // 入力チェック
            if (email == null || email.isBlank()
                    || code == null || code.isBlank()) {
 
                request.setAttribute(
                    "error",
                    "メールアドレスと認証コードを入力してください。"
                );
 
                request.setAttribute("email", email);
 
                request.getRequestDispatcher(
                    "/scoremanager/main/authentication_code.jsp"
                ).forward(request, response);
 
                return;
            }
 
            email = email.trim();
            code = code.trim();
 
            // 認証コードが数字か確認
            int inputCode;
 
            try {
                if (!code.matches("[0-9]{6}")) {
                    throw new NumberFormatException();
                }
 
                inputCode = Integer.parseInt(code);
 
            } catch (NumberFormatException e) {
 
                request.setAttribute(
                    "error",
                    "認証コードは6桁の数字で入力してください。"
                );
 
                request.setAttribute("email", email);
 
                request.getRequestDispatcher(
                    "/scoremanager/main/authentication_code.jsp"
                ).forward(request, response);
 
                return;
            }
 
            // DAO
            PreUsersDao dao = new PreUsersDao();
 
            // メールアドレスと認証コードの両方で検索
            PreUsers preUser =
                dao.selectByEmailAndCode(email, inputCode);
 
            // 仮登録情報が存在しない場合
            if (preUser == null) {
 
                request.setAttribute(
                    "error",
                    "認証コードが一致しません。もう一度確認してください。"
                );
 
                request.setAttribute("email", email);
 
                request.getRequestDispatcher(
                    "/scoremanager/main/authentication_code.jsp"
                ).forward(request, response);
 
                return;
            }
 
            // 認証コードの発行日時を取得
            Timestamp createAt = preUser.getCreate_at();
 
            // 発行日時が取得できない場合
            if (createAt == null) {
 
                request.setAttribute(
                    "error",
                    "認証情報を確認できません。認証コードを再送信してください。"
                );
 
                request.setAttribute("email", email);
 
                request.getRequestDispatcher(
                    "/scoremanager/main/authentication_code.jsp"
                ).forward(request, response);
 
                return;
            }
 
            // 30分経過しているか確認
            long currentTime = System.currentTimeMillis();
 
            long createTime = createAt.getTime();
 
            long elapsedTime = currentTime - createTime;
 
            long limitTime = 30 * 60 * 1000L;
 
            if (elapsedTime < 0 || elapsedTime > limitTime) {
 
                request.setAttribute(
                    "error",
                    "認証コードの有効期限が切れています。認証コードを再送信してください。"
                );
 
                request.setAttribute("email", email);
 
                request.getRequestDispatcher(
                    "/scoremanager/main/authentication_code.jsp"
                ).forward(request, response);
 
                return;
            }
 
            // 認証成功
            // 仮登録情報を削除
            dao.delete(preUser);
 
            // メールアドレスをセッションに保存
            request.getSession().setAttribute(
                "email",
                preUser.getEmail()
            );
 
            // 情報入力画面へ遷移
            response.sendRedirect(
                request.getContextPath()
                + "/scoremanager/main/InfomationDisplay.action"
            );
 
        } catch (Exception e) {
 
            e.printStackTrace();
 
            request.setAttribute(
                "error",
                "予期せぬエラーが発生しました。もう一度お試しください。"
            );
 
            request.getRequestDispatcher(
                "/scoremanager/main/authentication_code.jsp"
            ).forward(request, response);
        }
    }
}