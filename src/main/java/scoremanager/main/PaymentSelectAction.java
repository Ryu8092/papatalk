package scoremanager.main;
 
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;
 
public class PaymentSelectAction extends Action {
 
    @Override
    public void execute(HttpServletRequest req, HttpServletResponse res)
            throws Exception {
 
        String plan = req.getParameter("plan");
 
        // 開始予定日
        LocalDateTime startDate = LocalDateTime.now();
 
        // 終了予定日
        LocalDateTime endDate;
 
        switch (plan) {
            case "1":
                endDate = startDate.plusDays(1);
                break;
 
            case "2":
                endDate = startDate.plusMonths(1);
                break;
 
            case "3":
                endDate = startDate.plusMonths(3);
                break;
 
            default:
                throw new IllegalArgumentException("不正なプランです");
        }
 
        // 日付の表示形式
        DateTimeFormatter formatter =
                DateTimeFormatter.ofPattern("yyyy年M月d日 HH:mm");
 
        req.setAttribute("plan", plan);
        req.setAttribute("startDate",
                startDate.format(formatter));
        req.setAttribute("endDate",
                endDate.format(formatter));
 
        req.getRequestDispatcher(
            "/scoremanager/main/payment_select.jsp"
        ).forward(req, res);
    }
}