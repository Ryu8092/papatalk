package scoremanager.main;
 
import java.util.List;

import dao.UserDao;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;
 
public class GenruAction extends Action {
 
    @Override
    public void execute(HttpServletRequest req, HttpServletResponse res)
            throws Exception {
 
        UserDao dao = new UserDao();
 
        // データベースから趣味一覧を取得
        List<String> hobbyList = dao.selectHobbies();
 
        // JSPに趣味一覧を渡す
        req.setAttribute("hobbyList", hobbyList);
 
        req.getRequestDispatcher("/scoremanager/main/genru.jsp")
           .forward(req, res);
    }
}