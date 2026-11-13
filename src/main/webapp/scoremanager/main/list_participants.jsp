<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
 
<c:import url="/common/base.jsp">
 
    <c:param name="title">イベント参加予定者</c:param>
 
    <c:param name="content">
 
        <style>
            /* 全体 */
            .participant-container {
                padding: 30px;
            }
 
            /* タイトル */
            .participant-title {
                font-size: 24px;
                font-weight: bold;
                margin-bottom: 30px;
                color: #24476b;
            }
 
            /* 参加者一覧 */
            .participant-list {
                display: flex;
                flex-direction: column;
                gap: 20px;
            }
 
            /* 参加者カード */
            .participant-card {
                padding: 22px 25px;
                background: #fff;
                border: 1px solid #dce4ed;
                border-radius: 12px;
                box-shadow: 0 3px 10px rgba(31, 55, 85, .07);
                box-sizing: border-box;
            }
 
            /* 参加者情報 */
            .participant-info {
                display: flex;
                flex-direction: column;
                gap: 13px;
            }
 
            .participant-info p {
                display: flex;
                align-items: center;
                margin: 0;
                padding-bottom: 10px;
                border-bottom: 1px solid #edf0f4;
                font-size: 15px;
                color: #334155;
            }
 
            .participant-info p:last-child {
                border-bottom: none;
                padding-bottom: 0;
            }
 
            /* 項目名 */
            .participant-label {
                display: inline-block;
                width: 120px;
                flex-shrink: 0;
                color: #718096;
                font-weight: 600;
            }
 
            /* 項目の値 */
            .participant-value {
                color: #24476b;
                font-weight: 600;
                overflow-wrap: anywhere;
            }
 
            /* 戻るボタン */
            .back-area {
                text-align: center;
                margin-top: 30px;
            }
 
            .back-button {
                display: inline-block;
                min-width: 110px;
                padding: 12px 25px;
                border-radius: 8px;
                background: #718096;
                color: #fff;
                text-decoration: none;
                text-align: center;
                font-weight: 600;
                transition: background .2s;
            }
 
            .back-button:hover {
                background: #566579;
            }
 
            /* 参加者がいない場合 */
            .no-participant {
                text-align: center;
                padding: 60px 20px;
                color: #718096;
                background: #f7f9fc;
                border: 1px dashed #ccd5df;
                border-radius: 10px;
            }
 
            /* スマートフォン */
            @media (max-width: 576px) {
                .participant-container {
                    padding: 15px;
                }
 
                .participant-card {
                    padding: 18px;
                }
 
                .participant-info p {
                    align-items: flex-start;
                    flex-direction: column;
                    gap: 5px;
                }
 
                .participant-label {
                    width: auto;
                }
            }
        </style>
 
        <div class="participant-container">
 
            <!-- タイトル -->
            <h2 class="participant-title">
                イベント参加予定者
            </h2>
 
            <!-- 参加者一覧 -->
            <div class="participant-list">
 
                <c:choose>
 
                    <c:when test="${not empty expectedParticipantsList}">
 
                        <c:forEach var="participant"
                            items="${expectedParticipantsList}">
 
                            <div class="participant-card">
 
                                <div class="participant-info">
 
                                    <p>
                                        <span class="participant-label">
                                            名前：
                                        </span>
                                        <span class="participant-value">
                                            <c:out value="${participant.user_name}" />
                                        </span>
                                    </p>
 
                                    <p>
                                        <span class="participant-label">
                                            メールアドレス：
                                        </span>
                                        <span class="participant-value">
                                            <c:out value="${participant.email}" />
                                        </span>
                                    </p>
 
                                    <p>
                                        <span class="participant-label">
                                            電話番号：
                                        </span>
                                        <span class="participant-value">
                                            <c:out value="${participant.tel}" />
                                        </span>
                                    </p>
 
                                    <p>
                                        <span class="participant-label">
                                            大人人数：
                                        </span>
                                        <span class="participant-value">
                                            <c:out value="${participant.adultnumber}" />人
                                        </span>
                                    </p>
 
                                    <p>
                                        <span class="participant-label">
                                            子供人数：
                                        </span>
                                        <span class="participant-value">
                                            <c:out value="${participant.childnumber}" />人
                                        </span>
                                    </p>
 
                                </div>
 
                            </div>
 
                        </c:forEach>
 
                    </c:when>
 
                    <c:otherwise>
 
                        <div class="no-participant">
                            現在、このイベントの参加予定者はいません。
                        </div>
 
                    </c:otherwise>
 
                </c:choose>
 
            </div>
 
            <!-- 戻るボタン -->
            <div class="back-area">
                <a href="javascript:history.back()" class="back-button">
                    戻る
                </a>
            </div>
 
        </div>
 
    </c:param>
 
</c:import>