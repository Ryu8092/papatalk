
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<c:import url="/common/base.jsp">
    <c:param name="title">パパトークシステム</c:param>
    <c:param name="scripts"></c:param>
    <c:param name="content">

<style>
.notice-layout {
    display: flex;
    gap: 24px;
    align-items: flex-start;
    min-height: 70vh;
}
.matching-menu {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 8px;
}

.matching-menu a {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 12px;
    background: #fff;
    border: 1px solid #dce4ee;
    border-radius: 8px;
    color: #24476b;
    text-decoration: none;
    font-size: 13px;
    font-weight: bold;
}

.matching-menu a:hover {
    background: #f2f5fa;
}

.menu-arrow {
    color: #718096;
    font-size: 18px;
}

.notice-sidebar {
    flex: 0 0 240px;
    background: #fff;
    border-radius: 14px;
    box-shadow: 0 4px 16px rgba(31, 55, 85, .08);
    padding: 20px;
}

.notice-main {
    flex: 1;
    min-width: 0;
    padding: 28px;
    background: #fff;
    border-radius: 14px;
    box-shadow: 0 4px 16px rgba(31, 55, 85, .08);
}

.notice-title {
    color: #24476b;
    font-size: 26px;
    font-weight: 700;
    padding-bottom: 16px;
    border-bottom: 3px solid #ed9145;
    margin-bottom: 24px;
}

/* 戻るボタン */
.back-button {
    display: block;
    width: 100px;
    margin-left: auto;
    margin-bottom: 20px;
    padding: 10px;
    text-align: center;
    color: #24476b;
    border: 1px solid #dce4ee;
    border-radius: 8px;
    text-decoration: none;
    font-size: 14px;
    font-weight: 600;
    transition: background .2s;
}

.back-button:hover {
    background: #f2f5fa;
}

/* 通知メッセージ */
.notice-message {
    text-align: center;
    padding: 20px;
    border: 1px solid #dce4ee;
    border-radius: 10px;
    margin-bottom: 30px;
    line-height: 2;
    color: #555;
    background: #f8fafc;
}

/* マッチング完了メッセージ */
.success-message {
    text-align: center;
    padding: 15px;
    margin-bottom: 20px;
    background: #e6f7ed;
    border: 1px solid #7bc99a;
    border-radius: 8px;
    color: #267344;
    font-weight: bold;
    font-size: 16px;
}

/* 通知一覧 */
.notice-list {
    display: grid;
    grid-template-columns: repeat(2, minmax(0, 1fr));
    gap: 20px;
}

.notice-card {
    border: 1px solid #e2e8f0;
    border-radius: 12px;
    padding: 20px;
    text-align: center;
    background: #fff;
}

.notice-photo {
    width: 100%;
    height: 180px;
    background: #f1f5f9;
    display: flex;
    align-items: center;
    justify-content: center;
    margin-bottom: 16px;
    color: #718096;
    border-radius: 10px;
}

.notice-info {
    text-align: left;
    line-height: 1.8;
    margin-bottom: 16px;
    overflow-wrap: anywhere;
}

/* マッチングボタン */
.matching-button {
    display: block;
    width: 100%;
    padding: 10px;
    background: #ed9145;
    color: white;
    border: none;
    border-radius: 8px;
    font-weight: bold;
    cursor: pointer;
    text-align: center;
    font-size: 14px;
    transition: background .2s;
}

.matching-button:hover {
    background: #d97c30;
}

/* 通知がない場合 */
.empty-message {
    grid-column: 1 / -1;
    text-align: center;
    padding: 30px;
    background: #f8fafc;
    color: #718096;
    border-radius: 10px;
}

@media (max-width: 768px) {
    .notice-layout {
        flex-direction: column;
    }

    .notice-sidebar {
        width: 100%;
        flex-basis: auto;
        box-sizing: border-box;
    }

    .notice-main {
        width: 100%;
        padding: 20px;
        box-sizing: border-box;
    }

    .notice-list {
        grid-template-columns: 1fr;
    }
}
</style>

<div class="notice-layout">

    <aside class="notice-sidebar">
        <jsp:include page="/common/sidebar.jsp" />
    </aside>

    <main class="notice-main">

	        <!-- 4つの機能ボタン -->
	<div class="matching-menu">
	    <a href="${pageContext.request.contextPath}/scoremanager/main/Genru.action">
	        <span>マッチング設定</span>
	        <span class="menu-arrow">›</span>
	    </a>
	
	    <a href="${pageContext.request.contextPath}/scoremanager/main/FavoriteList.action">
	        <span>お気に入りパパ一覧</span>
	        <span class="menu-arrow">›</span>
	    </a>
	
	    <a href="${pageContext.request.contextPath}/scoremanager/main/GetFavoriteNotifications.action">
	        <span>お気に入り通知確認</span>
	        <span class="menu-arrow">›</span>
	    </a>
	
	    <a href="${pageContext.request.contextPath}/scoremanager/main/MatchingList.action">
	        <span>マッチング中一覧</span>
	        <span class="menu-arrow">›</span>
	    </a>
	</div>

        <%-- マッチング完了メッセージ --%>
        <c:if test="${not empty matchingMessage}">
            <div class="success-message">
                <c:out value="${matchingMessage}" />
            </div>
        </c:if>

        <h2 class="notice-title">お気に入り通知一覧</h2>

        <div class="notice-message">
            あなたに興味を持っている人がいます<br>
            すぐにマッチングすることができます
        </div>

        <div class="notice-list">

            <c:choose>

                <c:when test="${not empty notificationList}">

                    <c:forEach var="favorite" items="${notificationList}">

                        <div class="notice-card">

                            <div class="notice-photo">写真</div>

                            <div class="notice-info">

                                名前：
                                <c:out value="${favorite.user_name}" />
                                <br>

                                年齢：
                                <c:out value="${favorite.user_age}" />
                                <br>

                                住所：
                                <c:out value="${favorite.prefecture}" />
                                <br>

                                コメント：
                                <c:out value="${favorite.comment}" />

                            </div>

                            <%-- マッチング登録 --%>
                            <form
                                action="${pageContext.request.contextPath}/scoremanager/main/MatchingAdd.action"
                                method="post">

                                <input type="hidden" name="target_user_id"
                                    value="${favorite.user_id}">

                                <button type="submit" class="matching-button">
                                    マッチングする
                                </button>

                            </form>

                        </div>

                    </c:forEach>

                </c:when>

                <c:otherwise>

                    <p class="empty-message">
                        お気に入り通知がありません。
                    </p>

                </c:otherwise>

            </c:choose>

        </div>

    </main>

</div>

    </c:param>
</c:import>
