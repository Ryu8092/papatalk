package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

public class HobbyDao extends Dao {

    // 趣味一覧を取得
    public List<String> getAllHobbies() throws Exception {

        List<String> hobbies = new ArrayList<>();

        String sql =
                "SELECT hobby_name FROM hobbies ORDER BY hobby_id";

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql);
             ResultSet rs = st.executeQuery()) {

            while (rs.next()) {
                hobbies.add(rs.getString("hobby_name"));
            }
        }

        return hobbies;
    }

    // ユーザーが選択済みの趣味を取得
    public List<String> getUserHobbies(int userId) throws Exception {

        List<String> hobbies = new ArrayList<>();

        String sql =
                "SELECT h.hobby_name "
                + "FROM user_hobbies uh "
                + "JOIN hobbies h ON uh.hobby_id = h.hobby_id "
                + "WHERE uh.user_id = ? "
                + "ORDER BY h.hobby_id";

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {

            st.setInt(1, userId);

            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    hobbies.add(rs.getString("hobby_name"));
                }
            }
        }

        return hobbies;
    }

    // 選択した趣味を保存
    public int saveUserHobbies(int userId, String[] hobbyNames)
            throws Exception {

        // 趣味の重複を除去
        Set<String> selectedHobbies = new LinkedHashSet<>();

        if (hobbyNames != null) {
            for (String name : hobbyNames) {
                if (name != null && !name.trim().isEmpty()) {
                    selectedHobbies.add(name.trim());
                }
            }
        }

        try (Connection con = getConnection()) {

            boolean oldAutoCommit = con.getAutoCommit();
            con.setAutoCommit(false);

            try {
                // 選択された趣味が登録済みか確認
                String checkSql =
                        "SELECT hobby_id FROM hobbies WHERE hobby_name = ?";

                for (String name : selectedHobbies) {
                    try (PreparedStatement st =
                            con.prepareStatement(checkSql)) {

                        st.setString(1, name);

                        try (ResultSet rs = st.executeQuery()) {
                            if (!rs.next()) {
                                throw new IllegalArgumentException(
                                        "登録されていない趣味です: " + name);
                            }
                        }
                    }
                }

                // 以前の趣味を削除
                String deleteSql =
                        "DELETE FROM user_hobbies WHERE user_id = ?";

                try (PreparedStatement st =
                        con.prepareStatement(deleteSql)) {

                    st.setInt(1, userId);
                    st.executeUpdate();
                }

                // 選択した趣味を登録
                String insertSql =
                        "INSERT INTO user_hobbies (user_id, hobby_id) "
                        + "SELECT ?, hobby_id FROM hobbies "
                        + "WHERE hobby_name = ?";

                for (String name : selectedHobbies) {
                    try (PreparedStatement st =
                            con.prepareStatement(insertSql)) {

                        st.setInt(1, userId);
                        st.setString(2, name);

                        if (st.executeUpdate() != 1) {
                            throw new IllegalStateException(
                                    "趣味を保存できませんでした: " + name);
                        }
                    }
                }

                con.commit();

                return selectedHobbies.size();

            } catch (Exception e) {
                con.rollback();
                throw e;

            } finally {
                con.setAutoCommit(oldAutoCommit);
            }
        }
    }
}