package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.ListOfReports;

public class ListOfReportsDao extends Dao {

	// 通報内容IDから違反者一覧を取得
    public List<ListOfReports> select(int report_content_id)
            throws Exception {

        List<ListOfReports> list = new ArrayList<>();

        Connection con = getConnection();

        String sql =
        		"SELECT " +
        			    "r.REPORTED_USER_ID, " +
        			    "u.USER_NAME, " +
        			    "MAX(r.CREATE_AT) AS CREATE_AT " +
        			    "FROM REPORTS r " +
        			    "INNER JOIN USERS u " +
        			    "ON r.REPORTED_USER_ID = u.USER_ID " +
        			    "WHERE r.REPORT_CONTENT_ID = ? " +
        			    "GROUP BY r.REPORTED_USER_ID, u.USER_NAME " +
        			    "ORDER BY MAX(r.CREATE_AT) DESC";

        PreparedStatement st = con.prepareStatement(sql);

        st.setInt(1, report_content_id);

        ResultSet rs = st.executeQuery();

        while (rs.next()) {

            ListOfReports reports = new ListOfReports();

            reports.setUser_id(
                rs.getInt("REPORTED_USER_ID"));

            reports.setUser_name(
                rs.getString("USER_NAME"));

            reports.setCreated_at(
                rs.getDate("CREATE_AT"));

            list.add(reports);
        }

        rs.close();
        st.close();
        con.close();

        return list;
    }

    // ユーザーIDから通報一覧を取得
    public List<ListOfReports> selectByUserId(
            int user_id) throws Exception {

        List<ListOfReports> list = new ArrayList<>();

        Connection con = getConnection();

        String sql =
            "SELECT u.*, r.CREATE_AT " +
            "FROM REPORTS r " +
            "INNER JOIN USERS u " +
            "ON r.REPORTED_USER_ID = u.USER_ID " +
            "WHERE r.REPORTED_USER_ID = ? " +
            "ORDER BY r.REPORT_ID DESC";

        PreparedStatement st = con.prepareStatement(sql);

        st.setInt(1, user_id);

        ResultSet rs = st.executeQuery();

        while (rs.next()) {

            ListOfReports bean = new ListOfReports();

            bean.setUser_id(rs.getInt("USER_ID"));
            bean.setUser_name(rs.getString("USER_NAME"));
            bean.setUser_age(rs.getInt("USER_AGE"));
            bean.setNickname(rs.getString("NICKNAME"));
            bean.setPassword(rs.getString("PASSWORD"));
            bean.setEmail(rs.getString("EMAIL"));
            bean.setTel(rs.getString("TEL"));
            bean.setPostal_code(rs.getString("POSTAL_CODE"));
            bean.setPrefecture(rs.getString("PREFECTURE"));
            bean.setCity(rs.getString("CITY"));
            bean.setAddress1(rs.getString("ADDRESS1"));
            bean.setAddress2(rs.getString("ADDRESS2"));
            bean.setChild_age(rs.getInt("CHILD_AGE"));
            bean.setChild_gender(rs.getString("CHILD_GENDER"));
            bean.setCreated_at(rs.getDate("CREATE_AT"));
            bean.setUser_status(rs.getInt("USER_STATUS"));

            list.add(bean);
        }

        rs.close();
        st.close();
        con.close();

        return list;
    }
}