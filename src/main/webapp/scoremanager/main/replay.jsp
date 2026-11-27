<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<c:import url="/common/base.jsp">
    <c:param name="title">返信一覧｜パパトークシステム</c:param>
    <c:param name="scripts"></c:param>
    <c:param name="content">

        <style>
            .reply-layout {
                max-width: 900px;
                margin: 0 auto;
                padding: 30px 20px;
                box-sizing: border-box;
                text-align: left;
                background: #ffffff;
                border-radius: 12px;
                min-height: 70vh;
            }

            /* ヘッダー */
            .reply-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                gap: 15px;
                padding-bottom: 15px;
                border-bottom: 3px solid #ed9145;
                margin-bottom: 25px;
            }

            .reply-title {
                color: #24476b;
                font-size: 27px;
                font-weight: 700;
                margin: 0;
            }

            /* 戻るボタン */
            .back-form {
                margin: 0;
                flex-shrink: 0;
            }

            .back-button {
                display: inline-block;
                padding: 9px 20px;
                background: #ffffff;
                color: #24476b;
                border: 1px solid #24476b;
                border-radius: 6px;
                font-size: 14px;
                font-weight: bold;
                cursor: pointer;
                transition: .2s;
            }

            .back-button:hover {
                background: #f1f5f9;
            }

            /* 元投稿 */
            .original-post-card {
                background: #f8fafc;
                border: 1px solid #cbd5e1;
                border-radius: 12px;
                padding: 22px 25px;
                margin-bottom: 25px;
            }

            .original-post-title {
                color: #24476b;
                font-size: 20px;
                font-weight: 700;
                margin-bottom: 12px;
            }

            .original-post-content {
                color: #334155;
                font-size: 15px;
                line-height: 1.8;
                white-space: pre-wrap;
                overflow-wrap: anywhere;
                margin-bottom: 15px;
            }

            /* 元投稿情報 */
            .reply-info {
                display: flex;
                justify-content: space-between;
                color: #718096;
                font-size: 13px;
                margin-bottom: 12px;
                border-bottom: 1px solid #edf0f4;
                padding-bottom: 8px;
            }

            /* 返信入力フォーム */
            .reply-form-section {
                background: #fff;
                border: 1px solid #e2e8f0;
                border-radius: 12px;
                padding: 22px 25px;
                margin-bottom: 25px;
                box-shadow: 0 2px 8px rgba(31,55,85,.05);
            }

            .form-group {
                margin-bottom: 0;
                flex: 1;
                min-width: 0;
            }

            .reply-input-row {
                display: flex;
                align-items: flex-end;
                gap: 12px;
            }

            .reply-textarea {
                width: 100%;
                height: 44px;
                min-height: 44px;
                max-height: 44px;
                box-sizing: border-box;
                padding: 10px 12px;
                border: 1px solid #cbd5e1;
                border-radius: 6px;
                background: #fff;
                color: #344b63;
                font-size: 15px;
                resize: none;
                line-height: 22px;
            }

            .btn-submit {
                display: inline-block;
                height: 44px;
                min-height: 44px;
                box-sizing: border-box;
                padding: 0 24px;
                background: #ed9145;
                color: #fff;
                border: none;
                border-radius: 6px;
                font-weight: bold;
                font-size: 15px;
                cursor: pointer;
                transition: .2s;
                white-space: nowrap;
                flex-shrink: 0;
            }

            .btn-submit:hover:not(:disabled) {
                background: #d97c30;
            }

            .btn-submit:disabled {
                background: #cbd5e1;
                cursor: not-allowed;
            }

            /* 返信一覧エリア */
            .reply-list-section {
                margin-top: 25px;
            }

            /* 返信一覧開閉ボタン */
            .reply-toggle-button {
                display: flex;
                justify-content: space-between;
                align-items: center;
                width: 100%;
                padding: 17px 20px;
                background: #f1f5f9;
                border: 1px solid #dbe4ee;
                border-radius: 10px;
                color: #24476b;
                font-size: 15px;
                font-weight: bold;
                cursor: pointer;
                transition: .2s;
            }

            .reply-toggle-button:hover {
                background: #e8eff6;
                border-color: #24476b;
            }

            .reply-toggle-left {
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .reply-count {
                display: inline-flex;
                justify-content: center;
                align-items: center;
                min-width: 25px;
                height: 25px;
                padding: 0 7px;
                box-sizing: border-box;
                background: #24476b;
                color: #fff;
                border-radius: 20px;
                font-size: 12px;
            }

            .reply-toggle-icon {
                font-size: 18px;
                transition: transform .2s;
            }

            .reply-toggle-button.open .reply-toggle-icon {
                transform: rotate(180deg);
            }

            /* 返信一覧表示部分 */
            .reply-list {
                display: none;
                flex-direction: column;
                align-items: stretch;
                gap: 18px;
                width: 100%;
                box-sizing: border-box;
                margin-top: 18px;
                padding: 20px;
                background: #f8fafc;
                border: 1px solid #e2e8f0;
                border-radius: 12px;
                text-align: left;
            }

            .reply-list.show {
                display: flex;
            }

            /* 返信一覧見出し */
            .reply-list-heading {
                display: flex;
                align-items: center;
                gap: 9px;
                color: #24476b;
                font-size: 17px;
                font-weight: bold;
                padding-bottom: 13px;
                border-bottom: 2px solid #ed9145;
            }

            /* 返信カード */
            .reply-card {
                display: block;
                width: 100%;
                box-sizing: border-box;
                align-self: stretch;
                text-align: left;
                background: #ffffff;
                border: 1px solid #e2e8f0;
                border-left: 4px solid #ed9145;
                border-radius: 11px;
                padding: 19px 20px;
                box-shadow: 0 3px 10px rgba(36,71,107,.06);
                transition: box-shadow .2s;
            }

            .reply-card:hover {
                box-shadow: 0 5px 14px rgba(36,71,107,.11);
            }

            /* 返信者名・返信日 */
            .reply-card-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                gap: 10px;
                margin-bottom: 14px;
            }

            /* 返信者名 */
            .reply-number {
                display: flex;
                align-items: center;
                gap: 10px;
                color: #24476b;
                font-size: 15px;
                font-weight: 700;
                min-width: 0;
            }

            /* ユーザーアイコン */
            .reply-number-icon {
                display: inline-flex;
                justify-content: center;
                align-items: center;
                width: 34px;
                height: 34px;
                flex-shrink: 0;
                background: #eaf0f7;
                color: #24476b;
                border-radius: 50%;
                font-size: 16px;
            }

            /* 返信日 */
            .reply-date {
                color: #94a3b8;
                font-size: 12px;
                white-space: nowrap;
            }

            /* 返信本文 */
            .reply-content {
                position: relative;
                text-align: left;
                background: #f1f5f9;
                color: #334155;
                font-size: 15px;
                line-height: 1.9;
                white-space: pre-wrap;
                overflow-wrap: anywhere;
                padding: 17px 19px;
                border-radius: 10px;
                margin-bottom: 15px;
            }

            /* 吹き出しのしっぽ */
            .reply-content::before {
                content: "";
                position: absolute;
                top: -7px;
                left: 18px;
                width: 13px;
                height: 13px;
                background: #f1f5f9;
                transform: rotate(45deg);
            }

            /* 通報ボタン配置 */
            .bottom-buttons {
                display: flex;
                justify-content: flex-end;
                align-items: center;
                margin-top: 12px;
                padding-top: 12px;
                border-top: 1px solid #edf0f4;
            }

            .report-form {
                width: 100%;
                max-width: 520px;
                min-width: 0;
                margin: 0;
            }

            .report-open-button {
                display: inline-block;
                padding: 7px 16px;
                color: #d9534f;
                background: #fff5f5;
                border: 1px solid #f1c5c3;
                border-radius: 20px;
                font-size: 12px;
                font-weight: bold;
                cursor: pointer;
                transition: .2s;
            }

            .report-open-button:hover {
                color: #ffffff;
                background: #d9534f;
                border-color: #d9534f;
            }

            /* 通報フォーム */
            .report-form-area {
                display: none;
                width: 100%;
                margin-top: 15px;
                background: #f8fafc;
                padding: 18px;
                border: 1px solid #e2e8f0;
                border-radius: 10px;
                box-sizing: border-box;
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

            .report-textarea {
                min-height: 90px;
                resize: vertical;
            }

            .report-input-area {
                margin-bottom: 12px;
            }

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

            .btn-report:disabled {
                background: #cbd5e1;
                border-color: #cbd5e1;
                cursor: not-allowed;
            }

            /* メッセージ */
            .error-message {
                color: #d93025;
                background: #fff0f0;
                padding: 13px 16px;
                border-radius: 8px;
                margin-bottom: 20px;
                font-size: 14px;
            }

            /* 返信なし */
            .no-reply-message {
                text-align: center;
                padding: 30px 15px;
                color: #718096;
                background: #ffffff;
                border-radius: 10px;
                border: 1px dashed #cbd5e1;
                font-size: 14px;
            }
            

            /* スマホ対応 */
            @media (max-width: 768px) {
                .reply-layout {
                    padding: 20px 15px;
                }

                .reply-header {
                    gap: 10px;
                }

                .reply-title {
                    font-size: 23px;
                }

                .back-button {
                    padding: 8px 14px;
                    font-size: 13px;
                }

                .original-post-card,
                .reply-form-section {
                    padding: 18px 15px;
                }

                .reply-info {
                    flex-direction: column;
                    gap: 5px;
                }

                .reply-input-row {
                    flex-direction: column;
                    align-items: stretch;
                }

                .reply-textarea {
                    width: 100%;
                }

                .btn-submit {
                    align-self: flex-end;
                }

                .reply-list {
                    padding: 12px;
                }

                .reply-card {
                    padding: 16px 13px;
                }

                .reply-card-header {
                    gap: 8px;
                }

                .reply-number {
                    font-size: 14px;
                }

                .reply-content {
				    white-space: pre-wrap;
				    text-align: left;
				    padding: 12px;
				    margin: 0;
				    line-height: 1.6;
				}

                .reply-toggle-button {
                    padding: 14px;
                    font-size: 14px;
                }
            }
        </style>

        <div class="reply-layout">

            <!-- タイトルと戻るボタン -->
            <div class="reply-header">
                <h2 class="reply-title">返信一覧</h2>

                <form action="/papatalk/scoremanager/main/RetrievePosts.action"
                      method="get"
                      class="back-form">

                    <button type="submit" class="back-button">
                        戻る
                    </button>
                </form>
            </div>

            <!-- エラーメッセージ -->
            <c:if test="${not empty errorMessage}">
                <div class="error-message">
                    <c:out value="${errorMessage}" />
                </div>
            </c:if>

            <c:if test="${not empty reportMessage}">
                <div class="error-message"
                     style="color: #24476b; background: #fff4e8; border: 1px solid #ed9145;">
                    <c:out value="${reportMessage}" />
                </div>
            </c:if>

            <!-- 元投稿 -->
            <c:if test="${not empty post}">
                <div class="original-post-card">

                    <h3 class="original-post-title">
                        <c:out value="${post.post_title}" />
                    </h3>

                    <div class="original-post-content">
                        <c:out value="${post.post_content}" />
                    </div>

                    <div class="reply-info">
                        <span>
                            投稿者：<c:out value="${post.nickname}" />
                        </span>

                        <span>
                            投稿日：
                            <c:if test="${not empty post.post_date}">
                                <fmt:formatDate
                                    value="${post.post_date}"
                                    pattern="yyyy年MM月dd日 HH時mm分" />
                            </c:if>
                        </span>
                    </div>
                </div>
            </c:if>

            <!-- 返信入力フォーム -->
            <div class="reply-form-section">
                <form action="<c:url value='/scoremanager/main/RegisterReply.action' />"
                      method="post">

                    <input type="hidden"
                           name="post_id"
                           value="${post.post_id}">

                    <div class="reply-input-row">
                        <div class="form-group">
                            <textarea name="reply_content"
                                      id="replyContentArea"
                                      class="reply-textarea"
                                      placeholder="返信内容を入力してください"
                                      oninput="validateReplyInput()"
                                      required></textarea>
                        </div>

                        <button type="submit"
                                id="replySubmitBtn"
                                class="btn-submit"
                                disabled>
                            送信
                        </button>
                    </div>
                </form>
            </div>

            <!-- 返信一覧 -->
            <div class="reply-list-section">

                <!-- 返信一覧開閉ボタン -->
                <button type="button"
                        class="reply-toggle-button"
                        id="replyToggleButton"
                        aria-expanded="false"
                        aria-controls="replyListArea"
                        onclick="toggleReplyList()">

                    <span class="reply-toggle-left">
                        <span>✉</span>
                        <span>返信</span>
                        <span class="reply-count">
                            <c:out value="${empty replyList ? 0 : replyList.size()}" />
                        </span>
                    </span>

                    <span class="reply-toggle-icon">▼</span>
                </button>

                <!-- 返信一覧の中身 -->
                <div class="reply-list" id="replyListArea">

                    <div class="reply-list-heading">
                    </div>

                    <c:choose>
                        <c:when test="${empty replyList}">
                            <div class="no-reply-message">
                                まだ返信はありません。
                            </div>
                        </c:when>

                        <c:otherwise>
                            <c:forEach var="reply"
                                       items="${replyList}"
                                       varStatus="status">

                                <article class="reply-card">

                                    <!-- 返信者名と返信日 -->
                                    <div class="reply-card-header">

                                        <div class="reply-number">
                                            <span class="reply-number-icon">
                                                👤
                                            </span>

                                            <span>
                                                <c:out value="${reply.nickname}" />
                                            </span>
                                        </div>

                                        <span class="reply-date">
                                            <c:if test="${not empty reply.reply_date}">
                                                <c:out value="${fn:substring(reply.reply_date, 0, 4)}年${fn:substring(reply.reply_date, 5, 7)}月${fn:substring(reply.reply_date, 8, 10)}日 ${fn:substring(reply.reply_date, 11, 13)}時${fn:substring(reply.reply_date, 14, 16)}分" />
                                            </c:if>
                                        </span>
                                    </div>

 
									<!-- 返信内容 -->
									<div class="reply-content"><c:out value="${fn:trim(reply.reply_content)}" /></div>

                                    <!-- 通報ボタン -->
                                    <div class="bottom-buttons">
                                        <div class="report-form">

                                            <button type="button"
                                                    class="report-open-button"
                                                    id="reportOpenButton_${status.index}"
                                                    onclick="toggleReplyReportForm(${status.index})">
                                                ⚑ 通報する
                                            </button>

                                            <!-- 通報フォーム -->
                                            <div class="report-form-area"
                                                 id="reportFormArea_${status.index}">

                                                <form action="<c:url value='/scoremanager/main/ChatReportRegistration.action' />"
                                                      method="post"
                                                      id="reportFormElement_${status.index}">

                                                    <h3 class="report-title">
                                                        ⚑ この返信を通報する
                                                    </h3>

                                                    <input type="hidden"
                                                           name="reply_id"
                                                           value="${reply.reply_id}">

                                                    <input type="hidden"
                                                           name="post_id"
                                                           value="${post.post_id}">

                                                    <!-- 通報理由 -->
                                                    <div class="report-input-area">
                                                        <label class="report-label">
                                                            通報理由
                                                        </label>

                                                        <select name="report_reason_id"
                                                                class="report-select"
                                                                id="reasonSelect_${status.index}"
                                                                onchange="validateReportForm(${status.index})"
                                                                required>

                                                            <option value="">
                                                                通報理由を選択してください
                                                            </option>

                                                            <c:forEach var="reason"
                                                                       items="${reportReasons}">
                                                                <option value="${reason.report_reason_id}">
                                                                    <c:out value="${reason.report_reason_name}" />
                                                                </option>
                                                            </c:forEach>
                                                        </select>
                                                    </div>

                                                    <!-- 通報内容 -->
                                                    <div class="report-input-area">
                                                        <label class="report-label">
                                                            通報内容
                                                        </label>

                                                        <textarea name="content"
                                                                  class="report-textarea"
                                                                  id="contentTextarea_${status.index}"
                                                                  oninput="validateReportForm(${status.index})"
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
                                </article>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </c:param>
</c:import>

<script>
    // 返信入力バリデーション
    function validateReplyInput() {
        const textarea =
            document.getElementById("replyContentArea");

        const submitBtn =
            document.getElementById("replySubmitBtn");

        submitBtn.disabled = textarea.value.trim() === "";
    }

    // 返信一覧の開閉
    function toggleReplyList() {
        const replyList =
            document.getElementById("replyListArea");

        const toggleButton =
            document.getElementById("replyToggleButton");

        const isOpen =
            replyList.classList.contains("show");

        if (isOpen) {
            replyList.classList.remove("show");
            toggleButton.classList.remove("open");
            toggleButton.setAttribute("aria-expanded", "false");
        } else {
            replyList.classList.add("show");
            toggleButton.classList.add("open");
            toggleButton.setAttribute("aria-expanded", "true");
        }
    }

    // 通報フォーム開閉
    function toggleReplyReportForm(index) {
        const form =
            document.getElementById("reportFormArea_" + index);

        const button =
            document.getElementById("reportOpenButton_" + index);

        if (form.classList.contains("show")) {
            form.classList.remove("show");
            button.textContent = "⚑ 通報する";
        } else {
            form.classList.add("show");
            button.textContent = "通報フォームを閉じる";
            validateReportForm(index);
        }
    }

    // 通報フォーム入力バリデーション
    function validateReportForm(index) {
        const reasonSelect =
            document.getElementById("reasonSelect_" + index);

        const contentTextarea =
            document.getElementById("contentTextarea_" + index);

        const submitBtn =
            document.getElementById("submitBtn_" + index);

        if (reasonSelect.value === "" ||
            contentTextarea.value.trim() === "") {

            submitBtn.disabled = true;

        } else {

            submitBtn.disabled = false;

        }
    }
</script>