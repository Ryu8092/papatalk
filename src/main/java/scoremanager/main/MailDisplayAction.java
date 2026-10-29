package scoremanager.main;
 


import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;
 
@WebServlet("/MailDisplayAction")
public class MailDisplayAction extends Action {
 
    @Override
    public void execute(HttpServletRequest req, HttpServletResponse res) 
    		throws Exception {
 
    		
        req.getRequestDispatcher("email_address.jsp").forward(req, res);
    }
}