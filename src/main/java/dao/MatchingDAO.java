package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

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

            ps.setInt(1, matching.getAction_user_id());
            ps.setInt(2, matching.getTarget_user_id());

            count = ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return count;
    }
}