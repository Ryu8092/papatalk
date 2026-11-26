
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<c:import url="/common/base.jsp">

    <c:param name="title">
        パパトークシステム｜イベント投稿
    </c:param>

    <c:param name="content">

        <style>
            /* 画面全体 */
            .event-input-page {
                width: 100%;
                min-height: 75vh;
                padding: 30px 20px;
                box-sizing: border-box;
                background-color: #f1ebdd;
                font-family: "Yu Gothic", "Meiryo", sans-serif;
                letter-spacing: 0.05em;
            }

            /* 外側の枠 */
            .event-input-container {
                width: 100%;
                max-width: 850px;
                min-height: 540px;
                margin: 0 auto;
                padding: 25px 45px 30px;
                box-sizing: border-box;
                background-color: #fffdf8;
                border: 1px solid #d8ccb4;
                border-radius: 5px;
                box-shadow: 0 4px 12px rgba(50, 40, 20, 0.08);
            }

            /* タイトル */
            .event-input-title {
                text-align: center;
                font-size: 28px;
                font-weight: bold;
                color: #292c29;
                margin: 5px 0 25px;
            }

            .event-input-line {
                border: none;
                border-top: 2px solid #b49a65;
                margin-bottom: 25px;
            }

            /* 写真エリア */
            .photo-area {
                width: 100%;
                margin: 0 auto 25px;
                padding: 18px;
                box-sizing: border-box;
                text-align: center;
                background-color: #f7f3ea;
                border: 1px solid #d8ccb4;
                border-radius: 4px;
            }

            .photo-area label {
                display: block;
                color: #292c29;
                font-size: 15px;
                font-weight: bold;
                margin-bottom: 12px;
            }

            /* 写真追加ボタン */
            #addPhotoButton {
                padding: 9px 20px;
                margin-top: 5px;
                background-color: #292c29;
                border: 1px solid #292c29;
                border-radius: 4px;
                color: #fffdf8;
                font-size: 14px;
                cursor: pointer;
                transition: 0.2s;
            }

            #addPhotoButton:hover {
                background-color: #b49a65;
                border-color: #b49a65;
            }

            /* 写真枚数 */
            .photo-count {
                font-size: 13px;
                color: #81765f;
                margin-top: 12px;
            }

            /* プレビュー */
            .preview-area {
                display: flex;
                flex-wrap: wrap;
                justify-content: center;
                gap: 15px;
                margin-top: 18px;
            }

            .preview-item {
                width: 120px;
                position: relative;
            }

            .preview-item img {
                width: 120px;
                height: 100px;
                object-fit: cover;
                border: 1px solid #d8ccb4;
                border-radius: 4px;
            }

            /* 写真削除ボタン */
            .delete-photo {
                width: 100%;
                padding: 6px;
                background-color: #a94442;
                color: white;
                border: none;
                border-radius: 3px;
                cursor: pointer;
                font-size: 12px;
            }

            .delete-photo:hover {
                background-color: #873532;
            }

            /* 入力項目 */
            .input-group {
                margin-bottom: 17px;
            }

            .input-group label,
            .overview-group label {
                display: block;
                font-size: 14px;
                font-weight: bold;
                color: #292c29;
                margin-bottom: 7px;
            }

            .input-group input {
                width: 100%;
                max-width: 420px;
                height: 38px;
                padding: 6px 10px;
                box-sizing: border-box;
                border: 1px solid #cbbd9e;
                border-radius: 4px;
                background-color: #fff;
                color: #292c29;
                font-size: 14px;
            }

            .input-group input:focus,
            .overview-group textarea:focus {
                outline: none;
                border-color: #b49a65;
                box-shadow: 0 0 0 2px rgba(180, 154, 101, 0.15);
            }

            /* イベント概要 */
            .overview-group {
                margin-top: 22px;
            }

            .overview-group textarea {
                width: 100%;
                height: 120px;
                padding: 10px;
                box-sizing: border-box;
                border: 1px solid #cbbd9e;
                border-radius: 4px;
                background-color: #fff;
                color: #292c29;
                font-size: 14px;
                resize: vertical;
            }

            /* ボタンエリア */
            .button-area {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 30px;
                margin-top: 30px;
            }

            .button-area form {
                margin: 0;
            }

            .button-area button {
                min-width: 115px;
                padding: 11px 22px;
                border-radius: 4px;
                font-size: 14px;
                letter-spacing: 0.08em;
                cursor: pointer;
                transition: 0.2s;
            }

            /* 戻るボタン */
            .back-button {
                background-color: #292c29;
                color: #fffdf8;
                border: 1px solid #292c29;
            }

            .back-button:hover {
                background-color: #55584f;
            }

            /* 投稿ボタン */
            .submit-button {
                background-color: #b49a65;
                color: #fffdf8;
                border: 1px solid #b49a65;
            }

            .submit-button:hover {
                background-color: #967d4d;
                border-color: #967d4d;
            }

            /* タブレット */
            @media screen and (max-width: 768px) {
                .event-input-container {
                    padding: 20px 20px 30px;
                }

                .event-input-title {
                    font-size: 24px;
                }
            }

            /* スマートフォン */
            @media screen and (max-width: 520px) {
                .event-input-page {
                    padding: 15px 10px;
                }

                .event-input-container {
                    padding: 18px 13px 25px;
                }

                .event-input-title {
                    font-size: 21px;
                }

                .photo-area {
                    padding: 15px 8px;
                }

                .preview-item {
                    width: 100px;
                }

                .preview-item img {
                    width: 100px;
                    height: 85px;
                }

                .button-area {
                    gap: 12px;
                }

                .button-area button {
                    min-width: 100px;
                    padding: 10px 15px;
                    font-size: 13px;
                }
            }
        </style>

        <div class="event-input-page">

            <div class="event-input-container">

                <!-- タイトル -->
                <h1 class="event-input-title">
                    イベント投稿
                </h1>

                <hr class="event-input-line">

                <!-- イベント投稿フォーム -->
                <form id="eventForm"
                      action="${pageContext.request.contextPath}/scoremanager/main/EventOrganizerRegistration.action"
                      method="post"
                      enctype="multipart/form-data">

                    <!-- 写真エリア -->
                    <div class="photo-area">

                        <label>
                            イベント写真（1〜6枚）
                        </label>

                        <div>
                            <button type="button" id="addPhotoButton">
                                ＋ 写真を追加
                            </button>

                            <input
                                type="file"
                                id="eventImages"
                                accept="image/jpeg,image/png,image/gif"
                                multiple
                                hidden>
                        </div>

                        <div class="photo-count" id="photoCount">
                            0 / 6 枚選択中
                        </div>

                        <div class="preview-area" id="previewArea">
                        </div>

                    </div>

                    <!-- タイトル -->
                    <div class="input-group">
                        <label for="eventTitle">
                            タイトル
                        </label>

                        <input
                            type="text"
                            id="eventTitle"
                            name="title">
                    </div>

                    <!-- 開催日時 -->
                    <div class="input-group">
                        <label for="eventDate">
                            開催日時
                        </label>

                        <input
                            type="datetime-local"
                            id="eventDate"
                            name="event_date">
                    </div>

                    <!-- 締切日 -->
                    <div class="input-group">
                        <label for="deadline">
                            締切日
                        </label>

                        <input
                            type="date"
                            id="deadline"
                            name="deadline">
                    </div>

                    <!-- 定員 -->
                    <div class="input-group">
                        <label for="capacity">
                            定員
                        </label>

                        <input
                            type="number"
                            id="capacity"
                            name="capacity">
                    </div>

                    <!-- 開催場所 -->
                    <div class="input-group">
                        <label for="eventPlace">
                            開催場所
                        </label>

                        <input
                            type="text"
                            id="eventPlace"
                            name="event_place">
                    </div>

                    <!-- イベント概要 -->
                    <div class="overview-group">
                        <label for="eventDetails">
                            イベント概要
                        </label>

                        <textarea
                            id="eventDetails"
                            name="event_details"></textarea>
                    </div>

                </form>

                <!-- ボタンエリア -->
                <div class="button-area">

                    <!-- 戻る -->
                    <form action="${pageContext.request.contextPath}/scoremanager/main/RetrieveListOrganizers.action"
                          method="get">

                        <button type="submit" class="back-button">
                            戻る
                        </button>

                    </form>

                    <!-- 投稿 -->
                    <button type="submit"
                            form="eventForm"
                            class="submit-button">
                        投稿
                    </button>

                </div>

            </div>

        </div>

        <script>
            // 選択した画像を管理する配列
            let selectedImages = [];

            const imageInput =
                document.getElementById("eventImages");

            const addPhotoButton =
                document.getElementById("addPhotoButton");

            const previewArea =
                document.getElementById("previewArea");

            const photoCount =
                document.getElementById("photoCount");

            const eventForm =
                document.getElementById("eventForm");


            // 写真追加ボタン
            addPhotoButton.addEventListener("click", function() {
                imageInput.click();
            });


            // 画像選択
            imageInput.addEventListener("change", function() {

                const files = Array.from(this.files);

                for (const file of files) {

                    if (selectedImages.length >= 6) {
                        alert("写真は最大6枚までです。");
                        break;
                    }

                    // 画像形式チェック
                    if (!["image/jpeg", "image/png", "image/gif"]
                            .includes(file.type)) {

                        alert("JPEG・PNG・GIF形式の画像を選択してください。");
                        continue;
                    }

                    selectedImages.push(file);
                }

                // 同じ画像を再度選択できるようにする
                this.value = "";

                displayPreviews();
            });


            // プレビュー表示
            function displayPreviews() {

                previewArea.innerHTML = "";

                photoCount.textContent =
                    selectedImages.length + " / 6 枚選択中";

                selectedImages.forEach((file, index) => {

                    const item = document.createElement("div");
                    item.className = "preview-item";

                    const img = document.createElement("img");

                    const imageUrl = URL.createObjectURL(file);

                    img.src = imageUrl;

                    img.onload = function() {
                        URL.revokeObjectURL(imageUrl);
                    };

                    const deleteButton =
                        document.createElement("button");

                    deleteButton.type = "button";
                    deleteButton.className = "delete-photo";
                    deleteButton.textContent = "削除";

                    // 個別削除
                    deleteButton.addEventListener("click", function() {

                        selectedImages.splice(index, 1);

                        displayPreviews();
                    });

                    item.appendChild(img);
                    item.appendChild(deleteButton);

                    previewArea.appendChild(item);
                });
            }


            // フォーム送信前チェック
            eventForm.addEventListener("submit", function(event) {

                event.preventDefault();

                if (selectedImages.length < 1) {
                    alert("写真を最低1枚選択してください。");
                    return;
                }

                // 選択した画像を送信用FormDataに追加
                const formData = new FormData(eventForm);

                selectedImages.forEach(file => {
                    formData.append("images", file);
                });

                // FormDataを使って送信
                fetch(eventForm.action, {
                    method: "POST",
                    body: formData
                })

                .then(response => {

                    if (response.redirected) {

                        window.location.href = response.url;

                    } else {

                        return response.text().then(html => {

                            document.open();
                            document.write(html);
                            document.close();

                        });
                    }
                })

                .catch(error => {

                    alert("送信に失敗しました。");

                    console.error(error);

                });

            });
        </script>

    </c:param>

</c:import>
