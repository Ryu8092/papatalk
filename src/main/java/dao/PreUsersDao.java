
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import bean.PreUsers;

public class PreUsersDao extends Dao {

    // 仮登録情報を追加
    public int insert(String email, int random_code) throws Exception {

        String sql = "INSERT INTO pre_users (email, random_code, create_at) "
                   + "VALUES (?, ?, CURRENT_TIMESTAMP)";

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {

            st.setString(1, email);
            st.setInt(2, random_code);

            return st.executeUpdate();
        }
    }

    // 仮登録情報を削除
    public int delete(PreUsers preUsers) throws Exception {

        String sql = "DELETE FROM pre_users WHERE email = ?";

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {

            st.setString(1, preUsers.getEmail());

            return st.executeUpdate();
        }
    }
    
 // 仮登録情報を認証コードで検索
    public PreUsers select(int random_code) throws Exception {

        PreUsers preUsers = null;

        String sql = "SELECT * FROM pre_users WHERE random_code = ?";

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {

            st.setInt(1, random_code);

            try (ResultSet rs = st.executeQuery()) {

                if (rs.next()) {
                    preUsers = new PreUsers();
                    preUsers.setEmail(rs.getString("email"));
                    preUsers.setRandom_code(rs.getInt("random_code"));
                    preUsers.setCreate_at(rs.getTimestamp("create_at"));
                }
            }
        }

        return preUsers;
    }
}
