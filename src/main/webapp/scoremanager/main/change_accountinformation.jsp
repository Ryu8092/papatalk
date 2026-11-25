
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:import url="/common/base.jsp">
    <c:param name="title" value="パパトークシステム｜アカウント情報変更" />
    <c:param name="scripts" value="" />

    <c:param name="content">

        <style>
            .account-layout {
                display: flex;
                gap: 24px;
                align-items: flex-start;
                min-height: 70vh;
                padding: 10px 0;
            }

            .account-sidebar {
                flex: 0 0 240px;
                background: #fff;
                border-radius: 14px;
                box-shadow: 0 4px 16px rgba(31, 55, 85, 0.08);
                padding: 20px;
            }

            .account-main {
                flex: 1;
                min-width: 0;
                padding: 28px;
                background: #fff;
                border-radius: 14px;
                box-shadow: 0 4px 16px rgba(31, 55, 85, 0.08);
            }

            .account-title {
                color: #24476b;
                font-size: 26px;
                font-weight: 700;
                padding-bottom: 16px;
                border-bottom: 3px solid #ed9145;
                margin-bottom: 12px;
            }

            .account-description {
                color: #718096;
                font-size: 14px;
                margin-bottom: 28px;
            }

            .account-grid {
                display: grid;
                grid-template-columns: repeat(2, minmax(0, 1fr));
                gap: 20px;
            }

            .account-row {
                min-width: 0;
            }

            .account-full {
                grid-column: 1 / -1;
            }

            .account-label {
                display: block;
                color: #40536a;
                font-size: 14px;
                font-weight: 600;
                margin-bottom: 8px;
            }

            .required {
                color: #e85d5d;
                font-size: 12px;
                margin-left: 5px;
            }

            .account-input {
                display: block;
                width: 100%;
                min-height: 44px;
                padding: 10px 12px;
                border: 1px solid #dce5ed;
                border-radius: 8px;
                background: #f8fafc;
                color: #2d3748;
                font-size: 14px;
                box-sizing: border-box;
                transition: border-color 0.2s, box-shadow 0.2s;
            }

            .account-input:focus {
                outline: none;
                border-color: #00b9c7;
                box-shadow: 0 0 0 3px rgba(0, 185, 199, 0.12);
                background: #fff;
            }

            .account-help {
                display: block;
                color: #8492a6;
                font-size: 12px;
                margin-top: 6px;
            }

            .account-section-title {
                grid-column: 1 / -1;
                color: #24476b;
                font-size: 17px;
                font-weight: 700;
                padding-bottom: 10px;
                margin-top: 8px;
                border-bottom: 1px solid #e8edf2;
            }

            /* プロフィール画像 */
            .avatar-area {
                display: flex;
                align-items: center;
                gap: 18px;
                flex-wrap: wrap;
                padding: 16px;
                border: 1px solid #dce5ed;
                border-radius: 8px;
                background: #f8fafc;
            }

            .avatar-preview {
                width: 100px;
                height: 100px;
                border-radius: 50%;
                object-fit: cover;
                border: 2px solid #dce5ed;
                background: #fff;
                flex-shrink: 0;
            }

            .avatar-placeholder {
                display: flex;
                align-items: center;
                justify-content: center;
                color: #8492a6;
                font-size: 13px;
            }

            .avatar-file-area {
                display: flex;
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
                min-width: 0;
            }

            .avatar-file-input {
                display: none;
            }

            .avatar-file-button {
                display: inline-block;
                padding: 11px 20px;
                background: #24476b;
                color: #fff;
                border-radius: 8px;
                font-size: 14px;
                font-weight: 700;
                cursor: pointer;
                transition: opacity 0.2s;
            }

            .avatar-file-button:hover {
                opacity: 0.85;
            }

            .avatar-file-name {
                color: #718096;
                font-size: 12px;
                overflow-wrap: anywhere;
            }

            /* 趣味チェックボックス */
            .hobby-list {
                display: grid;
                grid-template-columns: repeat(3, minmax(0, 1fr));
                gap: 12px;
                padding: 16px;
                border: 1px solid #dce5ed;
                border-radius: 8px;
                background: #f8fafc;
            }

            .hobby-option {
                display: flex;
                align-items: center;
                gap: 8px;
                font-size: 14px;
                color: #40536a;
                cursor: pointer;
            }

            .hobby-option input {
                width: 17px;
                height: 17px;
                accent-color: #00b9c7;
                cursor: pointer;
                flex-shrink: 0;
            }

            /* 2つのボタンを中央に配置 */
            .account-buttons {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 16px;
                margin-top: 32px;
                padding-top: 24px;
                border-top: 1px solid #e8edf2;
            }

            .account-button {
                display: inline-block;
                min-width: 170px;
                padding: 12px 20px;
                border: none;
                border-radius: 8px;
                font-size: 14px;
                font-weight: 700;
                text-decoration: none;
                text-align: center;
                cursor: pointer;
                transition: opacity 0.2s;
                box-sizing: border-box;
            }

            .account-button:hover {
                opacity: 0.85;
            }

            /* 保存ボタン：オレンジ */
            .account-save {
                background: #ed9145;
                color: #fff;
            }

            /* パスワード変更：紺色 */
            .account-password {
                background: #24476b;
                color: #fff;
            }

            .error-message {
                color: #d93025;
                background: #fff1f0;
                border: 1px solid #ffc9c5;
                border-radius: 8px;
                padding: 12px;
                margin-bottom: 20px;
                white-space: pre-line;
            }

            @media (max-width: 768px) {
                .account-layout {
                    flex-direction: column;
                }

                .account-sidebar {
                    width: 100%;
                    flex-basis: auto;
                    box-sizing: border-box;
                }

                .account-main {
                    width: 100%;
                    padding: 20px;
                    box-sizing: border-box;
                }

                .account-grid {
                    grid-template-columns: 1fr;
                }

                .account-full,
                .account-section-title {
                    grid-column: auto;
                }

                .account-title {
                    font-size: 22px;
                }

                .account-buttons {
                    flex-direction: column;
                    gap: 10px;
                }

                .account-button {
                    width: 100%;
                }

                .hobby-list {
                    grid-template-columns: repeat(2, minmax(0, 1fr));
                }

                .avatar-preview {
                    width: 85px;
                    height: 85px;
                }
            }

            @media (max-width: 480px) {
                .avatar-area {
                    align-items: flex-start;
                }

                .avatar-file-area {
                    width: 100%;
                }

                .hobby-list {
                    grid-template-columns: 1fr;
                }
            }
        </style>

        <div class="account-layout">

            <!-- 左側：サイドバー -->
            <aside class="account-sidebar">
                <jsp:include page="/common/sidebar.jsp" />
            </aside>

            <!-- 右側：アカウント情報入力 -->
            <main class="account-main">

                <h2 class="account-title">アカウント情報変更</h2>

                <p class="account-description">
                    登録情報を確認・変更し、最後に保存ボタンを押してください。
                </p>

                <!-- エラーメッセージ -->
                <c:if test="${not empty error}">
                    <div class="error-message">
                        <c:out value="${error}" />
                    </div>
                </c:if>

                <!-- アカウント情報変更フォーム -->
                <form action="Change.action"
                      method="post"
                      enctype="multipart/form-data">

                    <div class="account-grid">

                        <h3 class="account-section-title">基本情報</h3>

                        <!-- プロフィール画像 -->
                        <div class="account-row account-full">

                            <label class="account-label">
                                プロフィール画像
                            </label>

                            <div class="avatar-area">

                                <c:choose>
                                    <c:when test="${not empty user.avatar_url}">
                                        <img
                                            id="avatar-preview"
                                            class="avatar-preview"
                                            src="${pageContext.request.contextPath}${user.avatar_url}"
                                            alt="プロフィール画像">
                                    </c:when>

                                    <c:otherwise>
                                        <div
                                            id="avatar-preview"
                                            class="avatar-preview avatar-placeholder">
                                            未登録
                                        </div>
                                    </c:otherwise>
                                </c:choose>

                                <div class="avatar-file-area">

                                    <input
                                        type="file"
                                        id="avatar"
                                        name="avatar"
                                        class="avatar-file-input"
                                        accept="image/jpeg,image/png,image/gif">

                                    <label for="avatar"
                                           class="avatar-file-button">
                                        画像を選択
                                    </label>

                                    <span id="avatar-file-name"
                                          class="avatar-file-name">
                                        選択されていません
                                    </span>

                                </div>

                                <small class="account-help">
                                    JPEG・PNG・GIF形式、5MB以内。
                                    画像を選択しなければ現在の画像を維持します。
                                </small>

                            </div>
                        </div>

                        <div class="account-row">
                            <label class="account-label" for="user_name">
                                名前<span class="required"></span>
                            </label>
                            <input class="account-input"
                                   type="text" id="user_name" name="user_name"
                                   value="<c:out value='${user.user_name}'/>"
                                   maxlength="30" required>
                        </div>

                        <div class="account-row">
                            <label class="account-label" for="user_age">
                                年齢
                            </label>
                            <input class="account-input"
                                   type="number" id="user_age" name="user_age"
                                   value="<c:out value='${user.user_age}'/>"
                                   min="0" max="150" required>
                        </div>

                        <div class="account-row">
                            <label class="account-label" for="nickname">
                                ニックネーム<span class="required"></span>
                            </label>
                            <input class="account-input"
                                   type="text" id="nickname" name="nickname"
                                   value="<c:out value='${user.nickname}'/>"
                                   maxlength="30" required>
                        </div>

                        <h3 class="account-section-title">連絡先</h3>

                        <div class="account-row account-full">
                            <label class="account-label" for="email">
                                メールアドレス<span class="required"></span>
                            </label>
                            <input class="account-input"
                                   type="email" id="email" name="email"
                                   value="<c:out value='${user.email}'/>"
                                   maxlength="100" required>
                        </div>

                        <div class="account-row">
                            <label class="account-label" for="tel">
                                電話番号
                            </label>
                            <input class="account-input"
                                   type="tel" id="tel" name="tel"
                                   value="<c:out value='${user.tel}'/>"
                                   maxlength="11">
                        </div>

                        <div class="account-row">
                            <label class="account-label" for="postal_code">
                                郵便番号
                            </label>
                            <input class="account-input"
                                   type="text" id="postal_code"
                                   name="postal_code"
                                   value="<c:out value='${user.postal_code}'/>"
                                   maxlength="8"
                                   placeholder="例：123-4567">
                        </div>

                        <h3 class="account-section-title">住所</h3>

                        <div class="account-row">
                            <label class="account-label" for="prefecture">
                                都道府県
                            </label>
                            <input class="account-input"
                                   type="text" id="prefecture"
                                   name="prefecture"
                                   value="<c:out value='${user.prefecture}'/>">
                        </div>

                        <div class="account-row">
                            <label class="account-label" for="city">
                                市区町村
                            </label>
                            <input class="account-input"
                                   type="text" id="city" name="city"
                                   value="<c:out value='${user.city}'/>"
                                   maxlength="50">
                        </div>

                        <div class="account-row account-full">
                            <label class="account-label" for="address1">
                                番地
                            </label>
                            <input class="account-input"
                                   type="text" id="address1" name="address1"
                                   value="<c:out value='${user.address1}'/>"
                                   maxlength="100">
                        </div>

                        <div class="account-row account-full">
                            <label class="account-label" for="address2">
                                建物名・部屋番号
                            </label>
                            <input class="account-input"
                                   type="text" id="address2" name="address2"
                                   value="<c:out value='${user.address2}'/>"
                                   maxlength="100">
                        </div>

                        <h3 class="account-section-title">お子さんの情報</h3>

                        <div class="account-row">
                            <label class="account-label" for="child_age">
                                お子さんの年齢
                            </label>
                            <input class="account-input"
                                   type="number" id="child_age" name="child_age"
                                   value="<c:out value='${user.child_age}'/>"
                                   min="0" max="17" required>
                        </div>

                        <div class="account-row">
                            <label class="account-label" for="child_gender">
                                お子さんの性別
                            </label>
                            <select class="account-input"
                                    id="child_gender" name="child_gender">

                                <option value="">選択してください</option>

                                <option value="男子"
                                    <c:if test="${user.child_gender eq '男子'}">selected</c:if>>
                                    男の子
                                </option>

                                <option value="女子"
                                    <c:if test="${user.child_gender eq '女子'}">selected</c:if>>
                                    女の子
                                </option>

                            </select>
                        </div>

                        <!-- 趣味 -->
                        <h3 class="account-section-title">趣味</h3>

                        <div class="account-row account-full">

                            <span class="account-label">
                                当てはまる趣味を選択してください
                            </span>

                            <div class="hobby-list">

                                <c:choose>
                                    <c:when test="${not empty allHobbies}">

                                        <c:forEach var="hobby" items="${allHobbies}">

                                            <label class="hobby-option">

                                                <input type="checkbox"
                                                       name="hobbies"
                                                       value="<c:out value='${hobby}'/>"
                                                       <c:if test="${not empty selectedHobbies and selectedHobbies.contains(hobby)}">checked</c:if>>

                                                <c:out value="${hobby}" />

                                            </label>

                                        </c:forEach>

                                    </c:when>

                                    <c:otherwise>
                                        趣味一覧を取得できませんでした。
                                    </c:otherwise>
                                </c:choose>

                            </div>

                            <span class="account-help">
                                複数選択できます。すべてのチェックを外して保存すると、
                                登録済みの趣味が解除されます。
                            </span>

                        </div>

                    </div>

                    <!-- 2つのボタン -->
                    <div class="account-buttons">

                        <!-- パスワード変更 -->
                        <button type="button"
                                class="account-button account-password"
                                onclick="location.href='PasswordChange.action'">
                            パスワード変更
                        </button>

                        <!-- アカウント情報保存 -->
                        <button type="submit"
                                class="account-button account-save">
                            アカウント情報保存
                        </button>

                    </div>

                </form>

            </main>

        </div>

        <!-- プロフィール画像プレビュー -->
        <script>
        document.addEventListener("DOMContentLoaded", function () {

            const avatarInput = document.getElementById("avatar");
            const fileName = document.getElementById("avatar-file-name");

            if (!avatarInput) {
                return;
            }

            avatarInput.addEventListener("change", function () {

                const file = this.files[0];

                if (!file) {
                    fileName.textContent = "選択されていません";
                    return;
                }

                // ファイル形式チェック
                const allowedTypes = [
                    "image/jpeg",
                    "image/png",
                    "image/gif"
                ];

                if (!allowedTypes.includes(file.type)) {
                    alert("JPEG・PNG・GIF形式の画像を選択してください。");
                    this.value = "";
                    fileName.textContent = "選択されていません";
                    return;
                }

                // 5MBチェック
                if (file.size > 5 * 1024 * 1024) {
                    alert("画像サイズは5MB以内にしてください。");
                    this.value = "";
                    fileName.textContent = "選択されていません";
                    return;
                }

                fileName.textContent = file.name;

                // 画像プレビュー
                const reader = new FileReader();

                reader.onload = function (event) {

                    let preview = document.getElementById("avatar-preview");

                    if (preview.tagName !== "IMG") {

                        const newImage = document.createElement("img");

                        newImage.id = "avatar-preview";
                        newImage.className = "avatar-preview";
                        newImage.alt = "プロフィール画像";

                        preview.replaceWith(newImage);
                        preview = newImage;
                    }

                    preview.src = event.target.result;
                };

                reader.readAsDataURL(file);

            });

        });
        </script>

    </c:param>
</c:import>
