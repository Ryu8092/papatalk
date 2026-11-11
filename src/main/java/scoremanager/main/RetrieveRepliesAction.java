package scoremanager.main;
 
import java.util.List;

import bean.Post;
import bean.Replies;
import bean.ReportReason;
import dao.PostDAO;
import dao.RepliesDAO;
import dao.ReportReasonDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;
 
public class RetrieveRepliesAction extends Action {
 
    @Override
    public void execute(HttpServletRequest req, HttpServletResponse res)
            throws Exception {
 
        req.setCharacterEncoding("UTF-8");
 
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            res.sendRedirect(req.getContextPath() + "/scoremanager/Login.action");
            return;
        }
 
        // セッションから通報完了メッセージがあれば取得してリクエスト属性にセットし、セッションからは削除する
        String reportMessage = (String) session.getAttribute("reportMessage");
        if (reportMessage != null) {
            req.setAttribute("reportMessage", reportMessage);
            session.removeAttribute("reportMessage");
        }
        
 
        try {
            String postIdStr = req.getParameter("post_id");
            
            if (postIdStr == null || postIdStr.isEmpty()) {
                res.sendRedirect(req.getContextPath() + "/scoremanager/main/RetrievePosts.action");
                return;
            }
 
            int postId = Integer.parseInt(postIdStr);
 
            // 投稿詳細の取得
            PostDAO postDao = new PostDAO();
            Post post = postDao.selectId(postId);
            req.setAttribute("post", post);
 
            // 返信一覧の取得
            RepliesDAO repliesDao = new RepliesDAO();
            List<Replies> replyList = repliesDao.selectByPostId(postId);
            req.setAttribute("replyList", replyList);
 
            // DBから通報理由一覧を取得してリクエストにセット
            ReportReasonDAO reportReasonDao = new ReportReasonDAO();
            
            List<ReportReason> reportReasons = reportReasonDao.getAll();
            
            req.setAttribute("reportReasons", reportReasons);
 
            req.getRequestDispatcher(
                "/scoremanager/main/replay.jsp"
            ).forward(req, res);
 
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("返信一覧の取得に失敗しました。", e);
        }
    }
}