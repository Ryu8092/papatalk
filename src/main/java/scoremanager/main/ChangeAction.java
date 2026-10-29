package scoremanager.main;

import java.io.IOException;
import java.util.List;

import bean.User;
import dao.HobbyDao;
import dao.UserDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class ChangeAction extends Action {

    @Override
    public void execute(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession(false);

        User user = null;

        if (session != null) {
            user = (User) session.getAttribute("user");
        }

        if (user == null) {
            res.sendRedirect("/scoremanager/Login.action");
            return;
        }

        // フォームからアカウント情報を取得
        String userName = req.getParameter("user_name");
        String userAgeStr = req.getParameter("user_age");
        String nickname = req.getParameter("nickname");
        String password = req.getParameter("password");
        String email = req.getParameter("email");
        String tel = req.getParameter("tel");
        String postalCode = req.getParameter("postal_code");
        String prefecture = req.getParameter("prefecture");
        String city = req.getParameter("city");
        String address1 = req.getParameter("address1");
        String address2 = req.getParameter("address2");
        String childAgeStr = req.getParameter("child_age");
        String childGender = req.getParameter("child_gender");

        // チェックされた趣味を取得
        String[] hobbies = req.getParameterValues("hobbies");

        // 必須項目のチェック
        if (userName == null || userName.isBlank()
                || nickname == null || nickname.isBlank()
                || email == null || email.isBlank()) {

            showError(req, user, hobbies,
                    "名前、ニックネーム、メールアドレスを入力してください。");
            forwardToChangePage(req, res);
            return;
        }

        try {
            int userAge = 0;

            if (userAgeStr != null && !userAgeStr.isBlank()) {
                userAge = Integer.parseInt(userAgeStr);
            }

            int childAge = 0;

            if (childAgeStr != null && !childAgeStr.isBlank()) {
                childAge = Integer.parseInt(childAgeStr);
            }

            if (userAge < 0 || userAge > 120
                    || childAge < 0 || childAge > 120) {

                showError(req, user, hobbies,
                        "年齢は0以上120以下で入力してください。");
                forwardToChangePage(req, res);
                return;
            }

            // 入力値をユーザー情報に設定
            user.setUser_name(userName);
            user.setUser_age(userAge);
            user.setNickname(nickname);

            // パスワードは入力された場合のみ変更
            if (password != null && !password.isBlank()) {
                user.setPassword(password);
            }

            user.setEmail(email);
            user.setTel(tel);
            user.setPostal_code(postalCode);
            user.setPrefecture(prefecture);
            user.setCity(city);
            user.setAddress1(address1);
            user.setAddress2(address2);
            user.setChild_age(childAge);
            user.setChild_gender(childGender);

            // ユーザー情報をDBに保存
            UserDao userDao = new UserDao();
            int result = userDao.update(user);

            System.out.println("===== アカウント更新確認 =====");
            System.out.println("ユーザーID: " + user.getUser_id());
            System.out.println("更新結果: " + result);
            System.out.println("==============================");

            if (result <= 0) {
                showError(req, user, hobbies,
                        "アカウント情報を更新できませんでした。（更新件数: "
                                + result + "）");
                forwardToChangePage(req, res);
                return;
            }

            // 趣味をDBに保存
            HobbyDao hobbyDao = new HobbyDao();

            System.out.println("===== 趣味保存確認 =====");
            System.out.println("ユーザーID: " + user.getUser_id());

            if (hobbies == null || hobbies.length == 0) {
                System.out.println("選択された趣味はありません。");
            } else {
                for (String hobby : hobbies) {
                    System.out.println("選択された趣味: " + hobby);
                }
            }

            int savedCount =
                    hobbyDao.saveUserHobbies(user.getUser_id(), hobbies);

            System.out.println("趣味保存処理の戻り値: " + savedCount);
            System.out.println("========================");

            // 更新したユーザー情報をセッションに反映
            session.setAttribute("user", user);
            System.out.println("変更処理完了：完了画面へ遷移します");
            // 完了画面へ
            res.sendRedirect(
            	    req.getContextPath()
            	        + "/scoremanager/main/CompletionScreen.action"
            	);
            	return;
            
            
        } catch (NumberFormatException e) {

            showError(req, user, hobbies,
                    "年齢は数字で入力してください。");
            forwardToChangePage(req, res);

        } catch (Exception e) {

            e.printStackTrace();

            // ユーザー情報または趣味の保存に失敗
            throw new ServletException(
                    "アカウント情報または趣味の保存に失敗しました。", e);
        }
    }

    // エラー表示用の情報を設定
    private void showError(HttpServletRequest req,
                           User user,
                           String[] hobbies,
                           String message)
            throws ServletException {

        req.setAttribute("error", message);
        req.setAttribute("user", user);

        try {
            HobbyDao hobbyDao = new HobbyDao();

            List<String> allHobbies = hobbyDao.getAllHobbies();

            req.setAttribute("allHobbies", allHobbies);

            if (hobbies != null) {
                req.setAttribute(
                        "selectedHobbies",
                        java.util.Arrays.asList(hobbies));
            } else {
                req.setAttribute(
                        "selectedHobbies",
                        hobbyDao.getUserHobbies(user.getUser_id()));
            }

        } catch (Exception e) {
            e.printStackTrace();

            throw new ServletException(
                    "趣味一覧の取得に失敗しました。", e);
        }
    }

    // アカウント情報変更画面へ戻る
    private void forwardToChangePage(HttpServletRequest req,
                                     HttpServletResponse res)
            throws ServletException, IOException {

        req.getRequestDispatcher(
                "/scoremanager/main/change_accountinformation.jsp")
                .forward(req, res);
    }
}