
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<c:import url="/common/base.jsp">

    <c:param name="title">パパトークシステム｜BANユーザー詳細</c:param>

    <c:param name="scripts">
        <style>
            .detail-page {
                max-width: 1100px;
                margin: 30px auto;
                padding: 20px;
                background: #f1ebdd;
                min-height: 70vh;
                box-sizing: border-box;
            }

            .detail-page * {
                box-sizing: border-box;
            }

            .detail-container {
                background: #fffdf8;
                border: 1px solid #d8ccb4;
                border-radius: 5px;
                box-shadow: 0 3px 12px rgba(50, 45, 35, 0.08);
                overflow: hidden;
            }

            /* 管理者画面ヘッダー */
            .detail-header {
                background: #292c29;
                color: #fffdf8;
                padding: 25px 35px;
                border-bottom: 4px solid #b49a65;
            }

            .admin-label {
                color: #c8b27f;
                font-size: 11px;
                font-weight: bold;
                letter-spacing: 3px;
                margin-bottom: 8px;
            }

            .system-name {
                color: #e8dfcd;
                font-size: 12px;
                letter-spacing: 2px;
                margin-bottom: 12px;
            }

            .detail-title {
                color: #fffdf8;
                font-size: 23px;
                font-weight: bold;
                margin: 0;
            }

            .header-decoration {
                color: #b49a65;
                font-size: 14px;
                margin-top: 12px;
            }

            /* 詳細内容 */
            .detail-content {
                padding: 35px;
            }

            .status-area {
                margin-bottom: 25px;
                padding: 16px 20px;
                background: #f8e9e5;
                border: 1px solid #d9b9ad;
                border-left: 5px solid #8b3d35;
                border-radius: 4px;
                color: #8b3d35;
                font-weight: bold;
            }

            .detail-list {
                display: flex;
                flex-direction: column;
                background: #faf6ed;
                border: 1px solid #ded4c1;
                border-radius: 4px;
                overflow: hidden;
            }

            .detail-row {
                display: flex;
                padding: 18px 20px;
                border-bottom: 1px solid #e3dac9;
            }

            .detail-row:last-child {
                border-bottom: none;
            }

            .detail-label {
                width: 180px;
                flex-shrink: 0;
                color: #776b57;
                font-weight: bold;
            }

            .detail-value {
                color: #38372f;
                overflow-wrap: anywhere;
            }

            /* メッセージ */
            .message {
                padding: 13px 16px;
                margin-bottom: 20px;
                border-radius: 4px;
                font-size: 14px;
            }

            .success-message {
                background: #e9f1e7;
                border: 1px solid #c8d8c3;
                color: #3f6840;
            }

            .error-message {
                background: #f8e9e5;
                border: 1px solid #dfc0b8;
                color: #8b3d35;
            }

            /* ボタンエリア */
            .action-area {
                display: flex;
                justify-content: center;
                margin-top: 30px;
            }

            .release-button {
                width: 230px;
                height: 48px;
                background: #8b3d35;
                color: #fffdf8;
                border: none;
                border-radius: 4px;
                font-size: 14px;
                font-weight: bold;
                cursor: pointer;
                transition: 0.2s;
            }

            .release-button:hover {
                background: #713029;
            }

            .bottom-buttons {
                display: flex;
                justify-content: center;
                align-items: center;
                margin-top: 35px;
                padding: 25px 0 10px;
                border-top: 1px solid #ded4c1;
            }

            .back-form {
                width: 230px;
                margin: 0;
            }

            .back-button {
                width: 230px;
                height: 48px;
                background: #292c29;
                color: #fffdf8;
                border: none;
                border-radius: 4px;
                font-size: 14px;
                font-weight: bold;
                cursor: pointer;
                transition: 0.2s;
            }

            .back-button:hover {
                background: #454943;
            }

            .no-data {
                padding: 25px;
                text-align: center;
                color: #776b57;
                background: #faf6ed;
                border: 1px solid #ded4c1;
                border-radius: 4px;
            }

            @media (max-width: 768px) {
                .detail-page {
                    padding: 10px;
                }

                .detail-header {
                    padding: 22px 20px;
                }

                .detail-content {
                    padding: 22px 18px;
                }

                .detail-title {
                    font-size: 20px;
                }
            }

            @media (max-width: 520px) {
                .detail-row {
                    flex-direction: column;
                    gap: 7px;
                }

                .detail-label {
                    width: 100%;
                }

                .release-button,
                .back-button,
                .back-form {
                    width: 100%;
                }

                .bottom-buttons {
                    padding-top: 20px;
                }
            }
        </style>
    </c:param>

    <c:param name="content">

        <div class="detail-page">

            <div class="detail-container">

                <!-- 管理者画面ヘッダー -->
                <div class="detail-header">
                    <div class="admin-label">ADMINISTRATOR</div>

                    <div class="system-name">
                        PAPATALK MANAGEMENT SYSTEM
                    </div>

                    <h2 class="detail-title">BANユーザー詳細</h2>

                    <div class="header-decoration">
                        ◆　USER ACCOUNT MANAGEMENT
                    </div>
                </div>

                <div class="detail-content">

                    <!-- メッセージ表示 -->
                    <c:if test="${not empty successMessage}">
                        <div class="message success-message">
                            <c:out value="${successMessage}" />
                        </div>
                    </c:if>

                    <c:if test="${not empty errorMessage}">
                        <div class="message error-message">
                            <c:out value="${errorMessage}" />
                        </div>
                    </c:if>

                    <c:choose>

                        <c:when test="${not empty target_user}">

                            <!-- BAN状態 -->
                            <div class="status-area">
                                現在、このユーザーはアカウント停止中です。
                            </div>

                            <!-- ユーザー情報 -->
                            <div class="detail-list">

                                <div class="detail-row">
                                    <div class="detail-label">
                                        ユーザーID
                                    </div>

                                    <div class="detail-value">
                                        <c:out value="${target_user.user_id}" />
                                    </div>
                                </div>

                                <div class="detail-row">
                                    <div class="detail-label">
                                        ユーザー名
                                    </div>

                                    <div class="detail-value">
                                        <c:out value="${target_user.user_name}" />
                                    </div>
                                </div>

                            </div>

                            <!-- BAN解除ボタン -->
                            <div class="action-area">
                                <form
                                    action="/papatalk/scoremanager/main/Update.action"
                                    method="post"
                                    onsubmit="return confirm('このユーザーのBANを解除しますか？');">

                                    <input
                                        type="hidden"
                                        name="user_id"
                                        value="<c:out value='${target_user.user_id}'/>">

                                    <button type="submit" class="release-button">
                                        BANを解除する
                                    </button>

                                </form>
                            </div>

                        </c:when>

                        <c:otherwise>

                            <div class="no-data">
                                ユーザー情報を取得できませんでした。
                            </div>

                        </c:otherwise>

                    </c:choose>

                    <!-- 戻るボタン -->
                    <div class="bottom-buttons">
                        <form
                            action="/papatalk/scoremanager/main/BanHistory.action"
                            method="post"
                            class="back-form">

                            <button type="submit" class="back-button">
                                戻る
                            </button>

                        </form>
                    </div>

                </div>
            </div>
        </div>

    </c:param>

</c:import>
