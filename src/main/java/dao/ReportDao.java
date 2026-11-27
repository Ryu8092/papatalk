
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import bean.Report;
import bean.User;

public class ReportDao extends Dao {

	// 通報内容IDからユーザー情報・通報情報を取得
	// 有効なアカウント（user_status = 0）のみ取得
	public List<Report> selectByReportContentId(int report_content_id)
	        throws Exception {

	    List<Report> list = new ArrayList<>();

	    String sql =
	        "SELECT r.*, " +
	        "u.user_name, " +
	        "u.user_status, " +
	        "rr.report_reason_name " +
	        "FROM reports r " +
	        "INNER JOIN users u " +
	        "ON r.reported_user_id = u.user_id " +
	        "INNER JOIN report_reasons rr " +
	        "ON r.report_reason_id = rr.report_reason_id " +
	        "WHERE r.report_content_id = ? " +
	        "AND u.user_status = 0 " +
	        "AND r.state = 0 " +
	        "ORDER BY r.create_at DESC";

	    try (Connection con = getConnection();
	         PreparedStatement st = con.prepareStatement(sql)) {

	        st.setInt(1, report_content_id);

	        try (ResultSet rs = st.executeQuery()) {

	            while (rs.next()) {

	                Report bean = new Report();

	                bean.setReport_id(rs.getInt("report_id"));
	                bean.setReporter_user_id(rs.getInt("reporter_user_id"));
	                bean.setReported_user_id(rs.getInt("reported_user_id"));
	                bean.setReport_reason_id(rs.getInt("report_reason_id"));
	                bean.setContent(rs.getString("content"));

	                Timestamp timestamp = rs.getTimestamp("create_at");
	                bean.setCreate_at(timestamp);

	                bean.setState(rs.getInt("state"));
	                bean.setReport_content(rs.getString("report_content"));
	                bean.setReport_content_id(rs.getInt("report_content_id"));
	                bean.setReport_reason_name(rs.getString("report_reason_name"));

	                User user = new User();
	                user.setUser_id(rs.getInt("reported_user_id"));
	                user.setUser_name(rs.getString("user_name"));
	                user.setUser_status(rs.getInt("user_status"));

	                bean.setUser(user);

	                list.add(bean);
	            }
	        }
	    }

	    return list;
	}


    // ユーザーIDからおさがりの商品・チャットの通報情報を取得
    // 停止済みユーザーも詳細確認できるようにする
    public List<Report> selectByUserId(
            int user_id) throws Exception {

        List<Report> list = new ArrayList<>();

        String sql =
        	    "SELECT r.*, " +
        	    "u.user_name, " +
        	    "u.user_status, " +
        	    "rr.report_reason_name " +
        	    "FROM reports r " +
        	    "INNER JOIN users u " +
        	    "ON r.reported_user_id = u.user_id " +
        	    "INNER JOIN report_reasons rr " +
        	    "ON r.report_reason_id = rr.report_reason_id " +
        	    "WHERE r.reported_user_id = ? " +
        	    "ORDER BY r.create_at DESC";

        try (
            Connection con = getConnection();
            PreparedStatement st = con.prepareStatement(sql)
        ) {
            st.setInt(1, user_id);

            try (ResultSet rs = st.executeQuery()) {

                while (rs.next()) {

                    Report bean = new Report();

                    bean.setReport_id(
                        rs.getInt("report_id"));

                    bean.setReporter_user_id(
                        rs.getInt("reporter_user_id"));

                    bean.setReported_user_id(
                        rs.getInt("reported_user_id"));

                    bean.setReport_reason_id(
                        rs.getInt("report_reason_id"));

                    bean.setContent(
                        rs.getString("content"));

                    // Timestamp型で取得
                    Timestamp timestamp =
                        rs.getTimestamp("create_at");

                    bean.setCreate_at(timestamp);

                    bean.setState(
                        rs.getInt("state"));

                    bean.setReport_content(
                        rs.getString("report_content"));

                    bean.setReport_content_id(
                        rs.getInt("report_content_id"));

                    bean.setReport_reason_name(
                        rs.getString("report_reason_name"));

                    // ユーザー情報
                    User user = new User();

                    user.setUser_id(
                        rs.getInt("reported_user_id"));

                    user.setUser_name(
                        rs.getString("user_name"));

                    user.setUser_status(
                        rs.getInt("user_status"));

                    bean.setUser(user);

                    list.add(bean);
                }
            }
        }

        return list;
    }


    // 通報情報を登録
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


    // 投稿IDから投稿者のユーザーIDを取得
    public int getUserIdByPostId(int postId) throws Exception {

        int userId = 0;

        String sql =
            "SELECT POST_USER_ID FROM POSTS WHERE POST_ID = ?";

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


    // 返信IDから返信者のユーザーIDを取得
    public int getUserIdByReplyId(int replyId) throws Exception {

        int userId = 0;

        String sql =
            "SELECT REPLY_USER_ID FROM REPLIES WHERE REPLY_ID = ?";

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
