//アカウント登録
package scoremanager.main;

import bean.User;
import dao.UserDao;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class RegistrationAction extends Action {

    @Override
    public void execute(HttpServletRequest request,
                        HttpServletResponse response) throws Exception {

        request.setCharacterEncoding("UTF-8");
        // 入力値を取得
        String username = request.getParameter("username");
        String ageText = request.getParameter("age");
        String nickname = request.getParameter("nickname");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String tel = request.getParameter("phone");
        String postal_code = request.getParameter("zipcode");
        String prefecture = request.getParameter("prefecture");
        String city = request.getParameter("city");
        String address1 = request.getParameter("address");
        String address2 = request.getParameter("building");
        String childAgeText = request.getParameter("child_age");
        String child_gender = request.getParameter("child_gender");

        // 必須項目のチェック
        checkRequired(request, "usernameError", username);
        checkRequired(request, "emailError", email);
        checkRequired(request, "passwordError", password);
        checkRequired(request, "ageError", ageText);
        checkRequired(request, "phoneError", tel);
        checkRequired(request, "zipcodeError", postal_code);
        checkRequired(request, "prefectureError", prefecture);
        checkRequired(request, "cityError", city);
        checkRequired(request, "addressError", address1);
        checkRequired(request, "childAgeError", childAgeText);
        checkRequired(request, "childGenderError", child_gender);
        // 年齢のチェック
        Integer age = null;

        if (isNotBlank(ageText)) {
            try {
                age = Integer.parseInt(ageText);

                if (age < 0 || age > 150) {
                    request.setAttribute(
                        "ageError", "※年齢は0～150の範囲で入力してください");
                }
            } catch (NumberFormatException e) {
                request.setAttribute(
                    "ageError", "※年齢は数字で入力してください");
            }
        }

        // お子さんの年齢のチェック
        Integer child_age = null;

        if (isNotBlank(childAgeText)) {
            try {
                child_age = Integer.parseInt(childAgeText);

                if (child_age < 0 || child_age > 150) {
                    request.setAttribute(
                        "childAgeError",
                        "※お子さんの年齢は0～150の範囲で入力してください");
                }
            } catch (NumberFormatException e) {
                request.setAttribute(
                    "childAgeError",
                    "※お子さんの年齢は数字で入力してください");
            }
        }

        // エラーがあれば入力画面に戻る
        String[] errorKeys = {
            "usernameError",
            "emailError",
            "passwordError",
            "ageError",
            "phoneError",
            "zipcodeError",
            "prefectureError",
            "cityError",
            "addressError",
            "childAgeError",
            "childGenderError"
        };

        for (String key : errorKeys) {
            if (request.getAttribute(key) != null) {
                request.getRequestDispatcher(
                    "/scoremanager/main/enter_information.jsp"
                ).forward(request, response);
                return;
            }
        }

        // エラーがなければ登録
        try {
            User user = new User();

            user.setUser_name(username);
            user.setUser_age(age);
            user.setNickname(nickname);
            user.setPassword(password);
            user.setEmail(email);
            user.setTel(tel);
            user.setPostal_code(postal_code);
            user.setPrefecture(prefecture);
            user.setCity(city);
            user.setAddress1(address1);
            user.setAddress2(address2);
            user.setChild_age(child_age);
            user.setChild_gender(child_gender);

            UserDao dao = new UserDao();
            dao.insert(user);

            // 登録成功後、完了画面のActionへ移動
            response.sendRedirect(
                request.getContextPath()
                + "/scoremanager/main/CompleteDisplay.action"
            );

        } catch (Exception e) {
            e.printStackTrace();

            request.setAttribute(
                "message", "登録処理中にエラーが発生しました。");

            request.getRequestDispatcher(
                "/scoremanager/main/enter_information.jsp"
            ).forward(request, response);
        }
    }

    // 必須項目のチェック
    private void checkRequired(
            HttpServletRequest request,
            String errorKey,
            String value) {

        if (value == null || value.trim().isEmpty()) {
            request.setAttribute(errorKey, "※入力は必須です");
        }
    }

    // null・空文字の確認
    private boolean isNotBlank(String value) {
        return value != null && !value.trim().isEmpty();
    }
}
