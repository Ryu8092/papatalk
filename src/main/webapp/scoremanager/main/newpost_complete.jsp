<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
 
<c:import url="/common/base.jsp">
    <c:param name="title">投稿完了｜パパトークシステム</c:param>
 
    <c:param name="scripts"></c:param>
 
    <c:param name="content">
 
        <style>
            /* 全体レイアウト */
            .complete-layout {
                display: flex;
                gap: 24px;
                align-items: flex-start;
                min-height: 70vh;
            }
 
            /* サイドバー */
            .complete-sidebar {
                flex: 0 0 240px;
                background: #fff;
                border-radius: 14px;
                box-shadow: 0 4px 16px rgba(31,55,85,.08);
                padding: 20px;
            }
 
            /* メイン画面 */
            .complete-main {
                flex: 1;
                min-width: 0;
                min-height: 400px;
                padding: 28px;
                background: #fff;
                border-radius: 14px;
                box-shadow: 0 4px 16px rgba(31,55,85,.08);
 
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                text-align: center;
            }
 
            /* 完了アイコン */
            .complete-icon {
                width: 80px;
                height: 80px;
                border-radius: 50%;
                background: #e5f6e9;
                color: #36a653;
                font-size: 48px;
                font-weight: bold;
 
                display: flex;
                justify-content: center;
                align-items: center;
 
                margin-bottom: 25px;
            }
 
            /* 見出し */
            .complete-title {
                color: #24476b;
                font-size: 28px;
                font-weight: 700;
                margin-bottom: 18px;
            }
 
            /* 説明 */
            .complete-message {
                color: #718096;
                font-size: 16px;
                line-height: 1.8;
                margin-bottom: 35px;
            }
 
            /* ボタン */
            .complete-button {
                display: inline-block;
                padding: 13px 35px;
                background: #ed9145;
                color: white;
                text-decoration: none;
                border-radius: 8px;
                font-size: 16px;
                font-weight: bold;
                transition: background .2s;
            }
 
            .complete-button:hover {
                background: #d97c30;
            }
 
            /* スマホ表示 */
            @media(max-width: 768px) {
                .complete-layout {
                    flex-direction: column;
                }
 
                .complete-sidebar {
                    width: 100%;
                    flex-basis: auto;
                    box-sizing: border-box;
                }
 
                .complete-main {
                    width: 100%;
                    min-height: 350px;
                    padding: 20px;
                    box-sizing: border-box;
                }
            }
        </style>
 
        <div class="complete-layout">
 
            <%-- サイドバー --%>
            <aside class="complete-sidebar">
                <jsp:include page="/common/sidebar.jsp" />
            </aside>
 
            <%-- 投稿完了画面 --%>
            <main class="complete-main">
 
                <div class="complete-icon">
                    ✓
                </div>
 
                <h2 class="complete-title">
                    投稿完了！
                </h2>
 
                <p class="complete-message">
                    投稿が正常に完了しました。<br>
                    たくさんの人と交流してみましょう！
                </p>
 
                <%-- 掲示板に戻る --%>
                <a
                    href="${pageContext.request.contextPath}/scoremanager/main/RetrievePosts.action"
                    class="complete-button">
                    掲示板に戻る
                </a>
 
            </main>
 
        </div>
 
    </c:param>
</c:import>