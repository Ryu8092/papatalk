
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:import url="/common/base.jsp">
    <c:param name="title">パパトークシステム</c:param>
    <c:param name="scripts"></c:param>

    <c:param name="content">
        <style>
            .matching-layout {
                display: flex;
                gap: 24px;
                align-items: flex-start;
                min-height: 70vh;
            }

            .matching-sidebar {
                flex: 0 0 240px;
                background: #ffffff;
                border-radius: 14px;
                box-shadow: 0 4px 16px rgba(31, 55, 85, 0.08);
                padding: 20px;
            }

            .matching-main {
                flex: 1;
                min-width: 0;
                padding: 28px;
                background: #ffffff;
                border-radius: 14px;
                box-shadow: 0 4px 16px rgba(31, 55, 85, 0.08);
            }

            .matching-title {
                color: #24476b;
                font-size: 26px;
                font-weight: 700;
                padding-bottom: 16px;
                border-bottom: 3px solid #ed9145;
                margin-bottom: 24px;
            }

            .matching-description {
                color: #718096;
                font-size: 14px;
            }

            @media (max-width: 768px) {
                .matching-layout {
                    flex-direction: column;
                }

                .matching-sidebar {
                    width: 100%;
                    flex-basis: auto;
                }

                .matching-main {
                    width: 100%;
                    padding: 20px;
                }
            }
        </style>

        <div class="matching-layout">

            <!-- 左側：サイドバー -->
            <aside class="matching-sidebar">
                <jsp:include page="/common/sidebar.jsp" />
            </aside>

            <!-- 右側：メインコンテンツ -->
            <main class="matching-main">
                <h2 class="matching-title">
                    マッチング一覧
                </h2>

                <p class="matching-description">
                    気になる相手を探して、新しいつながりを見つけましょう。
                </p>

                <!-- マッチング一覧のデータをここに追加 -->
            </main>

        </div>
    </c:param>
</c:import>
