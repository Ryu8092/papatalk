
package bean;

public class User implements java.io.Serializable {

    private int user_id;
    private String user_name;
    private int user_age;
    private String nickname;
    private String password;
    private String email;
    private String tel;
    private String postal_code;
    private String prefecture;
    private String city;
    private String address1;
    private String address2;
    private int child_age;
    private String child_gender;
    private java.sql.Date created_at;
    private int user_status;

    // ゲッター
    public int getUser_id() { return user_id; }
    public String getUser_name() { return user_name; }
    public int getUser_age() { return user_age; }
    public String getNickname() { return nickname; }
    public String getPassword() { return password; }
    public String getEmail() { return email; }
    public String getTel() { return tel; }
    public String getPostal_code() { return postal_code; }
    public String getPrefecture() { return prefecture; }
    public String getCity() { return city; }
    public String getAddress1() { return address1; }
    public String getAddress2() { return address2; }
    public int getChild_age() { return child_age; }
    public String getChild_gender() { return child_gender; }
    public java.sql.Date getCreated_at() { return created_at; }
    public int getUser_status() { return user_status; }

    // セッター
    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public void setUser_name(String user_name) {
        this.user_name = user_name;
    }

    public void setUser_age(int user_age) {
        this.user_age = user_age;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public void setPostal_code(String postal_code) {
        this.postal_code = postal_code;
    }

    public void setPrefecture(String prefecture) {
        this.prefecture = prefecture;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public void setAddress1(String address1) {
        this.address1 = address1;
    }

    public void setAddress2(String address2) {
        this.address2 = address2;
    }

    public void setChild_age(int child_age) {
        this.child_age = child_age;
    }

    public void setChild_gender(String child_gender) {
        this.child_gender = child_gender;
    }

    public void setCreated_at(java.sql.Date created_at) {
        this.created_at = created_at;
    }

    public void setUser_status(int user_status) {
        this.user_status = user_status;
    }
}
