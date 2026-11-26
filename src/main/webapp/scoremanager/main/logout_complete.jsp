
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:import url="/common/base.jsp">

    <c:param name="title">
        パパトーク｜ログアウト完了
    </c:param>

    <c:param name="scripts">
        <style>

            * {
                box-sizing: border-box;
            }

            /* ===== 全体 ===== */
            .logout-complete-page {
                display: flex;
                justify-content: center;
                align-items: center;
                width: 100%;
                min-height: 75vh;
                padding: 40px 20px;
                background: #f1ebdd;
            }

            /* ===== メインカード ===== */
            .logout-complete-card {
                width: 100%;
                max-width: 520px;
                padding: 45px 40px;
                text-align: center;
                background: #fffdf8;
                border: 1px solid #d8ccb4;
                border-radius: 5px;
                box-shadow: 0 8px 30px rgba(48, 43, 32, 0.10);
            }

            /* ===== アイコン ===== */
            .complete-icon {
                display: flex;
                justify-content: center;
                align-items: center;
                width: 78px;
                height: 78px;
                margin: 0 auto 25px;
                border-radius: 50%;
                font-size: 38px;
                font-weight: bold;
            }

            /* ===== タイトル ===== */
            .complete-title {
                margin: 0 0 20px;
                font-size: 25px;
                font-weight: bold;
                letter-spacing: 2px;
            }

            /* ===== メッセージ ===== */
            .complete-message {
                margin: 0 0 30px;
                font-size: 14px;
                line-height: 2;
                letter-spacing: 1px;
            }

            /* ===== ログインボタン ===== */
            .complete-login-button {
                display: flex;
                justify-content: center;
                align-items: center;
                width: 100%;
                min-height: 50px;
                padding: 13px 20px;
                border: 1px solid #292c29;
                border-radius: 4px;
                background: #292c29;
                color: #f1ebdd;
                font-size: 14px;
                font-weight: bold;
                letter-spacing: 2px;
                cursor: pointer;
                transition: 0.2s;
            }

            .complete-login-button:hover {
                background: #454943;
                border-color: #b49a65;
                color: #fffdf8;
                transform: translateY(-2px);
            }

            .complete-login-button:focus-visible {
                outline: 3px solid #b49a65;
                outline-offset: 3px;
            }

            /* ===== ブランド表記 ===== */
            .complete-brand {
                margin-top: 28px;
                padding-top: 20px;
                border-top: 1px solid #e3dac9;
                font-size: 11px;
                letter-spacing: 2px;
            }

            .logout-complete-card form {
                margin: 0;
            }

            /* ===== 一般ユーザー ===== */
            .normal .complete-icon {
                background: #f1ebdd;
                color: #8b3d35;
                border: 1px solid #d8ccb4;
            }

            .normal .complete-title {
                color: #38372f;
            }

            .normal .complete-message {
                color: #776b57;
            }

            .normal .complete-brand {
                color: #a69a83;
            }

            /* ===== 管理者 ===== */
            .admin .complete-icon {
                background: #292c29;
                color: #d8c39a;
                border: 2px solid #b49a65;
            }

            .admin .complete-title {
                color: #292c29;
            }

            .admin .complete-message {
                color: #776b57;
            }

            .admin .complete-brand {
                color: #a69a83;
            }

            /* ===== スマートフォン ===== */
            @media screen and (max-width: 576px) {

                .logout-complete-page {
                    padding: 25px 12px;
                }

                .logout-complete-card {
                    padding: 35px 20px;
                }

                .complete-title {
                    font-size: 21px;
                }

                .complete-message {
                    font-size: 13px;
                }

                .complete-brand {
                    font-size: 10px;
                }
            }

        </style>
    </c:param>

    <c:param name="content">

        <c:choose>

            <%-- ===== 管理者用 ===== --%>
            <c:when test="${requestScope.userStatus == 9}">

                <div class="logout-complete-page admin">

                    <div class="logout-complete-card">

                        <div class="complete-icon">
                            ✓
                        </div>

                        <h2 class="complete-title">
                            管理者ログアウト完了
                        </h2>

                        <p class="complete-message">
                            パパトークシステムの管理業務を<br>
                            お疲れさまでした。<br>
                            ログアウトしました。
                        </p>

                        <c:url value="/scoremanager/Login.action"
                            var="url_login" />

                        <form action="${url_login}" method="get">

                            <button type="submit"
                                class="complete-login-button">
                                ログイン画面に戻る →
                            </button>

                        </form>

                        <div class="complete-brand">
                            パパトークシステム｜管理者ページ
                        </div>

                    </div>

                </div>

            </c:when>

            <%-- ===== 一般ユーザー用 ===== --%>
            <c:otherwise>

                <div class="logout-complete-page normal">

                    <div class="logout-complete-card">

                        <div class="complete-icon">
                            ✓
                        </div>

                        <h2 class="complete-title">
                            ログアウトしました
                        </h2>

                        <p class="complete-message">
                            ぱぱトークをご利用いただき、<br>
                            ありがとうございました。<br>
                            またのご利用をお待ちしています。
                        </p>

                        <c:url value="/scoremanager/Login.action"
                            var="url_login" />

                        <form action="${url_login}" method="get">

                            <button type="submit"
                                class="complete-login-button">
                                ログイン画面に戻る →
                            </button>

                        </form>

                        <div class="complete-brand">
                            ぱぱトーク｜つながる、話せる、支え合える。
                        </div>

                    </div>

                </div>

            </c:otherwise>

        </c:choose>

    </c:param>

</c:import>
