
package scoremanager.main;

import java.util.List;

import bean.User;
import dao.HobbyDao;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class AccountinFormationAction extends Action {

    @Override
    public void execute(HttpServletRequest req, HttpServletResponse res)
            throws Exception {

        // ログイン情報を取得
        HttpSession session = req.getSession(false);

        if (session == null) {
            res.sendRedirect(req.getContextPath() + "/Login.action");
            return;
        }

        User user = (User) session.getAttribute("user");

        if (user == null) {
            res.sendRedirect(req.getContextPath() + "/Login.action");
            return;
        }

        // データベースから登録済みの趣味を取得
        HobbyDao hobbyDao = new HobbyDao();

        List<String> selectedHobbies =
                hobbyDao.getUserHobbies(user.getUser_id());

        // JSPへ趣味を渡す
        req.setAttribute("selectedHobbies", selectedHobbies);

        // デバッグ用ログ
        System.out.println("アカウント画面のユーザーID: "
                + user.getUser_id());
        System.out.println("アカウント画面に表示する趣味: "
                + selectedHobbies);

        // アカウント情報画面へ転送
        req.getRequestDispatcher(
                "/scoremanager/main/accountinformation.jsp"
        ).forward(req, res);
    }
}
