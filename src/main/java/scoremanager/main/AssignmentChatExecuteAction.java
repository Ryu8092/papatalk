package scoremanager.main;
 
import bean.OsagariChat;
import bean.User;
import dao.OsagariChatDao;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;
 
public class AssignmentChatExecuteAction extends Action {
 
    @Override
    public void execute(HttpServletRequest request,
                        HttpServletResponse response) throws Exception {
 
        // ログインユーザーを取得
        User user = (User) request.getSession().getAttribute("user");
 
        HttpSession session = request.getSession(false);
        
        // ログイン確認
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("Login.action");
            return;
        }
 
        // 文字コードを設定
        request.setCharacterEncoding("UTF-8");
 
        // 商品IDを取得
        String id = request.getParameter("product_id");
 
        if (id == null || id.isEmpty()) {
            throw new Exception("商品IDが指定されていません。");
        }
 
        int productId = Integer.parseInt(id);
 
        // メッセージを取得
        String content = request.getParameter("content");
 
        if (content == null || content.trim().isEmpty()) {
            throw new Exception("メッセージを入力してください。");
        }
 
        if (content.trim().length() > 500) {
            throw new Exception("メッセージは500文字以内で入力してください。");
        }
 
        // チャット情報を作成
        OsagariChat chat = new OsagariChat();
 
        chat.setBuyer_id(user.getUser_id());
        chat.setProduct_id(productId);
        chat.setSender_id(user.getUser_id());
        chat.setContent(content.trim());
 
        // データベースに保存
        OsagariChatDao dao = new OsagariChatDao();
        dao.insert(chat);
 
        // チャット画面へ戻る
        response.sendRedirect(
            request.getContextPath()
            + "/scoremanager/main/AssignmentChat.action?product_id="
            + productId
        );
    }
}