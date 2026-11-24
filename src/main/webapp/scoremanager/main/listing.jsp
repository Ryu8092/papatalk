
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:import url="/common/base.jsp">

    <c:param name="title">パパトークシステム｜おさがり商品登録</c:param>

    <c:param name="scripts">
        <script>
            // 受け渡し場所を結合
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

            // 選択された画像を保持
            let selectedFiles = [];

            // inputのFileListを更新
            function updateFileInput() {

                const input = document.getElementById("images");
                const dataTransfer = new DataTransfer();

                selectedFiles.forEach(file => {
                    dataTransfer.items.add(file);
                });

                input.files = dataTransfer.files;
            }

            // 画像選択時
            function handleImageSelect(input) {

                const files = Array.from(input.files);

                const allowedTypes = [
                    "image/jpeg",
                    "image/png",
                    "image/gif"
                ];

                // 最大3枚まで
                if (selectedFiles.length + files.length > 3) {

                    alert("商品画像は最大3枚まで登録できます。");

                    updateFileInput();
                    return;
                }

                // ファイル形式・容量チェック
                for (const file of files) {

                    if (!allowedTypes.includes(file.type)) {

                        alert("JPEG・PNG・GIF形式の画像を選択してください。");

                        updateFileInput();
                        return;
                    }

                    if (file.size > 5 * 1024 * 1024) {

                        alert("画像は1枚5MB以内にしてください。");

                        updateFileInput();
                        return;
                    }
                }

                // 選択した画像を追加
                selectedFiles = selectedFiles.concat(files);

                updateFileInput();
                displayPreviews();
            }

            // 画像プレビュー表示
            function displayPreviews() {

                const previewArea =
                    document.getElementById("photo-area");

                previewArea.innerHTML = "";

                selectedFiles.forEach((file, index) => {

                    const reader = new FileReader();

                    const item = document.createElement("div");
                    item.className = "photo-item";

                    const label = document.createElement("div");
                    label.className = "photo-label";

                    const image = document.createElement("img");
                    image.className = "photo-preview";
                    image.style.display = "block";

                    const caption = document.createElement("span");
                    caption.className = "photo-caption";

                    caption.textContent =
                        index === 0
                            ? "メイン画像"
                            : "画像 " + (index + 1);

                    // 削除ボタン
                    const removeButton =
                        document.createElement("button");

                    removeButton.type = "button";
                    removeButton.className = "photo-remove";
                    removeButton.textContent = "×";
                    removeButton.title = "この画像を削除";

                    removeButton.addEventListener("click", function () {
                        removeImage(index);
                    });

                    // 画像読み込み
                    reader.onload = function (event) {
                        image.src = event.target.result;
                    };

                    reader.readAsDataURL(file);

                    label.appendChild(image);
                    label.appendChild(removeButton);

                    item.appendChild(label);
                    item.appendChild(caption);

                    previewArea.appendChild(item);
                });

                // 空き枠を表示
                for (let i = selectedFiles.length; i < 3; i++) {

                    const item = document.createElement("div");
                    item.className = "photo-item";

                    const label = document.createElement("div");
                    label.className = "photo-label photo-empty";

                    const icon = document.createElement("span");
                    icon.className = "photo-icon";
                    icon.textContent = "+";

                    label.appendChild(icon);

                    const caption = document.createElement("span");
                    caption.className = "photo-caption";
                    caption.textContent = "画像 " + (i + 1);

                    item.appendChild(label);
                    item.appendChild(caption);

                    previewArea.appendChild(item);
                }

                // 画像枚数を更新
                document.getElementById("photo-count").textContent =
                    selectedFiles.length + " / 3枚";
            }

            // 選択した画像を削除
            function removeImage(index) {

                selectedFiles.splice(index, 1);

                updateFileInput();
                displayPreviews();
            }

            // フォーム送信前のチェック
            function validateForm() {

                // 受け渡し場所を結合
                combinePickupLocation();

                // 画像が1枚以上あるか確認
                if (selectedFiles.length === 0) {

                    alert("商品画像を1枚以上選択してください。");

                    return false;
                }

                // 受け渡し場所を確認
                const pickupLocation =
                    document.getElementById("pickup_location").value;

                if (!pickupLocation) {

                    alert("受け渡し場所を入力してください。");

                    return false;
                }

                return true;
            }

            // 初期表示
            document.addEventListener("DOMContentLoaded", function () {
                displayPreviews();
            });
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
            .photo-section {
                max-width: 760px;
                margin: 0 auto 32px;
            }

            .photo-section-title {
                font-size: 14px;
                font-weight: 600;
                color: #444;
                margin-bottom: 12px;
            }

            .photo-required {
                color: #d9534f;
                font-size: 12px;
                margin-left: 6px;
            }

            .photo-area {
                display: grid;
                grid-template-columns: repeat(5, minmax(0, 1fr));
                gap: 14px;
                margin: 0 auto;
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

            .photo-empty {
                border-style: dashed;
                border-color: #bfc5cc;
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

            /* 画像削除ボタン */
            .photo-remove {
                position: absolute;
                top: 5px;
                right: 5px;
                width: 25px;
                height: 25px;
                border: none;
                border-radius: 50%;
                background: rgba(0, 0, 0, 0.65);
                color: white;
                font-size: 18px;
                line-height: 1;
                cursor: pointer;
                z-index: 2;
            }

            .photo-remove:hover {
                background: #e85d5d;
            }

            /* 画像選択ボタン */
            .photo-upload-button {
                display: inline-block;
                margin-top: 14px;
                padding: 9px 18px;
                border: 1px solid #24476b;
                border-radius: 6px;
                background: #fff;
                color: #24476b;
                font-size: 13px;
                cursor: pointer;
            }

            .photo-upload-button:hover {
                background: #f0f5fa;
            }

            .photo-count {
                display: inline-block;
                margin-left: 12px;
                color: #718096;
                font-size: 12px;
            }

            .photo-note {
                margin-top: 10px;
                color: #777;
                font-size: 12px;
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

            /* エラーメッセージ */
            .error-message {
                color: #d9534f;
                font-size: 14px;
                font-weight: bold;
                margin-top: 10px;
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

                <!-- エラーメッセージ -->
                <c:if test="${not empty errorMessage}">
                    <p class="error-message">
                        <c:out value="${errorMessage}" />
                    </p>
                </c:if>

                <form class="listing-form"
                      action="${pageContext.request.contextPath}/scoremanager/main/ListingRegistration.action"
                      method="post"
                      enctype="multipart/form-data"
                      onsubmit="return validateForm()">

                    <!-- 商品画像 -->
                    <div class="photo-section">

                        <div class="photo-section-title">
                            商品画像
                            <span class="photo-required">必須・3枚</span>
                        </div>

                        <!-- 画像プレビュー -->
                        <div id="photo-area" class="photo-area"></div>

                        <!-- 画像選択 -->
                        <label for="images" class="photo-upload-button">
                            ＋ 写真を選択
                        </label>

                        <input type="file"
                               id="images"
                               name="images"
                               class="photo-input"
                               accept="image/jpeg,image/png,image/gif"
                               multiple
                               onchange="handleImageSelect(this)">

                        <span id="photo-count" class="photo-count">
                            0 / 3枚
                        </span>

                        <p class="photo-note">
                            JPEG・PNG・GIF形式、1枚5MB以内で選択してください。
                            1枚目がメイン画像になります。
                        </p>

                    </div>

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
