package scoremanager.main;

import java.sql.Date;
import java.time.LocalDate;
import java.util.List;

import bean.Event;
import dao.EventDAO;
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
            res.sendRedirect(req.getContextPath() + "/scoremanager/Login.action");
            return;
        }
        // 今日の日付を取得
        Date today = Date.valueOf(LocalDate.now());

        // DAOを使ってイベント一覧を取得
        EventDAO dao = new EventDAO();
        List<Event> eventList = dao.select(today);

        // JSPにイベント一覧を渡す
        req.setAttribute("eventList", eventList);

        // イベント一覧画面へ遷移
        req.getRequestDispatcher("/scoremanager/main/event_list.jsp").forward(req, res);
    }
}