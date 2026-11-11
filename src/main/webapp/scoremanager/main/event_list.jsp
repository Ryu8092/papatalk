<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<c:set var="content">

    <style>
        /* 全体レイアウト */
        .event-container {
            width: 100%;
            padding: 28px;
            background: #fff;
            border-radius: 14px;
            box-shadow: 0 3px 12px rgba(31, 55, 85, .08);
            box-sizing: border-box;
        }

        /* タイトル・ボタン */
        .event-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
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

        .participation-button {
            padding: 10px 20px;
            background: #ed9145;
            border: none;
            border-radius: 8px;
            color: #fff;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: background .2s;
        }

        .participation-button:hover {
            background: #d97c30;
        }

        /* イベント一覧 */
        .event-grid {
            display: grid;
            grid-template-columns: repeat(3, minmax(0, 1fr));
            gap: 18px;
        }

        /* イベントカード */
        .event-card {
            min-width: 0;
            padding: 12px;
            background: #fff;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            box-shadow: 0 2px 7px rgba(31, 55, 85, .06);
            box-sizing: border-box;
            transition: transform .2s, box-shadow .2s;
        }

        .event-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 14px rgba(31, 55, 85, .12);
        }

        /* 写真部分 */
        .event-image {
            width: 100%;
            height: 125px;
            display: flex;
            justify-content: center;
            align-items: center;
            margin-bottom: 13px;
            background: #f4f7fb;
            border: 1px solid #dce4ed;
            border-radius: 8px;
            color: #718096;
            font-size: 13px;
            box-sizing: border-box;
        }

        /* イベント名 */
        .event-name {
            color: #24476b;
            font-size: 17px;
            font-weight: 700;
            margin: 0 0 12px;
            overflow-wrap: anywhere;
        }

        /* イベント情報 */
        .event-info {
            display: grid;
            grid-template-columns: repeat(3, minmax(0, 1fr));
            gap: 9px 6px;
        }

        .event-info-item {
            min-width: 0;
        }

        .event-info-label {
            display: block;
            color: #718096;
            font-size: 11px;
            margin-bottom: 4px;
        }

        .event-info-value {
            display: block;
            color: #334155;
            font-size: 12px;
            font-weight: 600;
            overflow-wrap: anywhere;
        }

        /* イベントがない場合 */
        .empty-message {
            grid-column: 1 / -1;
            padding: 45px 20px;
            text-align: center;
            color: #718096;
            background: #f7f9fc;
            border: 1px dashed #ccd5df;
            border-radius: 10px;
            font-size: 15px;
        }
        /* サイドバーとメイン画面の横並び */
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
		
		/* イベント一覧部分 */
		.event-container {
		    flex: 1;
		    min-width: 0;
		    padding: 28px;
		    background: #fff;
		    border-radius: 14px;
		    box-shadow: 0 3px 12px rgba(31, 55, 85, .08);
		    box-sizing: border-box;
		}

        /* タブレット */
        @media (max-width: 900px) {
            .event-grid {
                grid-template-columns: repeat(2, minmax(0, 1fr));
            }
        }

        /* スマートフォン */
        @media (max-width: 576px) {
            .event-container {
                padding: 18px;
            }

            .event-title {
                font-size: 23px;
            }

            .event-grid {
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
	
	    <div class="event-container">
	
	        <!-- タイトル・参加予定ボタン -->
	        <div class="event-header">
	
	            <h2 class="event-title">イベント一覧</h2>
	
	            <button type="button" class="participation-button">
	                参加予定
	            </button>
	
	        </div>
	
	        <!-- イベント一覧 -->
	        <div class="event-grid">
	
	            <c:choose>
	
	                <c:when test="${empty eventList}">
	                    <div class="empty-message">
	                        現在、参加可能なイベントはありません。
	                    </div>
	                </c:when>
	
	                <c:otherwise>
	
	                    <c:forEach var="event" items="${eventList}">
	
	                        <div class="event-card">
	
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
	                                    <span class="event-info-label">開催場所</span>
	                                    <span class="event-info-value">
	                                        <c:out value="${event.event_place}" />
	                                    </span>
	                                </div>
	
	                                <div class="event-info-item">
	                                    <span class="event-info-label">定員</span>
	                                    <span class="event-info-value">
	                                        <c:out value="${event.capacity}" />人
	                                    </span>
	                                </div>
	
	                                <div class="event-info-item">
	                                    <span class="event-info-label">開催日時</span>
	                                    <span class="event-info-value">
	                                        <c:out value="${event.event_date}" />
	                                    </span>
	                                </div>
	
	                                <div class="event-info-item">
	                                    <span class="event-info-label">締め切り期限</span>
	                                    <span class="event-info-value">
	                                        <c:out value="${event.deadline}" />
	                                    </span>
	                                </div>
	
	                            </div>
	
	                        </div>
	
	                    </c:forEach>
	
	                </c:otherwise>
	
	            </c:choose>
	
	        </div>
	
	    </div>
    </div>

</c:set>

<c:import url="/common/base.jsp">
    <c:param name="title" value="イベント一覧｜パパトークシステム" />
    <c:param name="content" value="${content}" />
</c:import>
