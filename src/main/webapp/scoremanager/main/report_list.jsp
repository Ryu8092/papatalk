
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:import url="/common/base.jsp">
    <c:param name="title">パパトークシステム｜通報一覧</c:param>

    <c:param name="scripts">
        <style>
            /* 全体 */
            .report-list-container {
                width: 100%;
                min-height: 70vh;
                display: flex;
                justify-content: center;
                align-items: center;
                padding: 30px 20px;
                background-color: #f5f7fa;
            }

            /* 通報一覧カード */
            .report-list-card {
                width: 750px;
                min-height: 500px;
                background-color: #ffffff;
                border: 2px solid #222222;
                border-radius: 15px;
                padding: 25px 40px;
                box-sizing: border-box;
            }

            /* タイトル */
            .report-header {
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 55px;
                margin-bottom: 25px;
            }

            .report-header h2 {
                font-size: 30px;
                font-weight: bold;
                margin: 0;
                color: #222222;
            }

            /* 仕切り線 */
            .report-divider {
                border: none;
                border-top: 2px solid #222222;
                margin-bottom: 40px;
            }

            /* 通報メニューボタン */
            .report-menu {
                display: flex;
                flex-direction: column;
                align-items: center;
                gap: 30px;
            }

            .report-menu form {
                width: 310px;
                margin: 0;
            }

            .report-menu button {
                width: 100%;
                min-height: 65px;
                background-color: #c3e5f2;
                border: 2px solid #222222;
                border-radius: 30px;
                font-size: 18px;
                font-weight: bold;
                color: #222222;
                cursor: pointer;
                transition: 0.2s;
            }

            .report-menu button:hover {
                background-color: #9ed5e9;
                color: #222222;
                transform: translateY(-3px);
            }

            /* 戻るボタン */
            .back-button-area {
                display: flex;
                justify-content: center;
                margin-top: 40px;
            }

            .back-button {
                width: 100%;
                max-width: 250px;
                min-height: 60px;
                display: flex;
                justify-content: center;
                align-items: center;
                background-color: #c3e5f2;
                border: 2px solid #222222;
                border-radius: 30px;
                color: #222222;
                font-size: 18px;
                font-weight: bold;
                text-decoration: none;
                transition: 0.2s;
                box-sizing: border-box;
            }

            .back-button:hover {
                background-color: #9ed5e9;
                color: #222222;
                transform: translateY(-3px);
            }

            /* スマートフォン対応 */
            @media screen and (max-width: 768px) {
                .report-list-container {
                    padding: 15px;
                }

                .report-list-card {
                    width: 100%;
                    min-height: 500px;
                    padding: 20px;
                }

                .report-header h2 {
                    font-size: 24px;
                }

                .report-menu form {
                    width: 90%;
                }

                .report-menu button {
                    min-height: 60px;
                    font-size: 16px;
                }

                .back-button {
                    min-height: 55px;
                    font-size: 16px;
                }
            }
        </style>
    </c:param>

    <c:param name="content">
        <div class="report-list-container">

            <div class="report-list-card">

                <!-- タイトル -->
                <div class="report-header">
                    <h2>通報一覧</h2>
                </div>

                <hr class="report-divider">

                <!-- 通報種類選択ボタン -->
                <div class="report-menu">

                    <!-- マッチングのチャット -->
                    <form action="/papatalk/scoremanager/main/Acquisition.action" method="get">
					    <input type="hidden" name="report_content_id" value="1">
					    <button type="submit">マッチング</button>
					</form>

                    <!-- 掲示板 -->
                    <form action="/papatalk/scoremanager/main/Acquisition.action" method="get">
					    <input type="hidden" name="report_content_id" value="2">
					    <button type="submit">掲示板</button>
					</form>

                    <!-- おさがり譲渡の出品商品 -->
                   <form action="/papatalk/scoremanager/main/Acquisition.action" method="get">
					    <input type="hidden" name="report_content_id" value="3">
					    <button type="submit">おさがり譲渡</button>
					</form>

                </div>

                <!-- 一番下の戻るボタン -->
                <div class="back-button-area">
                    <a href="/papatalk/scoremanager/main/Operation.action"
                       class="back-button">
                        戻る
                    </a>
                </div>

            </div>
        </div>
    </c:param>

</c:import>