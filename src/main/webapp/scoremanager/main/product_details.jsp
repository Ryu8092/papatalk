
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:import url="/common/base.jsp">
    <c:param name="title">商品詳細｜パパトークシステム</c:param>
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

    .page-sidebar {
        width: 240px;
        flex-shrink: 0;
    }

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

    /* ジャンル検索フォーム */
    .search-form {
        display: flex;
        flex: 1;
        gap: 8px;
        min-width: 220px;
        margin: 0;
    }

    .search-input {
        flex: 1;
        min-width: 0;
        padding: 10px;
        border: 1px solid #cbd5e1;
        border-radius: 6px;
        background: #fff;
        color: #24476b;
        font-size: 14px;
    }

    .search-input:focus {
        outline: none;
        border-color: #3182ce;
        box-shadow: 0 0 0 3px rgba(49, 130, 206, 0.12);
    }

    .header-button {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        padding: 10px 16px;
        background: #fff;
        color: #24476b;
        border: 1px solid #cbd5e1;
        border-radius: 6px;
        font-weight: bold;
        white-space: nowrap;
        text-decoration: none;
        cursor: pointer;
    }

    .header-button:hover {
        background: #f1f6fa;
        color: #24476b;
    }

    .search-button {
        background: #ed9145;
        color: #fff;
        border-color: #ed9145;
    }

    .search-button:hover {
        background: #d87c2e;
        color: #fff;
    }

    /* 商品情報の配置 */
    .product-layout {
        display: grid;
        grid-template-columns: minmax(0, 1.15fr) minmax(260px, 0.85fr);
        gap: 24px;
    }

    /* 左側：写真 */
    .photo-area {
        min-width: 0;
    }

    .photo-title {
        margin-bottom: 10px;
        color: #52657b;
        font-weight: bold;
    }

    .photo-content {
        display: grid;
        grid-template-columns: 90px minmax(0, 1fr);
        gap: 14px;
    }

    .photo-thumbnails {
        display: flex;
        flex-direction: column;
        gap: 14px;
    }

    .photo-thumbnail {
        display: flex;
        align-items: center;
        justify-content: center;
        min-height: 72px;
        padding: 8px;
        color: #718096;
        background: #f8fafc;
        border: 1px solid #dce3eb;
        border-radius: 6px;
        text-align: center;
        font-size: 13px;
        cursor: pointer;
        overflow: hidden;
    }

    .photo-thumbnail.active {
        border: 2px solid #ed9145;
    }

    .thumbnail-image {
        width: 100%;
        height: 72px;
        object-fit: cover;
        display: block;
        border-radius: 4px;
    }

    .main-product-image {
        width: 100%;
        max-height: 420px;
        object-fit: contain;
        display: block;
    }

    .main-photo {
        display: flex;
        align-items: center;
        justify-content: center;
        min-height: 270px;
        padding: 16px;
        color: #718096;
        background: #f8fafc;
        border: 1px solid #dce3eb;
        border-radius: 8px;
        text-align: center;
        overflow: hidden;
    }

    .photo-icon {
        font-size: 42px;
        margin-bottom: 8px;
    }

    /* 商品説明 */
    .description-area {
        margin-top: 24px;
    }

    .section-title {
        margin-bottom: 12px;
        padding-bottom: 8px;
        color: #24476b;
        font-size: 18px;
        font-weight: bold;
        border-bottom: 2px solid #ed9145;
    }

    .description-content {
        text-align: left !important;
        overflow-wrap: anywhere;
        line-height: 1.7;
    }

    /* 右側：商品情報 */
    .product-info {
        min-width: 0;
    }

    .product-name {
        margin: 0 0 22px;
        color: #24476b;
        font-size: 24px;
        font-weight: bold;
        overflow-wrap: anywhere;
    }

    /* お気に入り・問い合わせボタン */
    .info-buttons {
        display: flex;
        gap: 10px;
        margin-bottom: 24px;
        align-items: stretch;
    }

    .info-buttons form {
        flex: 1;
        min-width: 0;
        display: flex;
        margin: 0;
    }

    .btn-favorite,
    .btn-contact {
        flex: 1;
        width: 100%;
        min-width: 0;
        box-sizing: border-box;
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 12px 8px;
        border-radius: 7px;
        font-size: 14px;
        font-weight: bold;
        text-align: center;
        text-decoration: none;
        cursor: pointer;
        line-height: 1.5;
    }

    .btn-favorite {
        color: #fff;
        background: #ed9145;
        border: 1px solid #ed9145;
    }

    .btn-favorite:hover {
        background: #d87c2e;
        border-color: #d87c2e;
    }

    .btn-favorite:disabled {
        background: #9ca3af;
        border-color: #9ca3af;
        cursor: not-allowed;
        opacity: 1;
    }

    .btn-contact {
        color: #24476b;
        background: #fff;
        border: 1px solid #9aabbc;
    }

    .btn-contact:hover {
        background: #f1f6fa;
    }

    /* 商品の詳細情報 */
    .info-row {
        margin-bottom: 22px;
    }

    .info-label {
        margin-bottom: 8px;
        color: #52657b;
        font-size: 14px;
        font-weight: bold;
    }

    .info-value {
        color: #344b63;
        line-height: 1.7;
        overflow-wrap: anywhere;
    }

    /* 通報・戻るエリア */
    .bottom-buttons {
        margin-top: 28px;
    }

    /* 戻るボタン */
    .btn-back {
        display: inline-block;
        flex-shrink: 0;
        padding: 10px 24px;
        color: #24476b;
        background: #e5f5fb;
        border: 1px solid #9acfe0;
        border-radius: 6px;
        font-size: 14px;
        font-weight: bold;
        text-decoration: none;
    }

    .btn-back:hover {
        background: #d3edf7;
        color: #24476b;
    }

    /* 通報エリア */
    .report-form {
        flex: 1;
        max-width: 520px;
        min-width: 0;
        margin: 0;
    }

    /* 通報フォームを開くボタン */
    .report-open-button {
        display: inline-block;
        padding: 10px 24px;
        color: #fff;
        background: #d9534f;
        border: 1px solid #d9534f;
        border-radius: 6px;
        font-size: 14px;
        font-weight: bold;
        cursor: pointer;
    }

    .report-open-button:hover {
        background: #bd3935;
        border-color: #bd3935;
    }

    /* 通報フォームの表示・非表示 */
    .report-form-area {
        display: none;
        width: 100%;
        margin-top: 18px;
    }

    .report-form-area.show {
        display: block;
    }

    .report-title {
        margin-bottom: 14px;
        padding-bottom: 8px;
        color: #24476b;
        font-size: 18px;
        font-weight: bold;
        border-bottom: 2px solid #ed9145;
    }

    .report-label {
        display: block;
        margin-bottom: 8px;
        color: #52657b;
        font-size: 14px;
        font-weight: bold;
    }

    .report-select,
    .report-textarea {
        width: 100%;
        box-sizing: border-box;
        padding: 10px;
        border: 1px solid #cbd5e1;
        border-radius: 6px;
        background: #fff;
        color: #344b63;
        font-size: 14px;
    }

    .report-select:focus,
    .report-textarea:focus {
        outline: none;
        border-color: #3182ce;
        box-shadow: 0 0 0 3px rgba(49, 130, 206, 0.12);
    }

    .report-textarea {
        min-height: 110px;
        resize: vertical;
        line-height: 1.7;
    }

    .report-input-area {
        margin-bottom: 16px;
    }

    /* 通報送信ボタン */
    .btn-report {
        display: inline-block;
        padding: 10px 24px;
        color: #fff;
        background: #d9534f;
        border: 1px solid #d9534f;
        border-radius: 6px;
        font-size: 14px;
        font-weight: bold;
        cursor: pointer;
    }

    .btn-report:hover {
        background: #bd3935;
        border-color: #bd3935;
    }

    /* 通報メッセージ */
    .report-message {
        margin-bottom: 20px;
        padding: 12px 16px;
        color: #24476b;
        background: #fff4e8;
        border: 1px solid #ed9145;
        border-radius: 6px;
        line-height: 1.7;
    }

    /* タブレット */
    @media (max-width: 900px) {
        .product-layout {
            grid-template-columns: 1fr;
        }

        .main-photo {
            min-height: 230px;
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

        .search-form {
            flex-basis: 100%;
            min-width: 0;
        }

        .header-button {
            flex: 1;
        }

        .photo-content {
            grid-template-columns: 65px minmax(0, 1fr);
            gap: 8px;
        }

        .photo-thumbnail {
            min-height: 60px;
            font-size: 11px;
        }

        .main-photo {
            min-height: 200px;
        }

        .info-buttons {
            gap: 8px;
        }

        .btn-favorite,
        .btn-contact {
            padding: 12px 4px;
            font-size: 12px;
        }

        .bottom-buttons {
            flex-direction: column;
            padding: 12px;
            gap: 16px;
        }

        .report-form {
            width: 100%;
            max-width: none;
        }

        .btn-report,
        .btn-back,
        .report-open-button {
            padding: 10px 14px;
            font-size: 13px;
        }
    }

    /* 小さいスマートフォン */
    @media (max-width: 380px) {
        .info-buttons {
            flex-direction: column;
        }

        .bottom-buttons {
            padding: 10px;
        }

        .btn-report,
        .btn-back,
        .report-open-button {
            padding: 9px 10px;
            font-size: 12px;
        }
    }
</style>

<div class="page-layout">

    <!-- 左側サイドバー -->
    <aside class="page-sidebar">
        <jsp:include page="/common/sidebar.jsp" />
    </aside>

    <!-- メインコンテンツ -->
    <main class="page-main">

        <!-- 上部ヘッダー -->
        <div class="detail-header">

            <div class="site-name">おさがり譲渡</div>

            <!-- ジャンル選択式検索 -->
            <form action="<c:url value='/scoremanager/main/ProductAcquisition.action' />"
                  method="get"
                  class="search-form">

                <select name="category_id"
                        class="search-input"
                        aria-label="ジャンル選択"
                        required>

                    <option value="">ジャンルを選択してください</option>

                    <c:forEach var="category" items="${categories}">
                        <option value="${category.category_id}">
                            <c:out value="${category.category_name}" />
                        </option>
                    </c:forEach>

                </select>

                <button type="submit"
                        class="header-button search-button">
                    検索
                </button>

            </form>
        </div>

        <!-- 通報メッセージ -->
        <c:if test="${not empty sessionScope.reportMessage}">

            <div class="report-message">
                <c:out value="${sessionScope.reportMessage}" />
            </div>

            <c:remove var="reportMessage" scope="session" />

        </c:if>

        <!-- 商品詳細 -->
        <div class="product-layout">

            <!-- 左側：写真と商品説明 -->
            <section class="photo-area">

                <div class="photo-title">商品写真</div>

                <div class="photo-content">

                    <!-- サムネイル一覧 -->
                    <div class="photo-thumbnails">

                        <c:choose>
                            <c:when test="${not empty imageList}">

                                <c:forEach var="imageUrl"
                                           items="${imageList}"
                                           varStatus="status">

                                    <div class="photo-thumbnail ${status.first ? 'active' : ''}"
                                         onclick="changeMainImage(this, '${pageContext.request.contextPath}${imageUrl}')">

                                        <img
                                            src="${pageContext.request.contextPath}${imageUrl}"
                                            alt="商品画像${status.count}"
                                            class="thumbnail-image">

                                    </div>

                                </c:forEach>

                            </c:when>

                            <c:otherwise>
                                <div class="photo-thumbnail">
                                    写真なし
                                </div>
                            </c:otherwise>
                        </c:choose>

                    </div>

                    <!-- メイン画像 -->
                    <div class="main-photo">

                        <c:choose>
                            <c:when test="${not empty imageList}">

                                <img
                                    id="mainProductImage"
                                    src="${pageContext.request.contextPath}${imageList[0]}"
                                    alt="${product.product_name}の商品画像"
                                    class="main-product-image">

                            </c:when>

                            <c:otherwise>

                                <div>
                                    <div class="photo-icon">📷</div>
                                    <div>商品写真</div>
                                    <small>商品画像は登録されていません</small>
                                </div>

                            </c:otherwise>
                        </c:choose>

                    </div>

                </div>

                <!-- 商品説明 -->
                <div class="description-area">

                    <h3 class="section-title">商品説明</h3>

                    <div class="description-content">
                        <c:out value="${product.content}" />
                    </div>

                </div>

            </section>

            <!-- 右側：商品情報 -->
            <section class="product-info">

                <h2 class="product-name">
                    <c:out value="${product.product_name}" />
                </h2>

                <!-- お気に入りと問い合わせ -->
                <div class="info-buttons">

                    <!-- お気に入り登録・解除 -->
                    <c:choose>
 
                        <%-- 登録済みの場合 --%>
                        <c:when test="${favoriteExists}">
 
                            <form action="<c:url value='/scoremanager/main/AddFavorite.action' />"
                                  method="post">
 
                                <input type="hidden"
                                       name="product_id"
                                       value="${product.product_id}">
 
                                <input type="hidden"
                                       name="action"
                                       value="remove">
 
                                <button type="submit" class="btn-favorite">
                                    ★ 登録解除
                                </button>
 
                            </form>
 
                        </c:when>
 
                        <%-- 未登録の場合 --%>
                        <c:otherwise>
 
                            <form action="<c:url value='/scoremanager/main/AddFavorite.action' />"
                                  method="post">
 
                                <input type="hidden"
                                       name="product_id"
                                       value="${product.product_id}">
 
                                <button type="submit" class="btn-favorite">
                                    ★ お気に入り登録
                                </button>
 
                            </form>
 
                        </c:otherwise>
 
                    </c:choose>

                    <!-- メールで問い合わせ -->
                    <form action="<c:url value='/scoremanager/main/AssignmentChat.action' />"
                          method="get">

                        <input type="hidden"
                               name="product_id"
                               value="${product.product_id}">

                        <button type="submit" class="btn-contact">
                            ✉ メールで問い合わせ
                        </button>

                    </form>

                </div>

                <!-- ジャンル -->
                <div class="info-row">

                    <div class="info-label">ジャンル</div>

                    <div class="info-value">
                        <c:out value="${product.category_name}"
                               default="ジャンル未登録" />
                    </div>

                </div>

                <!-- 投稿者 -->
                <div class="info-row">

                    <div class="info-label">投稿者</div>

                    <div class="info-value">
                        <c:out value="${product.seller_name}"
                               default="投稿者未登録" />
                    </div>

                </div>

                <!-- 商品状態 -->
                <div class="info-row">

                    <div class="info-label">商品状態</div>

                    <div class="info-value">
                        <c:out value="${product.item_condition_name}"
                               default="商品状態未登録" />
                    </div>

                </div>

                <!-- 受け渡し場所 -->
                <div class="info-row">

                    <div class="info-label">受け渡し場所</div>

                    <div class="info-value">
                        <c:out value="${product.pickup_location}" />
                    </div>

                </div>

                <!-- 通報 -->
                <div class="info-row">

                    <button type="button"
                            class="report-open-button"
                            id="reportOpenButton"
                            onclick="toggleReportForm()">
                        ⚑ 通報する
                    </button>

                    <div class="report-form-area" id="reportFormArea">

                        <form action="<c:url value='/scoremanager/main/Report.action' />"
                              method="post">

                            <h3 class="report-title">⚑ 商品を通報する</h3>

                            <!-- 通報種別 -->
                            <input type="hidden"
                                   name="report_type"
                                   value="product">

                            <!-- 商品ID -->
                            <input type="hidden"
                                   name="product_id"
                                   value="${product.product_id}">

                            <!-- 通報内容ID -->
                            <input type="hidden"
                                   name="report_content_id"
                                   value="1">

                            <div class="report-input-area">

                                <label class="report-label">
                                    通報理由
                                </label>

                                <select name="report_reason_id"
                                        class="report-select"
                                        required>

                                    <option value="">
                                        通報理由を選択してください
                                    </option>

                                    <c:forEach var="reason"
                                               items="${reportReasons}">

                                        <option value="${reason.report_reason_id}">
                                            <c:out value="${reason.report_reason_name}" />
                                        </option>

                                    </c:forEach>

                                </select>

                            </div>

                            <div class="report-input-area">

                                <label class="report-label">
                                    通報内容
                                </label>

                                <textarea name="content"
                                          class="report-textarea"
                                          maxlength="1000"
                                          required
                                          placeholder="通報内容を入力してください"></textarea>

                            </div>

                            <button type="submit"
                                    class="btn-report">
                                ⚑ 送信
                            </button>

                        </form>

                    </div>

                </div>

            </section>

        </div>

    </main>

</div>

    </c:param>
</c:import>

<!-- サムネイルをクリックしたときのメイン画像切り替え -->
<script>
    function changeMainImage(element, imageUrl) {

        const mainImage = document.getElementById("mainProductImage");

        if (mainImage) {
            mainImage.src = imageUrl;
        }

        // 選択中のサムネイルの枠線を切り替える
        const thumbnails = document.querySelectorAll(".photo-thumbnail");

        thumbnails.forEach(function(thumbnail) {
            thumbnail.classList.remove("active");
        });

        element.classList.add("active");
    }

    <!-- 通報フォームの表示切り替え -->
    function toggleReportForm() {

        const form = document.getElementById("reportFormArea");
        const button = document.getElementById("reportOpenButton");

        if (form.classList.contains("show")) {

            form.classList.remove("show");
            button.textContent = "⚑ 通報する";

        } else {

            form.classList.add("show");
            button.textContent = "通報フォームを閉じる";

        }
    }
</script>
