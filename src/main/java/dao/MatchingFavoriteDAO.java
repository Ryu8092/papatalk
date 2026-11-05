package dao;
 
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.MatchingFavorite;
import bean.User;
 
public class MatchingFavoriteDAO extends Dao {
 
    // お気に入りパパ一覧を取得
    public List<User> select(int loginUserId) {
 
        List<User> favoriteList = new ArrayList<>();
 
        String sql =
            "SELECT u.user_id, u.user_name, u.prefecture " +
            "FROM MATCHING_FAVORITES f " +
            "JOIN USERS u ON f.TARGET_USER_ID = u.user_id " +
            "WHERE f.ACTION_USER_ID = ?";
 
        try (
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {
 
            ps.setInt(1, loginUserId);
 
            try (ResultSet rs = ps.executeQuery()) {
 
                while (rs.next()) {
 
                    User user = new User();
 
                    user.setUser_id(rs.getInt("user_id"));
                    user.setUser_name(rs.getString("user_name"));
                    user.setPrefecture(rs.getString("prefecture"));
 
                    favoriteList.add(user);
                }
            }
 
        } catch (Exception e) {
            e.printStackTrace();
        }
 
        return favoriteList;
    }
 
 
    // お気に入りを登録
    public int insert(MatchingFavorite bean) {
 
        int count = 0;
 
        String sql =
            "INSERT INTO MATCHING_FAVORITES " +
            "(ACTION_USER_ID, TARGET_USER_ID) " +
            "SELECT ?, ? " +
            "WHERE NOT EXISTS (" +
            "    SELECT 1 FROM MATCHING_FAVORITES " +
            "    WHERE ACTION_USER_ID = ? " +
            "    AND TARGET_USER_ID = ?" +
            ")";
 
        try (
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {
 
            int actionUserId = bean.getAction_user_id();
            int targetUserId = bean.getTarget_user_id();
 
            ps.setInt(1, actionUserId);
            ps.setInt(2, targetUserId);
            ps.setInt(3, actionUserId);
            ps.setInt(4, targetUserId);
 
            count = ps.executeUpdate();
 
        } catch (Exception e) {
            e.printStackTrace();
        }
 
        return count;
    }
 
 
// アクション側のお気に入りを削除
    public int deleteAction(int actionUserId, int targetUserId) {
 
        int count = 0;
 
        String sql =
            "DELETE FROM MATCHING_FAVORITES " +
            "WHERE ACTION_USER_ID = ? " +
            "AND TARGET_USER_ID = ?";
 
        try (
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setInt(1, actionUserId);
            ps.setInt(2, targetUserId);
 
            count = ps.executeUpdate();
 
        } catch (Exception e) {
            e.printStackTrace();
        }
 
        return count;
    }
// ターゲット側のお気に入りを削除
    public int deleteTarget(int actionUserId, int targetUserId) {
 
        int count = 0;
 
        String sql =
            "DELETE FROM MATCHING_FAVORITES " +
            "WHERE ACTION_USER_ID = ? " +
            "AND TARGET_USER_ID = ?";
 
        try (
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setInt(1, targetUserId);
            ps.setInt(2, actionUserId);
 
            count = ps.executeUpdate();
 
        } catch (Exception e) {
            e.printStackTrace();
        }
 
        return count;
    }
 
    // 自分をお気に入り登録した人の一覧を取得
    public List<User> selectNotifications(int targetUserId) {
 
        List<User> notificationList = new ArrayList<>();
 
        String sql =
            "SELECT u.user_id, u.user_name, u.prefecture " +
            "FROM MATCHING_FAVORITES f " +
            "JOIN USERS u ON f.ACTION_USER_ID = u.user_id " +
            "WHERE f.TARGET_USER_ID = ?";
 
        try (
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {
 
            ps.setInt(1, targetUserId);
 
            try (ResultSet rs = ps.executeQuery()) {
 
                while (rs.next()) {
 
                    User user = new User();
 
                    user.setUser_id(rs.getInt("user_id"));
                    user.setUser_name(rs.getString("user_name"));
                    user.setPrefecture(rs.getString("prefecture"));
 
                    notificationList.add(user);
                }
            }
 
        } catch (Exception e) {
            e.printStackTrace();
        }
 
        return notificationList;
    }
}