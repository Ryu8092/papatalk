package scoremanager.main;
 
import java.sql.Date;

import bean.Event;
import dao.EventDAO;
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
 
        // イベント情報をセット
        req.setAttribute("event", event);
 
        // 今日の日付を取得
        Date today = new Date(System.currentTimeMillis());
 
        // 参加できるか確認
        boolean canApply = event != null
			&& event.getDeadline() != null
			&& !event.getDeadline().before(today);
 
        req.setAttribute("canApply", canApply);
 
        // イベント詳細画面へ転送
        req.getRequestDispatcher(
            "/scoremanager/main/event_details.jsp"
        ).forward(req, res);
    }
}