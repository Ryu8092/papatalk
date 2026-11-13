<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
 
<c:import url="/common/base.jsp">
    <c:param name="title">パパトークシステム｜クレジットカード情報</c:param>
    <c:param name="scripts"></c:param>
 
    <c:param name="content">
        <style>
            .card-layout {
                display: flex;
                gap: 24px;
                align-items: flex-start;
                min-height: 70vh;
            }
 
            .card-sidebar {
                flex: 0 0 240px;
                background: #fff;
                border-radius: 14px;
                box-shadow: 0 4px 16px rgba(31, 55, 85, .08);
                padding: 20px;
            }
 
            .card-main {
                flex: 1;
                min-width: 0;
                padding: 28px;
                background: #fff;
                border-radius: 14px;
                box-shadow: 0 4px 16px rgba(31, 55, 85, .08);
                min-height: 530px;
                box-sizing: border-box;
            }
 
            .card-top {
                position: relative;
                text-align: center;
                margin-bottom: 20px;
            }
 
            .card-title {
                font-size: 26px;
                font-weight: bold;
                color: #24476b;
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
 
            .card-description {
                text-align: center;
                margin: 18px 0 24px;
                color: #444;
            }
 
            .card-form {
                width: 65%;
                margin: 0 auto;
            }
 
            .card-form label {
                display: block;
                margin: 16px 0 7px;
                color: #333;
                font-weight: bold;
            }
 
            .required {
                color: #e85d5d;
                font-size: 12px;
                margin-left: 5px;
            }
 
            .card-form input {
                width: 100%;
                height: 40px;
                border: 1px solid #cbd5e1;
                border-radius: 7px;
                box-sizing: border-box;
                padding: 8px 10px;
                font-size: 15px;
            }
 
            .card-form input:focus,
            .expiration select:focus {
                outline: none;
                border-color: #ed9145;
            }
 
            .expiration {
                display: flex;
                align-items: center;
                gap: 10px;
            }
 
            .expiration select {
                height: 40px;
                padding: 5px 10px;
                border: 1px solid #cbd5e1;
                border-radius: 7px;
                background: #fff;
            }
 
            .confirm-button {
                display: block;
                margin: 30px auto 0;
                padding: 11px 35px;
                background: #ed9145;
                color: white;
                border: none;
                border-radius: 8px;
                font-size: 15px;
                font-weight: bold;
                cursor: pointer;
            }
 
            .confirm-button:hover {
                background: #d97c30;
            }
 
            @media (max-width: 768px) {
                .card-layout {
                    flex-direction: column;
                }
 
                .card-sidebar {
                    width: 100%;
                    flex-basis: auto;
                    box-sizing: border-box;
                }
 
                .card-main {
                    width: 100%;
                    padding: 20px;
                }
 
                .card-form {
                    width: 90%;
                }
 
                .back-button {
                    position: static;
                    display: block;
                    margin-bottom: 15px;
                }
            }
        </style>
 
        <div class="card-layout">
 
            <!-- サイドバー -->
            <aside class="card-sidebar">
                <jsp:include page="/common/sidebar.jsp" />
            </aside>
 
            <!-- メイン画面 -->
            <main class="card-main">
 
                <div class="card-top">
                    <button type="button" class="back-button"
                        onclick="history.back()">戻る</button>
 
                    <h2 class="card-title">
                        クレジットカード情報
                    </h2>
                </div>
 
                <p class="card-description">
                    ご使用になるクレジットカード情報を入力して下さい。
                </p>
 
                <form class="card-form"
                    action="${pageContext.request.contextPath}/scoremanager/main/PaymentConfirm.action"
                    method="post">
 
                    <!-- 選択したプラン -->
                    <input type="hidden" name="plan"
                        value="<c:out value='${plan}'/>">
 
                    <!-- カード番号 -->
                    <label for="card_number">
                        カード番号<span class="required">必須</span>
                    </label>
 
                    <input type="text"
                        id="card_number"
                        name="card_number"
                        maxlength="19"
                        value="<c:out value='${param.card_number}'/>">
 
                    <!-- 名義人 -->
                    <label for="card_name">
                        名義人<span class="required">必須</span>
                    </label>
 
                    <input type="text"
                        id="card_name"
                        name="card_name"
                        value="<c:out value='${param.card_name}'/>">
 
                    <!-- 有効期限 -->
                    <label>
                        有効期限<span class="required">必須</span>
                    </label>
 
                    <div class="expiration">
                        <select name="month">
                            <option value="">選択</option>
 
                            <c:forEach begin="1" end="12" var="m">
                                <option value="${m}"
                                    <c:if test="${param.month == m}">
                                        selected
                                    </c:if>>
                                    ${m}
                                </option>
                            </c:forEach>
                        </select>
                        月
 
                        <select name="year">
                            <option value="">選択</option>
 
                            <c:forEach begin="2026" end="2040" var="y">
                                <option value="${y}"
                                    <c:if test="${param.year == y}">
                                        selected
                                    </c:if>>
                                    ${y}
                                </option>
                            </c:forEach>
                        </select>
                        年
                    </div>
 
                    <!-- セキュリティコード -->
                    <label for="security_code">
                        セキュリティコード<span class="required">必須</span>
                    </label>
 
                    <input type="password"
                        id="security_code"
                        name="security_code"
                        maxlength="4">
 
                    <!-- 確認ボタン -->
                    <button type="submit" class="confirm-button">
                        確認
                    </button>
 
                </form>
            </main>
        </div>
    </c:param>
</c:import>
 