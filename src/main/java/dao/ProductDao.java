
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.Product;

public class ProductDao extends Dao {

    // ジャンル・都道府県を指定して商品一覧を取得
    public List<Product> select(Integer categoryId, String prefecture)
            throws Exception {

        List<Product> list = new ArrayList<>();

        StringBuilder sql = new StringBuilder();

        sql.append(
            "SELECT p.*, c.CATEGORY_NAME " +
            "FROM PRODUCTS p " +
            "LEFT JOIN PRODUCT_CATEGORIES c " +
            "ON p.CATEGORY_ID = c.CATEGORY_ID " +
            "INNER JOIN USERS u " +
            "ON p.SELLER_ID = u.USER_ID "
        );

        boolean hasWhere = false;

        // ジャンル検索
        if (categoryId != null) {
            sql.append("WHERE p.CATEGORY_ID = ? ");
            hasWhere = true;
        }

        // 都道府県検索
        if (prefecture != null && !prefecture.trim().isEmpty()) {

            if (hasWhere) {
                sql.append("AND ");
            } else {
                sql.append("WHERE ");
            }

            sql.append("u.PREFECTURE LIKE ? ");
        }

        sql.append("ORDER BY p.PRODUCT_ID DESC");

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql.toString())) {

            int index = 1;

            if (categoryId != null) {
                st.setInt(index++, categoryId);
            }

            if (prefecture != null && !prefecture.trim().isEmpty()) {
                st.setString(index++, "%" + prefecture.trim() + "%");
            }

            try (ResultSet rs = st.executeQuery()) {

                while (rs.next()) {

                    Product product = new Product();

                    product.setProduct_id(rs.getInt("PRODUCT_ID"));
                    product.setSeller_id(rs.getInt("SELLER_ID"));
                    product.setProduct_name(rs.getString("PRODUCT_NAME"));
                    product.setPickup_location(rs.getString("PICKUP_LOCATION"));
                    product.setContent(rs.getString("CONTENT"));
                    product.setStatus(rs.getString("STATUS"));
                    product.setCategory_id(rs.getInt("CATEGORY_ID"));
                    product.setItem_condition_id(rs.getInt("ITEM_CONDITION_ID"));

                    // ジャンル名
                    product.setCategory_name(
                        rs.getString("CATEGORY_NAME")
                    );

                    list.add(product);
                }
            }
        }

        return list;
    }

    // ジャンルIDを指定して商品一覧を取得
    public List<Product> select(int categoryId) throws Exception {

        List<Product> list = new ArrayList<>();

        String sql =
            "SELECT p.*, c.CATEGORY_NAME " +
            "FROM PRODUCTS p " +
            "LEFT JOIN PRODUCT_CATEGORIES c " +
            "ON p.CATEGORY_ID = c.CATEGORY_ID " +
            "WHERE p.CATEGORY_ID = ? " +
            "ORDER BY p.PRODUCT_ID DESC";

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {

            st.setInt(1, categoryId);

            try (ResultSet rs = st.executeQuery()) {

                while (rs.next()) {

                    Product product = new Product();

                    product.setProduct_id(rs.getInt("PRODUCT_ID"));
                    product.setSeller_id(rs.getInt("SELLER_ID"));
                    product.setProduct_name(rs.getString("PRODUCT_NAME"));
                    product.setPickup_location(rs.getString("PICKUP_LOCATION"));
                    product.setContent(rs.getString("CONTENT"));
                    product.setStatus(rs.getString("STATUS"));
                    product.setCategory_id(rs.getInt("CATEGORY_ID"));
                    product.setItem_condition_id(rs.getInt("ITEM_CONDITION_ID"));

                    product.setCategory_name(
                        rs.getString("CATEGORY_NAME")
                    );

                    list.add(product);
                }
            }
        }

        return list;
    }

    // 商品IDから商品詳細を取得
    public Product selectById(int productId) throws Exception {

        Product product = null;

        String sql =
            "SELECT p.*, " +
            "c.CATEGORY_NAME, " +
            "s.ITEM_CONDITION_NAME, " +
            "u.USER_NAME AS SELLER_NAME " +
            "FROM PRODUCTS p " +
            "LEFT JOIN PRODUCT_CATEGORIES c " +
            "ON p.CATEGORY_ID = c.CATEGORY_ID " +
            "LEFT JOIN PRODUCT_STATUSES s " +
            "ON p.ITEM_CONDITION_ID = s.ITEM_CONDITION_ID " +
            "LEFT JOIN USERS u " +
            "ON p.SELLER_ID = u.USER_ID " +
            "WHERE p.PRODUCT_ID = ?";

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {

            st.setInt(1, productId);

            try (ResultSet rs = st.executeQuery()) {

                if (rs.next()) {

                    product = new Product();

                    product.setProduct_id(rs.getInt("PRODUCT_ID"));
                    product.setSeller_id(rs.getInt("SELLER_ID"));
                    product.setProduct_name(rs.getString("PRODUCT_NAME"));
                    product.setPickup_location(rs.getString("PICKUP_LOCATION"));
                    product.setContent(rs.getString("CONTENT"));
                    product.setStatus(rs.getString("STATUS"));
                    product.setCategory_id(rs.getInt("CATEGORY_ID"));
                    product.setItem_condition_id(rs.getInt("ITEM_CONDITION_ID"));

                    // ジャンル名
                    product.setCategory_name(
                        rs.getString("CATEGORY_NAME")
                    );

                    // 商品状態名
                    product.setItem_condition_name(
                        rs.getString("ITEM_CONDITION_NAME")
                    );

                    // 出品者名
                    product.setSeller_name(
                        rs.getString("SELLER_NAME")
                    );
                }
            }
        }

        return product;
    }

 // 商品を登録して、生成されたPRODUCT_IDを返す
    public int insert(Product product) throws Exception {

        String sql =
            "INSERT INTO PRODUCTS " +
            "(SELLER_ID, PRODUCT_NAME, PICKUP_LOCATION, CONTENT, " +
            "STATUS, CATEGORY_ID, ITEM_CONDITION_ID) " +
            "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(
                     sql, PreparedStatement.RETURN_GENERATED_KEYS)) {

            st.setInt(1, product.getSeller_id());
            st.setString(2, product.getProduct_name());
            st.setString(3, product.getPickup_location());
            st.setString(4, product.getContent());
            st.setString(5, product.getStatus());
            st.setInt(6, product.getCategory_id());
            st.setInt(7, product.getItem_condition_id());

            st.executeUpdate();

            try (ResultSet rs = st.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }

        throw new Exception("商品IDを取得できませんでした。");
    }

    // 商品の状態を取得
    public int selectStatus(int product_id) throws Exception {

        String sql =
            "SELECT STATUS FROM PRODUCTS WHERE PRODUCT_ID = ?";

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {

            st.setInt(1, product_id);

            try (ResultSet rs = st.executeQuery()) {

                if (rs.next()) {
                    return rs.getInt("STATUS");
                }
            }
        }

        return -1;
    }

    // 商品の状態を更新
    public int update(int product_id, int status) throws Exception {

        String sql =
            "UPDATE PRODUCTS SET STATUS = ? WHERE PRODUCT_ID = ?";

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {

            st.setInt(1, status);
            st.setInt(2, product_id);

            return st.executeUpdate();
        }
    }
}
