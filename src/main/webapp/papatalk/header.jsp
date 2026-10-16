<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
    body {
        margin: 0;
        padding: 0;
        width: 100%; /* 全体の幅を確保 */
    }
	.header-logo {
        font-size: 36px;       /* ここで文字の大きさを調整（さらに大きくなら48pxなど） */
        font-weight: bold;     /* 太字 */
        letter-spacing: 2px;   /* 文字の間隔を少し広げて読みやすく */
        color: #333;           /* 文字色（真っ黒より少しグレーがオシャレです） */
    }
    .header {
        background-color: #e6f0ff;
        padding: 10px 30px;
        
        display: flex !important;
        justify-content: space-between !important;
        /* align-items: center;  ← これを削除、または以下に変更 */
        align-items: flex-end;   /* これで中身が下に揃います */
        
        width: 100%;
        box-sizing: border-box;
        text-align: left;         /* 基本は左寄せ */
    }

    /* 右側のブロックだけ右寄せを念押し */
    .header-user {
        margin-left: auto; 
        display: flex;
        align-items: center;
    }
</style>
	<meta charset="UTF-8">
	<title>パパトーク</title>
</head>
<body>
    <header class="header">
    <div class="header-logo">パパトーク</div>
    <div class="header-user">
        <span>${teacher.name} 様</span>
        <a href="/kadai2/scoremanager/main/Logout.action">ログアウト</a>
    </div>
</header>
</body>
</html>