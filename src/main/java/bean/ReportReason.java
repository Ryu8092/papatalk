package bean;
 
import java.io.Serializable;
 
public class ReportReason implements Serializable {
    private static final long serialVersionUID = 1L;
 
    private int report_reason_id;
    private String report_reason_name;
 
    public int getReport_reason_id() {
        return report_reason_id;
    }
 
    public void setReport_reason_id(int report_reason_id) {
        this.report_reason_id = report_reason_id;
    }
 
    public String getReport_reason_name() {
        return report_reason_name;
    }
 
    public void setReport_reason_name(String report_reason_name) {
        this.report_reason_name = report_reason_name;
    }
}