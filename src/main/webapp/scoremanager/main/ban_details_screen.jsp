<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
 
<c:import url="/common/base.jsp">
    <c:param name="title">パパトークシステム｜BANユーザー詳細</c:param>
 
    <c:param name="scripts">
        <style>
            .detail-page {
                max-width: 850px;
                margin: 30px auto;
                padding: 20px;
            }
 
            .detail-container {
                background: #fff;
                border-radius: 12px;
                padding: 30px;
                box-shadow: 0 3px 12px rgba(0, 0, 0, 0.08);
            }
 
            .back-button {
                display: inline-block;
                margin-bottom: 20px;
            }
 
            .back-button button {
                background: #e8edf2;
                color: #24476b;
                border: none;
                padding: 9px 18px;
                border-radius: 6px;
                cursor: pointer;
                font-weight: bold;
            }
 
            .detail-title {
                color: #24476b;
                font-size: 24px;
                font-weight: bold;
                margin-bottom: 25px;
                padding-bottom: 15px;
                border-bottom: 2px solid #ed9145;
            }
 
            .status-area {
                margin-bottom: 25px;
                padding: 15px;
                background: #fff1f0;
                border-radius: 8px;
                color: #c0392b;
                font-weight: bold;
            }
 
            .detail-list {
                display: flex;
                flex-direction: column;
                gap: 0;
            }
 
            .detail-row {
                display: flex;
                padding: 15px 10px;
                border-bottom: 1px solid #e5e5e5;
            }
 
            .detail-label {
                width: 180px;
                flex-shrink: 0;
                color: #555;
                font-weight: bold;
            }
 
            .detail-value {
                color: #333;
                overflow-wrap: anywhere;
            }
 
            .action-area {
                display: flex;
                justify-content: center;
                margin-top: 35px;
            }
 
            .release-button {
                background: #ed9145;
                color: #fff;
                border: none;
                padding: 13px 35px;
                border-radius: 7px;
                font-size: 16px;
                font-weight: bold;
                cursor: pointer;
            }
 
            .release-button:hover {
                background: #d97c30;
            }
 
            .message {
                padding: 12px;
                margin-bottom: 20px;
                border-radius: 6px;
            }
 
            .success-message {
                background: #e8f5e9;
                color: #2e7d32;
            }
 
            .error-message {
                background: #ffebee;
                color: #c62828;
            }
 
            @media (max-width: 600px) {
                .detail-page {
                    padding: 10px;
                }
 
                .detail-container {
                    padding: 20px 15px;
                }
 
                .detail-row {
                    flex-direction: column;
                    gap: 6px;
                }
 
                .detail-label {
                    width: 100%;
                }
            }
        </style>
    </c:param>
 
    <c:param name="content">
        <div class="detail-page">
            <div class="detail-container">
 
                <!-- 戻るボタン -->
                <form action="${pageContext.request.contextPath}/scoremanager/main/BanHistory.action"
                      method="post"
                      class="back-button">
                    <button type="submit">戻る</button>
                </form>
 
                <h2 class="detail-title">BANユーザー詳細</h2>
 
                <!-- メッセージ表示 -->
                <c:if test="${not empty successMessage}">
                    <div class="message success-message">
                        <c:out value="${successMessage}" />
                    </div>
                </c:if>
 
                <c:if test="${not empty errorMessage}">
                    <div class="message error-message">
                        <c:out value="${errorMessage}" />
                    </div>
                </c:if>
 
                <c:choose>
                    <c:when test="${not empty target_user}">
 
                        <div class="status-area">
                            現在、このユーザーはアカウント停止中です。
                        </div>
 
                        <!-- ユーザー情報 -->
                        <div class="detail-list">
 
                            <div class="detail-row">
                                <div class="detail-label">ユーザーID</div>
                                <div class="detail-value">
                                    <c:out value="${target_user.user_id}" />
                                </div>
                            </div>
 
                            <div class="detail-row">
                                <div class="detail-label">ユーザー名</div>
                                <div class="detail-value">
                                    <c:out value="${target_user.user_name}" />
                                </div>
                            </div>
 
 
                        </div>
 
                        <!-- BAN解除 -->
                        <div class="action-area">
                            <form action="${pageContext.request.contextPath}/scoremanager/main/Update.action"
                                  method="post"
                                  onsubmit="return confirm('このユーザーのBANを解除しますか？');">
 
                                <input type="hidden"
                                       name="user_id"
                                       value="${target_user.user_id}">
 
                                <button type="submit" class="release-button">
                                    BANを解除する
                                </button>
                            </form>
                        </div>
 
                    </c:when>
 
                    <c:otherwise>
                        <p>ユーザー情報を取得できませんでした。</p>
                    </c:otherwise>
                </c:choose>
 
            </div>
        </div>
    </c:param>
</c:import>