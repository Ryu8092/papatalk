<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ログイン</title>
</head>
<body>

    <h2>ログイン</h2>

    <form action="Login.action" method="post">
        ユーザー名：
        <input type="text" name="user_name" required>
        <br><br>

        パスワード：
        <input type="password" name="password" required>
        <br><br>

        <input type="submit" value="ログイン">
    </form>

    <p>
        <a href="">新規登録はこちら</a>
    </p>

</body>
</html>