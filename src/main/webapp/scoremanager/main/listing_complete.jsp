
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:import url="/common/base.jsp">
    <c:param name="title">パパトークシステム｜商品登録完了</c:param>
    <c:param name="content">
        <style>
            .matching-layout {
                display: flex;
                gap: 24px;
                min-height: 70vh;
                align-items: flex-start;
            }

            .matching-sidebar {
                width: 240px;
                flex-shrink: 0;
            }

            .matching-main {
                flex: 1;
                min-width: 0;
                padding: 36px;
                background: #fff;
                border-radius: 14px;
                box-shadow: 0 3px 12px rgba(0, 0, 0, 0.08);
                text-align: center;
            }

            .matching-title {
                color: #24476b;
                padding-bottom: 14px;
                margin-bottom: 28px;
                border-bottom: 3px solid #ed9145;
            }

            .complete-icon {
                font-size: 48px;
                color: #ed9145;
                margin-bottom: 12px;
            }

            .complete-message {
                color: #24476b;
                font-size: 20px;
                font-weight: bold;
                margin-bottom: 12px;
            }

            .complete-description {
                color: #667788;
                margin-bottom: 30px;
            }

            .complete-button {
                display: inline-block;
                padding: 12px 28px;
                background: #24476b;
                color: #fff;
                text-decoration: none;
                border-radius: 8px;
                font-weight: bold;
                transition: background 0.2s;
            }

            .complete-button:hover {
                background: #ed9145;
                color: #fff;
            }

            @media (max-width: 768px) {
                .matching-layout {
                    flex-direction: column;
                }

                .matching-sidebar {
                    width: 100%;
                }

                .matching-main {
                    width: 100%;
                    box-sizing: border-box;
                    padding: 24px 16px;
                }
            }
        </style>

        <div class="matching-layout">
            <aside class="matching-sidebar">
                <c:import url="/common/sidebar.jsp" />
            </aside>

            <main class="matching-main">
                <h2 class="matching-title">商品登録完了</h2>

                <div class="complete-icon">✓</div>

                <p class="complete-message">
                    商品を登録しました！
                </p>

                <p class="complete-description">
                    おさがり商品の登録が完了しました。
                </p>

                <a class="complete-button"
                   href="${pageContext.request.contextPath}/scoremanager/main/AssignmentTop.action">
                    おさがり譲渡トップへ戻る
                </a>
            </main>
        </div>
    </c:param>
</c:import>
