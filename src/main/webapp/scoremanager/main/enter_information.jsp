<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:import url="/common/base.jsp">
    <c:param name="title" value="パパトーク｜情報入力" />
    <c:param name="scripts" value="" />

    <c:param name="content">
        <div class="registration-page">

            <!-- 進捗バー -->
            <div class="step-container">

                <div class="step-box">
                    <div class="step-number step-inactive">1</div>
                    <div class="step-label">登録</div>
                </div>

                <div class="step-box">
                    <div class="step-number step-inactive">2</div>
                    <div class="step-label">メール認証</div>
                </div>

                <div class="step-box">
                    <div class="step-number step-active">3</div>
                    <div class="step-label">情報を入力</div>
                </div>

                <div class="step-box">
                    <div class="step-number step-inactive">4</div>
                    <div class="step-label">完了</div>
                </div>

            </div>

            <!-- 入力フォームカード -->
            <div class="registration-card">

                <h2 class="registration-title">基本情報の入力</h2>

                <p class="registration-message">
                    アカウント登録に必要な情報を入力してください。
                </p>

                <!-- メッセージ -->
                <c:if test="${not empty message}">
                    <div class="message-box">
                        <c:out value="${message}" />
                    </div>
                </c:if>

                <form action="/papatalk/scoremanager/main/Registration.action"
                      method="post"
                      enctype="multipart/form-data">

                    <!-- 名前 -->
                    <div class="form-group">
                        <label for="username">名前</label>
                        <input type="text" id="username" name="username"
                            value="<c:out value='${param.username}'/>" required>

                        <c:if test="${not empty usernameError}">
                            <p class="error-message">
                                <c:out value="${usernameError}"/>
                            </p>
                        </c:if>
                    </div>

                    <!-- メールアドレス -->
                    <div class="form-group">
                        <label for="email">メールアドレス</label>
                        <input type="email" id="email" name="email"
                            value="<c:out value='${email}'/>" readonly>

                        <c:if test="${not empty emailError}">
                            <p class="error-message">
                                <c:out value="${emailError}"/>
                            </p>
                        </c:if>
                    </div>

                    <!-- パスワード -->
                    <div class="form-group">
                        <label for="password">パスワード</label>
                        <input type="password" id="password" name="password"
                            autocomplete="new-password" required>

                        <c:if test="${not empty passwordError}">
                            <p class="error-message">
                                <c:out value="${passwordError}"/>
                            </p>
                        </c:if>
                    </div>

                    <!-- 年齢 -->
                    <div class="form-group">
                        <label for="age">年齢</label>
                        <input type="number" id="age" name="age"
                            min="0" max="150"
                            value="<c:out value='${param.age}'/>" required>

                        <c:if test="${not empty ageError}">
                            <p class="error-message">
                                <c:out value="${ageError}"/>
                            </p>
                        </c:if>
                    </div>

                    <!-- ニックネーム -->
                    <div class="form-group">
                        <label for="nickname">ニックネーム</label>
                        <input type="text" id="nickname" name="nickname"
                            value="<c:out value='${param.nickname}'/>">
                    </div>

                    <!-- 電話番号 -->
                    <div class="form-group">
                        <label for="phone">電話番号</label>
                        <input type="text" id="phone" name="phone"
                            value="<c:out value='${param.phone}'/>" required>

                        <c:if test="${not empty phoneError}">
                            <p class="error-message">
                                <c:out value="${phoneError}"/>
                            </p>
                        </c:if>
                    </div>

                    <!-- 郵便番号 -->
                    <div class="form-group">
                        <label for="zipcode">郵便番号</label>
                        <input type="text" id="zipcode" name="zipcode"
                            value="<c:out value='${param.zipcode}'/>" required>

                        <c:if test="${not empty zipcodeError}">
                            <p class="error-message">
                                <c:out value="${zipcodeError}"/>
                            </p>
                        </c:if>
                    </div>

                    <!-- 都道府県 -->
                    <div class="form-group">
                        <label for="prefecture">都道府県</label>
                        <input type="text" id="prefecture" name="prefecture"
                            value="<c:out value='${param.prefecture}'/>" required>

                        <c:if test="${not empty prefectureError}">
                            <p class="error-message">
                                <c:out value="${prefectureError}"/>
                            </p>
                        </c:if>
                    </div>

                    <!-- 市区町村 -->
                    <div class="form-group">
                        <label for="city">市区町村</label>
                        <input type="text" id="city" name="city"
                            value="<c:out value='${param.city}'/>" required>

                        <c:if test="${not empty cityError}">
                            <p class="error-message">
                                <c:out value="${cityError}"/>
                            </p>
                        </c:if>
                    </div>

                    <!-- 番地 -->
                    <div class="form-group">
                        <label for="address">番地</label>
                        <input type="text" id="address" name="address"
                            value="<c:out value='${param.address}'/>" required>

                        <c:if test="${not empty addressError}">
                            <p class="error-message">
                                <c:out value="${addressError}"/>
                            </p>
                        </c:if>
                    </div>

                    <!-- 建物名 -->
                    <div class="form-group">
                        <label for="building">建物名・部屋番号</label>
                        <input type="text" id="building" name="building"
                            value="<c:out value='${param.building}'/>">
                    </div>

                    <!-- 子どもの年齢 -->
                    <div class="form-group">
                        <label for="child_age">お子さんの年齢</label>
                        <input type="number" id="child_age" name="child_age"
                            min="0" max="150"
                            value="<c:out value='${param.child_age}'/>" required>

                        <c:if test="${not empty childAgeError}">
                            <p class="error-message">
                                <c:out value="${childAgeError}"/>
                            </p>
                        </c:if>
                    </div>

                    <!-- 子どもの性別 -->
                    <div class="form-group">
                        <label for="child_gender">お子さんの性別</label>
                        <select id="child_gender" name="child_gender" required>
                            <option value="">選択してください</option>
                            <option value="男子"
                                ${param.child_gender == '男子' ? 'selected' : ''}>
                                男の子
                            </option>
                            <option value="女子"
                                ${param.child_gender == '女子' ? 'selected' : ''}>
                                女の子
                            </option>
                        </select>

                        <c:if test="${not empty childGenderError}">
                            <p class="error-message">
                                <c:out value="${childGenderError}"/>
                            </p>
                        </c:if>
                    </div>

                    <!-- プロフィール画像 -->
                    <div class="form-group">
                        <label for="avatar">プロフィール画像</label>

                        <div class="file-input-wrapper">
                            <input type="file" id="avatar" name="avatar"
                                accept="image/jpeg,image/png,image/gif"
                                required>
                            <p class="input-note">
                                JPEG・PNG・GIF形式の画像を選択してください。
                            </p>
                        </div>
                    </div>

                    <!-- 送信ボタン -->
                    <button type="submit" class="registration-submit">
                        登録情報を送信する
                    </button>

                </form>

            </div>
        </div>

        <style>
            /* ページ全体 */
            .registration-page {
                padding: 20px 16px 50px;
                font-family: sans-serif;
                color: #24476b;
            }

            /* 進捗バー */
            .step-container {
                display: flex;
                justify-content: space-between;
                gap: 8px;
                width: 100%;
                max-width: 600px;
                margin: 20px auto 40px;
            }

            .step-box {
                flex: 1;
                min-width: 0;
                text-align: center;
            }

            .step-number {
                display: flex;
                align-items: center;
                justify-content: center;
                width: 40px;
                height: 40px;
                margin: 0 auto 10px;
                border-radius: 50%;
                font-weight: bold;
                color: #fff;
            }

            .step-active {
                background-color: #4CAF50;
            }

            .step-inactive {
                background-color: #BDBDBD;
            }

            .step-label {
                font-size: 13px;
                color: #52677d;
            }

            /* 入力カード */
            .registration-card {
                box-sizing: border-box;
                width: 100%;
                max-width: 600px;
                margin: 0 auto;
                padding: 40px 35px;
                background: #fff;
                border-radius: 20px;
                box-shadow: 0 8px 30px rgba(36, 71, 107, .12);
            }

            /* アイコン */
            .registration-icon {
                display: flex;
                align-items: center;
                justify-content: center;
                width: 76px;
                height: 76px;
                margin: 0 auto 22px;
                border-radius: 24px;
                background: #eaf2fa;
                font-size: 36px;
            }

            /* タイトル */
            .registration-title {
                margin: 0 0 14px;
                color: #24476b;
                font-size: 25px;
                font-weight: 800;
                text-align: center;
            }

            .registration-message {
                margin-bottom: 30px;
                color: #718096;
                font-size: 14px;
                line-height: 1.8;
                text-align: center;
            }

            /* 入力グループ */
            .form-group {
                margin-bottom: 22px;
            }

            .form-group label {
                display: block;
                margin-bottom: 9px;
                color: #24476b;
                font-size: 14px;
                font-weight: 700;
            }

            .form-group input:not([type="file"]),
            .form-group select {
                box-sizing: border-box;
                display: block;
                width: 100%;
                padding: 13px 14px;
                border: 1px solid #d7e0e9;
                border-radius: 10px;
                background: #fff;
                color: #334155;
                font-size: 15px;
                outline: none;
                transition: border-color .2s, box-shadow .2s;
            }

            /* フォーカス時 */
            .form-group input:focus,
            .form-group select:focus {
                border-color: #2196F3;
                box-shadow: 0 0 0 3px rgba(33, 150, 243, .12);
            }

            /* メールアドレス */
            .form-group input[readonly] {
                background: #f5f8fc;
                color: #718096;
                cursor: not-allowed;
            }

            /* ファイル選択 */
            .file-input-wrapper {
                padding: 16px;
                background: #f5f8fc;
                border: 1px solid #dfe8f1;
                border-radius: 12px;
            }

            .form-group input[type="file"] {
                width: 100%;
                font-size: 13px;
                color: #52677d;
            }

            .input-note {
                margin: 10px 0 0;
                color: #718096;
                font-size: 12px;
            }

            /* エラーメッセージ */
            .error-message {
                margin: 8px 0 0;
                color: #e05252;
                font-size: 12px;
                line-height: 1.6;
            }

            /* 通常メッセージ */
            .message-box {
                box-sizing: border-box;
                width: 100%;
                margin-bottom: 25px;
                padding: 15px 18px;
                background: #fff4f2;
                border: 1px solid #f3d4ce;
                border-radius: 12px;
                color: #d9534f;
                font-size: 13px;
                line-height: 1.8;
            }

            /* 登録ボタン */
            .registration-submit {
                display: block;
                width: 100%;
                margin: 30px auto 0;
                padding: 15px;
                border: none;
                border-radius: 10px;
                background: #ed9145;
                color: #fff;
                font-size: 16px;
                font-weight: 700;
                cursor: pointer;
                transition: background .2s;
            }

            .registration-submit:hover {
                background: #d97b2e;
            }

            /* スマートフォン対応 */
            @media (max-width: 480px) {
                .registration-card {
                    padding: 30px 20px;
                }

                .registration-title {
                    font-size: 22px;
                }

                .step-label {
                    font-size: 11px;
                }

                .step-number {
                    width: 34px;
                    height: 34px;
                }

                .form-group {
                    margin-bottom: 19px;
                }
            }
        </style>
    </c:param>
</c:import>