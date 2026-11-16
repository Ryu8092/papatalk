<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

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
    color: #333;
}

.chat-layout {
    max-width: 1000px;
    min-height: 70vh;
    margin: 30px auto;
    padding: 20px;
}

.chat-card {
    background-color: #fff;
    border-radius: 14px;
    padding: 25px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.06);
}

.chat-header {
    border-bottom: 2px solid #e5eaf0;
    padding-bottom: 15px;
    margin-bottom: 20px;
}

.chat-header h2 {
    margin: 0 0 8px;
    color: #24476b;
    font-size: 23px;
}

.chat-info {
    color: #666;
    font-size: 14px;
}

.chat-history {
    min-height: 350px;
    max-height: 500px;
    overflow-y: auto;
    padding: 20px;
    background-color: #f7f9fc;
    border-radius: 10px;
    margin-bottom: 20px;
}

.no-chat {
    text-align: center;
    color: #888;
    padding: 100px 10px;
    font-size: 15px;
}

.message-row {
    display: flex;
    margin-bottom: 18px;
}

.message-row.mine {
    justify-content: flex-end;
}

.message-row.other {
    justify-content: flex-start;
}

.message-content {
    max-width: 70%;
    padding: 12px 16px;
    border-radius: 12px;
    overflow-wrap: anywhere;
}

.mine .message-content {
    background-color: #dceeff;
    border-bottom-right-radius: 3px;
}

.other .message-content {
    background-color: #fff;
    border: 1px solid #e1e6ec;
    border-bottom-left-radius: 3px;
}

.message-text {
    margin: 0;
    white-space: pre-wrap;
    line-height: 1.6;
}

.message-date {
    display: block;
    margin-top: 6px;
    font-size: 11px;
    color: #888;
    text-align: right;
}

.error-message {
    color: #d9534f;
    background-color: #fff0f0;
    border: 1px solid #f0caca;
    border-radius: 8px;
    padding: 10px 14px;
    margin-bottom: 15px;
    font-size: 14px;
}

/* メッセージ入力欄 */
.chat-form {
    margin-top: 20px;
}

.chat-form textarea {
    width: 100%;
    min-height: 90px;
    padding: 12px;
    border: 1px solid #ccd5df;
    border-radius: 9px;
    font-size: 14px;
    resize: vertical;
}

.chat-form textarea:focus {
    outline: none;
    border-color: #24476b;
}

/* 通報フォーム：最初は非表示 */
.report-form {
    display: none;
    margin-top: 20px;
    padding: 20px;
    background-color: #fffafa;
    border: 1px solid #f0dada;
    border-radius: 10px;
}

/* 通報フォーム表示 */
.report-form.show {
    display: block;
}

.report-form h3 {
    margin: 0 0 15px;
    color: #dc6868;
    font-size: 17px;
}

.report-form label {
    display: block;
    margin-bottom: 8px;
    font-size: 14px;
    font-weight: bold;
}

.report-form select,
.report-form textarea {
    width: 100%;
    padding: 12px;
    border: 1px solid #ccd5df;
    border-radius: 8px;
    font-size: 14px;
    background-color: #fff;
}

.report-form select {
    margin-bottom: 18px;
}

.report-form textarea {
    min-height: 100px;
    resize: vertical;
}

.report-form select:focus,
.report-form textarea:focus {
    outline: none;
    border-color: #dc6868;
}

.report-form .report-submit-area {
    display: flex;
    justify-content: flex-end;
    margin-top: 15px;
}

/* ボタン配置 */
.chat-buttons {
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 10px;
    margin-top: 15px;
}

.chat-buttons form {
    margin: 0;
}

.btn {
    display: inline-block;
    border: none;
    border-radius: 8px;
    padding: 11px 22px;
    font-size: 14px;
    text-decoration: none;
    cursor: pointer;
}

.back-btn {
    background-color: #e5eaf0;
    color: #333;
}

.send-btn {
    background-color: #24476b;
    color: #fff;
}

.send-btn:hover {
    background-color: #193653;
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

/* 取引状態変更エリア */
.handover-area {
    border-top: 1px solid #e5eaf0;
    margin-top: 25px;
    padding-top: 20px;
    text-align: right;
}

.handover-area p {
    margin-bottom: 15px;
    font-size: 15px;
}

.handover-area form {
    display: inline-block;
    margin-top: 10px;
}

/* 取引中止・完了ボタン */
.trade-buttons {
    display: flex;
    justify-content: flex-end;
    gap: 12px;
    margin-top: 15px;
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

/* スマートフォン対応 */
@media (max-width: 768px) {

    .chat-layout {
        margin: 10px auto;
        padding: 10px;
    }

    .chat-card {
        padding: 15px;
    }

    .message-content {
        max-width: 85%;
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

    .report-form .report-submit-area {
        justify-content: stretch;
    }

    .report-form .report-submit-area button {
        width: 100%;
    }
}
</style>

</head>

<body>

<div class="chat-layout">
    <div class="chat-card">

        <%-- チャット画面の見出し --%>
        <div class="chat-header">

            <h2>おさがり譲渡チャット</h2>

            <div class="chat-info">
                商品ID：
                <c:out value="${product_id}" />
                ／
                購入者ID：
                <c:out value="${buyer_id}" />
            </div>

        </div>

        <%-- エラーメッセージ --%>
        <c:if test="${not empty errorMessage}">
            <div class="error-message">
                <c:out value="${errorMessage}" />
            </div>
        </c:if>

        <%-- 通報結果メッセージ --%>
        <c:if test="${not empty reportMessage}">
            <div class="error-message">
                <c:out value="${reportMessage}" />
            </div>
        </c:if>

        <%-- チャット履歴 --%>
        <div class="chat-history">

            <c:choose>

                <c:when test="${not empty chats}">

                    <c:forEach var="chat" items="${chats}">

                        <div class="message-row ${(isSeller and chat.sender_id == 1) or (isBuyer and chat.sender_id == 0) ? 'mine' : 'other'}">

                            <div class="message-content">

                                <p class="message-text">
                                    <c:out value="${chat.content}" />
                                </p>

                                <span class="message-date">
                                    <c:out value="${chat.create_at}" />
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

        <%-- メッセージ送信フォーム --%>
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

            <textarea name="content"
                      placeholder="メッセージを入力してください。"
                      required
                      maxlength="1000"></textarea>

        </form>

        <%-- 通報フォーム --%>
        <form id="reportForm"
              action="/papatalk/scoremanager/main/Report.action"
              method="post"
              class="report-form">

            <h3>チャットメッセージを通報する</h3>

            <%-- 通報種別：チャット --%>
            <input type="hidden"
                   name="report_type"
                   value="chat">

            <%-- 通報分類ID --%>
            <input type="hidden"
                   name="report_content_id"
                   value="1">

            <%-- 商品ID --%>
            <input type="hidden"
                   name="product_id"
                   value="${product_id}">

            <%-- 購入者ID --%>
            <input type="hidden"
                   name="buyer_id"
                   value="${buyer_id}">

            <%-- 通報対象ユーザーID --%>
            <input type="hidden"
                   name="reported_user_id"
                   id="reported_user_id"
                   value="${chatPartnerId}">

            <%-- ① 通報するメッセージを選択 --%>
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

            <%-- ② 通報理由 --%>
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

            <%-- ③ 通報内容 --%>
            <label for="report_content">
                通報内容
            </label>

            <textarea name="content"
                      id="report_content"
                      placeholder="通報した理由や詳細を入力してください。"
                      maxlength="1000"
                      required></textarea>

            <%-- ④ 通報する --%>
            <div class="report-submit-area">

                <button type="submit"
                        class="btn report-btn">
                    通報する
                </button>

            </div>

        </form>

        <%-- 戻る・通報・メッセージ送信ボタン --%>
        <div class="chat-buttons">

            <%-- 戻る --%>
            <a href="AssignmentTop.action?product_id=${product_id}"
               class="btn back-btn">
                戻る
            </a>

            <%-- 通報 --%>
            <button type="button"
                    id="reportToggleBtn"
                    class="btn report-btn"
                    onclick="toggleReportForm()">
                通報
            </button>

            <%-- メッセージ送信 --%>
            <button type="submit"
                    form="messageForm"
                    class="btn send-btn">
                メッセージを送信
            </button>

        </div>

        <%-- 出品者のみ取引状態変更エリアを表示 --%>
        <c:if test="${showHandoverButton}">

            <div class="handover-area">

                <p>
                    取引状態：
                    <strong>

                        <c:choose>

                            <c:when test="${status == '0'}">
                                募集中
                            </c:when>

                            <c:when test="${status == '1'}">
                                受け渡し予定
                            </c:when>

                            <c:when test="${status == '2'}">
                                取引完了
                            </c:when>

                            <c:when test="${status == '3'}">
                                取引中止
                            </c:when>

                            <c:otherwise>
                                状態不明
                            </c:otherwise>

                        </c:choose>

                    </strong>
                </p>

                <%-- STATUS = 0：受け渡し予定者にする --%>
                <c:if test="${status == '0'}">

                    <form action="/papatalk/scoremanager/main/ProductStateUpdate.action"
                          method="post">

                        <input type="hidden"
                               name="product_id"
                               value="${product_id}">

                        <input type="hidden"
                               name="buyer_id"
                               value="${buyer_id}">

                        <input type="hidden"
                               name="status"
                               value="1">

                        <button type="submit"
                                class="btn send-btn">
                            受け渡し予定者にする
                        </button>

                    </form>

                </c:if>

                <%-- STATUS = 1：取引中止・取引完了 --%>
                <c:if test="${status == '1'}">

                    <div class="trade-buttons">

                        <%-- 取引中止 --%>
                        <form action="/papatalk/scoremanager/main/ProductStateUpdate.action"
                              method="post">

                            <input type="hidden"
                                   name="product_id"
                                   value="${product_id}">

                            <input type="hidden"
                                   name="buyer_id"
                                   value="${buyer_id}">

                            <input type="hidden"
                                   name="status"
                                   value="3">

                            <button type="submit"
                                    class="btn cancel-btn">
                                取引中止
                            </button>

                        </form>

                        <%-- 取引完了 --%>
                        <form action="/papatalk/scoremanager/main/ProductStateUpdate.action"
                              method="post">

                            <input type="hidden"
                                   name="product_id"
                                   value="${product_id}">

                            <input type="hidden"
                                   name="buyer_id"
                                   value="${buyer_id}">

                            <input type="hidden"
                                   name="status"
                                   value="2">

                            <button type="submit"
                                    class="btn complete-btn">
                                取引完了
                            </button>

                        </form>

                    </div>

                </c:if>

            </div>

        </c:if>

    </div>
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