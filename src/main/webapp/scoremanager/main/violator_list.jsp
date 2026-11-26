
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:import url="/common/base.jsp">

    <c:param name="title">
        パパトークシステム｜違反者一覧
    </c:param>

    <c:param name="scripts">
        <style>

            * {
                box-sizing: border-box;
            }

            /* ===== 全体 ===== */
            .violator-page {
                width: 100%;
                min-height: 75vh;
                padding: 40px 30px;
                background: #f1ebdd;
            }

            /* ===== メインカード ===== */
            .violator-container {
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
            .violator-header {
                padding: 28px 40px 30px;
                background: #292c29;
                border-bottom: 4px solid #b49a65;
            }

            .violator-header-top {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 25px;
            }

            .violator-admin-label {
                display: inline-block;
                padding: 7px 14px;
                border: 1px solid #88774f;
                color: #d8c39a;
                font-size: 10px;
                font-weight: bold;
                letter-spacing: 2px;
            }

            .violator-system-label {
                font-size: 10px;
                color: #b9ad94;
                letter-spacing: 2px;
            }

            .violator-title {
                margin: 0;
                text-align: center;
                color: #f1ebdd;
                font-size: 28px;
                font-weight: bold;
                letter-spacing: 4px;
            }

            .violator-subtitle {
                margin-top: 10px;
                text-align: center;
                color: #b49a65;
                font-size: 10px;
                letter-spacing: 3px;
            }

            /* ===== 装飾 ===== */
            .violator-decoration {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 10px;
                margin-top: 20px;
            }

            .violator-decoration-line {
                width: 45px;
                height: 1px;
                background: #b49a65;
            }

            .violator-decoration-diamond {
                width: 7px;
                height: 7px;
                background: #b49a65;
                transform: rotate(45deg);
            }

            /* ===== コンテンツ ===== */
            .violator-content {
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

            /* ===== 通報カテゴリ ===== */
            .report-category {
                display: inline-block;
                margin-bottom: 20px;
                padding: 8px 18px;
                background: #eee5d2;
                border: 1px solid #b49a65;
                border-radius: 3px;
                color: #725f39;
                font-size: 14px;
                font-weight: bold;
                letter-spacing: 1px;
            }

            /* ===== 件数 ===== */
            .report-count {
                margin-bottom: 18px;
                color: #776b57;
                font-size: 14px;
                font-weight: bold;
            }

            /* ===== テーブル ===== */
            .table-wrapper {
                width: 100%;
                overflow-x: auto;
                border: 1px solid #ded4c1;
            }

            .report-table {
                width: 100%;
                border-collapse: collapse;
                background: #fffdf8;
            }

            .report-table th {
                padding: 15px 12px;
                background: #292c29;
                border-bottom: 3px solid #b49a65;
                color: #f1ebdd;
                font-size: 14px;
                font-weight: bold;
                letter-spacing: 1px;
                text-align: center;
                white-space: nowrap;
            }

            .report-table td {
                padding: 15px 12px;
                border-bottom: 1px solid #e3dac9;
                color: #504a3f;
                font-size: 14px;
                text-align: center;
            }

            .report-table tbody tr:hover {
                background: #faf6ed;
            }

            /* ===== ユーザー名 ===== */
            .user-name-form {
                display: inline;
                margin: 0;
            }

            .user-name-button {
                padding: 5px 8px;
                background: transparent;
                border: none;
                color: #8b3d35;
                font-size: 14px;
                font-weight: bold;
                cursor: pointer;
                transition: 0.2s;
            }

            .user-name-button:hover {
                color: #b49a65;
                text-decoration: underline;
            }

            .user-name-button:focus-visible {
                outline: 2px solid #b49a65;
                outline-offset: 3px;
            }

            /* ===== データなし ===== */
            .empty-message {
                padding: 40px 10px !important;
                color: #938875 !important;
                text-align: center;
            }

            /* ===== 戻るボタン ===== */
            .bottom-buttons {
                display: flex;
                justify-content: flex-start;
                margin-top: 30px;
                padding-top: 25px;
                border-top: 1px solid #e3dac9;
            }

            .back-form {
                width: 100%;
                max-width: 230px;
                margin: 0;
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

            .back-button:focus-visible {
                outline: 3px solid #b49a65;
                outline-offset: 3px;
            }

            /* ===== 下部 ===== */
            .violator-bottom {
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

                .violator-page {
                    padding: 25px 12px;
                }

                .violator-header {
                    padding: 25px 20px;
                }

                .violator-title {
                    font-size: 24px;
                }

                .violator-content {
                    padding: 25px 20px;
                }

                .report-table {
                    min-width: 500px;
                }
            }

            /* ===== スマートフォン ===== */
            @media screen and (max-width: 520px) {

                .violator-system-label {
                    display: none;
                }

                .violator-title {
                    font-size: 21px;
                    letter-spacing: 2px;
                }

                .violator-content {
                    padding: 22px 14px;
                }

                .page-description {
                    font-size: 12px;
                }

                .report-category {
                    font-size: 13px;
                }

                .report-table th,
                .report-table td {
                    padding: 12px 8px;
                    font-size: 12px;
                }

                .user-name-button {
                    font-size: 12px;
                }

                .violator-bottom {
                    font-size: 9px;
                }
            }

        </style>
    </c:param>

    <c:param name="content">

        <div class="violator-page">

            <div class="violator-container">

                <!-- ===== ヘッダー ===== -->
                <div class="violator-header">

                    <div class="violator-header-top">

                        <div class="violator-admin-label">
                            ADMINISTRATOR
                        </div>

                        <div class="violator-system-label">
                            PAPATALK MANAGEMENT SYSTEM
                        </div>

                    </div>

                    <h2 class="violator-title">
                        違反者一覧
                    </h2>

                    <div class="violator-subtitle">
                        REPORTED USERS
                    </div>

                    <div class="violator-decoration">

                        <div class="violator-decoration-line"></div>

                        <div class="violator-decoration-diamond"></div>

                        <div class="violator-decoration-line"></div>

                    </div>

                </div>

                <!-- ===== メインコンテンツ ===== -->
                <div class="violator-content">

                    <div class="page-description">
                        通報されたユーザーの情報を確認できます。
                    </div>

                    <!-- ===== 通報カテゴリ ===== -->
                    <div class="report-category">
                        <c:out value="${title}" />
                    </div>

                    <!-- ===== 通報件数 ===== -->
                    <div class="report-count">
                        通報件数：
                        <c:out value="${reports.size()}" />件
                    </div>

                    <!-- ===== 通報一覧 ===== -->
                    <div class="table-wrapper">

                        <table class="report-table">

                            <thead>
                                <tr>
                                    <th>ユーザーID</th>
                                    <th>ユーザー名</th>
                                    <th>通報日時</th>
                                </tr>
                            </thead>

                            <tbody>

                                <c:choose>

                                    <c:when test="${not empty reports}">

                                        <c:forEach var="report" items="${reports}">

                                            <tr>

                                                <!-- 通報されたユーザーID -->
                                                <td>
                                                    <c:out value="${report.reported_user_id}" />
                                                </td>

                                                <!-- 通報されたユーザー名 -->
                                                <td>

                                                    <form
                                                        action="/papatalk/scoremanager/main/TherearenoViolators.action"
                                                        method="get"
                                                        class="user-name-form">

                                                        <input
                                                            type="hidden"
                                                            name="reported_user_id"
                                                            value="<c:out value='${report.reported_user_id}' />">

                                                        <input
                                                            type="hidden"
                                                            name="report_content_id"
                                                            value="<c:out value='${reportContentId}' />">

                                                        <button
                                                            type="submit"
                                                            class="user-name-button">

                                                            <c:out value="${report.user.user_name}" />

                                                        </button>

                                                    </form>

                                                </td>

                                                <!-- 通報日時 -->
                                                <td>
                                                    <c:out value="${report.create_at}" />
                                                </td>

                                            </tr>

                                        </c:forEach>

                                    </c:when>

                                    <c:otherwise>

                                        <tr>
                                            <td colspan="3" class="empty-message">
                                                該当する通報情報はありません。
                                            </td>
                                        </tr>

                                    </c:otherwise>

                                </c:choose>

                            </tbody>

                        </table>

                    </div>

                    <!-- ===== 戻るボタン ===== -->
                    <div class="bottom-buttons">

                        <form
                            action="/papatalk/scoremanager/main/SingleScreenDisplay.action"
                            method="get"
                            class="back-form">

                            <button type="submit" class="back-button">
                                戻る
                            </button>

                        </form>

                    </div>

                    <!-- ===== 下部 ===== -->
                    <div class="violator-bottom">
                        PAPATALK SYSTEM ｜ USER MANAGEMENT
                    </div>

                </div>

            </div>

        </div>

    </c:param>

</c:import>
