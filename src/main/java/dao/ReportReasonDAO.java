package dao;
 
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.ReportReason;
 
public class ReportReasonDAO extends Dao {
 
    public List<ReportReason> getAll() throws Exception {
        List<ReportReason> list = new ArrayList<>();
        String sql = "SELECT REPORT_REASON_ID, REPORT_REASON_NAME FROM REPORT_REASONS ORDER BY REPORT_REASON_ID ASC";
 
        try (
            Connection con = getConnection();
            PreparedStatement st = con.prepareStatement(sql);
            ResultSet rs = st.executeQuery()
        ) {
            while (rs.next()) {
                ReportReason reason = new ReportReason();
                reason.setReport_reason_id(rs.getInt("REPORT_REASON_ID"));
                reason.setReport_reason_name(rs.getString("REPORT_REASON_NAME"));
                list.add(reason);
            }
        }
        return list;
    }
}