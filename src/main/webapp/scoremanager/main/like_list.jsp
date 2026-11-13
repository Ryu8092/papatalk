
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

/* 4つの機能ボタン */
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

/* お気に入りユーザー一覧 */
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

/* お気に入り解除ボタン */
.delete-form {
	margin-top: 16px;
}

.delete-button {
	width: 100%;
	padding: 10px;
	background: #e05252;
	color: white;
	border: none;
	border-radius: 8px;
	font-size: 14px;
	font-weight: bold;
	cursor: pointer;
	transition: background .2s;
}

.delete-button:hover {
	background: #c53030;
}

/* お気に入りがない場合 */
.empty-message {
	grid-column: 1/-1;
	padding: 30px;
	text-align: center;
	color: #718096;
	background: #f8fafc;
	border-radius: 10px;
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

				<!-- 4つの機能ボタン -->
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

				<!-- お気に入り一覧 -->
				<h2 class="matching-title">お気に入りパパ一覧</h2>

				<p class="matching-description">お気に入りに登録したパパを確認できます。</p>

				<div class="user-list">

					<c:choose>
						<c:when test="${not empty favoriteList}">

							<c:forEach var="user" items="${favoriteList}">

								<div class="user-card">

									<div class="user-photo">写真</div>

									<p>
										ユーザーID：
										<c:out value="${user.user_id}" />
									</p>

									<p>
										都道府県：
										<c:out value="${user.prefecture}" />
									</p>

									<!-- お気に入り解除ボタン -->
									<form class="delete-form"
										action="${pageContext.request.contextPath}/scoremanager/main/DeleteFavorites.action"
										method="post"
										onsubmit="return confirm('このパパをお気に入りから解除しますか？');">

										<input type="hidden" name="user_id" value="${user.user_id}">

										<button type="submit" class="delete-button">お気に入り解除</button>

									</form>

								</div>

							</c:forEach>

						</c:when>

						<c:otherwise>
							<p class="empty-message">お気に入りに登録したパパはいません。</p>
						</c:otherwise>
					</c:choose>

				</div>

			</main>
		</div>

	</c:param>
</c:import>
```
