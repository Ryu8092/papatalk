
package scoremanager.main;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class InfomationDisplayAction extends Action {

    @Override
    public void execute(HttpServletRequest request,
                        HttpServletResponse response) throws Exception {

        // セッションから認証済みメールアドレスを取得
        String email = (String) request.getSession().getAttribute("email");

        // メールアドレスを入力画面へ渡す
        request.setAttribute("email", email);

        // 登録情報入力画面を表示
        request.getRequestDispatcher(
            "/scoremanager/main/enter_information.jsp"
        ).forward(request, response);
    }
}
