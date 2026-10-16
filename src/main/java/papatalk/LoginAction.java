package papatalk;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class LoginAction extends Action {
    public void execute(HttpServletRequest request,
                       HttpServletResponse response) throws Exception {

        request.getRequestDispatcher("/papatalk/login.jsp")
               .forward(request, response);
    }
}