
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:import url="/common/base.jsp">
    <c:param name="title">パパトークシステム｜おさがり譲渡</c:param>
    <c:param name="scripts"></c:param>

    <c:param name="content">
        <style>
            /* ページ全体 */
            .matching-layout {
                display: flex;
                gap: 24px;
                align-items: flex-start;
                min-height: 70vh;
            }

            /* 左側サイドバー */
            .matching-sidebar {
                flex: 0 0 240px;
                background: #ffffff;
                border-radius: 14px;
                box-shadow: 0 4px 16px rgba(31, 55, 85, 0.08);
                padding: 20px;
            }

            /* 右側メイン */
            .matching-main {
                flex: 1;
                min-width: 0;
                padding: 28px;
                background: #ffffff;
                border-radius: 14px;
                box-shadow: 0 4px 16px rgba(31, 55, 85, 0.08);
            }

            /* ページタイトル */
            .matching-title {
                color: #24476b;
                font-size: 26px;
                font-weight: 700;
                padding-bottom: 16px;
                border-bottom: 3px solid #ed9145;
                margin-bottom: 16px;
            }

            .matching-description {
                color: #718096;
                font-size: 14px;
                line-height: 1.8;
                margin-bottom: 28px;
            }

            /* 検索・機能ボタン */
            .osagari-tools {
                display: flex;
                flex-wrap: wrap;
                align-items: center;
                gap: 12px;
                margin-bottom: 32px;
                padding: 20px;
                background: #f8fafc;
                border: 1px solid #e2e8f0;
                border-radius: 12px;
            }

            .osagari-tool-form {
                margin: 0;
            }

            /* ジャンル・地域検索フォーム */
            .osagari-category-form {
                display: flex;
                flex: 1 1 100%;
                align-items: center;
                flex-wrap: wrap;
                gap: 10px;
                margin: 0;
            }

            .osagari-category-form label {
                color: #24476b;
                font-weight: 600;
                white-space: nowrap;
            }

            .osagari-category-form select,
            .osagari-category-form input {
                flex: 1;
                min-width: 180px;
                padding: 11px 14px;
                border: 1px solid #cbd5e1;
                border-radius: 8px;
                background: #ffffff;
                font-size: 14px;
            }

            .osagari-category-form select:focus,
            .osagari-category-form input:focus {
                outline: none;
                border-color: #3182ce;
                box-shadow: 0 0 0 3px rgba(49, 130, 206, 0.12);
            }

            /* ボタン共通 */
            .osagari-btn {
                display: inline-flex;
                align-items: center;
                justify-content: center;
                min-height: 42px;
                padding: 10px 16px;
                border: 1px solid #24476b;
                border-radius: 8px;
                background: #24476b;
                color: #ffffff;
                font-size: 14px;
                font-weight: 600;
                text-align: center;
                text-decoration: none;
                white-space: nowrap;
                cursor: pointer;
                transition: background 0.2s, transform 0.2s;
            }

            .osagari-btn:hover {
                background: #173653;
                color: #ffffff;
                transform: translateY(-1px);
            }

            .osagari-search-btn {
                background: #ed9145;
                border-color: #ed9145;
            }

            .osagari-search-btn:hover {
                background: #d77a2e;
            }

            .osagari-entry-btn {
                background: #ed9145;
                border-color: #ed9145;
            }

            .osagari-entry-btn:hover {
                background: #d77a2e;
            }

            /* 商品一覧見出し */
            .osagari-section-title {
                margin-bottom: 20px;
                padding-left: 14px;
                border-left: 4px solid #ed9145;
                color: #24476b;
                font-size: 21px;
                font-weight: 700;
            }

            /* 商品一覧 */
            .osagari-item-list {
                display: grid;
                grid-template-columns: repeat(3, minmax(0, 1fr));
                gap: 20px;
            }

            /* 商品カード */
            .osagari-item {
                display: block;
                min-width: 0;
                overflow: hidden;
                border: 1px solid #e2e8f0;
                border-radius: 12px;
                background: #ffffff;
                box-shadow: 0 3px 10px rgba(31, 55, 85, 0.05);
                transition: transform 0.2s, box-shadow 0.2s;
                text-decoration: none;
                color: inherit;
                cursor: pointer;
            }

            .osagari-item:hover {
                transform: translateY(-3px);
                box-shadow: 0 6px 16px rgba(31, 55, 85, 0.12);
                color: inherit;
            }

            .osagari-item:focus-visible {
                outline: 3px solid #ed9145;
                outline-offset: 3px;
            }

            /* 商品写真 */
            .osagari-photo {
                display: flex;
                align-items: center;
                justify-content: center;
                height: 150px;
                overflow: hidden;
                background: #f1f5f9;
                color: #94a3b8;
                font-size: 14px;
            }

            /* 商品画像 */
            .osagari-product-image {
                width: 100%;
                height: 100%;
                object-fit: cover;
                display: block;
            }

            .osagari-item-info {
                padding: 16px;
            }

            /* 受け渡し場所 */
            .osagari-location {
                display: inline-block;
                max-width: 100%;
                margin-bottom: 12px;
                padding: 5px 9px;
                border-radius: 6px;
                background: #e8f5ee;
                color: #287653;
                font-size: 12px;
                font-weight: 600;
                overflow-wrap: anywhere;
            }

            /* 商品名 */
            .osagari-item-name {
                margin: 0;
                color: #24476b;
                font-size: 16px;
                font-weight: 700;
                line-height: 1.7;
                overflow-wrap: anywhere;
            }

            .osagari-detail-link {
                margin: 14px 0 0;
                color: #ed9145;
                font-size: 14px;
                font-weight: 600;
            }

            /* エラーメッセージ */
            .osagari-error {
                margin-bottom: 20px;
                padding: 12px 16px;
                border-radius: 8px;
                background: #fff1f0;
                color: #c0392b;
                font-size: 14px;
            }

            /* 商品がない場合 */
            .osagari-empty {
                grid-column: 1 / -1;
                padding: 36px 20px;
                border: 1px dashed #cbd5e1;
                border-radius: 12px;
                background: #f8fafc;
                color: #718096;
                text-align: center;
                line-height: 1.8;
            }

            /* タブレット */
            @media (max-width: 1100px) {
                .osagari-item-list {
                    grid-template-columns: repeat(2, minmax(0, 1fr));
                }
            }

            /* スマートフォン */
            @media (max-width: 768px) {
                .matching-layout {
                    flex-direction: column;
                }

                .matching-sidebar {
                    width: 100%;
                    flex-basis: auto;
                }

                .matching-main {
                    width: 100%;
                    box-sizing: border-box;
                    padding: 20px;
                }

                .matching-title {
                    font-size: 24px;
                }

                .osagari-tools {
                    padding: 14px;
                }

                .osagari-tool-form {
                    flex: 1 1 calc(50% - 12px);
                }

                .osagari-tool-form .osagari-btn {
                    width: 100%;
                    white-space: normal;
                }

                .osagari-category-form {
                    width: 100%;
                }

                .osagari-category-form select,
                .osagari-category-form input {
                    min-width: 0;
                }

                .osagari-item-list {
                    grid-template-columns: repeat(2, minmax(0, 1fr));
                    gap: 12px;
                }

                .osagari-photo {
                    height: 120px;
                }

                .osagari-item-info {
                    padding: 12px;
                }

                .osagari-item-name {
                    font-size: 14px;
                }
            }

            /* 小さいスマートフォン */
            @media (max-width: 380px) {
                .osagari-item-list {
                    grid-template-columns: 1fr;
                }
            }
        </style>

        <div class="matching-layout">

            <!-- 左側：共通サイドバー -->
            <aside class="matching-sidebar">
                <jsp:include page="/common/sidebar.jsp" />
            </aside>

            <!-- 右側：メインコンテンツ -->
            <main class="matching-main">

                <h1 class="matching-title">
                    おさがり譲渡
                </h1>

                <!-- 検索・機能ボタン -->
                <div class="osagari-tools">

                    <!-- ジャンル・地域検索 -->
                    <form action="ProductAcquisition.action"
                          method="get"
                          class="osagari-category-form">

                        <!-- ジャンル検索 -->
                        <label for="category_id">ジャンル：</label>

                        <select name="category_id" id="category_id">

                            <option value="">すべてのジャンル</option>

                            <c:forEach var="category" items="${categories}">
                                <option value="${category.category_id}"
                                    <c:if test="${selectedCategoryId == category.category_id.toString()}">
                                        selected
                                    </c:if>>
                                    <c:out value="${category.category_name}" />
                                </option>
                            </c:forEach>

                        </select>

                        <!-- 都道府県検索 -->
                        <label for="prefecture">都道府県：</label>

                        <input type="text"
                               name="prefecture"
                               id="prefecture"
                               placeholder="例：神奈川県"
                               value="<c:out value='${selectedPrefecture}' />">

                        <!-- 検索ボタン -->
                        <button type="submit"
                                class="osagari-btn osagari-search-btn">
                            検索
                        </button>

                    </form>

                    <!-- 商品出品 -->
                    <form action="/papatalk/scoremanager/main/Listing.action"
                          method="get"
                          class="osagari-tool-form">

                        <button type="submit" class="osagari-btn">
                            商品出品
                        </button>
                    </form>

                    <!-- お気に入り -->
                    <form action="/papatalk/scoremanager/main/ProductRetrieveFavorites.action"
                          method="get"
                          class="osagari-tool-form">

                        <button type="submit" class="osagari-btn">
                            お気に入り
                        </button>
                    </form>

                    <!-- 出品中商品 -->
                    <form action="/papatalk/scoremanager/main/ProductListing.action"
                          method="get"
                          class="osagari-tool-form">

                        <button type="submit" class="osagari-btn">
                            出品中商品
                        </button>
                    </form>

                </div>

                <!-- エラーメッセージ -->
                <c:if test="${not empty errorMessage}">
                    <div class="osagari-error">
                        <c:out value="${errorMessage}" />
                    </div>
                </c:if>

                <!-- 商品一覧 -->
                <h2 class="osagari-section-title">
                    出品商品一覧
                </h2>

                <div class="osagari-item-list">

                    <c:choose>

                        <c:when test="${not empty products}">

                            <c:forEach var="product" items="${products}">

                                <!-- 商品カード -->
                                <a class="osagari-item"
                                   href="GetProductDetails.action?product_id=${product.product_id}">

                                    <!-- 商品写真 -->
                                    <div class="osagari-photo">

                                        <c:choose>
                                            <c:when test="${not empty imageMap[product.product_id]}">
                                                <img
                                                    src="${pageContext.request.contextPath}${imageMap[product.product_id]}"
                                                    alt="商品画像"
                                                    class="osagari-product-image">
                                            </c:when>

                                            <c:otherwise>
                                                <div>
                                                    <div style="font-size: 38px; margin-bottom: 8px;">
                                                        📷
                                                    </div>
                                                    <div>商品写真</div>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>

                                    </div>

                                    <!-- 商品情報 -->
                                    <div class="osagari-item-info">

                                        <!-- 受け渡し場所 -->
                                        <div class="osagari-location">
                                            <c:out value="${product.pickup_location}" />
                                        </div>

                                        <!-- 商品名 -->
                                        <p class="osagari-item-name">
                                            <c:out value="${product.product_name}" />
                                        </p>

                                    </div>

                                </a>

                            </c:forEach>

                        </c:when>

                        <c:otherwise>

                            <div class="osagari-empty">
                                条件に一致する商品はありません。<br>
                                ジャンルや地域を変更して、もう一度検索してください。
                            </div>

                        </c:otherwise>

                    </c:choose>

                </div>

            </main>
        </div>
    </c:param>
</c:import>
