
package scoremanager.main;

import java.util.List;

import bean.Product;
import bean.ProductFavorites;
import bean.User;
import dao.ProductDao;
import dao.ProductFavoritesDao;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class AddFavoriteAction extends Action {

    @Override
    public void execute(HttpServletRequest request,
                        HttpServletResponse response) throws Exception {

        request.setCharacterEncoding("UTF-8");

        // ログイン確認
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("Login.action");
            return;
        }

        // ユーザー情報取得
        User user = (User) session.getAttribute("user");

        int userId = user.getUser_id();

        // 商品ID取得
        String id = request.getParameter("product_id");

        if (id == null || id.isEmpty()) {
            throw new Exception("商品IDが指定されていません。");
        }

        int productId = Integer.parseInt(id);

        // 商品情報取得
        ProductDao productDao = new ProductDao();

        Product product = productDao.selectById(productId);

        if (product == null) {
            throw new Exception("商品が見つかりません。");
        }

        // お気に入りDAO
        ProductFavoritesDao favoriteDao = new ProductFavoritesDao();

        // ログインユーザーのお気に入り一覧を取得
        List<Product> favorites = favoriteDao.select(userId);

        // 登録済みか確認
        boolean exists = false;

        for (Product favorite : favorites) {

            if (favorite.getProduct_id() == productId) {
                exists = true;
                break;
            }
        }

        // 未登録の場合だけ登録
        if (!exists) {

            ProductFavorites favorite = new ProductFavorites();

            favorite.setUser_id(userId);
            favorite.setProduct_id(productId);

            favoriteDao.insert(favorite);
        }

        // 商品詳細画面を再取得
        response.sendRedirect(
            request.getContextPath()
            + "/scoremanager/main/GetProductDetails.action?product_id="
            + productId
        );
    }
}
