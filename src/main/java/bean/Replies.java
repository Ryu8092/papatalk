package bean;
 
import java.io.Serializable;
import java.sql.Timestamp;
 
public class Replies implements Serializable {
 
    private static final long serialVersionUID = 1L;
 
    // 返信ID

    private int reply_id;
 
    // 返信先の投稿ID

    private int post_id;
 
    // 返信したユーザーID

    private int user_id;
 
    // 返信内容

    private String reply_content;
 
    // 返信したユーザー名

    private String user_name;
 
    // 返信日時

    private Timestamp reply_date;
 
 
    // 返信ID

    public int getReply_id() {

        return reply_id;

    }
 
    public void setReply_id(int reply_id) {

        this.reply_id = reply_id;

    }
 
 
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
 
 
    // 返信内容

    public String getReply_content() {

        return reply_content;

    }
 
    public void setReply_content(String reply_content) {

        this.reply_content = reply_content;

    }
 
 
    // ユーザー名

    public String getUser_name() {

        return user_name;

    }
 
    public void setUser_name(String user_name) {

        this.user_name = user_name;

    }
 
 
    // 返信日時

    public Timestamp getReply_date() {

        return reply_date;

    }
 
    public void setReply_date(Timestamp reply_date) {

        this.reply_date = reply_date;

    }








}
 