<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
 
<c:import url="/common/base.jsp">
    <c:param name="title">パパトークシステム</c:param>
    <c:param name="scripts"></c:param>
    <c:param name="content">
 
        <style>
            .confirm-layout {
                display: flex;
                gap: 24px;
                align-items: flex-start;
                min-height: 70vh;
            }
 
            .confirm-sidebar {
                flex: 0 0 240px;
                background: #fff;
                border-radius: 14px;
                box-shadow: 0 4px 16px rgba(31, 55, 85, .08);
                padding: 20px;
            }
 
            .confirm-main {
                flex: 1;
                min-width: 0;
                min-height: 530px;
                padding: 28px;
                background: #fff;
                border-radius: 14px;
                box-shadow: 0 4px 16px rgba(31, 55, 85, .08);
                box-sizing: border-box;
            }
 
            .confirm-top {
                position: relative;
                text-align: center;
            }
 
            .confirm-title {
                color: #24476b;
                font-size: 26px;
                font-weight: 700;
                margin: 0;
                padding-bottom: 16px;
                border-bottom: 3px solid #ed9145;
            }
 
            .back-button {
                position: absolute;
                left: 0;
                top: 0;
                padding: 7px 18px;
                background: #718096;
                border: none;
                border-radius: 20px;
                color: #fff;
                cursor: pointer;
            }
 
            .back-button:hover {
                background: #566579;
            }
 
            .card-info-box {
                width: 75%;
                min-height: 300px;
                margin: 28px auto 0;
                padding: 20px;
                background: #fff;
                border: 1px solid #dce4ee;
                border-radius: 12px;
                box-shadow: 0 3px 10px rgba(31, 55, 85, .05);
                box-sizing: border-box;
            }
 
            .card-info-title {
                margin: 0;
                padding-bottom: 12px;
                color: #24476b;
                font-size: 17px;
                font-weight: bold;
                border-bottom: 1px solid #e2e8f0;
            }
 
            .card-info {
                margin: 20px 15px;
            }
 
            .card-info p {
                margin: 20px 0;
                padding-bottom: 12px;
                border-bottom: 1px solid #edf0f4;
                color: #334155;
                font-weight: 600;
                overflow-wrap: anywhere;
            }
 
            .payment-button {
                display: block;
                margin: 30px auto 0;
                padding: 12px 40px;
                background: #ed9145;
                border: none;
                border-radius: 25px;
                color: #fff;
                font-weight: bold;
                cursor: pointer;
                transition: background .2s;
            }
 
            .payment-button:hover {
                background: #d97c30;
            }
 
            @media (max-width: 768px) {
                .confirm-layout {
                    flex-direction: column;
                }
 
                .confirm-sidebar {
                    width: 100%;
                    flex-basis: auto;
                    box-sizing: border-box;
                }
 
                .confirm-main {
                    width: 100%;
                    padding: 20px;
                }
 
                .card-info-box {
                    width: 95%;
                }
 
                .back-button {
                    position: static;
                    margin-bottom: 15px;
                }
            }
        </style>
 
        <div class="confirm-layout">
 
            <aside class="confirm-sidebar">
                <jsp:include page="/common/sidebar.jsp" />
            </aside>
 
            <main class="confirm-main">
 
                <div class="confirm-top">
 
                    <button type="button" class="back-button"
                        onclick="history.back()">戻る</button>
 
                    <h2 class="confirm-title">
                        クレジットカード情報確認
                    </h2>
 
                </div>
 
                <div class="card-info-box">
 
                    <p class="card-info-title">
                        クレジット情報内容
                    </p>
 
                    <div class="card-info">
 
                        <p>
                            名義人：
                            <c:out value="${card_name}" />
                        </p>
 
                        <p>
                            カード番号：
                            <c:choose>
                                <c:when test="${not empty card_number}">
                                    **** **** ****
                                    <c:out value="${fn:substring(card_number,
                                        fn:length(card_number) - 4,
                                        fn:length(card_number))}" />
                                </c:when>
 
                                <c:otherwise>
                                    ****
                                </c:otherwise>
                            </c:choose>
                        </p>
 
                        <p>
                            有効期限：
                            <c:out value="${month}" /> /
                            <c:out value="${year}" />
                        </p>
 
                    </div>
 
                </div>
 
                <form
                    action="${pageContext.request.contextPath}/scoremanager/main/PaymentDone.action"
                    method="post">
 
                    <input type="hidden" name="plan" value="${plan}">
 
                    <button type="submit" class="payment-button">
                        お支払い
                    </button>
 
                </form>
 
            </main>
 
        </div>
 
    </c:param>
</c:import>
 