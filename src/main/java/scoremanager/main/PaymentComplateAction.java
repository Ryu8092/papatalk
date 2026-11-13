package scoremanager.main;
 
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;
 
public class PaymentComplateAction extends Action {
 
    @Override
    public void execute(HttpServletRequest req, HttpServletResponse res)
            throws Exception {
 
        req.getRequestDispatcher(
            "/scoremanager/main/payment_done.jsp"
        ).forward(req, res);
    }
}