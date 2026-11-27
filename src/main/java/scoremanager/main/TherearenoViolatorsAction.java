
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


        // 通報対象ユーザーID
        String userId = request.getParameter("reported_user_id");

        // 通報内容ID
        String contentId = request.getParameter("report_content_id");

        System.out.println("通報対象ユーザーID：" + userId);
        System.out.println("通報内容ID：" + contentId);


        if (userId == null || !userId.matches("[0-9]+")) {
            response.sendRedirect(
                request.getContextPath()
                + "/scoremanager/main/SingleScreenDisplay.action"
            );
            return;
        }

        int reportedUserId;

        try {
            reportedUserId = Integer.parseInt(userId);
        } catch (NumberFormatException e) {
            response.sendRedirect(
                request.getContextPath()
                + "/scoremanager/main/SingleScreenDisplay.action"
            );
            return;
        }



        if (contentId == null || !contentId.matches("[1-3]")) {
            response.sendRedirect(
                request.getContextPath()
                + "/scoremanager/main/SingleScreenDisplay.action"
            );
            return;
        }

        int reportContentId = Integer.parseInt(contentId);


        ReportDao dao = new ReportDao();

        List<Report> reports = dao.selectByUserId(reportedUserId);

        request.setAttribute("reports", reports);
        request.setAttribute("reportedUserId", reportedUserId);
        request.setAttribute("reportContentId", reportContentId);


        request.getRequestDispatcher(
            "/scoremanager/main/report_details.jsp"
        ).forward(request, response);
    }
}
