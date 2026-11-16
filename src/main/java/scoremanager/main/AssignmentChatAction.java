
package scoremanager.main;

import java.util.List;

import bean.OsagariChat;
import bean.Product;
import bean.Report;
import bean.ReportReason;
import bean.User;
import dao.OsagariChatDao;
import dao.ProductDao;
import dao.ReportDao;
import dao.ReportReasonDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class AssignmentChatAction extends Action {

    @Override
    public void execute(
            HttpServletRequest request,
            HttpServletResponse response) throws Exception {

        HttpSession session = request.getSession(false);

        // ログイン確認
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(
                "/papatalk/scoremanager/main/Login.action"
            );
            return;
        }

        User loginUser = (User) session.getAttribute("user");
        int loginUserId = loginUser.getUser_id();

        // 商品ID取得
        String productIdStr = request.getParameter("product_id");

        if (productIdStr == null ||
                !productIdStr.matches("[0-9]+")) {

            response.sendRedirect(
                "/papatalk/scoremanager/main/AssignmentTop.action"
            );
            return;
        }

        int productId = Integer.parseInt(productIdStr);

        // 商品情報取得
        ProductDao productDao = new ProductDao();
        Product product = productDao.selectById(productId);

        if (product == null) {
            response.sendRedirect(
                "/papatalk/scoremanager/main/AssignmentTop.action"
            );
            return;
        }

        int sellerId = product.getSeller_id();
        boolean isSeller = loginUserId == sellerId;

        // 購入者ID取得
        int buyerId;

        if (isSeller) {

            String buyerIdStr = request.getParameter("buyer_id");

            if (buyerIdStr == null ||
                    !buyerIdStr.matches("[0-9]+")) {

                response.sendRedirect(
                    "/papatalk/scoremanager/main/AssignmentTop.action"
                );
                return;
            }

            buyerId = Integer.parseInt(buyerIdStr);

        } else {
            buyerId = loginUserId;
        }

        // 出品者または購入者本人か確認
        if (!isSeller && loginUserId != buyerId) {

            response.sendRedirect(
                "/papatalk/scoremanager/main/AssignmentTop.action"
            );
            return;
        }

        // チャット履歴取得
        OsagariChatDao chatDao = new OsagariChatDao();

        List<OsagariChat> chats =
                chatDao.select(buyerId, productId);
        
        System.out.println("===== チャット取得確認 =====");
        System.out.println("ログインユーザーID：" + loginUserId);
        System.out.println("商品ID：" + productId);
        System.out.println("購入者ID：" + buyerId);

        for (OsagariChat chat : chats) {
            System.out.println(
                "CHAT_ID：" + chat.getChat_id()
                + " / PRODUCT_ID：" + chat.getProduct_id()
                + " / BUYER_ID：" + chat.getBuyer_id()
                + " / CONTENT：" + chat.getContent()
            );
        }
        
        // チャットに関する通報情報を取得
        ReportDao reportDao = new ReportDao();

        List<Report> reports =
                reportDao.selectByReportContentId(3);

        // 通報理由一覧を取得
        ReportReasonDAO reasonDao = new ReportReasonDAO();

        List<ReportReason> reasonList =
                reasonDao.getAll();

        // チャット相手ID
        int chatPartnerId;

        if (isSeller) {
            chatPartnerId = buyerId;
        } else {
            chatPartnerId = sellerId;
        }

        // 通報結果メッセージ
        request.setAttribute(
            "reportMessage",
            session.getAttribute("reportMessage")
        );

        session.removeAttribute("reportMessage");

        // リクエスト設定
        request.setAttribute("chats", chats);
        request.setAttribute("product", product);
        request.setAttribute("product_id", productId);
        request.setAttribute("buyer_id", buyerId);
        request.setAttribute("isSeller", isSeller);
        request.setAttribute("isBuyer", !isSeller);
        request.setAttribute("chatPartnerId", chatPartnerId);

        // 通報情報リスト
        request.setAttribute("reports", reports);

        // 通報理由一覧
        request.setAttribute("reportReasons", reasonList);

        // 取引状態
        request.setAttribute("status", product.getStatus());
        request.setAttribute("showHandoverButton", isSeller);

        // JSPへ
        request.getRequestDispatcher(
            "/scoremanager/main/chat_assignment.jsp"
        ).forward(request, response);
    }
}
