package dao;
 
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import bean.Report;
 
public class ReportDao extends Dao {
 
    // シーケンス図通り：insert[ReportBean] に対応するメソッド
    public int insert(Report bean) throws Exception {
    	String sql =
	        "INSERT INTO reports " +
	        "(reporter_user_id, reported_user_id, report_reason_id, " +
	        "report_content_id, report_content, content, create_at, state) " +
	        "VALUES (?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP, ?)";

	    try (
	        Connection con = getConnection();
	        PreparedStatement st = con.prepareStatement(sql)
	    ) {
	        st.setInt(1, bean.getReporter_user_id());
	        st.setInt(2, bean.getReported_user_id());
	        st.setInt(3, bean.getReport_reason_id());
	        st.setInt(4, bean.getReport_content_id());
	        st.setString(5, bean.getReport_content());
	        st.setString(6, bean.getContent());
	        st.setInt(7, bean.getState());

	        return st.executeUpdate();
	    }
	}
 
    // 投稿IDから投稿者のユーザーIDを取得するメソッド
    public int getUserIdByPostId(int postId) throws Exception {
        int userId = 0;
        String sql = "SELECT POST_USER_ID FROM POSTS WHERE POST_ID = ?";
 
        try (
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setInt(1, postId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    userId = rs.getInt("POST_USER_ID");
                }
            }
        }
        return userId;
    }
 
    // 返信IDから返信者のユーザーIDを取得するメソッド
    public int getUserIdByReplyId(int replyId) throws Exception {
        int userId = 0;
        String sql = "SELECT REPLY_USER_ID FROM REPLIES WHERE REPLY_ID = ?";
 
        try (
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setInt(1, replyId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    userId = rs.getInt("REPLY_USER_ID");
                }
            }
        }
        return userId;
    }
}