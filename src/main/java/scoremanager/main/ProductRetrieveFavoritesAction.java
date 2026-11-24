package scoremanager.main;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import bean.Product;
import bean.User;
import dao.ProductFavoritesDao;
import dao.ProductImageDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class ProductRetrieveFavoritesAction extends Action {

    @Override
    public void execute(HttpServletRequest request,
                        HttpServletResponse response) throws Exception {

        // ログインユーザーを取得
        User user = (User) request.getSession().getAttribute("user");

        // ログインしていない場合
        if (user == null) {
            response.sendRedirect(
                request.getContextPath() + "/scoremanager/login.jsp"
            );
            return;
        }

        try {
            // ユーザーIDを取得
            int userId = user.getUser_id();

            // お気に入り一覧を取得
            ProductFavoritesDao dao = new ProductFavoritesDao();
            List<Product> favorites = dao.select(userId);

            // 商品画像DAO
            ProductImageDAO imageDao = new ProductImageDAO();

            // 商品IDと1枚目の画像URLを紐づける
            Map<Integer, String> imageMap = new HashMap<>();

            for (Product product : favorites) {

                int productId = product.getProduct_id();

                // 1枚目の画像URLを取得
                String imageUrl = imageDao.selectFirstImage(productId);

                imageMap.put(productId, imageUrl);
            }

            // コンソール確認
            System.out.println("お気に入り商品数：" + favorites.size());
            System.out.println("商品画像一覧：" + imageMap);

            // JSPに渡す
            request.setAttribute("userId", userId);
            request.setAttribute("favorites", favorites);
            request.setAttribute("imageMap", imageMap);

            // お気に入り一覧画面へ遷移
            RequestDispatcher dispatcher =
                request.getRequestDispatcher(
                    "/scoremanager/main/product_favorites_list.jsp"
                );

            dispatcher.forward(request, response);

        } catch (Exception e) {
            throw e;
        }
    }
}