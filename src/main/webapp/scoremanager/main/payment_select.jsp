<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
 
<c:import url="/common/base.jsp">
    <c:param name="title">パパトークシステム</c:param>
    <c:param name="scripts"></c:param>
    <c:param name="content">
 
        <style>
            .payment-layout {
                display: flex;
                gap: 24px;
                align-items: flex-start;
                min-height: 70vh;
            }
 
            .payment-sidebar {
                flex: 0 0 240px;
                background: #fff;
                border-radius: 14px;
                box-shadow: 0 4px 16px rgba(31, 55, 85, .08);
                padding: 20px;
            }
 
            .payment-main {
                flex: 1;
                min-width: 0;
                min-height: 530px;
                padding: 28px;
                background: #fff;
                border-radius: 14px;
                box-shadow: 0 4px 16px rgba(31, 55, 85, .08);
                box-sizing: border-box;
            }
 
            .payment-top {
                position: relative;
                text-align: center;
            }
 
            .payment-title {
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
 
            .purchase-box {
                width: 75%;
                margin: 25px auto 10px;
                padding: 20px;
                background: #fff;
                border: 1px solid #dce4ee;
                border-radius: 12px;
                box-shadow: 0 3px 10px rgba(31, 55, 85, .05);
                box-sizing: border-box;
            }
 
            .purchase-box > div {
                color: #24476b;
                font-size: 17px;
                font-weight: bold;
                padding-bottom: 12px;
                border-bottom: 1px solid #e2e8f0;
            }
 
            .purchase-box p {
                margin: 14px 5px;
                font-weight: bold;
                color: #334155;
            }
 
            .payment-method-title {
                width: 75%;
                margin: 20px auto 0;
                padding: 12px 15px;
                background: #f1f5f9;
                border-radius: 8px;
                color: #24476b;
                font-weight: bold;
                box-sizing: border-box;
            }
 
            .payment-method {
                width: 75%;
                margin: 18px auto;
                color: #334155;
                display: flex;
                flex-direction: column;
                gap: 15px;
            }
 
            .payment-method label {
                display: flex;
                align-items: center;
                gap: 8px;
                cursor: pointer;
            }
 
            .payment-method input[type="radio"] {
                appearance: none;
                width: 18px;
                height: 18px;
                flex: 0 0 18px;
                margin: 0;
                border: 1.5px solid #888;
                border-radius: 50%;
                box-sizing: border-box;
                cursor: pointer;
            }
 
            .payment-method input[type="radio"]:checked {
                background: radial-gradient(
                    circle,
                    #24476b 0 4px,
                    transparent 4.5px
                );
            }
 
            .next-button {
                display: block;
                margin: 60px auto 0;
                padding: 12px 40px;
                background: #ed9145;
                border: none;
                border-radius: 25px;
                color: #fff;
                font-weight: bold;
                cursor: pointer;
                transition: background .2s;
            }
 
            .next-button:hover {
                background: #d97c30;
            }
 
            @media (max-width: 768px) {
                .payment-layout {
                    flex-direction: column;
                }
 
                .payment-sidebar {
                    width: 100%;
                    flex-basis: auto;
                    box-sizing: border-box;
                }
 
                .payment-main {
                    width: 100%;
                    padding: 20px;
                }
 
                .purchase-box,
                .payment-method-title,
                .payment-method {
                    width: 100%;
                }
 
                .back-button {
                    position: static;
                    margin-bottom: 15px;
                }
            }
        </style>
 
        <div class="payment-layout">
 
            <aside class="payment-sidebar">
                <jsp:include page="/common/sidebar.jsp" />
            </aside>
 
            <main class="payment-main">
 
                <div class="payment-top">
                    <button type="button" class="back-button"
                        onclick="history.back()">戻る</button>
 
                    <h2 class="payment-title">お支払い</h2>
                </div>
 
                <div class="purchase-box">
                    <div>ご購入内容</div>
 
                    <c:choose>
                        <c:when test="${plan == '1'}">
                            <p>1日</p>
                            <p>300円</p>
                        </c:when>
 
                        <c:when test="${plan == '2'}">
                            <p>1か月</p>
                            <p>600円</p>
                        </c:when>
 
                        <c:when test="${plan == '3'}">
                            <p>3か月</p>
                            <p>1500円</p>
                        </c:when>
                    </c:choose>
 
                    <p>開始予定日：${startDate}</p>
                    <p>終了予定日：${endDate}</p>
                </div>
 
                <div class="payment-method-title">
                    お支払い方法
                </div>
 
                <form
                    action="${pageContext.request.contextPath}/scoremanager/main/CardInput.action"
                    method="get"
                    id="paymentForm">
 
                    <input type="hidden" name="plan" value="${plan}">
 
                    <div class="payment-method">
 
                        <label>
                            <input type="radio"
                                name="payment_method"
                                value="credit_card"
                                required>
                            クレジットカード
                        </label>
 
                        <label>
                            <input type="radio"
                                name="payment_method"
                                value="paypay">
                            PayPay
                        </label>
 
                        <label>
                            <input type="radio"
                                name="payment_method"
                                value="convenience">
                            コンビニ払い
                        </label>
 
                        <label>
                            <input type="radio"
                                name="payment_method"
                                value="bank">
                            銀行振込
                        </label>
 
                    </div>
 
                    <button type="submit" class="next-button">
                        次へ
                    </button>
 
                </form>
 
            </main>
        </div>
 
        <script>
            const paymentRadios = document.querySelectorAll(
                'input[name="payment_method"]'
            );
 
            const paymentForm = document.getElementById("paymentForm");
 
            let selectedRadio = null;
 
            // 選択中のボタンをもう一度押したら解除
            paymentRadios.forEach(function(radio) {
 
                radio.addEventListener("click", function() {
 
                    if (selectedRadio === this) {
                        this.checked = false;
                        selectedRadio = null;
                    } else {
                        selectedRadio = this;
                    }
 
                });
 
            });
 
            // クレジットカード以外は次へ進ませない
            paymentForm.addEventListener("submit", function(event) {
 
                const checkedRadio = document.querySelector(
                    'input[name="payment_method"]:checked'
                );
 
                if (!checkedRadio ||
                    checkedRadio.value !== "credit_card") {
 
                    event.preventDefault();
                }
 
            });
        </script>
 
    </c:param>
</c:import>
 