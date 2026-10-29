
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:import url="/common/base.jsp">
    <c:param name="title">パパトークシステム｜アカウント削除確認</c:param>

    <c:param name="scripts">
        <style>
            .delete-container {
                max-width: 650px;
                margin: 40px auto;
                padding: 35px 30px;
                background-color: #ffffff;
                border: 1px solid #e5e7eb;
                border-radius: 16px;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.06);
                text-align: center;
            }

            .delete-container h2 {
                margin-bottom: 30px;
                font-size: 28px;
                font-weight: bold;
                color: #333333;
            }

            .steps {
                margin-bottom: 35px;
                font-size: 15px;
            }

            .delete-icon {
                display: flex;
                align-items: center;
                justify-content: center;
                width: 70px;
                height: 70px;
                margin: 0 auto 20px;
                border-radius: 50%;
                background-color: #fff0f0;
                color: #dc3545;
                font-size: 36px;
                font-weight: bold;
            }

            .delete-container h3 {
                margin-bottom: 18px;
                font-size: 23px;
                font-weight: bold;
                color: #333333;
            }

            .delete-message {
                margin-bottom: 35px;
                color: #666666;
                font-size: 15px;
                line-height: 1.9;
            }

            .buttons {
                display: flex;
                justify-content: center;
                gap: 18px;
                margin-top: 25px;
            }

            .buttons form {
                flex: 1;
                max-width: 230px;
                margin: 0;
            }

            .buttons button {
                width: 100%;
                min-height: 55px;
                padding: 14px 18px;
                border: none;
                border-radius: 9px;
                font-size: 17px;
                font-weight: bold;
                cursor: pointer;
                transition: background-color 0.2s, transform 0.2s;
            }

            .delete-button {
                background-color: #dc3545;
                color: #ffffff;
            }

            .delete-button:hover {
                background-color: #bb2d3b;
                transform: translateY(-2px);
            }

            .cancel-button {
                background-color: #f0f2f4;
                color: #333333;
            }

            .cancel-button:hover {
                background-color: #dfe3e6;
                transform: translateY(-2px);
            }

            @media (max-width: 480px) {
                .delete-container {
                    margin: 20px 10px;
                    padding: 28px 18px;
                }

                .delete-container h2 {
                    font-size: 24px;
                }

                .delete-container h3 {
                    font-size: 20px;
                }

                .buttons {
                    flex-direction: column;
                    align-items: center;
                    gap: 12px;
                }

                .buttons form {
                    width: 100%;
                    max-width: 300px;
                }
            }
        </style>
    </c:param>

    <c:param name="content">
        <div class="delete-container">

            <h2>アカウント削除確認</h2>

            <div class="steps">
                <span style="color: #79bd62; font-weight: bold;">
                    ① 削除確認
                </span>
                <span style="color: #cccccc; margin-left: 15px;">
                    ② 削除完了
                </span>
            </div>

            <div class="delete-icon">!</div>

            <h3>アカウントを削除しますか？</h3>

            <p class="delete-message">
                アカウントを削除すると、登録した情報を<br>
                利用できなくなります。<br>
                本当に削除してもよろしいですか？
            </p>

            <div class="buttons">
                <form action="Process.action" method="post">
                    <button type="submit" class="delete-button">
                        アカウントを削除する
                    </button>
                </form>

                <form action="AccountinFormation.action" method="get">
                    <button type="submit" class="cancel-button">
                        キャンセル
                    </button>
                </form>
            </div>

        </div>
    </c:param>
</c:import>
