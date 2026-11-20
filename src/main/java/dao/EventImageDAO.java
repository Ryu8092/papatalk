package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.EventImage;

public class EventImageDAO extends Dao {

    // イベント写真を登録
    public int insert(EventImage image) throws Exception {

        String sql =
                "INSERT INTO EVENT_IMAGES " +
                "(EVENT_ID, URL, DISPLAY_ORDER) " +
                "VALUES (?, ?, ?)";

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {

            st.setInt(1, image.getEvent_id());
            st.setString(2, image.getUrl());
            st.setInt(3, image.getDisplay_order());

            return st.executeUpdate();
        }
    }

    // イベントIDから写真一覧を取得
    public List<EventImage> select(int eventId) throws Exception {

        List<EventImage> list = new ArrayList<>();

        String sql =
                "SELECT EVENT_IMAGE_ID, EVENT_ID, URL, DISPLAY_ORDER " +
                "FROM EVENT_IMAGES " +
                "WHERE EVENT_ID = ? " +
                "ORDER BY DISPLAY_ORDER ASC";

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {

            st.setInt(1, eventId);

            try (ResultSet rs = st.executeQuery()) {

                while (rs.next()) {

                    EventImage image = new EventImage();

                    image.setEvent_image_id(
                            rs.getInt("EVENT_IMAGE_ID"));

                    image.setEvent_id(
                            rs.getInt("EVENT_ID"));

                    image.setUrl(
                            rs.getString("URL"));

                    image.setDisplay_order(
                            rs.getInt("DISPLAY_ORDER"));

                    list.add(image);
                }
            }
        }

        return list;
    }

}