
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<c:import url="/common/base.jsp">
<<<<<<< HEAD

    <c:param name="title">
        パパトークシステム｜イベント一覧
    </c:param>
=======
    <c:param name="title">イベント一覧</c:param>
>>>>>>> refs/remotes/origin/master

    <c:param name="content">

        <style>
            /* 画面全体 */
<<<<<<< HEAD
            .event-page {
                width: 100%;
                min-height: 75vh;
                padding: 30px 20px;
                box-sizing: border-box;
                background-color: #f1ebdd;
                font-family: "Yu Gothic", "Meiryo", sans-serif;
                letter-spacing: 0.05em;
=======
            .event-container {
                max-width: 1100px;
                margin: 0 auto;
                padding: 15px 20px;
                box-sizing: border-box;
>>>>>>> refs/remotes/origin/master
            }

<<<<<<< HEAD
            .event-container {
                width: 100%;
                max-width: 1100px;
                min-height: 500px;
                margin: 0 auto;
                padding: 25px 35px 30px;
                box-sizing: border-box;
                background-color: #fffdf8;
                border: 1px solid #d8ccb4;
                border-radius: 5px;
                box-shadow: 0 4px 12px rgba(50, 40, 20, 0.08);
            }

            /* タイトル */
            .event-title-heading {
                text-align: center;
                color: #292c29;
                font-size: 28px;
                font-weight: bold;
                margin: 5px 0 25px;
            }

            .event-line {
                border: none;
                border-top: 2px solid #b49a65;
                margin-bottom: 25px;
            }

=======
>>>>>>> refs/remotes/origin/master
            /* ヘッダー */
            .event-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
<<<<<<< HEAD
                gap: 15px;
                margin-bottom: 25px;
=======
                margin-bottom: 15px;
>>>>>>> refs/remotes/origin/master
            }

<<<<<<< HEAD
            /* 共通ボタン */
            .event-back-button,
=======
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
>>>>>>> refs/remotes/origin/master
            .event-post-button {
<<<<<<< HEAD
                min-width: 110px;
                padding: 10px 20px;
                border-radius: 4px;
                font-size: 14px;
                letter-spacing: 0.08em;
                cursor: pointer;
                transition: 0.2s;
=======
                background-color: #4caf50;
                color: white;
                padding: 8px 18px;
                border-radius: 6px;
                text-decoration: none;
                font-size: 14px;
>>>>>>> refs/remotes/origin/master
            }

<<<<<<< HEAD
            /* 戻るボタン */
            .event-back-button {
                background-color: #292c29;
                color: #fffdf8;
                border: 1px solid #292c29;
            }

            .event-back-button:hover {
                background-color: #55584f;
            }

            /* イベント投稿ボタン */
            .event-post-button {
                background-color: #b49a65;
                color: #fffdf8;
                border: 1px solid #b49a65;
            }

=======
>>>>>>> refs/remotes/origin/master
            .event-post-button:hover {
                background-color: #967d4d;
                border-color: #967d4d;
            }

            /* イベント一覧 */
            .event-list {
                display: grid;
                grid-template-columns: repeat(3, minmax(0, 1fr));
<<<<<<< HEAD
                gap: 20px;
=======
                gap: 15px;
>>>>>>> refs/remotes/origin/master
            }

            /* イベントカード */
            .event-card {
                display: block;
<<<<<<< HEAD
                min-width: 0;
                padding: 12px;
                box-sizing: border-box;
                background-color: #fffdf8;
                border: 1px solid #d8ccb4;
                border-top: 4px solid #b49a65;
                border-radius: 5px;
                color: #292c29;
=======
                border: 1px solid #ddd;
                border-radius: 10px;
                padding: 10px;
                background-color: white;
                text-decoration: none;
                color: black;
                min-width: 0;
                box-sizing: border-box;
>>>>>>> refs/remotes/origin/master
                transition: transform 0.2s, box-shadow 0.2s;
            }

            .event-card:hover {
                transform: translateY(-3px);
<<<<<<< HEAD
                box-shadow: 0 4px 10px rgba(50, 40, 20, 0.12);
                background-color: #fdfaf2;
=======
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.12);
>>>>>>> refs/remotes/origin/master
            }

            /* イベント写真 */
            .event-photo {
                width: 100%;
<<<<<<< HEAD
                height: 150px;
=======
                height: 130px;
>>>>>>> refs/remotes/origin/master
                object-fit: cover;
<<<<<<< HEAD
                border-radius: 4px;
                display: block;
                background-color: #eee8da;
=======
                border-radius: 8px;
                display: block;
>>>>>>> refs/remotes/origin/master
            }

            /* 写真がない場合 */
            div.event-photo {
<<<<<<< HEAD
                color: #8b806d;
=======
                background-color: #eee;
                color: #888;
>>>>>>> refs/remotes/origin/master
                display: flex;
                justify-content: center;
                align-items: center;
                font-size: 14px;
                border: 1px dashed #d8ccb4;
            }

            /* イベントタイトル */
<<<<<<< HEAD
            .event-card-title {
                font-size: 16px;
                font-weight: bold;
                color: #292c29;
                margin: 12px 0 10px;
                overflow-wrap: anywhere;
            }

            /* 開催日時 */
            .event-date {
                color: #81765f;
                font-size: 13px;
                line-height: 1.7;
=======
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
>>>>>>> refs/remotes/origin/master
            }

            /* イベントがない場合 */
            .no-event {
                grid-column: 1 / -1;
                text-align: center;
<<<<<<< HEAD
                padding: 45px 20px;
                color: #8b806d;
                background-color: #f7f3ea;
                border: 1px dashed #d8ccb4;
                border-radius: 4px;
            }

            /* フォーム */
            .event-header form {
                margin: 0;
            }

            /* タブレット */
            @media (max-width: 768px) {
                .event-container {
                    padding: 20px 15px 25px;
                }

                .event-list {
                    grid-template-columns: repeat(2, minmax(0, 1fr));
                }

                .event-title-heading {
                    font-size: 24px;
                }
            }

            /* スマートフォン */
            @media (max-width: 480px) {
                .event-page {
                    padding: 15px 10px;
                }

                .event-container {
                    padding: 15px 12px 25px;
                }

                .event-list {
                    grid-template-columns: 1fr;
                }

                .event-header {
                    gap: 10px;
                }

                .event-back-button,
                .event-post-button {
                    min-width: 0;
                    padding: 9px 14px;
                    font-size: 12px;
                }

                .event-photo {
                    height: 160px;
                }

                .event-title-heading {
                    font-size: 21px;
                }
=======
                padding: 30px 20px;
                color: #777;
>>>>>>> refs/remotes/origin/master
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

<<<<<<< HEAD
        <div class="event-page">

            <div class="event-container">

                <!-- タイトル -->
                <h1 class="event-title-heading">
                    イベント一覧
                </h1>

                <hr class="event-line">

                <!-- ヘッダー -->
                <div class="event-header">

                    <!-- 管理画面に戻る -->
                    <form action="/papatalk/scoremanager/main/ManagementScreen.action"
                          method="get">

                        <button type="submit"
                                class="event-back-button">
                            戻る
                        </button>

                    </form>

                    <!-- イベント投稿 -->
                    <form action="/papatalk/scoremanager/main/EventInputdisplay.action"
                          method="get">

                        <button type="submit"
                                class="event-post-button">
                            イベント投稿
                        </button>

                    </form>

                </div>

                <!-- イベント一覧 -->
                <div class="event-list">

                    <c:choose>

                        <c:when test="${not empty eventList}">

                            <c:forEach var="event" items="${eventList}">

                                <!-- イベントカード -->
                                <div class="event-card">

                                    <!-- 詳細画面への遷移 -->
                                    <form action="/papatalk/scoremanager/main/GetEventParticipation.action"
                                          method="get">

                                        <input type="hidden"
                                               name="event_id"
                                               value="${event.event_id}">

                                        <button type="submit"
                                                style="display:block; width:100%; padding:0; border:none; background:transparent; text-align:left; cursor:pointer; font-family:inherit;">

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
                                            <div class="event-card-title">
                                                <c:out value="${event.title}" />
                                            </div>

                                            <!-- 開催日時 -->
                                            <div class="event-date">

                                                開催日時：

                                                <fmt:formatDate
                                                    value="${event.event_date}"
                                                    pattern="yyyy年MM月dd日 HH時mm分" />

                                            </div>

                                        </button>

                                    </form>

=======
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
>>>>>>> refs/remotes/origin/master
                                </div>

<<<<<<< HEAD
                            </c:forEach>

                        </c:when>

                        <c:otherwise>

                            <div class="no-event">
                                現在、開催予定のイベントはありません。
                            </div>

                        </c:otherwise>

                    </c:choose>

                </div>
=======
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
>>>>>>> refs/remotes/origin/master

            </div>

        </div>

    </c:param>
<<<<<<< HEAD

=======
>>>>>>> refs/remotes/origin/master
</c:import>
