<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
 
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
 
        /* 写真部分 */
        .event-image {
            width: 100%;
            height: 220px;
            display: flex;
            justify-content: center;
            align-items: center;
            margin-bottom: 20px;
            background: #f4f7fb;
            border: 1px solid #dce4ed;
            border-radius: 8px;
            color: #718096;
            font-size: 15px;
            box-sizing: border-box;
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
        }
 
        .event-details-label {
            display: block;
            color: #718096;
            font-size: 14px;
            margin-bottom: 10px;
        }
 
        .event-details-value {
            min-height: 120px;
            padding: 15px;
            background: #f7f9fc;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            color: #334155;
            font-size: 15px;
            line-height: 1.8;
            white-space: pre-wrap;
            overflow-wrap: anywhere;
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
 
        .back-button {
            background: #718096;
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
            .event-container {
                padding: 18px;
            }
 
            .event-title {
                font-size: 23px;
            }
 
            .event-info {
                grid-template-columns: 1fr;
            }
 
            .event-image {
                height: 170px;
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
 
                        <!-- 写真 -->
                        <div class="event-image">
                            写真
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
                                    <c:out value="${event.event_date}" />
                                </span>
                            </div>
 
                            <div class="event-info-item">
                                <span class="event-info-label">
                                    申し込み締め切り
                                </span>
                                <span class="event-info-value">
                                    <c:out value="${event.deadline}" />
                                </span>
                            </div>
 
                        </div>
 
                        <!-- イベント内容 -->
                        <div class="event-details-area">
                            <span class="event-details-label">
                                イベント内容
                            </span>
                            <div class="event-details-value">
                                <c:out value="${event.event_details}" />
                            </div>
                        </div>
 
                        <!-- ボタン -->
                        <div class="event-buttons">
 
                            <!-- 締め切り日まで参加ボタンを表示 -->
                            <c:if test="${canApply}">
                                <a href="<c:url value='/scoremanager/main/ReferenceConfirmationDisplay.action'/>?event_id=${event.event_id}"
                                   class="participation-button">
                                    参加する
                                </a>
                            </c:if>
 
                            <!-- 戻るボタン -->
                            <a href="<c:url value='/scoremanager/main/RetrieveEvents.action'/>"
                               class="back-button">
                                戻る
                            </a>
 
                        </div>
 
                    </div>
 
                </c:otherwise>
 
            </c:choose>
 
        </div>
    </div>
 
</c:set>
 
<c:import url="/common/base.jsp">
    <c:param name="title" value="イベント詳細｜パパトークシステム" />
    <c:param name="content" value="${content}" />
</c:import>
 