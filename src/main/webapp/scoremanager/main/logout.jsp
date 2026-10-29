
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:import url="/common/base.jsp">
    <c:param name="title" value="パパトーク｜ログアウト" />
    <c:param name="scripts" value="" />

    <c:param name="content">
        <div class="logout-page">
            <div class="logout-card">

                <div class="logout-icon">💬</div>

                <h2 class="logout-title">
                    ログアウトしますか？
                </h2>

                <p class="logout-message">
                    ぱぱトークをご利用いただきありがとうございます。<br>
                    またいつでも戻ってきてくださいね。
                </p>

                <div class="logout-buttons">

                    <!-- ログアウト処理 -->
                    <form
                        action="LogoutControl.action" method="get">
                        <button type="submit"
                        	name="action"
                        	value="ログアウトする"
                            class="logout-confirm">
                            ログアウトする
                        </button>
                    </form>

                    <!-- 戻る -->
                    <form action="LogoutControl.action" method="get">
    					<button type="submit"
            				name="action"
            				value="戻る"
            				class="logout-back">
        						戻る
    					</button>
					</form>
                </div>
            </div>
        </div>

        <style>
            .logout-page {
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 65vh;
                padding: 30px 16px;
            }

            .logout-card {
                width: 100%;
                max-width: 480px;
                padding: 40px 30px;
                text-align: center;
                background: #fff;
                border-radius: 20px;
                box-shadow: 0 8px 30px rgba(36, 71, 107, .12);
            }

            .logout-icon {
                display: flex;
                align-items: center;
                justify-content: center;
                width: 76px;
                height: 76px;
                margin: 0 auto 22px;
                border-radius: 24px;
                background: #eaf2fa;
                font-size: 36px;
            }

            .logout-title {
                margin-bottom: 14px;
                color: #24476b;
                font-size: 25px;
                font-weight: 800;
            }

            .logout-message {
                margin-bottom: 30px;
                color: #718096;
                font-size: 15px;
                line-height: 1.8;
            }

            .logout-buttons {
                display: flex;
                flex-direction: column;
                gap: 12px;
            }

            .logout-buttons form {
                margin: 0;
            }

            .logout-confirm,
            .logout-back {
                display: block;
                width: 100%;
                padding: 13px;
                border-radius: 10px;
                font-size: 16px;
                font-weight: 700;
                text-decoration: none;
                box-sizing: border-box;
            }

            .logout-confirm {
                border: none;
                background: #ed9145;
                color: #fff;
                cursor: pointer;
            }

            .logout-confirm:hover {
                background: #d97b2e;
            }

            .logout-back {
                border: 1px solid #d7e0e9;
                background: #fff;
                color: #24476b;
            }

            .logout-back:hover {
                background: #f0f5fa;
            }
        </style>
    </c:param>
</c:import>