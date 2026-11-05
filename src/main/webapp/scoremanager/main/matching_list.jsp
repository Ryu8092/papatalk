<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
 
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
 
            .matching-sidebar-wrapper {
                flex: 0 0 210px;
                width: 210px;
                min-width: 210px;
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
 
            .user-list {
                display: grid;
                grid-template-columns: repeat(2, minmax(0, 1fr));
                gap: 20px;
            }
 
            .user-card {
                padding: 22px;
                border: 1px solid #dce5ee;
                border-radius: 12px;
                background: #fff;
            }
 
            .user-name {
                font-size: 19px;
                font-weight: bold;
                margin-bottom: 10px;
            }
 
            .user-prefecture {
                color: #66788a;
                margin-bottom: 18px;
            }
 
            .chat-button {
                display: block;
                width: 100%;
                padding: 11px;
                border-radius: 8px;
                background: #24476b;
                color: white;
                font-weight: bold;
                text-align: center;
                text-decoration: none;
                box-sizing: border-box;
            }
 
            .chat-button:hover {
                background: #173b60;
                color: white;
            }
 
            .empty-message {
                color: #777;
                padding: 20px 0;
            }
 
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
        </style>
 
        <div class="matching-layout">
 
            <div class="matching-sidebar-wrapper">
                <jsp:include page="/common/sidebar.jsp" />
            </div>
 
            <main class="matching-main">
 
                <h1 class="matching-title">マッチング中一覧</h1>
 
                <p class="matching-description">
                    マッチングしたユーザーを確認できます。
                </p>
 
                <div class="user-list">
 
                    <c:forEach var="matching" items="${matchingList}">
 
                        <div class="user-card">
 
                            <div class="user-name">
                                <c:out value="${matching.user_name}" />
                            </div>
 
                            <div class="user-prefecture">
                                <c:out value="${matching.prefecture}" />
                            </div>
 
                            <a class="chat-button"
                                href="${pageContext.request.contextPath}/scoremanager/main/MatchingChat.action?target_user_id=${matching.user_id}">
                                チャットする
                            </a>
 
                        </div>
 
                    </c:forEach>
 
                </div>
 
                <c:if test="${empty matchingList}">
                    <p class="empty-message">
                        まだマッチングしているユーザーはいません。
                    </p>
                </c:if>
 
            </main>
        </div>
    </c:param>
</c:import>