package dao;
 
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import bean.ExpectedParticipants;
 
public class ExpectedParticipantsDao {
 
    public List<ExpectedParticipants> select(int event_id) throws Exception {
 
        List<ExpectedParticipants> list = new ArrayList<>();
 
        Connection con = new Dao().getConnection();
 
        String sql = "SELECT * FROM EXPECTED_PARTICIPANTS WHERE EVENT_ID = ?";
 
        PreparedStatement st = con.prepareStatement(sql);
 
        st.setInt(1, event_id);
 
        ResultSet rs = st.executeQuery();
 
        while (rs.next()) {
 
            ExpectedParticipants bean = new ExpectedParticipants();
 
            bean.setUser_id(rs.getInt("USER_ID"));
            bean.setEvent_id(rs.getInt("EVENT_ID"));
            bean.setAdultnumber(rs.getInt("ADULTNUMBER"));
            bean.setChildnumber(rs.getInt("CHILDNUMBER"));
 
            list.add(bean);
        }
 
        rs.close();
        st.close();
        con.close();
 
        return list;
    }
 
    // 参加予約を登録
    public int insert(ExpectedParticipants bean) throws Exception {
 
        Connection con = new Dao().getConnection();
 
        String sql = "INSERT INTO EXPECTED_PARTICIPANTS "
                + "(USER_ID, EVENT_ID, ADULTNUMBER, CHILDNUMBER) "
                + "VALUES (?, ?, ?, ?)";
 
        PreparedStatement st = con.prepareStatement(sql);
 
        st.setInt(1, bean.getUser_id());
        st.setInt(2, bean.getEvent_id());
        st.setInt(3, bean.getAdultnumber());
        st.setInt(4, bean.getChildnumber());
 
        int result = st.executeUpdate();
 
        st.close();
        con.close();
 
        return result;
    }
 
    // 同じユーザーの予約があるか確認
    public boolean exists(int user_id, int event_id) throws Exception {
 
        Connection con = new Dao().getConnection();
 
        String sql = "SELECT COUNT(*) FROM EXPECTED_PARTICIPANTS "
                + "WHERE USER_ID = ? AND EVENT_ID = ?";
 
        PreparedStatement st = con.prepareStatement(sql);
 
        st.setInt(1, user_id);
        st.setInt(2, event_id);
 
        ResultSet rs = st.executeQuery();
 
        rs.next();
        boolean exists = rs.getInt(1) > 0;
 
        rs.close();
        st.close();
        con.close();
 
        return exists;
    }
 
    // ユーザーIDから参加予定を取得
    public List<ExpectedParticipants> selectByUserId(int user_id) throws Exception {
 
        List<ExpectedParticipants> list = new ArrayList<>();
 
        Connection con = new Dao().getConnection();
 
        String sql = "SELECT * FROM EXPECTED_PARTICIPANTS WHERE USER_ID = ?";
 
        PreparedStatement st = con.prepareStatement(sql);
 
        st.setInt(1, user_id);
 
        ResultSet rs = st.executeQuery();
 
        while (rs.next()) {
 
            ExpectedParticipants bean = new ExpectedParticipants();
 
            bean.setUser_id(rs.getInt("USER_ID"));
            bean.setEvent_id(rs.getInt("EVENT_ID"));
            bean.setAdultnumber(rs.getInt("ADULTNUMBER"));
            bean.setChildnumber(rs.getInt("CHILDNUMBER"));
 
            list.add(bean);
        }
 
        rs.close();
        st.close();
        con.close();
 
        return list;
    }
 
    // イベント参加予定者のユーザー情報を取得
    public List<Map<String, Object>> selectParticipants(int event_id)
            throws Exception {
 
        List<Map<String, Object>> list = new ArrayList<>();
 
        Connection con = new Dao().getConnection();
 
        String sql =
                "SELECT ep.USER_ID, u.USER_NAME, u.EMAIL, u.TEL, "
                + "ep.ADULTNUMBER, ep.CHILDNUMBER "
                + "FROM EXPECTED_PARTICIPANTS ep "
                + "INNER JOIN USERS u ON ep.USER_ID = u.USER_ID "
                + "WHERE ep.EVENT_ID = ?";
 
        PreparedStatement st = con.prepareStatement(sql);
 
        st.setInt(1, event_id);
 
        ResultSet rs = st.executeQuery();
 
        while (rs.next()) {
 
            Map<String, Object> map = new HashMap<>();
 
            map.put("user_id", rs.getInt("USER_ID"));
            map.put("user_name", rs.getString("USER_NAME"));
            map.put("email", rs.getString("EMAIL"));
            map.put("tel", rs.getString("TEL"));
            map.put("adultnumber", rs.getInt("ADULTNUMBER"));
            map.put("childnumber", rs.getInt("CHILDNUMBER"));
 
            list.add(map);
        }
 
        rs.close();
        st.close();
        con.close();
 
        return list;
    }
}