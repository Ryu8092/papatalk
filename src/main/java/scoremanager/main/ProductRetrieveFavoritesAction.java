package scoremanager.main;

import java.util.List;

import bean.Product;
import bean.User;
import dao.ProductFavoritesDao;
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
            
            System.out.println(favorites);
            // JSPに渡す
            request.setAttribute("userId", userId);
            request.setAttribute("favorites", favorites);

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
