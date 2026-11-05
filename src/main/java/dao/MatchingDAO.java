package dao;
 
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.Matching;
import bean.User;
 
public class MatchingDAO extends Dao {
 
    // マッチングを登録
    public int insert(Matching matching) {
 
        int count = 0;
 
        String sql =
            "INSERT INTO MATCHINGS " +
            "(action_user_id, target_user_id) " +
            "VALUES (?, ?)";
 
        try (
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {
 
            // マッチングした2人のIDを設定
            ps.setInt(1, matching.getAction_user_id());
            ps.setInt(2, matching.getTarget_user_id());
 
            // データベースに登録
            count = ps.executeUpdate();
 
        } catch (Exception e) {
 
            // エラーの詳細をコンソールに表示
            e.printStackTrace();
 
            throw new RuntimeException(
                "マッチング登録に失敗しました。", e
            );
        }
 
        return count;
    }
 
 
    // マッチング中のユーザー一覧を取得
    public List<User> selectMatchingUsers(int loginUserId) {
 
        List<User> matchingList = new ArrayList<>();
 
        String sql =
            "SELECT u.user_id, u.user_name, u.prefecture " +
            "FROM MATCHINGS m " +
            "JOIN USERS u ON " +
            "(m.ACTION_USER_ID = ? AND u.user_id = m.TARGET_USER_ID) " +
            "OR " +
            "(m.TARGET_USER_ID = ? AND u.user_id = m.ACTION_USER_ID)";
 
        try (
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {
 
            ps.setInt(1, loginUserId);
            ps.setInt(2, loginUserId);
 
            try (ResultSet rs = ps.executeQuery()) {
 
                while (rs.next()) {
 
                    User user = new User();
 
                    user.setUser_id(rs.getInt("user_id"));
                    user.setUser_name(rs.getString("user_name"));
                    user.setPrefecture(rs.getString("prefecture"));
 
                    matchingList.add(user);
                }
            }
 
        } catch (Exception e) {
 
            e.printStackTrace();
 
            throw new RuntimeException(
                "マッチング中ユーザーの取得に失敗しました。", e
            );
        }
 
        return matchingList;
    }
 
}