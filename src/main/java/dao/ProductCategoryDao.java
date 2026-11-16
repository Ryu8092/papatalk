
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.Category;

public class ProductCategoryDao extends Dao {

    // ジャンル一覧を取得
    public List<Category> select() throws Exception {

        List<Category> list = new ArrayList<>();

        String sql =
            "SELECT CATEGORY_ID, CATEGORY_NAME " +
            "FROM PRODUCT_CATEGORIES " +
            "ORDER BY CATEGORY_ID";

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql);
             ResultSet rs = st.executeQuery()) {

            while (rs.next()) {

                Category category = new Category();

                category.setCategory_id(
                    rs.getInt("CATEGORY_ID")
                );

                category.setCategory_name(
                    rs.getString("CATEGORY_NAME")
                );

                list.add(category);
            }
        }

        return list;
    }
}
