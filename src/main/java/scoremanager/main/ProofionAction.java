//アカウント登録
package scoremanager.main;

import bean.PreUsers;
import dao.PreUsersDao;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class ProofionAction extends Action {

    @Override
    public void execute(HttpServletRequest request,
                        HttpServletResponse response) throws Exception {

        try {
        	
            request.setCharacterEncoding("UTF-8");

            String email = request.getParameter("email");
            String code = request.getParameter("code");
//            System.out.println(email);
//            System.out.println(code);
            
            // 入力チェック
            if (code == null || code.isBlank()) {

                request.setAttribute("message", "メールアドレスと認証コードを入力してください。");
                request.getRequestDispatcher(
                    "/scoremanager/main/authentication_code.jsp"
                ).forward(request, response);
                return;
            }

            int inputCode;

            try {
                inputCode = Integer.parseInt(code);
            } catch (NumberFormatException e) {
                request.setAttribute("message", "認証コードは数字で入力してください。");
                request.getRequestDispatcher(
                    "/scoremanager/main/authentication_code.jsp"
                ).forward(request, response);
                return;
            }

            PreUsersDao dao = new PreUsersDao();
            PreUsers preUser = dao.select(inputCode);

            if (preUser == null) {
                request.setAttribute("message", "仮登録情報が見つかりません。");
                request.getRequestDispatcher(
                    "/scoremanager/main/authentication_code.jsp"
                ).forward(request, response);
                return;
            }

            // 認証コードの確認
            if (preUser.getRandom_code() == inputCode) {
                // 仮登録情報を削除
                dao.delete(preUser);

                // メールアドレスを次の画面へ渡す
                request.getSession().setAttribute("email", email);

                // 情報入力画面へ遷移
                response.sendRedirect(
                    request.getContextPath()
                    + "/scoremanager/main/InfomationDisplay.action"
                );

            } else {
                request.setAttribute("message", "認証コードが一致しません。");
                request.getRequestDispatcher(
                    "/scoremanager/main/authentication_code.jsp"
                ).forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();

            request.setAttribute("message", "予期せぬエラーが発生しました。");
            request.getRequestDispatcher(
                "/scoremanager/main/authentication_code.jsp"
            ).forward(request, response);
        }
    }
}
