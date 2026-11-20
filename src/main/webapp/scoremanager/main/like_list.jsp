<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
 
<c:import url="/common/base.jsp">
    <c:param name="title" value="お気に入りパパ一覧" />
    <c:param name="content">
 
        <style>
            /* 全体レイアウト */
            .matching-layout {
                display: flex;
                gap: 24px;
                align-items: flex-start;
                width: 100%;
                min-height: 70vh;
                box-sizing: border-box;
            }
 
            /* タイトル */
            .matching-title {
                font-size: 26px;
                font-weight: bold;
                margin-bottom: 16px;
                padding-bottom: 16px;
                border-bottom: 3px solid #ed9145;
                color: #173b60;
            }
 
            /* サイドバー */
            .matching-sidebar {
                flex: 0 0 240px;
                background: #fff;
                border-radius: 14px;
                box-shadow: 0 4px 16px rgba(31, 55, 85, .08);
                padding: 12px;
                box-sizing: border-box;
            }
 
            /* メインコンテンツ */
            .matching-main {
                flex: 1;
                min-width: 0;
                padding: 28px;
                background: #fff;
                border-radius: 14px;
                box-shadow: 0 4px 16px rgba(31, 55, 85, .08);
                box-sizing: border-box;
            }
 
            .matching-description {
                color: #66788a;
                margin-bottom: 25px;
            }
 
            /* 4つの機能ボタン */
            .matching-menu {
                display: flex;
                flex-direction: row;
                justify-content: center;
                align-items: center;
                gap: 10px;
                margin-bottom: 24px;
                padding: 12px 0;
                background: #f1f5f9;
                border-radius: 10px;
            }
 
            .matching-menu form {
                flex: 0 1 180px;
                min-width: 0;
                margin: 0;
            }
 
            .matching-menu button {
                display: flex;
                align-items: center;
                justify-content: center;
                width: 100%;
                box-sizing: border-box;
                padding: 12px 10px;
                background: #24476b;
                border: 1px solid #24476b;
                border-radius: 8px;
                color: #fff;
                font-size: 13px;
                font-weight: 600;
                text-align: center;
                cursor: pointer;
                transition: background .2s;
            }
 
            .matching-menu button:hover {
                background: #193653;
            }
 
            /* お気に入りユーザー一覧 */
            .user-list {
                display: grid;
                grid-template-columns: repeat(2, minmax(0, 1fr));
                gap: 20px;
            }
 
            /* ユーザーカード */
            .user-card {
                padding: 22px;
                border: 1px solid #dce5ee;
                border-radius: 12px;
                background: #fff;
                box-sizing: border-box;
            }
 
            /* プロフィール写真 */
            .user-photo {
                width: 100%;
                height: 180px;
                display: flex;
                align-items: center;
                justify-content: center;
                background: #f1f5f9;
                border-radius: 10px;
                margin-bottom: 16px;
                color: #718096;
                overflow: hidden;
            }
 
            .user-photo img {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }
 
            /* プロフィール情報 */
            .user-info {
                display: block;
                margin-bottom: 12px;
                color: #2d3748;
                font-size: 14px;
                overflow-wrap: anywhere;
            }
 
            .user-info strong {
                color: #24476b;
            }
 
            /* お気に入り解除ボタン */
            .delete-form {
                margin-top: 16px;
            }
 
            .delete-button {
                width: 100%;
                margin-top: 10px;
                padding: 9px 12px;
                background: #fff;
                border: 1px solid #dc6b6b;
                border-radius: 8px;
                color: #c0392b;
                font-size: 13px;
                font-weight: 600;
                font-family: inherit;
                cursor: pointer;
                transition: background .2s;
            }
 
            .delete-button:hover {
                background: #fff1f1;
            }
 
            /* お気に入りがない場合 */
            .empty-message {
                grid-column: 1 / -1;
                color: #777;
                padding: 20px 0;
                text-align: center;
            }
 
            /* レスポンシブ対応 */
            @media (max-width: 768px) {
                .matching-layout {
                    flex-direction: column;
                }
 
                .matching-sidebar {
                    width: 100%;
                    min-width: 0;
                    flex-basis: auto;
                }
 
                .matching-main {
                    width: 100%;
                    padding: 20px;
                }
 
                .matching-menu {
                    flex-wrap: wrap;
                }
 
                .matching-menu form {
                    flex: 1 1 40%;
                }
 
                .user-list {
                    grid-template-columns: 1fr;
                }
            }
 
            @media (max-width: 480px) {
                .matching-menu form {
                    flex: 1 1 100%;
                }
 
                .matching-menu button {
                    padding: 10px;
                    font-size: 12px;
                }
 
                .matching-title {
                    font-size: 22px;
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
 
                <!-- ページタイトル -->
                <h1 class="matching-title">
                    お気に入りパパ一覧
                </h1>
 
                <p class="matching-description">
                    お気に入りに登録したパパを確認できます。
                </p>
 
                <!-- 4つの機能ボタン -->
                <div class="matching-menu">
 
                    <form
                        action="/papatalk/scoremanager/main/Genru.action"
                        method="get">
                        <button type="submit">
                            マッチング設定
                        </button>
                    </form>
 
                    <form
                        action="/papatalk/scoremanager/main/RetrieveFavorites.action"
                        method="get">
                        <button type="submit">
                            お気に入りパパ一覧
                        </button>
                    </form>
 
                    <form
                        action="/papatalk/scoremanager/main/GetFavoriteNotifications.action"
                        method="get">
                        <button type="submit">
                            お気に入り通知確認
                        </button>
                    </form>
 
                    <form
                        action="/papatalk/scoremanager/main/MatchingList.action"
                        method="get">
                        <button type="submit">
                            マッチング中一覧
                        </button>
                    </form>
 
                </div>
 
                <!-- お気に入り一覧 -->
                <div class="user-list">
 
                    <c:choose>
 
                        <c:when test="${not empty favoriteList}">
 
                            <c:forEach var="user" items="${favoriteList}">
 
                                <div class="user-card">
 
                                    <!-- プロフィール写真 -->
                                    <div class="user-photo">
 
                                        <c:choose>
 
                                            <c:when test="${not empty user.avatar_url}">
                                                <img
                                                    src="${pageContext.request.contextPath}${user.avatar_url}"
                                                    alt="プロフィール画像">
                                            </c:when>
 
                                            <c:otherwise>
                                                写真なし
                                            </c:otherwise>
 
                                        </c:choose>
 
                                    </div>
 
                                    <!-- ニックネーム -->
                                    <span class="user-info">
                                        <strong>ニックネーム：</strong>
                                        <c:out value="${user.nickname}" />
                                    </span>
 
                                    <!-- 年齢 -->
                                    <span class="user-info">
                                        <strong>年齢：</strong>
                                        <c:out value="${user.user_age}" />歳
                                    </span>
 
                                    <!-- 都道府県 -->
                                    <span class="user-info">
                                        <strong>都道府県：</strong>
                                        <c:out value="${user.prefecture}" />
                                    </span>
 
                                    <!-- コメント -->
                                    <span class="user-info">
                                        <strong>コメント：</strong>
                                        <c:out value="${user.comment}" />
                                    </span>
 
                                    <!-- お気に入り解除 -->
                                    <form class="delete-form"
                                        action="/papatalk/scoremanager/main/DeleteFavorites.action"
                                        method="post"
                                        onsubmit="return confirm('このパパをお気に入りから解除しますか？');">
 
                                        <input
                                            type="hidden"
                                            name="user_id"
                                            value="${user.user_id}">
 
                                        <button
                                            type="submit"
                                            class="delete-button">
                                            お気に入り解除
                                        </button>
 
                                    </form>
 
                                </div>
 
                            </c:forEach>
 
                        </c:when>
 
                        <c:otherwise>
 
                            <p class="empty-message">
                                お気に入りに登録したパパはいません。
                            </p>
 
                        </c:otherwise>
 
                    </c:choose>
 
                </div>
 
            </main>
 
        </div>
 
    </c:param>
</c:import>