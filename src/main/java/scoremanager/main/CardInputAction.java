package scoremanager.main;
 
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;
 
public class CardInputAction extends Action {
 
    @Override
    public void execute(HttpServletRequest req, HttpServletResponse res)
            throws Exception {
 
        String plan = req.getParameter("plan");
 
        req.setAttribute("plan", plan);
 
        req.getRequestDispatcher("/scoremanager/main/card_input.jsp")
            .forward(req, res);
    }
}