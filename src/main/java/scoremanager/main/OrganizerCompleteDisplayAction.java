package scoremanager.main;
 
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;
 
public class OrganizerCompleteDisplayAction extends Action {
 
    @Override
    public void execute(HttpServletRequest req, HttpServletResponse res)
            throws Exception {
 
        req.getRequestDispatcher(
            "/scoremanager/main/event_organizer_complete.jsp"
        ).forward(req, res);
    }
}