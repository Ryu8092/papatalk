
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:import url="/common/base.jsp">
    <c:param name="title">パパトークシステム｜パスワード変更</c:param>
    <c:param name="scripts"></c:param>

    <c:param name="content">

        <style>
            .password-layout {
                display: flex;
                gap: 24px;
                align-items: flex-start;
                min-height: 70vh;
            }

            /* 左側サイドバー */
            .password-sidebar {
                flex: 0 0 240px;
                background: #ffffff;
                border-radius: 14px;
                box-shadow: 0 4px 16px rgba(31, 55, 85, 0.08);
                padding: 20px;
            }

            /* 右側メイン */
            .password-main {
                flex: 1;
                min-width: 0;
                padding: 28px;
                background: #ffffff;
                border-radius: 14px;
                box-shadow: 0 4px 16px rgba(31, 55, 85, 0.08);
            }

            /* 見出し */
            .password-title {
                color: #24476b;
                font-size: 26px;
                font-weight: 700;
                padding-bottom: 16px;
                border-bottom: 3px solid #ed9145;
                margin-bottom: 24px;
            }

            .password-description {
                color: #718096;
                font-size: 14px;
                margin-bottom: 24px;
            }

            /* 注意書き */
            .password-notice {
                padding: 13px 16px;
                margin-bottom: 25px;
                color: #24476b;
                background: #f8fafc;
                border-left: 4px solid #ed9145;
                border-radius: 8px;
                font-size: 13px;
            }

            /* 入力フォーム */
            .password-form {
                max-width: 650px;
                margin: 0 auto;
            }

            .password-row {
                min-width: 0;
                margin-bottom: 22px;
            }

            .password-label {
                display: block;
                color: #718096;
                font-size: 13px;
                font-weight: 600;
                margin-bottom: 7px;
            }

            .password-input-area {
                display: flex;
                align-items: center;
                width: 100%;
                min-height: 42px;
                border: 1px solid #dce5ed;
                border-radius: 8px;
                background: #f8fafc;
                overflow: hidden;
                box-sizing: border-box;
            }

            .password-input-area:focus-within {
                border-color: #24476b;
                box-shadow: 0 0 0 2px rgba(36, 71, 107, 0.10);
            }

            .password-input-area input {
                flex: 1;
                min-width: 0;
                padding: 11px 13px;
                border: none;
                outline: none;
                background: transparent;
                color: #2d3748;
                font-size: 14px;
            }

            .password-input-area input::placeholder {
                color: #a0aec0;
            }

            .password-toggle {
                flex-shrink: 0;
                margin-right: 7px;
                padding: 7px 12px;
                color: #24476b;
                background: #e8eef4;
                border: none;
                border-radius: 6px;
                font-size: 12px;
                cursor: pointer;
            }

            .password-toggle:hover {
                background: #dce5ed;
            }

            .password-help {
                display: block;
                margin-top: 7px;
                color: #718096;
                font-size: 12px;
            }

            /* エラー・成功メッセージ */
            .password-error {
                padding: 13px 15px;
                margin-bottom: 20px;
                color: #b42318;
                background: #fff0ee;
                border: 1px solid #f5d0cb;
                border-radius: 8px;
                font-size: 14px;
            }

            .password-success {
                padding: 13px 15px;
                margin-bottom: 20px;
                color: #187344;
                background: #eaf7ef;
                border: 1px solid #ccebd7;
                border-radius: 8px;
                font-size: 14px;
            }

            /* ボタン */
            .password-buttons {
                display: flex;
                justify-content: center;
                gap: 14px;
                flex-wrap: wrap;
                margin-top: 30px;
            }

            .password-button {
                display: inline-block;
                min-width: 150px;
                border: none;
                border-radius: 8px;
                padding: 12px 22px;
                font-size: 14px;
                font-weight: 600;
                text-decoration: none;
                text-align: center;
                cursor: pointer;
                box-sizing: border-box;
            }

            .password-submit {
			    background: #ed9145;
			    color: #ffffff;
			}
			
			.password-submit:hover {
			    background: #d97d32;
}

            .password-back {
                background: #ffffff;
                color: #24476b;
                border: 1px solid #24476b;
            }

            .password-back:hover {
                background: #f0f4f8;
            }

            /* ボタン用フォーム */
            .password-buttons form {
                margin: 0;
            }

            /* スマートフォン */
            @media (max-width: 768px) {
                .password-layout {
                    flex-direction: column;
                }

                .password-sidebar {
                    width: 100%;
                    flex-basis: auto;
                    box-sizing: border-box;
                }

                .password-main {
                    width: 100%;
                    padding: 20px;
                    box-sizing: border-box;
                }

                .password-buttons {
                    flex-direction: column;
                }

                .password-button {
                    width: 100%;
                }
            }
        </style>

        <div class="password-layout">

            <!-- 左側：サイドバー -->
            <aside class="password-sidebar">
                <jsp:include page="/common/sidebar.jsp" />
            </aside>

            <!-- 右側：パスワード変更 -->
            <main class="password-main">

                <h2 class="password-title">パスワード変更</h2>

                <p class="password-description">
                    現在のパスワードを確認して、新しいパスワードに変更できます。
                </p>

                <div class="password-notice">
                    新しいパスワードは8文字以上で設定してください。
                </div>

                <!-- エラーメッセージ -->
                <c:if test="${not empty error}">
                    <div class="password-error">
                        <c:out value="${error}" />
                    </div>
                </c:if>

                <!-- 完了メッセージ -->
                <c:if test="${not empty message}">
                    <div class="password-success">
                        <c:out value="${message}" />
                    </div>
                </c:if>

                <!-- パスワード変更フォーム -->
                <form id="passwordChangeForm"
                    action="PasswordChangeExecute.action"
                    method="post"
                    class="password-form">

                    <!-- 現在のパスワード -->
                    <div class="password-row">

                        <label class="password-label"
                            for="current_password">
                            現在のパスワード
                        </label>

                        <div class="password-input-area">
                            <input
                                type="password"
                                id="current_password"
                                name="current_password"
                                placeholder="現在のパスワードを入力"
                                required
                                autocomplete="current-password">

                            <button type="button"
                                class="password-toggle"
                                onclick="togglePassword('current_password', this)">
                                表示
                            </button>
                        </div>

                    </div>

                    <!-- 新しいパスワード -->
                    <div class="password-row">

                        <label class="password-label"
                            for="new_password">
                            新しいパスワード
                        </label>

                        <div class="password-input-area">
                            <input
                                type="password"
                                id="new_password"
                                name="new_password"
                                placeholder="新しいパスワードを入力"
                                minlength="8"
                                required
                                autocomplete="new-password">

                            <button type="button"
                                class="password-toggle"
                                onclick="togglePassword('new_password', this)">
                                表示
                            </button>
                        </div>

                        <small class="password-help">
                            8文字以上で入力してください。
                        </small>

                    </div>

                    <!-- 新しいパスワード（確認用） -->
                    <div class="password-row">

                        <label class="password-label"
                            for="confirm_password">
                            新しいパスワード（確認用）
                        </label>

                        <div class="password-input-area">
                            <input
                                type="password"
                                id="confirm_password"
                                name="confirm_password"
                                placeholder="新しいパスワードをもう一度入力"
                                minlength="8"
                                required
                                autocomplete="new-password">

                            <button type="button"
                                class="password-toggle"
                                onclick="togglePassword('confirm_password', this)">
                                表示
                            </button>
                        </div>

                    </div>

                </form>

                <!-- ボタン -->
				<div class="password-buttons">
				
				    <!-- 戻るボタン（左側） -->
				    <form action="AccountinFormation.action" method="get">
				        <button type="submit"
				            class="password-button password-back">
				            戻る
				        </button>
				    </form>
				
				    <!-- パスワード変更ボタン（右側） -->
				    <button type="submit"
				        form="passwordChangeForm"
				        class="password-button password-submit">
				        パスワードを変更する
				    </button>
				
				</div>
            </main>

        </div>

        <script>
            function togglePassword(id, button) {
                const input = document.getElementById(id);

                if (input.type === "password") {
                    input.type = "text";
                    button.textContent = "非表示";
                } else {
                    input.type = "password";
                    button.textContent = "表示";
                }
            }
        </script>

    </c:param>
</c:import>
