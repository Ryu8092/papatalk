package dao;
 
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import bean.Replies;
 
public class RepliesDAO extends Dao {
 
    public List<Replies> selectByPostId(int postId) throws Exception {
        List<Replies> list = new ArrayList<>();
        String sql = 
            "SELECT r.reply_id, r.post_id, r.reply_user_id, r.content, r.create_at, u.user_name " +
            "FROM replies r " +
            "INNER JOIN users u ON r.reply_user_id = u.user_id " +
            "WHERE r.post_id = ? " +
            "ORDER BY r.create_at ASC";
 
        try (
            Connection con = getConnection();
            PreparedStatement st = con.prepareStatement(sql)
        ) {
            st.setInt(1, postId);
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    Replies reply = new Replies();
                    reply.setReply_id(rs.getInt("REPLY_ID"));
                    reply.setPost_id(rs.getInt("POST_ID"));
                    reply.setUser_id(rs.getInt("REPLY_USER_ID"));
                    reply.setReply_content(rs.getString("CONTENT"));
                    Timestamp ts = rs.getTimestamp("CREATE_AT");
                    if (ts != null) {
                        reply.setReply_date(ts.toLocalDateTime());
                    }
                    reply.setUser_name(rs.getString("USER_NAME"));
                    list.add(reply);
                }
            }
        }
        return list;
    }
 
    public int insert(Replies reply) throws Exception {
        String sql = 
            "INSERT INTO replies (post_id, reply_user_id, content, create_at) " +
            "VALUES (?, ?, ?, CURRENT_TIMESTAMP)";
 
        try (
            Connection con = getConnection();
            PreparedStatement st = con.prepareStatement(sql)
        ) {
            st.setInt(1, reply.getPost_id());
            st.setInt(2, reply.getUser_id());
            st.setString(3, reply.getReply_content());
 
            return st.executeUpdate();
        }
    }
}