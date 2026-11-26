
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:import url="/common/base.jsp">

    <c:param name="title">
        パパトークシステム｜投稿管理
    </c:param>

    <c:param name="scripts">
        <style>
            /* ===== 全体 ===== */
            .post-container {
                width: 100%;
                min-height: 75vh;
                padding: 40px 30px;
                background: #f1ebdd;
                box-sizing: border-box;
            }

            /* ===== メインカード ===== */
            .post-main-card {
                max-width: 1100px;
                margin: 0 auto;
                background: #fffdf8;
                border: 1px solid #d8ccb4;
                border-radius: 5px;
                overflow: hidden;
                box-shadow: 0 8px 30px rgba(48, 43, 32, 0.10);
            }

            /* ===== ヘッダー ===== */
            .post-main-header {
                padding: 28px 40px 30px;
                background: #292c29;
                border-bottom: 4px solid #b49a65;
            }

            .post-header-top {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 25px;
            }

            .post-admin-label {
                display: inline-block;
                padding: 7px 14px;
                border: 1px solid #88774f;
                color: #d8c39a;
                font-size: 10px;
                font-weight: bold;
                letter-spacing: 2px;
            }

            .post-system-label {
                font-size: 10px;
                color: #b9ad94;
                letter-spacing: 2px;
            }

            .post-main-header h2 {
                margin: 0;
                text-align: center;
                color: #f1ebdd;
                font-size: 28px;
                font-weight: bold;
                letter-spacing: 4px;
            }

            .post-subtitle {
                margin-top: 10px;
                text-align: center;
                color: #b49a65;
                font-size: 10px;
                letter-spacing: 3px;
            }

            /* ===== 装飾 ===== */
            .post-decoration {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 10px;
                margin-top: 20px;
            }

            .post-decoration-line {
                width: 45px;
                height: 1px;
                background: #b49a65;
            }

            .post-decoration-diamond {
                width: 7px;
                height: 7px;
                background: #b49a65;
                transform: rotate(45deg);
            }

            /* ===== コンテンツ ===== */
            .post-content-area {
                padding: 35px 40px 40px;
            }

            .post-description {
                margin-bottom: 30px;
                padding-bottom: 20px;
                border-bottom: 1px solid #e3dac9;
                color: #776b57;
                font-size: 13px;
                letter-spacing: 1px;
            }

            /* ===== 投稿カード ===== */
            .post-card {
                margin-bottom: 22px;
                padding: 25px 28px;
                background: #fffdf8;
                border: 1px solid #ded4c1;
                border-left: 4px solid #b49a65;
                border-radius: 4px;
                transition: 0.25s;
                box-sizing: border-box;
            }

            .post-card:hover {
                background: #faf6ed;
                border-color: #b49a65;
                box-shadow: 0 7px 18px rgba(64, 54, 37, 0.10);
                transform: translateY(-2px);
            }

            /* ===== 投稿タイトル ===== */
            .post-title {
                margin-bottom: 15px;
                padding-bottom: 12px;
                border-bottom: 1px solid #e3dac9;
                color: #38372f;
                font-size: 19px;
                font-weight: bold;
                line-height: 1.5;
                letter-spacing: 1px;
                overflow-wrap: anywhere;
            }

            /* ===== 投稿情報 ===== */
            .post-info {
                margin-bottom: 18px;
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
                margin-bottom: 22px;
                padding: 18px;
                background: #faf6ed;
                border: 1px solid #e3dac9;
                border-radius: 3px;
                color: #38372f;
                font-size: 14px;
                line-height: 1.9;
                white-space: pre-wrap;
                overflow-wrap: anywhere;
            }

            /* ===== 詳細・返信ボタン ===== */
            .post-button-area {
                display: flex;
                justify-content: flex-end;
            }

            .detail-button {
                min-width: 145px;
                min-height: 42px;
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

            .detail-button:hover {
                background: #454943;
                border-color: #b49a65;
                color: #fffdf8;
                transform: translateY(-2px);
            }

            .detail-button:focus-visible {
                outline: 3px solid #b49a65;
                outline-offset: 3px;
            }

            /* ===== 投稿がない場合 ===== */
            .empty-message {
                padding: 65px 20px;
                text-align: center;
                background: #faf6ed;
                border: 1px solid #ded4c1;
                border-radius: 4px;
                color: #776b57;
            }

            .empty-icon {
                margin-bottom: 18px;
                color: #b49a65;
                font-size: 34px;
            }

            .empty-title {
                margin-bottom: 12px;
                color: #38372f;
                font-size: 18px;
                font-weight: bold;
                letter-spacing: 2px;
            }

            .empty-text {
                color: #898171;
                font-size: 12px;
            }

            /* ===== 戻るボタン ===== */
            .back-button-area {
                display: flex;
                justify-content: flex-start;
                margin-top: 30px;
                padding-top: 22px;
                border-top: 1px solid #e3dac9;
            }

            .back-button {
                min-width: 170px;
                min-height: 42px;
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

            .back-button:hover {
                background: #454943;
                border-color: #b49a65;
                color: #fffdf8;
                transform: translateY(-2px);
            }

            .back-button:focus-visible {
                outline: 3px solid #b49a65;
                outline-offset: 3px;
            }

            /* ===== 下部 ===== */
            .post-bottom {
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
                .post-container {
                    padding: 25px 12px;
                }

                .post-main-header {
                    padding: 25px 20px;
                }

                .post-main-header h2 {
                    font-size: 24px;
                }

                .post-content-area {
                    padding: 25px 20px;
                }

                .post-card {
                    padding: 20px;
                }
            }

            /* ===== スマートフォン ===== */
            @media screen and (max-width: 520px) {
                .post-system-label {
                    display: none;
                }

                .post-main-header h2 {
                    font-size: 21px;
                    letter-spacing: 2px;
                }

                .post-content-area {
                    padding: 22px 14px;
                }

                .post-card {
                    padding: 18px 15px;
                }

                .post-title {
                    font-size: 17px;
                }

                .post-content {
                    padding: 14px;
                    font-size: 13px;
                }

                .post-button-area {
                    justify-content: center;
                }

                .detail-button {
                    width: 100%;
                }

                .back-button-area {
                    justify-content: center;
                }

                .back-button {
                    width: 100%;
                }
            }
        </style>
    </c:param>

    <c:param name="content">

        <div class="post-container">

            <div class="post-main-card">

                <!-- ===== ヘッダー ===== -->
                <div class="post-main-header">

                    <div class="post-header-top">

                        <div class="post-admin-label">
                            ADMINISTRATOR
                        </div>

                        <div class="post-system-label">
                            PAPATALK MANAGEMENT SYSTEM
                        </div>

                    </div>

                    <h2>投稿管理</h2>

                    <div class="post-subtitle">
                        POST MANAGEMENT
                    </div>

                    <div class="post-decoration">

                        <div class="post-decoration-line"></div>

                        <div class="post-decoration-diamond"></div>

                        <div class="post-decoration-line"></div>

                    </div>

                </div>

                <!-- ===== メインコンテンツ ===== -->
                <div class="post-content-area">

                    <div class="post-description">
                        登録されている投稿の確認や管理者からの返信ができます。
                    </div>

                    <!-- ===== 投稿一覧 ===== -->
                    <c:choose>

                        <c:when test="${empty postList}">

                            <div class="empty-message">

                                <div class="empty-icon">
                                    ◇
                                </div>

                                <div class="empty-title">
                                    投稿はありません
                                </div>

                                <div class="empty-text">
                                    新しい投稿が登録されると、こちらに表示されます。
                                </div>

                            </div>

                        </c:when>

                        <c:otherwise>

                            <c:forEach var="post" items="${postList}">

                                <div class="post-card">

                                    <!-- 投稿タイトル -->
                                    <div class="post-title">
                                        <c:out value="${post.post_title}" />
                                    </div>

                                    <!-- 投稿情報 -->
                                    <div class="post-info">

                                        <span class="post-info-label">
                                            投稿者
                                        </span>

                                        <c:out value="${post.user_name}" />

                                        <br>

                                        <span class="post-info-label">
                                            投稿日時
                                        </span>

                                        <c:out value="${post.post_date}" />

                                    </div>

                                    <!-- 投稿内容 -->
                                    <div class="post-content">
                                        <c:out value="${post.post_content}" />
                                    </div>

                                    <!-- 詳細・返信 -->
                                    <div class="post-button-area">

                                        <form action="/papatalk/scoremanager/main/PostDetail.action"
                                              method="get">

                                            <input type="hidden"
                                                   name="post_id"
                                                   value="<c:out value='${post.post_id}'/>">

                                            <button type="submit"
                                                    class="detail-button">
                                                詳細・返信　›
                                            </button>

                                        </form>

                                    </div>

                                </div>

                            </c:forEach>

                        </c:otherwise>

                    </c:choose>

                    <!-- ===== 運営管理画面に戻るボタン ===== -->
                    <div class="back-button-area">

                        <form action="/papatalk/scoremanager/main/operation_management.jsp"
                              method="get">

                            <button type="submit"
                                    class="back-button">
                                ‹ 運営管理画面に戻る
                            </button>

                        </form>

                    </div>

                    <!-- ===== 下部 ===== -->
                    <div class="post-bottom">
                        PAPATALK SYSTEM ｜ POST MANAGEMENT
                    </div>

                </div>

            </div>

        </div>

    </c:param>

</c:import>
