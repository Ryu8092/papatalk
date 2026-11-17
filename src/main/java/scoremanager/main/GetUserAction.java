
package scoremanager.main;

import java.util.List;

import bean.User;
import dao.UserDao;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class GetUserAction extends Action {

    @Override
    public void execute(HttpServletRequest req,
                        HttpServletResponse res) throws Exception {

        System.out.println("GetUserAction実行");

        // ログイン状態を確認
        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            res.sendRedirect(
                req.getContextPath() + "/scoremanager/login.jsp"
            );
            return;
        }

        // ログインユーザーを取得
        User loginUser = (User) session.getAttribute("user");

        // JSPから検索条件を取得
        // nullの場合は空文字にする
        String childAge = req.getParameter("child_age");
        String fatherAge = req.getParameter("father_age");
        String region = req.getParameter("region");
        String destination = req.getParameter("destination");
        String hobbies = req.getParameter("hobbies");

        if (childAge == null) {
            childAge = "";
        }

        if (fatherAge == null) {
            fatherAge = "";
        }

        if (region == null) {
            region = "";
        }

        if (destination == null) {
            destination = "";
        }

        if (hobbies == null) {
            hobbies = "";
        }

        // DAOを生成
        UserDao dao = new UserDao();

        // すべての検索条件をまとめて検索
        List<User> userList = dao.select(
            childAge,
            fatherAge,
            region,
            destination,
            hobbies,
            loginUser.getUser_id()
        );

        // 検索結果をJSPに渡す
        req.setAttribute("userList", userList);

        // 検索条件もJSPに渡す
        req.setAttribute("childAge", childAge);
        req.setAttribute("fatherAge", fatherAge);
        req.setAttribute("region", region);
        req.setAttribute("destination", destination);
        req.setAttribute("hobbies", hobbies);

        // 検索結果画面へ遷移
        req.getRequestDispatcher(
            "/scoremanager/main/match_list.jsp"
        ).forward(req, res);
    }
}
