
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

public class ProductAcquisitionAction extends Action {

    @Override
    public void execute(HttpServletRequest request,
            HttpServletResponse response) throws Exception {

        request.setCharacterEncoding("UTF-8");

        ProductDao productDao = new ProductDao();
        ProductCategoryDao categoryDao = new ProductCategoryDao();

        // 検索条件を取得
        String categoryIdStr =
            request.getParameter("category_id");

        // 都道府県
        String prefecture =
            request.getParameter("prefecture");

        Integer categoryId = null;

        // ジャンルIDが入力されている場合
        if (categoryIdStr != null
                && !categoryIdStr.trim().isEmpty()) {

            try {
                categoryId = Integer.parseInt(categoryIdStr);

            } catch (NumberFormatException e) {

                request.setAttribute(
                    "errorMessage",
                    "ジャンルの指定が正しくありません。"
                );
            }
        }

        // 商品一覧を取得
        List<Product> allProducts = new ArrayList<>();

        if (request.getAttribute("errorMessage") == null) {

            allProducts = productDao.select(
                categoryId,
                prefecture
            );
        }

        // ログイン中のユーザー情報を取得
        HttpSession session = request.getSession(false);

        User user = null;

        if (session != null) {
            user = (User) session.getAttribute("user");
        }

        // 自分が出品した商品を除外
        List<Product> products = new ArrayList<>();

        for (Product product : allProducts) {

            if (user == null
                    || product.getSeller_id() != user.getUser_id()) {

                products.add(product);
            }
        }

        // 商品がない場合
        if (products.isEmpty()
                && request.getAttribute("errorMessage") == null) {

            request.setAttribute(
                "errorMessage",
                "条件に一致する商品がありません。"
            );
        }

        // 商品一覧をJSPに渡す
        request.setAttribute("products", products);

        // 検索条件をJSPに戻す
        request.setAttribute(
            "selectedCategoryId",
            categoryIdStr
        );

        request.setAttribute(
            "selectedPrefecture",
            prefecture
        );

        // ジャンル一覧を取得
        List<Category> categories = categoryDao.select();

        request.setAttribute("categories", categories);

        // 商品一覧画面へ遷移
        request.getRequestDispatcher(
            "/scoremanager/main/assignment_top.jsp"
        ).forward(request, response);
    }
}
