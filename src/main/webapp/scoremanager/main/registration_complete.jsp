<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>登録完了</title>
 
<style>
/* 進捗バー */
.step-container {
    display: flex;
    justify-content: space-between;
    width: 600px;
    margin: 40px auto;
    font-family: sans-serif;
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
 
/* 完了メッセージ */
.complete-message {
    width: 600px;
    margin: 40px auto;
    padding: 20px;
    text-align: center;
    font-size: 22px;
    font-weight: bold;
    background-color: #f0fff0;
    border: 1px solid #4CAF50;
    border-radius: 6px;
}
 
.login-btn {
    display: block;        /* ← ボタンをブロック要素にする */
    width: 200px;          /* ← 横幅を固定する（中央揃えに必要） */
    margin: 0 auto;        /* ← ボタン自体を中央に配置 */
    padding: 12px 20px;
    background-color: #2196F3;
    color: #fff;
    text-decoration: none;
    border-radius: 4px;
    font-size: 18px;
    font-weight: bold;
    text-align: center;    /* ← 文字を中央にする */
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
 
<!-- 完了メッセージ -->
<div class="complete-message">
    登録完了しました
</div>
 
<div class="back-login">
    <a href="/papatalk/scoremanager/Login.action" class="login-btn">ログインに戻る</a>
</div>
 
 
</body>
</html>