<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>登録完了</title>

<style>
    body {
        margin: 0;
        background: #f5f8fc;
        font-family: sans-serif;
        color: #40536a;
    }

    /* 進捗バー */
    .step-container {
        display: flex;
        justify-content: space-between;
        width: 600px;
        max-width: calc(100% - 40px);
        margin: 40px auto;
    }

    .step-box {
        text-align: center;
        width: 120px;
    }

    .step-number {
        width: 40px;
        height: 40px;
        line-height: 40px;
        border-radius: 50%;
        margin: 0 auto 10px;
        font-weight: bold;
        color: white;
    }

    .step-active {
        background-color: #4CAF50;
    }

    .step-inactive {
        background-color: #BDBDBD;
    }

    .step-label {
        font-size: 14px;
    }

    /* 完了画面 */
    .complete-page {
        display: flex;
        justify-content: center;
        align-items: center;
        padding: 20px 16px 50px;
    }

    .complete-card {
        width: 100%;
        max-width: 480px;
        padding: 42px 30px;
        text-align: center;
        background: #ffffff;
        border-radius: 20px;
        box-shadow: 0 8px 30px rgba(36, 71, 107, 0.12);
        box-sizing: border-box;
    }

    /* 丸い完了アイコン */
    .complete-icon {
        display: flex;
        justify-content: center;
        align-items: center;
        width: 82px;
        height: 82px;
        margin: 0 auto 24px;
        border-radius: 50%;
        background: #eaf5ed;
        color: #39845a;
        font-size: 42px;
        font-weight: 700;
    }

    /* 完了タイトル */
    .complete-title {
        margin-bottom: 16px;
        color: #24476b;
        font-size: 26px;
        font-weight: 800;
    }

    /* 完了メッセージ */
    .complete-text {
        margin-bottom: 30px;
        color: #718096;
        font-size: 15px;
        line-height: 1.9;
    }

    /* ログインボタン */
    .login-btn {
        display: block;
        width: 100%;
        padding: 14px 20px;
        margin: 0 auto;
        box-sizing: border-box;
        background-color: #ed9145;
        color: #fff;
        text-decoration: none;
        border-radius: 11px;
        font-size: 16px;
        font-weight: bold;
        text-align: center;
        transition: background 0.2s;
    }

    .login-btn:hover {
        background-color: #d97b2e;
        color: #fff;
    }

    /* ブランドメッセージ */
    .complete-brand {
        margin-top: 24px;
        color: #8a9bad;
        font-size: 13px;
    }

    /* スマホ対応 */
    @media (max-width: 600px) {
        .step-container {
            width: calc(100% - 24px);
        }

        .step-box {
            width: 25%;
        }

        .step-label {
            font-size: 11px;
        }

        .complete-card {
            padding: 35px 22px;
        }

        .complete-title {
            font-size: 23px;
        }
    }
</style>

</head>

<body>

    <!-- 進捗バー -->
    <div class="step-container">

        <div class="step-box">
            <div class="step-number step-inactive">1</div>
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
            <div class="step-number step-active">4</div>
            <div class="step-label">完了</div>
        </div>

    </div>

    <!-- 登録完了画面 -->
    <div class="complete-page">

        <div class="complete-card">

            <!-- 完了アイコン -->
            <div class="complete-icon" aria-hidden="true">
                ✓
            </div>

            <!-- 完了タイトル -->
            <h2 class="complete-title">
                登録が完了しました
            </h2>

            <!-- 完了メッセージ -->
            <p class="complete-text">
                ぱぱトークへのご登録ありがとうございます。<br>
                アカウントの登録が正常に完了しました。<br>
                ぜひ、ぱぱトークをご利用ください。
            </p>

            <!-- ログインボタン -->
            <a href="/papatalk/scoremanager/Login.action"
               class="login-btn">
                ログイン画面へ進む →
            </a>

            <!-- ブランドメッセージ -->
            <div class="complete-brand">
                ぱぱトーク｜つながる、話せる、支え合える。
            </div>

        </div>

    </div>

</body>
</html>