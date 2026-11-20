package scoremanager.main;
 
import bean.User;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;
 
public class PasswordChangeAction extends Action {
 
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
 
        request.setAttribute("user", user);
 
        // パスワード変更画面へ
        request.getRequestDispatcher(
                "/scoremanager/main/password_change.jsp"
        ).forward(request, response);
    }
}