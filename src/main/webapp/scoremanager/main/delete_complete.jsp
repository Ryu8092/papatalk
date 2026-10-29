
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:import url="/common/base.jsp">
    <c:param name="title">パパトークシステム｜アカウント削除完了</c:param>

    <c:param name="scripts">
        <style>
            .steps {
                margin: 20px 0 30px;
                font-size: 14px;
            }

            .complete-icon {
                margin: 20px 0;
                color: #79bd62;
                font-size: 32px;
                font-weight: bold;
                text-align: center;
            }

            .complete-message {
                margin: 15px 0 25px;
                color: #666666;
                font-size: 15px;
                line-height: 1.8;
                text-align: center;
            }

            .complete-buttons {
                margin-top: 25px;
                text-align: center;
            }

            .login-button {
                min-width: 200px;
                padding: 11px 22px;
                border: none;
                border-radius: 7px;
                background-color: #79bd62;
                color: #ffffff;
                font-size: 15px;
                font-weight: bold;
                cursor: pointer;
                transition: background-color 0.2s;
            }

            .login-button:hover {
                background-color: #62a94d;
            }
        </style>
    </c:param>

    <c:param name="content">
        <h2>アカウント削除完了</h2>

        <div class="steps">
            <span style="color: #cccccc;">①削除確認</span>
            <span style="color: #79bd62; margin-left: 15px;">
                ②削除完了
            </span>
        </div>

        <div class="complete-icon">✓</div>

        <h3 style="text-align: center;">
            退会処理が完了しました
        </h3>

        <p class="complete-message">
            パパトークをご利用いただき、ありがとうございました。
        </p>

        <div class="complete-buttons">
            <form action="../Login.action" method="get">
                <button type="submit" class="login-button">
                    ログイン画面へ戻る
                </button>
            </form>
        </div>
    </c:param>
</c:import>
