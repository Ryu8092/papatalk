
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:import url="/common/base.jsp">

    <c:param name="title">
        パパトークシステム｜パパトーク管理
    </c:param>

    <c:param name="scripts">
        <style>

            * {
                box-sizing: border-box;
            }

            /* ===== 全体 ===== */
            .operation-page {
                width: 100%;
                min-height: 75vh;
                padding: 40px 30px;
                background: #f1ebdd;
            }

            /* ===== メインカード ===== */
            .operation-container {
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
            .operation-main-header {
                padding: 28px 40px 30px;
                background: #292c29;
                border-bottom: 4px solid #b49a65;
            }

            .operation-header-top {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 25px;
            }

            .operation-admin-label {
                display: inline-block;
                padding: 7px 14px;
                border: 1px solid #88774f;
                color: #d8c39a;
                font-size: 10px;
                font-weight: bold;
                letter-spacing: 2px;
            }

            .operation-system-label {
                font-size: 10px;
                color: #b9ad94;
                letter-spacing: 2px;
            }

            .operation-title {
                margin: 0;
                text-align: center;
                color: #f1ebdd;
                font-size: 28px;
                font-weight: bold;
                letter-spacing: 4px;
            }

            .operation-subtitle {
                margin-top: 10px;
                text-align: center;
                color: #b49a65;
                font-size: 10px;
                letter-spacing: 3px;
            }

            /* ===== 装飾 ===== */
            .operation-decoration {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 10px;
                margin-top: 20px;
            }

            .operation-decoration-line {
                width: 45px;
                height: 1px;
                background: #b49a65;
            }

            .operation-decoration-diamond {
                width: 7px;
                height: 7px;
                background: #b49a65;
                transform: rotate(45deg);
            }

            /* ===== コンテンツ ===== */
            .operation-content {
                padding: 40px;
            }

            .operation-description {
                margin-bottom: 30px;
                padding-bottom: 20px;
                border-bottom: 1px solid #e3dac9;
                color: #776b57;
                font-size: 13px;
                letter-spacing: 1px;
                text-align: center;
            }

            /* ===== メニュー ===== */
            .operation-menu {
                display: grid;
                grid-template-columns: repeat(2, minmax(0, 1fr));
                gap: 22px;
            }

            .operation-form {
                width: 100%;
                margin: 0;
            }

            /* ===== メニューボタン ===== */
            .operation-button {
                width: 100%;
                min-height: 115px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 25px 30px;
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

            .operation-button:hover {
                background: #faf6ed;
                border-color: #b49a65;
                border-left-color: #8b3d35;
                color: #8b3d35;
                transform: translateY(-4px);
                box-shadow: 0 7px 18px rgba(64, 54, 37, 0.12);
            }

            .operation-button:focus-visible,
            .logout-button:focus-visible {
                outline: 3px solid #b49a65;
                outline-offset: 3px;
            }

            /* ===== 矢印 ===== */
            .operation-arrow {
                font-size: 28px;
                color: #b49a65;
                transition: 0.2s;
            }

            .operation-button:hover .operation-arrow {
                color: #8b3d35;
                transform: translateX(4px);
            }

            /* ===== ログアウト ===== */
            .logout-area {
                display: flex;
                justify-content: center;
                margin-top: 40px;
                padding-top: 25px;
                border-top: 1px solid #e3dac9;
            }

            .logout-form {
                width: 100%;
                max-width: 230px;
                margin: 0;
            }

            .logout-button {
                width: 100%;
                min-height: 48px;
                display: flex;
                justify-content: center;
                align-items: center;
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

            .logout-button:hover {
                background: #454943;
                border-color: #b49a65;
                color: #fffdf8;
                transform: translateY(-2px);
            }

            /* ===== 下部 ===== */
            .operation-bottom {
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

                .operation-page {
                    padding: 25px 12px;
                }

                .operation-main-header {
                    padding: 25px 20px;
                }

                .operation-title {
                    font-size: 24px;
                }

                .operation-content {
                    padding: 25px 20px;
                }

                .operation-menu {
                    gap: 16px;
                }

                .operation-button {
                    min-height: 95px;
                    padding: 20px;
                    font-size: 16px;
                }

            }

            /* ===== スマートフォン ===== */
            @media screen and (max-width: 520px) {

                .operation-system-label {
                    display: none;
                }

                .operation-title {
                    font-size: 21px;
                    letter-spacing: 2px;
                }

                .operation-content {
                    padding: 22px 14px;
                }

                .operation-menu {
                    grid-template-columns: 1fr;
                    gap: 15px;
                }

                .operation-button {
                    min-height: 80px;
                    padding: 18px 22px;
                    font-size: 16px;
                }

                .operation-arrow {
                    font-size: 24px;
                }

                .operation-bottom {
                    font-size: 9px;
                }

            }

        </style>
    </c:param>

    <c:param name="content">

        <div class="operation-page">

            <div class="operation-container">

                <!-- ===== ヘッダー ===== -->
                <div class="operation-main-header">

                    <div class="operation-header-top">

                        <div class="operation-admin-label">
                            ADMINISTRATOR
                        </div>

                        <div class="operation-system-label">
                            PAPATALK MANAGEMENT SYSTEM
                        </div>

                    </div>

                    <h2 class="operation-title">
                        パパトーク管理
                    </h2>

                    <div class="operation-subtitle">
                        ADMINISTRATION MENU
                    </div>

                    <div class="operation-decoration">
                        <div class="operation-decoration-line"></div>
                        <div class="operation-decoration-diamond"></div>
                        <div class="operation-decoration-line"></div>
                    </div>

                </div>

                <!-- ===== メインコンテンツ ===== -->
                <div class="operation-content">

                    

                    <!-- ===== 管理メニュー ===== -->
                    <div class="operation-menu">

                        <!-- 投稿 -->
                        <form action="/papatalk/scoremanager/main/RetrievePosts.action"
                              method="get"
                              class="operation-form">

                            <button type="submit" class="operation-button">
                                <span>投稿</span>
                                <span class="operation-arrow">›</span>
                            </button>

                        </form>

                        <!-- 通報履歴 -->
                        <form action="/papatalk/scoremanager/main/BanList.action"
                              method="get"
                              class="operation-form">

                            <button type="submit" class="operation-button">
                                <span>通報履歴</span>
                                <span class="operation-arrow">›</span>
                            </button>

                        </form>

                        <!-- 通報一覧 -->
                        <form action="/papatalk/scoremanager/main/SingleScreenDisplay.action"
                              method="get"
                              class="operation-form">

                            <button type="submit" class="operation-button">
                                <span>通報一覧</span>
                                <span class="operation-arrow">›</span>
                            </button>

                        </form>

                        <!-- イベント -->
                        <form action="/papatalk/scoremanager/main/RetrieveListOrganizers.action"
                              method="get"
                              class="operation-form">

                            <button type="submit" class="operation-button">
                                <span>イベント</span>
                                <span class="operation-arrow">›</span>
                            </button>

                        </form>

                    </div>

                    <!-- ===== ログアウト ===== -->
                    <div class="logout-area">

                        <form action="/papatalk/scoremanager/main/Logout.action"
                              method="get"
                              class="logout-form">

                            <button type="submit" class="logout-button">
                                ログアウト
                            </button>

                        </form>

                    </div>

                    <!-- ===== 下部 ===== -->
                    <div class="operation-bottom">
                        PAPATALK SYSTEM ｜ ADMINISTRATION
                    </div>

                </div>

            </div>

        </div>

    </c:param>

</c:import>
