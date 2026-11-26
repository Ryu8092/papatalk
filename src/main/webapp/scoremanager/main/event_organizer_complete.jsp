
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<c:import url="/common/base.jsp">

    <c:param name="title">
        パパトークシステム｜イベント投稿完了
    </c:param>

    <c:param name="content">

        <style>
            /* 画面全体 */
            .complete-page {
                width: 100%;
                min-height: 75vh;
                display: flex;
                justify-content: center;
                align-items: center;
                padding: 30px 20px;
                box-sizing: border-box;
                background-color: #f1ebdd;
                font-family: "Yu Gothic", "Meiryo", sans-serif;
                letter-spacing: 0.05em;
            }

            /* 完了画面の枠 */
            .complete-container {
                width: 100%;
                max-width: 850px;
                min-height: 490px;
                padding: 30px 40px;
                box-sizing: border-box;
                display: flex;
                flex-direction: column;
                align-items: center;
                background-color: #fffdf8;
                border: 1px solid #d8ccb4;
                border-radius: 5px;
                box-shadow: 0 4px 12px rgba(50, 40, 20, 0.08);
            }

            /* タイトル */
            .complete-title {
                width: 100%;
                text-align: center;
                font-size: 28px;
                font-weight: bold;
                color: #292c29;
                margin: 5px 0 25px;
            }

            .complete-line {
                width: 100%;
                border: none;
                border-top: 2px solid #b49a65;
                margin-bottom: 30px;
            }

            /* 完了メッセージ */
            .complete-message {
                flex: 1;
                display: flex;
                justify-content: center;
                align-items: center;
                font-size: 30px;
                font-weight: bold;
                color: #292c29;
                text-align: center;
            }

            /* 戻るボタンエリア */
            .button-area {
                width: 100%;
                display: flex;
                justify-content: center;
                margin-top: 30px;
            }

            /* 戻るボタン */
            .back-button {
                min-width: 110px;
                padding: 11px 25px;
                background-color: #292c29;
                border: 1px solid #292c29;
                border-radius: 4px;
                color: #fffdf8;
                font-size: 14px;
                letter-spacing: 0.08em;
                cursor: pointer;
                transition: 0.2s;
            }

            .back-button:hover {
                background-color: #b49a65;
                border-color: #b49a65;
            }

            /* スマートフォン */
            @media screen and (max-width: 520px) {
                .complete-page {
                    padding: 15px 10px;
                }

                .complete-container {
                    min-height: 430px;
                    padding: 20px 15px;
                }

                .complete-title {
                    font-size: 22px;
                }

                .complete-message {
                    font-size: 23px;
                }
            }
        </style>

        <div class="complete-page">

            <div class="complete-container">

                <!-- タイトル -->
                <h1 class="complete-title">
                    イベント投稿完了
                </h1>

                <hr class="complete-line">

                <!-- 完了メッセージ -->
                <div class="complete-message">
                    投稿が完了しました
                </div>

                <!-- 戻るボタン -->
                <div class="button-area">

                    <form action="/papatalk/scoremanager/main/RetrieveListOrganizers.action"
                          method="get">

                        <button type="submit" class="back-button">
                            戻る
                        </button>

                    </form>

                </div>

            </div>

        </div>

    </c:param>

</c:import>
