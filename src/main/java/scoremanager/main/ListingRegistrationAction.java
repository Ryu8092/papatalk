
package scoremanager.main;

import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.imageio.ImageIO;

import bean.Product;
import bean.User;
import dao.ProductDao;
import dao.ProductImageDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import tool.Action;

public class ListingRegistrationAction extends Action {

    // 画像の最大枚数
    private static final int MAX_IMAGE_COUNT = 3;

    // 画像1枚の最大サイズ（5MB）
    private static final long MAX_IMAGE_SIZE = 5 * 1024 * 1024;

    // 画像の保存先
    private static final String UPLOAD_DIRECTORY =
        "C:\\work\\pleiades\\2023-12\\workspace\\papatalk\\src\\main\\webapp\\uploads";

    @Override
    public void execute(HttpServletRequest request,
                        HttpServletResponse response) throws Exception {

        // 保存した画像ファイルのパスを記録
        List<Path> savedImagePaths = new ArrayList<>();

        try {

            // ログイン中のユーザーを取得
            User user = (User) request.getSession().getAttribute("user");

            // ログインしていない場合
            if (user == null) {
                throw new Exception("ログイン情報を取得できませんでした。");
            }

            // JSPから送信された値を取得
            String productName = request.getParameter("product_name");
            String pickupLocation = request.getParameter("pickup_location");
            String content = request.getParameter("content");
            String categoryId = request.getParameter("category_id");
            String itemConditionId = request.getParameter("item_condition_id");


            // 必須項目の入力チェック
            if (productName == null || productName.trim().isEmpty()
                    || pickupLocation == null || pickupLocation.trim().isEmpty()
                    || categoryId == null || categoryId.isEmpty()
                    || itemConditionId == null || itemConditionId.isEmpty()) {

                request.setAttribute("errorMessage",
                    "商品名、受け渡し場所、カテゴリ、商品状態を入力してください。");

                request.getRequestDispatcher(
                    "/scoremanager/main/listing.jsp")
                    .forward(request, response);

                return;
            }

            // 商品情報を作成
            Product bean = new Product();

            // 出品者IDはログインユーザーから取得
            bean.setSeller_id(user.getUser_id());

            bean.setProduct_name(productName.trim());
            bean.setPickup_location(pickupLocation.trim());
            bean.setContent(content == null ? "" : content.trim());

            // 新規出品時のステータス
            bean.setStatus("0");
            bean.setCategory_id(Integer.parseInt(categoryId));
            bean.setItem_condition_id(Integer.parseInt(itemConditionId));

            // 画像を取得

            List<Part> imageParts = new ArrayList<>();

            for (Part part : request.getParts()) {

                if ("images".equals(part.getName())
                        && part.getSize() > 0) {

                    imageParts.add(part);
                }
            }

            // 画像枚数チェック
            if (imageParts.isEmpty()) {
                throw new Exception("商品画像を1枚以上選択してください。");
            }

            if (imageParts.size() != MAX_IMAGE_COUNT) {
                throw new Exception("商品画像を3枚選択してください。");
            }

            // 画像を保存

            Path uploadPath = Path.of(UPLOAD_DIRECTORY);

            // uploadsフォルダを作成
            Files.createDirectories(uploadPath);

            List<String> imageUrls = new ArrayList<>();

            for (Part imagePart : imageParts) {

                // ファイルサイズチェック
                if (imagePart.getSize() > MAX_IMAGE_SIZE) {
                    throw new Exception("画像は1枚5MB以内にしてください。");
                }

                // MIMEタイプを確認
                String contentType = imagePart.getContentType();

                String extension;

                if ("image/jpeg".equalsIgnoreCase(contentType)) {
                    extension = ".jpg";

                } else if ("image/png".equalsIgnoreCase(contentType)) {
                    extension = ".png";

                } else if ("image/gif".equalsIgnoreCase(contentType)) {
                    extension = ".gif";

                } else {
                    throw new Exception(
                        "JPEG、PNG、GIF形式の画像を選択してください。");
                }

                // 画像として読み込めるか確認
                try (InputStream input = imagePart.getInputStream()) {

                    if (ImageIO.read(input) == null) {
                        throw new Exception("画像ファイルが正しくありません。");
                    }
                }

                // UUIDでファイル名を作成
                String fileName =
                    UUID.randomUUID().toString() + extension;

                // 保存先
                Path savedImagePath = uploadPath.resolve(fileName);

                // 画像を保存
                try (InputStream input = imagePart.getInputStream()) {
                    Files.copy(input, savedImagePath);
                }

                // 保存したファイルを記録
                savedImagePaths.add(savedImagePath);

                // DBに保存する画像URL
                String imageUrl = "/uploads/" + fileName;

                imageUrls.add(imageUrl);

                System.out.println("画像保存完了：" + savedImagePath);
                System.out.println("ファイル存在確認："
                    + Files.exists(savedImagePath));
            }

            // 商品情報を登録
            ProductDao dao = new ProductDao();
            // 自動採番されたPRODUCT_IDを取得
            int productId = dao.insert(bean);

            // 商品画像情報を登録
            ProductImageDAO imageDao = new ProductImageDAO();

            for (String imageUrl : imageUrls) {

                imageDao.insert(productId, imageUrl);

                System.out.println("画像URL登録：" + imageUrl);
            }

            // 登録完了画面へ移動
            response.sendRedirect(
                request.getContextPath()
                + "/scoremanager/main/ListingComplete.action");

        } catch (Exception e) {

            // 保存済み画像を削除
            for (Path path : savedImagePaths) {

                try {
                    Files.deleteIfExists(path);

                } catch (Exception deleteError) {
                    deleteError.printStackTrace();
                }
            }

            // エラー内容を表示
            e.printStackTrace();

            request.setAttribute("errorMessage", e.getMessage());

            request.getRequestDispatcher(
                "/scoremanager/main/listing.jsp")
                .forward(request, response);
        }
    }
}
