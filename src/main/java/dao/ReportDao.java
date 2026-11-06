package dao;
 
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import bean.Report;
 
public class ReportDao extends Dao {
 
    // 通報内容IDからユーザー名・通報情報を取得
    public List<Report> selectByReportContentId(
            int report_content_id) throws Exception {
 
        List<Report> list = new ArrayList<>();
 
        String sql =
        		"SELECT r.*, u.user_name, rr.report_reason_name " +
        			    "FROM reports r " +
        			    "INNER JOIN users u " +
        			    "ON r.reported_user_id = u.user_id " +
        			    "INNER JOIN report_reasons rr " +
        			    "ON r.report_reason_id = rr.report_reason_id " +
        			    "WHERE r.report_content_id = ? " +
        			    "ORDER BY r.create_at DESC";
 
        try (
            Connection con = getConnection();
            PreparedStatement st = con.prepareStatement(sql)
        ) {
 
            st.setInt(1, report_content_id);
 
            try (ResultSet rs = st.executeQuery()) {
 
                while (rs.next()) {
 
                    Report bean = new Report();
 
                    bean.setReport_id(rs.getInt("report_id"));
 
                    bean.setReporter_user_id(
                        rs.getInt("reporter_user_id"));
 
                    bean.setReported_user_id(
                        rs.getInt("reported_user_id"));
 
                    bean.setReport_reason_id(
                        rs.getInt("report_reason_id"));
 
                    bean.setContent(
                        rs.getString("content"));
 
                    Timestamp timestamp =
                        rs.getTimestamp("create_at");
 
                    if (timestamp != null) {
                        bean.setCreate_at(
                            timestamp.toLocalDateTime());
                    }
 
                    bean.setState(rs.getInt("state"));
 
                    bean.setReport_content(
                        rs.getString("report_content"));
 
                    bean.setReport_content_id(
                        rs.getInt("report_content_id"));
 
                    // ユーザー名
                    bean.setUser_name(
                        rs.getString("user_name"));
                    
                 // 通報理由名
                    bean.setReport_reason_name(
                        rs.getString("report_reason_name"));
                    
                    list.add(bean);
                }
            }
        }
 
        return list;
    }
 
 
    // ユーザーIDから通報情報・ユーザー名を取得
    public List<Report> selectByUserId(
            int user_id) throws Exception {
 
        List<Report> list = new ArrayList<>();
 
        String sql =
        		"SELECT r.*, u.user_name, rr.report_reason_name " +
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
 
                    bean.setReport_id(rs.getInt("report_id"));
 
                    bean.setReporter_user_id(
                        rs.getInt("reporter_user_id"));
 
                    bean.setReported_user_id(
                        rs.getInt("reported_user_id"));
 
                    bean.setReport_reason_id(
                        rs.getInt("report_reason_id"));
 
                    bean.setContent(
                        rs.getString("content"));
 
                    Timestamp timestamp =
                        rs.getTimestamp("create_at");
 
                    if (timestamp != null) {
                        bean.setCreate_at(
                            timestamp.toLocalDateTime());
                    }
 
                    bean.setState(rs.getInt("state"));
 
                    bean.setReport_content(
                        rs.getString("report_content"));
 
                    bean.setReport_content_id(
                        rs.getInt("report_content_id"));
 
                    // ユーザー名
                    bean.setUser_name(
                        rs.getString("user_name"));
                    
                    bean.setReport_reason_name(
                    	    rs.getString("report_reason_name"));
 
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
            "report_content_id, content, create_at, state) " +
            "VALUES (?, ?, ?, ?, ?, CURRENT_TIMESTAMP, ?)";
 
        try (
            Connection con = getConnection();
            PreparedStatement st = con.prepareStatement(sql)
        ) {
 
            st.setInt(1, bean.getReporter_user_id());
            st.setInt(2, bean.getReported_user_id());
            st.setInt(3, bean.getReport_reason_id());
            st.setInt(4, bean.getReport_content_id());
            st.setString(5, bean.getContent());
            st.setInt(6, bean.getState());
 
            return st.executeUpdate();
        }
    }
 
 
    // 商品IDから出品者（SELLER_ID）を取得する
    public int getSellerIdByProductId(int productId) throws Exception {
        int sellerId = 0;
        String sql = "SELECT SELLER_ID FROM PRODUCTS WHERE PRODUCT_ID = ?";
 
        try (
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setInt(1, productId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    sellerId = rs.getInt("SELLER_ID");
                }
            }
        }
        return sellerId;
    }
 
 
    // 指定した通報理由IDが存在するか確認する
    public boolean existsReportReason(int reasonId) throws Exception {
        boolean exists = false;
        String sql = "SELECT COUNT(*) FROM REPORT_REASONS WHERE REPORT_REASON_ID = ?";
 
        try (
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setInt(1, reasonId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    exists = rs.getInt(1) > 0;
                }
            }
        }
        return exists;
    }
 
}