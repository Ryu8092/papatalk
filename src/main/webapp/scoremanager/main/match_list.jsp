
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<c:import url="/common/base.jsp">
	<c:param name="title">パパトークシステム</c:param>
	<c:param name="scripts"></c:param>
	<c:param name="content">

		<style>
.matching-layout {
	display: flex;
	gap: 24px;
	align-items: flex-start;
	min-height: 70vh;
}

.matching-sidebar {
	flex: 0 0 240px;
	background: #fff;
	border-radius: 14px;
	box-shadow: 0 4px 16px rgba(31, 55, 85, .08);
	padding: 20px;
}

.matching-main {
	flex: 1;
	min-width: 0;
	padding: 28px;
	background: #fff;
	border-radius: 14px;
	box-shadow: 0 4px 16px rgba(31, 55, 85, .08);
}

.matching-title {
	color: #24476b;
	font-size: 26px;
	font-weight: 700;
	padding-bottom: 16px;
	border-bottom: 3px solid #ed9145;
	margin-bottom: 16px;
}

.matching-description {
	color: #718096;
	font-size: 14px;
	margin-bottom: 16px;
}

.matching-menu {
	display: grid;
	grid-template-columns: repeat(2, minmax(0, 1fr));
	gap: 8px;
	margin-bottom: 24px;
}

.matching-menu a {
	display: flex;
	align-items: center;
	justify-content: space-between;
	gap: 8px;
	padding: 9px 12px;
	background: #fff;
	border: 1px solid #dce4ee;
	border-radius: 8px;
	color: #24476b;
	text-decoration: none;
	font-size: 13px;
	font-weight: 600;
	transition: background .2s;
}

.matching-menu a:hover {
	background: #f2f5fa;
}

.menu-arrow {
	color: #718096;
	flex-shrink: 0;
}

.user-list {
	display: grid;
	grid-template-columns: repeat(2, minmax(0, 1fr));
	gap: 20px;
	margin-top: 20px;
}

.user-card {
	padding: 20px;
	border: 1px solid #e2e8f0;
	border-radius: 12px;
	background: #fff;
	text-align: center;
}

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
}

.user-card p {
	text-align: left;
	margin: 12px 0;
	overflow-wrap: anywhere;
}

.like-button {
	padding: 10px 24px;
	border: none;
	border-radius: 20px;
	background: #ed9145;
	color: #fff;
	cursor: pointer;
	margin-top: 10px;
}

.like-button:hover {
	background: #d97c30;
}

.message-success {
	color: green;
	font-weight: bold;
	margin-bottom: 16px;
}

@media ( max-width : 768px) {
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
	.user-list {
		grid-template-columns: 1fr;
	}
}

@media ( max-width : 480px) {
	.matching-menu a {
		padding: 8px;
		font-size: 12px;
	}
}
</style>

		<div class="matching-layout">

			<aside class="matching-sidebar">
				<jsp:include page="/common/sidebar.jsp" />
			</aside>

			<main class="matching-main">

				<h2 class="matching-title">マッチング一覧</h2>

				<c:if test="${not empty insertCount}">
					<p class="message-success">イイネできました！</p>
				</c:if>


				<p class="matching-description">同じ都道府県のパパを探してみましょう！</p>

				<div class="matching-menu">

					<a
						href="${pageContext.request.contextPath}/scoremanager/main/Genru.action">
						<span>マッチング設定</span> <span class="menu-arrow">›</span>
					</a> <a
						href="${pageContext.request.contextPath}/scoremanager/main/RetrieveFavorites.action">
						<span>お気に入りパパ一覧</span> <span class="menu-arrow">›</span>
					</a> <a
						href="${pageContext.request.contextPath}/scoremanager/main/GetFavoriteNotifications.action">
						<span>お気に入り通知確認</span> <span class="menu-arrow">›</span>
					</a> <a
						href="${pageContext.request.contextPath}/scoremanager/main/MatchingList.action">
						<span>マッチング中一覧</span> <span class="menu-arrow">›</span>
					</a>

				</div>

				<div class="user-list">

					<c:forEach var="user" items="${userList}">

						<div class="user-card">

							<div class="user-photo">写真</div>

							<%-- ユーザーIDは画面に表示しない --%>
							<p>
								都道府県：
								<c:out value="${user.prefecture}" />
							</p>

							<form
								action="${pageContext.request.contextPath}/scoremanager/main/FavoriteAdd.action"
								method="post">

								<%-- ログインユーザーIDはAction側で
                                     セッションから取得する --%>

								<input type="hidden" name="target_user_id"
									value="${user.user_id}">

								<button type="submit" class="like-button">イイネ！！</button>

							</form>

						</div>

					</c:forEach>

					<c:if test="${empty userList}">
						<p>該当するユーザーがいません。</p>
					</c:if>

				</div>

			</main>

		</div>

	</c:param>
</c:import>