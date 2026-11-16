
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:import url="/common/base.jsp">
    <c:param name="title">
        パパトークシステム｜通報詳細
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

            .section-title {
                font-size: 18px;
                font-weight: bold;
                color: #24476b;
                border-left: 5px solid #ed9145;
                padding-left: 12px;
                margin: 25px 0 15px;
            }

            .detail-table {
                width: 100%;
                border-collapse: collapse;
            }

            .detail-table th {
                width: 30%;
                background: #24476b;
                color: white;
                padding: 14px;
                text-align: left;
                border-bottom: 1px solid #ddd;
                white-space: nowrap;
            }

            .detail-table td {
                padding: 14px;
                color: #444;
                border-bottom: 1px solid #ddd;
                overflow-wrap: anywhere;
            }

            .detail-table tr:hover {
                background: #f5f8fb;
            }

            .report-content {
                min-height: 100px;
                white-space: pre-wrap;
                line-height: 1.8;
            }

            .status {
                display: inline-block;
                padding: 5px 12px;
                border-radius: 15px;
                background: #fff0df;
                color: #d87925;
                font-size: 13px;
            }

            .message {
                background: #fff0df;
                color: #d87925;
                padding: 12px;
                border-radius: 6px;
                margin-bottom: 20px;
            }

            /* 下部ボタン */
            .bottom-buttons {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-top: 25px;
            }

            .back-button {
                display: inline-flex;
                align-items: center;
                justify-content: center;
                background: #24476b;
                color: white;
                height: 42px;
                padding: 0 24px;
                border-radius: 6px;
                text-decoration: none;
                font-size: 14px;
                border: none;
            }

            .back-button:hover {
                background: #18344f;
                color: white;
            }

            /* アカウント停止ボタン */
            .account-stop-area {
                display: flex;
                align-items: center;
            }

            .account-stop-area form {
                margin: 0;
            }

            .stop-button {
                display: inline-flex;
                align-items: center;
                justify-content: center;
                background: #dc3545;
                color: white;
                border: none;
                height: 42px;
                padding: 0 25px;
                border-radius: 6px;
                font-size: 14px;
                font-weight: bold;
                cursor: pointer;
            }

            .stop-button:hover {
                background: #b02a37;
            }

            @media (max-width: 768px) {
                .matching-layout {
                    flex-direction: column;
                    margin: 10px;
                }

                .matching-main {
                    padding: 18px;
                    overflow-x: auto;
                }

                .detail-table {
                    min-width: 650px;
                }

                .bottom-buttons {
                    gap: 12px;
                }

                .back-button,
                .stop-button {
                    padding: 0 16px;
                }
            }
        </style>

        <div class="matching-layout">
            <main class="matching-main">

                <h2 class="page-title">
                    通報詳細
                </h2>

                <p class="page-description">
                    選択したユーザーの通報履歴を確認できます。
                </p>

                <%-- アカウント停止結果メッセージ --%>
                <c:if test="${not empty sessionScope.stopMessage}">
                    <div class="message">
                        <c:out value="${sessionScope.stopMessage}" />
                    </div>
                    <c:remove var="stopMessage" scope="session" />
                </c:if>

                <%-- 通報情報 --%>
                <c:choose>

                    <c:when test="${not empty reports}">

                        <div class="report-category">
                            通報情報
                        </div>

                        <%-- 通報対象ユーザー情報 --%>
                        <h3 class="section-title">
                            通報対象ユーザー情報
                        </h3>

                        <table class="detail-table">
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

                        <%-- 通報履歴一覧 --%>
                        <h3 class="section-title">
                            通報履歴一覧
                        </h3>

                        <table class="detail-table">
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
                                                    <span class="status">未対応</span>
                                                </c:when>

                                                <c:when test="${report.user.user_status == 1}">
                                                    <span class="status">停止済み</span>
                                                </c:when>

                                                <c:otherwise>
                                                    <span class="status">不明</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>

                    </c:when>

                    <c:otherwise>
                        <div class="message">
                            通報情報を取得できませんでした。
                        </div>
                    </c:otherwise>

                </c:choose>

                <%-- 下部ボタン（共通・1つだけ表示） --%>
                <div class="bottom-buttons">

                    <%-- 戻るボタン --%>
					<a href="<c:url value='/scoremanager/main/Acquisition.action' />?report_content_id=${reportContentId}"
					   class="back-button">
					    戻る
					</a>

                    <%-- 通報情報がある場合のみアカウント停止ボタンを表示 --%>
                    <c:if test="${not empty reports}">
                        <div class="account-stop-area">
                            <form action="Update.action"
                                  method="post"
                                  onsubmit="return confirm('このユーザーのアカウントを停止しますか？');">

                                <input type="hidden"
                                       name="reported_user_id"
                                       value="${reports[0].reported_user_id}">

                                <button type="submit" class="stop-button">
                                    アカウント停止
                                </button>
                            </form>
                        </div>
                    </c:if>

                </div>

            </main>
        </div>

    </c:param>
</c:import>
