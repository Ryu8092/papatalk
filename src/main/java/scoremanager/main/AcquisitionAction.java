package scoremanager.main;
 
import java.util.List;

import bean.User;
import dao.UserDao;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;
 
public class AcquisitionAction extends Action {
 
    private UserDao dao = new UserDao();
 
    @Override
    public void execute(HttpServletRequest req, HttpServletResponse res)
            throws Exception {
 
        // BANされたユーザーを取得
        List<User> userList = dao.select(8);
 
        // JSPにユーザー一覧を渡す
        req.setAttribute("userList", userList);
 
        // BANされたユーザーがいない場合
        if (userList.isEmpty()) {
            req.setAttribute("message", "BANした人はいません");
        }
 
        // BAN履歴画面を表示
        req.getRequestDispatcher(
                "/scoremanager/main/ban_history_screen.jsp")
                .forward(req, res);
    }
}