
package scoremanager.main;

import java.io.IOException;

import bean.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class CompletionScreenAction extends Action {

    @Override
    public void execute(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
    	
    	 System.out.println("CompletionScreenAction が実行されました");
        // ログイン中のユーザーを取得
        User user = (User) req.getSession().getAttribute("user");

        // ログインしていない場合
        if (user == null) {
            res.sendRedirect(req.getContextPath() + "/Login.action");
            return;
        }
        System.out.println("完了画面JSPへ転送します");
        // 完了画面を表示
        req.getRequestDispatcher(
            "/scoremanager/main/comfirm_accountinformation.jsp"
        ).forward(req, res);
    }
}
