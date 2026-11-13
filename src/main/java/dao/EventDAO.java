package dao;
 
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.Event;
 
public class EventDAO extends Dao {
 
    // イベント一覧取得（すべてのイベント）
    public List<Event> select() throws Exception {
 
        List<Event> list = new ArrayList<>();
 
        Connection con = getConnection();
 
        String sql = "SELECT * FROM EVENTS ORDER BY EVENT_ID ASC";
 
        PreparedStatement st = con.prepareStatement(sql);
 
        ResultSet rs = st.executeQuery();
 
        while (rs.next()) {
 
            Event bean = new Event();
 
            bean.setEvent_id(rs.getInt("EVENT_ID"));
            bean.setTitle(rs.getString("TITLE"));
            bean.setEvent_date(rs.getDate("EVENT_DATE"));
            bean.setEvent_place(rs.getString("EVENT_PLACE"));
            bean.setDeadline(rs.getDate("DEADLINE"));
            bean.setEvent_details(rs.getString("EVENT_DETAILS"));
            bean.setCapacity(rs.getInt("CAPACITY"));
            bean.setEvent_url(rs.getString("EVENT_URL"));
 
            list.add(bean);
        }
 
        rs.close();
        st.close();
        con.close();
 
        return list;
    }
 
    // イベント登録
    public int insert(Event bean) throws Exception {
 
        Connection con = getConnection();
 
        String sql = "INSERT INTO EVENTS "
                + "(TITLE, EVENT_DATE, EVENT_PLACE, DEADLINE, "
                + "EVENT_DETAILS, CAPACITY, EVENT_URL) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";
 
        PreparedStatement st = con.prepareStatement(sql);
 
        st.setString(1, bean.getTitle());
        st.setDate(2, bean.getEvent_date());
        st.setString(3, bean.getEvent_place());
        st.setDate(4, bean.getDeadline());
        st.setString(5, bean.getEvent_details());
        st.setInt(6, bean.getCapacity());
        st.setString(7, bean.getEvent_url());
 
        int line = st.executeUpdate();
 
        st.close();
        con.close();
 
        return line;
    }
 
    // deadlineを条件にイベント一覧を取得
    public List<Event> selectdead(java.sql.Date deadline) throws Exception {
 
        List<Event> list = new ArrayList<>();
 
        Connection con = getConnection();
 
        String sql = "SELECT * FROM events WHERE deadline >= ? ORDER BY deadline ASC";
 
        PreparedStatement st = con.prepareStatement(sql);
        st.setDate(1, deadline);
 
        ResultSet rs = st.executeQuery();
 
        while (rs.next()) {
 
            Event event = new Event();
 
            event.setEvent_id(rs.getInt("event_id"));
            event.setTitle(rs.getString("title"));
            event.setEvent_date(rs.getDate("event_date"));
            event.setEvent_place(rs.getString("event_place"));
            event.setDeadline(rs.getDate("deadline"));
            event.setEvent_details(rs.getString("event_details"));
            event.setCapacity(rs.getInt("capacity"));
            event.setEvent_url(rs.getString("event_url"));
 
            list.add(event);
        }
 
        rs.close();
        st.close();
        con.close();
 
        return list;
    }
 
    // イベントIDからイベント情報を取得
    public Event select(int event_id) throws Exception {
 
        Event bean = null;
 
        Connection con = new Dao().getConnection();
 
        String sql = "SELECT * FROM EVENTS WHERE EVENT_ID = ?";
 
        PreparedStatement st = con.prepareStatement(sql);
 
        st.setInt(1, event_id);
 
        ResultSet rs = st.executeQuery();
 
        if (rs.next()) {
 
            bean = new Event();
 
            bean.setEvent_id(rs.getInt("EVENT_ID"));
            bean.setTitle(rs.getString("TITLE"));
            bean.setEvent_date(rs.getDate("EVENT_DATE"));
            bean.setEvent_place(rs.getString("EVENT_PLACE"));
            bean.setDeadline(rs.getDate("DEADLINE"));
            bean.setEvent_details(rs.getString("EVENT_DETAILS"));
            bean.setCapacity(rs.getInt("CAPACITY"));
            bean.setEvent_url(rs.getString("EVENT_URL"));
        }
 
        rs.close();
        st.close();
        con.close();
 
        return bean;
    }
}