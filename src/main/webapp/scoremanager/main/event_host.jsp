<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
 
<c:import url="/common/base.jsp">
 
    <c:param name="title">イベント一覧</c:param>
 
    <c:param name="content">
 
        <style>
            .event-container {
                padding: 30px;
            }
 
            .event-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 25px;
            }
 
            .event-back-button {
                background-color: #777;
                color: white;
                padding: 12px 25px;
                border-radius: 6px;
                text-decoration: none;
            }
 
            .event-back-button:hover {
                background-color: #555;
            }
 
            .event-post-button {
                background-color: #4caf50;
                color: white;
                padding: 12px 25px;
                border-radius: 6px;
                text-decoration: none;
            }
 
            .event-post-button:hover {
                background-color: #388e3c;
            }
 
            .event-list {
                display: grid;
                grid-template-columns: repeat(3, 1fr);
                gap: 25px;
            }
 
            .event-card {
                border: 1px solid #ddd;
                border-radius: 10px;
                padding: 15px;
                background-color: white;
                text-decoration: none;
                color: black;
            }
 
            .event-photo {
                width: 100%;
                height: 160px;
                background-color: #eee;
                display: flex;
                align-items: center;
                justify-content: center;
                color: #888;
                border-radius: 6px;
                margin-bottom: 15px;
                object-fit: cover;
            }
 
            .event-title {
                font-size: 18px;
                font-weight: bold;
                margin-bottom: 10px;
            }
 
            .event-date {
                color: #666;
                font-size: 14px;
            }
 
            .no-event {
                grid-column: 1 / -1;
                text-align: center;
                padding: 60px 20px;
                color: #777;
            }
        </style>
 
        <div class="event-container">
 
            <div class="event-header">
 
                <!-- 管理画面に戻る -->
                <a href="<c:url value='/scoremanager/main/ManagementScreen.action'/>"
                   class="event-back-button">
                    戻る
                </a>
 
                <!-- イベント投稿 -->
                <a href="EventInputdisplay.action"
                   class="event-post-button">
                    イベント投稿
                </a>
 
            </div>
 
            <div class="event-list">
 
                <c:choose>
 
                    <c:when test="${not empty eventList}">
 
                        <c:forEach var="event" items="${eventList}">
 
                            <a href="GetEventParticipation.action?event_id=${event.event_id}"
                               class="event-card">
 
                                <c:choose>
 
                                    <c:when test="${not empty event.event_url}">
                                        <img src="${event.event_url}"
                                             class="event-photo">
                                    </c:when>
 
                                    <c:otherwise>
                                        <div class="event-photo">
                                            写真
                                        </div>
                                    </c:otherwise>
 
                                </c:choose>
 
                                <div class="event-title">
                                    <c:out value="${event.title}" />
                                </div>
 
                                <div class="event-date">
                                    開催日時：
                                    <c:out value="${event.event_date}" />
                                </div>
 
                            </a>
 
                        </c:forEach>
 
                    </c:when>
 
                    <c:otherwise>
 
                        <div class="no-event">
                            現在、開催予定のイベントはありません。
                        </div>
 
                    </c:otherwise>
 
                </c:choose>
 
            </div>
 
        </div>
 
    </c:param>
 
</c:import>