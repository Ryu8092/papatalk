package papatalk.main;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class ScreenDisplayAction extends Action {

    @Override
    public void execute(HttpServletRequest request,
                        HttpServletResponse response) throws Exception {

        // ホーム画面を表示する
        request.getRequestDispatcher(
            "/papatalk/main/match_list.jsp"
        ).forward(request, response);
    }
}