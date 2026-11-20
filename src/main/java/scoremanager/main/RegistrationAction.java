package scoremanager.main;
 
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
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
 
// アカウント登録
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
 
        // 必須チェック・文字数チェック
        checkRequiredAndLength(request, "usernameError",
                username, 30, "名前");
 
        checkRequiredAndLength(request, "emailError",
                email, 255, "メールアドレス");
 
        checkRequiredAndLength(request, "passwordError",
                password, 0, "パスワード");
 
        checkRequiredAndLength(request, "phoneError",
                tel, 11, "電話番号");
 
        checkRequiredAndLength(request, "zipcodeError",
                postal_code, 8, "郵便番号");
 
        checkRequiredAndLength(request, "prefectureError",
                prefecture, 10, "都道府県");
 
        checkRequiredAndLength(request, "cityError",
                city, 50, "市区町村");
 
        checkRequiredAndLength(request, "addressError",
                address1, 100, "番地");
 
        checkRequiredAndLength(request, "childGenderError",
                child_gender, 2, "お子さんの性別");
 
        // 任意項目の文字数チェック
        checkLength(request, "nicknameError",
                nickname, 30, "ニックネーム");
 
        checkLength(request, "buildingError",
                address2, 100, "建物名");
 
        // BCryptの入力上限チェック（72バイト）
        if (password != null
                && password.getBytes(StandardCharsets.UTF_8).length > 72) {
 
            request.setAttribute(
                "passwordError",
                "※パスワードは72バイト以内で入力してください"
            );
        }
 
        // 年齢のチェック
        Integer age = null;
 
        if (ageText == null || ageText.trim().isEmpty()) {
 
            request.setAttribute(
                "ageError",
                "※入力は必須です"
            );
 
        } else {
 
            try {
                age = Integer.parseInt(ageText);
 
                if (age < 0 || age > 150) {
                    request.setAttribute(
                        "ageError",
                        "※年齢は0～150の範囲で入力してください"
                    );
                }
 
            } catch (NumberFormatException e) {
                request.setAttribute(
                    "ageError",
                    "※年齢は数字で入力してください"
                );
            }
        }
 
        // お子さんの年齢のチェック
        Integer child_age = null;
 
        if (childAgeText == null || childAgeText.trim().isEmpty()) {
 
            request.setAttribute(
                "childAgeError",
                "※入力は必須です"
            );
 
        } else {
 
            try {
                child_age = Integer.parseInt(childAgeText);
 
                if (child_age < 0 || child_age >= 18) {
                    request.setAttribute(
                        "childAgeError",
                        "※お子さんの年齢は0～17歳で入力してください"
                    );
                }
 
            } catch (NumberFormatException e) {
                request.setAttribute(
                    "childAgeError",
                    "※お子さんの年齢は数字で入力してください"
                );
            }
        }
 
        // エラー項目
        String[] errorKeys = {
            "usernameError",
            "emailError",
            "passwordError",
            "nicknameError",
            "ageError",
            "phoneError",
            "zipcodeError",
            "prefectureError",
            "cityError",
            "addressError",
            "buildingError",
            "childAgeError",
            "childGenderError"
        };
 
        // エラーがあれば入力画面に戻る
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
 
            // プロフィール画像の確認
            if (avatarPart == null || avatarPart.getSize() == 0) {
 
                request.setAttribute(
                    "message",
                    "プロフィール画像を選択してください。"
                );
 
                request.getRequestDispatcher(
                    "/scoremanager/main/enter_information.jsp"
                ).forward(request, response);
 
                return;
            }
 
            // ファイルサイズのチェック（5MBまで）
            if (avatarPart.getSize() > 5 * 1024 * 1024) {
 
                request.setAttribute(
                    "message",
                    "画像は5MB以内にしてください。"
                );
 
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
 
                request.setAttribute(
                    "message",
                    "JPEG・PNG・GIF形式の画像を選択してください。"
                );
 
                request.getRequestDispatcher(
                    "/scoremanager/main/enter_information.jsp"
                ).forward(request, response);
 
                return;
            }
 
            // 実際に画像として読み込めるか確認
            try (InputStream input = avatarPart.getInputStream()) {
 
                if (ImageIO.read(input) == null) {
 
                    request.setAttribute(
                        "message",
                        "正しい画像ファイルを選択してください。"
                    );
 
                    request.getRequestDispatcher(
                        "/scoremanager/main/enter_information.jsp"
                    ).forward(request, response);
 
                    return;
                }
            }
 
            // 画像の保存先
            String uploadDirectory =
                "C:\\work\\pleiades\\2023-12\\workspace\\papatalk\\src\\main\\webapp\\uploads";
 
            Path uploadPath = Path.of(uploadDirectory);
 
            // uploadsフォルダを作成
            Files.createDirectories(uploadPath);
 
            // 保存するファイル名
            String fileName =
                UUID.randomUUID().toString() + extension;
 
            // 保存先
            savedImagePath = uploadPath.resolve(fileName);
 
            // 画像を保存
            try (InputStream input = avatarPart.getInputStream()) {
                Files.copy(input, savedImagePath);
            }
 
            // DBに保存する画像URL
            avatarUrl = "/uploads/" + fileName;
 
            // 画像URLの文字数チェック
            if (avatarUrl.length() > 1000) {
 
                Files.deleteIfExists(savedImagePath);
                savedImagePath = null;
 
                request.setAttribute(
                    "message",
                    "プロフィール画像のURLが長すぎます。"
                );
 
                request.getRequestDispatcher(
                    "/scoremanager/main/enter_information.jsp"
                ).forward(request, response);
 
                return;
            }
 
            System.out.println("画像保存完了：" + savedImagePath);
            System.out.println("ファイル存在確認：" + Files.exists(savedImagePath));
 
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
 
            // データベースに登録
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
                "message",
                "登録処理中にエラーが発生しました。"
            );
 
            request.getRequestDispatcher(
                "/scoremanager/main/enter_information.jsp"
            ).forward(request, response);
        }
    }
 
    // 必須チェックと文字数チェックをまとめた処理
    private void checkRequiredAndLength(
            HttpServletRequest request,
            String errorKey,
            String value,
            int maxLength,
            String itemName) {
 
        // 必須チェック
        if (value == null || value.trim().isEmpty()) {
 
            request.setAttribute(
                errorKey,
                "※入力は必須です"
            );
 
            return;
        }
 
        // maxLengthが0の場合は文字数チェックを行わない
        if (maxLength > 0 && value.length() > maxLength) {
 
            request.setAttribute(
                errorKey,
                "※" + itemName + "は"
                + maxLength + "文字以内で入力してください"
            );
        }
    }
 
    // 任意項目の文字数チェック
    private void checkLength(
            HttpServletRequest request,
            String errorKey,
            String value,
            int max,
            String itemName) {
 
        // 空欄はチェックしない
        if (value == null || value.trim().isEmpty()) {
            return;
        }
 
        if (value.length() > max) {
 
            request.setAttribute(
                errorKey,
                "※" + itemName + "は"
                + max + "文字以内で入力してください"
            );
        }
    }
 
    // null・空文字の確認
    private boolean isNotBlank(String value) {
        return value != null && !value.trim().isEmpty();
    }
}