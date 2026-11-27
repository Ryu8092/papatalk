
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:import url="/common/base.jsp">

    <c:param name="title">
        パパトークシステム｜通報履歴
    </c:param>

    <c:param name="scripts">
        <style>
            /* 全体 */
            .history-page {
                width: 100%;
                min-height: 75vh;
                display: flex;
                justify-content: center;
                align-items: center;
                padding: 30px 20px;
                box-sizing: border-box;
                background-color: #f1ebdd;
                font-family: "Yu Gothic", "Meiryo", sans-serif;
                letter-spacing: 0.05em;
            }

            /* 外側の枠 */
            .history-container {
                width: 100%;
                max-width: 850px;
                min-height: 490px;
                padding: 25px 45px 30px;
                box-sizing: border-box;
                display: flex;
                flex-direction: column;
                background-color: #fffdf8;
                border: 1px solid #d8ccb4;
                border-radius: 5px;
                box-shadow: 0 4px 12px rgba(50, 40, 20, 0.08);
            }

            /* タイトル */
            .history-title {
                text-align: center;
                font-size: 28px;
                font-weight: bold;
                color: #292c29;
                margin: 5px 0 25px;
            }

            .history-line {
                border: none;
                border-top: 2px solid #b49a65;
                margin-bottom: 30px;
            }

            /* ユーザー一覧 */
            .history-list {
                width: 85%;
                margin: 0 auto;
                display: flex;
                flex-direction: column;
                gap: 18px;
            }

            /* ユーザーの枠 */
            .history-item {
                width: 100%;
                min-height: 60px;
                display: flex;
                align-items: center;
                gap: 15px;
                padding: 12px 20px;
                box-sizing: border-box;
                background-color: #fffdf8;
                border: 1px solid #d8ccb4;
                border-left: 4px solid #b49a65;
                border-radius: 4px;
                transition: 0.2s;
            }

            .history-item:hover {
                background-color: #f5f0e5;
            }

            .user-name {
                color: #292c29;
                font-size: 16px;
                font-weight: bold;
                overflow-wrap: anywhere;
            }

            .user-status {
                flex-shrink: 0;
                color: #a94442;
                font-size: 14px;
                font-weight: bold;
            }

            /* ユーザー詳細ボタン */
            .detail-button {
                width: 100%;
                display: flex;
                justify-content: space-between;
                align-items: center;
                gap: 15px;
                padding: 0;
                background: transparent;
                border: none;
                text-align: left;
                cursor: pointer;
                font-family: inherit;
                letter-spacing: inherit;
            }

            /* 履歴がない場合 */
            .no-history {
                text-align: center;
                font-size: 16px;
                color: #8b806d;
                margin: 0 auto;
                padding: 25px;
                width: 85%;
                box-sizing: border-box;
                background-color: #f7f3ea;
                border: 1px dashed #d8ccb4;
                border-radius: 4px;
            }

            /* 戻るボタンエリア */
            .back-area {
                display: flex;
                justify-content: center;
                margin-top: auto;
                padding-top: 35px;
            }

            /* 戻るボタン */
            .back-button {
                min-width: 110px;
                padding: 10px 25px;
                background-color: #292c29;
                border: 1px solid #292c29;
                border-radius: 4px;
                color: #fffdf8;
                font-size: 14px;
                letter-spacing: 0.08em;
                cursor: pointer;
                transition: 0.2s;
            }

            .back-button:hover {
                background-color: #b49a65;
                border-color: #b49a65;
            }

            @media screen and (max-width: 768px) {
                .history-container {
                    padding: 20px 15px 25px;
                }

                .history-title {
                    font-size: 24px;
                }

                .history-list {
                    width: 100%;
                }

                .history-item {
                    padding: 12px;
                }

                .user-name {
                    font-size: 14px;
                }

                .user-status {
                    font-size: 12px;
                }

                .no-history {
                    width: 100%;
                }
            }

            @media screen and (max-width: 520px) {
                .history-page {
                    padding: 15px 10px;
                }

                .history-title {
                    font-size: 21px;
                }

                .history-item {
                    gap: 8px;
                    padding: 10px;
                }

                .user-name {
                    font-size: 13px;
                }

                .user-status {
                    font-size: 11px;
                }
            }
        </style>
    </c:param>

    <c:param name="content">

        <div class="history-page">

            <div class="history-container">

                <!-- タイトル -->
                <h1 class="history-title">
                    通報履歴
                </h1>

                <hr class="history-line">

                <!-- BANされたユーザー一覧 -->
                <c:choose>

                    <c:when test="${not empty userList}">

                        <div class="history-list">

                            <c:forEach var="user" items="${userList}">

                                <div class="history-item">

                                    <form action="/papatalk/scoremanager/main/BanScreenDisplay.action"
                                          method="get">

                                        <input type="hidden"
                                               name="user_id"
                                               value="${user.user_id}">

                                        <button type="submit"
                                                class="detail-button">

                                            <span class="user-name">
                                                <c:out value="${user.user_name}" />
                                            </span>

                                            <span class="user-status">
                                                アカウント停止中
                                            </span>

                                        </button>

                                    </form>

                                </div>

                            </c:forEach>

                        </div>

                    </c:when>

                    <c:otherwise>

                        <p class="no-history">
                            BANした人はいません
                        </p>

                    </c:otherwise>

                </c:choose>

                <!-- 一番下・中央の戻るボタン -->
                <div class="back-area">

                    <form action="/papatalk/scoremanager/main/Operation.action"
                          method="get">

                        <button type="submit" class="back-button">
                            戻る
                        </button>

                    </form>

                </div>

            </div>

        </div>

    </c:param>

</c:import>
