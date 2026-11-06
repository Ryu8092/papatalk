
package scoremanager.main;

import java.util.List;

import bean.MatchingFavorite;
import bean.User;
import dao.MatchingFavoriteDAO;
import dao.UserDao;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class FavoriteAddAction extends Action {

    @Override
    public void execute(
            HttpServletRequest request,
            HttpServletResponse response) throws Exception {

        // セッションからログインユーザーを取得
        HttpSession session = request.getSession(false);

        User loginUser = null;

        if (session != null) {
            loginUser = (User) session.getAttribute("user");
        }

        // ログインしていない場合
        if (loginUser == null) {
            response.sendRedirect(
                request.getContextPath() + "/login.jsp"
            );
            return;
        }

        int actionUserId = loginUser.getUser_id();

        // 相手のユーザーIDを取得
        String targetUserIdStr =
            request.getParameter("target_user_id");

        int targetUserId;

        try {
            targetUserId = Integer.parseInt(targetUserIdStr);
        } catch (NumberFormatException e) {
            request.setAttribute("insertCount", 0);
            request.setAttribute(
                "errorMessage", "ユーザーIDが正しくありません。"
            );
            forwardToList(request, response);
            return;
        }

        // 自分自身へのイイネを禁止
        if (actionUserId == targetUserId) {
            request.setAttribute("insertCount", 0);
            request.setAttribute(
                "errorMessage", "自分自身にはイイネできません。"
            );
            forwardToList(request, response);
            return;
        }

        // Beanを作成
        MatchingFavorite bean = new MatchingFavorite();
        bean.setAction_user_id(actionUserId);
        bean.setTarget_user_id(targetUserId);

        // DAOで登録
        MatchingFavoriteDAO dao = new MatchingFavoriteDAO();
        int count = dao.insert(bean);
        
        UserDao udao = new UserDao();
 
        // ログインしたユーザーID
        int loginUserId = loginUser.getUser_id();
 
        // ログインしたユーザーと同じ都道府県のユーザーを取得
        List<User> userList =
                udao.selectByPrefecture(loginUser.getPrefecture(),loginUserId);
 
        // JSPにユーザー一覧を渡す
        request.setAttribute("userList", userList);
        if (count == 1) {
            // 登録結果をJSPに渡す
        	request.setAttribute("insertCount", count);
        }
        	
        

        // 一覧画面に戻す
        forwardToList(request, response);
    }

    private void forwardToList(
            HttpServletRequest request,
            HttpServletResponse response) throws Exception {

        RequestDispatcher dispatcher =
            request.getRequestDispatcher(
                "/scoremanager/main/match_list.jsp"
            );

        dispatcher.forward(request, response);
    }
}