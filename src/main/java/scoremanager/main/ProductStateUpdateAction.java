
package scoremanager.main;

import java.util.ArrayList;
import java.util.List;

import bean.OsagariChat;
import bean.Product;
import bean.User;
import dao.OsagariChatDao;
import dao.ProductDao;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class ProductStateUpdateAction extends Action {

    @Override
    public void execute(HttpServletRequest request,
                        HttpServletResponse response)
            throws Exception {

        // ① 文字コード設定
        request.setCharacterEncoding("UTF-8");

        // ② セッション取得
        HttpSession session = request.getSession(false);

        // ログイン確認
        if (session == null ||
            session.getAttribute("user") == null) {

            throw new Exception("ログインしてください。");
        }

        // ③ ログインユーザー取得
        User user = (User) session.getAttribute("user");

        // ④ パラメータ取得
        String productIdStr = request.getParameter("product_id");
        String buyerIdStr = request.getParameter("buyer_id");
        String statusStr = request.getParameter("status");

        // ⑤ 入力チェック
        if (productIdStr == null ||
            buyerIdStr == null ||
            statusStr == null ||
            !productIdStr.matches("[0-9]+") ||
            !buyerIdStr.matches("[0-9]+") ||
            !statusStr.matches("[0-9]+")) {

            throw new Exception(
                "商品ID、購入希望者ID、または取引状態が指定されていません。"
            );
        }

        // ⑥ 数値に変換
        int product_id = Integer.parseInt(productIdStr);
        int buyer_id = Integer.parseInt(buyerIdStr);
        int status = Integer.parseInt(statusStr);

        if (product_id <= 0 || buyer_id <= 0) {
            throw new Exception("正しいIDを指定してください。");
        }

        // ⑦ 変更後の取引状態確認
        if (status != 1 && status != 2 && status != 3) {
            throw new Exception("正しい取引状態を指定してください。");
        }

        // ⑧ DAO生成
        ProductDao dao = new ProductDao();

        // ⑨ 商品情報取得
        Product product = dao.selectById(product_id);

        if (product == null) {
            throw new Exception("商品が見つかりません。");
        }

        // ⑩ ID確認
        System.out.println("ログインユーザーID：" + user.getUser_id());
        System.out.println("商品ID：" + product_id);
        System.out.println("商品出品者ID：" + product.getSeller_id());
        System.out.println("購入希望者ID：" + buyer_id);

        // 出品者本人か確認
        if (product.getSeller_id() != user.getUser_id()) {
            throw new Exception(
                "取引状態を変更する権限がありません。"
            );
        }

        // ⑪ 現在の取引状態取得
        int currentStatus = dao.selectStatus(product_id);

        // ⑫ 取引状態の変更確認
        if (currentStatus == 0) {

            // 募集中から受け渡し予定への変更のみ許可
            if (status != 1) {
                throw new Exception(
                    "この取引状態には変更できません。"
                );
            }

        } else if (currentStatus == 1) {

            // 受け渡し予定から完了または中止への変更のみ許可
            if (status != 2 && status != 3) {
                throw new Exception(
                    "この取引状態には変更できません。"
                );
            }

        } else if (currentStatus == 2 || currentStatus == 3) {

            throw new Exception(
                "この取引はすでに終了しています。"
            );

        } else {

            throw new Exception(
                "現在の取引状態を確認できません。"
            );
        }

        // ⑬ 取引状態を更新
        int line = dao.update(product_id, status);

        if (line == 0) {
            throw new Exception(
                "取引状態を更新できませんでした。"
            );
        }

        // ⑭ 更新後の商品情報を取得
        Product updatedProduct = dao.selectById(product_id);

        if (updatedProduct == null) {
            throw new Exception(
                "更新後の商品情報が見つかりません。"
            );
        }

        // ⑮ チャット履歴を再取得
        OsagariChatDao chatDao = new OsagariChatDao();

        List<OsagariChat> chats =
                chatDao.select(buyer_id, product_id);

        if (chats == null) {
            chats = new ArrayList<>();
        }

        // ⑯ JSPに渡す情報を設定
        request.setAttribute("product", updatedProduct);
        request.setAttribute("product_id", product_id);
        request.setAttribute("buyer_id", buyer_id);
        request.setAttribute("status", updatedProduct.getStatus());
        request.setAttribute("chats", chats);

        // ログインユーザーは出品者なのでtrue
        request.setAttribute("showHandoverButton", true);

        // ⑰ JSPへ直接遷移
        request.getRequestDispatcher(
            "/scoremanager/main/chat_assignment.jsp"
        ).forward(request, response);
    }
}
