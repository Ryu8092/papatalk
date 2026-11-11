package bean;
 
import java.io.Serializable;
import java.sql.Date;
 
public class Event implements Serializable {
 
    private int event_id;
    private String title;
    private Date event_date;
    private String event_place;
    private Date deadline;
    private String event_details;
    private int capacity;
    private String event_url;
 
    public int getEvent_id() {
        return event_id;
    }
 
    public void setEvent_id(int event_id) {
        this.event_id = event_id;
    }
 
    public String getTitle() {
        return title;
    }
 
    public void setTitle(String title) {
        this.title = title;
    }
 
    public Date getEvent_date() {
        return event_date;
    }
 
    public void setEvent_date(Date event_date) {
        this.event_date = event_date;
    }
 
    public String getEvent_place() {
        return event_place;
    }
 
    public void setEvent_place(String event_place) {
        this.event_place = event_place;
    }
 
    public Date getDeadline() {
        return deadline;
    }
 
    public void setDeadline(Date deadline) {
        this.deadline = deadline;
    }
 
    public String getEvent_details() {
        return event_details;
    }
 
    public void setEvent_details(String event_details) {
        this.event_details = event_details;
    }
 
    public int getCapacity() {
        return capacity;
    }
 
    public void setCapacity(int capacity) {
        this.capacity = capacity;
    }
 
    public String getEvent_url() {
        return event_url;
    }
 
    public void setEvent_url(String event_url) {
        this.event_url = event_url;
    }
}
 