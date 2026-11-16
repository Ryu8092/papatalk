package scoremanager.main;

import bean.ProductFavorites;
import bean.User;
import dao.ProductFavoritesDao;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class ProductDeletesFavoritesAction extends Action {

    @Override
    public void execute(HttpServletRequest request,
                        HttpServletResponse response) throws Exception {

        // ログイン中のユーザーを取得
        User user = (User) request.getSession().getAttribute("user");

        if (user == null) {
            response.sendRedirect(
                request.getContextPath() + "/scoremanager/login.jsp"
            );
            return;
        }

        // ユーザーIDを取得
        int userId = user.getUser_id();

        // 商品IDを取得
        int productId = Integer.parseInt(
            request.getParameter("product_id")
        );

        // 削除対象のお気に入り情報を設定
        ProductFavorites fav = new ProductFavorites();
        fav.setUser_id(userId);
        fav.setProduct_id(productId);

        // お気に入りを削除
        ProductFavoritesDao dao = new ProductFavoritesDao();
        dao.delete(fav);

        // お気に入り一覧を再取得
        request.getRequestDispatcher(
            "/scoremanager/main/ProductRetrieveFavorites.action"
        ).forward(request, response);
    }
}