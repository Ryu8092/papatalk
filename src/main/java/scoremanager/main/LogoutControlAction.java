package scoremanager.main;
 
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;
 
public class LogoutControlAction extends Action {
 
    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
    	String action = request.getParameter("action");
    	if ("ログアウトする".equals(action)) {
    		// セッションを破棄（ログアウト）
            request.getSession().invalidate();
            // ログアウト完了画面へフォワード
            request.getRequestDispatcher("logout_complete.jsp").forward(request, response);
    	}else if ("戻る".equals(action)) {
    		request.getRequestDispatcher("match_list.jsp").forward(request, response);
    	}   
    }
}