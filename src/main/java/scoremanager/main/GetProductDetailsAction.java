
package scoremanager.main;

import java.util.List;

import bean.Category;
import bean.Product;
import bean.ReportReason;
import bean.User;
import dao.ProductCategoryDao;
import dao.ProductDao;
import dao.ProductFavoritesDao;
import dao.ProductImageDAO;
import dao.ReportReasonDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class GetProductDetailsAction extends Action {

    @Override
    public void execute(HttpServletRequest request,
                        HttpServletResponse response) throws Exception {

        // 商品ID取得
        String id = request.getParameter("product_id");

        if (id == null || id.isEmpty()) {
            request.setAttribute("errorMessage", "商品が指定されていません。");
            request.getRequestDispatcher("/assignment_top.jsp")
                   .forward(request, response);
            return;
        }

        int productId;

        try {
            productId = Integer.parseInt(id);
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "商品IDが正しくありません。");
            request.getRequestDispatcher("/assignment_top.jsp")
                   .forward(request, response);
            return;
        }

        // 商品情報取得
        ProductDao productDao = new ProductDao();

        Product product = productDao.selectById(productId);

        if (product == null) {
            request.setAttribute("errorMessage", "商品が見つかりませんでした。");
            request.getRequestDispatcher("/assignment_top.jsp")
                   .forward(request, response);
            return;
        }

        // 商品画像一覧取得
        ProductImageDAO imageDao = new ProductImageDAO();

        List<String> imageList =
                imageDao.selectByProductId(productId);

        // カテゴリ一覧取得
        ProductCategoryDao productcategoryDao =
                new ProductCategoryDao();

        List<Category> categories = productcategoryDao.select();

        // 通報理由一覧取得
        ReportReasonDAO reportreasonDao = new ReportReasonDAO();

        List<ReportReason> reportReasons = reportreasonDao.getAll();

        // ログインユーザー取得
        HttpSession session = request.getSession(false);

        Integer userId = null;

        if (session != null) {

            Object userIdObject = session.getAttribute("user_id");

            if (userIdObject != null) {

                userId = Integer.parseInt(userIdObject.toString());

            } else if (session.getAttribute("user") != null) {

                User user = (User) session.getAttribute("user");

                userId = user.getUser_id();

                session.setAttribute("user_id", userId);
            }
        }

        // お気に入り登録確認
        boolean isFavorite = false;

        if (userId != null) {

            ProductFavoritesDao favoritesDao =
                new ProductFavoritesDao();

            isFavorite = favoritesDao.exists(userId, productId);
        }

        // コンソール確認
        System.out.println("商品ID：" + product.getProduct_id());
        System.out.println("ジャンル名：" + product.getCategory_name());
        System.out.println("商品状態名：" + product.getItem_condition_name());
        System.out.println("投稿者名：" + product.getSeller_name());
        System.out.println("お気に入り登録済み：" + isFavorite);

        System.out.println("商品画像一覧：");

        for (String imageUrl : imageList) {
            System.out.println(imageUrl);
        }

        // JSPに渡す
        request.setAttribute("product", product);
        request.setAttribute("imageList", imageList);
        request.setAttribute("categoryName", product.getCategory_name());
        request.setAttribute("itemConditionName", product.getItem_condition_name());
        request.setAttribute("sellerName", product.getSeller_name());
        request.setAttribute("categories", categories);
        request.setAttribute("favoriteExists", isFavorite);
        request.setAttribute("reportReasons", reportReasons);

        // 商品詳細画面へ
        request.getRequestDispatcher(
            "/scoremanager/main/product_details.jsp"
        ).forward(request, response);
    }
}
