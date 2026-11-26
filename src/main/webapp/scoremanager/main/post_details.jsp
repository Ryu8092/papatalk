
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:import url="/common/base.jsp">

    <c:param name="title">
        パパトークシステム｜投稿詳細
    </c:param>

    <c:param name="scripts">
        <style>

            * {
                box-sizing: border-box;
            }

            /* ===== 全体 ===== */
            .detail-container {
                width: 100%;
                min-height: 75vh;
                padding: 40px 30px;
                background: #f1ebdd;
            }

            /* ===== メインカード ===== */
            .detail-main-card {
                max-width: 1100px;
                margin: 0 auto;
                background: #fffdf8;
                border: 1px solid #d8ccb4;
                border-radius: 5px;
                overflow: hidden;
                box-shadow: 0 8px 30px rgba(48, 43, 32, 0.10);
            }

            /* ===== ヘッダー ===== */
            .detail-main-header {
                padding: 28px 40px 30px;
                background: #292c29;
                border-bottom: 4px solid #b49a65;
            }

            .detail-header-top {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 25px;
            }

            .detail-admin-label {
                display: inline-block;
                padding: 7px 14px;
                border: 1px solid #88774f;
                color: #d8c39a;
                font-size: 10px;
                font-weight: bold;
                letter-spacing: 2px;
            }

            .detail-system-label {
                font-size: 10px;
                color: #b9ad94;
                letter-spacing: 2px;
            }

            .detail-main-header h2 {
                margin: 0;
                text-align: center;
                color: #f1ebdd;
                font-size: 28px;
                font-weight: bold;
                letter-spacing: 4px;
            }

            .detail-subtitle {
                margin-top: 10px;
                text-align: center;
                color: #b49a65;
                font-size: 10px;
                letter-spacing: 3px;
            }

            /* ===== 装飾 ===== */
            .detail-decoration {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 10px;
                margin-top: 20px;
            }

            .detail-decoration-line {
                width: 45px;
                height: 1px;
                background: #b49a65;
            }

            .detail-decoration-diamond {
                width: 7px;
                height: 7px;
                background: #b49a65;
                transform: rotate(45deg);
            }

            /* ===== コンテンツ ===== */
            .detail-content-area {
                padding: 35px 40px 40px;
            }

            /* ===== メッセージ ===== */
            .message {
                padding: 15px 18px;
                margin-bottom: 20px;
                border-radius: 4px;
                font-size: 13px;
                line-height: 1.7;
            }

            .success-message {
                background: #f5efdf;
                border: 1px solid #b49a65;
                border-left: 4px solid #b49a65;
                color: #66532e;
            }

            .error-message {
                background: #f8eeea;
                border: 1px solid #c99a8d;
                border-left: 4px solid #8b3d35;
                color: #8b3d35;
            }

            /* ===== 各セクションカード ===== */
            .detail-card {
                padding: 28px;
                margin-bottom: 25px;
                background: #fffdf8;
                border: 1px solid #ded4c1;
                border-radius: 4px;
            }

            /* ===== セクションタイトル ===== */
            .section-title {
                margin: 0 0 22px;
                padding-bottom: 13px;
                border-bottom: 1px solid #e3dac9;
                border-left: 4px solid #b49a65;
                padding-left: 14px;
                color: #38372f;
                font-size: 19px;
                font-weight: bold;
                letter-spacing: 1px;
            }

            /* ===== 投稿タイトル ===== */
            .post-title {
                margin-bottom: 15px;
                color: #38372f;
                font-size: 22px;
                font-weight: bold;
                line-height: 1.6;
                overflow-wrap: anywhere;
            }

            /* ===== 投稿情報 ===== */
            .post-info {
                margin-bottom: 20px;
                color: #776b57;
                font-size: 12px;
                line-height: 2;
            }

            .post-info-label {
                display: inline-block;
                margin-right: 5px;
                color: #8b3d35;
                font-weight: bold;
            }

            /* ===== 投稿内容 ===== */
            .post-content {
                min-height: 110px;
                padding: 22px;
                background: #faf6ed;
                border: 1px solid #e3dac9;
                border-radius: 3px;
                color: #38372f;
                font-size: 14px;
                line-height: 1.9;
                white-space: pre-wrap;
                overflow-wrap: anywhere;
            }

            /* ===== 返信カード ===== */
            .reply-card {
                padding: 22px;
                margin-bottom: 18px;
                background: #faf6ed;
                border: 1px solid #ded4c1;
                border-left: 4px solid #b49a65;
                border-radius: 4px;
            }

            .reply-name {
                margin-bottom: 13px;
                padding-bottom: 10px;
                border-bottom: 1px solid #e3dac9;
                color: #8b3d35;
                font-size: 14px;
                font-weight: bold;
            }

            .reply-content {
                margin-bottom: 15px;
                color: #38372f;
                font-size: 14px;
                line-height: 1.9;
                white-space: pre-wrap;
                overflow-wrap: anywhere;
            }

            .reply-date {
                color: #898171;
                font-size: 11px;
                text-align: right;
            }

            /* ===== 返信なし ===== */
            .empty-message {
                padding: 45px 20px;
                text-align: center;
                background: #faf6ed;
                border: 1px solid #ded4c1;
                border-radius: 4px;
                color: #776b57;
                font-size: 13px;
            }

            .empty-icon {
                margin-bottom: 12px;
                color: #b49a65;
                font-size: 30px;
            }

            /* ===== 返信入力欄 ===== */
            .reply-textarea {
                width: 100%;
                min-height: 150px;
                padding: 16px;
                background: #fffdf8;
                border: 1px solid #d8ccb4;
                border-radius: 4px;
                color: #38372f;
                font-size: 14px;
                line-height: 1.8;
                resize: vertical;
                font-family: inherit;
            }

            .reply-textarea:focus {
                outline: none;
                border-color: #b49a65;
                box-shadow: 0 0 0 3px rgba(180, 154, 101, 0.15);
            }

            .reply-textarea::placeholder {
                color: #a69a83;
            }

            /* ===== ボタンエリア ===== */
            .button-area {
                display: flex;
                justify-content: space-between;
                align-items: center;
                gap: 15px;
                margin-top: 25px;
                padding-top: 22px;
                border-top: 1px solid #e3dac9;
            }

            /* ===== 戻るボタン ===== */
            .btn-back {
                min-width: 150px;
                min-height: 44px;
                padding: 10px 20px;
                background: #292c29;
                border: 1px solid #292c29;
                border-radius: 4px;
                color: #f1ebdd;
                font-size: 13px;
                font-weight: bold;
                cursor: pointer;
                transition: 0.2s;
            }

            .btn-back:hover {
                background: #454943;
                border-color: #b49a65;
                color: #fffdf8;
                transform: translateY(-2px);
            }

            /* ===== 返信ボタン ===== */
            .btn-reply {
                min-width: 170px;
                min-height: 44px;
                padding: 10px 22px;
                background: #8b3d35;
                border: 1px solid #8b3d35;
                border-radius: 4px;
                color: #fffdf8;
                font-size: 13px;
                font-weight: bold;
                cursor: pointer;
                transition: 0.2s;
            }

            .btn-reply:hover {
                background: #6f2e28;
                border-color: #6f2e28;
                color: #fffdf8;
                transform: translateY(-2px);
            }

            .btn-back:focus-visible,
            .btn-reply:focus-visible {
                outline: 3px solid #b49a65;
                outline-offset: 3px;
            }

            /* ===== 下部 ===== */
            .detail-bottom {
                margin-top: 30px;
                padding-top: 20px;
                border-top: 1px solid #e3dac9;
                text-align: center;
                color: #a69a83;
                font-size: 10px;
                letter-spacing: 2px;
            }

            /* ===== タブレット ===== */
            @media screen and (max-width: 768px) {

                .detail-container {
                    padding: 25px 12px;
                }

                .detail-main-header {
                    padding: 25px 20px;
                }

                .detail-main-header h2 {
                    font-size: 24px;
                }

                .detail-content-area {
                    padding: 25px 20px;
                }

                .detail-card {
                    padding: 20px;
                }
            }

            /* ===== スマートフォン ===== */
            @media screen and (max-width: 520px) {

                .detail-system-label {
                    display: none;
                }

                .detail-main-header h2 {
                    font-size: 21px;
                    letter-spacing: 2px;
                }

                .detail-content-area {
                    padding: 22px 14px;
                }

                .detail-card {
                    padding: 18px 15px;
                }

                .section-title {
                    font-size: 17px;
                }

                .post-title {
                    font-size: 19px;
                }

                .post-content {
                    padding: 15px;
                    font-size: 13px;
                }

                .reply-card {
                    padding: 16px;
                }

                .button-area {
                    flex-direction: column;
                    align-items: stretch;
                }

                .button-area form {
                    width: 100%;
                }

                .btn-back,
                .btn-reply {
                    width: 100%;
                }
            }

        </style>
    </c:param>

    <c:param name="content">

        <div class="detail-container">

            <div class="detail-main-card">

                <!-- ===== ヘッダー ===== -->
                <div class="detail-main-header">

                    <div class="detail-header-top">

                        <div class="detail-admin-label">
                            ADMINISTRATOR
                        </div>

                        <div class="detail-system-label">
                            PAPATALK MANAGEMENT SYSTEM
                        </div>

                    </div>

                    <h2>投稿詳細</h2>

                    <div class="detail-subtitle">
                        POST DETAILS
                    </div>

                    <div class="detail-decoration">
                        <div class="detail-decoration-line"></div>
                        <div class="detail-decoration-diamond"></div>
                        <div class="detail-decoration-line"></div>
                    </div>

                </div>

                <!-- ===== メインコンテンツ ===== -->
                <div class="detail-content-area">

                    <!-- エラーメッセージ -->
                    <c:if test="${not empty errorMessage}">
                        <div class="message error-message">
                            <c:out value="${errorMessage}" />
                        </div>
                    </c:if>

                    <!-- 成功メッセージ -->
                    <c:if test="${not empty replyMessage}">
                        <div class="message success-message">
                            <c:out value="${replyMessage}" />
                        </div>
                    </c:if>

                    <c:if test="${not empty post}">

                        <!-- ===== 投稿内容 ===== -->
                        <div class="detail-card">

                            <h3 class="section-title">
                                投稿内容
                            </h3>

                            <div class="post-title">
                                <c:out value="${post.post_title}" />
                            </div>

                            <div class="post-info">

                                <span class="post-info-label">
                                    投稿者
                                </span>

                                <c:out value="${post.user_name}" />

                                <br>

                                <span class="post-info-label">
                                    投稿日時
                                </span>

                                <c:choose>
                                    <c:when test="${not empty post.post_date}">
                                        <fmt:formatDate
                                            value="${post.post_date}"
                                            pattern="yyyy年MM月dd日 HH時mm分" />
                                    </c:when>
                                    <c:otherwise>
                                        日時情報がありません
                                    </c:otherwise>
                                </c:choose>

                            </div>

                            <div class="post-content">
                                <c:out value="${post.post_content}" />
                            </div>

                        </div>

                        <!-- ===== 返信一覧 ===== -->
                        <div class="detail-card">

                            <h3 class="section-title">
                                返信履歴
                            </h3>

                            <c:choose>

                                <c:when test="${empty replyList}">

                                    <div class="empty-message">

                                        <div class="empty-icon">
                                            ◇
                                        </div>

                                        まだ返信はありません。

                                    </div>

                                </c:when>

                                <c:otherwise>

                                    <c:forEach var="reply" items="${replyList}">

                                        <div class="reply-card">

                                            <div class="reply-name">
                                                <c:out value="${reply.user_name}" />
                                            </div>

                                            <div class="reply-content">
                                                <c:out value="${reply.reply_content}" />
                                            </div>

                                            <div class="reply-date">

                                                <c:choose>
                                                    <c:when test="${not empty reply.reply_date}">
                                                        <fmt:formatDate
                                                            value="${reply.reply_date}"
                                                            pattern="yyyy年MM月dd日 HH時mm分" />
                                                    </c:when>
                                                    <c:otherwise>
                                                        日時情報がありません
                                                    </c:otherwise>
                                                </c:choose>

                                            </div>

                                        </div>

                                    </c:forEach>

                                </c:otherwise>

                            </c:choose>

                        </div>

                        <!-- ===== 管理者返信 ===== -->
                        <div class="detail-card">

                            <h3 class="section-title">
                                管理者からの返信
                            </h3>

                            <!-- 返信入力欄 -->
                            <textarea
                                id="reply_content"
                                name="reply_content"
                                form="replyForm"
                                class="reply-textarea"
                                maxlength="1000"
                                placeholder="返信内容を入力してください。"
                                required></textarea>

                            <div class="button-area">

                                <!-- 投稿一覧に戻る -->
                                <form action="/papatalk/scoremanager/main/RetrievePosts.action"
                                      method="get">

                                    <button type="submit"
                                            class="btn-back">
                                        戻る
                                    </button>

                                </form>

                                <!-- 返信登録 -->
                                <form id="replyForm"
                                      action="/papatalk/scoremanager/main/PostReply.action"
                                      method="post">

                                    <input type="hidden"
                                           name="post_id"
                                           value="<c:out value='${post.post_id}' />">

                                    <button type="submit"
                                            class="btn-reply">
                                        返信を登録する
                                    </button>

                                </form>

                            </div>

                        </div>

                    </c:if>

                    <!-- ===== 下部 ===== -->
                    <div class="detail-bottom">
                        PAPATALK SYSTEM ｜ POST MANAGEMENT
                    </div>

                </div>

            </div>

        </div>

    </c:param>

</c:import>
