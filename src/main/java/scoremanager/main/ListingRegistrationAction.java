
package scoremanager.main;

import bean.Product;
import bean.User;
import dao.ProductDao;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class ListingRegistrationAction extends Action {

    @Override
    public void execute(HttpServletRequest request,
            HttpServletResponse response) throws Exception {

        // ログイン中のユーザーを取得
        User user = (User) request.getSession().getAttribute("user");

        // ログインしていない場合
        if (user == null) {
            throw new Exception("ログイン情報を取得できませんでした。");
        }

        // JSPから送信された値を取得
        String productName = request.getParameter("product_name");
        String pickupLocation = request.getParameter("pickup_location");
        String content = request.getParameter("content");
        String categoryId = request.getParameter("category_id");
        String itemConditionId = request.getParameter("item_condition_id");
        
        System.out.println(productName);
        System.out.println(pickupLocation);
        System.out.println(content);
        System.out.println(categoryId);
        System.out.println(itemConditionId);
        
        // 必須項目の入力チェック
        if (productName == null || productName.trim().isEmpty()
                || pickupLocation == null || pickupLocation.trim().isEmpty()
                || categoryId == null || categoryId.isEmpty()
                || itemConditionId == null || itemConditionId.isEmpty()) {

            request.setAttribute("errorMessage",
                    "商品名、受け渡し場所、カテゴリ、商品状態を入力してください。");

            request.getRequestDispatcher(
                    "/scoremanager/main/listing.jsp")
                    .forward(request, response);
            return;
        }

        // 商品情報を作成
        Product bean = new Product();

        // 出品者IDはログインユーザーから取得
        bean.setSeller_id(user.getUser_id());

        bean.setProduct_name(productName.trim());
        bean.setPickup_location(pickupLocation.trim());
        bean.setContent(content == null ? "" : content.trim());

        // 新規出品時のステータス
        // DBのデフォルト値と同じ0を設定
        bean.setStatus("0");

        bean.setCategory_id(Integer.parseInt(categoryId));
        bean.setItem_condition_id(Integer.parseInt(itemConditionId));

        // 商品を登録
        ProductDao dao = new ProductDao();
        dao.insert(bean);

        // 登録完了画面へ移動
        response.sendRedirect(
                request.getContextPath()
                + "/scoremanager/main/ListingComplete.action");
    }
}
