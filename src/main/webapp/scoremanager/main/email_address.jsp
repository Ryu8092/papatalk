
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:import url="/common/base.jsp">
    <c:param name="title" value="パパトーク｜メールアドレス入力" />
    <c:param name="scripts" value="" />

    <c:param name="content">
        <div class="registration-page">

            <!-- 進捗バー -->
            <div class="step-container">

                <div class="step-box">
                    <div class="step-number step-active">1</div>
                    <div class="step-label">登録</div>
                </div>

                <div class="step-box">
                    <div class="step-number step-inactive">2</div>
                    <div class="step-label">メール認証</div>
                </div>

                <div class="step-box">
                    <div class="step-number step-inactive">3</div>
                    <div class="step-label">情報を入力</div>
                </div>

                <div class="step-box">
                    <div class="step-number step-inactive">4</div>
                    <div class="step-label">完了</div>
                </div>

            </div>

            <!-- メールアドレス入力カード -->
            <div class="registration-card">
            

                <div class="registration-icon">💌</div>
					
                <h2 class="registration-title">
                    メールアドレスを入力
                </h2>

                <p class="registration-message">
                    パパトークへようこそ！<br>
                    メールアドレスを入力して、会員登録を始めましょう。
                </p>

                <!-- メール送信フォーム -->
                <form action="MailVerification.action" method="post">
             		<c:if test="${not empty errorMessage}">
					    <p style="color: red; font-size: 13px;">
				        <c:out value="${errorMessage}" />
				    </p>
					</c:if>

                    <label for="email" class="email-label">
                        メールアドレス
                    </label>

                    <input
                        type="email"
                        id="email"
                        name="email"
                        required
                        maxlength="254"
                        placeholder="example@example.com"
                        autocomplete="email">

                    <button type="submit" class="registration-submit">
                        認証メールを送信
                    </button>

                </form>
                
                <!-- 戻るボタン -->
				<form action="LoginDisplay.action" method="get">
    			<button type="submit" class="registration-back">
        		戻る
	    		</button>
				</form>

                <p class="registration-note">
                    入力したメールアドレスに認証メールをお送りします。
                </p>

            </div>

        </div>

        <style>
            /* ページ全体 */
            .registration-page {
                padding: 20px 16px 50px;
                font-family: sans-serif;
                color: #24476b;
            }

            /* 進捗バー */
            .step-container {
                display: flex;
                justify-content: space-between;
                gap: 8px;
                width: 100%;
                max-width: 600px;
                margin: 20px auto 40px;
            }

            .step-box {
                flex: 1;
                min-width: 0;
                text-align: center;
            }

            .step-number {
                display: flex;
                align-items: center;
                justify-content: center;
                width: 40px;
                height: 40px;
                margin: 0 auto 10px;
                border-radius: 50%;
                font-weight: bold;
                color: #fff;
            }

            .step-active {
                background-color: #4CAF50;
            }

            .step-inactive {
                background-color: #BDBDBD;
            }

            .step-label {
                font-size: 13px;
                color: #52677d;
            }

            /* 入力カード */
            .registration-card {
                box-sizing: border-box;
                width: 100%;
                max-width: 480px;
                margin: 0 auto;
                padding: 40px 30px;
                text-align: center;
                background: #fff;
                border-radius: 20px;
                box-shadow: 0 8px 30px rgba(36, 71, 107, .12);
            }

            /* アイコン */
            .registration-icon {
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

            .registration-title {
                margin: 0 0 14px;
                color: #24476b;
                font-size: 25px;
                font-weight: 800;
            }

            .registration-message {
                margin-bottom: 28px;
                color: #718096;
                font-size: 15px;
                line-height: 1.8;
            }

            /* 入力欄 */
            .email-label {
                display: block;
                margin-bottom: 8px;
                text-align: left;
                color: #24476b;
                font-size: 14px;
                font-weight: 700;
            }

            input[type="email"] {
                box-sizing: border-box;
                width: 100%;
                padding: 13px;
                margin-bottom: 20px;
                border: 1px solid #d7e0e9;
                border-radius: 10px;
                font-size: 16px;
                outline: none;
            }

            input[type="email"]:focus {
                border-color: #2196F3;
                box-shadow: 0 0 0 3px rgba(33, 150, 243, .12);
            }

            /* 送信ボタン */
            .registration-submit {
                display: block;
                width: 100%;
                padding: 14px;
                border: none;
                border-radius: 10px;
                background: #ed9145;
                color: #fff;
                font-size: 16px;
                font-weight: 700;
                cursor: pointer;
            }
            
            /* 戻るボタン */
			.registration-back {
    			display: block;
   	 			width: 100%;
   	 			padding: 14px;
    			margin-top: 16px;
    			box-sizing: border-box;
    			border: none;
    			border-radius: 10px;
    			background: #a8b4c5;
    			color: #fff;
    			font-size: 16px;
   				font-weight: 700;
    			cursor: pointer;
    			transition: background-color 0.2s;
			}

			.registration-back:hover {
   				 background: #8999ad;
			}

			/* フォームの余白を調整 */
			.registration-card form {
    			margin-bottom: 0;
			}

            .registration-submit:hover {
                background: #d97b2e;
            }

            .registration-note {
                margin: 18px 0 0;
                color: #718096;
                font-size: 12px;
                line-height: 1.7;
            }

            /* スマートフォン対応 */
            @media (max-width: 480px) {
                .registration-card {
                    padding: 30px 20px;
                }

                .registration-title {
                    font-size: 22px;
                }

                .step-label {
                    font-size: 11px;
                }

                .step-number {
                    width: 34px;
                    height: 34px;
                }
            }
        </style>
    </c:param>
</c:import>