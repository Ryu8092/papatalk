package bean;
 
import java.io.Serializable;
import java.sql.Timestamp;
 
public class Post implements Serializable {
 
    // 投稿ID
    private int post_id;
    // 投稿したユーザーのID
    private int user_id;
    // 投稿タイトル
    private String post_title;
    // 投稿内容
    private String post_content;
    // 投稿者のニックネーム
    private String nickname;
    // 投稿日時
    private Timestamp post_date;
    // 閲覧期限
    private Timestamp view_limit;
 
    // 投稿ID
    public int getPost_id() {
        return post_id;
    }
    public void setPost_id(int post_id) {
        this.post_id = post_id;
    }
 
    // ユーザーID
    public int getUser_id() {
        return user_id;
    }
    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }
 
    // 投稿タイトル
    public String getPost_title() {
        return post_title;
    }
    public void setPost_title(String post_title) {
        this.post_title = post_title;
    }
 
    // 投稿内容
    public String getPost_content() {
        return post_content;
    }
    public void setPost_content(String post_content) {
        this.post_content = post_content;
    }
 
    // 投稿者のニックネーム
    public String getNickname() {
        return nickname;
    }
    public void setNickname(String nickname) {
        this.nickname = nickname;
    }
 
    // 投稿日時
    public Timestamp getPost_date() {
        return post_date;
    }
    public void setPost_date(Timestamp post_date) {
        this.post_date = post_date;
    }
 
    // 閲覧期限
    public Timestamp getView_limit() {
        return view_limit;
    }
    public void setView_limit(Timestamp view_limit) {
        this.view_limit = view_limit;
    }
}