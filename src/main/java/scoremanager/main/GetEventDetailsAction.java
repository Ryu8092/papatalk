
package scoremanager.main;

import java.sql.Date;
import java.util.List;

import bean.Event;
import bean.EventImage;
import dao.EventDAO;
import dao.EventImageDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class GetEventDetailsAction extends Action {

    @Override
    public void execute(HttpServletRequest req, HttpServletResponse res)
            throws Exception {

        // イベントIDを取得
        int event_id = Integer.parseInt(req.getParameter("event_id"));

        // イベント情報を取得
        EventDAO dao = new EventDAO();
        Event event = dao.select(event_id);

        // イベントが存在しない場合
        if (event == null) {
            res.sendRedirect(
                req.getContextPath() + "/scoremanager/main/RetrieveEvents.action"
            );
            return;
        }

        // イベント情報をセット
        req.setAttribute("event", event);

        // イベント写真を取得
        EventImageDAO imageDao = new EventImageDAO();
        List<EventImage> imageList = imageDao.select(event_id);



        // 今日の日付を取得
        Date today = new Date(System.currentTimeMillis());

        // 参加できるか確認
        boolean canApply = event.getDeadline() != null
                && !event.getDeadline().before(today);
        
        req.setAttribute("imageList", imageList);
        req.setAttribute("canApply", canApply);

        // イベント詳細画面へ転送
        req.getRequestDispatcher(
            "/scoremanager/main/event_details.jsp"
        ).forward(req, res);
    }
}
