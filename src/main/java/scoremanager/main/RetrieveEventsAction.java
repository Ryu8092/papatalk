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
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class RetrieveEventsAction extends Action {

    @Override
    public void execute(HttpServletRequest req, HttpServletResponse res)
            throws Exception {

        // ログイン確認
        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            res.sendRedirect(
                req.getContextPath() + "/scoremanager/Login.action"
            );
            return;
        }

        // DAOを使ってイベント一覧を取得
        EventDAO dao = new EventDAO();
        List<Event> eventList = dao.select();

        // イベントごとの画像を取得
        EventImageDAO imageDao = new EventImageDAO();

        Map<Integer, List<EventImage>> imageMap = new HashMap<>();

        for (Event event : eventList) {

            List<EventImage> imageList =
                imageDao.select(event.getEvent_id());

            imageMap.put(event.getEvent_id(), imageList);
        }

        // JSPにイベント一覧と画像一覧を渡す
        req.setAttribute("eventList", eventList);
        req.setAttribute("imageMap", imageMap);

        // イベント一覧画面へ遷移
        req.getRequestDispatcher(
            "/scoremanager/main/event_list.jsp"
        ).forward(req, res);
    }
}