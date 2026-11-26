
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<c:import url="/common/base.jsp">

    <c:param name="title">
        パパトークシステム｜イベント投稿
    </c:param>

    <c:param name="content">

        <style>
<<<<<<< HEAD
            /* 画面全体 */
            .event-input-page {
=======
            .event-input-container {
                border: 2px solid black;
                padding: 18px 45px 20px;
                margin: 10px;
                min-height: 540px;
                box-sizing: border-box;
            }
 
            .photo-area {
			    width: 100%;
			    border: 2px solid black;
			    margin: 0 auto 16px;
			    padding: 15px;
			    box-sizing: border-box;
			    text-align: center;
			}
			
			#addPhotoButton {
			    padding: 8px 18px;
			    margin-top: 10px;
			    background-color: white;
			    border: 1px solid black;
			    cursor: pointer;
			}
			
			.preview-area {
			    display: flex;
			    flex-wrap: wrap;
			    justify-content: center;
			    gap: 15px;
			    margin-top: 15px;
			}
			
			.preview-item {
			    width: 120px;
			    position: relative;
			}
			
			.preview-item img {
			    width: 120px;
			    height: 100px;
			    object-fit: cover;
			    border: 1px solid #ccc;
			}
			
			.delete-photo {
			    width: 100%;
			    padding: 5px;
			    background-color: #e53935;
			    color: white;
			    border: none;
			    cursor: pointer;
			}
			
			.photo-count {
			    font-size: 13px;
			    margin-top: 8px;
			}
			
			.photo-count {
			    font-size: 13px;
			    margin-top: 8px;
			}
            .input-group {
                margin-bottom: 8px;
            }
 
            .input-group label {
                display: block;
                font-size: 13px;
                margin-bottom: 5px;
            }
 
            .input-group input {
                width: 250px;
                height: 29px;
                border: 2px solid black;
                box-sizing: border-box;
            }
 
            .overview-group {
                margin-top: 20px;
            }
 
            .overview-group label {
                display: block;
                font-size: 13px;
                margin-bottom: 5px;
            }
 
            .overview-group textarea {
>>>>>>> refs/remotes/origin/master
                width: 100%;
                min-height: 75vh;
                padding: 30px 20px;
                box-sizing: border-box;
                background-color: #f1ebdd;
                font-family: "Yu Gothic", "Meiryo", sans-serif;
                letter-spacing: 0.05em;
            }

            /* 外側のカード */
            .event-input-container {
                width: 100%;
                max-width: 850px;
                min-height: 540px;
                margin: 0 auto;
                padding: 30px 45px;
                box-sizing: border-box;
                background-color: #fffdf8;
                border: 1px solid #d8ccb4;
                border-radius: 25px;
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
                border-radius: 10px;
                margin-bottom: 25px;
            }

            /* 写真エリア */
            .photo-area {
                width: 100%;
                margin: 0 auto 30px;
                padding: 25px 20px;
                box-sizing: border-box;
                text-align: center;
                background-color: #f7f3ea;
                border: 1px solid #d8ccb4;
                border-radius: 25px;
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
                padding: 11px 24px;
                margin-top: 5px;
                background-color: #292c29;
                border: 1px solid #292c29;
                border-radius: 25px;
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

            /* 写真プレビュー */
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
                border-radius: 20px;
            }

            /* 写真削除ボタン */
            .delete-photo {
                width: 100%;
                padding: 8px;
                margin-top: 5px;
                background-color: #a94442;
                color: white;
                border: none;
                border-radius: 20px;
                cursor: pointer;
                font-size: 12px;
            }

            .delete-photo:hover {
                background-color: #873532;
            }

            /* 入力項目 */
            .input-group {
                margin-bottom: 25px;
            }

            /* ラベル */
            .input-group label,
            .overview-group label {
                display: flex;
                align-items: center;
                gap: 10px;
                font-size: 15px;
                font-weight: bold;
                color: #292c29;
                margin-bottom: 10px;
            }

            /* 必須マーク */
            .required {
                display: inline-block;
                padding: 4px 10px;
                background-color: #a94442;
                color: white;
                border-radius: 20px;
                font-size: 11px;
                font-weight: normal;
            }

            /* すべての入力欄 */
            .input-group input,
            .overview-group textarea {
                display: block;
                width: 100%;
                box-sizing: border-box;
                padding: 13px 18px;
                border: 1px solid #d8ccb4;
                border-radius: 20px !important;
                background-color: #fff;
                color: #292c29;
                font-family: inherit;
                font-size: 15px;
                transition: 0.2s;
            }

            /* テキスト・数値・日付・日時入力欄 */
            .input-group input[type="text"],
            .input-group input[type="number"],
            .input-group input[type="date"],
            .input-group input[type="datetime-local"] {
                height: 52px;
                border-radius: 20px !important;
                -webkit-appearance: none;
                appearance: none;
            }

            /* イベント概要 */
            .overview-group {
                margin-top: 28px;
                margin-bottom: 20px;
            }

            .overview-group textarea {
                height: 180px;
                line-height: 1.8;
                resize: vertical;
                border-radius: 20px !important;
            }

            /* プレースホルダー */
            .input-group input::placeholder,
            .overview-group textarea::placeholder {
                color: #aaa18e;
            }

            /* 入力中 */
            .input-group input:focus,
            .overview-group textarea:focus {
                outline: none;
                border-color: #b49a65;
                box-shadow: 0 0 0 3px rgba(180, 154, 101, 0.18);
                background-color: #fffefa;
            }

            /* 入力補足 */
            .input-note {
                margin-top: 7px;
                font-size: 12px;
                color: #81765f;
            }

            /* ボタンエリア */
            .button-area {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 30px;
                margin-top: 35px;
            }

            .button-area form {
                margin: 0;
            }

            .button-area button {
                min-width: 125px;
                padding: 13px 25px;
                border-radius: 25px;
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
                    padding: 25px;
                    border-radius: 25px;
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
                    padding: 20px 13px 25px;
                    border-radius: 22px;
                }

                .event-input-title {
                    font-size: 21px;
                }

                .photo-area {
                    padding: 18px 8px;
                    border-radius: 22px;
                }

                .preview-item {
                    width: 100px;
                }

                .preview-item img {
                    width: 100px;
                    height: 85px;
                    border-radius: 18px;
                }

                .input-group input,
                .overview-group textarea {
                    border-radius: 20px !important;
                    font-size: 14px;
                }

                .input-group input {
                    height: 50px;
                }

                .input-group label,
                .overview-group label {
                    font-size: 14px;
                }

                .overview-group textarea {
                    height: 150px;
                }

                .button-area {
                    gap: 12px;
                }

                .button-area button {
                    min-width: 100px;
                    padding: 11px 15px;
                    font-size: 13px;
                    border-radius: 22px;
                }
            }
        </style>
<<<<<<< HEAD

        <div class="event-input-page">

            <div class="event-input-container">

                <h1 class="event-input-title">
                    イベント投稿
                </h1>

                <hr class="event-input-line">

                <!-- イベント投稿フォーム -->
                <form id="eventForm"
                      action="/papatalk/scoremanager/main/EventOrganizerRegistration.action"
                      method="post"
                      enctype="multipart/form-data">

                    <!-- 写真エリア -->
                    <div class="photo-area">

                        <label>
                            イベント写真
                            <span class="required">必須</span>
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

                        <p class="input-note">
                            JPEG・PNG・GIF形式、最大6枚まで選択できます。
                        </p>

                    </div>

                    <!-- イベントタイトル -->
                    <div class="input-group">

                        <label for="eventTitle">
                            イベントタイトル
                            <span class="required">必須</span>
                        </label>

                        <input
                            type="text"
                            id="eventTitle"
                            name="title"
                            placeholder="例：親子で楽しむ公園イベント"
                            required>

                    </div>

                    <!-- 開催日時 -->
                    <div class="input-group">

                        <label for="eventDate">
                            開催日時
                            <span class="required">必須</span>
                        </label>

                        <input
                            type="datetime-local"
                            id="eventDate"
                            name="event_date"
                            required>

                       
                    </div>

                    <!-- 申込締切日時 -->
                    <div class="input-group">

                        <label for="deadline">
                            申込締切日
                            <span class="required">必須</span>
                        </label>

                        <input
                            type="date"
                            id="deadline"
                            name="deadline"
                            required>

                       

                    </div>

                    <!-- 定員 -->
                    <div class="input-group">

                        <label for="capacity">
                            定員
                            <span class="required">必須</span>
                        </label>

                        <input
                            type="number"
                            id="capacity"
                            name="capacity"
                            min="1"
                            placeholder="例：20"
                            required>

                        

                    </div>

                    <!-- 開催場所 -->
                    <div class="input-group">

                        <label for="eventPlace">
                            開催場所
                            <span class="required">必須</span>
                        </label>

                        <input
                            type="text"
                            id="eventPlace"
                            name="event_place"
                            placeholder="例：東京都〇〇区〇〇公園"
                            required>

                    </div>

                    <!-- イベント概要 -->
                    <div class="overview-group">

                        <label for="eventDetails">
                            イベント概要
                            <span class="required">必須</span>
                        </label>

                        <textarea
                            id="eventDetails"
                            name="event_details"
                            placeholder="イベントの内容、対象年齢、持ち物、当日の流れなどを入力してください。"
                            required></textarea>

                        

                    </div>

                </form>

                <!-- ボタンエリア -->
=======
 
        <div class="event-input-container">
 
            <div class="photo-area">

			    <label>イベント写真（1〜6枚）</label>
			
			    <div>
			        <button type="button" id="addPhotoButton">
			            ＋ 写真を追加
			        </button>
			
			        <input
			            type="file"
			            id="eventImages"
			            accept="image/jpeg,image/png,image/gif"
			            multiple
			            hidden
			        >
			    </div>
			
			    <div class="photo-count" id="photoCount">
			        0 / 6 枚選択中
			    </div>
			
			    <div class="preview-area" id="previewArea"></div>
			
			</div>
 
			<form
			    action="EventOrganizerRegistration.action"
			    method="post"
			    enctype="multipart/form-data"
			    onsubmit="return validateImages()">
 
                <div class="input-group">
                    <label>タイトル</label>
                    <input type="text" name="title">
                </div>
 
                <div class="input-group">
                    <label>開催日時</label>
                    <input type="datetime-local" name="event_date">
                </div>
 
                <div class="input-group">
                    <label>締切日</label>
                    <input type="date" name="deadline">
                </div>
 
                <div class="input-group">
                    <label>定員</label>
                    <input type="number" name="capacity">
                </div>
 
                <div class="input-group">
                    <label>開催場所</label>
                    <input type="text" name="event_place">
                </div>
 
                <div class="overview-group">
                    <label>イベント概要</label>
                    <textarea name="event_details"></textarea>
                </div>
 
>>>>>>> refs/remotes/origin/master
                <div class="button-area">

                    <!-- 戻る -->
                    <form action="/papatalk/scoremanager/main/RetrieveListOrganizers.action"
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
<<<<<<< HEAD

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

=======
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
		    function validateImages() {
		
		        if (selectedImages.length < 1) {
		            alert("写真を最低1枚選択してください。");
		            return false;
		        }
		
		        // 選択した画像を送信用FormDataに追加
		        const form = document.querySelector("form");
		        const formData = new FormData(form);
		
		        selectedImages.forEach(file => {
		            formData.append("images", file);
		        });
		
		        // FormDataを使って送信
		        fetch(form.action, {
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
		
		        return false;
		    }
		</script>
 
>>>>>>> refs/remotes/origin/master
    </c:param>

</c:import>
