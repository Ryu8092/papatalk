<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
 
<c:import url="/common/base.jsp">
    <c:param name="title">投稿履歴｜パパトークシステム</c:param>
    <c:param name="scripts"></c:param>
 
    <c:param name="content">
 
        <style>
 
            /* 投稿履歴画面全体 */
            .history-container {
                width: 90%;
                max-width: 1000px;
                margin: 40px auto;
                padding: 30px;
                background: #ffffff;
                border: 1px solid #e2e8f0;
                border-radius: 14px;
                box-shadow: 0 3px 12px rgba(31, 55, 85, 0.08);
                box-sizing: border-box;
            }
 
            /* 上部ボタンとタイトル */
            .history-header {
                position: relative;
                display: flex;
                align-items: center;
                justify-content: center;
                min-height: 45px;
                margin-bottom: 35px;
            }
 
            /* 戻るボタン */
            .back-button {
                position: absolute;
                left: 0;
                top: 0;
                display: inline-block;
                padding: 9px 22px;
                color: #ffffff;
                background: #24476b;
                text-decoration: none;
                border-radius: 7px;
                font-size: 14px;
                font-weight: bold;
                transition: 0.2s;
            }
 
            .back-button:hover {
                background: #183653;
            }
 
            /* 画面タイトル */
            .history-title {
                margin: 0;
                color: #24476b;
                font-size: 28px;
                font-weight: bold;
                text-align: center;
            }
 
            /* 投稿一覧 */
            .history-list {
                display: flex;
                flex-direction: column;
                align-items: center;
                gap: 35px;
            }
 
            /* 投稿カード */
            .history-card {
                width: 80%;
                padding: 18px 20px;
                border: 2px solid #333333;
                background: #ffffff;
                box-sizing: border-box;
            }
 
            /* 投稿タイトル */
            .history-post-title {
                margin: 0 0 15px;
                color: #333333;
                font-size: 17px;
                font-weight: bold;
                overflow-wrap: anywhere;
            }
 
            /* 投稿本文 */
            .history-post-content {
                margin: 0 0 20px;
                color: #444444;
                font-size: 15px;
                line-height: 1.8;
                white-space: pre-wrap;
                overflow-wrap: anywhere;
                word-break: break-word;
            }
 
            /* 投稿日 */
            .history-post-date {
                color: #555555;
                font-size: 12px;
                text-align: left;
            }
 
            /* 投稿がない場合 */
            .history-empty {
                width: 80%;
                padding: 40px 20px;
                border: 1px dashed #cbd5e1;
                border-radius: 8px;
                background: #f7f9fc;
                color: #718096;
                text-align: center;
                box-sizing: border-box;
            }
 
            /* スマホ表示 */
            @media (max-width: 768px) {
 
                .history-container {
                    width: 95%;
                    padding: 20px 15px;
                }
 
                .history-header {
                    padding-top: 50px;
                }
 
                .history-title {
                    font-size: 24px;
                }
 
                .history-card {
                    width: 100%;
                }
 
                .history-empty {
                    width: 100%;
                }
 
            }
 
        </style>
 
        <div class="history-container">
 
            <%-- 上部 --%>
            <div class="history-header">
 
                <%-- 掲示板に戻る --%>
                <a
                    href="${pageContext.request.contextPath}/scoremanager/main/RetrievePosts.action"
                    class="back-button">
                    戻る
                </a>
 
                <%-- タイトル --%>
                <h2 class="history-title">
                    投稿履歴
                </h2>
 
            </div>
 
            <%-- 投稿履歴一覧 --%>
            <div class="history-list">
 
                <c:choose>
 
                    <%-- 投稿履歴がない場合 --%>
                    <c:when test="${empty postList}">
 
                        <div class="history-empty">
                            まだ投稿履歴はありません。
                        </div>
 
                    </c:when>
 
                    <%-- 投稿履歴がある場合 --%>
                    <c:otherwise>
 
                        <c:forEach var="post" items="${postList}">
 
                            <div class="history-card">
 
                                <%-- 投稿タイトル --%>
                                <h3 class="history-post-title">
                                    <c:out value="${post.post_title}" />
                                </h3>
 
                                <%-- 投稿本文 --%>
                                <p class="history-post-content"><c:out value="${post.post_content}" /></p>
 
                                <%-- 投稿日 --%>
                                <div class="history-post-date">
 
                                    <c:if test="${not empty post.post_date}">
                                        <fmt:formatDate
                                            value="${post.post_date}"
                                            pattern="yyyy/MM/dd" />
                                    </c:if>
 
                                </div>
 
                            </div>
 
                        </c:forEach>
 
                    </c:otherwise>
 
                </c:choose>
 
            </div>
 
        </div>
 
    </c:param>
</c:import>