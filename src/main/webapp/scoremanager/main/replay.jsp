<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:import url="/common/base.jsp">
    <c:param name="title">投稿返信｜パパトークシステム</c:param>
    <c:param name="scripts"></c:param>

    <c:param name="content">

        <style>
            /* 全体 */
            .reply-page {
                max-width: 1000px;
                margin: 30px auto;
                padding: 30px;
                background: #fff;
                border-radius: 14px;
                box-shadow: 0 3px 12px rgba(31,55,85,.08);
                box-sizing: border-box;
            }

            /* 戻るボタン */
            .back-button {
                display: inline-block;
                padding: 9px 22px;
                background: #24476b;
                color: #fff;
                text-decoration: none;
                border-radius: 7px;
                font-weight: bold;
                margin-bottom: 25px;
            }

            .back-button:hover {
                background: #183653;
            }

            /* 元の投稿 */
            .original-post {
                padding: 20px;
                border-bottom: 2px solid #e2e8f0;
                margin-bottom: 25px;
            }

            .original-title {
                color: #24476b;
                font-size: 24px;
                text-align: center;
                margin: 0 0 20px;
                overflow-wrap: anywhere;
            }

            .original-content {
                color: #334155;
                font-size: 16px;
                line-height: 1.9;
                text-align: center;
                white-space: pre-wrap;
                overflow-wrap: anywhere;
                margin-bottom: 20px;
            }

            /* 返信一覧 */
            .reply-heading {
                color: #24476b;
                font-size: 20px;
                margin-bottom: 20px;
            }

            .reply-list {
                display: flex;
                flex-direction: column;
                gap: 20px;
            }

            .reply-card {
                padding: 20px;
                border-bottom: 1px solid #e2e8f0;
                background: #f8fafc;
                border-radius: 8px;
            }

            .reply-info {
                display: flex;
                justify-content: space-between;
                align-items: center;
                flex-wrap: wrap;
                color: #718096;
                font-size: 13px;
                margin-bottom: 15px;
            }

            .reply-info-left {
                display: flex;
                gap: 20px;
                align-items: center;
                flex-wrap: wrap;
            }

            .reply-user {
                font-weight: bold;
                color: #24476b;
            }

            .reply-content {
                color: #334155;
                font-size: 15px;
                line-height: 1.8;
                white-space: pre-wrap;
                overflow-wrap: anywhere;
                margin: 0 0 15px 0;
                padding-left: 10px;
            }

            /* 通報エリア */
            .reply-bottom-buttons {
                display: flex;
                justify-content: flex-end;
                align-items: flex-start;
                margin-top: 15px;
                padding-top: 15px;
                border-top: 1px solid #e2e8f0;
            }

            .report-form {
                flex: 1;
                max-width: 520px;
                min-width: 0;
                margin: 0;
            }

            /* 通報フォームを開くボタン */
            .report-open-button {
                display: inline-block;
                padding: 8px 18px;
                color: #fff;
                background: #d9534f;
                border: 1px solid #d9534f;
                border-radius: 6px;
                font-size: 13px;
                font-weight: bold;
                cursor: pointer;
            }

            .report-open-button:hover {
                background: #bd3935;
                border-color: #bd3935;
            }

            /* 通報フォームの表示・非表示 */
            .report-form-area {
                display: none;
                width: 100%;
                margin-top: 15px;
                background: #fff;
                padding: 15px;
                border: 1px solid #cbd5e1;
                border-radius: 6px;
            }

            .report-form-area.show {
                display: block;
            }

            .report-title {
                margin-bottom: 12px;
                padding-bottom: 6px;
                color: #24476b;
                font-size: 16px;
                font-weight: bold;
                border-bottom: 2px solid #ed9145;
            }

            .report-label {
                display: block;
                margin-bottom: 6px;
                color: #52657b;
                font-size: 13px;
                font-weight: bold;
            }

            .report-select,
            .report-textarea {
                width: 100%;
                box-sizing: border-box;
                padding: 8px;
                border: 1px solid #cbd5e1;
                border-radius: 6px;
                background: #fff;
                color: #344b63;
                font-size: 13px;
            }

            .report-select:focus,
            .report-textarea:focus {
                outline: none;
                border-color: #3182ce;
                box-shadow: 0 0 0 3px rgba(49, 130, 206, 0.12);
            }

            .report-textarea {
                min-height: 90px;
                resize: vertical;
                line-height: 1.7;
            }

            .report-input-area {
                margin-bottom: 12px;
            }

            /* 通報送信ボタン */
            .btn-report {
                display: inline-block;
                padding: 8px 18px;
                color: #fff;
                background: #d9534f;
                border: 1px solid #d9534f;
                border-radius: 6px;
                font-size: 13px;
                font-weight: bold;
                cursor: pointer;
            }

            .btn-report:hover {
                background: #bd3935;
                border-color: #bd3935;
            }

            /* 返信がない場合 */
            .empty-reply {
                padding: 25px;
                text-align: center;
                color: #718096;
                background: #f7f9fc;
                border-radius: 8px;
            }

            /* 返信入力 */
            .reply-form {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 15px;
                margin-top: 35px;
                padding-top: 25px;
                border-top: 1px solid #e2e8f0;
            }

            .reply-input {
                width: 60%;
                min-height: 42px;
                padding: 10px;
                border: 2px solid #cbd5e1;
                border-radius: 6px;
                font-size: 15px;
                box-sizing: border-box;
            }

            .reply-input:focus {
                outline: none;
                border-color: #ed9145;
            }

            .send-button {
                padding: 11px 25px;
                background: #ed9145;
                color: #fff;
                border: none;
                border-radius: 7px;
                font-weight: bold;
                font-size: 14px;
                cursor: pointer;
            }

            .send-button:hover {
                background: #d97c30;
            }

            /* 成功メッセージ */
            .success-message {
                color: #2e7d32;
                background: #e8f5e9;
                padding: 12px;
                border-radius: 7px;
                margin-bottom: 15px;
            }

            /* エラーメッセージ */
            .error-message {
                color: #d93025;
                background: #fff0f0;
                padding: 12px;
                border-radius: 7px;
                margin-bottom: 15px;
            }

            /* スマホ対応 */
            @media(max-width: 600px) {
                .reply-page {
                    padding: 18px;
                    margin: 15px;
                }

                .reply-form {
                    flex-direction: column;
                }

                .reply-input {
                    width: 100%;
                }

                .send-button {
                    width: 100%;
                }
            }
        </style>


        <div class="reply-page">

            <%-- 掲示板に戻る --%>
            <a
                class="back-button"
                href="${pageContext.request.contextPath}/scoremanager/main/RetrievePosts.action">
                戻る
            </a>


            <%-- 元の投稿 --%>
            <div class="original-post">

                <h2 class="original-title">
                    <c:out value="${post.post_title}" />
                </h2>

                <div class="original-content">
                    <c:out value="${post.post_content}" />
                </div>

            </div>


            <%-- 返信一覧の見出し --%>
            <h3 class="reply-heading">
                返信一覧
            </h3>


            <%-- イイネ成功メッセージ --%>
            <c:if test="${not empty message}">
                <div class="success-message">
                    <c:out value="${message}" />
                </div>
            </c:if>


            <%-- エラーメッセージ --%>
            <c:if test="${not empty errorMessage}">
                <div class="error-message">
                    <c:out value="${errorMessage}" />
                </div>
            </c:if>


            <%-- 返信一覧 --%>
            <div class="reply-list">

                <c:choose>

                    <%-- 返信がない場合 --%>
                    <c:when test="${empty replyList}">

                        <div class="empty-reply">
                            まだ返信はありません。<br>
                            最初の返信をしてみましょう！
                        </div>

                    </c:when>


                    <%-- 返信がある場合 --%>
                    <c:otherwise>

                        <c:forEach var="reply" items="${replyList}" varStatus="status">

                            <div class="reply-card">

                                <%-- 返信者・返信日時 --%>
                                <div class="reply-info">

                                    <div class="reply-info-left">

                                        <span class="reply-user">
                                            名前：
                                            <a href="${pageContext.request.contextPath}/scoremanager/main/UserDetail.action?user_id=${reply.user_id}&post_id=${post.post_id}">
                                                <c:out value="${reply.user_name}" />
                                            </a>
                                        </span>

                                        <span>
                                            返信日：
                                            <c:out value="${reply.reply_date}" />
                                        </span>

                                    </div>

                                </div>


                                <%-- 返信内容 --%>
                                <p class="reply-content">
                                    <c:out value="${reply.reply_content}" />
                                </p>


                                <%-- 各返信ごとの通報エリア（開閉式） --%>
                                <div class="reply-bottom-buttons">

                                    <div class="report-form">

                                        <%-- 通報フォームを開くボタン --%>
                                        <button type="button"
                                                class="report-open-button"
                                                id="reportOpenButton_${status.index}"
                                                onclick="toggleReplyReportForm(${status.index})">
                                            ⚑ 通報する
                                        </button>


                                        <%-- 通報入力フォーム --%>
                                        <div class="report-form-area" id="reportFormArea_${status.index}">

                                            <form action="<c:url value='/scoremanager/main/Report.action' />"
                                                  method="post">

                                                <h3 class="report-title">
                                                    ⚑ この返信を通報する
                                                </h3>


                                                <%-- どの返信に対する通報かを渡す --%>
                                                <input type="hidden"
                                                       name="reply_id"
                                                       value="${reply.reply_id}">

                                                <input type="hidden"
                                                       name="report_content_id"
                                                       value="1">


                                                <%-- 通報理由 --%>
                                                <div class="report-input-area">

                                                    <label class="report-label">
                                                        通報理由
                                                    </label>

                                                    <select name="report_reason_id"
                                                            class="report-select"
                                                            required>

                                                        <option value="">
                                                            通報理由を選択してください
                                                        </option>

                                                        <c:forEach var="reason" items="${reportReasons}">
                                                            <option value="${reason.report_reason_id}">
                                                                <c:out value="${reason.report_reason_name}" />
                                                            </option>
                                                        </c:forEach>

                                                    </select>

                                                </div>


                                                <%-- 通報内容 --%>
                                                <div class="report-input-area">

                                                    <label class="report-label">
                                                        通報内容
                                                    </label>

                                                    <textarea name="content"
                                                              class="report-textarea"
                                                              maxlength="1000"
                                                              required
                                                              placeholder="通報内容を入力してください"></textarea>

                                                </div>


                                                <%-- 通報送信ボタン --%>
                                                <button type="submit" class="btn-report">
                                                    ⚑ 送信
                                                </button>

                                            </form>

                                        </div>

                                    </div>

                                </div>

                            </div>

                        </c:forEach>

                    </c:otherwise>

                </c:choose>

            </div>


            <%-- 返信入力フォーム --%>
            <form
                class="reply-form"
                method="post"
                action="${pageContext.request.contextPath}/scoremanager/main/RegisterReply.action">

                <%-- どの投稿への返信かを渡す --%>
                <input
                    type="hidden"
                    name="post_id"
                    value="${post.post_id}">


                <%-- 返信内容 --%>
                <input
                    type="text"
                    name="reply_content"
                    class="reply-input"
                    placeholder="返信内容を入力してください"
                    maxlength="500"
                    required>


                <%-- 送信 --%>
                <button
                    type="submit"
                    class="send-button">
                    送信
                </button>

            </form>

        </div>

    </c:param>
</c:import>


<!-- 各返信ごとの通報フォームの表示切り替えスクリプト -->
<script>
    function toggleReplyReportForm(index) {

        const form = document.getElementById("reportFormArea_" + index);
        const button = document.getElementById("reportOpenButton_" + index);

        if (form.classList.contains("show")) {

            form.classList.remove("show");
            button.textContent = "⚑ 通報する";

        } else {

            form.classList.add("show");
            button.textContent = "通報フォームを閉じる";

        }
    }
</script>