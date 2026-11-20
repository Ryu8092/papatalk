<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
 
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
 
<c:import url="/common/base.jsp">
 
    <c:param name="title">パパトークシステム｜おさがり商品登録</c:param>
 
    <c:param name="scripts">
        <script>
            function combinePickupLocation() {
                const prefecture =
                    document.getElementById("prefecture").value.trim();
 
                const city =
                    document.getElementById("city").value.trim();
 
                const district =
                    document.getElementById("district").value.trim();
 
                document.getElementById("pickup_location").value =
                    [prefecture, city, district]
                        .filter(Boolean)
                        .join(" ");
            }
 
            function previewImage(input, previewId) {
                const preview = document.getElementById(previewId);
 
                if (input.files && input.files[0]) {
                    const reader = new FileReader();
 
                    reader.onload = function (event) {
                        preview.src = event.target.result;
                        preview.style.display = "block";
                    };
 
                    reader.readAsDataURL(input.files[0]);
                }
            }
        </script>
    </c:param>
 
    <c:param name="content">
 
        <style>
            /* 全体レイアウト */
            .listing-layout {
                display: flex;
                align-items: flex-start;
                gap: 24px;
                width: 100%;
                max-width: 1400px;
                margin: 0 auto;
                padding: 24px;
                box-sizing: border-box;
            }
 
            /* 左側サイドバー */
            .listing-sidebar {
                flex: 0 0 240px;
                min-width: 0;
            }
 
            /* メインエリア */
            .listing-main {
                flex: 1;
                min-width: 0;
                background: #fff;
                border-radius: 16px;
                box-shadow: 0 3px 12px rgba(0, 0, 0, 0.08);
                padding: 32px 30px;
                box-sizing: border-box;
            }
 
            /* ページタイトル */
            .listing-title {
                margin: 0 0 28px;
                padding-bottom: 12px;
                border-bottom: 3px solid #ed9145;
                color: #24476b;
                font-size: 26px;
                font-weight: bold;
            }
 
            .listing-description {
                color: #777;
                font-size: 14px;
                margin: -18px 0 28px;
            }
 
            /* 写真エリア */
            .photo-area {
                display: grid;
                grid-template-columns: repeat(5, minmax(0, 1fr));
                gap: 14px;
                margin: 0 auto 32px;
                max-width: 760px;
            }
 
            .photo-item {
                display: flex;
                flex-direction: column;
                align-items: center;
                gap: 8px;
                min-width: 0;
            }
 
            .photo-label {
                position: relative;
                display: flex;
                align-items: center;
                justify-content: center;
                width: 100%;
                aspect-ratio: 1 / 1;
                max-height: 120px;
                border: 1px solid #d4e0ef;
                border-radius: 8px;
                background: #fff;
                cursor: pointer;
                overflow: hidden;
                box-sizing: border-box;
            }
 
            .photo-label:hover {
                border-color: #477aa8;
                background: #f8fbff;
            }
 
            .photo-icon {
                font-size: 30px;
                color: #777;
            }
 
            .photo-preview {
                display: none;
                position: absolute;
                width: 100%;
                height: 100%;
                object-fit: cover;
                inset: 0;
            }
 
            .photo-input {
                display: none;
            }
 
            .photo-caption {
                font-size: 12px;
                color: #666;
            }
 
            .required-note {
                color: #d9534f;
                font-size: 12px;
                text-align: center;
                margin: -22px 0 26px;
            }
 
            /* フォーム */
            .listing-form {
                max-width: 850px;
                margin: 0 auto;
            }
 
            .form-grid {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 26px 28px;
            }
 
            .form-group {
                display: flex;
                flex-direction: column;
                gap: 9px;
                min-width: 0;
            }
 
            .form-group.full-width {
                grid-column: 1 / -1;
            }
 
            /* 項目名 */
            .form-group label {
                color: #24476b;
                font-size: 15px;
                font-weight: bold;
            }
 
            /* 入力欄 */
            .form-group input,
            .form-group select,
            .form-group textarea {
                width: 100%;
                padding: 14px 15px;
                border: 1px solid #d4e0ef;
                border-radius: 8px;
                background: #fff;
                color: #24476b;
                font-size: 14px;
                box-sizing: border-box;
            }
 
            .form-group input:focus,
            .form-group select:focus,
            .form-group textarea:focus {
                outline: none;
                border-color: #477aa8;
                box-shadow: 0 0 0 2px rgba(71, 122, 168, 0.12);
            }
 
            /* 受け渡し場所 */
            .location-grid {
                display: grid;
                grid-template-columns: repeat(3, minmax(0, 1fr));
                gap: 12px;
            }
 
            .location-field {
                display: flex;
                flex-direction: column;
                gap: 7px;
                min-width: 0;
            }
 
            .location-field label {
                color: #24476b;
                font-size: 13px;
                font-weight: 600;
            }
 
            .location-field input {
                min-width: 0;
            }
 
            /* 商品説明 */
            .form-group textarea {
                min-height: 115px;
                resize: vertical;
            }
 
            /* ボタン */
            .form-buttons {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 14px;
                margin-top: 32px;
            }
 
            .form-button {
                min-width: 120px;
                padding: 16px 28px;
                border: 1px solid #d4e0ef;
                border-radius: 9px;
                background: #fff;
                color: #24476b;
                font-size: 16px;
                font-weight: bold;
                cursor: pointer;
                text-align: center;
                text-decoration: none;
                box-sizing: border-box;
            }
 
            .form-button:hover {
                background: #f5f8fc;
            }
 
            /* 出品ボタン */
            .form-button-primary {
                min-width: 120px;
                border: 1px solid #ed9145;
                background: #ed9145;
                color: #fff;
                font-weight: bold;
            }
 
            .form-button-primary:hover {
                background: #df7f32;
            }
 
            /* タブレット */
            @media (max-width: 900px) {
                .listing-layout {
                    flex-direction: column;
                    padding: 16px;
                }
 
                .listing-sidebar {
                    flex: auto;
                    width: 100%;
                }
 
                .listing-main {
                    width: 100%;
                    padding: 24px;
                }
            }
 
            /* スマートフォン */
            @media (max-width: 560px) {
                .form-grid {
                    grid-template-columns: 1fr;
                }
 
                .form-group.full-width {
                    grid-column: auto;
                }
 
                .photo-area {
                    grid-template-columns: repeat(3, minmax(0, 1fr));
                    gap: 10px;
                }
 
                .location-grid {
                    grid-template-columns: 1fr;
                }
 
                .form-buttons {
                    gap: 12px;
                }
 
                .form-button {
                    min-width: 100px;
                    padding: 12px 16px;
                }
 
                .form-button-primary {
                    min-width: 150px;
                }
 
                .listing-main {
                    padding: 20px 16px;
                }
            }
        </style>
 
        <div class="listing-layout">
 
            <!-- 左側サイドバー -->
            <aside class="listing-sidebar">
                <jsp:include page="/common/sidebar.jsp" />
            </aside>
 
            <!-- 商品登録エリア -->
            <main class="listing-main">
 
                <h2 class="listing-title">おさがり商品登録</h2>
 
                <p class="listing-description">
                    写真と商品情報を入力して、おさがりを出品しましょう。
                </p>
 
                <form class="listing-form"
                      action="/papatalk/scoremanager/main/ListingRegistration.action"
                      method="post"
                      onsubmit="combinePickupLocation()">
 
                    <div class="form-grid">
 
                        <!-- 商品名 -->
                        <div class="form-group">
                            <label for="product_name">タイトル</label>
 
                            <input type="text"
                                   id="product_name"
                                   name="product_name"
                                   placeholder="商品名を入力してください"
                                   required>
                        </div>
 
                        <!-- カテゴリ：データベースから取得 -->
                        <div class="form-group">
                            <label for="category_id">カテゴリ</label>
 
                            <select id="category_id"
                                    name="category_id"
                                    required>
 
                                <option value="">
                                    カテゴリを選択してください
                                </option>
 
                                <c:forEach var="category"
                                           items="${categories}">
 
                                    <option value="${category.category_id}">
                                        <c:out value="${category.category_name}" />
                                    </option>
 
                                </c:forEach>
 
                            </select>
                        </div>
 
                        <!-- 商品状態：データベースから取得 -->
                        <div class="form-group">
                            <label for="item_condition_id">商品状態</label>
 
                            <select id="item_condition_id"
                                    name="item_condition_id"
                                    required>
 
                                <option value="">
                                    商品状態を選択してください
                                </option>
 
                                <c:forEach var="itemCondition"
                                           items="${itemConditions}">
 
                                    <option value="${itemCondition.item_condition_id}">
                                        <c:out value="${itemCondition.item_condition_name}" />
                                    </option>
 
                                </c:forEach>
 
                            </select>
                        </div>
 
                        <!-- 受け渡し場所 -->
                        <div class="form-group full-width">
 
                            <label>受け渡し場所</label>
 
                            <div class="location-grid">
 
                                <div class="location-field">
                                    <label for="prefecture">県</label>
 
                                    <input type="text"
                                           id="prefecture"
                                           placeholder="例：神奈川県"
                                           required>
                                </div>
 
                                <div class="location-field">
                                    <label for="city">市</label>
 
                                    <input type="text"
                                           id="city"
                                           placeholder="例：横浜市"
                                           required>
                                </div>
 
                                <div class="location-field">
                                    <label for="district">区・町・村</label>
 
                                    <input type="text"
                                           id="district"
                                           placeholder="例：港北区"
                                           required>
                                </div>
 
                            </div>
 
                            <input type="hidden"
                                   id="pickup_location"
                                   name="pickup_location">
 
                        </div>
 
                        <!-- 商品説明 -->
                        <div class="form-group full-width">
 
                            <label for="content">商品説明</label>
 
                            <textarea id="content"
                                      name="content"
                                      rows="5"
                                      placeholder="商品の状態や受け渡しについて入力してください"
                                      required></textarea>
 
                        </div>
 
                    </div>
 
                    <!-- ボタン -->
                    <div class="form-buttons">
 
                        <button type="button"
                                class="form-button"
                                onclick="history.back()">
                            戻る
                        </button>
 
                        <button type="submit"
                                class="form-button form-button-primary">
                            出品
                        </button>
 
                    </div>
 
                </form>
 
            </main>
 
        </div>
 
    </c:param>
 
</c:import>