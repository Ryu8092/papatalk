

package scoremanager.main;
 
import java.util.List;

import bean.User;
import dao.MatchingFavoriteDAO;
import dao.UserDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;
 
public class MatchListAction extends Action {
 
    @Override

    public void execute(HttpServletRequest req, HttpServletResponse res)

            throws Exception {
 
        // 文字コードを設定

        req.setCharacterEncoding("UTF-8");
 
        // セッションを取得

        HttpSession session = req.getSession(false);
 
        // ログイン確認

        if (session == null || session.getAttribute("user") == null) {

            res.sendRedirect(

                req.getContextPath() + "/scoremanager/Login.action"

            );

            return;

        }
 
        // ログインユーザーを取得

        User user = (User) session.getAttribute("user");
 
        // ログインユーザーのID

        int loginUserId = user.getUser_id();
 
        try {
 
            // 同じ都道府県のユーザーを取得

            UserDao dao = new UserDao();
 
            List<User> userList =

                dao.selectByPrefecture(user.getPrefecture(), loginUserId);
 
            // イイネ済みのユーザーを取得

            MatchingFavoriteDAO favoriteDao = new MatchingFavoriteDAO();
 
            List<User> favoriteList =

                favoriteDao.select(loginUserId);
 
            // イイネ済みのユーザーを一覧から除外

            userList.removeIf(matchUser ->

                favoriteList.stream().anyMatch(favorite ->

                    favorite.getUser_id() == matchUser.getUser_id()

                )

            );
 
            // JSPにユーザー一覧を渡す

            req.setAttribute("userList", userList);
 
            // ログインユーザーの情報を渡す

            req.setAttribute("user", user);
 
            // マッチング一覧画面へ移動

            req.getRequestDispatcher(

                "/scoremanager/main/match_list.jsp"

            ).forward(req, res);
 
        } catch (Exception e) {
 
            e.printStackTrace();
 
            throw new ServletException(

                "マッチング一覧の表示に失敗しました。", e

            );

        }

    }

}

 