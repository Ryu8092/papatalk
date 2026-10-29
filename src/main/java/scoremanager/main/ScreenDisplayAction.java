package scoremanager.main;
 
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;
 
public class ScreenDisplayAction extends Action {
    public void execute(HttpServletRequest request,
                        HttpServletResponse response) throws Exception {
        request.getRequestDispatcher(
            "/scoremanager/main/delete_confirm.jsp"
        ).forward(request, response);
    }
}