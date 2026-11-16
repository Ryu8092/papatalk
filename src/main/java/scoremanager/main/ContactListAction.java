
package scoremanager.main;

import java.util.List;

import bean.OsagariChat;
import bean.User;
import dao.OsagariChatDao;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class ContactListAction extends Action {

    @Override
    public void execute(HttpServletRequest request,
                        HttpServletResponse response) throws Exception {

        request.setCharacterEncoding("UTF-8");

        // セッションの確認
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(
                request.getContextPath() + "/login.jsp"
            );
            return;
        }

        // ログイン中のユーザー（出品者）を取得
        User user = (User) session.getAttribute("user");
        int sellerId = user.getUser_id();

        // 商品IDを取得
        String productIdStr = request.getParameter("product_id");

        // 商品IDの入力チェック
        if (productIdStr == null ||
            !productIdStr.matches("[0-9]+")) {

            response.sendRedirect(
                request.getContextPath()
                + "/scoremanager/main/ProductListing.action"
            );
            return;
        }

        int productId = Integer.parseInt(productIdStr);

        // 出品者IDと商品IDからお問い合わせ一覧を取得
        OsagariChatDao dao = new OsagariChatDao();

        List<OsagariChat> chatList =
            dao.selectBuyer(sellerId, productId);

        // JSPにデータを渡す
        request.setAttribute("chatList", chatList);
        request.setAttribute("productId", productId);

        // お問い合わせがない場合
        if (chatList == null || chatList.isEmpty()) {
            request.setAttribute(
                "message",
                "この商品には、現在お問い合わせがありません。"
            );
        }

        // お問い合わせ一覧画面へ遷移
        request.getRequestDispatcher(
            "/scoremanager/main/inquiry_list.jsp"
        ).forward(request, response);
    }
}
