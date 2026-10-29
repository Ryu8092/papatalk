
package bean;

public class PreUsers implements java.io.Serializable {

    private String email;
    private int random_code;
    private java.sql.Timestamp create_at;

    // ゲッター
    public String getEmail() {
        return email;
    }

    public int getRandom_code() {
        return random_code;
    }

    public java.sql.Timestamp getCreate_at() {
        return create_at;
    }

    // セッター
    public void setEmail(String email) {
        this.email = email;
    }

    public void setRandom_code(int random_code) {
        this.random_code = random_code;
    }

    public void setCreate_at(java.sql.Timestamp create_at) {
        this.create_at = create_at;
    }
}
