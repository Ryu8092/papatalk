
package scoremanager;

import java.util.List;

import org.mindrot.jbcrypt.BCrypt;

import bean.User;
import dao.SubscriptionDAO;
import dao.UserDao;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class LoginSelectionAction extends Action {

    UserDao dao = new UserDao();
    SubscriptionDAO subscriptionDao = new SubscriptionDAO();

    public void execute(HttpServletRequest req, HttpServletResponse res)
            throws Exception {

        String password = req.getParameter("password");
        String user_name = req.getParameter("user_name");
        
        List<User> userlist = dao.selectByUserName(user_name);
        
        User login_user = null;
        
        for (User user : userlist) {
        	if (BCrypt.checkpw(password, user.getPassword())) {
        		login_user = user;
        		break;
        		
        	}
        }
        

//        User user = dao.select(password, user_name);

        if (login_user == null) {

            req.setAttribute("error", "ユーザー名またはパスワードが確認できませんでした。");
            req.setAttribute("user_name", user_name);

            req.getRequestDispatcher("/scoremanager/login.jsp").forward(req, res);

        } else {

            int user_id = login_user.getUser_id();

            // ログインしたユーザーと同じ都道府県のユーザーを取得
            List<User> userList =
                    dao.selectByPrefecture(login_user.getPrefecture(), user_id);

            // JSPにユーザー一覧を渡す
            req.setAttribute("userList", userList);

            HttpSession session = req.getSession();

            // ユーザー情報をセッションに格納
            session.setAttribute("user", login_user);

            // サブスク加入状態を取得
            boolean subscription = subscriptionDao.select(user_id);

            // サブスク状態をセッションに格納
            session.setAttribute("subscription", subscription);

            if (login_user.getUser_status() == 0) {

                // 一般ユーザー
                req.getRequestDispatcher("/scoremanager/main/match_list.jsp")
                        .forward(req, res);

            } else if (login_user.getUser_status() == 9) {

                // 管理者
                req.getRequestDispatcher("/scoremanager/main/ManagementScreen.action")
                        .forward(req, res);
            }
        }
    }
}
