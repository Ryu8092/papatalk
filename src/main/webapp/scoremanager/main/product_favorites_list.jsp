<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
 
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
 
<c:import url="/common/base.jsp">
    <c:param name="title">パパトークシステム｜お気に入り一覧</c:param>
    <c:param name="scripts"></c:param>
 
    <c:param name="content">
 
        <style>
            /* 全体レイアウト */
            .page-layout {
                display: flex;
                gap: 24px;
                align-items: flex-start;
                min-height: 70vh;
            }
 
            /* サイドバー */
            .page-sidebar {
                width: 240px;
                flex-shrink: 0;
            }
 
            /* メイン */
            .page-main {
                flex: 1;
                min-width: 0;
                padding: 24px;
                background: #fff;
                border: 1px solid #e5eaf0;
                border-radius: 14px;
                box-shadow: 0 3px 12px rgba(32,59,92,0.08);
            }
 
            /* ヘッダー */
            .detail-header {
                display: flex;
                align-items: center;
                gap: 12px;
                margin-bottom: 28px;
            }
 
            .site-name {
                color: #24476b;
                font-size: 25px;
                font-weight: bold;
            }
 
            /* タイトル */
            .page-title {
                margin: 0 0 16px;
                padding-bottom: 16px;
                color: #24476b;
                font-size: 26px;
                font-weight: bold;
                border-bottom: 3px solid #ed9145;
            }
 
            /* 説明 */
            .page-description {
                margin-bottom: 28px;
                color: #718096;
                font-size: 14px;
                line-height: 1.8;
            }
 
            /* 登録数 */
            .favorites-count {
                margin-bottom: 20px;
                color: #718096;
                font-size: 14px;
            }
 
            .favorites-count strong {
                color: #24476b;
                font-size: 20px;
            }
 
            /* お気に入り一覧 */
            .favorites-list {
                display: flex;
                flex-direction: column;
                gap: 16px;
            }
 
            /* 商品カード */
            .favorite-card {
                display: flex;
                align-items: center;
                gap: 16px;
                padding: 16px;
                border: 1px solid #e2e8f0;
                border-radius: 12px;
                background: #fff;
                box-shadow: 0 3px 10px rgba(31,55,85,0.05);
                box-sizing: border-box;
 
                /* カード全体をクリック可能にする */
                cursor: pointer;
                transition: 0.2s;
            }
 
            .favorite-card:hover {
                background: #f8fafc;
                border-color: #ed9145;
                box-shadow: 0 4px 14px rgba(31,55,85,0.12);
            }
 
            .favorite-card:focus-visible {
                outline: 2px solid #3182ce;
                outline-offset: 4px;
            }
 
            /* 商品写真枠 */
            .favorite-photo {
                width: 170px;
                height: 124px;
                flex-shrink: 0;
                display: flex;
                align-items: center;
                justify-content: center;
                flex-direction: column;
                gap: 6px;
                overflow: hidden;
                border: 1px solid #dce5ef;
                border-radius: 10px;
                background: #f1f5f9;
                color: #94a3b8;
                font-size: 14px;
            }
 
            .favorite-photo .camera-icon {
                font-size: 34px;
            }
 
            /* 商品情報 */
            .favorite-info {
                flex: 1;
                min-width: 0;
            }
 
            .favorite-label {
                display: inline-block;
                margin-bottom: 16px;
                padding: 6px 12px;
                border-radius: 20px;
                background: #fff0e2;
                color: #b96622;
                font-size: 12px;
                font-weight: 600;
            }
 
            .favorite-info p {
                display: flex;
                flex-wrap: wrap;
                align-items: baseline;
                gap: 6px;
                margin: 8px 0;
                color: #444;
                font-size: 15px;
                line-height: 1.8;
            }
 
            .field-label {
                color: #718096;
                min-width: 0;
                flex: 0 0 auto;
            }
 
            .favorite-info strong {
                color: #24476b;
                overflow-wrap: anywhere;
            }
 
            /* 解除フォーム */
            .favorite-delete-form {
                margin: 0;
                flex-shrink: 0;
                cursor: default;
            }
 
            /* 解除ボタン */
            .delete-button {
                display: inline-flex;
                align-items: center;
                justify-content: center;
                min-height: 48px;
                padding: 10px 18px;
                border: 1px solid #e47777;
                border-radius: 9px;
                background: #fff;
                color: #c45151;
                font-size: 14px;
                font-weight: 600;
                cursor: pointer;
                transition: 0.2s;
            }
 
            .delete-button:hover {
                background: #fff1f1;
                transform: translateY(-1px);
            }
 
            /* お気に入りがない場合 */
            .empty-message {
                padding: 36px 20px;
                border: 1px dashed #cbd5e1;
                border-radius: 12px;
                background: #f8fafc;
                text-align: center;
                line-height: 1.8;
            }
 
            .empty-message h3 {
                color: #24476b;
                font-size: 20px;
                margin: 0 0 12px;
            }
 
            .empty-message p {
                color: #718096;
                font-size: 14px;
                margin: 0;
            }
 
            /* 戻るボタン */
            .back-button {
                display: inline-flex;
                align-items: center;
                justify-content: center;
                padding: 10px 16px;
                margin-top: 24px;
                background: #fff;
                color: #24476b;
                border: 1px solid #cbd5e1;
                border-radius: 6px;
                font-weight: bold;
                text-decoration: none;
                cursor: pointer;
            }
 
            .back-button:hover {
                background: #f1f6fa;
                color: #24476b;
            }
 
            /* スマートフォン対応 */
            @media (max-width: 768px) {
                .page-layout {
                    flex-direction: column;
                    gap: 16px;
                }
 
                .page-sidebar {
                    width: 100%;
                }
 
                .page-main {
                    width: 100%;
                    box-sizing: border-box;
                    padding: 16px;
                }
 
                .page-title {
                    font-size: 24px;
                }
 
                .favorite-card {
                    flex-direction: column;
                    align-items: stretch;
                    padding: 18px;
                }
 
                .favorite-photo {
                    width: 100%;
                    height: 180px;
                }
 
                .favorite-delete-form {
                    width: 100%;
                }
 
                .delete-button {
                    width: 100%;
                }
            }
        </style>
 
        <div class="page-layout">
 
            <%-- 左側サイドバー --%>
            <aside class="page-sidebar">
                <jsp:include page="/common/sidebar.jsp" />
            </aside>
 
            <%-- メインコンテンツ --%>
            <main class="page-main">
 
                <h1 class="page-title">
                    お気に入り一覧
                </h1>
 
                <c:choose>
 
                    <%-- お気に入りがない場合 --%>
                    <c:when test="${empty favorites}">
                        <div class="empty-message">
                            <h3>お気に入りはありません</h3>
                            <p>
                                お気に入りに登録した商品は、ここに表示されます。
                            </p>
                        </div>
                    </c:when>
 
                    <%-- お気に入りがある場合 --%>
                    <c:otherwise>
 
                        <p class="favorites-count">
                            お気に入り登録数：
                            <strong>
                                <c:out value="${favorites.size()}" />
                            </strong>
                            件
                        </p>
 
                        <div class="favorites-list">
 
                            <%-- 商品ごとにカードを作成 --%>
                            <c:forEach var="favorite" items="${favorites}">
 
                                <%-- 商品詳細画面へのURL --%>
                                <c:url var="productDetailUrl"
                                       value="/scoremanager/main/GetProductDetails.action">
                                    <c:param name="product_id"
                                             value="${favorite.product_id}" />
                                </c:url>
 
                                <%-- 商品カード全体をクリック可能にする --%>
                                <div class="favorite-card"
                                     role="link"
                                     tabindex="0"
                                     onclick="location.href='${productDetailUrl}'"
                                     onkeydown="if (event.key === 'Enter' || event.key === ' ') {
                                         event.preventDefault();
                                         location.href='${productDetailUrl}';
                                     }">
 
                                    <%-- 商品写真枠 --%>
                                    <div class="favorite-photo">
                                        <span class="camera-icon">📷</span>
                                        <span>写真なし</span>
                                    </div>
 
                                    <%-- 商品情報 --%>
                                    <div class="favorite-info">
                                        <p>
                                            <span class="field-label">
                                                商品名
                                            </span>
 
                                            <strong>
                                                <c:out
                                                    value="${favorite.product_name}"
                                                    default="商品名未登録" />
                                            </strong>
                                        </p>
                                    </div>
 
                                    <%-- お気に入り解除 --%>
                                    <form
                                        action="${pageContext.request.contextPath}/scoremanager/main/ProductDeletesFavorites.action"
                                        method="post"
                                        class="favorite-delete-form"
                                        onclick="event.stopPropagation();"
                                        onkeydown="event.stopPropagation();"
                                        onsubmit="return confirm('このお気に入りを解除しますか？');">
 
                                        <input
                                            type="hidden"
                                            name="product_id"
                                            value="${favorite.product_id}" />
 
                                        <button
                                            type="submit"
                                            class="delete-button">
                                            お気に入り解除
                                        </button>
 
                                    </form>
 
                                </div>
 
                            </c:forEach>
 
                        </div>
 
                    </c:otherwise>
 
                </c:choose>
 
                <%-- 商品一覧に戻るボタン --%>
                <form
                    action="${pageContext.request.contextPath}/scoremanager/main/AssignmentTop.action"
                    method="get">
 
                    <button type="submit" class="back-button">
                        ← 戻る
                    </button>
 
                </form>
 
            </main>
        </div>
 
    </c:param>
</c:import>