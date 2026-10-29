
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:import url="/common/base.jsp">
    <c:param name="title" value="パパトーク｜メール認証" />
    <c:param name="scripts" value="" />

    <c:param name="content">
        <div class="verification-page">

            <!-- 進捗バー -->
            <div class="step-container">

                <div class="step-box">
                    <div class="step-number step-inactive">1</div>
                    <div class="step-label">登録</div>
                </div>

                <div class="step-box">
                    <div class="step-number step-active">2</div>
                    <div class="step-label">メール認証</div>
                </div>

                <div class="step-box">
                    <div class="step-number step-inactive">3</div>
                    <div class="step-label">情報を入力</div>
                </div>

                <div class="step-box">
                    <div class="step-number step-inactive">4</div>
                    <div class="step-label">完了</div>
                </div>

            </div>

            <!-- メール認証カード -->
            <div class="verification-card">

                <div class="verification-icon">✉️</div>

                <h2 class="verification-title">
                    メール認証
                </h2>

                <p class="verification-message">
                    確認メールを送信しました。<br>
                    メールに記載された認証コードを入力してください。
                </p>

                <!-- 案内メッセージ -->
                <div class="message-box">
                    <p>
                        入力されたメールアドレスへ、
                        新規アカウント登録確認のメールを送信しました。
                    </p>

                    <p>
                        メール本文にある6桁の認証コードを入力し、
                        「認証する」ボタンを押してください。
                    </p>

                    <p>
                        認証コードの有効期限は30分です。
                        メールが届かない場合は、迷惑メールフォルダもご確認ください。
                    </p>
                </div>
				<c:if test="${not empty message}">
    				<p>${message}</p>
				</c:if>
                <!-- 認証コード入力フォーム -->
                <form action="Proofion.action" method="post">
					
                    <label for="code" class="code-label">
                        6桁の認証コード
                    </label>

                    <input
                        type="text"
                        id="code"
                        name="code"
                        required
                        inputmode="numeric"
                        pattern="[0-9]{6}"
                        maxlength="6"
                        minlength="6"
                        autocomplete="one-time-code"
                        placeholder="例：123456">
					<input type="hidden" name="email"
       					value="<c:out value='${email}'/>">
                    <p class="code-note">
                        ※ パスワードではなく、メールに届いた6桁の数字を入力してください。
                    </p>

                    <button type="submit" class="verification-submit">
                        認証する
                    </button>

                </form>

            </div>

        </div>

        <style>
            /* ページ全体 */
            .verification-page {
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

            /* 認証カード */
            .verification-card {
                box-sizing: border-box;
                width: 100%;
                max-width: 480px;
                margin: 0 auto;
                padding: 40px 30px;
                text-align: center;
                background: #fff;
                border-radius: 20px;
                box-shadow: 0 8px 30px rgba(36, 71, 107, .12);
            }

            /* アイコン */
            .verification-icon {
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

            .verification-title {
                margin: 0 0 14px;
                color: #24476b;
                font-size: 25px;
                font-weight: 800;
            }

            .verification-message {
                margin-bottom: 24px;
                color: #718096;
                font-size: 15px;
                line-height: 1.8;
            }

            /* 案内メッセージ */
            .message-box {
                box-sizing: border-box;
                width: 100%;
                margin-bottom: 25px;
                padding: 18px;
                background: #f5f8fc;
                border: 1px solid #dfe8f1;
                border-radius: 12px;
                text-align: left;
                font-size: 13px;
                line-height: 1.8;
                color: #52677d;
            }

            .message-box p {
                margin: 0 0 12px;
            }

            .message-box p:last-child {
                margin-bottom: 0;
            }

            /* 認証コード入力欄 */
            .code-label {
                display: block;
                margin-bottom: 10px;
                text-align: left;
                color: #24476b;
                font-size: 14px;
                font-weight: 700;
            }

            input[name="code"] {
                box-sizing: border-box;
                width: 100%;
                padding: 14px;
                margin-bottom: 8px;
                border: 1px solid #d7e0e9;
                border-radius: 10px;
                font-size: 24px;
                letter-spacing: 8px;
                text-align: center;
                outline: none;
            }

            input[name="code"]:focus {
                border-color: #2196F3;
                box-shadow: 0 0 0 3px rgba(33, 150, 243, .12);
            }

            .code-note {
                margin: 8px 0 22px;
                color: #718096;
                font-size: 12px;
                line-height: 1.7;
                text-align: left;
            }

            /* 認証ボタン */
            .verification-submit {
                display: block;
                width: 100%;
                padding: 14px;
                border: none;
                border-radius: 10px;
                background: #ed9145;
                color: #fff;
                font-size: 16px;
                font-weight: 700;
                cursor: pointer;
            }

            .verification-submit:hover {
                background: #d97b2e;
            }

            /* スマートフォン対応 */
            @media (max-width: 480px) {
                .verification-card {
                    padding: 30px 20px;
                }

                .verification-title {
                    font-size: 22px;
                }

                .step-label {
                    font-size: 11px;
                }

                .step-number {
                    width: 34px;
                    height: 34px;
                }

                .message-box {
                    padding: 14px;
                }

                input[name="code"] {
                    font-size: 22px;
                    letter-spacing: 6px;
                }
            }
        </style>
    </c:param>
</c:import>