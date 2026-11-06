<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
 
<c:import url="/common/base.jsp">
    <c:param name="title">新規投稿｜パパトークシステム</c:param>
 
    <c:param name="scripts"></c:param>
 
    <c:param name="content">
 
        <style>
            /* 全体レイアウト */
            .newpost-layout {
                display: flex;
                gap: 24px;
                align-items: flex-start;
                min-height: 70vh;
            }
 
            /* サイドバー */
            .newpost-sidebar {
                flex: 0 0 240px;
                background: #fff;
                border-radius: 14px;
                box-shadow: 0 4px 16px rgba(31,55,85,.08);
                padding: 20px;
            }
 
            /* メイン画面 */
            .newpost-main {
                flex: 1;
                min-width: 0;
                padding: 28px;
                background: #fff;
                border-radius: 14px;
                box-shadow: 0 4px 16px rgba(31,55,85,.08);
            }
 
            /* タイトル */
            .newpost-title {
                color: #24476b;
                font-size: 26px;
                font-weight: 700;
                padding-bottom: 16px;
                border-bottom: 3px solid #ed9145;
                margin-bottom: 16px;
            }
 
            .newpost-description {
                color: #718096;
                font-size: 14px;
                margin-bottom: 28px;
            }
 
            /* 入力フォーム */
            .newpost-form {
                display: flex;
                flex-direction: column;
                gap: 22px;
            }
 
            .form-group {
                display: flex;
                flex-direction: column;
                gap: 8px;
            }
 
            .form-label {
                color: #24476b;
                font-weight: bold;
                font-size: 15px;
            }
 
            .form-input {
                width: 100%;
                box-sizing: border-box;
                padding: 13px;
                border: 1px solid #ccd5df;
                border-radius: 8px;
                font-size: 15px;
                outline: none;
            }
 
            .form-input:focus {
                border-color: #ed9145;
                box-shadow: 0 0 0 2px rgba(237,145,69,.15);
            }
 
            .form-textarea {
                width: 100%;
                min-height: 250px;
                box-sizing: border-box;
                padding: 13px;
                border: 1px solid #ccd5df;
                border-radius: 8px;
                font-size: 15px;
                resize: vertical;
                line-height: 1.7;
                outline: none;
            }
 
            .form-textarea:focus {
                border-color: #ed9145;
                box-shadow: 0 0 0 2px rgba(237,145,69,.15);
            }
 
            /* ボタン */
            .newpost-buttons {
                display: flex;
                justify-content: center;
                gap: 15px;
                margin-top: 10px;
                flex-wrap: wrap;
            }
 
            .submit-button {
                padding: 12px 35px;
                background: #ed9145;
                color: white;
                border: none;
                border-radius: 8px;
                font-size: 16px;
                font-weight: bold;
                cursor: pointer;
            }
 
            .submit-button:hover {
                background: #d97c30;
            }
 
            .back-button {
                display: inline-block;
                padding: 12px 35px;
                background: #718096;
                color: white;
                text-decoration: none;
                border-radius: 8px;
                font-size: 16px;
                font-weight: bold;
            }
 
            .back-button:hover {
                background: #5b6878;
            }
 
            /* 入力エラー */
            .error-message {
                color: #d93025;
                background: #fff0f0;
                padding: 12px;
                border-radius: 6px;
                margin-bottom: 15px;
            }
 
            /* スマホ表示 */
            @media(max-width: 768px) {
                .newpost-layout {
                    flex-direction: column;
                }
 
                .newpost-sidebar {
                    width: 100%;
                    flex-basis: auto;
                    box-sizing: border-box;
                }
 
                .newpost-main {
                    width: 100%;
                    padding: 20px;
                    box-sizing: border-box;
                }
            }
        </style>
 
        <div class="newpost-layout">
 
            <%-- サイドバー --%>
            <aside class="newpost-sidebar">
                <jsp:include page="/common/sidebar.jsp" />
            </aside>
 
            <%-- メイン画面 --%>
            <main class="newpost-main">
 
                <h2 class="newpost-title">新規投稿</h2>
 
                <p class="newpost-description">
                    投稿したい内容を入力してください。
                </p>
 
                <%-- エラーメッセージ --%>
                <c:if test="${not empty errorMessage}">
                    <div class="error-message">
                        <c:out value="${errorMessage}" />
                    </div>
                </c:if>
 
                <%-- 投稿フォーム --%>
                <form class="newpost-form"
                      action="${pageContext.request.contextPath}/scoremanager/main/NewRegistrationRegistration.action"
                      method="post"
                      accept-charset="UTF-8">
 
                    <%-- 投稿タイトル --%>
                    <div class="form-group">
 
                        <label class="form-label" for="title">
                            タイトル
                        </label>
 
                        <input
                            type="text"
                            id="title"
                            name="title"
                            class="form-input"
                            placeholder="投稿タイトルを入力してください"
                            maxlength="100"
                            value="<c:out value='${param.title}'/>"
                            required
                        >
 
                    </div>
 
                    <%-- 投稿内容 --%>
                    <div class="form-group">
 
                        <label class="form-label" for="content">
                            投稿内容
                        </label>
 
                        <textarea
                            id="content"
                            name="content"
                            class="form-textarea"
                            placeholder="投稿内容を入力してください"
                            maxlength="2000"
                            required
                        ><c:out value="${param.content}" /></textarea>
 
                    </div>
 
                    <%-- ボタン --%>
                    <div class="newpost-buttons">
 
                        <button type="submit" class="submit-button">
                            投稿する
                        </button>
 
                        <a
                            href="${pageContext.request.contextPath}/scoremanager/main/RetrievePosts.action"
                            class="back-button">
                            戻る
                        </a>
 
                    </div>
 
                </form>
 
            </main>
 
        </div>
 
    </c:param>
</c:import>