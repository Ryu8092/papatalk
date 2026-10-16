<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>パパトーク</title>

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

.signup {
    display: block;
    width: 210px;
    margin: 40px auto 0;
    padding: 14px 0;
    border: 2px solid black;
    border-radius: 10px;
    color: black;
    text-decoration: none;
    font-size: 18px;
}

.error-message {
    margin: -50px auto 20px;
    color: red;
    font-size: 14px;
}
</style>
</head>

<body>

    <h1>パパトーク</h1>

    <% if (request.getAttribute("comment") != null) { %>
        <p class="error-message">
            <%= request.getAttribute("comment") %>
        </p>
    <% } %>

    <form action="LoginExecute.action" method="post">

        <input type="text" name="user_name"
               placeholder="ユーザーネーム" required>

        <input type="password" name="password"
               placeholder="パスワード" required>

        <button type="submit">ログイン</button>

    </form>

    <a href="Signup.action" class="signup">新規会員登録</a>

</body>
</html>