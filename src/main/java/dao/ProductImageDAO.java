
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

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
}
