
package scoremanager.main;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import bean.Product;
import bean.User;
import dao.ProductDao;
import dao.ProductImageDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class ProductListingAction extends Action {

    @Override
    public void execute(HttpServletRequest request,
            HttpServletResponse response) throws Exception {

        // ログイン情報を取得
        HttpSession session = request.getSession(false);

        if (session == null) {
            throw new Exception("ログイン情報がありません。");
        }

        User user = (User) session.getAttribute("user");

        if (user == null) {
            throw new Exception("ログイン情報がありません。");
        }

        // ログイン中のユーザーID
        int userId = user.getUser_id();

        // 商品をすべて取得
        ProductDao dao = new ProductDao();
        List<Product> allProducts = dao.select(null, null);

        // 画像DAO
        ProductImageDAO imageDao = new ProductImageDAO();

        // 自分が出品した商品
        List<Product> productList = new ArrayList<>();

        // 商品IDと画像URLを管理
        Map<Integer, String> imageMap = new HashMap<>();

        for (Product product : allProducts) {

            if (product.getSeller_id() == userId) {

                productList.add(product);

                // 商品の1枚目の画像URLを取得
                String imageUrl =
                    imageDao.selectFirstImage(product.getProduct_id());
                	System.out.println(imageUrl);

                imageMap.put(product.getProduct_id(), imageUrl);
            }
        }

        // JSPに商品一覧と画像情報を渡す
        request.setAttribute("productList", productList);
        request.setAttribute("imageMap", imageMap);

        // 出品管理画面へ移動
        request.getRequestDispatcher(
            "/scoremanager/main/listing_management.jsp"
        ).forward(request, response);
    }
}
