
package scoremanager.main;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class CompleteDisplayAction extends Action {

    @Override
    public void execute(HttpServletRequest request,
                        HttpServletResponse response) throws Exception {

        request.getRequestDispatcher(
            "/scoremanager/main/registration_complete.jsp"
        ).forward(request, response);
    }
}
