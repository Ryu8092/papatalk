
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:import url="/common/base.jsp">

    <c:param name="title">
        パパトークシステム｜通報一覧
    </c:param>

    <c:param name="scripts">
        <style>

            * {
                box-sizing: border-box;
            }

            /* ===== 全体 ===== */
            .report-page {
                width: 100%;
                min-height: 75vh;
                padding: 40px 30px;
                background: #f1ebdd;
            }

            /* ===== メインカード ===== */
            .report-container {
                width: 100%;
                max-width: 1000px;
                margin: 0 auto;
                background: #fffdf8;
                border: 1px solid #d8ccb4;
                border-radius: 5px;
                overflow: hidden;
                box-shadow: 0 8px 30px rgba(48, 43, 32, 0.10);
            }

            /* ===== ヘッダー ===== */
            .report-main-header {
                padding: 28px 40px 30px;
                background: #292c29;
                border-bottom: 4px solid #b49a65;
            }

            .report-header-top {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 25px;
            }

            .report-admin-label {
                display: inline-block;
                padding: 7px 14px;
                border: 1px solid #88774f;
                color: #d8c39a;
                font-size: 10px;
                font-weight: bold;
                letter-spacing: 2px;
            }

            .report-system-label {
                font-size: 10px;
                color: #b9ad94;
                letter-spacing: 2px;
            }

            .report-title {
                margin: 0;
                text-align: center;
                color: #f1ebdd;
                font-size: 28px;
                font-weight: bold;
                letter-spacing: 4px;
            }

            .report-subtitle {
                margin-top: 10px;
                text-align: center;
                color: #b49a65;
                font-size: 10px;
                letter-spacing: 3px;
            }

            /* ===== 装飾 ===== */
            .report-decoration {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 10px;
                margin-top: 20px;
            }

            .report-decoration-line {
                width: 45px;
                height: 1px;
                background: #b49a65;
            }

            .report-decoration-diamond {
                width: 7px;
                height: 7px;
                background: #b49a65;
                transform: rotate(45deg);
            }

            /* ===== コンテンツ ===== */
            .report-content {
                padding: 40px;
            }

            .report-description {
                margin-bottom: 30px;
                padding-bottom: 20px;
                border-bottom: 1px solid #e3dac9;
                color: #776b57;
                font-size: 13px;
                letter-spacing: 1px;
                text-align: center;
            }

            /* ===== 通報メニュー ===== */
            .report-menu {
                display: flex;
                flex-direction: column;
                align-items: center;
                gap: 20px;
            }

            .report-form {
                width: 100%;
                max-width: 550px;
                margin: 0;
            }

            /* ===== ボタン ===== */
            .report-button {
                width: 100%;
                min-height: 85px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 20px 30px;
                background: #fffdf8;
                border: 1px solid #ded4c1;
                border-left: 4px solid #b49a65;
                border-radius: 4px;
                color: #38372f;
                font-size: 18px;
                font-weight: bold;
                letter-spacing: 2px;
                cursor: pointer;
                transition: 0.25s;
            }

            .report-button:hover {
                background: #faf6ed;
                border-color: #b49a65;
                border-left-color: #8b3d35;
                color: #8b3d35;
                transform: translateY(-3px);
                box-shadow: 0 7px 18px rgba(64, 54, 37, 0.12);
            }

            .report-button:focus-visible,
            .report-back-button:focus-visible {
                outline: 3px solid #b49a65;
                outline-offset: 3px;
            }

            /* ===== 矢印 ===== */
            .report-arrow {
                font-size: 28px;
                color: #b49a65;
                transition: 0.2s;
            }

            .report-button:hover .report-arrow {
                color: #8b3d35;
                transform: translateX(4px);
            }

            /* ===== 戻るボタン ===== */
            .report-back-area {
                display: flex;
                justify-content: center;
                margin-top: 40px;
                padding-top: 25px;
                border-top: 1px solid #e3dac9;
            }

            .report-back-form {
                width: 100%;
                max-width: 230px;
                margin: 0;
            }

            .report-back-button {
                width: 100%;
                min-height: 48px;
                padding: 10px 20px;
                background: #292c29;
                border: 1px solid #292c29;
                border-radius: 4px;
                color: #f1ebdd;
                font-size: 13px;
                font-weight: bold;
                letter-spacing: 2px;
                cursor: pointer;
                transition: 0.2s;
            }

            .report-back-button:hover {
                background: #454943;
                border-color: #b49a65;
                color: #fffdf8;
                transform: translateY(-2px);
            }

            /* ===== 下部 ===== */
            .report-bottom {
                margin-top: 30px;
                padding-top: 20px;
                border-top: 1px solid #e3dac9;
                text-align: center;
                color: #a69a83;
                font-size: 10px;
                letter-spacing: 2px;
            }

            /* ===== タブレット ===== */
            @media screen and (max-width: 768px) {

                .report-page {
                    padding: 25px 12px;
                }

                .report-main-header {
                    padding: 25px 20px;
                }

                .report-title {
                    font-size: 24px;
                }

                .report-content {
                    padding: 25px 20px;
                }

                .report-button {
                    min-height: 75px;
                    padding: 20px;
                    font-size: 16px;
                }
            }

            /* ===== スマートフォン ===== */
            @media screen and (max-width: 520px) {

                .report-system-label {
                    display: none;
                }

                .report-title {
                    font-size: 21px;
                    letter-spacing: 2px;
                }

                .report-content {
                    padding: 22px 14px;
                }

                .report-button {
                    min-height: 70px;
                    padding: 18px;
                    font-size: 15px;
                }

                .report-arrow {
                    font-size: 24px;
                }

                .report-bottom {
                    font-size: 9px;
                }
            }

        </style>
    </c:param>

    <c:param name="content">

        <div class="report-page">

            <div class="report-container">

                <!-- ===== ヘッダー ===== -->
                <div class="report-main-header">

                    <div class="report-header-top">

                        <div class="report-admin-label">
                            ADMINISTRATOR
                        </div>

                        <div class="report-system-label">
                            PAPATALK MANAGEMENT SYSTEM
                        </div>

                    </div>

                    <h2 class="report-title">
                        通報一覧
                    </h2>

                    <div class="report-subtitle">
                        REPORT MANAGEMENT
                    </div>

                    <div class="report-decoration">

                        <div class="report-decoration-line"></div>

                        <div class="report-decoration-diamond"></div>

                        <div class="report-decoration-line"></div>

                    </div>

                </div>

                <!-- ===== メインコンテンツ ===== -->
                <div class="report-content">

                    <div class="report-description">
                        確認する通報カテゴリを選択してください。
                    </div>

                    <!-- ===== 通報メニュー ===== -->
                    <div class="report-menu">

                        <!-- マッチング -->
                        <form
                            action="/papatalk/scoremanager/main/Acquisition.action"
                            method="get"
                            class="report-form">

                            <input
                                type="hidden"
                                name="report_content_id"
                                value="1">

                            <button type="submit" class="report-button">

                                <span>マッチング</span>

                                <span class="report-arrow">›</span>

                            </button>

                        </form>

                        <!-- 掲示板 -->
                        <form
                            action="/papatalk/scoremanager/main/Acquisition.action"
                            method="get"
                            class="report-form">

                            <input
                                type="hidden"
                                name="report_content_id"
                                value="2">

                            <button type="submit" class="report-button">

                                <span>掲示板</span>

                                <span class="report-arrow">›</span>

                            </button>

                        </form>

                        <!-- おさがり譲渡 -->
                        <form
                            action="/papatalk/scoremanager/main/Acquisition.action"
                            method="get"
                            class="report-form">

                            <input
                                type="hidden"
                                name="report_content_id"
                                value="3">

                            <button type="submit" class="report-button">

                                <span>おさがり譲渡</span>

                                <span class="report-arrow">›</span>

                            </button>

                        </form>

                    </div>

                    <!-- ===== 戻るボタン ===== -->
                    <div class="report-back-area">

                        <form
                            action="/papatalk/scoremanager/main/Operation.action"
                            method="get"
                            class="report-back-form">

                            <button type="submit" class="report-back-button">
                                戻る
                            </button>

                        </form>

                    </div>

                    <!-- ===== 下部 ===== -->
                    <div class="report-bottom">
                        PAPATALK SYSTEM ｜ REPORT MANAGEMENT
                    </div>

                </div>

            </div>

        </div>

    </c:param>

</c:import>
