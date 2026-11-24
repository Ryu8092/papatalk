package scoremanager.main;
 
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
 
        // お気に入り登録済みか確認
        boolean exists = favoriteDao.exists(userId, productId);
 
        // ボタンから送られた処理を取得
        String action = request.getParameter("action");
 
        if ("remove".equals(action)) {
 
            // お気に入り解除
            ProductFavorites favorite = new ProductFavorites();
 
            favorite.setUser_id(userId);
            favorite.setProduct_id(productId);
 
            favoriteDao.delete(favorite);
 
        } else if (!exists) {
 
            // 未登録の場合だけ登録
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