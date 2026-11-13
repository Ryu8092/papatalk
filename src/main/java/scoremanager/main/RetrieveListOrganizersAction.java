package scoremanager.main;
 
import java.util.List;

import bean.Event;
import dao.EventDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;
 
public class RetrieveListOrganizersAction extends Action {
 
    @Override
    public void execute(HttpServletRequest req, HttpServletResponse res)
            throws Exception {
 
        EventDAO dao = new EventDAO();
 
        List<Event> eventList = dao.select();
 
        req.setAttribute("eventList", eventList);
 
        req.getRequestDispatcher("/scoremanager/main/event_host.jsp")
           .forward(req, res);
    }
}