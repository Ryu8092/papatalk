package dao;
 
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import bean.User;
 
public class UserDao extends Dao {
	
 
	// ログイン確認
    public User select(String password, String user_name)
            throws Exception {
        User user = null;
        String sql = "SELECT * FROM users "
                + "WHERE password = ? "
                + "AND user_name = ? "
                + "AND user_status != 1";
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            st.setString(1, password);
            st.setString(2, user_name);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    user = new User();
                    
                    user.setUser_id(rs.getInt("user_id"));
                    user.setUser_name(rs.getString("user_name"));
                    user.setUser_age(rs.getInt("user_age"));
                    user.setNickname(rs.getString("nickname"));
                    user.setPassword(rs.getString("password"));
                    user.setEmail(rs.getString("email"));
                    user.setTel(rs.getString("tel"));
                    user.setPostal_code(rs.getString("postal_code"));
                    user.setPrefecture(rs.getString("prefecture"));
                    user.setCity(rs.getString("city"));
                    user.setAddress1(rs.getString("address1"));
                    user.setAddress2(rs.getString("address2"));
                    user.setChild_age(rs.getInt("child_age"));
                    user.setChild_gender(rs.getString("child_gender"));
                    user.setUser_status(rs.getInt("user_status"));
                    user.setComment(rs.getString("comment"));
                    return user;
                }
            }
        }
        return null;
    }
 
    // 新規登録用：メールアドレスの重複確認
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
 

    // 新規登録
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
            st.setInt(13, 0);
 
            return st.executeUpdate();
        }
    }
    
    // アカウント削除
    public int updateStatus(int user_id) throws Exception {
 
        String sql = "UPDATE users SET user_status = ? WHERE user_id = ?";
 
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
 
            st.setInt(1,1);
            st.setInt(2, user_id);
 
            return st.executeUpdate();
        }
    }
    // アカウント情報の更新
    public int update(User user) throws Exception {
 
        String sql = "UPDATE users SET "
                + "user_name = ?, "
                + "user_age = ?, "
                + "nickname = ?, "
                + "password = ?, "
                + "email = ?, "
                + "tel = ?, "
                + "postal_code = ?, "
                + "prefecture = ?, "
                + "city = ?, "
                + "address1 = ?, "
                + "address2 = ?, "
                + "child_age = ?, "
                + "child_gender = ? "
                + "WHERE user_id = ?";
 
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
            st.setString(11, user.getAddress2());
            st.setInt(12, user.getChild_age());
            st.setString(13, user.getChild_gender());
            st.setInt(14, user.getUser_id());
 
            return st.executeUpdate();
        }
    }
 
    // 都道府県から自分以外のユーザーを取得
    public List<User> selectByPrefecture(
            String prefecture, int loginUserId) throws Exception {
 
        List<User> list = new ArrayList<>();
 
        String sql = "SELECT user_id, prefecture FROM users "
                + "WHERE prefecture = ? AND user_id <> ?";
 
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
 
            st.setString(1, prefecture);
            st.setInt(2, loginUserId);
 
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    User user = new User();
                    user.setUser_id(rs.getInt("user_id"));
                    user.setPrefecture(rs.getString("prefecture"));
                    list.add(user);
                }
            }
        }
        return list;
    }
 
    // マッチング設定の条件でユーザーを検索
    public List<User> select(
            String childAge,
            String fatherAge,
            String prefecture,
            int loginUserId) throws Exception {
 
        List<User> list = new ArrayList<>();
 
        StringBuilder sql = new StringBuilder(
                "SELECT user_id, user_name, user_age, child_age, prefecture "
                + "FROM users "
                + "WHERE user_id <> ? "
                + "AND user_status = 1");
 
        List<Object> params = new ArrayList<>();
        params.add(loginUserId);
 
        // 子供の年齢
        if (childAge != null && !childAge.isEmpty()) {
            sql.append(" AND child_age = ?");
            params.add(Integer.parseInt(childAge));
        }
 
        // パパの年齢
        if (fatherAge != null && !fatherAge.isEmpty()) {
            if ("20代".equals(fatherAge)) {
                sql.append(" AND user_age BETWEEN 20 AND 29");
            } else if ("30代".equals(fatherAge)) {
                sql.append(" AND user_age BETWEEN 30 AND 39");
            } else if ("40代".equals(fatherAge)) {
                sql.append(" AND user_age BETWEEN 40 AND 49");
            } else if ("50代以上".equals(fatherAge)) {
                sql.append(" AND user_age >= 50");
            }
        }
 
        // 都道府県
        if (prefecture != null && !prefecture.isEmpty()
                && !"指定なし".equals(prefecture)) {
            sql.append(" AND prefecture = ?");
            params.add(prefecture);
        }
 
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql.toString())) {
 
            for (int i = 0; i < params.size(); i++) {
                st.setObject(i + 1, params.get(i));
            }
 
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    User user = new User();
                    user.setUser_id(rs.getInt("user_id"));
                    user.setUser_name(rs.getString("user_name"));
                    user.setUser_age(rs.getInt("user_age"));
                    user.setChild_age(rs.getInt("child_age"));
                    user.setPrefecture(rs.getString("prefecture"));
                    list.add(user);
                }
            }
        }
 
        return list;
    }
 
 
    // マッチング設定の条件でユーザーを検索
    public List<User> select(
            String childAge,
            String fatherAge,
            String region,
            String destination,
            String hobbies,
            int loginUserId) throws Exception {
 
        List<User> list = new ArrayList<>();
 
        StringBuilder sql = new StringBuilder(
                "SELECT DISTINCT users.user_id, users.user_name, "
                + "users.user_age, users.child_age, users.prefecture "
                + "FROM users "
                + "WHERE users.user_id <> ? "
                + "AND users.user_status = 0");
 
        List<Object> params = new ArrayList<>();
        params.add(loginUserId);
 
        // 子どもの年齢
        if (childAge != null && !childAge.isEmpty()
                && childAge.matches("\\d+")) {
            sql.append(" AND users.child_age = ?");
            params.add(Integer.parseInt(childAge));
        }
 
        // パパの年齢
        if (fatherAge != null && !fatherAge.isEmpty()) {
            if ("20代".equals(fatherAge)) {
                sql.append(" AND users.user_age BETWEEN 20 AND 29");
            } else if ("30代".equals(fatherAge)) {
                sql.append(" AND users.user_age BETWEEN 30 AND 39");
            } else if ("40代".equals(fatherAge)) {
                sql.append(" AND users.user_age BETWEEN 40 AND 49");
            } else if ("50代以上".equals(fatherAge)) {
                sql.append(" AND users.user_age >= 50");
            }
        }
 
        // お住まいの地域で絞り込む
        if (region != null && !region.isEmpty()
                && !"指定なし".equals(region)) {
 
            String[] prefectures = null;
 
            if ("北海道".equals(region)) {
                prefectures = new String[]{"北海道"};
 
            } else if ("東北".equals(region)) {
                prefectures = new String[]{
                    "青森県", "岩手県", "宮城県",
                    "秋田県", "山形県", "福島県"
                };
 
            } else if ("関東".equals(region)) {
                prefectures = new String[]{
                    "東京都", "神奈川県", "埼玉県",
                    "千葉県", "茨城県", "栃木県", "群馬県"
                };
 
            } else if ("中部".equals(region)) {
                prefectures = new String[]{
                    "新潟県", "富山県", "石川県", "福井県",
                    "山梨県", "長野県", "岐阜県",
                    "静岡県", "愛知県"
                };
 
            } else if ("近畿".equals(region)) {
                prefectures = new String[]{
                    "三重県", "滋賀県", "京都府", "大阪府",
                    "兵庫県", "奈良県", "和歌山県"
                };
 
            } else if ("中国".equals(region)) {
                prefectures = new String[]{
                    "鳥取県", "島根県", "岡山県",
                    "広島県", "山口県"
                };
 
            } else if ("四国".equals(region)) {
                prefectures = new String[]{
                    "徳島県", "香川県", "愛媛県", "高知県"
                };
 
            } else if ("九州・沖縄".equals(region)) {
                prefectures = new String[]{
                    "福岡県", "佐賀県", "長崎県", "熊本県",
                    "大分県", "宮崎県", "鹿児島県", "沖縄県"
                };
            }
 
            if (prefectures != null) {
                sql.append(" AND users.prefecture IN (");
 
                for (int i = 0; i < prefectures.length; i++) {
                    if (i > 0) {
                        sql.append(",");
                    }
                    sql.append("?");
                    params.add(prefectures[i]);
                }
 
                sql.append(")");
            }
        }
 
        // 都道府県で絞り込む
        if (destination != null && !destination.isEmpty()
                && !"指定なし".equals(destination)) {
            sql.append(" AND users.prefecture = ?");
            params.add(destination);
        }
 
        // 趣味で絞り込む（選択した趣味のうち1つでも一致）
        if (hobbies != null && !hobbies.trim().isEmpty()) {
 
            String[] hobbyNames = hobbies.split(",");
 
            sql.append(" AND EXISTS (");
            sql.append("SELECT 1 FROM USER_HOBBIES uh ");
            sql.append("INNER JOIN HOBBIES h ");
            sql.append("ON uh.HOBBY_ID = h.HOBBY_ID ");
            sql.append("WHERE uh.USER_ID = users.USER_ID ");
            sql.append("AND h.HOBBY_NAME IN (");
 
            for (int i = 0; i < hobbyNames.length; i++) {
                if (i > 0) {
                    sql.append(",");
                }
                sql.append("?");
                params.add(hobbyNames[i].trim());
            }
 
            sql.append("))");
        }
 
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql.toString())) {
 
            for (int i = 0; i < params.size(); i++) {
                st.setObject(i + 1, params.get(i));
            }
 
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    User user = new User();
                    user.setUser_id(rs.getInt("user_id"));
                    user.setUser_name(rs.getString("user_name"));
                    user.setUser_age(rs.getInt("user_age"));
                    user.setChild_age(rs.getInt("child_age"));
                    user.setPrefecture(rs.getString("prefecture"));
                    list.add(user);
                }
            }
        }
 
        return list;
    }
 
    // データベースから趣味一覧を取得
    public List<String> selectHobbies() throws Exception {
 
        List<String> list = new ArrayList<>();
 
        String sql = "SELECT HOBBY_NAME FROM HOBBIES ORDER BY HOBBY_ID";
 
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql);
             ResultSet rs = st.executeQuery()) {
 
            while (rs.next()) {
                list.add(rs.getString("HOBBY_NAME"));
            }
        }
 
        return list;
    }
    
    public User selectUser(int user_id) throws Exception {

        String sql = "SELECT * FROM users WHERE user_id = ?";

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {

            st.setInt(1, user_id);


            try (ResultSet rs = st.executeQuery()) {

                if (rs.next()) {

                    User user = new User();

                    user.setUser_id(rs.getInt("user_id"));
                    user.setUser_name(rs.getString("user_name"));
                    user.setUser_age(rs.getInt("user_age"));
                    user.setNickname(rs.getString("nickname"));
                    user.setPassword(rs.getString("password"));
                    user.setEmail(rs.getString("email"));
                    user.setTel(rs.getString("tel"));
                    user.setPostal_code(rs.getString("postal_code"));
                    user.setPrefecture(rs.getString("prefecture"));
                    user.setCity(rs.getString("city"));
                    user.setAddress1(rs.getString("address1"));
                    user.setAddress2(rs.getString("address2"));
                    user.setChild_age(rs.getInt("child_age"));
                    user.setChild_gender(rs.getString("child_gender"));
                    user.setUser_status(rs.getInt("user_status"));
                    user.setComment(rs.getString("comment"));

                    return user;
                }
            }
        }

        return null;
    }
    
 // 通報履歴を取得
    public List<Map<String, Object>> selectReportHistory() throws Exception {
 
        List<Map<String, Object>> list = new ArrayList<>();
 
        String sql = "SELECT "
                + "R.REPORT_ID, "
                + "R.REPORTER_USER_ID, "
                + "R.REPORTED_USER_ID, "
                + "R.REPORT_CONTENT_ID, "
                + "R.REPORT_REASON_ID, "
                + "RR.REPORT_REASON_NAME, "
                + "R.REPORT_CONTENT, "
                + "R.CONTENT, "
                + "R.CREATED_AT, "
                + "R.STATE "
                + "FROM REPORTS R "
                + "INNER JOIN REPORT_REASONS RR "
                + "ON R.REPORT_REASON_ID = RR.REPORT_REASON_ID "
                + "ORDER BY R.CREATED_AT DESC";
 
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql);
             ResultSet rs = st.executeQuery()) {
 
            while (rs.next()) {
 
                Map<String, Object> report = new HashMap<>();
 
                report.put("report_id", rs.getInt("REPORT_ID"));
                report.put("reporter_user_id", rs.getInt("REPORTER_USER_ID"));
                report.put("reported_user_id", rs.getInt("REPORTED_USER_ID"));
                report.put("report_content_id", rs.getInt("REPORT_CONTENT_ID"));
                report.put("report_reason_id", rs.getInt("REPORT_REASON_ID"));
                report.put("report_reason_name", rs.getString("REPORT_REASON_NAME"));
                report.put("report_content", rs.getString("REPORT_CONTENT"));
                report.put("content", rs.getString("CONTENT"));
                report.put("created_at", rs.getTimestamp("CREATED_AT"));
                report.put("state", rs.getString("STATE"));
 
                list.add(report);
            }
        }
 
        return list;
    }
// BANされたユーザーを取得
    public List<User> select(int user_status) throws Exception {
 
        List<User> list = new ArrayList<>();
 
        String sql = "SELECT user_id, user_name, user_status "
                + "FROM users "
                + "WHERE user_status = ?";
 
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
 
            st.setInt(1, user_status);
 
            try (ResultSet rs = st.executeQuery()) {
 
                while (rs.next()) {
 
                    User user = new User();
 
                    user.setUser_id(rs.getInt("user_id"));
                    user.setUser_name(rs.getString("user_name"));
                    user.setUser_status(rs.getInt("user_status"));
 
                    list.add(user);
                }
            }
        }
 
        return list;
    }


}