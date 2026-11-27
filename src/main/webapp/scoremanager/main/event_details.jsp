
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<c:set var="content">

    <style>
        /* 全体レイアウト */
        .event-page-layout {
            display: flex;
            gap: 24px;
            align-items: flex-start;
            width: 100%;
        }

        /* サイドバー */
        .event-sidebar {
            flex: 0 0 240px;
            background: #fff;
            border-radius: 14px;
            padding: 20px;
            box-shadow: 0 3px 12px rgba(31, 55, 85, .08);
            box-sizing: border-box;
        }

        /* イベント詳細部分 */
        .event-container {
            flex: 1;
            min-width: 0;
            padding: 28px;
            background: #fff;
            border-radius: 14px;
            box-shadow: 0 3px 12px rgba(31, 55, 85, .08);
            box-sizing: border-box;
        }

        /* タイトル */
        .event-header {
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 3px solid #ed9145;
        }

        .event-title {
            color: #24476b;
            font-size: 27px;
            font-weight: 700;
            margin: 0;
        }

        /* 詳細カード */
        .event-detail-card {
            padding: 20px;
            background: #fff;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            box-shadow: 0 2px 7px rgba(31, 55, 85, .06);
            box-sizing: border-box;
        }

        /* 写真ギャラリー */
        .event-image-gallery {
            position: relative;
            width: 100%;
            height: 300px;
            margin-bottom: 20px;
            background: #f4f7fb;
            border: 1px solid #dce4ed;
            border-radius: 8px;
            overflow: hidden;
            box-sizing: border-box;
        }

        .gallery-image {
            display: none;
            width: 100%;
            height: 100%;
            object-fit: contain;
        }

        .gallery-image.active {
            display: block;
        }

        /* 写真切り替えボタン */
        .gallery-button {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            width: 40px;
            height: 40px;
            border: none;
            border-radius: 50%;
            background: rgba(36, 71, 107, 0.8);
            color: #fff;
            font-size: 24px;
            cursor: pointer;
            z-index: 2;
            transition: background .2s;
        }

        .gallery-button:hover {
            background: #ed9145;
        }

        .gallery-prev {
            left: 12px;
        }

        .gallery-next {
            right: 12px;
        }

        /* 写真枚数 */
        .gallery-counter {
            position: absolute;
            bottom: 10px;
            left: 50%;
            transform: translateX(-50%);
            padding: 5px 12px;
            background: rgba(36, 71, 107, 0.8);
            color: #fff;
            border-radius: 15px;
            font-size: 12px;
        }

        /* イベント名 */
        .event-name {
            color: #24476b;
            font-size: 24px;
            font-weight: 700;
            margin: 0 0 25px;
            overflow-wrap: anywhere;
        }

        /* イベント情報 */
        .event-info {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 18px;
            margin-bottom: 25px;
        }

        .event-info-item {
            min-width: 0;
            padding: 15px;
            background: #f7f9fc;
            border-radius: 8px;
        }

        .event-info-label {
            display: block;
            color: #718096;
            font-size: 13px;
            margin-bottom: 8px;
        }

        .event-info-value {
            display: block;
            color: #334155;
            font-size: 15px;
            font-weight: 600;
            overflow-wrap: anywhere;
        }

        /* イベント内容 */
        .event-details-area {
            margin-top: 10px;
            width: 100%;
        }

        .event-details-label {
            display: block;
            color: #718096;
            font-size: 14px;
            font-weight: 600;
            margin-bottom: 10px;
        }

        .event-details-value {
            display: block;
            width: 100%;
            min-height: 120px;
            padding: 15px;
            background: #f7f9fc;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            color: #334155;
            font-size: 15px;
            line-height: 1.8;

            /* 左上から表示 */
            text-align: left;
            vertical-align: top;

            /* 改行を維持 */
            white-space: pre-wrap;

            /* 長い文字列も枠内で折り返す */
            overflow-wrap: anywhere;
            word-break: normal;

            box-sizing: border-box;
        }

        /* ボタン */
        .event-buttons {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-top: 30px;
        }

        .participation-button,
        .back-button {
            display: inline-block;
            padding: 12px 35px;
            border-radius: 8px;
            text-decoration: none;
            font-size: 15px;
            font-weight: 600;
            text-align: center;
        }

        .participation-button {
            background: #ed9145;
            color: #fff;
        }

        .participation-button:hover {
            background: #d77a2e;
            color: #fff;
        }

        .back-button {
            background: #718096;
            color: #fff;
        }

        .back-button:hover {
            background: #526174;
            color: #fff;
        }

        /* イベントがない場合 */
        .empty-message {
            padding: 45px 20px;
            text-align: center;
            color: #718096;
            background: #f7f9fc;
            border: 1px dashed #ccd5df;
            border-radius: 10px;
            font-size: 15px;
        }

        /* スマートフォン */
        @media (max-width: 576px) {
            .event-page-layout {
                flex-direction: column;
            }

            .event-sidebar {
                width: 100%;
                flex-basis: auto;
            }

            .event-container {
                width: 100%;
                padding: 18px;
            }

            .event-title {
                font-size: 23px;
            }

            .event-info {
                grid-template-columns: 1fr;
            }

            .event-image-gallery {
                height: 170px;
            }

            .event-buttons {
                flex-wrap: wrap;
            }
        }
    </style>

    <div class="event-page-layout">

        <!-- サイドバー -->
        <aside class="event-sidebar">
            <jsp:include page="/common/sidebar.jsp" />
        </aside>

        <!-- イベント詳細 -->
        <div class="event-container">

            <div class="event-header">
                <h2 class="event-title">イベント詳細</h2>
            </div>

            <c:choose>

                <c:when test="${empty event}">
                    <div class="empty-message">
                        イベント情報が見つかりません。
                    </div>
                </c:when>

                <c:otherwise>

                    <div class="event-detail-card">

                        <!-- 写真ギャラリー -->
                        <div class="event-image-gallery">

                            <c:choose>

                                <c:when test="${not empty imageList}">

                                    <c:forEach var="image"
                                        items="${imageList}"
                                        varStatus="status">

                                        <img
                                            src="${pageContext.request.contextPath}${image.url}"
                                            class="gallery-image ${status.first ? 'active' : ''}"
                                            alt="イベント写真">

                                    </c:forEach>

                                    <!-- 写真が2枚以上の場合 -->
                                    <c:if test="${fn:length(imageList) > 1}">

                                        <button type="button"
                                            class="gallery-button gallery-prev"
                                            onclick="changeEventImage(-1)">
                                            &#10094;
                                        </button>

                                        <button type="button"
                                            class="gallery-button gallery-next"
                                            onclick="changeEventImage(1)">
                                            &#10095;
                                        </button>

                                        <div class="gallery-counter">
                                            <span id="currentImage">1</span>
                                            /
                                            <span id="totalImages">${fn:length(imageList)}</span>
                                        </div>

                                    </c:if>

                                </c:when>

                                <c:otherwise>

                                    <div style="
                                        display: flex;
                                        justify-content: center;
                                        align-items: center;
                                        height: 100%;
                                        color: #718096;">
                                        写真はありません
                                    </div>

                                </c:otherwise>

                            </c:choose>

                        </div>

                        <!-- イベント名 -->
                        <h3 class="event-name">
                            <c:out value="${event.title}" />
                        </h3>

                        <!-- イベント情報 -->
                        <div class="event-info">

                            <div class="event-info-item">
                                <span class="event-info-label">
                                    開催場所
                                </span>
                                <span class="event-info-value">
                                    <c:out value="${event.event_place}" />
                                </span>
                            </div>

                            <div class="event-info-item">
                                <span class="event-info-label">
                                    定員
                                </span>
                                <span class="event-info-value">
                                    <c:out value="${event.capacity}" />人
                                </span>
                            </div>

                            <div class="event-info-item">
                                <span class="event-info-label">
                                    開催日
                                </span>
                                <span class="event-info-value">
                                    <fmt:formatDate
                                        value="${event.event_date}"
                                        pattern="yyyy年MM月dd日 HH:mm" />
                                </span>
                            </div>

                            <div class="event-info-item">
                                <span class="event-info-label">
                                    申し込み締め切り
                                </span>
                                <span class="event-info-value">
                                    <fmt:formatDate
                                        value="${event.deadline}"
                                        pattern="yyyy年MM月dd日" />
                                </span>
                            </div>

                        </div>

                        <!-- イベント内容 -->
                        <div class="event-details-area">

                            <span class="event-details-label">
                                イベント内容
                            </span>

                            <div class="event-details-value"><c:out value="${event.event_details}" /></div>

                        </div>

                       <!-- ボタン -->
						<div class="event-buttons">
						
						    <!-- 戻るボタン -->
						    <form action="<c:url value='/scoremanager/main/RetrieveEvents.action'/>"
						          method="get">
						
						        <button type="submit" class="back-button">
						            戻る
						        </button>
						
						    </form>
						
						    <!-- 参加するボタン -->
						    <c:if test="${canApply}">
						
						        <form action="<c:url value='/scoremanager/main/ReferenceConfirmationDisplay.action'/>"
						              method="get">
						
						            <input type="hidden"
						                   name="event_id"
						                   value="${event.event_id}">
						
						            <button type="submit" class="participation-button">
						                参加する
						            </button>
						
						        </form>
						
						    </c:if>
						
						</div>

                    </div>

                </c:otherwise>

            </c:choose>

        </div>
    </div>

    <!-- 写真切り替え処理 -->
    <script>
        let currentImageIndex = 0;

        function changeEventImage(direction) {

            const images = document.querySelectorAll(".gallery-image");

            if (images.length <= 1) {
                return;
            }

            images[currentImageIndex].classList.remove("active");

            currentImageIndex += direction;

            if (currentImageIndex >= images.length) {
                currentImageIndex = 0;
            }

            if (currentImageIndex < 0) {
                currentImageIndex = images.length - 1;
            }

            images[currentImageIndex].classList.add("active");

            document.getElementById("currentImage").textContent =
                currentImageIndex + 1;
        }
    </script>

</c:set>

<c:import url="/common/base.jsp">
    <c:param name="title" value="イベント詳細｜パパトークシステム" />
    <c:param name="content" value="${content}" />
</c:import>
