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
 
        /* 参加確認画面 */
        .confirmation-container {
            width: 100%;
            max-width: 700px;
            min-height: 390px;
            margin: 0 auto;
            padding: 30px;
            background: #fff;
            border: 1px solid #e2e8f0;
            border-top: 4px solid #ed9145;
            border-radius: 14px;
            box-shadow: 0 3px 12px rgba(31, 55, 85, .08);
            box-sizing: border-box;
            text-align: center;
        }
 
        /* イベント名 */
        .confirmation-title {
            margin: 0 0 15px;
            color: #24476b;
            font-size: 24px;
            font-weight: 700;
            overflow-wrap: anywhere;
        }
 
        /* エラーメッセージ */
        .error-message {
            margin: 0 0 20px;
            color: #e53935;
            font-size: 15px;
            font-weight: bold;
        }
 
        /* 開催日時 */
        .confirmation-date {
            display: inline-block;
            margin-bottom: 40px;
            padding: 10px 25px;
            background: #f7f9fc;
            border-radius: 8px;
            color: #334155;
            font-size: 17px;
        }
 
        /* 入力部分 */
        .confirmation-form {
            width: 350px;
            max-width: 100%;
            margin: 0 auto;
            text-align: left;
        }
 
        .input-group {
            margin-bottom: 18px;
        }
 
        .input-group label {
            display: block;
            margin-bottom: 5px;
            color: #334155;
            font-size: 13px;
            font-weight: 600;
        }
 
        .input-group input {
            width: 100%;
            height: 38px;
            border: 1px solid #cbd5e1;
            border-radius: 6px;
            padding: 4px 10px;
            box-sizing: border-box;
            font-size: 15px;
        }
 
        /* ボタン */
        .confirmation-buttons {
            display: flex;
            justify-content: center;
            gap: 60px;
            margin-top: 55px;
        }
 
        .confirmation-buttons a,
        .confirmation-buttons button {
            width: 110px;
            height: 43px;
            display: flex;
            justify-content: center;
            align-items: center;
            border: none;
            border-radius: 8px;
            background: #718096;
            color: #fff;
            text-decoration: none;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            box-sizing: border-box;
        }
 
        .confirmation-buttons button {
            background: #ed9145;
        }
 
        .confirmation-buttons a:hover {
            background: #5b687a;
        }
 
        .confirmation-buttons button:hover {
            background: #d97c30;
        }
 
        /* スマートフォン */
        @media (max-width: 576px) {
            .event-container {
                padding: 18px;
            }
 
            .confirmation-container {
                padding: 20px 15px;
            }
 
            .confirmation-buttons {
                gap: 25px;
            }
        }
    </style>
 
    <div class="event-page-layout">
 
        <!-- サイドバー -->
        <aside class="event-sidebar">
            <jsp:include page="/common/sidebar.jsp" />
        </aside>
 
        <!-- 参加確認画面 -->
        <div class="event-container">
 
            <div class="confirmation-container">
 
                <!-- イベント名 -->
                <h2 class="confirmation-title">
                    <c:out value="${event.title}" />
                </h2>
 
                <!-- エラーメッセージ -->
                <c:if test="${not empty errorMessage}">
                    <p class="error-message">
                        <c:out value="${errorMessage}" />
                    </p>
                </c:if>
 
                <!-- 開催日時 -->
                <div class="confirmation-date">
                    <c:out value="${event.event_date}" />
                </div>
 
                <form class="confirmation-form"
                    action="<c:url value='/scoremanager/main/ParticipationRegistration.action'/>"
                    method="post">
 
                    <input type="hidden" name="event_id"
                        value="${event.event_id}">
 
                    <!-- 大人 -->
                    <div class="input-group">
                        <label for="adultnumber">大人</label>
                        <input type="number" id="adultnumber"
                            name="adultnumber" min="0" value="0" required>
                    </div>
 
                    <!-- 子供 -->
                    <div class="input-group">
                        <label for="childnumber">子供</label>
                        <input type="number" id="childnumber"
                            name="childnumber" min="0" value="0" required>
                    </div>
 
                    <!-- ボタン -->
                    <div class="confirmation-buttons">
 
                        <a href="<c:url value='/scoremanager/main/GetEventDetails.action'/>?event_id=${event.event_id}">
                            戻る
                        </a>
 
                        <button type="submit">
                            予約する
                        </button>
 
                    </div>
                </form>
 
            </div>
        </div>
    </div>
 
</c:set>
 
<c:import url="/common/base.jsp">
    <c:param name="title" value="参加確認｜パパトークシステム" />
    <c:param name="content" value="${content}" />
</c:import>
 