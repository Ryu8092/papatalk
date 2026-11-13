
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<c:import url="/common/base.jsp">

    <c:param name="title" value="マッチング中一覧" />

    <c:param name="content">

        <style>
            .matching-layout {
                display: flex;
                gap: 24px;
                align-items: flex-start;
                width: 100%;
                min-height: 70vh;
                box-sizing: border-box;
            }
            .matching-title {
			    font-size: 26px;
			    font-weight: bold;
			    margin-bottom: 16px;
			    padding-bottom: 16px;
			    border-bottom: 3px solid #ed9145;
			    color: #173b60;
			}

            .matching-sidebar {
			    flex: 0 0 240px;
			    background: #fff;
			    border-radius: 14px;
			    box-shadow: 0 4px 16px rgba(31, 55, 85, .08);
			    padding: 20px;
			    box-sizing: border-box;
			}

            .matching-main {
                flex: 1;
                min-width: 0;
                padding: 28px;
                background: #fff;
                border-radius: 14px;
                box-shadow: 0 4px 16px rgba(31,55,85,.08);
                box-sizing: border-box;
            }

            .matching-title {
                font-size: 26px;
                font-weight: bold;
                margin-bottom: 10px;
                color: #173b60;
            }

            .matching-description {
                color: #66788a;
                margin-bottom: 25px;
            }

            /* 上部メニュー */
            .matching-menu {
                display: grid;
                grid-template-columns: repeat(2, minmax(0, 1fr));
                gap: 8px;
                margin-bottom: 24px;
            }

            .matching-menu form {
                margin: 0;
            }

            .matching-menu button {
                width: 100%;
                display: flex;
                align-items: center;
                justify-content: space-between;
                gap: 8px;
                padding: 9px 12px;
                background: #fff;
                border: 1px solid #dce4ee;
                border-radius: 8px;
                color: #24476b;
                font-size: 13px;
                font-weight: 600;
                font-family: inherit;
                cursor: pointer;
                transition: background .2s;
            }

            .matching-menu button:hover {
                background: #f2f5fa;
            }

            .menu-arrow {
                color: #718096;
                flex-shrink: 0;
            }

            /* ユーザーカード一覧 */
            .user-list {
                display: grid;
                grid-template-columns: repeat(2, minmax(0, 1fr));
                gap: 20px;
            }

            /* カード全体を囲むフォーム */
            .user-card-form {
                width: 100%;
                margin: 0;
            }

            /* カードボタン */
            .user-card {
                display: block;
                width: 100%;
                padding: 22px;
                border: 1px solid #dce5ee;
                border-radius: 12px;
                background: #fff;
                color: #2d3748;
                text-align: left;
                font-family: inherit;
                font-size: inherit;
                cursor: pointer;
                box-sizing: border-box;
                transition: transform .2s, box-shadow .2s;
            }

            .user-card:hover {
                transform: translateY(-3px);
                box-shadow: 0 6px 18px rgba(31,55,85,.12);
            }

            .user-card:focus-visible {
                outline: 2px solid #24476b;
                outline-offset: 3px;
            }

            .user-name {
                display: block;
                font-size: 19px;
                font-weight: bold;
                margin-bottom: 10px;
                color: #2d3748;
            }

            .user-prefecture {
                display: block;
                color: #66788a;
                margin-bottom: 18px;
            }

            .user-message-info {
                display: block;
                margin-bottom: 10px;
                color: #2d3748;
                font-size: 14px;
            }

            .user-message-content {
                display: block;
                color: #66788a;
                font-size: 14px;
                overflow-wrap: anywhere;
            }

            .empty-message {
                color: #777;
                padding: 20px 0;
            }

            /* レスポンシブ対応 */
            @media (max-width: 768px) {
                .matching-layout {
                    flex-direction: column;
                }

                .matching-sidebar-wrapper {
                    width: 100%;
                    min-width: 0;
                    flex-basis: auto;
                }

                .matching-main {
                    width: 100%;
                    padding: 20px;
                }

                .user-list {
                    grid-template-columns: 1fr;
                }
            }

            @media (max-width: 480px) {
                .matching-menu button {
                    padding: 8px;
                    font-size: 12px;
                }
            }
        </style>

        <div class="matching-layout">

            <!-- サイドバー -->
			<aside class="matching-sidebar">
			    <jsp:include page="/common/sidebar.jsp" />
			</aside>

            <!-- メインコンテンツ -->
            <main class="matching-main">

                <h1 class="matching-title">マッチング中一覧</h1>
                
                <p class="matching-description">
                    マッチングしたユーザーを確認できます。
                </p>

                <!-- 上部メニュー -->
                <div class="matching-menu">

                    <form action="${pageContext.request.contextPath}/scoremanager/main/Genru.action"
                          method="get">
                        <button type="submit">
                            <span>マッチング設定</span>
                            <span class="menu-arrow">›</span>
                        </button>
                    </form>

                    <form action="${pageContext.request.contextPath}/scoremanager/main/FavoriteList.action"
                          method="get">
                        <button type="submit">
                            <span>お気に入りパパ一覧</span>
                            <span class="menu-arrow">›</span>
                        </button>
                    </form>

                    <form action="${pageContext.request.contextPath}/scoremanager/main/GetFavoriteNotifications.action"
                          method="get">
                        <button type="submit">
                            <span>お気に入り通知確認</span>
                            <span class="menu-arrow">›</span>
                        </button>
                    </form>

                    <form action="${pageContext.request.contextPath}/scoremanager/main/MatchingList.action"
                          method="get">
                        <button type="submit">
                            <span>マッチング中一覧</span>
                            <span class="menu-arrow">›</span>
                        </button>
                    </form>

                </div>



                <!-- マッチングユーザー一覧 -->
                <div class="user-list">

                    <c:forEach var="matching" items="${matchingList}">

                        <form class="user-card-form"
                              action="${pageContext.request.contextPath}/scoremanager/main/MatchingChat.action"
                              method="get">

                            <input type="hidden"
                                   name="match_id"
                                   value="${matching.match_id}">

                            <button type="submit" class="user-card">

                                <!-- 相手の名前 -->
                                <span class="user-name">
                                    <c:out value="${matching.user_name}" />さん
                                </span>

                                <!-- 最新メッセージの送信日時 -->
                                <span class="user-message-info">

                                    <strong>送信日時：</strong>

                                    <c:choose>
                                        <c:when test="${not empty matching.latestCreateAt}">
                                            <fmt:formatDate
                                                value="${matching.latestCreateAt}"
                                                pattern="yyyy/MM/dd HH:mm"
                                            />
                                        </c:when>

                                        <c:otherwise>
                                            まだメッセージはありません
                                        </c:otherwise>
                                    </c:choose>

                                </span>

                                <!-- 最新メッセージ -->
                                <span class="user-message-content">

                                    <strong>最新のメッセージ：</strong>

                                    <c:choose>
                                        <c:when test="${not empty matching.latestContent}">
                                            <c:out value="${matching.latestContent}" />
                                        </c:when>

                                        <c:otherwise>
                                            まだメッセージはありません
                                        </c:otherwise>
                                    </c:choose>

                                </span>

                            </button>

                        </form>

                    </c:forEach>

                </div>

                <!-- マッチング相手がいない場合 -->
                <c:if test="${empty matchingList}">
                    <p class="empty-message">
                        まだマッチングしているユーザーはいません。
                    </p>
                </c:if>

            </main>

        </div>

    </c:param>

</c:import>
