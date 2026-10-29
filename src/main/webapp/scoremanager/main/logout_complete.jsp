<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:import url="/common/base.jsp">
    <c:param name="title">パパトーク｜ログアウト完了</c:param>
    <c:param name="scripts"></c:param>

    <c:param name="content">
        <style>
            .logout-complete-page {
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 65vh;
                padding: 30px 16px;
            }

            .logout-complete-card {
                width: 100%;
                max-width: 480px;
                padding: 42px 30px;
                text-align: center;
                background: #ffffff;
                border-radius: 20px;
                box-shadow: 0 8px 30px rgba(36, 71, 107, 0.12);
            }

            .complete-icon {
                display: flex;
                justify-content: center;
                align-items: center;
                width: 82px;
                height: 82px;
                margin: 0 auto 24px;
                border-radius: 26px;
                background: #eaf5ed;
                color: #39845a;
                font-size: 42px;
            }

            .complete-title {
                margin-bottom: 16px;
                color: #24476b;
                font-size: 26px;
                font-weight: 800;
            }

            .complete-message {
                margin-bottom: 30px;
                color: #718096;
                font-size: 15px;
                line-height: 1.9;
            }

            .complete-login-button {
                display: inline-block;
                width: 100%;
                padding: 14px 20px;
                border: none;
                border-radius: 11px;
                background: #ed9145;
                color: #ffffff;
                font-size: 16px;
                font-weight: 700;
                text-decoration: none;
                transition: background 0.2s;
            }

            .complete-login-button:hover {
                background: #d97b2e;
                color: #ffffff;
            }

            .complete-brand {
                margin-top: 24px;
                color: #8a9bad;
                font-size: 13px;
            }
        </style>

        <div class="logout-complete-page">
            <div class="logout-complete-card">

                <div class="complete-icon" aria-hidden="true">
                    ✓
                </div>

                <h2 class="complete-title">
                    ログアウトしました
                </h2>

                <p class="complete-message">
                    ぱぱトークをご利用いただき、<br>
                    ありがとうございました。<br>
                    またのご利用をお待ちしています。
                </p>

                <c:url
                    value="/scoremanager/Login.action"
                    var="url_login" />

                <a href="${url_login}"
                    class="complete-login-button">
                    ログイン画面に戻る →
                </a>

                <div class="complete-brand">
                    ぱぱトーク｜つながる、話せる、支え合える。
                </div>

            </div>
        </div>
    </c:param>
</c:import>
