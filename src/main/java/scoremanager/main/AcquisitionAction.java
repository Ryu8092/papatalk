
package scoremanager.main;

import java.util.List;

import bean.Report;
import dao.ReportDao;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class AcquisitionAction extends Action {

    @Override
    public void execute(
            HttpServletRequest request,
            HttpServletResponse response) throws Exception {

        // ボタンから送られた通報内容IDを取得
        String id = request.getParameter("report_content_id");

        // IDの入力確認
        if (id == null || id.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        int reportContentId;

        try {
            reportContentId = Integer.parseInt(id);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        // 通報内容IDの確認（1～3のみ許可）
        if (reportContentId < 1 || reportContentId > 3) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        // ReportDaoを使用して通報情報を取得
        ReportDao dao = new ReportDao();

        List<Report> reports =
                dao.selectByReportContentId(reportContentId);
        System.out.println(reports);
        // デバッグ用
        System.out.println("通報内容ID：" + reportContentId);
        System.out.println("通報件数：" + reports.size());

        // JSPにデータを渡す
        request.setAttribute("reports", reports);
        request.setAttribute("reportContentId", reportContentId);

        // 通報内容IDに応じてタイトルを設定
        String title;

        switch (reportContentId) {
            case 1:
                title = "マッチング";
                break;

            case 2:
                title = "掲示板";
                break;

            case 3:
                title = "おさがり譲渡";
                break;

            default:
                title = "通報一覧";
                break;
        }

        request.setAttribute("title", title);

        // 違反者一覧画面へ遷移
        request.getRequestDispatcher(
                "/scoremanager/main/violator_list.jsp"
        ).forward(request, response);
    }
}
