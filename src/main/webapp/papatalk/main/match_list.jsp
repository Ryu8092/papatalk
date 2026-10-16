
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
.header {
    background-color: #e6f0ff;
    padding: 10px 30px;
    display: flex;
    justify-content: space-between;
    align-items: flex-end;
    box-sizing: border-box;
    width: 100%;
}

.header-logo {
    font-size: 36px;
    font-weight: bold;
    letter-spacing: 2px;
    color: #333;
}

.header-user {
    display: flex;
    align-items: center;
    gap: 15px;
}

.logout-button {
    padding: 8px 16px;
    border: 1px solid black;
    border-radius: 8px;
    background-color: white;
    color: black;
    text-decoration: none;
    font-size: 15px;
}
</style>

<header class="header">
    <div class="header-logo">パパトーク</div>

    <div class="header-user">
        <span>${user.user_name} 様</span>

        <a class="logout-button"
           href="${pageContext.request.contextPath}/scoremanager/main/Logout.action">
            ログアウト
        </a>
    </div>
</header>
