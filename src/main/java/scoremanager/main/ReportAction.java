
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

public class ReportAction extends Action {

    @Override
    public void execute(
            HttpServletRequest request,
            HttpServletResponse response) throws Exception {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);

        // ログイン確認
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(
                request.getContextPath() + "/login.jsp"
            );
            return;
        }

        // ログインユーザー取得
        User user = (User) session.getAttribute("user");
        int reporterUserId = user.getUser_id();

        // 通報種別取得
        String reportType = request.getParameter("report_type");

        // 共通項目取得
        String reasonIdText = request.getParameter("report_reason_id");
        String content = request.getParameter("content");

        int reasonId;
        int productId = 0;
        int reportedUserId = 0;

        // 通報理由確認
        try {
            reasonId = Integer.parseInt(reasonIdText);

            if (reasonId <= 0) {
                throw new NumberFormatException();
            }

        } catch (Exception e) {

            session.setAttribute(
                "reportMessage",
                "通報理由を選択してください。"
            );

            returnToPage(
                request, response, reportType,
                request.getParameter("product_id")
            );
            return;
        }

        // 通報内容確認
        if (content == null || content.trim().isEmpty()) {

            session.setAttribute(
                "reportMessage",
                "通報内容を入力してください。"
            );

            returnToPage(
                request, response, reportType,
                request.getParameter("product_id")
            );
            return;
        }

        // 商品の通報
        if ("product".equals(reportType)) {

            String productIdText =
                request.getParameter("product_id");

            try {
                productId = Integer.parseInt(productIdText);

                if (productId <= 0) {
                    throw new NumberFormatException();
                }

            } catch (Exception e) {

                session.setAttribute(
                    "reportMessage",
                    "商品IDが正しくありません。"
                );

                response.sendRedirect(
                    request.getContextPath()
                    + "/scoremanager/main/assignment_top.jsp"
                );
                return;
            }

            // 商品一覧取得
            ProductDao productDao = new ProductDao();
            List<Product> products = productDao.select(null, null);

            // 商品IDから出品者ID取得
            for (Product product : products) {

                if (product.getProduct_id() == productId) {
                    reportedUserId = product.getSeller_id();
                    break;
                }
            }

            // 商品が存在しない場合
            if (reportedUserId == 0) {

                session.setAttribute(
                    "reportMessage",
                    "商品が見つかりませんでした。"
                );

                response.sendRedirect(
                    request.getContextPath()
                    + "/scoremanager/main/assignment_top.jsp"
                );
                return;
            }

        // チャットの通報
        } else if ("chat".equals(reportType)) {

            String reportedUserIdText =
                request.getParameter("reported_user_id");

            String productIdText =
                request.getParameter("product_id");

            try {
                reportedUserId =
                    Integer.parseInt(reportedUserIdText);

                productId =
                    Integer.parseInt(productIdText);

                if (reportedUserId <= 0 || productId <= 0) {
                    throw new NumberFormatException();
                }

            } catch (Exception e) {

                session.setAttribute(
                    "reportMessage",
                    "通報対象の情報が正しくありません。"
                );

                forwardChatPage(request, response);
                return;
            }

        } else {

            session.setAttribute(
                "reportMessage",
                "通報種別が正しくありません。"
            );

            response.sendRedirect(
                request.getContextPath()
                + "/scoremanager/main/AssignmentTop.action"
            );
            return;
        }

        // 自分自身は通報できない
        if (reporterUserId == reportedUserId) {

            session.setAttribute(
                "reportMessage",
                "自分自身は通報できません。"
            );

            returnToPage(
                request,
                response,
                reportType,
                String.valueOf(productId)
            );
            return;
        }

        // 通報Bean作成
        Report report = new Report();

        report.setReporter_user_id(reporterUserId);
        report.setReported_user_id(reportedUserId);
        report.setReport_reason_id(reasonId);

        // 通報内容の分類ID
        // 商品通報：1
        // チャット通報：3
        if ("chat".equals(reportType)) {
            report.setReport_content_id(3);
        } else {
            report.setReport_content_id(1);
        }

        report.setContent(content.trim());
        report.setState(0);

        // 通報登録
        ReportDao reportDao = new ReportDao();
        int result = reportDao.insert(report);

        // 登録結果
        if (result > 0) {

            session.setAttribute(
                "reportMessage",
                "通報を受け付けました。ご協力ありがとうございます。"
            );

        } else {

            session.setAttribute(
                "reportMessage",
                "通報に失敗しました。もう一度お試しください。"
            );
        }

        // 通報種別によって遷移
        if ("chat".equals(reportType)) {

            // チャット履歴を再取得してJSPへ
            forwardChatPage(request, response);

        } else {

            // 商品詳細JSPへ
            response.sendRedirect(
                request.getContextPath()
                + "/scoremanager/main/product_details.jsp?product_id="
                + productId
            );
        }
    }

    // チャット画面に戻す
    private void forwardChatPage(
            HttpServletRequest request,
            HttpServletResponse response) throws Exception {

        HttpSession session = request.getSession(false);

        User loginUser = (User) session.getAttribute("user");
        int loginUserId = loginUser.getUser_id();

        // 商品ID取得
        String productIdText =
            request.getParameter("product_id");

        int productId;

        try {
            productId = Integer.parseInt(productIdText);

            if (productId <= 0) {
                throw new NumberFormatException();
            }

        } catch (Exception e) {

            response.sendRedirect(
                request.getContextPath()
                + "/scoremanager/main/AssignmentTop.action"
            );
            return;
        }

        // 商品情報取得
        ProductDao productDao = new ProductDao();
        Product product = productDao.selectById(productId);

        if (product == null) {

            response.sendRedirect(
                request.getContextPath()
                + "/scoremanager/main/AssignmentTop.action"
            );
            return;
        }

        int sellerId = product.getSeller_id();

        boolean isSeller = loginUserId == sellerId;

        // 購入者ID取得
        int buyerId;

        if (isSeller) {

            String buyerIdText =
                request.getParameter("buyer_id");

            try {
                buyerId = Integer.parseInt(buyerIdText);

                if (buyerId <= 0) {
                    throw new NumberFormatException();
                }

            } catch (Exception e) {

                response.sendRedirect(
                    request.getContextPath()
                    + "/scoremanager/main/AssignmentTop.action"
                );
                return;
            }

        } else {
            buyerId = loginUserId;
        }

        // チャット参加者確認
        if (!isSeller && loginUserId != buyerId) {

            response.sendRedirect(
                request.getContextPath()
                + "/scoremanager/main/AssignmentTop.action"
            );
            return;
        }

        // チャット履歴取得
        OsagariChatDao chatDao = new OsagariChatDao();

        List<OsagariChat> chats =
            chatDao.select(buyerId, productId);

        // チャットに関する通報情報取得
        ReportDao reportDao = new ReportDao();

        List<Report> reports =
            reportDao.selectByReportContentId(3);

        // 通報理由一覧取得
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

        // 通報結果メッセージ取得
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

        // 通報情報
        request.setAttribute("reports", reports);

        // 通報理由一覧
        request.setAttribute("reportReasons", reasonList);

        // 取引状態
        request.setAttribute("status", product.getStatus());
        request.setAttribute("showHandoverButton", isSeller);

        // JSPへ転送
        request.getRequestDispatcher(
            "/scoremanager/main/chat_assignment.jsp"
        ).forward(request, response);
    }

    // 通報種別によって戻り先を切り替える
    private void returnToPage(
            HttpServletRequest request,
            HttpServletResponse response,
            String reportType,
            String productId) throws Exception {

        if ("chat".equals(reportType)) {

            // チャットは履歴を再取得してJSPへ
            forwardChatPage(request, response);

        } else if ("product".equals(reportType)) {

            // 商品詳細JSPへ
            response.sendRedirect(
                request.getContextPath()
                + "/scoremanager/main/product_details.jsp?product_id="
                + productId
            );

        } else {

            response.sendRedirect(
                request.getContextPath()
                + "/scoremanager/main/AssignmentTop.action"
            );
        }
    }
}
