package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.Product;
import bean.ProductFavorites;

public class ProductFavoritesDao extends Dao{

    private static final String INSERT =
        "INSERT INTO product_favorites (user_id, product_id) VALUES (?, ?)";

    public int insert(ProductFavorites bean) throws Exception {

        try (Connection con = new Dao().getConnection();
             PreparedStatement ps = con.prepareStatement(INSERT)) {

            ps.setInt(1, bean.getUser_id());
            ps.setInt(2, bean.getProduct_id());

            return ps.executeUpdate();
        }
    }
    
 // お気に入りを削除
    public int delete(ProductFavorites favorites) throws Exception {

        Connection con = getConnection();

        String sql = "DELETE FROM product_favorites "
                   + "WHERE user_id = ? AND product_id = ?";

        PreparedStatement st = con.prepareStatement(sql);

        st.setInt(1, favorites.getUser_id());
        st.setInt(2, favorites.getProduct_id());

        int result = st.executeUpdate();

        st.close();
        con.close();

        return result;
    }
    
 // お気に入り一覧を取得
    public List<Product> select(int user_id) throws Exception {

        List<Product> list = new ArrayList<>();

        String sql = "SELECT p.product_id, p.seller_id, "
                   + "p.product_name, p.pickup_location, "
                   + "p.content, p.status, "
                   + "p.category_id, p.item_condition_id "
                   + "FROM product_favorites f "
                   + "INNER JOIN products p "
                   + "ON f.product_id = p.product_id "
                   + "WHERE f.user_id = ?";

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {

            st.setInt(1, user_id);

            try (ResultSet rs = st.executeQuery()) {

                while (rs.next()) {

                    Product product = new Product();

                    product.setProduct_id(rs.getInt("product_id"));
                    product.setSeller_id(rs.getInt("seller_id"));
                    product.setProduct_name(rs.getString("product_name"));
                    product.setPickup_location(rs.getString("pickup_location"));
                    product.setContent(rs.getString("content"));
                    product.setStatus(rs.getString("status"));
                    product.setCategory_id(rs.getInt("category_id"));
                    product.setItem_condition_id(rs.getInt("item_condition_id"));

                    list.add(product);
                }
            }
        return list;
        }
    }
    
 // お気に入り登録済みか確認
    public boolean exists(int user_id, int product_id) throws Exception {

        String sql =
            "SELECT COUNT(*) FROM PRODUCT_FAVORITES " +
            "WHERE USER_ID = ? AND PRODUCT_ID = ?";

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {

            st.setInt(1, user_id);
            st.setInt(2, product_id);

            try (ResultSet rs = st.executeQuery()) {

                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }

        return false;
    }
}