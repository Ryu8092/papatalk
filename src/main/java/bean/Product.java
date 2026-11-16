package bean;

public class Product {

    private int product_id;
    private int seller_id;
    private String product_name;
    private String pickup_location;
    private String content;
    private String status;
    private int category_id;
    private int item_condition_id;
    private String category_name;
    private String item_condition_name;
    private String seller_name;
    // 商品ID
    public int getProduct_id() {
        return product_id;
    }

    public void setProduct_id(int product_id) {
        this.product_id = product_id;
    }

    // 販売者ID
    public int getSeller_id() {
        return seller_id;
    }

    public void setSeller_id(int seller_id) {
        this.seller_id = seller_id;
    }

    // 商品名
    public String getProduct_name() {
        return product_name;
    }

    public void setProduct_name(String product_name) {
        this.product_name = product_name;
    }

    // 受け取り場所
    public String getPickup_location() {
        return pickup_location;
    }

    public void setPickup_location(String pickup_location) {
        this.pickup_location = pickup_location;
    }

    // コンテンツ
    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    // ステータス
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    // カテゴリID
    public int getCategory_id() {
        return category_id;
    }

    public void setCategory_id(int category_id) {
        this.category_id = category_id;
    }

    // 商品状態ID
    public int getItem_condition_id() {
        return item_condition_id;
    }

    public void setItem_condition_id(int item_condition_id) {
        this.item_condition_id = item_condition_id;
    }
    
    public String getCategory_name() {
        return category_name;
    }

    public void setCategory_name(String category_name) {
        this.category_name = category_name;
    }

    public String getItem_condition_name() {
        return item_condition_name;
    }

    public void setItem_condition_name(String item_condition_name) {
        this.item_condition_name = item_condition_name;
    }

    public String getSeller_name() {
        return seller_name;
    }

    public void setSeller_name(String seller_name) {
        this.seller_name = seller_name;
    }
}