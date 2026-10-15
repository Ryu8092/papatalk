```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>パパトーク｜ログイン</title>

<style>
    * {
        box-sizing: border-box;
    }

    body {
        margin: 0;
        min-height: 100vh;
        font-family: "Meiryo", sans-serif;
        background: #f2f8f7;
        display: flex;
        justify-content: center;
        align-items: center;
        color: #30434a;
    }

    .login-container {
        width: 100%;
        max-width: 420px;
        padding: 40px 35px;
        margin: 20px;
        background: white;
        border-radius: 20px;
        box-shadow: 0 8px 25px rgba(40, 80, 75, 0.10);
        text-align: center;
    }

    h1 {
        margin: 0 0 10px;
        color: #278b83;
        font-size: 32px;
    }

    .subtitle {
        margin-bottom: 30px;
        color: #71827f;
        font-size: 14px;
    }

    .input-group {
        margin-bottom: 18px;
        text-align: left;
    }

    .input-group label {
        display: block;
        margin-bottom: 8px;
        font-size: 14px;
        font-weight: bold;
    }

    .input-group input {
        width: 100%;
        padding: 14px;
        border: 1px solid #ccdcd9;
        border-radius: 10px;
        font-size: 16px;
        outline: none;
    }

    .input-group input:focus {
        border-color: #278b83;
        box-shadow: 0 0 0 3px rgba(39, 139, 131, 0.12);
    }

    .login-button {
        width: 100%;
        padding: 14px;
        margin-top: 8px;
        border: none;
        border-radius: 10px;
        background: #278b83;
        color: white;
        font-size: 17px;
        font-weight: bold;
        cursor: pointer;
    }

    .login-button:hover {
        background: #20766f;
    }

    .signup-button {
        display: block;
        width: 100%;
        padding: 13px;
        margin-top: 15px;
        border: 1px solid #278b83;
        border-radius: 10px;
        color: #278b83;
        text-decoration: none;
        font-weight: bold;
    }

    .signup-button:hover {
        background: #edf8f6;
    }

    .error-message {
        margin-bottom: 18px;
        padding: 12px;
        border-radius: 8px;
        background: #fff0ef;
        color: #c0392b;
        font-size: 14px;
    }
</style>
</head>

<body>

    <div class="login-container">

        <h1>パパトーク</h1>
        <p class="subtitle">おかえりなさい！ログインしてください</p>

        <% if (request.getAttribute("comment") != null) { %>
            <div class="error-message">
                <%= request.getAttribute("comment") %>
            </div>
