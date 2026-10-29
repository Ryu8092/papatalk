<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:import url="/common/base.jsp">
    <c:param name="title">ぱぱトーク｜ログイン</c:param>
    <c:param name="scripts"></c:param>
    <c:param name="content">
        <style>
            .papa-login-page {
                min-height: 78vh;
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 40px 16px;
                background: #f4f7fb;
            }

            .papa-login-card {
                width: 100%;
                max-width: 460px;
                overflow: hidden;
                border: none;
                border-radius: 20px;
                background: #ffffff;
                box-shadow: 0 10px 35px rgba(31, 55, 85, 0.10);
            }

            .papa-brand {
                padding: 30px 24px 24px;
                text-align: center;
                background: linear-gradient(135deg, #24476b, #3976a5);
                color: white;
            }

            .papa-brand-icon {
                display: inline-flex;
                align-items: center;
                justify-content: center;
                width: 66px;
                height: 66px;
                margin-bottom: 12px;
                border-radius: 22px;
                background: #ffffff;
                color: #ed9145;
                font-size: 32px;
            }

            .papa-brand h1 {
                margin: 0;
                font-size: 29px;
                font-weight: 800;
                letter-spacing: 1px;
            }

            .papa-brand p {
                margin: 10px 0 0;
                font-size: 14px;
                color: #edf5ff;
            }

            .papa-login-body {
                padding: 30px;
            }

            .papa-welcome {
                margin-bottom: 24px;
                text-align: center;
            }

            .papa-welcome h2 {
                color: #243b53;
                font-size: 23px;
                font-weight: 700;
            }

            .papa-welcome p {
                margin-bottom: 0;
                color: #718096;
                font-size: 14px;
            }

            .papa-login-body .form-control {
                min-height: 52px;
                border-radius: 10px;
                border-color: #dce4ed;
            }

            .papa-login-body .form-control:focus {
                border-color: #3976a5;
                box-shadow: 0 0 0 0.2rem rgba(57, 118, 165, 0.15);
            }

            .papa-field-label {
                display: block;
                margin-bottom: 8px;
                color: #34495e;
                font-size: 14px;
                font-weight: 600;
            }

            .papa-login-button {
                width: 100%;
                min-height: 52px;
                margin-top: 8px;
                border: none;
                border-radius: 12px;
                background: #ed9145;
                color: #ffffff;
                font-size: 17px;
                font-weight: 700;
                transition: background 0.2s, transform 0.2s;
            }

            .papa-login-button:hover {
                background: #d97b2e;
                color: #ffffff;
                transform: translateY(-1px);
            }

            /* 新規会員登録ボタン */
            .papa-register-button {
                width: 100%;
                min-height: 52px;
                margin-top: 12px;
                border: 2px solid #3976a5;
                border-radius: 12px;
                background: #ffffff;
                color: #3976a5;
                font-size: 17px;
                font-weight: 700;
                transition: background 0.2s, color 0.2s;
            }

            .papa-register-button:hover {
                background: #3976a5;
                color: #ffffff;
            }

            .papa-password-check {
                display: flex;
                align-items: center;
                gap: 8px;
                margin: 16px 0;
                color: #526579;
                font-size: 14px;
            }

            .papa-password-check input {
                width: 16px;
                height: 16px;
                accent-color: #3976a5;
            }

            .papa-login-footer {
                margin-top: 22px;
                text-align: center;
                color: #8291a3;
                font-size: 12px;
            }

            @media (max-width: 576px) {
                .papa-login-page {
                    padding: 24px 12px;
                }

                .papa-login-body {
                    padding: 24px 20px;
                }

                .papa-brand h1 {
                    font-size: 25px;
                }
            }
        </style>

        <div class="papa-login-page">
            <div class="card papa-login-card">

                <!-- パパトークのロゴ風ヘッダー -->
                <div class="papa-brand">
                    <div class="papa-brand-icon" aria-hidden="true">
                        💬
                    </div>
                    <h1>ぱぱトーク</h1>
                    <p>つながる、話せる、支え合える。</p>
                </div>

                <div class="papa-login-body">

                    <div class="papa-welcome">
                        <h2>おかえりなさい！</h2>
                        <p>アカウントにログインしてください。</p>
                    </div>

                    <!-- エラーメッセージ -->
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger py-2" role="alert">
                            <c:out value="${error}" />
                        </div>
                    </c:if>

                    <!-- ログイン処理 -->
                    <form method="post"
                        action="LoginSelection.action">

                        <!-- ユーザー名 -->
                        <div class="mb-4">
                            <label class="papa-field-label"
                                for="user_name">
                                ユーザー名
                            </label>

                            <input class="form-control"
                                type="text"
                                name="user_name"
                                id="user_name"
                                value="<c:out value='${user_name}'/>"
                                placeholder="登録したユーザー名"
                                autocomplete="username"
                                required>
                        </div>

                        <!-- パスワード -->
                        <div class="mb-2">
                            <label class="papa-field-label"
                                for="password">
                                パスワード
                            </label>

                            <input class="form-control"
                                type="password"
                                name="password"
                                id="password"
                                placeholder="パスワードを入力"
                                autocomplete="current-password"
                                required>
                        </div>

                        <!-- パスワード表示 -->
                        <label class="papa-password-check"
                            for="chk_d_ps">
                            <input class="form-check-input"
                                type="checkbox"
                                id="chk_d_ps">
                            パスワードを表示する
                        </label>

                        <!-- ログインボタン -->
                        <button class="btn papa-login-button"
                            type="submit"
                            name="login"
                            value="ログイン">
                            ログイン →
                        </button>

                    </form>

                    <!-- 新規会員登録 -->
                    <form method="post"
                        action="/papatalk/scoremanager/main/MailDisplay.action">

                        <button class="btn papa-register-button"
                            type="submit">
                            新規会員登録 →
                        </button>

                    </form>

                    <div class="papa-login-footer">
                        安心して利用できる、あなたのコミュニティ。
                    </div>

                </div>
            </div>
        </div>

        <!-- パスワード表示切り替え -->
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const passwordField =
                    document.getElementById('password');

                const showCheckbox =
                    document.getElementById('chk_d_ps');

                if (passwordField && showCheckbox) {
                    showCheckbox.addEventListener('change', function () {
                        passwordField.type =
                            showCheckbox.checked ? 'text' : 'password';
                    });
                }
            });
        </script>
    </c:param>
</c:import>