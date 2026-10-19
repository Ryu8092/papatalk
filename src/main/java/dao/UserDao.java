package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import bean.User;

public class UserDao extends Dao {

    // ログイン確認
    public User select(String password, String user_name)
            throws Exception {

        User user = null;

        String sql = "select * from users where password=? and user_name=?";

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {

            st.setString(1, password);
            st.setString(2, user_name);

            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    user = new User();
                    user.setPassword(rs.getString("password"));
                    user.setUser_name(rs.getString("user_name"));

                    return user;
                }
            }
        }

        return null;
    }

    // メールアドレスの重複確認
    public User select(String email) throws Exception {

        User user = null;

        String sql = "select * from users where email=?";

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {

            st.setString(1, email);

            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    user = new User();
                    user.setEmail(rs.getString("email"));

                    return user;
                }
            }
        }

        return null;
    }
    public int insert(User user) throws Exception {

        String sql = "insert into users "
                + "(user_name, user_age, nickname, password, email, tel, "
                + "postal_code, prefecture, city, address1, "
                + "child_age, child_gender, user_status) "
                + "values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {

            st.setString(1, user.getUser_name());
            st.setInt(2, user.getUser_age());
            st.setString(3, user.getNickname());
            st.setString(4, user.getPassword());
            st.setString(5, user.getEmail());
            st.setString(6, user.getTel());
            st.setString(7, user.getPostal_code());
            st.setString(8, user.getPrefecture());
            st.setString(9, user.getCity());
            st.setString(10, user.getAddress1());
            st.setInt(11, user.getChild_age());
            st.setString(12, user.getChild_gender());
            st.setInt(13, 1);

            return st.executeUpdate();
        }
    }

    // アカウント削除
    public int updateStatus(String user_name) throws Exception {

        String sql = "UPDATE users SET user_status = ? WHERE user_name = ?";

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {

            st.setString(1, "deleted");
            st.setString(2, user_name);

            return st.executeUpdate();
        }
    }
}