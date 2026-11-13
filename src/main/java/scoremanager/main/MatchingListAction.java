package scoremanager.main;

import java.util.List;

import bean.Matching;
import bean.MatchingChat;
import bean.User;
import dao.MatchingChatDAO;
import dao.MatchingDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class MatchingListAction extends Action {

    @Override
    public void execute(HttpServletRequest req, HttpServletResponse res)
            throws Exception {

        req.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession(false);

        // ログイン確認
        if (session == null || session.getAttribute("user") == null) {
            res.sendRedirect(
                req.getContextPath() + "/scoremanager/Login.action"
            );
            return;
        }

        User user = (User) session.getAttribute("user");
        int loginUserId = user.getUser_id();

        try {

            MatchingDAO matchingDAO = new MatchingDAO();
            MatchingChatDAO chatDAO = new MatchingChatDAO();

            // マッチング相手の一覧を取得
            List<Matching> matchingList =
                matchingDAO.select(loginUserId);

            // 相手ごとの最新メッセージを取得
            for (Matching matching : matchingList) {

                MatchingChat latestChat =
                    chatDAO.selectLatest(matching.getMatch_id());

                // 最新メッセージをMatchingBeanに設定
                if (latestChat != null) {
                    matching.setLatestContent(latestChat.getContent());
                    matching.setLatestCreateAt(latestChat.getCreate_at());
                    matching.setLatestSenderName(latestChat.getUser_name());
            
                }
            }

            req.setAttribute("matchingList", matchingList);
            req.setAttribute("user", user);

            req.getRequestDispatcher(
                "/scoremanager/main/chat_list.jsp"
            ).forward(req, res);

        } catch (Exception e) {

            e.printStackTrace();

            throw new ServletException(
                "マッチング中一覧の表示に失敗しました。", e
            );
        }
    }
}