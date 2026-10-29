<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:import url="/common/base.jsp">
    <c:param name="title">パパトークシステム｜アカウント情報</c:param>
    <c:param name="scripts"></c:param>

    <c:param name="content">
        <style>
            .account-layout {
                display: flex;
                gap: 24px;
                align-items: flex-start;
                min-height: 70vh;
            }

            .account-sidebar {
                flex: 0 0 240px;
                background: #ffffff;
                border-radius: 14px;
                box-shadow: 0 4px 16px rgba(31, 55, 85, 0.08);
                padding: 20px;
            }

            .account-main {
                flex: 1;
                min-width: 0;
                padding: 28px;
                background: #ffffff;
                border-radius: 14px;
                box-shadow: 0 4px 16px rgba(31, 55, 85, 0.08);
            }

            .account-title {
                color: #24476b;
                font-size: 26px;
                font-weight: 700;
                padding-bottom: 16px;
                border-bottom: 3px solid #ed9145;
                margin-bottom: 24px;
            }

            .account-grid {
                display: grid;
                grid-template-columns: repeat(2, minmax(0, 1fr));
                gap: 18px;
            }

            .account-row {
                min-width: 0;
            }

            .account-label {
                display: block;
                color: #718096;
                font-size: 13px;
                font-weight: 600;
                margin-bottom: 7px;
            }

            .account-value {
                min-height: 42px;
                padding: 11px 13px;
                border: 1px solid #dce5ed;
                border-radius: 8px;
                background: #f8fafc;
                color: #2d3748;
                font-size: 14px;
                overflow-wrap: anywhere;
                box-sizing: border-box;
            }

            .account-full {
                grid-column: 1 / -1;
            }

            .account-hobbies {
                min-height: 70px;
    			display: flex;
    			align-items: center;
   				align-content: center;
    			flex-wrap: wrap;
    			gap: 10px;
    			padding: 18px;
    			white-space: normal;
            }

            .account-buttons {
                display: flex;
                justify-content: center;
                gap: 14px;
                flex-wrap: wrap;
                margin-top: 30px;
            }

            .account-button {
                display: inline-block;
                border: none;
                border-radius: 8px;
                padding: 12px 22px;
                font-size: 14px;
                font-weight: 600;
                text-decoration: none;
                text-align: center;
                cursor: pointer;
                background: #00b9c7;
                color: #ffffff;
            }

            .account-button:hover {
                opacity: 0.85;
            }

            .account-delete {
                background: #e85d5d;
            }

            @media (max-width: 768px) {
                .account-layout {
                    flex-direction: column;
                }

                .account-sidebar {
                    width: 100%;
                    flex-basis: auto;
                    box-sizing: border-box;
                }

                .account-main {
                    width: 100%;
                    padding: 20px;
                    box-sizing: border-box;
                }

                .account-grid {
                    grid-template-columns: 1fr;
                }

                .account-full {
                    grid-column: auto;
                }
            }
        </style>

        <div class="account-layout">

            <!-- 左側：サイドバー -->
            <aside class="account-sidebar">
                <jsp:include page="/common/sidebar.jsp" />
            </aside>

            <!-- 右側：アカウント情報 -->
            <main class="account-main">

                <h2 class="account-title">アカウント情報</h2>

                <div class="account-grid">

                    <div class="account-row">
                        <label class="account-label">名前</label>
                        <div class="account-value">${user.user_name}</div>
                    </div>

                    <div class="account-row">
                        <label class="account-label">年齢</label>
                        <div class="account-value">${user.user_age}歳</div>
                    </div>

                    <div class="account-row">
                        <label class="account-label">ニックネーム</label>
                        <div class="account-value">${user.nickname}</div>
                    </div>

                    <div class="account-row">
                        <label class="account-label">パスワード</label>
                        <div class="account-value">********</div>
                    </div>

                    <div class="account-row account-full">
                        <label class="account-label">メールアドレス</label>
                        <div class="account-value">${user.email}</div>
                    </div>

                    <div class="account-row">
                        <label class="account-label">電話番号</label>
                        <div class="account-value">${user.tel}</div>
                    </div>

                    <div class="account-row">
                        <label class="account-label">郵便番号</label>
                        <div class="account-value">${user.postal_code}</div>
                    </div>

                    <div class="account-row">
                        <label class="account-label">都道府県</label>
                        <div class="account-value">${user.prefecture}</div>
                    </div>

                    <div class="account-row">
                        <label class="account-label">市区町村</label>
                        <div class="account-value">${user.city}</div>
                    </div>

                    <div class="account-row">
                        <label class="account-label">番地</label>
                        <div class="account-value">${user.address1}</div>
                    </div>

                    <div class="account-row account-full">
                        <label class="account-label">建物名・部屋番号</label>
                        <div class="account-value">${user.address2}</div>
                    </div>

                    <div class="account-row">
                        <label class="account-label">お子さんの年齢</label>
                        <div class="account-value">${user.child_age}歳</div>
                    </div>

                    <div class="account-row">
                        <label class="account-label">お子さんの性別</label>
                        <div class="account-value">${user.child_gender}</div>
                    </div>

                    <div class="account-row account-full">
    					<label class="account-label">趣味</label>
    						<div class="account-value account-hobbies">
        						<c:choose>
            						<c:when test="${not empty selectedHobbies}">
                						<c:forEach var="hobby"
                          	 				items="${selectedHobbies}"
											varStatus="status">
                    						<c:if test="${!status.first}">、</c:if>
                    						<c:out value="${hobby}"/>
                						</c:forEach>
            						</c:when>
            						
            						<c:otherwise>
                					趣味は未登録です
            						</c:otherwise>
        						</c:choose>
    						</div>
						</div>

            

                <div class="account-buttons">
                    <form action="AccountChange.action" method="get">
                        <button type="submit" class="account-button">
                            アカウント情報変更
                        </button>
                    </form>

                    <form action="ScreenDisplay.action" method="get">
                        <button type="submit"
                                class="account-button account-delete">
                            アカウント削除
                        </button>
                    </form>
                    
                </div>

            </main>
        </div>
    </c:param>
</c:import>