package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import bean.User;

public class UserDao extends Dao {

    public User select(String password, String user_name)
            throws Exception {

        User user = null;

        String sql = "select * from user where password=? and user_name=?";

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
}