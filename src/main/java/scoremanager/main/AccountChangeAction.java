
package scoremanager.main;

import java.util.List;

import bean.User;
import dao.HobbyDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class AccountChangeAction extends Action {

    @Override
    public void execute(HttpServletRequest req,
                        HttpServletResponse res) throws Exception {

        req.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            res.sendRedirect(req.getContextPath() + "/scoremanager/Login.action");
            return;
        }

        User user = (User) session.getAttribute("user");

        try {
            HobbyDao hobbyDao = new HobbyDao();

            // 趣味一覧を取得
            List<String> allHobbies = hobbyDao.getAllHobbies();

            // ログインユーザーが登録済みの趣味を取得
            List<String> selectedHobbies =
                    hobbyDao.getUserHobbies(user.getUser_id());

            // JSPに渡す
            req.setAttribute("allHobbies", allHobbies);
            req.setAttribute("selectedHobbies", selectedHobbies);
            req.setAttribute("user", user);

            // アカウント情報変更画面を表示
            req.getRequestDispatcher(
                    "/scoremanager/main/change_accountinformation.jsp")
                    .forward(req, res);

        } catch (Exception e) {
            e.printStackTrace();

            throw new ServletException(
                    "アカウント情報画面の表示に失敗しました。", e);
        }
    }
}
