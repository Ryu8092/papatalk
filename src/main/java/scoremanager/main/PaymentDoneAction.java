package scoremanager.main;
 
import bean.User;
import dao.SubscriptionDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;
 
public class PaymentDoneAction extends Action {
 
    @Override
    public void execute(HttpServletRequest req, HttpServletResponse res)
            throws Exception {
 
        // ログインユーザーを取得
        HttpSession session = req.getSession(false);
 
        if (session == null || session.getAttribute("user") == null) {
            res.sendRedirect(req.getContextPath() + "/scoremanager/login.jsp");
            return;
        }
 
        User user = (User) session.getAttribute("user");
 
        // ユーザーIDを取得
        int user_id = user.getUser_id();
 
        // 選択したプランを取得
        String Splan = req.getParameter("plan");
        int plan = Integer.parseInt(Splan);
 
//        int plan;
//
//        // プランを数値に変換
//        switch (selectedPlan) {
//
//            case "1day":
//                plan = 1;
//                break;
//
//            case "1month":
//                plan = 2;
//                break;
//
//            case "3months":
//                plan = 3;
//                break;
//
//            default:
//                throw new IllegalArgumentException("不正なプランです");
//        }
 
        // サブスク登録
        SubscriptionDAO dao = new SubscriptionDAO();
 
        // すでに契約中か確認
        if (dao.select(user_id)) {
            res.sendRedirect(
                req.getContextPath()
                + "/scoremanager/main/PaymentComplate.action"
            );
            return;
        }
 
        // 契約情報を登録
        int result = dao.insert(user_id, plan);
 
        // 登録成功
        if (result > 0) {
            res.sendRedirect(
                req.getContextPath()
                + "/scoremanager/main/PaymentComplate.action"
            );
        }
    }
}