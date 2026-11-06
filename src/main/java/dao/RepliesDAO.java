package dao;
 
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.Replies;
 
public class RepliesDAO extends Dao {
 
    // 指定した投稿に対する返信を取得する
    public List<Replies> select(int postId) {
 
        List<Replies> replyList = new ArrayList<>();
 
        String sql =
            "SELECT r.REPLY_ID, r.POST_ID, r.REPLY_USER_ID, " +
            "r.CONTENT, r.CREATE_AT, u.USER_NAME " +
            "FROM REPLIES r " +
            "JOIN USERS u ON r.REPLY_USER_ID = u.USER_ID " +
            "WHERE r.POST_ID = ? " +
            "ORDER BY r.CREATE_AT ASC";
 
        try (
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setInt(1, postId);
 
            try (ResultSet rs = ps.executeQuery()) {
 
                while (rs.next()) {
 
                    Replies reply = new Replies();
 
                    reply.setReply_id(rs.getInt("REPLY_ID"));
                    reply.setPost_id(rs.getInt("POST_ID"));
                    reply.setUser_id(rs.getInt("REPLY_USER_ID"));
                    reply.setReply_content(rs.getString("CONTENT"));
                    reply.setUser_name(rs.getString("USER_NAME"));
                    reply.setReply_date(rs.getTimestamp("CREATE_AT"));
 
                    replyList.add(reply);
                }
            }
 
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
 
        return replyList;
    }
 
    // 返信を登録する
    public int insert(Replies reply) {
 
        String sql =
            "INSERT INTO REPLIES " +
            "(POST_ID, REPLY_USER_ID, CONTENT, CREATE_AT) " +
            "VALUES (?, ?, ?, CURRENT_TIMESTAMP)";
 
        try (
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {
 
            ps.setInt(1, reply.getPost_id());
            ps.setInt(2, reply.getUser_id());
            ps.setString(3, reply.getReply_content());
 
            return ps.executeUpdate();
 
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}