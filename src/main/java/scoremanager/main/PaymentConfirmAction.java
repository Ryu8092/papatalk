package scoremanager.main;
 
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;
 
public class PaymentConfirmAction extends Action {
 
    @Override
    public void execute(HttpServletRequest req, HttpServletResponse res)
            throws Exception {
 
        // 入力内容を取得
        String cardNumber = req.getParameter("card_number");
        String cardName = req.getParameter("card_name");
        String month = req.getParameter("month");
        String year = req.getParameter("year");
        String securityCode = req.getParameter("security_code");
        String plan = req.getParameter("plan");
 
        // 未入力チェック
        boolean hasError = false;
 
        if (cardNumber == null || cardNumber.trim().isEmpty()) {
            req.setAttribute("cardNumberError", true);
            hasError = true;
        }
 
        if (cardName == null || cardName.trim().isEmpty()) {
            req.setAttribute("cardNameError", true);
            hasError = true;
        }
 
        if (month == null || month.isEmpty()
                || year == null || year.isEmpty()) {
            req.setAttribute("expirationError", true);
            hasError = true;
        }
 
        if (securityCode == null || securityCode.trim().isEmpty()) {
            req.setAttribute("securityError", true);
            hasError = true;
        }
 
        // 入力エラーがある場合
        if (hasError) {
 
            req.setAttribute("plan", plan);
 
            req.getRequestDispatcher(
                "/scoremanager/main/card_input.jsp"
            ).forward(req, res);
 
            return;
        }
 
        // 入力内容を次の画面に渡す
        req.setAttribute("card_number", cardNumber);
        req.setAttribute("card_name", cardName);
        req.setAttribute("month", month);
        req.setAttribute("year", year);
        req.setAttribute("plan", plan);
 
        // 入力に問題がなければ確認画面へ
        req.getRequestDispatcher(
            "/scoremanager/main/payment_confirm.jsp"
        ).forward(req, res);
    }
}