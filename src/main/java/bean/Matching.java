package bean;

import java.io.Serializable;

public class Matching implements Serializable {

    private int action_user_id;
    private int target_user_id;

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
}