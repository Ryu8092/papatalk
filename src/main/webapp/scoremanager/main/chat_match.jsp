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
 
            // 最後に取得したチャットID
            let lastChatId = 0;
 
            // 更新中かどうか
            let isUpdating = false;
 
            // 最初に表示されているチャットIDを取得
            window.addEventListener("load", function () {
 
                const chatArea = document.getElementById("chat-area");
 
                if (!chatArea) {
                    return;
                }
 
                const messages =
                    chatArea.querySelectorAll(".chat-message");
 
                messages.forEach(message => {
 
                    const chatId =
                        Number(message.dataset.chatId);
 
                    if (chatId > lastChatId) {
                        lastChatId = chatId;
                    }
                });
 
                // 最新メッセージまでスクロール
                chatArea.scrollTop = chatArea.scrollHeight;
            });
 
 
            // チャット履歴の自動更新
            function updateChat() {
 
                if (isUpdating) {
                    return;
                }
 
                const chatArea =
                    document.getElementById("chat-area");
 
                if (!chatArea) {
                    return;
                }
 
                isUpdating = true;
 
                // 更新前のスクロール位置を確認
                const isAtBottom =
                    chatArea.scrollHeight - chatArea.scrollTop
                    - chatArea.clientHeight < 50;
 
                const chatUrl =
                    "${pageContext.request.contextPath}/scoremanager/main/MatchingChat.action?match_id=${match_id}&ajax=true";
 
                fetch(chatUrl, {
                    cache: "no-store"
                })
                .then(response => {
 
                    if (!response.ok) {
                        throw new Error(
                            "チャット履歴の取得に失敗しました。"
                        );
                    }
 
                    return response.json();
                })
                .then(chatList => {
 
                    chatList.forEach(chat => {
 
                        const chatId = Number(chat.chat_id);
 
                        // すでに表示されているメッセージは追加しない
                        if (chatId <= lastChatId) {
                            return;
                        }
 
                        const isMine =
                            Number(chat.user_id)
                            === Number("${user.user_id}");
 
                        const messageDiv =
                            document.createElement("div");
 
                        messageDiv.className = isMine
                            ? "chat-message my-message"
                            : "chat-message other-message";
 
                        messageDiv.dataset.chatId = chatId;
 
                        // 送信者名
                        const sender =
                            document.createElement("span");
 
                        sender.className = "sender-name";
 
                        sender.textContent =
                            isMine ? "自分" : chat.nickname;
 
                        // メッセージ本文
                        const bubble =
                            document.createElement("div");
 
                        bubble.className = "message-bubble";
                        bubble.textContent = chat.content;
 
                        // 送信日時
                        const date =
                            document.createElement("span");
 
                        date.className = "message-date";
 
                        if (chat.create_at) {
 
                            const created = new Date(
                                chat.create_at.replace(" ", "T")
                            );
 
                            if (!isNaN(created.getTime())) {
 
                                date.textContent =
                                    created.getFullYear() + "/" +
                                    String(
                                        created.getMonth() + 1
                                    ).padStart(2, "0") + "/" +
                                    String(
                                        created.getDate()
                                    ).padStart(2, "0") + " " +
                                    String(
                                        created.getHours()
                                    ).padStart(2, "0") + ":" +
                                    String(
                                        created.getMinutes()
                                    ).padStart(2, "0");
                            }
                        }
 
                        messageDiv.appendChild(sender);
                        messageDiv.appendChild(bubble);
                        messageDiv.appendChild(date);
 
 
                        // 相手のメッセージには通報フォームを表示
                        if (!isMine) {
 
                            const index = "new_" + chatId;
 
                            const bottomButtons =
                                document.createElement("div");
 
                            bottomButtons.className = "bottom-buttons";
 
                            const reportForm =
                                document.createElement("div");
 
                            reportForm.className = "report-form";
 
                            // 通報ボタン
                            const reportButton =
                                document.createElement("button");
 
                            reportButton.type = "button";
                            reportButton.className =
                                "report-open-button";
 
                            reportButton.id =
                                "reportOpenButton_" + index;
 
                            reportButton.textContent = "⚑ 通報する";
 
                            reportButton.onclick = function () {
                                toggleChatReportForm(index);
                            };
 
                            // 通報フォーム
                            const reportArea =
                                document.createElement("div");
 
                            reportArea.className = "report-form-area";
 
                            reportArea.id =
                                "reportFormArea_" + index;
 
                            const form =
                                document.createElement("form");
 
                            form.action =
                                "${pageContext.request.contextPath}/scoremanager/main/MatchReport.action";
 
                            form.method = "post";
 
                            // 通報タイトル
                            const title =
                                document.createElement("h3");
 
                            title.className = "report-title";
 
                            title.textContent =
                                "⚑ このメッセージを通報する";
 
                            // チャットID
                            const chatIdInput =
                                document.createElement("input");
 
                            chatIdInput.type = "hidden";
                            chatIdInput.name = "chat_id";
                            chatIdInput.value = chatId;
 
                            // マッチングID
                            const matchIdInput =
                                document.createElement("input");
 
                            matchIdInput.type = "hidden";
                            matchIdInput.name = "match_id";
                            matchIdInput.value = "${match_id}";
 
                            // 通報理由
                            const reasonArea =
                                document.createElement("div");
 
                            reasonArea.className =
                                "report-input-area";
 
                            const reasonLabel =
                                document.createElement("label");
 
                            reasonLabel.className = "report-label";
                            reasonLabel.textContent = "通報理由";
 
                            const reasonSelect =
                                document.createElement("select");
 
                            reasonSelect.name = "report_reason_id";
                            reasonSelect.className = "report-select";
 
                            reasonSelect.id =
                                "reasonSelect_" + index;
 
                            reasonSelect.required = true;
 
                            // 通報理由一覧をコピー
                            const template =
                                document.getElementById(
                                    "report-reason-template"
                                );
 
                            if (template) {
 
                                Array.from(template.options).forEach(
                                    option => {
                                        reasonSelect.appendChild(
                                            option.cloneNode(true)
                                        );
                                    }
                                );
                            }
 
                            reasonSelect.onchange = function () {
                                validateChatReportForm(index);
                            };
 
                            reasonLabel.htmlFor = reasonSelect.id;
 
                            reasonArea.appendChild(reasonLabel);
                            reasonArea.appendChild(reasonSelect);
 
                            // 通報内容
                            const contentArea =
                                document.createElement("div");
 
                            contentArea.className =
                                "report-input-area";
 
                            const contentLabel =
                                document.createElement("label");
 
                            contentLabel.className = "report-label";
                            contentLabel.textContent = "通報内容";
 
                            const textarea =
                                document.createElement("textarea");
 
                            textarea.name = "content";
                            textarea.className = "report-textarea";
 
                            textarea.id =
                                "reportContent_" + index;
 
                            textarea.maxLength = 1000;
                            textarea.required = true;
 
                            textarea.placeholder =
                                "通報内容を入力してください";
 
                            textarea.oninput = function () {
                                validateChatReportForm(index);
                            };
 
                            contentLabel.htmlFor = textarea.id;
 
                            contentArea.appendChild(contentLabel);
                            contentArea.appendChild(textarea);
 
                            // 送信ボタン
                            const submitButton =
                                document.createElement("button");
 
                            submitButton.type = "submit";
                            submitButton.className = "btn-report";
 
                            submitButton.id =
                                "submitBtn_" + index;
 
                            submitButton.disabled = true;
                            submitButton.textContent = "⚑ 送信";
 
                            // フォームに追加
                            form.appendChild(title);
                            form.appendChild(chatIdInput);
                            form.appendChild(matchIdInput);
                            form.appendChild(reasonArea);
                            form.appendChild(contentArea);
                            form.appendChild(submitButton);
 
                            reportArea.appendChild(form);
 
                            reportForm.appendChild(reportButton);
                            reportForm.appendChild(reportArea);
 
                            bottomButtons.appendChild(reportForm);
 
                            messageDiv.appendChild(bottomButtons);
                        }
 
                        // 空メッセージがあれば削除
                        const emptyMessage =
                            chatArea.querySelector(".empty-message");
 
                        if (emptyMessage) {
                            emptyMessage.remove();
                        }
 
                        // 新しいメッセージだけ追加
                        chatArea.appendChild(messageDiv);
 
                        // 最後に取得したIDを更新
                        lastChatId = chatId;
                    });
 
                    // 更新前に一番下を見ていた場合だけ一番下へ移動
                    if (isAtBottom) {
                        chatArea.scrollTop = chatArea.scrollHeight;
                    }
                })
                .catch(error => {
                    console.error(error);
                })
                .finally(() => {
                    isUpdating = false;
                });
            }
 
 
            // 3秒ごとに更新
            setInterval(updateChat, 3000);
 
 
            // 通報フォーム開閉処理
            function toggleChatReportForm(index) {
 
                const form =
                    document.getElementById(
                        "reportFormArea_" + index
                    );
 
                const button =
                    document.getElementById(
                        "reportOpenButton_" + index
                    );
 
                if (!form || !button) {
                    return;
                }
 
                if (form.classList.contains("show")) {
 
                    form.classList.remove("show");
                    button.textContent = "⚑ 通報する";
 
                } else {
 
                    form.classList.add("show");
 
                    button.textContent =
                        "通報フォームを閉じる";
 
                    validateChatReportForm(index);
                }
            }
 
 
            // 通報フォーム入力チェック
            function validateChatReportForm(index) {
 
                const reasonSelect =
                    document.getElementById(
                        "reasonSelect_" + index
                    );
 
                const contentTextarea =
                    document.getElementById(
                        "reportContent_" + index
                    );
 
                const submitBtn =
                    document.getElementById(
                        "submitBtn_" + index
                    );
 
                if (!reasonSelect ||
                    !contentTextarea ||
                    !submitBtn) {
                    return;
                }
 
                if (reasonSelect.value === "" ||
                    contentTextarea.value.trim() === "") {
 
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
 
                    <h2 class="matching-title">${chat.nickname}チャット</h2>
 
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
 
                        <c:choose>
 
                            <c:when test="${chat.user_id == user.user_id}">
 
                                <div class="chat-message my-message"
                                     data-chat-id="${chat.chat_id}">
 
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
 
                                <div class="chat-message other-message"
                                     data-chat-id="${chat.chat_id}">
 
                                    <span class="sender-name">
                                        <c:out value="${chat.nickname}" />
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
 
 
                                            <div class="report-form-area"
                                                 id="reportFormArea_${status.index}">
 
                                                <form action="${pageContext.request.contextPath}/scoremanager/main/MatchReport.action"
                                                      method="post"
                                                      id="reportFormElement_${status.index}">
 
                                                    <h3 class="report-title">
                                                        ⚑ このメッセージを通報する
                                                    </h3>
 
                                                    <!-- チャットID -->
                                                    <input type="hidden"
                                                           name="chat_id"
                                                           value="${chat.chat_id}">
 
                                                    <!-- マッチングID -->
                                                    <input type="hidden"
                                                           name="match_id"
                                                           value="${match_id}">
 
 
                                                    <!-- 通報理由 -->
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
 
 
                                                    <!-- 通報内容 -->
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
 
 
                                                    <!-- 送信ボタン -->
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
                            まだメッセージはありません。
                            <br>
                            最初のメッセージを送ってみましょう！
                        </p>
                    </c:if>
 
                </div>
 
 
                <!-- 新しいメッセージ用の通報理由一覧 -->
                <select id="report-reason-template" style="display: none;">
 
                    <option value="">
                        通報理由を選択してください
                    </option>
 
                    <c:forEach var="reason" items="${reportReasons}">
                        <option value="${reason.report_reason_id}">
                            <c:out value="${reason.report_reason_name}" />
                        </option>
                    </c:forEach>
 
                </select>
 
 
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