package scoremanager.main;
 
import java.util.ArrayList;
import java.util.List;

import bean.Post;
import bean.ReportReason;
import dao.PostDAO;
import dao.ReportReasonDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;
 
public class RetrievePostsAction extends Action {
 
    @Override
    public void execute(HttpServletRequest req, HttpServletResponse res)
            throws Exception {
 
        req.setCharacterEncoding("UTF-8");
 
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            res.sendRedirect(req.getContextPath() + "/scoremanager/Login.action");
            return;
        }
 
        // セッションに保存されている通報完了メッセージがあれば取得してリクエスト属性にセットし、セッションからは削除する
        String reportMessage = (String) session.getAttribute("reportMessage");
        if (reportMessage != null) {
            req.setAttribute("reportMessage", reportMessage);
            session.removeAttribute("reportMessage");
        }
 
        try {
            PostDAO dao = new PostDAO();
            List<Post> allPosts = dao.getAll();
            List<Post> postList = new ArrayList<>();
 
            for (Post post : allPosts) {
                if (post.getView_limit() != null
                        && post.getView_limit().getTime() < System.currentTimeMillis()) {
                    continue;
                }
                postList.add(post);
            }
 
            req.setAttribute("postList", postList);
 
            // DBから通報理由一覧を取得してリクエスト属性にセット
            ReportReasonDAO reportReasonDao = new ReportReasonDAO();
            List<ReportReason> reportReasons = reportReasonDao.getAll();
            req.setAttribute("reportReasons", reportReasons);
 
            // シーケンス図通りのforward処理
            req.getRequestDispatcher(
                "/scoremanager/main/bulletinboard_top.jsp"
            ).forward(req, res);
 
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("掲示板の投稿一覧の取得に失敗しました。", e);
        }
    }
}