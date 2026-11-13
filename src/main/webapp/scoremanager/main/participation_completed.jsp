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
 
        /* メイン画面 */
        .event-container {
            flex: 1;
            min-width: 0;
            padding: 28px;
            background: #fff;
            border-radius: 14px;
            box-shadow: 0 3px 12px rgba(31, 55, 85, .08);
            box-sizing: border-box;
        }
 
        /* 予約完了画面 */
        .completed-container {
            width: 100%;
            max-width: 700px;
            min-height: 390px;
            margin: 0 auto;
            padding: 50px 30px;
            background: #fff;
            border: 1px solid #e2e8f0;
            border-top: 4px solid #ed9145;
            border-radius: 14px;
            box-shadow: 0 3px 12px rgba(31, 55, 85, .08);
            box-sizing: border-box;
            text-align: center;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }
 
        /* 完了マーク */
        .completed-mark {
            width: 75px;
            height: 75px;
            margin-bottom: 25px;
            border-radius: 50%;
            background: #fff1e5;
            color: #ed9145;
            font-size: 42px;
            font-weight: bold;
            line-height: 75px;
        }
 
        /* タイトル */
        .completed-title {
            margin: 0 0 18px;
            color: #24476b;
            font-size: 25px;
            font-weight: 700;
        }
 
        /* メッセージ */
        .completed-message {
            margin: 0;
            color: #64748b;
            font-size: 16px;
            line-height: 1.8;
        }
 
        /* 戻るボタン */
        .completed-button {
            display: flex;
            justify-content: center;
            align-items: center;
            width: 180px;
            height: 45px;
            margin-top: 40px;
            border-radius: 8px;
            background: #ed9145;
            color: #fff;
            text-decoration: none;
            font-size: 14px;
            font-weight: 600;
        }
 
        .completed-button:hover {
            background: #d97c30;
        }
 
        /* スマートフォン */
        @media (max-width: 576px) {
            .event-container {
                padding: 18px;
            }
 
            .completed-container {
                padding: 35px 15px;
            }
 
            .completed-title {
                font-size: 21px;
            }
        }
    </style>
 
    <div class="event-page-layout">
 
        <!-- サイドバー -->
        <aside class="event-sidebar">
            <jsp:include page="/common/sidebar.jsp" />
        </aside>
 
        <!-- 予約完了画面 -->
        <div class="event-container">
 
            <div class="completed-container">
 
                <div class="completed-mark">
                    ✓
                </div>
 
                <h2 class="completed-title">
                    予約が完了しました
                </h2>
 
                <p class="completed-message">
                    イベントへの参加予約を受け付けました。<br>
                    ご予約ありがとうございます。
                </p>
 
                <a href="<c:url value='/scoremanager/main/RetrieveEvents.action'/>"
                    class="completed-button">
                    イベント一覧へ戻る
                </a>
 
            </div>
 
        </div>
 
    </div>
 
</c:set>
 
<c:import url="/common/base.jsp">
    <c:param name="title" value="予約完了｜パパトークシステム" />
    <c:param name="content" value="${content}" />
</c:import>
 