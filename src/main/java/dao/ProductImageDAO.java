
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ProductImageDAO extends Dao {

    // 商品画像を登録
    public int insert(int productId, String url) throws Exception {

        String sql =
            "INSERT INTO PRODUCT_IMAGES " +
            "(PRODUCT_ID, URL) " +
            "VALUES (?, ?)";

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {

            st.setInt(1, productId);
            st.setString(2, url);

            return st.executeUpdate();
        }
    }

    // 商品の1枚目の画像URLを取得
    public String selectFirstImage(int productId) throws Exception {

        String sql =
            "SELECT URL FROM PRODUCT_IMAGES " +
            "WHERE PRODUCT_ID = ? " +
            "ORDER BY PRODUCT_IMAGE_ID ASC";

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {

            st.setInt(1, productId);

            try (ResultSet rs = st.executeQuery()) {

                if (rs.next()) {
                    return rs.getString("URL");
                }
            }
        }

        return null;
    }

    // 商品IDからすべての画像URLを取得
    public List<String> selectByProductId(int productId) throws Exception {

        List<String> imageList = new ArrayList<>();

        String sql =
            "SELECT URL FROM PRODUCT_IMAGES " +
            "WHERE PRODUCT_ID = ? " +
            "ORDER BY PRODUCT_IMAGE_ID ASC";

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {

            st.setInt(1, productId);

            try (ResultSet rs = st.executeQuery()) {

                while (rs.next()) {
                    imageList.add(rs.getString("URL"));
                }
            }
        }

        return imageList;
    }
}
