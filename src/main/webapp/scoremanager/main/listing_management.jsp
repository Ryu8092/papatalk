<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
 
<c:import url="/common/base.jsp">
    <c:param name="title">パパトークシステム｜出品管理</c:param>
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
 
            /* 左側サイドバー */
            .page-sidebar {
                width: 240px;
                flex-shrink: 0;
            }
 
            /* 右側メイン */
            .page-main {
                flex: 1;
                min-width: 0;
                padding: 24px;
                background: #fff;
                border: 1px solid #e5eaf0;
                border-radius: 14px;
                box-shadow: 0 3px 12px rgba(32, 59, 92, 0.08);
            }
 
            /* 上部ヘッダー */
            .detail-header {
                display: flex;
                align-items: center;
                gap: 12px;
                flex-wrap: wrap;
                margin-bottom: 28px;
            }
 
            .site-name {
                color: #24476b;
                font-size: 25px;
                font-weight: bold;
                white-space: nowrap;
            }
 
            /* ページタイトル */
            .page-title {
                margin: 0 0 16px;
                padding-bottom: 16px;
                color: #24476b;
                font-size: 26px;
                font-weight: bold;
                border-bottom: 3px solid #ed9145;
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
 
            /* 説明文 */
            .page-description {
                margin-bottom: 28px;
                color: #718096;
                font-size: 14px;
                line-height: 1.8;
            }
 
            /* 商品一覧見出し */
            .section-title {
                margin-bottom: 20px;
                padding-left: 14px;
                border-left: 4px solid #ed9145;
                color: #24476b;
                font-size: 20px;
                font-weight: bold;
            }
 
            /* 商品一覧 */
            .product-list {
                display: grid;
                grid-template-columns: repeat(3, minmax(0, 1fr));
                gap: 20px;
            }
 
            /* 商品カード */
            .product-card {
                display: block;
                min-width: 0;
                overflow: hidden;
                border: 1px solid #e2e8f0;
                border-radius: 12px;
                background: #fff;
                box-shadow: 0 3px 10px rgba(31, 55, 85, 0.05);
                color: inherit;
            }
 
            /* 商品写真 */
            .product-photo {
                display: flex;
                align-items: center;
                justify-content: center;
                height: 160px;
                background: #f8fafc;
                border-bottom: 1px solid #e2e8f0;
                color: #718096;
                text-align: center;
                font-size: 14px;
            }
 
            .photo-icon {
                margin-bottom: 8px;
                font-size: 38px;
            }
 
            /* 商品情報 */
            .product-info {
                padding: 16px;
            }
 
            /* 受け渡し場所 */
            .product-location {
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
            .product-name {
                margin: 0 0 16px;
                color: #24476b;
                font-size: 17px;
                font-weight: bold;
                line-height: 1.7;
                overflow-wrap: anywhere;
            }
 
            /* メールでお問い合わせボタン */
            .contact-button {
                display: block;
                width: 100%;
                box-sizing: border-box;
                margin-top: 14px;
                padding: 11px 10px;
                background: #ed9145;
                color: #fff;
                border: none;
                border-radius: 7px;
                font-size: 14px;
                font-weight: bold;
                text-align: center;
                text-decoration: none;
                cursor: pointer;
            }
 
            .contact-button:hover {
                background: #d8792e;
                color: #fff;
            }
 
            /* 商品がない場合 */
            .empty-message {
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
                .product-list {
                    grid-template-columns: repeat(2, minmax(0, 1fr));
                }
            }
 
            /* スマートフォン */
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
 
                .detail-header {
                    align-items: stretch;
                }
 
                .site-name {
                    width: 100%;
                }
 
                .page-title {
                    font-size: 24px;
                }
 
                .product-list {
                    grid-template-columns: repeat(2, minmax(0, 1fr));
                    gap: 12px;
                }
 
                .product-photo {
                    height: 120px;
                }
 
                .product-info {
                    padding: 12px;
                }
 
                .product-name {
                    font-size: 14px;
                }
 
                .contact-button {
                    font-size: 12px;
                    padding: 10px 5px;
                }
            }
 
            /* 小さいスマートフォン */
            @media (max-width: 380px) {
                .product-list {
                    grid-template-columns: 1fr;
                }
            }
        </style>
 
        <div class="page-layout">
 
            <!-- 左側サイドバー -->
            <aside class="page-sidebar">
                <jsp:include page="/common/sidebar.jsp" />
            </aside>
 
            <!-- 右側メインコンテンツ -->
            <main class="page-main">
 
                <!-- 上部ヘッダー -->
                
 
                <!-- ページタイトル -->
                <h1 class="page-title">
                    出品管理
                </h1>
 
                <!-- 説明文 -->
                
 
                <!-- 商品一覧 -->
                <h2 class="section-title">
                    自分が出品した商品
                </h2>
 
                <div class="product-list">
 
                    <c:choose>
 
                        <c:when test="${not empty productList}">
 
                            <c:forEach var="product" items="${productList}">
 
                                <!-- 商品カード -->
                                <div class="product-card">
 
                                    <!-- 商品写真 -->
                                    <div class="product-photo">
                                        <div>
                                            <div class="photo-icon">📷</div>
                                            <div>商品写真</div>
                                        </div>
                                    </div>
 
                                    <!-- 商品情報 -->
                                    <div class="product-info">
 
                                        <!-- 受け渡し場所 -->
                                        <div class="product-location">
                                            <c:out value="${product.pickup_location}"
                                                default="場所未登録" />
                                        </div>
 
                                        <!-- 商品名 -->
                                        <p class="product-name">
                                            <c:out value="${product.product_name}"
                                                default="商品名未登録" />
                                        </p>
 
                                        <c:url var="contactUrl"
									       value="/scoremanager/main/ContactList.action">
									    <c:param name="product_id"
									             value="${product.product_id}"/>
										</c:url>
										
										<a class="contact-button" href="${contactUrl}">
										    ✉ メールでお問い合わせ
										</a>
 
                                    </div>
 
                                </div>
 
                            </c:forEach>
 
                        </c:when>
 
                        <c:otherwise>
 
                            <div class="empty-message">
                                現在、出品している商品はありません。<br>
                                商品を出品すると、こちらに表示されます。
                            </div>
 
                        </c:otherwise>
 
                    </c:choose>
 
                </div>
 
                <!-- 戻るボタン -->
                <button type="button"
                        class="back-button"
                        onclick="history.back()">
                    ← 戻る
                </button>
 
            </main>
 
        </div>
 
    </c:param>
</c:import>