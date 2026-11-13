package scoremanager.main;
 
import java.sql.Date;

import bean.Event;
import dao.EventDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;
 
public class EventOrganizerRegistrationAction extends Action {
 
    @Override
    public void execute(HttpServletRequest req, HttpServletResponse res)
            throws Exception {
 
        req.setCharacterEncoding("UTF-8");
 
        Event bean = new Event();
 
        bean.setTitle(req.getParameter("title"));
 
        String eventDate = req.getParameter("event_date");
        bean.setEvent_date(Date.valueOf(eventDate.substring(0, 10)));
 
        bean.setDeadline(Date.valueOf(req.getParameter("deadline")));
 
        bean.setCapacity(Integer.parseInt(req.getParameter("capacity")));
 
        bean.setEvent_place(req.getParameter("event_place"));
 
        bean.setEvent_details(req.getParameter("event_details"));
 
        // 写真URLは今回は空文字
        bean.setEvent_url("");
 
        EventDAO dao = new EventDAO();
 
        int line = dao.insert(bean);
 
        if (line > 0) {
            req.getRequestDispatcher(
                "/scoremanager/main/OrganizerCompleteDisplay.action"
            ).forward(req, res);
        }
    }
}