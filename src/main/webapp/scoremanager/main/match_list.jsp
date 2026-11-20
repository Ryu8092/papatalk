
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:import url="/common/base.jsp">
    <c:param name="title">パパトークシステム｜マッチング</c:param>
    <c:param name="scripts"></c:param>

    <c:param name="content">

<style>

/* 全体レイアウト */
.matching-layout {
    display: flex;
    gap: 24px;
    align-items: flex-start;
    min-height: 70vh;
}

/* サイドバー */
.matching-sidebar {
    flex: 0 0 240px;
    background: #fff;
    border-radius: 14px;
    box-shadow: 0 4px 16px rgba(31, 55, 85, .08);
    padding: 20px;
}

/* メイン */
.matching-main {
    flex: 1;
    min-width: 0;
    padding: 28px;
    background: #fff;
    border-radius: 14px;
    box-shadow: 0 4px 16px rgba(31, 55, 85, .08);
}

/* ページタイトル */
.matching-title {
    color: #24476b;
    font-size: 26px;
    font-weight: 700;
    padding-bottom: 16px;
    border-bottom: 3px solid #ed9145;
    margin-bottom: 16px;
}

/* 成功メッセージ */
.message-success {
    margin-bottom: 20px;
    padding: 12px 16px;
    border-radius: 8px;
    background: #e8f5ee;
    color: #287653;
    font-size: 14px;
    font-weight: 600;
}

/* 4つの機能ボタン */
.matching-tools {
    display: flex;
    flex-direction: row;
    flex-wrap: wrap;
    align-items: center;
    justify-content: center;
    gap: 10px;
    width: 100%;
    max-width: 100%;
    margin: 0 auto 32px;
    padding: 12px 0;
    background: #f1f5f9;
    border-radius: 10px;
}

/* 機能ボタン */
.matching-btn {
    display: flex;
    align-items: center;
    justify-content: center;
    flex: 0 1 180px;
    min-width: 0;
    box-sizing: border-box;
    padding: 12px 10px;
    border: 1px solid #24476b;
    border-radius: 8px;
    background: #24476b;
    color: #fff;
    font-size: 13px;
    font-weight: 600;
    text-align: center;
    text-decoration: none;
    transition: background .2s;
}

.matching-btn:hover {
    background: #193653;
    border-color: #193653;
    color: #fff;
}

/* 一覧見出し */
.matching-section-title {
    margin-bottom: 20px;
    padding-left: 14px;
    border-left: 4px solid #ed9145;
    color: #24476b;
    font-size: 21px;
    font-weight: 700;
}

/* ユーザー一覧 */
.user-list {
    display: grid;
    grid-template-columns: repeat(3, minmax(0, 1fr));
    gap: 20px;
}

/* ユーザーカード */
.user-card {
    display: flex;
    flex-direction: column;
    min-width: 0;
    overflow: hidden;
    border: 1px solid #e2e8f0;
    border-radius: 12px;
    background: #fff;
    box-shadow: 0 3px 10px rgba(31, 55, 85, .05);
    transition: transform .2s, box-shadow .2s;
}

.user-card:hover {
    transform: translateY(-3px);
    box-shadow: 0 6px 16px rgba(31, 55, 85, .12);
}

/* 写真表示部分 */
.user-photo {
    display: flex;
    align-items: center;
    justify-content: center;
    height: 150px;
    background: #f1f5f9;
    color: #94a3b8;
    font-size: 14px;
    overflow: hidden;
}

.user-photo img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

/* ユーザー情報 */
.user-card-info {
    display: flex;
    flex-direction: column;
    flex: 1;
    padding: 16px;
}

/* ユーザー情報の文章 */
.user-card p {
    margin: 0 0 12px;
    color: #24476b;
    font-size: 14px;
    line-height: 1.7;
    overflow-wrap: anywhere;
}

/* ニックネーム */
.user-nickname {
    font-size: 17px !important;
    font-weight: 700;
    margin-bottom: 12px !important;
}

/* 都道府県 */
.user-prefecture {
    display: inline-block;
    align-self: flex-start;
    margin-bottom: 14px;
    padding: 5px 9px;
    border-radius: 6px;
    background: #e8f5ee;
    color: #287653;
    font-size: 12px;
    font-weight: 600;
}

/* イイネボタン */
.like-button {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    width: 100%;
    min-height: 42px;
    margin-top: auto;
    padding: 10px 16px;
    border: 1px solid #ed9145;
    border-radius: 8px;
    background: #ed9145;
    color: #fff;
    font-size: 14px;
    font-weight: 600;
    cursor: pointer;
    transition: background .2s, transform .2s;
}

.like-button:hover {
    background: #d77a2e;
    border-color: #d77a2e;
    transform: translateY(-1px);
}

/* ユーザーがいない場合 */
.matching-empty {
    grid-column: 1 / -1;
    padding: 36px 20px;
    border: 1px dashed #cbd5e1;
    border-radius: 12px;
    background: #f8fafc;
    color: #718096;
    text-align: center;
    line-height: 1.8;
}

/* タブレット */
@media (max-width: 1100px) {
    .user-list {
        grid-template-columns: repeat(2, minmax(0, 1fr));
    }
}

/* スマートフォン */
@media (max-width: 768px) {
    .matching-layout {
        flex-direction: column;
    }

    .matching-sidebar {
        width: 100%;
        flex-basis: auto;
        box-sizing: border-box;
    }

    .matching-main {
        width: 100%;
        padding: 20px;
        box-sizing: border-box;
    }

    .matching-title {
        font-size: 24px;
    }

    .matching-tools {
        flex-wrap: wrap;
        justify-content: center;
    }

    .matching-btn {
        flex: 1 1 40%;
        white-space: normal;
    }

    .user-list {
        grid-template-columns: repeat(2, minmax(0, 1fr));
        gap: 12px;
    }

    .user-photo {
        height: 120px;
    }

    .user-card-info {
        padding: 12px;
    }

    .user-card p {
        font-size: 13px;
    }
}

/* 小さいスマートフォン */
@media (max-width: 380px) {
    .user-list {
        grid-template-columns: 1fr;
    }

    .matching-btn {
        flex: 1 1 100%;
    }
}

</style>

<div class="matching-layout">

    <%-- サイドバー --%>
    <aside class="matching-sidebar">
        <jsp:include page="/common/sidebar.jsp" />
    </aside>

    <%-- メインコンテンツ --%>
    <main class="matching-main">

        <h1 class="matching-title">マッチング</h1>

        <%-- 成功メッセージ --%>
        <c:if test="${not empty insertCount}">
            <p class="message-success">
                イイネできました！
            </p>
        </c:if>

        <%-- 4つの機能ボタン --%>
        <div class="matching-tools">

            <a class="matching-btn"
               href="/papatalk/scoremanager/main/Genru.action">
                マッチング設定
            </a>

            <a class="matching-btn"
               href="/papatalk/scoremanager/main/RetrieveFavorites.action">
                お気に入りパパ一覧
            </a>

            <a class="matching-btn"
               href="/papatalk/scoremanager/main/GetFavoriteNotifications.action">
                お気に入り通知確認
            </a>

            <a class="matching-btn"
               href="/papatalk/scoremanager/main/MatchingList.action">
                マッチング中一覧
            </a>

        </div>

        <%-- マッチング一覧 --%>
        <h2 class="matching-section-title">マッチング一覧</h2>

        <div class="user-list">

            <c:choose>

                <c:when test="${not empty userList}">

                    <c:forEach var="user" items="${userList}">

                        <div class="user-card">

                            <%-- 写真 --%>
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

                            <div class="user-card-info">

                                <%-- ニックネーム --%>
                                <p class="user-nickname">
                                    ニックネーム：
                                    <c:out value="${user.nickname}" />
                                </p>

                                <%-- 年齢 --%>
                                <p>
                                    年齢：
                                    <c:out value="${user.user_age}" />歳
                                </p>

                                <%-- 都道府県 --%>
                                <div class="user-prefecture">
                                    <c:out value="${user.prefecture}" />
                                </div>

                                <%-- コメント --%>
                                <p>
                                    コメント：
                                    <c:out value="${user.comment}" />
                                </p>

                                <%-- イイネ登録 --%>
                                <form
                                    action="/papatalk/scoremanager/main/FavoriteAdd.action"
                                    method="post">

                                    <input
                                        type="hidden"
                                        name="target_user_id"
                                        value="${user.user_id}">

                                    <button type="submit" class="like-button">
                                        イイネ！！
                                    </button>

                                </form>

                            </div>

                        </div>

                    </c:forEach>

                </c:when>

                <c:otherwise>

                    <div class="matching-empty">
                        該当するユーザーがいません。<br>
                        マッチング設定を確認して、もう一度お試しください。
                    </div>

                </c:otherwise>

            </c:choose>

        </div>

    </main>

</div>

    </c:param>
</c:import>
