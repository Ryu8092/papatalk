
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>パパトーク ログイン</title>
<style>
body {
    font-family: "Meiryo", sans-serif;
    text-align: center;
    background-color: white;
}

h1 {
    margin-top: 60px;
    margin-bottom: 75px;
    font-size: 24px;
}

input {
    display: block;
    width: 300px;
    height: 45px;
    margin: 15px auto;
    padding: 0 10px;
    border: 2px solid black;
    border-radius: 10px;
    font-size: 18px;
    box-sizing: border-box;
}

button {
    width: 150px;
    height: 48px;
    margin-top: 8px;
    border: 2px solid black;
    border-radius: 10px;
    background-color: white;
    font-size: 18px;
    cursor: pointer;
}
</style>
</head>
<body>

<h1>パパトーク</h1>

<% if (request.getAttribute("errorMessage") != null) { %>
    <p style="color:red;">
        <%= request.getAttribute("errorMessage") %>
    </p>
<% } %>

<form action="LoginSelectAction.action" method="post">
    <input type="text" name="user_name"
           placeholder="ユーザーネーム">

    <input type="password" name="password"
           placeholder="パスワード">

    <button type="submit">ログイン</button>
</form>

</body>
</html>
