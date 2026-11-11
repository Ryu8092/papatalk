package scoremanager.main;
 
import bean.Report;
import bean.User;
import dao.ReportDao;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;
 
public class ChatReportRegistrationAction extends Action {
 
    @Override
    public void execute(HttpServletRequest request,
                        HttpServletResponse response) throws Exception {
 
        request.setCharacterEncoding("UTF-8");
 
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/scoremanager/Login.action");
            return;
        }
 
        // ログインユーザー（通報者）
        User user = (User) session.getAttribute("user");
        int reporterUserId = user.getUser_id();
 
        // JSPから送信されたパラメータを取得
        String replyIdText = request.getParameter("reply_id");
        String postIdText = request.getParameter("post_id");
        String reasonIdText = request.getParameter("report_reason_id");
        String content = request.getParameter("content");
 
        int replyId = 0;
        int postId = 0;
        int reasonId = 0;
 
        try {
            replyId = Integer.parseInt(replyIdText);
            reasonId = Integer.parseInt(reasonIdText);
            if (postIdText != null && !postIdText.isEmpty()) {
                postId = Integer.parseInt(postIdText);
            }
        } catch (Exception e) {
            session.setAttribute("reportMessage", "入力値が不正です。");
            response.sendRedirect(request.getContextPath() + "/scoremanager/main/RetrieveReplies.action?post_id=" + postId);
            return;
        }
 
        ReportDao dao = new ReportDao();
        int reportedUserId = 0;
 
        try {
            // 返信IDから返信を作成したユーザーのIDを取得（修正点）
            reportedUserId = dao.getUserIdByReplyId(replyId);
        } catch (Exception e) {
            e.printStackTrace();
        }
 
        if (reportedUserId == 0) {
            session.setAttribute("reportMessage", "対象の返信が見つかりませんでした。");
            response.sendRedirect(request.getContextPath() + "/scoremanager/main/RetrieveReplies.action?post_id=" + postId);
            return;
        }
 
        // 自分の返信は通報不可
        if (reporterUserId == reportedUserId) {
            session.setAttribute("reportMessage", "自分の返信は通報できません。");
            response.sendRedirect(request.getContextPath() + "/scoremanager/main/RetrieveReplies.action?post_id=" + postId);
            return;
        }
 
        // Report Beanの作成
        Report report = new Report();
        report.setReporter_user_id(reporterUserId);
        report.setReported_user_id(reportedUserId);
        report.setReport_reason_id(reasonId);
        report.setReport_content_id(2); // 返信通報の分類ID
        report.setContent(content.trim());
        report.setState(0);
 
        // シーケンス図通り ReportDAO の insert を実行して件数を取得
        int result = 0;
        try {
            result = dao.insert(report);
        } catch (Exception e) {
            e.printStackTrace();
        }
 
        // 結果メッセージの設定
        if (result > 0) {
            session.setAttribute("reportMessage", "通報が完了しました。");
        } else {
            session.setAttribute("reportMessage", "通報に失敗しました。");
        }
 
        // 返信一覧画面へ戻る（post_idを引き継いで元の画面へリダイレクト）
        response.sendRedirect(request.getContextPath() + "/scoremanager/main/RetrieveReplies.action?post_id=" + postId);
    }
}
 