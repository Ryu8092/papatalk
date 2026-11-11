
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.Event;

public class EventDAO extends Dao {

    // deadlineを条件にイベント一覧を取得
    public List<Event> select(java.sql.Date deadline) throws Exception {

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
}
