
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:import url="/common/base.jsp">
    <c:param name="title">ユーザー詳細｜パパトークシステム</c:param>
    <c:param name="scripts"></c:param>
    <c:param name="content">

        <style>
            /* 全体 */
            .user-detail-page {
                max-width: 800px;
                margin: 30px auto;
                padding: 30px;
                background: #fff;
                border-radius: 14px;
                box-shadow: 0 3px 12px rgba(31,55,85,.08);
                box-sizing: border-box;
            }

            /* 戻るボタンエリア */
            .back-button-area {
                display: flex;
                justify-content: flex-start;
                margin-bottom: 20px;
            }

            /* 戻るボタン */
            .back-button {
                padding: 13px 28px;
                background: #24476b;
                color: #fff;
                text-decoration: none;
                border: none;
                border-radius: 8px;
                font-size: 16px;
                font-weight: bold;
                cursor: pointer;
                box-shadow: 0 2px 5px rgba(31,55,85,.15);
                transition: background 0.2s;
            }

            .back-button:hover {
                background: #183653;
            }

            /* 見出し */
            .detail-heading {
                color: #24476b;
                font-size: 24px;
                text-align: center;
                margin-bottom: 30px;
                padding-bottom: 15px;
                border-bottom: 2px solid #e2e8f0;
            }

            /* ユーザー情報：2列表示 */
            .user-info {
                display: grid;
                grid-template-columns: repeat(2, 1fr);
                gap: 10px;
            }

            .user-info-item {
			    display: flex;
			    flex-direction: column;
			    gap: 4px; 
			    padding: 10px 14px; 
			    background: #f7f9fc;
			    border: 1px solid #e2e8f0;
			    border-radius: 8px;
			    box-sizing: border-box;
			}

            .user-info-label {
			    width: 100%;
			    min-width: 0;
			    color: #52657b;
			    font-weight: bold;
			    font-size: 12px; 
			}
			
			.user-info-value {
			    color: #334155;
			    font-size: 14px; 
			    line-height: 1.5;
			    overflow-wrap: anywhere;
			    white-space: pre-wrap;
			}

            /* コメントは横幅いっぱい */
            .comment-item {
                grid-column: 1 / -1;
            }

            /* ボタンエリア */
            .button-area {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 20px;
                margin-top: 35px;
            }

            /* イイネボタン */
            .favorite-button {
                padding: 11px 35px;
                background: #ed9145;
                color: #fff;
                border: none;
                border-radius: 7px;
                font-size: 14px;
                font-weight: bold;
                cursor: pointer;
            }

            .favorite-button:hover {
                background: #d97c30;
            }

            /* ユーザーが見つからない場合 */
            .empty-user {
                padding: 30px;
                text-align: center;
                color: #718096;
                background: #f7f9fc;
                border-radius: 8px;
            }

            /* スマホ対応 */
            @media(max-width: 600px) {
                .user-detail-page {
                    padding: 18px;
                    margin: 15px;
                }

                .user-info {
                    grid-template-columns: 1fr;
                }

                .comment-item {
                    grid-column: auto;
                }

                .button-area {
                    flex-direction: column;
                }

                .favorite-button {
                    width: 100%;
                    box-sizing: border-box;
                }
            }
        </style>

        <div class="user-detail-page">

            <!-- 戻るボタン -->
            <div class="back-button-area">
                <button type="button"
                        class="back-button"
                        onclick="history.back()">
                    ← 戻る
                </button>
            </div>

            <!-- 見出し -->
            <h2 class="detail-heading">
                ユーザー詳細
            </h2>

            <%-- ユーザー情報がある場合 --%>
            <c:if test="${not empty target_user}">

                <div class="user-info">

                    <div class="user-info-item">
                        <div class="user-info-label">名前</div>
                        <div class="user-info-value">
                            <c:out value="${target_user.user_name}" />
                        </div>
                    </div>

                    <div class="user-info-item">
                        <div class="user-info-label">ニックネーム</div>
                        <div class="user-info-value">
                            <c:out value="${target_user.nickname}" />
                        </div>
                    </div>

                    <div class="user-info-item">
                        <div class="user-info-label">年齢</div>
                        <div class="user-info-value">
                            <c:out value="${target_user.user_age}歳" />
                        </div>
                    </div>

                    <div class="user-info-item">
                        <div class="user-info-label">居住地</div>
                        <div class="user-info-value">
                            <c:out value="${target_user.prefecture}" />
                            <c:out value="${target_user.city}" />
                        </div>
                    </div>

                    <div class="user-info-item">
                        <div class="user-info-label">子供の年齢</div>
                        <div class="user-info-value">
                            <c:out value="${target_user.child_age}歳" />
                        </div>
                    </div>

                    <div class="user-info-item">
                        <div class="user-info-label">子供の性別</div>
                        <div class="user-info-value">
                            <c:out value="${target_user.child_gender}子" />
                        </div>
                    </div>

                    <div class="user-info-item comment-item">
                        <div class="user-info-label">コメント</div>
                        <div class="user-info-value">
                            <c:out value="${target_user.comment}" />
                        </div>
                    </div>

                </div>

                <%-- イイネボタン --%>
                <div class="button-area">
                    <form action="${pageContext.request.contextPath}/scoremanager/main/BoardFavoriteAdd.action"
                          method="post">

                        <input type="hidden"
                               name="target_user_id"
                               value="<c:out value='${target_user.user_id}'/>">

                        <input type="hidden"
                               name="post_id"
                               value="${post_id}">

                        <button type="submit"
                                class="favorite-button">
                            イイネ
                        </button>
                    </form>
                </div>

            </c:if>

            <%-- ユーザー情報が見つからない場合 --%>
            <c:if test="${empty target_user}">
                <div class="empty-user">
                    ユーザー情報が見つかりません。
                </div>
            </c:if>

        </div>

    </c:param>
</c:import>
