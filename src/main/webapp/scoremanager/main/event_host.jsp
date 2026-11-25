
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<c:import url="/common/base.jsp">
    <c:param name="title">イベント一覧</c:param>

    <c:param name="content">

        <style>
            /* 画面全体 */
            .event-container {
                max-width: 1100px;
                margin: 0 auto;
                padding: 15px 20px;
                box-sizing: border-box;
            }

            /* ヘッダー */
            .event-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 15px;
            }

            /* 戻るボタン */
            .event-back-button {
                background-color: #777;
                color: white;
                padding: 8px 18px;
                border-radius: 6px;
                text-decoration: none;
                font-size: 14px;
            }

            .event-back-button:hover {
                background-color: #555;
            }

            /* イベント投稿ボタン */
            .event-post-button {
                background-color: #4caf50;
                color: white;
                padding: 8px 18px;
                border-radius: 6px;
                text-decoration: none;
                font-size: 14px;
            }

            .event-post-button:hover {
                background-color: #388e3c;
            }

            /* イベント一覧 */
            .event-list {
                display: grid;
                grid-template-columns: repeat(3, minmax(0, 1fr));
                gap: 15px;
            }

            /* イベントカード */
            .event-card {
                display: block;
                border: 1px solid #ddd;
                border-radius: 10px;
                padding: 10px;
                background-color: white;
                text-decoration: none;
                color: black;
                min-width: 0;
                box-sizing: border-box;
                transition: transform 0.2s, box-shadow 0.2s;
            }

            .event-card:hover {
                transform: translateY(-3px);
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.12);
            }

            /* イベント写真 */
            .event-photo {
                width: 100%;
                height: 130px;
                object-fit: cover;
                border-radius: 8px;
                display: block;
            }

            /* 写真がない場合 */
            div.event-photo {
                background-color: #eee;
                color: #888;
                display: flex;
                justify-content: center;
                align-items: center;
                font-size: 14px;
            }

            /* イベントタイトル */
            .event-title {
                font-size: 16px;
                font-weight: bold;
                margin: 8px 0;
                overflow-wrap: anywhere;
            }

            /* 開催日時 */
            .event-date {
                color: #666;
                font-size: 12px;
            }

            /* イベントがない場合 */
            .no-event {
                grid-column: 1 / -1;
                text-align: center;
                padding: 30px 20px;
                color: #777;
            }

            /* タブレット */
            @media (max-width: 768px) {
                .event-list {
                    grid-template-columns: repeat(2, minmax(0, 1fr));
                }
            }

            /* スマートフォン */
            @media (max-width: 480px) {
                .event-container {
                    padding: 10px;
                }

                .event-list {
                    grid-template-columns: 1fr;
                }

                .event-photo {
                    height: 160px;
                }
            }
        </style>

        <div class="event-container">

            <!-- ヘッダー -->
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

            <!-- イベント一覧 -->
            <div class="event-list">

                <c:choose>

                    <c:when test="${not empty eventList}">

                        <c:forEach var="event" items="${eventList}">

                            <a href="GetEventParticipation.action?event_id=${event.event_id}"
                               class="event-card">

                                <!-- イベント写真 -->
                                <c:choose>

                                    <c:when test="${not empty imageMap[event.event_id]}">

                                        <img
                                            src="${pageContext.request.contextPath}${imageMap[event.event_id][0].url}"
                                            class="event-photo"
                                            alt="イベント写真">

                                    </c:when>

                                    <c:otherwise>

                                        <div class="event-photo">
                                            写真
                                        </div>

                                    </c:otherwise>

                                </c:choose>

                                <!-- イベントタイトル -->
                                <div class="event-title">
                                    <c:out value="${event.title}" />
                                </div>

                                <!-- 開催日時 -->
                                <div class="event-date">
                                    開催日時：
                                    <fmt:formatDate
                                        value="${event.event_date}"
                                        pattern="yyyy年MM月dd日 HH:mm" />
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
