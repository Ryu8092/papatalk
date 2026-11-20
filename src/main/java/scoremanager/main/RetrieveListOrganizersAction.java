package scoremanager.main;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import bean.Event;
import bean.EventImage;
import dao.EventDAO;
import dao.EventImageDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class RetrieveListOrganizersAction extends Action {

    @Override
    public void execute(HttpServletRequest req, HttpServletResponse res)
            throws Exception {

        EventDAO dao = new EventDAO();
        EventImageDAO imageDao = new EventImageDAO();

        // イベント一覧を取得
        List<Event> eventList = dao.select();

        // イベントごとの画像一覧を格納
        Map<Integer, List<EventImage>> imageMap = new HashMap<>();

        for (Event event : eventList) {

            List<EventImage> imageList =
                imageDao.select(event.getEvent_id());

            imageMap.put(event.getEvent_id(), imageList);
        }

        req.setAttribute("eventList", eventList);
        req.setAttribute("imageMap", imageMap);

        req.getRequestDispatcher(
            "/scoremanager/main/event_host.jsp"
        ).forward(req, res);
    }
}