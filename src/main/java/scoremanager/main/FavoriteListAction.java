package scoremanager.main;
 
import java.util.List;

import bean.User;
import dao.MatchingFavoriteDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;
 
public class FavoriteListAction extends Action {
 
    @Override
    public void execute(HttpServletRequest req, HttpServletResponse res)
            throws Exception {
 
        // ログイン中のユーザーを取得
        HttpSession session = req.getSession(false);
 
        if (session == null || session.getAttribute("user") == null) {
            res.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }
 
        User loginUser = (User) session.getAttribute("user");
        int loginUserId = loginUser.getUser_id();
        
        MatchingFavoriteDAO dao = new MatchingFavoriteDAO();
       
        List<User> favoriteList = dao.select(loginUserId);
 
        // JSPに一覧を渡す
        req.setAttribute("favoriteList", favoriteList);
 
        req.getRequestDispatcher(
            "/scoremanager/main/favorite_list.jsp"
        ).forward(req, res);
    }
}