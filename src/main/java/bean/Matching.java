package bean;

import java.io.Serializable;
import java.sql.Timestamp;

public class Matching implements Serializable {

    private int action_user_id;
    private int target_user_id;
    private int match_id;
    private String latestContent;
    private Timestamp latestCreateAt;
    private String latestSenderName;
    private String user_name;

    public String getUser_name() {
        return user_name;
    }

    public void setUser_name(String user_name) {
        this.user_name = user_name;
    }
    
    public int getMatch_id() {
    	return match_id;
    }
    
    public void setMatch_id(int match_id) {
    	this.match_id = match_id;
    }
    
    // action_user_idを取得
    public int getAction_user_id() {
        return action_user_id;
    }

    // action_user_idを設定
    public void setAction_user_id(int action_user_id) {
        this.action_user_id = action_user_id;
    }

    // target_user_idを取得
    public int getTarget_user_id() {
        return target_user_id;
    }

    // target_user_idを設定
    public void setTarget_user_id(int target_user_id) {
        this.target_user_id = target_user_id;
    }
    
    public String getLatestContent() {
        return latestContent;
    }

    public void setLatestContent(String latestContent) {
        this.latestContent = latestContent;
    }

    public Timestamp getLatestCreateAt() {
        return latestCreateAt;
    }

    public void setLatestCreateAt(Timestamp latestCreateAt) {
        this.latestCreateAt = latestCreateAt;
    }

    public String getLatestSenderName() {
        return latestSenderName;
    }

    public void setLatestSenderName(String latestSenderName) {
        this.latestSenderName = latestSenderName;
    }
}