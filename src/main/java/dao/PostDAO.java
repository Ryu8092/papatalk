package dao;
 
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.Post;
 
public class PostDAO extends Dao {
 
    // 投稿一覧をすべて取得する
    public List<Post> getAll() {
 
        List<Post> list = new ArrayList<>();
 
        String sql =
            "SELECT " +
            "p.POST_ID, " +
            "p.POST_USER_ID, " +
            "p.TITLE, " +
            "p.CONTENT, " +
            "p.CREATE_AT, " +
            "u.USER_NAME " +
            "FROM POSTS p " +
            "JOIN USERS u ON p.POST_USER_ID = u.USER_ID " +
            "ORDER BY p.CREATE_AT DESC";
 
        try (
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()
        ) {
 
            while (rs.next()) {
 
                Post post = new Post();
 
                post.setPost_id(rs.getInt("POST_ID"));
                post.setUser_id(rs.getInt("POST_USER_ID"));
                post.setPost_title(rs.getString("TITLE"));
                post.setPost_content(rs.getString("CONTENT"));
                post.setUser_name(rs.getString("USER_NAME"));
                post.setPost_date(rs.getTimestamp("CREATE_AT"));
 
                // 現在のPOSTSテーブルにはVIEW_LIMITがないため設定しない
 
                list.add(post);
            }
 
        } catch (Exception e) {
 
            e.printStackTrace();
 
            throw new RuntimeException(
                "投稿一覧の取得に失敗しました。",
                e
            );
        }
 
        return list;
    }
 
 
    // 新しい投稿を登録する
    public int insert(Post post) {
 
        int count = 0;
 
        String sql =
            "INSERT INTO POSTS " +
            "(POST_USER_ID, TITLE, CONTENT, CREATE_AT) " +
            "VALUES (?, ?, ?, CURRENT_TIMESTAMP)";
 
        try (
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {
 
            // 投稿者のユーザーID
            ps.setInt(1, post.getUser_id());
 
            // 投稿タイトル
            ps.setString(2, post.getPost_title());
 
            // 投稿内容
            ps.setString(3, post.getPost_content());
 
            // データベースに登録
            count = ps.executeUpdate();
 
        } catch (Exception e) {
 
            e.printStackTrace();
 
            throw new RuntimeException(
                "投稿の登録に失敗しました。",
                e
            );
        }
 
        return count;
    }
 
 
    // ログイン中のユーザーの投稿履歴を取得する
    public List<Post> select(int user_id) {
 
        List<Post> list = new ArrayList<>();
 
        String sql =
            "SELECT " +
            "POST_ID, " +
            "POST_USER_ID, " +
            "TITLE, " +
            "CONTENT, " +
            "CREATE_AT " +
            "FROM POSTS " +
            "WHERE POST_USER_ID = ? " +
            "ORDER BY CREATE_AT DESC";
 
        try (
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {
 
            // ログイン中のユーザーIDを指定
            ps.setInt(1, user_id);
 
            try (ResultSet rs = ps.executeQuery()) {
 
                while (rs.next()) {
 
                    Post post = new Post();
 
                    post.setPost_id(rs.getInt("POST_ID"));
                    post.setUser_id(rs.getInt("POST_USER_ID"));
                    post.setPost_title(rs.getString("TITLE"));
                    post.setPost_content(rs.getString("CONTENT"));
                    post.setPost_date(rs.getTimestamp("CREATE_AT"));
 
                    list.add(post);
                }
            }
 
        } catch (Exception e) {
 
            e.printStackTrace();
 
            throw new RuntimeException(
                "投稿履歴の取得に失敗しました。",
                e
            );
        }
 
        return list;
    }
 
}