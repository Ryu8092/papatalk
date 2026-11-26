<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:import url="/common/base.jsp">

    <c:param name="title">
        パパトークシステム｜イベント参加予定者
    </c:param>

    <c:param name="scripts">
        <style>
            /* 画面全体 */
            .participant-container {
                background-color: #f1ebdd;
                min-height: 70vh;
                padding: 35px 20px;
            }

            /* メインカード */
            .participant-main-card {
                max-width: 1100px;
                margin: 0 auto;
                background-color: #fffdf8;
                border: 1px solid #d8ccb4;
                border-radius: 5px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
                overflow: hidden;
            }

            /* ヘッダー */
            .participant-main-header {
                background-color: #292c29;
                color: #fffdf8;
                padding: 25px 35px 30px;
                text-align: center;
                border-bottom: 4px solid #b49a65;
            }

            .participant-header-top {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 25px;
            }

            .participant-admin-label {
                font-size: 12px;
                letter-spacing: 2px;
                color: #d3bd8d;
                font-weight: bold;
            }

            .participant-system-label {
                font-size: 10px;
                letter-spacing: 1.5px;
                color: #c7c2b5;
            }

            .participant-main-header h2 {
                margin: 0;
                font-size: 27px;
                font-weight: bold;
                letter-spacing: 3px;
                color: #fffdf8;
            }

            .participant-subtitle {
                margin-top: 8px;
                font-size: 11px;
                letter-spacing: 3px;
                color: #d3bd8d;
            }

            /* ヘッダー装飾 */
            .participant-decoration {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 12px;
                margin-top: 22px;
            }

            .participant-decoration-line {
                width: 55px;
                height: 1px;
                background-color: #b49a65;
            }

            .participant-decoration-diamond {
                width: 8px;
                height: 8px;
                background-color: #b49a65;
                transform: rotate(45deg);
            }

            /* コンテンツ */
            .participant-content-area {
                padding: 35px 45px 25px;
            }

            .participant-title {
                font-size: 19px;
                font-weight: bold;
                color: #38372f;
                padding-bottom: 15px;
                margin-bottom: 25px;
                border-bottom: 1px solid #d8ccb4;
            }

            /* 参加者一覧 */
            .participant-list {
                display: flex;
                flex-direction: column;
                gap: 18px;
            }

            .participant-card {
                background-color: #faf6ed;
                border: 1px solid #ded4c1;
                border-left: 4px solid #b49a65;
                border-radius: 4px;
                padding: 22px 25px;
            }

            .participant-info p {
                display: flex;
                align-items: flex-start;
                margin: 0;
                padding: 10px 0;
                border-bottom: 1px solid #e8dfd0;
                font-size: 14px;
            }

            .participant-info p:last-child {
                border-bottom: none;
            }

            .participant-label {
                display: inline-block;
                width: 130px;
                min-width: 130px;
                color: #746b59;
                font-weight: bold;
            }

            .participant-value {
                color: #38372f;
                overflow-wrap: anywhere;
            }

            /* 参加者がいない場合 */
            .no-participant {
                background-color: #faf6ed;
                border: 1px solid #ded4c1;
                border-radius: 4px;
                padding: 45px 20px;
                text-align: center;
                color: #746b59;
                font-size: 14px;
            }

            .empty-icon {
                font-size: 30px;
                color: #b49a65;
                margin-bottom: 12px;
            }

            /* 戻るボタンエリア */
            .button-area {
                display: flex;
                justify-content: center;
                align-items: center;
                margin-top: 35px;
                padding: 25px 0 30px;
                border-top: 1px solid #ded4c1;
            }

            .button-area form {
                margin: 0;
            }

            /* 戻るボタン */
            .btn-back {
                width: 230px;
                height: 48px;
                background-color: #292c29;
                color: #fffdf8;
                border: none;
                border-radius: 4px;
                font-size: 14px;
                font-weight: bold;
                text-align: center;
                cursor: pointer;
                transition: 0.2s;
            }

            .btn-back:hover {
                background-color: #454941;
            }

            /* フッター */
            .participant-bottom {
                margin-top: 5px;
                padding-top: 18px;
                border-top: 1px solid #ded4c1;
                text-align: center;
                color: #a49a87;
                font-size: 10px;
                letter-spacing: 1.5px;
            }

            /* タブレット */
            @media screen and (max-width: 768px) {
                .participant-container {
                    padding: 20px 12px;
                }

                .participant-main-header {
                    padding: 22px 20px 25px;
                }

                .participant-content-area {
                    padding: 25px 20px;
                }

                .participant-main-header h2 {
                    font-size: 23px;
                }

                .participant-header-top {
                    gap: 10px;
                }
            }

            /* スマートフォン */
            @media screen and (max-width: 520px) {
                .participant-header-top {
                    flex-direction: column;
                    gap: 6px;
                }

                .participant-main-header h2 {
                    font-size: 20px;
                }

                .participant-content-area {
                    padding: 22px 15px;
                }

                .participant-card {
                    padding: 15px;
                }

                .participant-info p {
                    flex-direction: column;
                    gap: 5px;
                }

                .participant-label {
                    width: auto;
                    min-width: auto;
                }

                .btn-back {
                    width: 230px;
                    max-width: 100%;
                }
            }
        </style>
    </c:param>

    <c:param name="content">

        <div class="participant-container">

            <div class="participant-main-card">

                <!-- ヘッダー -->
                <div class="participant-main-header">

                    <div class="participant-header-top">

                        <div class="participant-admin-label">
                            ADMINISTRATOR
                        </div>

                        <div class="participant-system-label">
                            PAPATALK MANAGEMENT SYSTEM
                        </div>

                    </div>

                    <h2>イベント参加予定者</h2>

                    <div class="participant-subtitle">
                        EVENT PARTICIPANTS
                    </div>

                    <div class="participant-decoration">
                        <div class="participant-decoration-line"></div>
                        <div class="participant-decoration-diamond"></div>
                        <div class="participant-decoration-line"></div>
                    </div>

                </div>

                <!-- コンテンツ -->
                <div class="participant-content-area">

                    <h3 class="participant-title">
                        参加予定者一覧
                    </h3>

                    <div class="participant-list">

                        <c:choose>

                            <c:when test="${not empty expectedParticipantsList}">

                                <c:forEach var="participant"
                                    items="${expectedParticipantsList}">

                                    <div class="participant-card">

                                        <div class="participant-info">

                                            <p>
                                                <span class="participant-label">
                                                    名前
                                                </span>

                                                <span class="participant-value">
                                                    <c:out value="${participant.user_name}" />
                                                </span>
                                            </p>

                                            <p>
                                                <span class="participant-label">
                                                    メールアドレス
                                                </span>

                                                <span class="participant-value">
                                                    <c:out value="${participant.email}" />
                                                </span>
                                            </p>

                                            <p>
                                                <span class="participant-label">
                                                    電話番号
                                                </span>

                                                <span class="participant-value">
                                                    <c:out value="${participant.tel}" />
                                                </span>
                                            </p>

                                            <p>
                                                <span class="participant-label">
                                                    大人人数
                                                </span>

                                                <span class="participant-value">
                                                    <c:out value="${participant.adultnumber}" /> 人
                                                </span>
                                            </p>

                                            <p>
                                                <span class="participant-label">
                                                    子供人数
                                                </span>

                                                <span class="participant-value">
                                                    <c:out value="${participant.childnumber}" /> 人
                                                </span>
                                            </p>

                                        </div>

                                    </div>

                                </c:forEach>

                            </c:when>

                            <c:otherwise>

                                <div class="no-participant">

                                    <div class="empty-icon">◇</div>

                                    現在、このイベントの参加予定者はいません。

                                </div>

                            </c:otherwise>

                        </c:choose>

                    </div>

                    <!-- 戻るボタン -->
                    <div class="button-area">

                        <form action="/papatalk/scoremanager/main/RetrieveListOrganizers.action"
                            method="get">

                            <button type="submit" class="btn-back">
                                戻る
                            </button>

                        </form>

                    </div>

                    <!-- フッター -->
                    <div class="participant-bottom">
                        PAPATALK SYSTEM ｜ EVENT MANAGEMENT
                    </div>

                </div>

            </div>

        </div>

    </c:param>

</c:import>