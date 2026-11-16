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

public class AssignmentChatExecuteAction extends Action {

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

        User user = (User) session.getAttribute("user");

        int userId = user.getUser_id();

        // 商品ID
        String productIdStr = request.getParameter("product_id");

        if (productIdStr == null ||
                !productIdStr.matches("[0-9]+")) {

            response.sendRedirect(
                "/papatalk/scoremanager/main/AssignmentTop.action"
            );
            return;
        }

        int productId = Integer.parseInt(productIdStr);

        // 購入者ID
        String buyerIdStr = request.getParameter("buyer_id");

        if (buyerIdStr == null ||
                !buyerIdStr.matches("[0-9]+")) {

            response.sendRedirect(
                "/papatalk/scoremanager/main/AssignmentTop.action"
            );
            return;
        }

        int buyerId = Integer.parseInt(buyerIdStr);

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

        // 出品者または購入者本人か確認
        if (userId != sellerId && userId != buyerId) {
            response.sendRedirect(
                "/papatalk/scoremanager/main/AssignmentTop.action"
            );
            return;
        }

        // メッセージ内容
        String content = request.getParameter("content");

        if (content != null && !content.trim().isEmpty()) {

            // チャット情報作成
            OsagariChat chat = new OsagariChat();

            chat.setBuyer_id(buyerId);
            chat.setProduct_id(productId);

            // sender_idは0か1
            if (userId == sellerId) {
                chat.setSender_id(1);
            } else {
                chat.setSender_id(0);
            }

            chat.setContent(content.trim());

            // 登録
            OsagariChatDao dao = new OsagariChatDao();

            int result = dao.insert(chat);

            if (result <= 0) {
                request.setAttribute(
                    "errorMessage",
                    "メッセージを送信できませんでした。"
                );
            }
        } else {
            request.setAttribute(
                "errorMessage",
                "メッセージを入力してください。"
            );
        }

        // チャット履歴を再取得
        OsagariChatDao chatDao = new OsagariChatDao();

        List<OsagariChat> chats =
                chatDao.select(buyerId, productId);

        // 通報情報取得
        ReportDao reportDao = new ReportDao();

        List<Report> reports =
                reportDao.selectByReportContentId(3);

        ReportReasonDAO reasonDao = new ReportReasonDAO();

        List<ReportReason> reportReasons =
                reasonDao.getAll();
        
        // ログインユーザーの立場
        boolean isSeller = userId == sellerId;

        int chatPartnerId;

        if (isSeller) {
            chatPartnerId = buyerId;
        } else {
            chatPartnerId = sellerId;
        }

        // JSPに必要な情報を設定
        request.setAttribute("chats", chats);

        request.setAttribute("product", product);

        request.setAttribute("product_id", productId);

        request.setAttribute("buyer_id", buyerId);

        request.setAttribute("isSeller", isSeller);

        request.setAttribute("isBuyer", !isSeller);

        request.setAttribute("chatPartnerId", chatPartnerId);

        request.setAttribute("reports", reports);

        request.setAttribute("reportReasons", reportReasons);

        request.setAttribute("status", product.getStatus());

        request.setAttribute("showHandoverButton", isSeller);

        // chat_assignment.jspへ直接遷移
        request.getRequestDispatcher(
            "/scoremanager/main/chat_assignment.jsp"
        ).forward(request, response);
    }
}