
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

            /* 上部タイトル */
            .history-header {
                display: block;
                min-height: auto;
                margin-bottom: 15px;
            }

            /* メインタイトル：掲示板と同じデザイン */
            .history-title {
                color: #24476b;
                font-size: 27px;
                font-weight: 700;
                padding-bottom: 15px;
                border-bottom: 3px solid #ed9145;
                margin: 0 0 15px;
                text-align: left;
            }

            /* 投稿一覧 */
            .history-list {
                display: flex;
                flex-direction: column;
                gap: 18px;
                width: 100%;
            }

            /* 投稿カード全体のリンク */
            .history-card-link {
                display: block;
                width: 100%;
                color: inherit;
                text-decoration: none;
                cursor: pointer;
            }

            /* 投稿カード */
            .history-card {
                width: 100%;
                box-sizing: border-box;
                background: #ffffff;
                border: 1px solid #e2e8f0;
                border-radius: 12px;
                padding: 22px 25px;
                text-align: left;
                transition: box-shadow 0.2s, border-color 0.2s;
            }

            /* マウスを乗せたとき */
            .history-card-link:hover .history-card {
                border-color: #ed9145;
                box-shadow: 0 4px 14px rgba(31, 55, 85, 0.12);
                background: #fffaf5;
            }

            /* キーボード操作時 */
            .history-card-link:focus-visible {
                outline: 3px solid #ed9145;
                outline-offset: 4px;
                border-radius: 12px;
            }

            /* 投稿タイトル */
            .history-post-title {
                color: #24476b;
                font-size: 21px;
                font-weight: 700;
                margin: 0 0 16px;
                padding-bottom: 12px;
                border-bottom: 1px solid #edf0f4;
                text-align: left;
                overflow-wrap: anywhere;
            }

            /* 投稿本文 */
            .history-post-content {
                color: #334155;
                font-size: 15px;
                line-height: 1.9;
                white-space: pre-wrap;
                overflow-wrap: anywhere;
                word-break: break-word;
                margin: 0 0 22px;
                min-height: 30px;
            }

            /* 投稿情報 */
            .history-post-info {
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

            /* 投稿者 */
            .history-post-user {
                font-weight: 600;
            }

            /* 投稿がない場合 */
            .history-empty {
                width: 100%;
                padding: 40px 20px;
                border: 1px dashed #cbd5e1;
                border-radius: 8px;
                background: #f7f9fc;
                color: #718096;
                text-align: center;
                box-sizing: border-box;
            }

            /* 下部ボタンエリア */
            .history-footer {
                display: flex;
                justify-content: center;
                margin-top: 35px;
                padding-top: 20px;
                border-top: 1px solid #edf0f4;
            }

            /* 戻るボタン */
            .back-button {
                display: inline-block;
                padding: 10px 35px;
                color: #24476b;
                background: #ffffff;
                border: 1px solid #24476b;
                border-radius: 7px;
                text-decoration: none;
                font-size: 14px;
                font-weight: bold;
                transition: 0.2s;
            }

            .back-button:hover {
                background: #f1f5f9;
                color: #183653;
                border-color: #183653;
            }

            /* スマホ表示 */
            @media (max-width: 768px) {

                .history-container {
                    width: 95%;
                    padding: 20px 15px;
                }

                .history-title {
                    font-size: 23px;
                }

                .history-card {
                    padding: 18px;
                }

                .history-post-title {
                    font-size: 18px;
                }

                .back-button {
                    width: 100%;
                    max-width: 250px;
                    text-align: center;
                    box-sizing: border-box;
                }
            }
        </style>

        <div class="history-container">

            <%-- 上部タイトル --%>
            <div class="history-header">
                <h2 class="history-title">投稿履歴</h2>
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

                            <%-- 投稿カード全体をクリック可能にする --%>
                            <a class="history-card-link"
                               href="/papatalk/scoremanager/main/RetrieveReplies.action?post_id=${post.post_id}">

                                <article class="history-card">

                                    <%-- 投稿タイトル --%>
                                    <h3 class="history-post-title">
                                        <c:out value="${post.post_title}" />
                                    </h3>

                                    <%-- 投稿本文 --%>
                                    <div class="history-post-content">
                                        <c:out value="${post.post_content}" />
                                    </div>

                                    <%-- 投稿者・投稿日 --%>
                                    <div class="history-post-info">

                                        <c:if test="${not empty post.user_name}">
                                            <span class="history-post-user">
                                                投稿者：
                                                <c:out value="${post.user_name}" />
                                            </span>
                                        </c:if>

                                        <span>
                                            投稿日：
                                            <c:if test="${not empty post.post_date}">
                                                <fmt:formatDate
												    value="${post.post_date}"
												    pattern="yyyy年MM月dd日 HH時mm分" />
                                            </c:if>
                                        </span>

                                    </div>

                                </article>
                            </a>

                        </c:forEach>

                    </c:otherwise>

                </c:choose>

            </div>

            <%-- 一番下の戻るボタン --%>
            <div class="history-footer">

                <a href="/papatalk/scoremanager/main/RetrievePosts.action"
                   class="back-button">
                    ← 戻る
                </a>

            </div>

        </div>

    </c:param>
</c:import>
