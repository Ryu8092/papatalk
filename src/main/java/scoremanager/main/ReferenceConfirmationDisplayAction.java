package scoremanager.main;
 
import bean.Event;
import dao.EventDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;
 
public class ReferenceConfirmationDisplayAction extends Action {
 
    @Override
    public void execute(HttpServletRequest req, HttpServletResponse res)
            throws Exception {
 
        int event_id = Integer.parseInt(req.getParameter("event_id"));
 
        EventDAO dao = new EventDAO();
 
        Event event = dao.select(event_id);
 
        req.setAttribute("event", event);
 
        req.getRequestDispatcher(
            "/scoremanager/main/partici_pation_confirmation.jsp"
        ).forward(req, res);
    }
}