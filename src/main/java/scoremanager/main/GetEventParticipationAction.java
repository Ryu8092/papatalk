package scoremanager.main;
 
import java.util.List;
import java.util.Map;

import dao.ExpectedParticipantsDao;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;
 
public class GetEventParticipationAction extends Action {
 
    @Override
    public void execute(HttpServletRequest req, HttpServletResponse res)
            throws Exception {
 
        // イベントIDを取得
        int event_id = Integer.parseInt(req.getParameter("event_id"));
 
        // 参加予定者を取得
        ExpectedParticipantsDao dao = new ExpectedParticipantsDao();
 
        List<Map<String, Object>> list =
                dao.selectParticipants(event_id);
 
        // 参加予定者一覧をセット
        req.setAttribute("expectedParticipantsList", list);
 
        // 参加予定者一覧画面へ
        req.getRequestDispatcher(
                "/scoremanager/main/list_participants.jsp"
        ).forward(req, res);
    }
}