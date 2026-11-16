
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>ぱぱトーク｜アカウント停止完了</title>

<style>
    * {
        box-sizing: border-box;
    }

    body {
        margin: 0;
        padding: 0;
        background-color: #f3f6fa;
        font-family: "Meiryo", sans-serif;
        color: #333;
    }

    .complete-container {
        min-height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
        padding: 30px 20px;
    }

    .complete-card {
        width: 100%;
        max-width: 650px;
        background-color: #fff;
        border-radius: 16px;
        padding: 55px 40px 35px;
        text-align: center;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
    }

    .complete-icon {
        width: 85px;
        height: 85px;
        margin: 0 auto 25px;
        border-radius: 50%;
        background-color: #e6f4ed;
        color: #299765;
        font-size: 48px;
        font-weight: bold;
        line-height: 85px;
    }

    .complete-title {
        font-size: 27px;
        color: #24476b;
        margin-bottom: 25px;
        font-weight: bold;
    }

    .complete-message {
        font-size: 16px;
        line-height: 2;
        color: #555;
        margin-bottom: 35px;
    }

    .complete-message strong {
        color: #ed9145;
    }

    .button-area {
        border-top: 1px solid #e5e5e5;
        padding-top: 30px;
        margin-top: 15px;
    }

    .back-button {
        display: inline-block;
        min-width: 240px;
        padding: 14px 25px;
        background-color: #24476b;
        color: white;
        text-decoration: none;
        border-radius: 8px;
        font-size: 16px;
        font-weight: bold;
        transition: 0.2s;
    }

    .back-button:hover {
        background-color: #193653;
        color: white;
    }

    @media (max-width: 600px) {
        .complete-card {
            padding: 40px 20px 30px;
        }

        .complete-title {
            font-size: 22px;
        }

        .complete-message {
            font-size: 14px;
        }

        .back-button {
            width: 100%;
            min-width: auto;
        }
    }
</style>
</head>

<body>

<div class="complete-container">

    <div class="complete-card">

        <!-- 完了アイコン -->
        <div class="complete-icon">
            ✓
        </div>

        <!-- 完了メッセージ -->
        <h1 class="complete-title">
            アカウント停止完了
        </h1>

        <div class="complete-message">
            アカウントの停止処理が正常に完了しました。<br>
            <strong>アカウント停止が完了しています。</strong><br>
            ご利用ありがとうございました。
        </div>

        <!-- 通報一覧に戻るボタン -->
        <div class="button-area">

            <a href="<c:url value='/scoremanager/main/Operation.action'/>"
               class="back-button">
                通報一覧に戻る
            </a>

        </div>

    </div>

</div>

</body>
</html>
