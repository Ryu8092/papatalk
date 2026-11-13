
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.MatchingChat;

public class MatchingChatDAO extends Dao {

    // チャット履歴を取得
    public List<MatchingChat> select(int matchId) {

        List<MatchingChat> chatList = new ArrayList<>();

        String sql =
            "SELECT mc.CHAT_ID, mc.MATCH_ID, mc.USER_ID, " +
            "mc.CONTENT, mc.CREATE_AT, u.USER_NAME " +
            "FROM MATCHING_CHATS mc " +
            "JOIN USERS u ON mc.USER_ID = u.USER_ID " +
            "WHERE mc.MATCH_ID = ? " +
            "ORDER BY mc.CREATE_AT ASC, mc.CHAT_ID ASC";

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, matchId);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    MatchingChat chat = new MatchingChat();

                    chat.setChat_id(rs.getInt("CHAT_ID"));
                    chat.setMatch_id(rs.getInt("MATCH_ID"));
                    chat.setUser_id(rs.getInt("USER_ID"));
                    chat.setContent(rs.getString("CONTENT"));
                    chat.setCreate_at(rs.getTimestamp("CREATE_AT"));
                    chat.setUser_name(rs.getString("USER_NAME"));

                    chatList.add(chat);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("チャット履歴の取得に失敗しました。", e);
        }

        return chatList;
    }


    // 最新メッセージを1件取得
    public MatchingChat selectLatest(int matchId) {

        String sql =
            "SELECT mc.CHAT_ID, mc.MATCH_ID, mc.USER_ID, " +
            "mc.CONTENT, mc.CREATE_AT, u.USER_NAME " +
            "FROM MATCHING_CHATS mc " +
            "JOIN USERS u ON mc.USER_ID = u.USER_ID " +
            "WHERE mc.MATCH_ID = ? " +
            "ORDER BY mc.CREATE_AT DESC, mc.CHAT_ID DESC " +
            "LIMIT 1";

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, matchId);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {

                    MatchingChat chat = new MatchingChat();

                    chat.setChat_id(rs.getInt("CHAT_ID"));
                    chat.setMatch_id(rs.getInt("MATCH_ID"));
                    chat.setUser_id(rs.getInt("USER_ID"));
                    chat.setContent(rs.getString("CONTENT"));
                    chat.setCreate_at(rs.getTimestamp("CREATE_AT"));
                    chat.setUser_name(rs.getString("USER_NAME"));

                    return chat;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("最新メッセージの取得に失敗しました。", e);
        }

        // メッセージがまだ存在しない場合
        return null;
    }


    // メッセージを登録
    public int insert(MatchingChat chat) {

        String sql =
            "INSERT INTO MATCHING_CHATS " +
            "(MATCH_ID, USER_ID, CONTENT, CREATE_AT) " +
            "VALUES (?, ?, ?, CURRENT_TIMESTAMP)";

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, chat.getMatch_id());
            ps.setInt(2, chat.getUser_id());
            ps.setString(3, chat.getContent());

            return ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("メッセージの登録に失敗しました。", e);
        }
    }
    
    
}
