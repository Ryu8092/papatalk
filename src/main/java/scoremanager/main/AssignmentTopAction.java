package scoremanager.main;

import java.util.ArrayList;
import java.util.List;

import bean.Category;
import bean.Product;
import bean.User;
import dao.ProductCategoryDao;
import dao.ProductDao;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class AssignmentTopAction extends Action {

    @Override
    public void execute(HttpServletRequest request,
            HttpServletResponse response) throws Exception {

        // 商品一覧を取得
        ProductDao productDao = new ProductDao();
        List<Product> allProducts = productDao.select(null, null);

        // ログイン中のユーザー情報を取得
        HttpSession session = request.getSession(false);
        User user = null;

        if (session != null) {
            user = (User) session.getAttribute("user");
        }

        // 自分が出品した商品を除外
        List<Product> products = new ArrayList<>();

        for (Product product : allProducts) {

            // 未ログインの場合は全商品を表示
            // ログイン中の場合は自分の商品を除外
            if (user == null ||
                    product.getSeller_id() != user.getUser_id()) {

                products.add(product);
            }
        }

        // 商品一覧をJSPに渡す
        request.setAttribute("products", products);

        // ジャンル一覧をCategoryDaoから取得
        ProductCategoryDao categoryDao = new ProductCategoryDao();

        List<Category> categories = categoryDao.select();

        // ジャンル一覧をJSPに渡す
        request.setAttribute("categories", categories);

        // 商品一覧画面へ遷移
        request.getRequestDispatcher(
                "/scoremanager/main/assignment_top.jsp")
                .forward(request, response);
    }
}