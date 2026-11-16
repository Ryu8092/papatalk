//アカウント登録
package scoremanager.main;

import java.io.File;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.mindrot.jbcrypt.BCrypt;

import bean.User;
import dao.UserDao;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
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
     // プロフィール画像を取得
        Part avatarPart = request.getPart("avatar");

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
        String avatarUrl = null;
        Path savedImagePath = null;

        try {
            // 画像を取得
            if (avatarPart == null || avatarPart.getSize() == 0) {
                request.setAttribute("message", "プロフィール画像を選択してください。");
                request.getRequestDispatcher(
                    "/scoremanager/main/enter_information.jsp"
                ).forward(request, response);
                return;
            }

            // ファイルサイズのチェック（5MBまで）
            if (avatarPart.getSize() > 5 * 1024 * 1024) {
                request.setAttribute("message", "画像は5MB以内にしてください。");
                request.getRequestDispatcher(
                    "/scoremanager/main/enter_information.jsp"
                ).forward(request, response);
                return;
            }

            // 画像形式のチェック
            String contentType = avatarPart.getContentType();
            String extension;

            if ("image/jpeg".equals(contentType)) {
                extension = ".jpg";
            } else if ("image/png".equals(contentType)) {
                extension = ".png";
            } else if ("image/gif".equals(contentType)) {
                extension = ".gif";
            } else {
                request.setAttribute("message", "JPEG・PNG・GIF形式の画像を選択してください。");
                request.getRequestDispatcher(
                    "/scoremanager/main/enter_information.jsp"
                ).forward(request, response);
                return;
            }

            // 実際に画像として読み込めるか確認
            try (InputStream input = avatarPart.getInputStream()) {
                if (ImageIO.read(input) == null) {
                    request.setAttribute("message", "正しい画像ファイルを選択してください。");
                    request.getRequestDispatcher(
                        "/scoremanager/main/enter_information.jsp"
                    ).forward(request, response);
                    return;
                }
            }

         // 画像の保存先を指定
            String uploadDirectory =
                "C:\\work\\pleiades\\2023-12\\workspace\\papatalk\\src\\main\\webapp\\uploads";


            File uploadFolder = new File(uploadDirectory);

            if (!uploadFolder.exists()) {
                uploadFolder.mkdirs();
            }

         // uploadsフォルダを作成
            Path uploadPath = Path.of(uploadDirectory);
            Files.createDirectories(uploadPath);

            // 保存するファイル名
            String fileName = UUID.randomUUID().toString() + extension;

            // 保存先
            savedImagePath = uploadPath.resolve(fileName);

            // 画像を保存
            try (InputStream input = avatarPart.getInputStream()) {
                Files.copy(input, savedImagePath);
            }

            avatarUrl = "/uploads/" + fileName;

            System.out.println("画像保存完了：" + savedImagePath);
            System.out.println("ファイル存在確認：" + Files.exists(savedImagePath));
            savedImagePath = new File(uploadFolder, fileName).toPath();

            // 画像を保存
            avatarPart.write(savedImagePath.toString());

            // DBに保存する画像パス
            avatarUrl = "/uploads/" + fileName;

            // Userオブジェクトを作成
            User user = new User();

            user.setUser_name(username);
            user.setUser_age(age);
            user.setNickname(nickname);
            user.setEmail(email);
            user.setTel(tel);
            user.setPostal_code(postal_code);
            user.setPrefecture(prefecture);
            user.setCity(city);
            user.setAddress1(address1);
            user.setAddress2(address2);
            user.setChild_age(child_age);
            user.setChild_gender(child_gender);
            user.setAvatar_url(avatarUrl);

            // パスワードをBCryptでハッシュ化
            String hashedPassword = BCrypt.hashpw(
                password,
                BCrypt.gensalt(12)
            );

            user.setPassword(hashedPassword);

            UserDao dao = new UserDao();
            dao.insert(user);

            // 登録成功後、完了画面へ
            response.sendRedirect(
                request.getContextPath()
                + "/scoremanager/main/CompleteDisplay.action"
            );

        } catch (Exception e) {
            e.printStackTrace();

            // DB登録などに失敗した場合、保存済み画像を削除
            if (savedImagePath != null) {
                Files.deleteIfExists(savedImagePath);
            }

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
