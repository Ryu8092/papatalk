
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:import url="/common/base.jsp">
    <c:param name="title">
        パパトークシステム｜違反者一覧
    </c:param>

    <c:param name="content">

        <style>
            * {
                box-sizing: border-box;
            }

            .matching-layout {
                display: flex;
                gap: 24px;
                min-height: 70vh;
                margin: 20px;
            }

            .matching-sidebar {
                width: 240px;
                flex-shrink: 0;
                background: #fff;
                border-radius: 12px;
                padding: 20px;
            }

            .matching-main {
                flex: 1;
                min-width: 0;
                background: #fff;
                border-radius: 12px;
                padding: 28px;
            }

            .page-title {
                font-size: 25px;
                font-weight: bold;
                color: #24476b;
                margin-bottom: 10px;
            }

            .page-description {
                color: #666;
                margin-bottom: 25px;
            }

            .report-category {
                display: inline-block;
                background: #fff0df;
                color: #d87925;
                padding: 7px 16px;
                border-radius: 20px;
                font-size: 14px;
                font-weight: bold;
                margin-bottom: 20px;
            }

            .report-count {
                font-weight: bold;
                color: #24476b;
                margin-bottom: 15px;
            }

            .report-table {
                width: 100%;
                border-collapse: collapse;
            }

            .report-table th {
                background: #24476b;
                color: white;
                padding: 13px 10px;
                text-align: center;
                white-space: nowrap;
            }

            .report-table td {
                padding: 13px 10px;
                border-bottom: 1px solid #ddd;
                text-align: center;
                color: #444;
            }

            .report-table tr:hover {
                background: #f5f8fb;
            }

            .user-name-link {
                color: #24476b;
                font-weight: bold;
                text-decoration: none;
            }

            .user-name-link:hover {
                color: #ed9145;
                text-decoration: underline;
            }

            .empty-message {
                text-align: center;
                padding: 40px 10px;
                color: #888;
            }

            .bottom-buttons {
                display: flex;
                justify-content: flex-start;
                margin-top: 25px;
            }

            .back-button {
                display: inline-block;
                background: #24476b;
                color: white;
                padding: 9px 24px;
                border-radius: 6px;
                text-decoration: none;
                font-size: 14px;
            }

            .back-button:hover {
                background: #18344f;
                color: white;
            }

            @media (max-width: 768px) {
                .matching-layout {
                    flex-direction: column;
                    margin: 10px;
                }

                .matching-sidebar {
                    width: 100%;
                }

                .matching-main {
                    padding: 18px;
                    overflow-x: auto;
                }

                .report-table {
                    min-width: 450px;
                }
            }
        </style>

        <div class="matching-layout">

            <main class="matching-main">

                <h2 class="page-title">
                    違反者一覧
                </h2>

                <p class="page-description">
                    通報されたユーザーの情報を確認できます。
                </p>

                <%-- 通報コンテンツの種類 --%>
                <div class="report-category">
                    <c:out value="${title}" />
                </div>

                <%-- 通報件数 --%>
                <div class="report-count">
                    通報件数：
                    <c:out value="${reports.size()}" />件
                </div>

                <%-- 通報一覧 --%>
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

                                        <%-- 通報されたユーザーID --%>
                                        <td>
                                            <c:out value="${report.reported_user_id}" />
                                        </td>

                                        <%-- 通報されたユーザー名 --%>
                                        <td>
                                            <a href="<c:url value='/scoremanager/main/TherearenoViolators.action' />?reported_user_id=${report.reported_user_id}&amp;report_content_id=${reportContentId}"
                                               class="user-name-link">

                                                <c:out value="${report.user.user_name}" />

                                            </a>
                                        </td>

                                        <%-- 通報日時 --%>
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

                <%-- 戻るボタン --%>
                <div class="bottom-buttons">

                    <a href="<c:url value='/scoremanager/main/SingleScreenDisplay.action' />"
                       class="back-button">

                        戻る

                    </a>

                </div>

            </main>

        </div>

    </c:param>
</c:import>
