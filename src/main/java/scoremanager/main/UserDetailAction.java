package scoremanager.main;

import bean.User;
import dao.UserDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class UserDetailAction extends Action {

    @Override
    public void execute(HttpServletRequest req,
                        HttpServletResponse res) throws Exception {


        try {
            // replay.jspから対象ユーザーのIDを取得
            int user_id = Integer.parseInt(req.getParameter("user_id"));
            
            

            // UserDaoを使ってユーザー情報を取得
            UserDao userDao = new UserDao();

            User user = userDao.selectUser(user_id);

            // ユーザー情報をJSPに渡す
            req.setAttribute("target_user", user);
            
            // 元の投稿ID
            req.setAttribute("post_id", req.getParameter("post_id"));

            // ユーザー詳細画面を表示
            req.getRequestDispatcher(
                    "/scoremanager/main/boarduserdetail.jsp")
                    .forward(req, res);

        } catch (Exception e) {
            e.printStackTrace();

            throw new ServletException(
                    "ユーザー詳細画面の表示に失敗しました。", e);
        }
    }
}