package scoremanager.main;
 
import bean.Report;
import bean.User;
import dao.ReportDao;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;
 
public class PostReportRegistrationAction extends Action {
 
    @Override
    public void execute(HttpServletRequest request,
                        HttpServletResponse response) throws Exception {
 
        request.setCharacterEncoding("UTF-8");
 
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath()
                    + "/scoremanager/Login.action");
            return;
        }
 
        User user = (User) session.getAttribute("user");
        int reporterUserId = user.getUser_id();
 
        String postIdText = request.getParameter("post_id");
        String reasonIdText = request.getParameter("report_reason_id");
        String content = request.getParameter("content");
 
        // 通報内容の必須チェック
        if (content == null || content.isBlank()) {
            session.setAttribute("reportMessage", "通報内容を入力してください。");
            response.sendRedirect(request.getContextPath()
                    + "/scoremanager/main/RetrievePosts.action");
            return;
        }
 
        // 通報内容の文字数チェック
        if (content.length() > 1000) {
            session.setAttribute("reportMessage",
                    "通報内容は1000文字以内で入力してください。");
            response.sendRedirect(request.getContextPath()
                    + "/scoremanager/main/RetrievePosts.action");
            return;
        }
 
        int postId;
        int reasonId;
 
        try {
            postId = Integer.parseInt(postIdText);
            reasonId = Integer.parseInt(reasonIdText);
        } catch (Exception e) {
            session.setAttribute("reportMessage", "入力値が不正です。");
            response.sendRedirect(request.getContextPath()
                    + "/scoremanager/main/RetrievePosts.action");
            return;
        }
 
        System.out.println(postId);
 
        ReportDao dao = new ReportDao();
        int reportedUserId = 0;
 
        try {
            // 投稿者IDを取得
            reportedUserId = dao.getUserIdByPostId(postId);
        } catch (Exception e) {
            e.printStackTrace();
        }
 
        if (reportedUserId == 0) {
            session.setAttribute("reportMessage", "投稿が見つかりませんでした。");
            response.sendRedirect(request.getContextPath()
                    + "/scoremanager/main/RetrievePosts.action");
            return;
        }
 
        if (reporterUserId == reportedUserId) {
            session.setAttribute("reportMessage", "自分の投稿は通報できません。");
            response.sendRedirect(request.getContextPath()
                    + "/scoremanager/main/RetrievePosts.action");
            return;
        }
 
        // ReportBeanの組み立て
        Report report = new Report();
        report.setReporter_user_id(reporterUserId);
        report.setReported_user_id(reportedUserId);
        report.setReport_reason_id(reasonId);
        report.setReport_content_id(1);
        report.setContent(content.trim());
        report.setState(0);
 
        // 通報情報をDBに保存
        int result = 0;
 
        try {
            result = dao.insert(report);
        } catch (Exception e) {
            e.printStackTrace();
        }
 
        if (result > 0) {
            session.setAttribute("reportMessage", "通報が完了しました");
        } else {
            session.setAttribute("reportMessage", "通報に失敗しました。");
        }
 
        // 掲示板トップへリダイレクト
        response.sendRedirect(request.getContextPath()
                + "/scoremanager/main/RetrievePosts.action");
    }
}