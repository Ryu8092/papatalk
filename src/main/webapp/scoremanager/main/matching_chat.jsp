
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:import url="/common/base.jsp">

    <c:param name="title">チャット | パパトークシステム</c:param>

    <c:param name="scripts">
        <script>
            // メッセージ入力チェック
            function checkMessage() {
                const message = document.getElementById("content");

                if (message.value.trim() === "") {
                    alert("メッセージを入力してください。");
                    return false;
                }

                return true;
            }

            // 最新メッセージまでスクロール
            window.addEventListener("load", function () {
                const chatArea = document.getElementById("chat-area");

                if (chatArea) {
                    chatArea.scrollTop = chatArea.scrollHeight;
                }
            });

            // 通報フォーム開閉処理
            function toggleChatReportForm(index) {
                const form = document.getElementById("reportFormArea_" + index);
                const button = document.getElementById("reportOpenButton_" + index);

                if (form.classList.contains("show")) {
                    form.classList.remove("show");
                    button.textContent = "⚑ 通報する";
                } else {
                    form.classList.add("show");
                    button.textContent = "通報フォームを閉じる";
                    validateChatReportForm(index);
                }
            }

            // 通報フォーム入力チェック
            function validateChatReportForm(index) {
                const reasonSelect = document.getElementById("reasonSelect_" + index);
                const contentTextarea = document.getElementById("reportContent_" + index);
                const submitBtn = document.getElementById("submitBtn_" + index);

                if (reasonSelect.value === "" || contentTextarea.value.trim() === "") {
                    submitBtn.disabled = true;
                } else {
                    submitBtn.disabled = false;
                }
            }
        </script>
    </c:param>

    <c:param name="content">

        <style>
            /* 全体レイアウト */
            .matching-layout {
                display: flex;
                gap: 24px;
                align-items: flex-start;
                min-height: 70vh;
            }

            /* サイドバー */
            .matching-sidebar {
                flex: 0 0 240px;
                background: #fff;
                border-radius: 14px;
                box-shadow: 0 4px 16px rgba(31, 55, 85, .08);
                padding: 20px;
            }

            /* メインコンテンツ */
            .matching-main {
                flex: 1;
                min-width: 0;
                padding: 28px;
                background: #fff;
                border-radius: 14px;
                box-shadow: 0 4px 16px rgba(31, 55, 85, .08);
            }

            /* ヘッダー */
            .chat-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                gap: 12px;
                margin-bottom: 20px;
            }

            .matching-title {
                color: #24476b;
                font-size: 26px;
                font-weight: 700;
                padding-bottom: 16px;
                border-bottom: 3px solid #ed9145;
                margin: 0;
                flex: 1;
            }

            /* 一覧に戻るフォーム */
            .chat-header form {
                margin: 0;
                padding: 0;
                flex-shrink: 0;
            }

            /* 一覧に戻るボタン */
            .back-button {
                padding: 9px 16px;
                border: 1px solid #dce4ee;
                border-radius: 8px;
                background: #fff;
                color: #24476b;
                font-size: 13px;
                font-weight: 600;
                cursor: pointer;
                font-family: inherit;
                white-space: nowrap;
            }

            .back-button:hover {
                background: #f2f5fa;
            }

            /* チャット履歴 */
            .chat-area {
                height: 430px;
                overflow-y: auto;
                padding: 20px;
                background: #f5f7fa;
                border: 1px solid #e2e8f0;
                border-radius: 12px;
                display: flex;
                flex-direction: column;
                gap: 16px;
            }

            /* メッセージ全体 */
            .chat-message {
                display: flex;
                flex-direction: column;
                max-width: 75%;
            }

            .my-message {
                align-self: flex-end;
                align-items: flex-end;
            }

            .other-message {
                align-self: flex-start;
                align-items: flex-start;
            }

            /* 送信者名 */
            .sender-name {
                color: #718096;
                font-size: 12px;
                margin-bottom: 5px;
            }

            /* メッセージ吹き出し */
            .message-bubble {
                padding: 12px 16px;
                border-radius: 14px;
                overflow-wrap: anywhere;
                line-height: 1.6;
            }

            .my-message .message-bubble {
                background: #ed9145;
                color: #fff;
                border-bottom-right-radius: 4px;
            }

            .other-message .message-bubble {
                background: #fff;
                color: #2d3748;
                border: 1px solid #e2e8f0;
                border-bottom-left-radius: 4px;
            }

            /* 送信日時 */
            .message-date {
                color: #a0aec0;
                font-size: 11px;
                margin-top: 5px;
            }

            /* メッセージがない場合 */
            .empty-message {
                text-align: center;
                color: #718096;
                margin: auto;
            }

            /* メッセージ送信フォーム */
            .chat-form {
                display: flex;
                gap: 12px;
                margin-top: 20px;
            }

            .chat-input {
                flex: 1;
                min-width: 0;
                padding: 13px 16px;
                border: 1px solid #dce4ee;
                border-radius: 10px;
                font-size: 14px;
                outline: none;
            }

            .chat-input:focus {
                border-color: #ed9145;
            }

            .send-button {
                padding: 12px 26px;
                border: none;
                border-radius: 10px;
                background: #ed9145;
                color: #fff;
                font-weight: 600;
                cursor: pointer;
            }

            .send-button:hover {
                background: #d97c30;
            }

            /* 通報ボタン */
            .bottom-buttons {
                display: flex;
                justify-content: flex-start;
                width: 100%;
                margin-top: 7px;
            }

            .report-form {
                width: 100%;
            }

            .report-open-button {
                padding: 5px 10px;
                border: 1px solid #dce4ee;
                border-radius: 6px;
                background: #fff;
                color: #718096;
                font-size: 12px;
                cursor: pointer;
            }

            .report-open-button:hover {
                background: #fff5f0;
                border-color: #ed9145;
                color: #d97c30;
            }

            /* 通報フォーム */
            .report-form-area {
                display: none;
                width: 100%;
                box-sizing: border-box;
                margin-top: 10px;
                padding: 16px;
                background: #fff;
                border: 1px solid #e2e8f0;
                border-radius: 10px;
            }

            .report-form-area.show {
                display: block;
            }

            .report-title {
                margin: 0 0 14px;
                color: #24476b;
                font-size: 16px;
            }

            .report-input-area {
                margin-bottom: 14px;
            }

            .report-label {
                display: block;
                margin-bottom: 6px;
                color: #4a5568;
                font-size: 13px;
                font-weight: 600;
            }

            .report-select,
            .report-textarea {
                width: 100%;
                box-sizing: border-box;
                padding: 10px;
                border: 1px solid #dce4ee;
                border-radius: 7px;
                font-size: 13px;
                outline: none;
            }

            .report-select:focus,
            .report-textarea:focus {
                border-color: #ed9145;
            }

            .report-textarea {
                min-height: 90px;
                resize: vertical;
                font-family: inherit;
            }

            .btn-report {
                padding: 9px 20px;
                border: none;
                border-radius: 7px;
                background: #ed9145;
                color: #fff;
                font-weight: 600;
                cursor: pointer;
            }

            .btn-report:hover:not(:disabled) {
                background: #d97c30;
            }

            .btn-report:disabled {
                background: #cbd5e0;
                cursor: not-allowed;
            }

            /* タブレット・スマートフォン */
            @media (max-width: 768px) {
                .matching-layout {
                    flex-direction: column;
                }

                .matching-sidebar {
                    width: 100%;
                    flex-basis: auto;
                    box-sizing: border-box;
                }

                .matching-main {
                    width: 100%;
                    padding: 20px;
                    box-sizing: border-box;
                }

                .chat-message {
                    max-width: 90%;
                }
            }

            @media (max-width: 480px) {
                .chat-area {
                    height: 380px;
                    padding: 12px;
                }

                .chat-form {
                    gap: 8px;
                }

                .send-button {
                    padding: 10px 16px;
                }

                .chat-header {
                    flex-wrap: wrap;
                }

                .matching-title {
                    font-size: 22px;
                }
            }
        </style>

        <div class="matching-layout">

            <!-- サイドバー -->
            <aside class="matching-sidebar">
                <jsp:include page="/common/sidebar.jsp" />
            </aside>

            <!-- チャット画面 -->
            <main class="matching-main">

                <div class="chat-header">

                    <h2 class="matching-title">${chat.user_name}チャット</h2>

                    <!-- 一覧に戻る -->
                    <form action="${pageContext.request.contextPath}/scoremanager/main/MatchingList.action"
                          method="get">

                        <button type="submit" class="back-button">
                            ← 一覧に戻る
                        </button>

                    </form>

                </div>

                <!-- チャット履歴 -->
                <div class="chat-area" id="chat-area">

                    <c:forEach var="chat" items="${chatList}" varStatus="status">

                        <!-- メッセージ -->
                        <c:choose>

                            
                            <c:when test="${chat.user_id == user.user_id}">

                                <div class="chat-message my-message">

                                    <span class="sender-name">自分</span>

                                    <div class="message-bubble">
                                        <c:out value="${chat.content}" />
                                    </div>

                                    <span class="message-date">
                                        <fmt:formatDate
                                            value="${chat.create_at}"
                                            pattern="yyyy/MM/dd HH:mm"
                                        />
                                    </span>

                                </div>

                            </c:when>

                            <c:otherwise>

                                <div class="chat-message other-message">

                                    <span class="sender-name">
                                        <c:out value="${chat.user_name}" />
                                    </span>

                                    <div class="message-bubble">
                                        <c:out value="${chat.content}" />
                                    </div>

                                    <span class="message-date">
                                        <fmt:formatDate
                                            value="${chat.create_at}"
                                            pattern="yyyy/MM/dd HH:mm"
                                        />
                                    </span>

                                    <div class="bottom-buttons">

                                        <div class="report-form">

                                            <button type="button"
                                                    class="report-open-button"
                                                    id="reportOpenButton_${status.index}"
                                                    onclick="toggleChatReportForm(${status.index})">
                                                ⚑ 通報する
                                            </button>

                                            <!-- 通報フォーム -->
                                            <div class="report-form-area"
                                                 id="reportFormArea_${status.index}">

                                                <form action="${pageContext.request.contextPath}/scoremanager/main/MatchReport.action"
                                                      method="post"
                                                      id="reportFormElement_${status.index}">

                                                    <h3 class="report-title">
                                                        ⚑ このメッセージを通報する
                                                    </h3>

                                                    <input type="hidden"
                                                           name="chat_id"
                                                           value="${chat.chat_id}">

                                                    <input type="hidden"
                                                           name="match_id"
                                                           value="${match_id}">

                                                    <div class="report-input-area">

                                                        <label class="report-label"
                                                               for="reasonSelect_${status.index}">
                                                            通報理由
                                                        </label>

                                                        <select name="report_reason_id"
                                                                class="report-select"
                                                                id="reasonSelect_${status.index}"
                                                                onchange="validateChatReportForm(${status.index})"
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

                                                    <div class="report-input-area">

                                                        <label class="report-label"
                                                               for="reportContent_${status.index}">
                                                            通報内容
                                                        </label>

                                                        <textarea name="content"
                                                                  class="report-textarea"
                                                                  id="reportContent_${status.index}"
                                                                  oninput="validateChatReportForm(${status.index})"
                                                                  maxlength="1000"
                                                                  required
                                                                  placeholder="通報内容を入力してください"></textarea>

                                                    </div>

                                                    <button type="submit"
                                                            class="btn-report"
                                                            id="submitBtn_${status.index}"
                                                            disabled>
                                                        ⚑ 送信
                                                    </button>

                                                </form>

                                            </div>

                                        </div>

                                    </div>

                                </div>

                            </c:otherwise>

                        </c:choose>

                    </c:forEach>

                    <!-- メッセージがない場合 -->
                    <c:if test="${empty chatList}">
                        <p class="empty-message">
                            まだメッセージはありません。<br>
                            最初のメッセージを送ってみましょう！
                        </p>
                    </c:if>

                </div>

                <!-- メッセージ送信フォーム -->
                <form class="chat-form"
                      action="${pageContext.request.contextPath}/scoremanager/main/MatchingChatAdd.action"
                      method="post"
                      onsubmit="return checkMessage();">

                    <input type="hidden"
                           name="match_id"
                           value="${match_id}">

                    <input type="text"
                           id="content"
                           name="content"
                           class="chat-input"
                           placeholder="メッセージを入力してください"
                           maxlength="1000"
                           required>

                    <button type="submit" class="send-button">
                        送信
                    </button>

                </form>

            </main>
        </div>

    </c:param>

</c:import>
