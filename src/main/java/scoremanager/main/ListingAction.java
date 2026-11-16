
package scoremanager.main;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.naming.InitialContext;
import javax.sql.DataSource;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class ListingAction extends Action {

    @Override
    public void execute(HttpServletRequest request,
            HttpServletResponse response) throws Exception {

        // カテゴリ一覧
        List<Map<String, Object>> categories = new ArrayList<>();

        // 商品状態一覧
        List<Map<String, Object>> itemConditions = new ArrayList<>();

        // データベース接続
        InitialContext ic = new InitialContext();

        DataSource ds = (DataSource) ic.lookup(
                "java:/comp/env/jdbc/papa");

        try (Connection con = ds.getConnection()) {

            // カテゴリテーブルから取得
            String categorySql =
                    "SELECT CATEGORY_ID, CATEGORY_NAME " +
                    "FROM PRODUCT_CATEGORIES " +
                    "ORDER BY CATEGORY_ID";

            try (PreparedStatement st =
                    con.prepareStatement(categorySql);
                 ResultSet rs = st.executeQuery()) {

                while (rs.next()) {
                    Map<String, Object> category = new HashMap<>();

                    category.put("category_id",
                            rs.getInt("CATEGORY_ID"));

                    category.put("category_name",
                            rs.getString("CATEGORY_NAME"));

                    categories.add(category);
                }
            }

            // 商品状態テーブルから取得
            String conditionSql =
                    "SELECT ITEM_CONDITION_ID, ITEM_CONDITION_NAME " +
                    "FROM PRODUCT_STATUSES " +
                    "ORDER BY ITEM_CONDITION_ID";

            try (PreparedStatement st =
                    con.prepareStatement(conditionSql);
                 ResultSet rs = st.executeQuery()) {

                while (rs.next()) {
                    Map<String, Object> condition = new HashMap<>();

                    condition.put("item_condition_id",
                            rs.getInt("ITEM_CONDITION_ID"));

                    condition.put("item_condition_name",
                            rs.getString("ITEM_CONDITION_NAME"));

                    itemConditions.add(condition);
                }
            }
        }

        // JSPにデータを渡す
        request.setAttribute("categories", categories);
        request.setAttribute("itemConditions", itemConditions);

        // 商品登録画面へ遷移
        request.getRequestDispatcher(
                "/scoremanager/main/listing.jsp")
                .forward(request, response);
    }
}
