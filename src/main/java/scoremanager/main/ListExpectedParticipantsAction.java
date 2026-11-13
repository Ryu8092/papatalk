package scoremanager.main;
 
import java.util.ArrayList;
import java.util.List;

import bean.Event;
import bean.ExpectedParticipants;
import bean.User;
import dao.EventDAO;
import dao.ExpectedParticipantsDao;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;
 
public class ListExpectedParticipantsAction extends Action {
 
    @Override
    public void execute(HttpServletRequest req, HttpServletResponse res)
            throws Exception {
 
        // ログイン情報を取得
        HttpSession session = req.getSession();
        User loginUser = (User) session.getAttribute("user");
 
        // 参加予定を取得
        ExpectedParticipantsDao dao = new ExpectedParticipantsDao();
 
        List<ExpectedParticipants> list =
                dao.selectByUserId(loginUser.getUser_id());
 
        // 予約済みイベントの情報を取得
        EventDAO eventDao = new EventDAO();
 
        List<Event> eventList = new ArrayList<>();
 
        for (ExpectedParticipants participants : list) {
 
            Event event = eventDao.select(participants.getEvent_id());
 
            if (event != null) {
                eventList.add(event);
            }
        }
 
        // 参加予定一覧をセット
        req.setAttribute("plannedEventList", eventList);
 
        // 参加予定一覧画面へ
        req.getRequestDispatcher(
                "/scoremanager/main/plannedattend.jsp"
        ).forward(req, res);
    }
}