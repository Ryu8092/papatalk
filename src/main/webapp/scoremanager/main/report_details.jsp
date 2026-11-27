
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:import url="/common/base.jsp">

    <c:param name="title">
        パパトークシステム｜通報詳細
    </c:param>

    <c:param name="scripts">
        <style>

            * {
                box-sizing: border-box;
            }

            /* ===== 全体 ===== */
            .detail-page {
                width: 100%;
                min-height: 75vh;
                padding: 40px 30px;
                background: #f1ebdd;
            }

            /* ===== メインカード ===== */
            .detail-container {
                width: 100%;
                max-width: 1100px;
                margin: 0 auto;
                background: #fffdf8;
                border: 1px solid #d8ccb4;
                border-radius: 5px;
                overflow: hidden;
                box-shadow: 0 8px 30px rgba(48, 43, 32, 0.10);
            }

            /* ===== ヘッダー ===== */
            .detail-header {
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

            .detail-title {
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
            .detail-content {
                padding: 40px;
            }

            .page-description {
                margin-bottom: 25px;
                padding-bottom: 20px;
                border-bottom: 1px solid #e3dac9;
                color: #776b57;
                font-size: 13px;
                letter-spacing: 1px;
                text-align: center;
            }

            /* ===== メッセージ ===== */
            .message {
                margin-bottom: 20px;
                padding: 14px 18px;
                background: #f5eee0;
                border: 1px solid #b49a65;
                border-left: 4px solid #b49a65;
                color: #725f39;
                border-radius: 3px;
            }

            /* ===== セクションタイトル ===== */
            .section-title {
                margin: 30px 0 15px;
                padding: 10px 15px;
                background: #f5eee0;
                border-left: 4px solid #b49a65;
                color: #38372f;
                font-size: 17px;
                font-weight: bold;
                letter-spacing: 1px;
            }

            /* ===== 通報カテゴリ ===== */
            .report-category {
                display: inline-block;
                margin-bottom: 5px;
                padding: 8px 18px;
                background: #eee5d2;
                border: 1px solid #b49a65;
                border-radius: 3px;
                color: #725f39;
                font-size: 14px;
                font-weight: bold;
                letter-spacing: 1px;
            }

            /* ===== テーブル ===== */
            .table-wrapper {
                width: 100%;
                overflow-x: auto;
                border: 1px solid #ded4c1;
            }

            .detail-table {
                width: 100%;
                border-collapse: collapse;
                background: #fffdf8;
            }

            .detail-table th {
                padding: 14px;
                background: #292c29;
                color: #f1ebdd;
                border-bottom: 1px solid #b49a65;
                text-align: left;
                white-space: nowrap;
                font-size: 13px;
            }

            .detail-table td {
                padding: 14px;
                color: #504a3f;
                border-bottom: 1px solid #e3dac9;
                font-size: 13px;
                overflow-wrap: anywhere;
            }

            .detail-table tbody tr:hover {
                background: #faf6ed;
            }

            /* ===== 詳細情報テーブル ===== */
            .user-detail-table th {
                width: 30%;
            }

            /* ===== 通報内容 ===== */
            .report-content {
                min-width: 180px;
                min-height: 100px;
                white-space: pre-wrap;
                line-height: 1.8;
            }

            /* ===== 対応状態 ===== */
            .status {
                display: inline-block;
                padding: 6px 13px;
                border: 1px solid #b49a65;
                border-radius: 3px;
                background: #f5eee0;
                color: #725f39;
                font-size: 12px;
                white-space: nowrap;
            }

            /* ===== 下部ボタン ===== */
            .bottom-buttons {
                position: relative;
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 15px;
                margin-top: 35px;
                padding-top: 25px;
                border-top: 1px solid #e3dac9;
            }

            /* ===== 戻るボタン ===== */
            .back-form {
                width: 100%;
                max-width: 230px;
                margin: 0 auto;
            }

            .back-button {
                width: 100%;
                min-height: 48px;
                padding: 10px 20px;
                background: #292c29;
                border: 1px solid #292c29;
                border-radius: 4px;
                color: #f1ebdd;
                font-size: 13px;
                font-weight: bold;
                letter-spacing: 2px;
                cursor: pointer;
                transition: 0.2s;
            }

            .back-button:hover {
                background: #454943;
                border-color: #b49a65;
                color: #fffdf8;
                transform: translateY(-2px);
            }

            /* ===== アカウント停止 ===== */
            .account-stop-area {
                position: absolute;
                right: 0;
                top: 25px;
                display: flex;
                align-items: center;
            }

            .account-stop-form {
                margin: 0;
            }

            .stop-button {
                min-height: 48px;
                padding: 10px 25px;
                background: #8b3d35;
                border: 1px solid #8b3d35;
                border-radius: 4px;
                color: #fffdf8;
                font-size: 13px;
                font-weight: bold;
                letter-spacing: 1px;
                cursor: pointer;
                transition: 0.2s;
            }

            .stop-button:hover {
                background: #6f302b;
                border-color: #6f302b;
                transform: translateY(-2px);
            }

            .back-button:focus-visible,
            .stop-button:focus-visible {
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

                .detail-page {
                    padding: 25px 12px;
                }

                .detail-header {
                    padding: 25px 20px;
                }

                .detail-title {
                    font-size: 24px;
                }

                .detail-content {
                    padding: 25px 20px;
                }

                .user-detail-table {
                    min-width: 450px;
                }

                .history-table {
                    min-width: 750px;
                }

                .account-stop-area {
                    position: static;
                }

                .bottom-buttons {
                    flex-wrap: wrap;
                }

            }

            /* ===== スマートフォン ===== */
            @media screen and (max-width: 520px) {

                .detail-system-label {
                    display: none;
                }

                .detail-title {
                    font-size: 21px;
                    letter-spacing: 2px;
                }

                .detail-content {
                    padding: 22px 14px;
                }

                .page-description {
                    font-size: 12px;
                }

                .section-title {
                    font-size: 15px;
                }

                .bottom-buttons {
                    flex-direction: column;
                    align-items: center;
                    gap: 15px;
                }

                .back-form {
                    max-width: none;
                }

                .back-button,
                .stop-button {
                    width: 100%;
                }

                .account-stop-area {
                    position: static;
                    width: 100%;
                }

                .account-stop-form {
                    width: 100%;
                }

                .detail-bottom {
                    font-size: 9px;
                }

            }

        </style>
    </c:param>

    <c:param name="content">

        <div class="detail-page">

            <div class="detail-container">

                <!-- ===== ヘッダー ===== -->
                <div class="detail-header">

                    <div class="detail-header-top">

                        <div class="detail-admin-label">
                            ADMINISTRATOR
                        </div>

                        <div class="detail-system-label">
                            PAPATALK MANAGEMENT SYSTEM
                        </div>

                    </div>

                    <h2 class="detail-title">
                        通報詳細
                    </h2>

                    <div class="detail-subtitle">
                        REPORT DETAILS
                    </div>

                    <div class="detail-decoration">

                        <div class="detail-decoration-line"></div>

                        <div class="detail-decoration-diamond"></div>

                        <div class="detail-decoration-line"></div>

                    </div>

                </div>

                <!-- ===== メインコンテンツ ===== -->
                <div class="detail-content">

                    <div class="page-description">
                        選択したユーザーの通報履歴を確認できます。
                    </div>

                    <!-- ===== アカウント停止結果メッセージ ===== -->
                    <c:if test="${not empty sessionScope.stopMessage}">

                        <div class="message">
                            <c:out value="${sessionScope.stopMessage}" />
                        </div>

                        <c:remove var="stopMessage" scope="session" />

                    </c:if>
                    <!-- ===== 通報情報 ===== -->
                    <c:choose>

                        <c:when test="${not empty reports}">

                            <div class="report-category">
                                通報情報
                            </div>

                            <!-- ===== 通報対象ユーザー情報 ===== -->
                            <h3 class="section-title">
                                通報対象ユーザー情報
                            </h3>

                            <div class="table-wrapper">

                                <table class="detail-table user-detail-table">

                                    <tbody>

                                        <tr>
                                            <th>ユーザーID</th>
                                            <td>
                                                <c:out value="${reports[0].reported_user_id}" />
                                            </td>
                                        </tr>

                                        <tr>
                                            <th>ユーザー名</th>
                                            <td>
                                                <c:out value="${reports[0].user.user_name}" />
                                            </td>
                                        </tr>

                                    </tbody>

                                </table>

                            </div>

                            <!-- ===== 通報履歴一覧 ===== -->
                            <h3 class="section-title">
                                通報履歴一覧
                            </h3>

                            <div class="table-wrapper">

                                <table class="detail-table history-table">

                                    <thead>

                                        <tr>
                                            <th>通報ID</th>
                                            <th>通報者ID</th>
                                            <th>通報理由</th>
                                            <th>通報内容</th>
                                            <th>通報日時</th>
                                            <th>対応状態</th>
                                        </tr>

                                    </thead>

                                    <tbody>

                                        <c:forEach var="report" items="${reports}">

                                            <tr>

                                                <td>
                                                    <c:out value="${report.report_id}" />
                                                </td>

                                                <td>
                                                    <c:out value="${report.reporter_user_id}" />
                                                </td>

                                                <td>
                                                    <c:out value="${report.report_reason_name}" />
                                                </td>

                                                <td class="report-content">
                                                    <c:out value="${report.content}" />
                                                </td>

                                                <td>
                                                    <c:out value="${report.create_at}" />
                                                </td>

                                                <td>

                                                    <c:choose>

                                                        <c:when test="${report.user.user_status == 0}">
                                                            <span class="status">
                                                                未対応
                                                            </span>
                                                        </c:when>

                                                        <c:when test="${report.user.user_status == 1}">
                                                            <span class="status">
                                                                停止済み
                                                            </span>
                                                        </c:when>

                                                        <c:otherwise>
                                                            <span class="status">
                                                                不明
                                                            </span>
                                                        </c:otherwise>

                                                    </c:choose>

                                                </td>

                                            </tr>

                                        </c:forEach>

                                    </tbody>

                                </table>

                            </div>

                        </c:when>

                        <c:otherwise>

                            <div class="message">
                                通報情報を取得できませんでした。
                            </div>

                        </c:otherwise>

                    </c:choose>

                    <!-- ===== 下部ボタン ===== -->
                    <div class="bottom-buttons">

                        <!-- 戻るボタン -->
                        <form
                            action="/papatalk/scoremanager/main/Acquisition.action"
                            method="get"
                            class="back-form">

                            <input
                                type="hidden"
                                name="report_content_id"
                                value="<c:out value='${reportContentId}' />">

                            <button type="submit" class="back-button">
                                戻る
                            </button>

                        </form>

                        <!-- 通報情報がある場合のみアカウント停止ボタンを表示 -->
                        <c:if test="${not empty reports}">

                            <div class="account-stop-area">

                                <form
                                    action="/papatalk/scoremanager/main/Update.action"
                                    method="post"
                                    class="account-stop-form">

                                    <input
                                        type="hidden"
                                        name="reported_user_id"
                                        value="<c:out value='${reports[0].reported_user_id}' />">

                                    <button type="submit" class="stop-button">
                                        アカウント停止
                                    </button>

                                </form>

                            </div>

                        </c:if>

                    </div>

                    <!-- ===== 下部 ===== -->
                    <div class="detail-bottom">
                        PAPATALK SYSTEM ｜ REPORT MANAGEMENT
                    </div>

                </div>

            </div>

        </div>

    </c:param>

</c:import>
