
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<c:import url="/common/base.jsp">
    <c:param name="title">パパトークシステム</c:param>
    <c:param name="scripts"></c:param>

    <c:param name="content">
        <style>
            .subscription-layout {
                display: flex;
                gap: 24px;
                align-items: flex-start;
                min-height: 70vh;
            }

            .subscription-sidebar {
                flex: 0 0 240px;
                background: #fff;
                border-radius: 14px;
                box-shadow: 0 4px 16px rgba(31, 55, 85, .08);
                padding: 20px;
            }

            .subscription-main {
                flex: 1;
                min-width: 0;
                padding: 28px;
                background: #fff;
                border-radius: 14px;
                box-shadow: 0 4px 16px rgba(31, 55, 85, .08);
            }

            .subscription-top {
                position: relative;
                text-align: center;
            }

            .subscription-title {
                color: #24476b;
                font-size: 26px;
                font-weight: 700;
                padding-bottom: 16px;
                border-bottom: 3px solid #ed9145;
                margin-bottom: 16px;
            }

            .subscription-description {
                color: #718096;
                font-size: 14px;
                margin-bottom: 24px;
            }

            .plan-list {
                display: grid;
                grid-template-columns: repeat(3, minmax(0, 1fr));
                gap: 20px;
                margin-top: 30px;
            }

            .plan-list form {
                margin: 0;
            }

            .plan-button {
                width: 100%;
                min-height: 150px;
                padding: 20px;
                border: 1px solid #dce4ee;
                border-radius: 12px;
                background: #fff;
                color: #24476b;
                cursor: pointer;
                font-size: 16px;
                font-weight: 600;
                transition: background .2s;
            }

            .plan-button:hover {
                background: #f2f5fa;
            }

            .plan-period {
                margin-bottom: 15px;
            }

            .plan-price {
                color: #ed9145;
                font-size: 24px;
                font-weight: 700;
            }

            .date-area {
                margin-top: 30px;
                padding: 22px;
                background: #f5f8fc;
                border: 1px solid #dce4ee;
                border-radius: 12px;
            }

            .date-title {
                color: #24476b;
                font-size: 18px;
                font-weight: 700;
                margin-bottom: 18px;
                text-align: center;
            }

            .date-row {
                display: flex;
                justify-content: space-between;
                gap: 15px;
                padding: 13px 5px;
                border-bottom: 1px solid #dce4ee;
            }

            .date-row:last-child {
                border-bottom: none;
            }

            .date-label {
                color: #718096;
                font-weight: 600;
            }

            .date-value {
                color: #24476b;
                font-weight: 700;
                text-align: right;
            }

            .back-button {
                position: absolute;
                left: 0;
                top: 0;
                padding: 8px 18px;
                background: #f1f3f5;
                color: #444;
                border: 1px solid #dce4ee;
                border-radius: 8px;
                cursor: pointer;
            }

            .back-button:hover {
                background: #e4e8ed;
            }

            @media (max-width: 768px) {
                .subscription-layout {
                    flex-direction: column;
                }

                .subscription-sidebar {
                    width: 100%;
                    flex-basis: auto;
                    box-sizing: border-box;
                }

                .subscription-main {
                    width: 100%;
                    padding: 20px;
                    box-sizing: border-box;
                }

                .plan-list {
                    grid-template-columns: 1fr;
                }

                .date-row {
                    flex-direction: column;
                    gap: 5px;
                }

                .date-value {
                    text-align: left;
                }

                .back-button {
                    position: static;
                    margin-bottom: 15px;
                }
            }
        </style>

        <div class="subscription-layout">

            <!-- サイドバー -->
            <aside class="subscription-sidebar">
                <jsp:include page="/common/sidebar.jsp" />
            </aside>

            <!-- メイン画面 -->
            <main class="subscription-main">

                <div class="subscription-top">

                    <h2 class="subscription-title">
                        サブスク限定
                    </h2>

                </div>

                <p class="subscription-description">
                    ご希望のプランを選択してください。
                </p>

                <!-- 料金プラン -->
                <div class="plan-list">

                    <form
                        action="${pageContext.request.contextPath}/scoremanager/main/PaymentSelect.action"
                        method="get">

                        <input type="hidden" name="plan" value="1">

                        <button type="submit" class="plan-button">
                            <div class="plan-period">1日</div>
                            <div class="plan-price">300円</div>
                        </button>
                    </form>

                    <form
                        action="${pageContext.request.contextPath}/scoremanager/main/PaymentSelect.action"
                        method="get">

                        <input type="hidden" name="plan" value="2">

                        <button type="submit" class="plan-button">
                            <div class="plan-period">1か月</div>
                            <div class="plan-price">600円</div>
                        </button>
                    </form>

                    <form
                        action="${pageContext.request.contextPath}/scoremanager/main/PaymentSelect.action"
                        method="get">

                        <input type="hidden" name="plan" value="3">

                        <button type="submit" class="plan-button">
                            <div class="plan-period">3か月</div>
                            <div class="plan-price">1500円</div>
                        </button>
                    </form>

                </div>

                <!-- 選択したプランの日付表示 -->
                <c:if test="${not empty startDate and not empty endDate}">

                    <div class="date-area">

                        <h3 class="date-title">
                            ご利用期間
                        </h3>

                        <div class="date-row">
                            <span class="date-label">
                                選択プラン
                            </span>

                            <span class="date-value">
                                <c:choose>
                                    <c:when test="${plan == '1'}">
                                        1日プラン
                                    </c:when>
                                    <c:when test="${plan == '2'}">
                                        1か月プラン
                                    </c:when>
                                    <c:when test="${plan == '3'}">
                                        3か月プラン
                                    </c:when>
                                </c:choose>
                            </span>
                        </div>

                        <div class="date-row">
                            <span class="date-label">
                                開始予定日
                            </span>

                            <span class="date-value">
                                <c:out value="${startDate}" />
                            </span>
                        </div>

                        <div class="date-row">
                            <span class="date-label">
                                終了予定日
                            </span>

                            <span class="date-value">
                                <c:out value="${endDate}" />
                            </span>
                        </div>

                    </div>

                </c:if>

            </main>

        </div>

    </c:param>
</c:import>
