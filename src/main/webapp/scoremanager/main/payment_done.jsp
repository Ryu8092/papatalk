<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
 
<c:import url="/common/base.jsp">
    <c:param name="title">パパトークシステム</c:param>
    <c:param name="scripts"></c:param>
    <c:param name="content">
 
        <style>
            .done-layout {
                display: flex;
                gap: 24px;
                align-items: flex-start;
                min-height: 70vh;
            }
 
            .done-sidebar {
                flex: 0 0 240px;
                background: #fff;
                border-radius: 14px;
                box-shadow: 0 4px 16px rgba(31, 55, 85, .08);
                padding: 20px;
            }
 
            .done-main {
                flex: 1;
                min-width: 0;
                min-height: 530px;
                padding: 28px;
                background: #fff;
                border-radius: 14px;
                box-shadow: 0 4px 16px rgba(31, 55, 85, .08);
                box-sizing: border-box;
                text-align: center;
            }
 
            .done-title {
                color: #24476b;
                font-size: 26px;
                font-weight: 700;
                padding-bottom: 16px;
                border-bottom: 3px solid #ed9145;
                margin: 0;
            }
 
            .done-message {
                margin-top: 120px;
                font-size: 24px;
                font-weight: bold;
                color: #24476b;
            }
 
            .done-button {
                display: inline-block;
                margin-top: 60px;
                padding: 12px 35px;
                background: #ed9145;
                border-radius: 25px;
                color: #fff;
                text-decoration: none;
                font-weight: bold;
                transition: background .2s;
            }
 
            .done-button:hover {
                background: #d97c30;
            }
 
            @media (max-width: 768px) {
                .done-layout {
                    flex-direction: column;
                }
 
                .done-sidebar {
                    width: 100%;
                    flex-basis: auto;
                    box-sizing: border-box;
                }
 
                .done-main {
                    width: 100%;
                    padding: 20px;
                }
            }
        </style>
 
        <div class="done-layout">
 
            <aside class="done-sidebar">
                <jsp:include page="/common/sidebar.jsp" />
            </aside>
 
            <main class="done-main">
 
                <h2 class="done-title">お支払い完了</h2>
 
                <p class="done-message">
                    お支払いが完了しました。
                </p>
 
                <a class="done-button"
                   href="${pageContext.request.contextPath}/scoremanager/main/MatchList.action">
                    ホームへ戻る
                </a>
 
            </main>
 
        </div>
 
    </c:param>
</c:import>
 