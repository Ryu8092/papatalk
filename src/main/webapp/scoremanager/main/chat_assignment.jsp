<%@ page language="java" contentType="text/html; charset=UTF-8"

    pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<!DOCTYPE html>

<html lang="ja">

<head>

<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>パパトークシステム｜チャット</title>

<style>

* {

    box-sizing: border-box;

}

body {

    margin: 0;

    background-color: #f5f7fa;

    font-family: "Noto Sans JP", sans-serif;

    color: #334155;

}

/* 全体 */

.chat-layout {

    width: 100%;

    max-width: 1100px;

    min-height: 70vh;

    margin: 30px auto;

    padding: 20px;

}

/* メインカード */

.chat-card {

    background-color: #fff;

    border-radius: 14px;

    padding: 28px;

    box-shadow: 0 3px 12px rgba(31, 55, 85, .08);

}

/* ヘッダー */

.chat-header {

    border-bottom: 3px solid #ed9145;

    padding-bottom: 15px;

    margin-bottom: 25px;

}

.chat-header h2 {

    margin: 0;

    color: #24476b;

    font-size: 27px;

    font-weight: 700;

}

/* エラーメッセージ */

.error-message {

    color: #d9534f;

    background-color: #fff0f0;

    border: 1px solid #f0caca;

    border-radius: 8px;

    padding: 12px 15px;

    margin-bottom: 15px;

    font-size: 14px;

}

/* チャット履歴 */

.chat-history {

    background: #f7f9fc;

    border: 1px solid #dce4ed;

    border-radius: 12px;

    min-height: 450px;

    max-height: 650px;

    overflow-y: auto;

    padding: 25px;

}

/* メッセージ行 */

.message-row {

    display: flex;

    width: 100%;

    margin-bottom: 20px;

}

.message-row.mine {

    justify-content: flex-end;

}

.message-row.other {

    justify-content: flex-start;

}

/* メッセージ全体（名前＋吹き出し＋日時） */

.message-wrapper {

    display: flex;

    flex-direction: column;

    width: fit-content;

    max-width: 70%;

}

.message-row.mine .message-wrapper {

    align-items: flex-end;

}

.message-row.other .message-wrapper {

    align-items: flex-start;

}

/* 自分／相手の名前 */

.message-name {

    display: block;

    margin-bottom: 5px;

    font-size: 12px;

    color: #94a3b8;

}

/* 吹き出し */

.message-content {

    display: inline-block;

    width: fit-content;

    max-width: 100%;

    min-width: 0;

    padding: 10px 15px;

    border-radius: 12px;

    overflow-wrap: anywhere;

    box-shadow: 0 1px 3px rgba(0, 0, 0, .05);

}

/* 自分 */

.message-row.mine .message-content {

    background: #ed9145;

    color: #fff;

    border-bottom-right-radius: 3px;

}

/* 相手 */

.message-row.other .message-content {

    background: #fff;

    color: #334155;

    border: 1px solid #e2e8f0;

    border-bottom-left-radius: 3px;

}

/* メッセージ本文 */

.message-text {

    margin: 0;

    padding: 0;

    text-align: left;

    white-space: pre-wrap;

    overflow-wrap: anywhere;

    line-height: 1.7;

    font-size: 14px;

}

/* 送信日時 */

.message-time {

    display: block;

    margin-top: 5px;

    font-size: 11px;

    text-align: right;

    white-space: nowrap;

}

/* 自分の送信日時 */

.message-row.mine .message-time {

    color: #94a3b8;

}

/* 相手の送信日時 */

.message-row.other .message-time {

    color: #94a3b8;

}

/* メッセージがない場合 */

.no-chat {

    text-align: center;

    color: #718096;

    padding: 120px 10px;

    font-size: 15px;

    line-height: 1.8;

}

/* 入力フォーム */

.chat-form {

    margin-top: 20px;

    display: flex;

    gap: 10px;

    align-items: center;

}

.chat-form input[type="text"] {

    flex: 1;

    min-width: 0;

    height: 45px;

    padding: 0 14px;

    border: 1px solid #ccd5df;

    border-radius: 8px;

    font-size: 14px;

    outline: none;

}

.chat-form input[type="text"]:focus {

    border-color: #24476b;

    box-shadow: 0 0 0 2px rgba(36, 71, 107, .1);

}

/* ボタン共通 */

.btn {

    display: inline-block;

    border: none;

    border-radius: 8px;

    padding: 11px 22px;

    font-size: 14px;

    font-weight: 600;

    text-decoration: none;

    cursor: pointer;

    transition: background .2s;

    white-space: nowrap;

}

/* 送信ボタン */

.send-btn {

    background-color: #24476b;

    color: #fff;

}

.send-btn:hover {

    background-color: #193653;

}

/* 戻るボタン */

.back-btn {

    background-color: #e5eaf0;

    color: #334155;

}

.back-btn:hover {

    background-color: #d5dce5;

}

/* 通報ボタン */

.report-btn {

    background-color: #fff;

    color: #dc6868;

    border: 1px solid #dc6868;

}

.report-btn:hover {

    background-color: #fff0f0;

}

/* ボタン配置 */

.chat-buttons {

    display: flex;

    justify-content: space-between;

    align-items: center;

    gap: 10px;

    margin-top: 20px;

}

.chat-buttons form {

    margin: 0;

}

/* 通報フォーム */

.report-form {

    display: none;

    margin-top: 20px;

    padding: 22px;

    background-color: #fffafa;

    border: 1px solid #f0dada;

    border-radius: 10px;

}

.report-form.show {

    display: block;

}

.report-form h3 {

    margin: 0 0 20px;

    color: #dc6868;

    font-size: 18px;

}

.report-form label {

    display: block;

    margin-bottom: 8px;

    font-size: 14px;

    font-weight: 600;

    color: #334155;

}

.report-form select,

.report-form textarea {

    width: 100%;

    padding: 12px;

    border: 1px solid #ccd5df;

    border-radius: 8px;

    font-size: 14px;

    background-color: #fff;

    margin-bottom: 18px;

}

.report-form select:focus,

.report-form textarea:focus {

    outline: none;

    border-color: #dc6868;

}

.report-form textarea {

    min-height: 110px;

    resize: vertical;

}

.report-form .report-submit-area {

    display: flex;

    justify-content: flex-end;

    margin-top: 5px;

}

/* 取引状態エリア */

.handover-area {

    background: #fff;

    border: 1px solid #e2e8f0;

    border-radius: 12px;

    margin-top: 25px;

    padding: 22px;

}

.handover-area p {

    margin: 0 0 15px;

    font-size: 15px;

    color: #334155;

}

.handover-area strong {

    color: #24476b;

}

.handover-area form {

    display: inline-block;

    margin-top: 10px;

}

/* 取引ボタン */

.trade-buttons {

    display: flex;

    justify-content: flex-end;

    gap: 12px;

    margin-top: 15px;

}

.trade-buttons form {

    margin: 0;

}

.cancel-btn {

    background-color: #dc6868;

    color: #fff;

}

.cancel-btn:hover {

    background-color: #bd4e4e;

}

.complete-btn {

    background-color: #27866c;

    color: #fff;

}

.complete-btn:hover {

    background-color: #1e6b56;

}

/* スマートフォン */

@media (max-width: 768px) {

    .chat-layout {

        margin: 10px auto;

        padding: 10px;

    }

    .chat-card {

        padding: 18px;

    }

    .chat-header h2 {

        font-size: 23px;

    }

    .chat-history {

        min-height: 350px;

        padding: 15px;

    }

    .message-wrapper {

        max-width: 85%;

    }

    .message-content {

        max-width: 100%;

    }

    .chat-form {

        flex-wrap: wrap;

    }

    .chat-form input[type="text"] {

        flex-basis: 100%;

    }

    .chat-form button {

        flex: 1;

    }

    .chat-buttons {

        flex-direction: column;

        align-items: stretch;

    }

    .chat-buttons button,

    .chat-buttons a {

        width: 100%;

        text-align: center;

    }

    .trade-buttons {

        flex-direction: column;

    }

    .trade-buttons form {

        display: block;

    }

    .trade-buttons button {

        width: 100%;

    }

    .report-form .report-submit-area {

        justify-content: stretch;

    }

    .report-form .report-submit-area button {

        width: 100%;

    }

}

/* 吹き出しの幅は本文の文字数に合わせる */
.message-row .message-wrapper {
    display: flex;
    flex-direction: column;
    width: max-content;
    max-width: 70%;
    min-width: 0;
    flex: 0 1 auto;
}

.message-row.mine .message-wrapper {
    align-items: flex-end;
}

.message-row.other .message-wrapper {
    align-items: flex-start;
}

.message-row .message-content {
    display: block;
    width: fit-content;
    max-width: 100%;
    min-width: 0;
    height: auto;
    box-sizing: border-box;
    padding: 10px 15px;
    overflow-wrap: anywhere;
}

.message-row .message-text {
    display: block;
    width: auto;
    min-width: 0;
    max-width: 100%;
    margin: 0;
    padding: 0;
    white-space: pre-wrap;
    overflow-wrap: anywhere;
    line-height: 1.7;
}

@media (max-width: 768px) {
    .message-row .message-wrapper {
        max-width: 85%;
    }
}

</style>

</head>

<body>

<div class="chat-layout">

    <div class="chat-card">

        <!-- チャット画面の見出し -->

        <div class="chat-header">

            <h2>おさがり譲渡チャット</h2>

        </div>

        <!-- エラーメッセージ -->

        <c:if test="${not empty errorMessage}">

            <div class="error-message">

                <c:out value="${errorMessage}" />

            </div>

        </c:if>

        <!-- 通報結果メッセージ -->

        <c:if test="${not empty reportMessage}">

            <div class="error-message">

                <c:out value="${reportMessage}" />

            </div>

        </c:if>

        <div class="chat-history">

            <c:choose>

                <c:when test="${not empty chats}">

                    <c:forEach var="chat" items="${chats}">

                        <div class="message-row ${(isSeller and chat.sender_id == 1) or (isBuyer and chat.sender_id == 0) ? 'mine' : 'other'}">

                            <div class="message-wrapper">

                                <!-- 自分のメッセージには「自分」と表示 -->

                                <c:if test="${(isSeller and chat.sender_id == 1) or (isBuyer and chat.sender_id == 0)}">

                                    <span class="message-name">自分</span>

                                </c:if>

                                <!-- メッセージ吹き出し -->

                                <div class="message-content">

                                    <p class="message-text"><c:out value="${chat.content}" /></p>

                                </div>

                                <!-- 送信日時（吹き出しの外） -->

                                <span class="message-time">

                                    <c:out value="${fn:substring(chat.create_at, 0, 4)}年${fn:substring(chat.create_at, 5, 7)}月${fn:substring(chat.create_at, 8, 10)}日 ${fn:substring(chat.create_at, 11, 13)}時${fn:substring(chat.create_at, 14, 16)}分" />

                                </span>

                            </div>

                        </div>

                    </c:forEach>

                </c:when>

                <c:otherwise>

                    <p class="no-chat">

                        まだメッセージはありません。<br>

                        最初のメッセージを送信してください。

                    </p>

                </c:otherwise>

            </c:choose>

        </div>

        <!-- メッセージ送信フォーム -->

        <form id="messageForm"

              class="chat-form"

              action="/papatalk/scoremanager/main/AssignmentChatExecute.action"

              method="post">

            <input type="hidden"

                   name="product_id"

                   value="${product_id}">

            <input type="hidden"

                   name="buyer_id"

                   value="${buyer_id}">

            <input type="text"

                   name="content"

                   placeholder="メッセージを入力してください。"

                   required

                   maxlength="1000">

            <button type="submit" class="btn send-btn">

                送信

            </button>

            <button type="button"

                    id="reportToggleBtn"

                    class="btn report-btn"

                    onclick="toggleReportForm()">

                通報

            </button>

        </form>

        <!-- 通報フォーム -->

        <form id="reportForm"

              action="/papatalk/scoremanager/main/Report.action"

              method="post"

              class="report-form">

            <h3>チャットメッセージを通報する</h3>

            <input type="hidden"

                   name="report_type"

                   value="chat">

            <input type="hidden"

                   name="report_content_id"

                   value="1">

            <input type="hidden"

                   name="product_id"

                   value="${product_id}">

            <input type="hidden"

                   name="buyer_id"

                   value="${buyer_id}">

            <input type="hidden"

                   name="reported_user_id"

                   id="reported_user_id"

                   value="${chatPartnerId}">

            <label for="selected_chat_id">

                通報するメッセージ

            </label>

            <select name="chat_id"

                    id="selected_chat_id"

                    required

                    onchange="setReportedUser()">

                <option value="">

                    メッセージを選択してください

                </option>

                <c:forEach var="chat" items="${chats}">

                    <c:if test="${isSeller and chat.sender_id == 0}">

                        <option value="${chat.chat_id}">

                            <c:out value="${chat.content}" />

                        </option>

                    </c:if>

                    <c:if test="${isBuyer and chat.sender_id == 1}">

                        <option value="${chat.chat_id}">

                            <c:out value="${chat.content}" />

                        </option>

                    </c:if>

                </c:forEach>

            </select>

            <label for="report_reason_id">

                通報理由

            </label>

            <select name="report_reason_id"

                    id="report_reason_id"

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

            <label for="report_content">

                通報内容

            </label>

            <textarea name="content"

                      id="report_content"

                      placeholder="通報した理由や詳細を入力してください。"

                      maxlength="1000"

                      required></textarea>

            <div class="report-submit-area">

                <button type="submit" class="btn report-btn">

                    通報する

                </button>

            </div>

        </form>

        <!-- 戻るボタン -->

        <div class="chat-buttons">

            <a href="AssignmentTop.action?product_id=${product_id}"

               class="btn back-btn">

                戻る

            </a>

        </div>

    </div>

    <!-- 出品者のみ取引状態変更エリアを表示 -->

    <c:if test="${showHandoverButton}">

        <div class="handover-area">

            <p>

                取引状態：

                <strong>

                    <c:choose>

                        <c:when test="${status == '0'}">募集中</c:when>

                        <c:when test="${status == '1'}">受け渡し予定</c:when>

                        <c:when test="${status == '2'}">取引完了</c:when>

                        <c:when test="${status == '3'}">取引中止</c:when>

                        <c:otherwise>状態不明</c:otherwise>

                    </c:choose>

                </strong>

            </p>

            <!-- STATUS = 0 -->

            <c:if test="${status == '0'}">

                <form action="/papatalk/scoremanager/main/ProductStateUpdate.action"

                      method="post">

                    <input type="hidden" name="product_id" value="${product_id}">

                    <input type="hidden" name="buyer_id" value="${buyer_id}">

                    <input type="hidden" name="status" value="1">

                    <button type="submit" class="btn send-btn">

                        受け渡し予定者にする

                    </button>

                </form>

            </c:if>

            <!-- STATUS = 1 -->

            <c:if test="${status == '1'}">

                <div class="trade-buttons">

                    <form action="/papatalk/scoremanager/main/ProductStateUpdate.action"

                          method="post">

                        <input type="hidden" name="product_id" value="${product_id}">

                        <input type="hidden" name="buyer_id" value="${buyer_id}">

                        <input type="hidden" name="status" value="3">

                        <button type="submit" class="btn cancel-btn">

                            取引中止

                        </button>

                    </form>

                    <form action="/papatalk/scoremanager/main/ProductStateUpdate.action"

                          method="post">

                        <input type="hidden" name="product_id" value="${product_id}">

                        <input type="hidden" name="buyer_id" value="${buyer_id}">

                        <input type="hidden" name="status" value="2">

                        <button type="submit" class="btn complete-btn">

                            取引完了

                        </button>

                    </form>

                </div>

            </c:if>

        </div>

    </c:if>

</div>

<script>

/* 通報フォームの表示・非表示 */

function toggleReportForm() {

    const reportForm = document.getElementById("reportForm");

    const reportButton = document.getElementById("reportToggleBtn");

    reportForm.classList.toggle("show");

    if (reportForm.classList.contains("show")) {

        reportButton.textContent = "通報フォームを閉じる";

        reportForm.scrollIntoView({

            behavior: "smooth",

            block: "start"

        });

    } else {

        reportButton.textContent = "通報";

    }

}

/* 選択したメッセージの通報対象ユーザーIDを設定 */

function setReportedUser() {

    const select = document.getElementById("selected_chat_id");

    const reportedUserId = document.getElementById("reported_user_id");

    if (select.value === "") {

        reportedUserId.value = "";

        return;

    }

    reportedUserId.value = "${chatPartnerId}";

}

</script>

</body>

</html>
