<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
 
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
            }
            .reply-title {
                color: #24476b;
                font-size: 27px;
                font-weight: 700;
                padding-bottom: 15px;
                border-bottom: 3px solid #ed9145;
                margin-bottom: 25px;
            }
            .original-post-card {
                background: #f8fafc;
                border: 1px solid #cbd5e1;
                border-radius: 12px;
                padding: 22px 25px;
                margin-bottom: 30px;
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
                margin-bottom: 15px;
            }
            .reply-form-section {
                background: #fff;
                border: 1px solid #e2e8f0;
                border-radius: 12px;
                padding: 22px 25px;
                margin-bottom: 30px;
                box-shadow: 0 2px 8px rgba(31,55,85,.05);
            }
            .form-group {
                margin-bottom: 15px;
            }
            .reply-textarea {
                width: 100%;
                box-sizing: border-box;
                padding: 12px;
                border: 1px solid #cbd5e1;
                border-radius: 6px;
                background: #fff;
                color: #344b63;
                font-size: 15px;
                min-height: 100px;
                resize: vertical;
                line-height: 1.7;
            }
            .btn-submit {
                display: inline-block;
                padding: 10px 24px;
                background: #ed9145;
                color: #fff;
                border: none;
                border-radius: 6px;
                font-weight: bold;
                font-size: 15px;
                cursor: pointer;
                transition: .2s;
            }
            .btn-submit:hover:not(:disabled) {
                background: #d97c30;
            }
            .btn-submit:disabled {
                background: #cbd5e1;
                cursor: not-allowed;
            }
            .reply-list {
                display: flex;
                flex-direction: column;
                gap: 20px;
            }
            .reply-card {
                background: #fff;
                border: 1px solid #e2e8f0;
                border-radius: 12px;
                padding: 22px 25px;
                box-shadow: 0 2px 8px rgba(31,55,85,.05);
            }
            .reply-info {
                display: flex;
                justify-content: space-between;
                color: #718096;
                font-size: 13px;
                margin-bottom: 12px;
                border-bottom: 1px solid #edf0f4;
                padding-bottom: 8px;
            }
            .reply-content {
                color: #334155;
                font-size: 15px;
                line-height: 1.8;
                white-space: pre-wrap;
                margin-bottom: 15px;
            }
            .bottom-buttons {
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
            }
            .report-form-area {
                display: none;
                width: 100%;
                margin-top: 15px;
                background: #fff;
                padding: 15px;
                border: 1px solid #cbd5e1;
                border-radius: 6px;
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
            .error-message {
                color: #d93025;
                background: #fff0f0;
                padding: 13px 16px;
                border-radius: 8px;
                margin-bottom: 20px;
                font-size: 14px;
            }
            .back-link {
                display: inline-block;
                margin-bottom: 20px;
                color: #24476b;
                text-decoration: none;
                font-weight: bold;
            }
            .back-link:hover {
                text-decoration: underline;
            }
        </style>
 
        <div class="reply-layout">
 
            <a class="back-link" href="${pageContext.request.contextPath}/scoremanager/main/RetrievePosts.action">
                ＜ 掲示板トップへ戻る
            </a>
 
            <h2 class="reply-title">返信一覧</h2>
 
            <c:if test="${not empty errorMessage}">
                <div class="error-message">
                    <c:out value="${errorMessage}" />
                </div>
            </c:if>
 
            <c:if test="${not empty reportMessage}">
                <div class="error-message" style="color: #24476b; background: #fff4e8; border: 1px solid #ed9145;">
                    <c:out value="${reportMessage}" />
                </div>
            </c:if>
 
            <!-- 元投稿表示エリア -->
            <c:if test="${not empty post}">
                <div class="original-post-card">
                    <h3 class="original-post-title"><c:out value="${post.post_title}" /></h3>
                    <div class="original-post-content"><c:out value="${post.post_content}" /></div>
                    <div class="reply-info">
                        <span>投稿者：<c:out value="${post.user_name}" /></span>
                        <span>投稿日：<c:out value="${post.post_date}" /></span>
                    </div>
                </div>
            </c:if>
 
            <!-- 返信入力フォーム -->
            <div class="reply-form-section">
                <form action="<c:url value='/scoremanager/main/RegisterReply.action' />" method="post">
                    <input type="hidden" name="post_id" value="${post.post_id}">
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
                </form>
            </div>
 
            <!-- 返信一覧表示エリア -->
            <div class="reply-list">
                <c:choose>
                    <c:when test="${empty replyList}">
                        <div style="color: #718096; text-align: center; padding: 30px;">
                            まだ返信はありません。
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="reply" items="${replyList}" varStatus="status">
                            <article class="reply-card">
                                <div class="reply-info">
                                    <span>名前：<c:out value="${reply.user_name}" /></span>
                                    <span>返信日：<c:out value="${reply.reply_date}" /></span>
                                </div>
                                <div class="reply-content">
                                    <c:out value="${reply.reply_content}" />
                                </div>
 
                                <!-- 返信に対する通報ボタンと動的フォーム -->
                                <div class="bottom-buttons">
                                    <div class="report-form">
                                        <button type="button"
                                                class="report-open-button"
                                                id="reportOpenButton_${status.index}"
                                                onclick="toggleReplyReportForm(${status.index})">
                                            ⚑ 通報する
                                        </button>
 
                                        <div class="report-form-area" id="reportFormArea_${status.index}">
                                            <form action="<c:url value='/scoremanager/main/ChatReportRegistration.action' />"
                                                  method="post"
                                                  id="reportFormElement_${status.index}">
 
                                                <h3 class="report-title">⚑ この返信を通報する</h3>
 
                                                <input type="hidden" name="reply_id" value="${reply.reply_id}">
                                                <input type="hidden" name="post_id" value="${post.post_id}">
 
                                                <!-- DBから取得した通報理由プルダウン -->
                                                <div class="report-input-area">
                                                    <label class="report-label">通報理由</label>
                                                    <select name="report_reason_id"
                                                            class="report-select"
                                                            id="reasonSelect_${status.index}"
                                                            onchange="validateReportForm(${status.index})"
                                                            required>
                                                        <option value="">通報理由を選択してください</option>
                                                        <c:forEach var="reason" items="${reportReasons}">
                                                            <option value="${reason.report_reason_id}">
                                                                <c:out value="${reason.report_reason_name}" />
                                                            </option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
 
                                                <div class="report-input-area">
                                                    <label class="report-label">通報内容</label>
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
 
    </c:param>
</c:import>
 
<script>
    // 返信入力バリデーション（空欄時は送信無効化）
    function validateReplyInput() {
        const textarea = document.getElementById("replyContentArea");
        const submitBtn = document.getElementById("replySubmitBtn");
 
        if (textarea.value.trim() === "") {
            submitBtn.disabled = true;
        } else {
            submitBtn.disabled = false;
        }
    }
 
    // 通報フォーム開閉処理
    function toggleReplyReportForm(index) {
        const form = document.getElementById("reportFormArea_" + index);
        const button = document.getElementById("reportOpenButton_" + index);
 
        if (form.classList.contains("show")) {
            form.classList.remove("show");
            button.textContent = "⚑ 通報する";
        } else {
            form.classList.add("show");
            button.textContent = "通報フォームを閉じる";
            validateReportForm(index);
        }
    }
 
    // 通報フォーム入力バリデーション（理由未選択または内容空欄時は送信無効化）
    function validateReportForm(index) {
        const reasonSelect = document.getElementById("reasonSelect_" + index);
        const contentTextarea = document.getElementById("contentTextarea_" + index);
        const submitBtn = document.getElementById("submitBtn_" + index);
 
        if (reasonSelect.value === "" || contentTextarea.value.trim() === "") {
            submitBtn.disabled = true;
        } else {
            submitBtn.disabled = false;
        }
    }
</script>