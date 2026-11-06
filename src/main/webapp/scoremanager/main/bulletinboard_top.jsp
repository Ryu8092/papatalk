<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
 
<c:import url="/common/base.jsp">
    <c:param name="title">掲示板｜パパトークシステム</c:param>
    <c:param name="scripts"></c:param>
 
    <c:param name="content">
 
        <style>
            /* 全体レイアウト */
            .bulletin-layout {
                display: flex;
                gap: 24px;
                align-items: flex-start;
                min-height: 70vh;
                width: 100%;
            }
 
            /* サイドバー */
            .bulletin-sidebar {
                flex: 0 0 240px;
                background: #fff;
                border-radius: 14px;
                box-shadow: 0 3px 12px rgba(31,55,85,.08);
                padding: 20px;
                box-sizing: border-box;
            }
 
            /* メイン画面 */
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
 
            /* 見出し */
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
 
            /* ボタン */
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
 
            /* 投稿一覧 */
            .post-list {
                display: flex;
                flex-direction: column;
                gap: 18px;
                width: 100%;
            }
 
            /* 投稿カード */
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
 
            /* 投稿詳細画面へのリンク */
            .post-open-link {
                display: block;
                color: inherit;
                text-decoration: none;
                cursor: pointer;
            }
 
            .post-open-link:hover .post-title {
                color: #ed9145;
            }
 
            /* 投稿タイトル */
            .post-title {
                color: #24476b;
                font-size: 21px;
                font-weight: 700;
                margin: 0 0 16px;
                padding-bottom: 12px;
                border-bottom: 1px solid #edf0f4;
                text-align: left;
                overflow-wrap: anywhere;
                transition: .2s;
            }
 
            /* 投稿内容 */
            .post-content {
                color: #334155;
                font-size: 15px;
                line-height: 1.9;
                white-space: pre-wrap;
                overflow-wrap: anywhere;
                word-break: break-word;
                text-align: left;
                margin: 0 0 22px;
                min-height: 30px;
            }
 
            /* 投稿者・日時 */
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
                text-align: left;
            }
 
            .post-user {
                font-weight: 600;
            }
 
            /* 返信画面への案内 */
            .reply-guide {
                color: #ed9145;
                font-size: 12px;
                text-align: right;
                margin-top: 10px;
            }
 
            /* 通報ボタン */
            .report-area {
                margin-top: 14px;
                text-align: right;
            }
 
            .report-button {
                padding: 7px 17px;
                background: #e85b5b;
                color: #fff;
                border: none;
                border-radius: 7px;
                cursor: pointer;
                font-size: 13px;
                font-weight: bold;
                transition: .2s;
            }
 
            .report-button:hover {
                background: #c94444;
            }
 
            /* 投稿がない場合 */
            .empty-message {
                padding: 45px 20px;
                text-align: center;
                color: #718096;
                background: #f7f9fc;
                border: 1px dashed #ccd5df;
                border-radius: 10px;
                font-size: 15px;
            }
 
            /* エラーメッセージ */
            .error-message {
                color: #d93025;
                background: #fff0f0;
                padding: 13px 16px;
                border-radius: 8px;
                margin-bottom: 20px;
                font-size: 14px;
            }
 
            /* スマホ表示 */
            @media(max-width: 768px) {
                .bulletin-layout {
                    flex-direction: column;
                }
 
                .bulletin-sidebar {
                    width: 100%;
                    flex-basis: auto;
                }
 
                .bulletin-main {
                    width: 100%;
                    padding: 20px;
                }
 
                .post-card {
                    padding: 18px;
                }
 
                .post-info {
                    flex-direction: column;
                    align-items: flex-start;
                }
 
                .report-area {
                    text-align: left;
                }
            }
        </style>
 
 
        <div class="bulletin-layout">
 
            <%-- サイドバー --%>
            <aside class="bulletin-sidebar">
                <jsp:include page="/common/sidebar.jsp" />
            </aside>
 
 
            <%-- メイン画面 --%>
            <main class="bulletin-main">
 
                <h2 class="bulletin-title">
                    掲示板
                </h2>
 
                <p class="bulletin-description">
                    みんなの投稿を確認してみましょう！
                </p>
 
 
                <%-- ボタン --%>
                <div class="bulletin-buttons">
 
                    <%-- 新規投稿画面へ --%>
                    <a
                        class="bulletin-button"
                        href="${pageContext.request.contextPath}/scoremanager/main/NewRegistration.action">
                        ＋ 投稿する
                    </a>
 
                    <%-- 投稿履歴Actionへ --%>
                    <a
                        class="bulletin-button"
                        href="${pageContext.request.contextPath}/scoremanager/main/GetPostHistory.action">
                        投稿履歴
                    </a>
 
                </div>
 
 
                <%-- エラーメッセージ --%>
                <c:if test="${not empty errorMessage}">
                    <div class="error-message">
                        <c:out value="${errorMessage}" />
                    </div>
                </c:if>
 
 
                <%-- 投稿一覧 --%>
                <div class="post-list">
 
                    <c:choose>
 
                        <%-- 投稿がない場合 --%>
                        <c:when test="${empty postList}">
 
                            <div class="empty-message">
                                まだ投稿はありません。<br>
                                最初の投稿をしてみましょう！
                            </div>
 
                        </c:when>
 
 
                        <%-- 投稿がある場合 --%>
                        <c:otherwise>
 
                            <c:forEach var="post" items="${postList}">
 
                                <article class="post-card">
 
                                    <%-- 投稿をクリックすると返信画面へ移動 --%>
                                    <a
                                        class="post-open-link"
                                        href="${pageContext.request.contextPath}/scoremanager/main/RetrieveReplies.action?post_id=${post.post_id}">
 
                                        <%-- 投稿タイトル --%>
                                        <h3 class="post-title">
                                            <c:out value="${post.post_title}" />
                                        </h3>
 
                                        <%-- 投稿内容 --%>
                                        <div class="post-content">
                                            <c:out value="${post.post_content}" />
                                        </div>
 
                                        <%-- 投稿者・投稿日時 --%>
                                        <div class="post-info">
 
                                            <span class="post-user">
                                                投稿者：
                                                <c:out value="${post.user_name}" />
                                            </span>
 
                                            <span>
                                                投稿日：
                                                <c:out value="${post.post_date}" />
                                            </span>
 
                                        </div>
 
                                        <%-- クリックできることを表示 --%>
                                        <div class="reply-guide">
                                            この投稿に返信する ＞
                                        </div>
 
                                    </a>
 
 
                                    <%-- 通報ボタン --%>
                                    <div class="report-area">
 
                                        <form
                                            method="post"
                                            action="${pageContext.request.contextPath}/scoremanager/main/ReportPost.action">
 
                                            <input
                                                type="hidden"
                                                name="post_id"
                                                value="${post.post_id}">
 
                                            <button
                                                type="submit"
                                                class="report-button">
                                                通報
                                            </button>
 
                                        </form>
 
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