package scoremanager.main;
 
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;
 
public class ParticipationCompletedDisplayAction extends Action {
 
    @Override
    public void execute(HttpServletRequest req, HttpServletResponse res)
            throws Exception {
 
        req.getRequestDispatcher(
                "/scoremanager/main/participation_completed.jsp"
        ).forward(req, res);
    }
}