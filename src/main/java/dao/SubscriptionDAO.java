package dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDateTime;
public class SubscriptionDAO extends Dao {
    // サブスク登録
    public int insert(int user_id, int plan) throws Exception {
        LocalDateTime start_date = LocalDateTime.now();
        LocalDateTime end_date;
        // プランによって終了日時を設定
        switch (plan) {
            case 1:
                end_date = start_date.plusDays(1);
                break;
            case 2:
                end_date = start_date.plusMonths(1);
                break;
            case 3:
                end_date = start_date.plusMonths(3);
                break;
            default:
                throw new IllegalArgumentException("不正なプランです");
        }
        String sql = "INSERT INTO subscriptions "
                   + "(user_id, start_date, end_date) "
                   + "VALUES (?, ?, ?)";
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            st.setInt(1, user_id);
            st.setTimestamp(2, java.sql.Timestamp.valueOf(start_date));
            st.setTimestamp(3, java.sql.Timestamp.valueOf(end_date));
            return st.executeUpdate();
        }
    }
    // サブスク加入確認
    public boolean select(int user_id) throws Exception {
        String sql = "SELECT COUNT(*) FROM subscriptions "
                   + "WHERE user_id = ? "
                   + "AND start_date <= CURRENT_TIMESTAMP "
                   + "AND end_date >= CURRENT_TIMESTAMP";
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            st.setInt(1, user_id);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }
        return false;
    }
}