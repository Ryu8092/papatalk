
package scoremanager.main;

import java.util.List;

import bean.Report;
import dao.ReportDao;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class TherearenoViolatorsAction extends Action {

    @Override
    public void execute(HttpServletRequest request,
                        HttpServletResponse response)
            throws Exception {

        // 違反者のユーザーIDを取得
        String userId = request.getParameter("reported_user_id");

        // 通報内容IDを取得
        String contentId = request.getParameter("report_content_id");

        System.out.println("通報対象ユーザーID：" + userId);
        System.out.println("通報内容ID：" + contentId);

        // ユーザーIDの入力確認
        if (userId == null || !userId.matches("[0-9]+")) {
            response.sendRedirect("SingleScreenDisplay.action");
            return;
        }

        int reportedUserId;

        try {
            reportedUserId = Integer.parseInt(userId);
        } catch (NumberFormatException e) {
            response.sendRedirect("SingleScreenDisplay.action");
            return;
        }

        // 通報内容IDの入力確認
        if (contentId == null || !contentId.matches("[1-3]")) {
            response.sendRedirect("SingleScreenDisplay.action");
            return;
        }

        int reportContentId = Integer.parseInt(contentId);

        // DAOから通報詳細を取得
        ReportDao dao = new ReportDao();

        List<Report> reports = dao.selectByUserId(reportedUserId);

        // JSPに渡す
        request.setAttribute("reports", reports);
        request.setAttribute("reportedUserId", reportedUserId);
        request.setAttribute("reportContentId", reportContentId);

        // 詳細画面へ
        request.getRequestDispatcher(
            "/scoremanager/main/report_details.jsp"
        ).forward(request, response);
    }
}
