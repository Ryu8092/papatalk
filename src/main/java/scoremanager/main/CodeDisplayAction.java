
package scoremanager.main;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class CodeDisplayAction extends Action {

    @Override
    public void execute(HttpServletRequest req,
            HttpServletResponse res) throws Exception {

        // 文字コード設定
        req.setCharacterEncoding("UTF-8");

        // メールアドレスを取得
        String email = req.getParameter("email");
        System.out.println(email);
        // JSPにメールアドレスを渡す
        req.setAttribute("email", email);

        // 認証コード入力画面へ遷移
        req.getRequestDispatcher(
                "/scoremanager/main/authentication_code.jsp")
                .forward(req, res);
    }
}
