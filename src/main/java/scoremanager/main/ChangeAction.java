
package scoremanager.main;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;
import java.util.UUID;

import javax.imageio.ImageIO;

import bean.User;
import dao.HobbyDao;
import dao.UserDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import tool.Action;

public class ChangeAction extends Action {

    private static final String UPLOAD_DIRECTORY =
            "C:\\work\\pleiades\\2023-12\\workspace\\papatalk\\src\\main\\webapp\\uploads";

    private static final long MAX_FILE_SIZE = 5 * 1024 * 1024;

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
            res.sendRedirect(
                    req.getContextPath() + "/scoremanager/Login.action");
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

        // 文字数チェック
        if (userName.length() > 30) {
            showError(req, user, hobbies,
                    "ユーザー名は30文字以内で入力してください。");
            forwardToChangePage(req, res);
            return;
        }

        if (userAgeStr != null && userAgeStr.length() > 3) {
            showError(req, user, hobbies,
                    "年齢は3桁以内で入力してください。");
            forwardToChangePage(req, res);
            return;
        }

        if (nickname.length() > 30) {
            showError(req, user, hobbies,
                    "ニックネームは30文字以内で入力してください。");
            forwardToChangePage(req, res);
            return;
        }

        if (password != null && !password.isBlank()
                && password.length() > 20) {
            showError(req, user, hobbies,
                    "パスワードは20文字以内で入力してください。");
            forwardToChangePage(req, res);
            return;
        }

        if (email.length() > 100) {
            showError(req, user, hobbies,
                    "メールアドレスは100文字以内で入力してください。");
            forwardToChangePage(req, res);
            return;
        }

        if (tel != null && tel.length() > 11) {
            showError(req, user, hobbies,
                    "電話番号は11文字以内で入力してください。");
            forwardToChangePage(req, res);
            return;
        }

        if (postalCode != null && postalCode.length() > 8) {
            showError(req, user, hobbies,
                    "郵便番号は8文字以内で入力してください。");
            forwardToChangePage(req, res);
            return;
        }

        if (city != null && city.length() > 50) {
            showError(req, user, hobbies,
                    "市区町村は50文字以内で入力してください。");
            forwardToChangePage(req, res);
            return;
        }

        if (address1 != null && address1.length() > 100) {
            showError(req, user, hobbies,
                    "番地は100文字以内で入力してください。");
            forwardToChangePage(req, res);
            return;
        }

        if (address2 != null && address2.length() > 100) {
            showError(req, user, hobbies,
                    "建物名・部屋番号は100文字以内で入力してください。");
            forwardToChangePage(req, res);
            return;
        }

        try {

            int userAge = 0;
            int childAge = 0;

            StringBuilder ageErrors = new StringBuilder();

            // 自分の年齢チェック
            if (userAgeStr == null || userAgeStr.isBlank()) {
                ageErrors.append("年齢を入力してください。");
            } else {
                try {
                    userAge = Integer.parseInt(userAgeStr);

                    if (userAge < 18 || userAge > 100) {
                        ageErrors.append(
                                "年齢は18～100の範囲で入力してください。");
                    }
                } catch (NumberFormatException e) {
                    ageErrors.append("年齢は数字で入力してください。");
                }
            }

            // お子さんの年齢チェック
            if (childAgeStr == null || childAgeStr.isBlank()) {

                if (ageErrors.length() > 0) {
                    ageErrors.append("\n");
                }

                ageErrors.append("お子さんの年齢を入力してください。");

            } else {
                try {
                    childAge = Integer.parseInt(childAgeStr);

                    if (childAge < 0 || childAge >= 18) {
                        if (ageErrors.length() > 0) {
                            ageErrors.append("\n");
                        }

                        ageErrors.append(
                                "お子さんの年齢は0～17歳で入力してください。");
                    }

                } catch (NumberFormatException e) {
                    if (ageErrors.length() > 0) {
                        ageErrors.append("\n");
                    }

                    ageErrors.append(
                            "お子さんの年齢は数字で入力してください。");
                }
            }

            if (ageErrors.length() > 0) {
                showError(req, user, hobbies, ageErrors.toString());
                forwardToChangePage(req, res);
                return;
            }

            // プロフィール画像の取得
            Part avatarPart = req.getPart("avatar");

            if (avatarPart != null && avatarPart.getSize() > 0) {

                // ファイルサイズチェック
                if (avatarPart.getSize() > MAX_FILE_SIZE) {
                    showError(req, user, hobbies,
                            "画像サイズは5MB以内にしてください。");
                    forwardToChangePage(req, res);
                    return;
                }

                // MIMEタイプチェック
                String contentType = avatarPart.getContentType();

                String extension;

                if ("image/jpeg".equals(contentType)) {
                    extension = ".jpg";
                } else if ("image/png".equals(contentType)) {
                    extension = ".png";
                } else if ("image/gif".equals(contentType)) {
                    extension = ".gif";
                } else {
                    showError(req, user, hobbies,
                            "JPEG・PNG・GIF形式の画像を選択してください。");
                    forwardToChangePage(req, res);
                    return;
                }

                // 実際に画像データかどうか確認
                try (InputStream input = avatarPart.getInputStream()) {
                    if (ImageIO.read(input) == null) {
                        showError(req, user, hobbies,
                                "正しい画像ファイルを選択してください。");
                        forwardToChangePage(req, res);
                        return;
                    }
                }

                // 保存先フォルダを作成
                Path uploadPath = Path.of(UPLOAD_DIRECTORY);
                Files.createDirectories(uploadPath);

                // UUIDでファイル名を生成
                String fileName = UUID.randomUUID().toString() + extension;

                Path filePath = uploadPath.resolve(fileName);

                // 画像を保存
                try (InputStream input = avatarPart.getInputStream()) {
                    Files.copy(input, filePath);
                }

                // DBに保存する画像URL
                user.setAvatar_url("/uploads/" + fileName);
            }

            // 入力値をユーザー情報に設定
            user.setUser_name(userName);
            user.setUser_age(userAge);
            user.setNickname(nickname);

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
            System.out.println("画像URL: " + user.getAvatar_url());
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

            res.sendRedirect(
                    req.getContextPath()
                            + "/scoremanager/main/CompletionScreen.action"
            );

        } catch (Exception e) {
            e.printStackTrace();

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
