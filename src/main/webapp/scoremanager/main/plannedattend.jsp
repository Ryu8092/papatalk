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
                margin-bottom: 24px;
            }
 
            .planned-card {
                background: #fff;
                border: 1px solid #ddd;
                border-radius: 10px;
                padding: 22px;
                margin-bottom: 20px;
                box-shadow: 0 2px 6px rgba(0, 0, 0, 0.06);
            }
 
            .planned-card h3 {
                margin: 0 0 15px;
                font-size: 20px;
                color: #333;
            }
 
            .planned-card p {
                margin: 10px 0;
                color: #555;
            }
 
            .planned-card a {
                color: #2878c8;
                text-decoration: none;
            }
 
            .planned-card a:hover {
                text-decoration: underline;
            }
 
            .no-event {
                text-align: center;
                padding: 40px 20px;
                color: #777;
                background: #fff;
                border: 1px solid #ddd;
                border-radius: 10px;
            }
 
            .back-area {
                text-align: center;
                margin-top: 25px;
            }
 
            .back-button {
                display: inline-block;
                padding: 10px 30px;
                background: #718096;
                color: #fff;
                text-decoration: none;
                border-radius: 8px;
                font-weight: bold;
                transition: background .2s;
            }
 
            .back-button:hover {
                background: #596779;
            }
 
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
            }
        </style>
 
        <div class="matching-layout">
 
            <!-- サイドバー -->
            <aside class="matching-sidebar">
                <jsp:include page="/common/sidebar.jsp" />
            </aside>
 
            <!-- 参加予定一覧 -->
            <main class="matching-main">
 
                <h2 class="matching-title">参加予定一覧</h2>
 
                <c:choose>
 
                    <c:when test="${not empty plannedEventList}">
 
                        <c:forEach var="event" items="${plannedEventList}">
 
                            <div class="planned-card">
 
                                <h3>
                                    <c:out value="${event.title}" />
                                </h3>
 
                                <p>
                                    開催日：
                                    <c:out value="${event.event_date}" />
                                </p>
 
                                <p>
                                    開催場所：
                                    <c:out value="${event.event_place}" />
                                </p>
 
                                <c:if test="${not empty event.event_url}">
                                    <p>
                                        イベントURL：
                                        <a href="<c:out value='${event.event_url}' />"
                                           target="_blank"
                                           rel="noopener noreferrer">
                                            イベントページを見る
                                        </a>
                                    </p>
                                </c:if>
 
                            </div>
 
                        </c:forEach>
 
                    </c:when>
 
                    <c:otherwise>
 
                        <div class="no-event">
                            現在、予約しているイベントはありません。
                        </div>
 
                    </c:otherwise>
 
                </c:choose>
 
                <!-- 戻るボタン -->
                <div class="back-area">
                    <a href="<c:url value='/scoremanager/main/RetrieveEvents.action'/>"
                       class="back-button">
                        戻る
                    </a>
                </div>
 
            </main>
 
        </div>
 
    </c:param>
 
</c:import>