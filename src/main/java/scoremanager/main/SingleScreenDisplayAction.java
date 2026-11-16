
package scoremanager.main;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class SingleScreenDisplayAction extends Action {

    @Override
    public void execute(HttpServletRequest request,
            HttpServletResponse response) throws Exception {

        // 通報一覧画面へ遷移
        request.getRequestDispatcher("/scoremanager/main/report_list.jsp")
               .forward(request, response);
    }
}
