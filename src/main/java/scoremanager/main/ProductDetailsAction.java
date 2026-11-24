package scoremanager.main;

import bean.Product;
import dao.ProductDao;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class ProductDetailsAction extends Action {

    @Override
    public void execute(HttpServletRequest request,
                        HttpServletResponse response) throws Exception {

        request.setCharacterEncoding("UTF-8");

        try {
            // 商品IDを取得
            int productId = Integer.parseInt(
                    request.getParameter("product_id"));

            // 商品情報を取得
            ProductDao dao = new ProductDao();
            Product product = dao.selectById(productId);

            // 商品が見つからない場合
            if (product == null) {
                request.setAttribute("errorMessage",
                        "商品情報が見つかりません。");
                request.getRequestDispatcher("/error.jsp")
                       .forward(request, response);
                return;
            }

            // 商品情報をJSPに渡す
            request.setAttribute("product", product);

            // 商品詳細画面を表示
            request.getRequestDispatcher("/product_details.jsp")
                   .forward(request, response);

        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage",
                    "商品IDが正しくありません。");
            request.getRequestDispatcher("/error.jsp")
                   .forward(request, response);
        }
    }
}
