package scoremanager.main;
 
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
 
public class ParticipationRegistrationAction extends Action {
 
    @Override
    public void execute(HttpServletRequest req, HttpServletResponse res)
            throws Exception {
 
        req.setCharacterEncoding("UTF-8");
 
        // ログイン情報を取得
        HttpSession session = req.getSession();
        User loginUser = (User) session.getAttribute("user");
 
        // 入力値を取得
        String eventId = req.getParameter("event_id");
        String adultNumber = req.getParameter("adultnumber");
        String childNumber = req.getParameter("childnumber");
 
        // 入力された人数を確認
        System.out.println("大人人数：" + adultNumber);
        System.out.println("子供人数：" + childNumber);
 
        // 大人の人数が未入力の場合
        if (adultNumber == null || adultNumber.trim().isEmpty()) {
            req.setAttribute("errorMessage", "大人の人数を入力してください。");
 
            req.getRequestDispatcher(
                    "/scoremanager/main/ReferenceConfirmationDisplay.action?event_id="
                    + eventId
            ).forward(req, res);
 
            return;
        }
 
        // 参加予約情報を作成
        ExpectedParticipants bean = new ExpectedParticipants();
 
        bean.setUser_id(loginUser.getUser_id());
        bean.setEvent_id(Integer.parseInt(eventId));
        bean.setAdultnumber(Integer.parseInt(adultNumber));
        bean.setChildnumber(Integer.parseInt(childNumber));
 
        // DB処理
        ExpectedParticipantsDao dao = new ExpectedParticipantsDao();
 
        // すでに予約されているか確認
        if (dao.exists(bean.getUser_id(), bean.getEvent_id())) {
 
            req.setAttribute("errorMessage", "このイベントはすでに予約済みです。");
 
            req.getRequestDispatcher(
                    "/scoremanager/main/ReferenceConfirmationDisplay.action?event_id="
                    + eventId
            ).forward(req, res);
 
            return;
        }
 
        // イベント情報を取得
        EventDAO eventDao = new EventDAO();
        Event event = eventDao.select(bean.getEvent_id());
 
        // 予約済みの人数を取得
        List<ExpectedParticipants> list = dao.select(bean.getEvent_id());
 
        int totalNumber = 0;
 
        for (ExpectedParticipants participants : list) {
            totalNumber += participants.getAdultnumber();
            totalNumber += participants.getChildnumber();
        }
 
        // 今回入力した人数を追加
        int newTotalNumber =
                totalNumber + bean.getAdultnumber() + bean.getChildnumber();
 
        // 定員を超えている場合
        if (newTotalNumber > event.getCapacity()) {
 
            req.setAttribute("errorMessage", "定員を超えています。");
 
            req.getRequestDispatcher(
                    "/scoremanager/main/ReferenceConfirmationDisplay.action?event_id="
                    + eventId
            ).forward(req, res);
 
            return;
        }
 
        // 参加予約を登録
        dao.insert(bean);
 
        // 完了画面へリダイレクト
        res.sendRedirect(req.getContextPath()
                + "/scoremanager/main/ParticipationCompletedDisplay.action");
    }
}