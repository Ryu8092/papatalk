<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>アカウント削除確認</title>

<style>
    body {
        font-family: sans-serif;
        text-align: center;
        margin: 0;
        background: white;
    }

    .steps {
        margin-top: 25px;
    }

    h3 {
        margin-top: 75px;
        font-size: 18px;
    }

    .buttons {
        margin-top: 100px;
    }

    button {
        background: #8bc9ed;
        border: 1px solid #009fe8;
        padding: 10px 28px;
        margin: 0 45px;
        cursor: pointer;
        font-size: 15px;
    }
</style>
</head>

<body>

<div class="steps">
    <span style="color: #79bd62;">①削除</span>
    <span style="color: #cccccc; margin-left: 15px;">②削除完了</span>
</div>

<h3>アカウント削除されますか</h3>

<div class="buttons">

    <form action="${pageContext.request.contextPath}/papatalk/main/Process.action"
          method="post" style="display:inline;">
        <button type="submit">削除</button>
    </form>

    <form action="${pageContext.request.contextPath}/papatalk/main/Cancel.action"
          method="post" style="display:inline;">
        <button type="submit">キャンセル</button>
    </form>

</div>

</body>
</html>