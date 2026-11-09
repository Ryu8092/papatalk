<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
 
<c:import url="/common/base.jsp">
    <c:param name="title">
        パパトークシステム｜通報履歴
    </c:param>
 
    <c:param name="scripts">
        <style>
            /* 全体 */
            .history-page {
                width: 100%;
                min-height: 75vh;
                display: flex;
                justify-content: center;
                align-items: center;
                padding: 30px 20px;
                background-color: #f5f7fa;
            }
 
            /* 外側の枠 */
            .history-container {
                width: 100%;
                max-width: 850px;
                min-height: 490px;
                background-color: #ffffff;
                border: 2px solid #222222;
                padding: 15px 45px 40px;
                box-sizing: border-box;
            }
 
            /* 戻るボタン */
            .back-button {
                display: inline-block;
                padding: 5px 15px;
                background-color: #c3e5f2;
                border: 2px solid #222222;
                color: #222222;
                text-decoration: none;
                font-size: 18px;
            }
 
            /* タイトル */
            .history-title {
                text-align: center;
                font-size: 32px;
                margin: -20px 0 20px;
            }
 
            .history-line {
                border: none;
                border-top: 2px solid #222222;
                margin-bottom: 20px;
            }
 
            /* ユーザー一覧 */
            .history-list {
                width: 80%;
                margin: 0 auto;
                display: flex;
                flex-direction: column;
                gap: 25px;
            }
 
            /* ユーザーの枠 */
            .history-item {
                width: 100%;
                min-height: 50px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                border: 2px solid #222222;
                padding: 8px 20px;
                box-sizing: border-box;
                text-decoration: none;
                color: #555555;
                font-size: 17px;
            }
 
            .history-item:hover {
                background-color: #f0f7fa;
            }
 
            .user-name {
                margin-left: 20px;
            }
 
            .user-status {
                color: red;
            }
 
            /* 履歴がない場合 */
            .no-history {
                text-align: center;
                font-size: 18px;
                margin-top: 60px;
            }
 
            @media screen and (max-width: 768px) {
                .history-container {
                    padding: 15px 15px 30px;
                }
 
                .history-title {
                    font-size: 25px;
                }
 
                .history-list {
                    width: 95%;
                }
 
                .history-item {
                    font-size: 14px;
                    padding: 8px 10px;
                }
            }
        </style>
    </c:param>
 
    <c:param name="content">
        <div class="history-page">
            <div class="history-container">
 
                <!-- 戻るボタン -->
                <a href="operation_management.jsp"
                   class="back-button">
                    戻る
                </a>
 
                <!-- タイトル -->
                <h1 class="history-title">
                    通報履歴
                </h1>
 
                <hr class="history-line">
 
                <!-- BANされたユーザー一覧 -->
                <c:choose>
                    <c:when test="${not empty userList}">
                        <div class="history-list">
 
                            <c:forEach var="user" items="${userList}">
                                <a href="BanScreenDisplay.action?user_id=${user.user_id}"
                                   class="history-item">
 
                                    <span class="user-name">
                                        <c:out value="${user.user_name}" />
                                    </span>
 
                                    <span class="user-status">
                                        アカウント停止中
                                    </span>
 
                                </a>
                            </c:forEach>
 
                        </div>
                    </c:when>
 
                    <c:otherwise>
                        <p class="no-history">
                            BANした人はいません
                        </p>
                    </c:otherwise>
                </c:choose>
 
            </div>
        </div>
    </c:param>
</c:import>