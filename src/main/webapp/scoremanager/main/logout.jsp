
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:import url="/common/base.jsp">

    <c:param name="title">
        パパトーク｜ログアウト
    </c:param>

    <c:param name="scripts">
        <style>

            * {
                box-sizing: border-box;
            }

            /* ===== 全体 ===== */
            .logout-page {
                display: flex;
                justify-content: center;
                align-items: center;
                width: 100%;
                min-height: 75vh;
                padding: 40px 20px;
                background: #f1ebdd;
            }

            /* ===== メインカード ===== */
            .logout-card {
                width: 100%;
                max-width: 520px;
                padding: 40px;
                text-align: center;
                background: #fffdf8;
                border: 1px solid #d8ccb4;
                border-radius: 5px;
                box-shadow: 0 8px 30px rgba(48, 43, 32, 0.10);
            }

            /* ===== アイコン ===== */
            .logout-icon {
                display: flex;
                align-items: center;
                justify-content: center;
                width: 76px;
                height: 76px;
                margin: 0 auto 25px;
                border: 1px solid #b49a65;
                border-radius: 50%;
                background: #f1ebdd;
                font-size: 32px;
            }

            /* ===== タイトル ===== */
            .logout-title {
                margin: 0 0 18px;
                color: #38372f;
                font-size: 25px;
                font-weight: bold;
                letter-spacing: 2px;
            }

            /* ===== メッセージ ===== */
            .logout-message {
                margin: 0 0 30px;
                color: #776b57;
                font-size: 14px;
                line-height: 2;
                letter-spacing: 1px;
            }

            /* ===== ボタンエリア ===== */
            .logout-buttons {
                display: flex;
                flex-direction: column;
                gap: 14px;
            }

            .logout-buttons form {
                width: 100%;
                margin: 0;
            }

            /* ===== ボタン共通 ===== */
            .logout-confirm,
            .logout-back {
                display: flex;
                justify-content: center;
                align-items: center;
                width: 100%;
                min-height: 48px;
                padding: 12px 20px;
                border-radius: 4px;
                font-size: 14px;
                font-weight: bold;
                letter-spacing: 2px;
                cursor: pointer;
                transition: 0.2s;
            }

            /* ===== ログアウトする ===== */
            .logout-confirm {
                border: 1px solid #8b3d35;
                background: #8b3d35;
                color: #fffdf8;
            }

            .logout-confirm:hover {
                background: #71312b;
                border-color: #71312b;
                transform: translateY(-2px);
            }

            /* ===== 戻る ===== */
            .logout-back {
                border: 1px solid #b49a65;
                background: #fffdf8;
                color: #38372f;
            }

            .logout-back:hover {
                background: #faf6ed;
                border-color: #8b3d35;
                color: #8b3d35;
                transform: translateY(-2px);
            }

            /* ===== フォーカス ===== */
            .logout-confirm:focus-visible,
            .logout-back:focus-visible {
                outline: 3px solid #b49a65;
                outline-offset: 3px;
            }

            /* ===== 管理者 ===== */
            .admin .logout-icon {
                background: #292c29;
                border: 2px solid #b49a65;
                color: #d8c39a;
            }

            .admin .logout-title {
                color: #292c29;
            }

            .admin .logout-confirm {
                background: #292c29;
                border-color: #292c29;
                color: #f1ebdd;
            }

            .admin .logout-confirm:hover {
                background: #454943;
                border-color: #b49a65;
            }

            .admin .logout-back {
                background: #fffdf8;
                border-color: #b49a65;
                color: #38372f;
            }

            .admin .logout-back:hover {
                background: #faf6ed;
                border-color: #8b3d35;
                color: #8b3d35;
            }

            /* ===== スマートフォン ===== */
            @media screen and (max-width: 576px) {

                .logout-page {
                    padding: 25px 12px;
                }

                .logout-card {
                    padding: 32px 20px;
                }

                .logout-title {
                    font-size: 21px;
                }

                .logout-message {
                    font-size: 13px;
                }

                .logout-confirm,
                .logout-back {
                    font-size: 13px;
                }
            }

        </style>
    </c:param>

    <c:param name="content">

        <c:choose>

            <%-- ===== 管理者の場合 ===== --%>
            <c:when test="${sessionScope.user.user_status == 9}">

                <div class="logout-page admin">

                    <div class="logout-card">

                        <div class="logout-icon">
                            ⚙
                        </div>

                        <h2 class="logout-title">
                            管理者ログアウト
                        </h2>

                        <p class="logout-message">
                            パパトークシステムの管理画面をご利用いただきありがとうございます。<br>
                            ログアウトしますか？
                        </p>

                        <div class="logout-buttons">

                            <form action="/papatalk/scoremanager/main/LogoutControl.action"
                                  method="post">

                                <button type="submit"
                                        name="action"
                                        value="ログアウトする"
                                        class="logout-confirm">
                                    ログアウトする
                                </button>

                            </form>

                            <form action="/papatalk/scoremanager/main/LogoutControl.action"
                                  method="get">

                                <button type="submit"
                                        name="action"
                                        value="戻る"
                                        class="logout-back">
                                    管理画面に戻る
                                </button>

                            </form>

                        </div>

                    </div>

                </div>

            </c:when>

            <%-- ===== 一般ユーザーの場合 ===== --%>
            <c:otherwise>

                <div class="logout-page normal">

                    <div class="logout-card">

                        <div class="logout-icon">
                            💬
                        </div>

                        <h2 class="logout-title">
                            ログアウトしますか？
                        </h2>

                        <p class="logout-message">
                            ぱぱトークをご利用いただきありがとうございます。<br>
                            またいつでも戻ってきてくださいね。
                        </p>

                        <div class="logout-buttons">

                            <form action="/papatalk/scoremanager/main/LogoutControl.action"
                                  method="post">

                                <button type="submit"
                                        name="action"
                                        value="ログアウトする"
                                        class="logout-confirm">
                                    ログアウトする
                                </button>

                            </form>

                            <form action="/papatalk/scoremanager/main/LogoutControl.action"
                                  method="get">

                                <button type="submit"
                                        name="action"
                                        value="戻る"
                                        class="logout-back">
                                    戻る
                                </button>

                            </form>

                        </div>

                    </div>

                </div>

            </c:otherwise>

        </c:choose>

    </c:param>

</c:import>
