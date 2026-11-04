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

.notice-sidebar {
	flex: 0 0 240px;
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
	font-weight: bold;
	padding-bottom: 16px;
	border-bottom: 3px solid #ed9145;
	margin-bottom: 24px;
}

.notice-message {
	text-align: center;
	padding: 20px;
	border: 1px solid #aaa;
	margin-bottom: 30px;
	line-height: 2;
	color: #555;
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
	font-size: 18px;
}

.notice-list {
	display: grid;
	grid-template-columns: repeat(2, minmax(0, 1fr));
	gap: 24px;
}

.notice-card {
	border: 1px solid #ddd;
	border-radius: 10px;
	padding: 15px;
	text-align: center;
}

.notice-photo {
	width: 100%;
	height: 150px;
	background: #f1f5f9;
	display: flex;
	align-items: center;
	justify-content: center;
	margin-bottom: 12px;
	color: #718096;
	border-radius: 8px;
}

.notice-info {
	text-align: left;
	line-height: 1.8;
	margin-bottom: 12px;
}

.matching-button {
	display: block;
	width: 100%;
	padding: 10px;
	background: #ed9145;
	color: white;
	border: none;
	border-radius: 7px;
	font-weight: bold;
	cursor: pointer;
	text-decoration: none;
	text-align: center;
	font-size: 16px;
}

.matching-button:hover {
	background: #d8792e;
}

.empty-message {
	grid-column: 1/-1;
	text-align: center;
	padding: 30px;
	background: #f8fafc;
	color: #718096;
	border-radius: 10px;
}

.back-button {
	display: block;
	width: 100px;
	margin-left: auto;
	margin-bottom: 20px;
	padding: 10px;
	text-align: center;
	color: #24476b;
	border: 1px solid #ccc;
	border-radius: 7px;
	text-decoration: none;
}

@media ( max-width : 768px) {
	.notice-layout {
		flex-direction: column;
	}
	.notice-main {
		width: 100%;
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

				<a class="back-button"
					href="${pageContext.request.contextPath}/scoremanager/main/FavoriteList.action">
					戻る </a>

				<%-- マッチング完了メッセージ --%>
				<c:if test="${not empty matchingMessage}">
					<div class="success-message">
						<c:out value="${matchingMessage}" />
					</div>
				</c:if>

				<h2 class="notice-title">お気に入り通知一覧</h2>

				<div class="notice-message">
					あなたに興味を持っている人がいます<br> すでにマッチングすることができます
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
										<br> 年齢：
										<c:out value="${favorite.user_age}" />
										<br> 住所：
										<c:out value="${favorite.prefecture}" />
										<br> コメント：
										<c:out value="${favorite.comment}" />

									</div>

									<%-- マッチング登録 --%>
									<form
										action="${pageContext.request.contextPath}/scoremanager/main/MatchingAdd.action"
										method="post">

										<input type="hidden" name="target_user_id"
											value="${favorite.user_id}">

										<button type="submit" class="matching-button">
											マッチングする</button>

									</form>

								</div>

							</c:forEach>

						</c:when>

						<c:otherwise>

							<p class="empty-message">お気に入り通知がありません。</p>

						</c:otherwise>

					</c:choose>

				</div>

			</main>

		</div>

	</c:param>

</c:import>