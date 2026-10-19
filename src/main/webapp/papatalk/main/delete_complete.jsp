<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>アカウント削除完了</title>
<style>
    body {
        font-family: sans-serif;
        text-align: center;
        margin: 0;
        background: white;
    }
    .steps {
        margin-top: 25px;
        color: #79bd62;
    }
    h3 {
        margin-top: 75px;
        font-size: 18px;
    }
    a {
        display: inline-block;
        margin-top: 65px;
        color: #55b9e8;
        text-decoration: none;
    }
</style>
</head>
<body>

<div class="steps">①削除　　②削除完了</div>

<h3>アカウント削除完了</h3>

<a href="${pageContext.request.contextPath}/papatalk/Login.action">
    ログインに戻る
</a>

</body>
</html>