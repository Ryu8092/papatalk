package bean;
 
import java.io.Serializable;
import java.time.LocalDateTime;
 
public class Report implements Serializable {
 
    private int report_id;
    private int reporter_user_id;
    private int reported_user_id;
    private int report_reason_id;
    private String content;
    private LocalDateTime create_at;
    private int state;
    private String report_content;
    private int report_content_id;
    private String report_reason_name;
    // DAOで取得するユーザー名
    private String user_name;
 
    // getter / setter
 
    public int getReport_id() {
        return report_id;
    }
 
    public void setReport_id(int report_id) {
        this.report_id = report_id;
    }
 
    public int getReporter_user_id() {
        return reporter_user_id;
    }
 
    public void setReporter_user_id(int reporter_user_id) {
        this.reporter_user_id = reporter_user_id;
    }
 
    public int getReported_user_id() {
        return reported_user_id;
    }
 
    public void setReported_user_id(int reported_user_id) {
        this.reported_user_id = reported_user_id;
    }
 
    public int getReport_reason_id() {
        return report_reason_id;
    }
 
    public void setReport_reason_id(int report_reason_id) {
        this.report_reason_id = report_reason_id;
    }
 
    public String getContent() {
        return content;
    }
 
    public void setContent(String content) {
        this.content = content;
    }
 
    public LocalDateTime getCreate_at() {
        return create_at;
    }
 
    public void setCreate_at(LocalDateTime create_at) {
        this.create_at = create_at;
    }
 
    public int getState() {
        return state;
    }
 
    public void setState(int state) {
        this.state = state;
    }
 
    public String getReport_content() {
        return report_content;
    }
 
    public void setReport_content(String report_content) {
        this.report_content = report_content;
    }
 
    public int getReport_content_id() {
        return report_content_id;
    }
 
    public void setReport_content_id(int report_content_id) {
        this.report_content_id = report_content_id;
    }
 
    public String getUser_name() {
        return user_name;
    }
 
    public void setUser_name(String user_name) {
        this.user_name = user_name;
    }
    public String getReport_reason_name() {
        return report_reason_name;
    }
    public void setReport_reason_name(String report_reason_name) {
        this.report_reason_name = report_reason_name;
    }
}