package bean;

public class EventImage {

    private int event_image_id;
    private int event_id;
    private String url;
    private int display_order;

    // 写真ID
    public int getEvent_image_id() {
        return event_image_id;
    }

    public void setEvent_image_id(int event_image_id) {
        this.event_image_id = event_image_id;
    }

    // イベントID
    public int getEvent_id() {
        return event_id;
    }

    public void setEvent_id(int event_id) {
        this.event_id = event_id;
    }

    // 写真URL
    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    // 写真の表示順
    public int getDisplay_order() {
        return display_order;
    }

    public void setDisplay_order(int display_order) {
        this.display_order = display_order;
    }
}	