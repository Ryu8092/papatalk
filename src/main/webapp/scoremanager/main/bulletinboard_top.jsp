<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
 
<c:import url="/common/base.jsp">
    <c:param name="title">掲示板｜パパトークシステム</c:param>
    <c:param name="scripts"></c:param>
 
    <c:param name="content">
 
        <style>
            .bulletin-layout {
                display: flex;
                gap: 24px;
                align-items: flex-start;
                min-height: 70vh;
                width: 100%;
            }
            .bulletin-sidebar {
                flex: 0 0 240px;
                background: #fff;
                border-radius: 14px;
                box-shadow: 0 3px 12px rgba(31,55,85,.08);
                padding: 20px;
                box-sizing: border-box;
            }
            .bulletin-main {
                flex: 1;
                min-width: 0;
                padding: 30px;
                background: #fff;
                border-radius: 14px;
                box-shadow: 0 3px 12px rgba(31,55,85,.08);
                box-sizing: border-box;
                text-align: left;
            }
            .bulletin-title {
                color: #24476b;
                font-size: 27px;
                font-weight: 700;
                padding-bottom: 15px;
                border-bottom: 3px solid #ed9145;
                margin: 0 0 15px;
                text-align: left;
            }
            .bulletin-description {
                color: #718096;
                font-size: 15px;
                margin: 0 0 25px;
                text-align: left;
            }
            .bulletin-buttons {
                display: flex;
                gap: 12px;
                margin-bottom: 30px;
                flex-wrap: wrap;
            }
            .bulletin-button {
                display: inline-block;
                padding: 12px 24px;
                background: #ed9145;
                color: #fff;
                text-decoration: none;
                border-radius: 9px;
                font-weight: bold;
                font-size: 15px;
                transition: .2s;
            }
            .bulletin-button:hover {
                background: #d97c30;
                transform: translateY(-2px);
            }
            .post-list {
                display: flex;
                flex-direction: column;
                gap: 18px;
                width: 100%;
            }
            .post-card {
                width: 100%;
                box-sizing: border-box;
                background: #fff;
                border: 1px solid #e2e8f0;
                border-radius: 12px;
                padding: 22px 25px;
                text-align: left;
                transition: box-shadow .2s;
            }
            .post-card:hover {
                box-shadow: 0 4px 14px rgba(31,55,85,.08);
            }
            .post-open-link {
                display: block;
                color: inherit;
                text-decoration: none;
                cursor: pointer;
            }
            .post-open-link:hover .post-title {
                color: #ed9145;
            }
            .post-title {
                color: #24476b;
                font-size: 21px;
                font-weight: 700;
                margin: 0 0 16px;
                padding-bottom: 12px;
                border-bottom: 1px solid #edf0f4;
                text-align: left;
                overflow-wrap: anywhere;
            }
            .post-content {
                color: #334155;
                font-size: 15px;
                line-height: 1.9;
                white-space: pre-wrap;
                overflow-wrap: anywhere;
                word-break: break-word;
                margin: 0 0 22px;
                min-height: 30px;
            }
            .post-info {
                display: flex;
                justify-content: space-between;
                align-items: center;
                flex-wrap: wrap;
                gap: 10px;
                color: #718096;
                font-size: 13px;
                border-top: 1px solid #edf0f4;
                padding-top: 14px;
            }
            .post-user {
                font-weight: 600;
            }
            .reply-guide {
                color: #ed9145;
                font-size: 12px;
                text-align: right;
                margin-top: 10px;
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
        </style>
 
        <div class="bulletin-layout">
            <aside class="bulletin-sidebar">
                <jsp:include page="/common/sidebar.jsp" />
            </aside>
 
            <main class="bulletin-main">
                <h2 class="bulletin-title">掲示板</h2>
                <p class="bulletin-description">みんなの投稿を確認してみましょう！</p>
 
                <div class="bulletin-buttons">
                    <a class="bulletin-button" href="${pageContext.request.contextPath}/scoremanager/main/NewRegistration.action">＋ 投稿する</a>
                    <a class="bulletin-button" href="${pageContext.request.contextPath}/scoremanager/main/GetPostHistory.action">投稿履歴</a>
                </div>
 
                <c:if test="${not empty errorMessage}">
                    <div class="error-message"><c:out value="${errorMessage}" /></div>
                </c:if>
 
                <c:if test="${not empty reportMessage}">
                    <div class="error-message" style="color: #24476b; background: #fff4e8; border: 1px solid #ed9145;">
                        <c:out value="${reportMessage}" />
                    </div>
                </c:if>
 
                <div class="post-list">
                    <c:choose>
                        <c:when test="${empty postList}">
                            <div class="empty-message">まだ投稿はありません。<br>最初の投稿をしてみましょう！</div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="post" items="${postList}" varStatus="status">
                                <article class="post-card">
                                    <a class="post-open-link" href="${pageContext.request.contextPath}/scoremanager/main/RetrieveReplies.action?post_id=${post.post_id}">
                                        <h3 class="post-title"><c:out value="${post.post_title}" /></h3>
                                        <div class="post-content"><c:out value="${post.post_content}" /></div>
                                        <div class="post-info">
                                            <span class="post-user">投稿者：<c:out value="${post.user_name}" /></span>
                                            <span>投稿日：<c:out value="${post.post_date}" /></span>
                                        </div>
                                        <div class="reply-guide">この投稿に返信する ＞</div>
                                    </a>
 
                                    <!-- シーケンス図対応：通報ボタンと開閉フォーム -->
                                    <div class="bottom-buttons">
                                        <div class="report-form">
                                            <button type="button"
                                                    class="report-open-button"
                                                    id="reportOpenButton_${status.index}"
                                                    onclick="togglePostReportForm(${status.index})">
                                                ⚑ 通報する
                                            </button>
 
                                            <div class="report-form-area" id="reportFormArea_${status.index}">
                                                <form action="<c:url value='/scoremanager/main/PostReportRegistration.action' />"
                                                      method="post"
                                                      id="reportFormElement_${status.index}">
 
                                                    <h3 class="report-title">⚑ この投稿を通報する</h3>
 
                                                    <input type="hidden" name="post_id" value="${post.post_id}">
                                                    <input type="hidden" name="report_content_id" value="1">
       
 
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
 
                                                    <!-- シーケンス図のalt条件：選択されていない場合は無効化 -->
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
            </main>
        </div>
    </c:param>
</c:import>
 
<script>
    function togglePostReportForm(index) {
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
 
    // シーケンス図のalt「選択されていない場合：通報ボタンを無効化」を制御する関数
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