package dao;
 
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.Matching;
 
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
    public List<Matching> select(int loginUserId) {

        List<Matching> matchingList = new ArrayList<>();

        String sql =
            "SELECT m.MATCH_ID, u.USER_NAME " +
            "FROM MATCHINGS m " +
            "JOIN USERS u ON " +
            "(m.ACTION_USER_ID = ? AND u.USER_ID = m.TARGET_USER_ID) " +
            "OR " +
            "(m.TARGET_USER_ID = ? AND u.USER_ID = m.ACTION_USER_ID)";

        try (
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, loginUserId);
            ps.setInt(2, loginUserId);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    Matching matching = new Matching();

                    matching.setMatch_id(rs.getInt("MATCH_ID"));
                    matching.setUser_name(rs.getString("USER_NAME"));

                    matchingList.add(matching);
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

	public boolean existsMatching(int matchId, int userId) {
	
	    String sql =
	        "SELECT COUNT(*) FROM MATCHINGS " +
	        "WHERE MATCH_ID = ? " +
	        "AND (ACTION_USER_ID = ? OR TARGET_USER_ID = ?)";
	
	    try (
	        Connection con = getConnection();
	        PreparedStatement ps = con.prepareStatement(sql)
	    ) {
	        ps.setInt(1, matchId);
	        ps.setInt(2, userId);
	        ps.setInt(3, userId);
	
	        try (ResultSet rs = ps.executeQuery()) {
	            rs.next();
	            return rs.getInt(1) > 0;
	        }
	
	    } catch (Exception e) {
	        e.printStackTrace();
	        throw new RuntimeException("マッチング確認に失敗しました。", e);
	    }
	}

 
}