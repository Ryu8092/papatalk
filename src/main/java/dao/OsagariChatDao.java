
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import bean.OsagariChat;

public class OsagariChatDao extends Dao {
	
	// 出品者IDと商品IDから購入者一覧を取得
	public List<OsagariChat> selectBuyer(int user_id, int product_id)
	        throws Exception {

	    List<OsagariChat> list = new ArrayList<>();

	    String sql =
	        "SELECT DISTINCT c.PRODUCT_ID, c.BUYER_ID, u.USER_NAME " +
	        "FROM OSAGARI_CHATS c " +
	        "INNER JOIN PRODUCTS p " +
	        "ON c.PRODUCT_ID = p.PRODUCT_ID " +
	        "INNER JOIN USERS u " +
	        "ON c.BUYER_ID = u.USER_ID " +
	        "WHERE p.SELLER_ID = ? " +
	        "AND c.PRODUCT_ID = ? " +
	        "ORDER BY c.BUYER_ID";

	    try (Connection con = getConnection();
	         PreparedStatement st = con.prepareStatement(sql)) {

	        st.setInt(1, user_id);
	        st.setInt(2, product_id);

	        try (ResultSet rs = st.executeQuery()) {

	            while (rs.next()) {
	                OsagariChat chat = new OsagariChat();

	                chat.setProduct_id(rs.getInt("PRODUCT_ID"));
	                chat.setBuyer_id(rs.getInt("BUYER_ID"));
	                chat.setUser_name(rs.getString("USER_NAME"));

	                list.add(chat);
	            }
	        }
	    }

	    return list;
	}
	
	

    // 購入者IDと商品IDからチャット一覧を取得
    public List<OsagariChat> select(int buyer_id, int product_id)
            throws Exception {

        List<OsagariChat> list = new ArrayList<>();

        String sql = "SELECT chat_id, buyer_id, product_id, "
                   + "sender_id, content, create_at "
                   + "FROM osagari_chats "
                   + "WHERE buyer_id = ? AND product_id = ? "
                   + "ORDER BY create_at ASC";

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {

            st.setInt(1, buyer_id);
            st.setInt(2, product_id);

            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {

                    OsagariChat chat = new OsagariChat();

                    chat.setChat_id(rs.getInt("chat_id"));
                    chat.setBuyer_id(rs.getInt("buyer_id"));
                    chat.setProduct_id(rs.getInt("product_id"));
                    chat.setSender_id(rs.getInt("sender_id"));
                    chat.setContent(rs.getString("content"));

                    Timestamp timestamp = rs.getTimestamp("create_at");

                    if (timestamp != null) {
                        chat.setCreate_at(timestamp.toLocalDateTime());
                    }

                    list.add(chat);
                }
            }
        }

        return list;
    }

    // チャットを登録
    public int insert(OsagariChat chat) throws Exception {

        String sql = "INSERT INTO osagari_chats "
                   + "(buyer_id, product_id, sender_id, content, create_at) "
                   + "VALUES (?, ?, ?, ?, CURRENT_TIMESTAMP)";

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {

            st.setInt(1, chat.getBuyer_id());
            st.setInt(2, chat.getProduct_id());
            st.setInt(3, chat.getSender_id());
            st.setString(4, chat.getContent());

            return st.executeUpdate();
        }
    }
}
