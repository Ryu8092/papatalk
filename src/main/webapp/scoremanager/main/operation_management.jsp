<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
 
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
 
<c:import url="/common/base.jsp">
 
    <c:param name="title">
        パパトークシステム｜パパトーク管理
    </c:param>
 
    <c:param name="scripts">
        <style>
            /* 全体 */
            .operation-page {
                width: 100%;
                min-height: 75vh;
                display: flex;
                justify-content: center;
                align-items: center;
                padding: 30px 20px;
                background-color: #f5f7fa;
            }
 
            /* 管理画面の枠 */
            .operation-container {
                width: 100%;
                max-width: 850px;
                min-height: 470px;
                background-color: #ffffff;
                border: 2px solid #222222;
                padding: 15px 60px 35px;
                box-sizing: border-box;
            }
 
            /* タイトル部分 */
            .operation-header {
                display: flex;
                justify-content: center;
                align-items: center;
                border-bottom: 2px solid #222222;
                padding: 0 0 15px;
                margin-bottom: 35px;
            }
 
            .operation-title {
                text-align: center;
                font-size: 28px;
                font-weight: bold;
                color: #222222;
                margin: 0;
            }
 
            /* ボタン配置：縦1列 */
            .operation-menu {
                display: flex;
                flex-direction: column;
                align-items: center;
                gap: 30px;
            }
 
            /* 各メニューボタン */
            .operation-button {
                width: 310px;
                min-height: 65px;
                display: flex;
                justify-content: center;
                align-items: center;
                background-color: #c3e5f2;
                border: 2px solid #222222;
                border-radius: 30px;
                color: #222222;
                font-size: 18px;
                font-weight: bold;
                text-decoration: none;
                transition: 0.2s;
                box-sizing: border-box;
            }
 
            .operation-button:hover {
                background-color: #9ed5e9;
                color: #222222;
                transform: translateY(-3px);
            }
 
            /* ログアウトボタン */
            .logout-area {
                display: flex;
                justify-content: center;
                margin-top: 40px;
            }
 
            .logout-button {
                width: 100%;
                max-width: 250px;
                min-height: 60px;
                display: flex;
                justify-content: center;
                align-items: center;
                background-color: #c3e5f2;
                border: 2px solid #222222;
                border-radius: 30px;
                color: #222222;
                font-size: 18px;
                font-weight: bold;
                text-decoration: none;
                transition: 0.2s;
                box-sizing: border-box;
            }
 
            .logout-button:hover {
                background-color: #9ed5e9;
                color: #222222;
                transform: translateY(-3px);
            }
 
            /* スマートフォン対応 */
            @media screen and (max-width: 768px) {
                .operation-container {
                    padding: 15px 20px 30px;
                }
 
                .operation-title {
                    font-size: 22px;
                }
 
                .operation-menu {
                    gap: 30px;
                }
 
                .operation-button {
                    width: 90%;
                    min-height: 60px;
                    font-size: 16px;
                }
 
                .logout-button {
                    min-height: 55px;
                    font-size: 16px;
                }
            }
        </style>
    </c:param>
 
    <c:param name="content">
 
        <div class="operation-page">
 
            <div class="operation-container">
 
                <!-- タイトル -->
                <div class="operation-header">
                    <h1 class="operation-title">
                        パパトーク管理
                    </h1>
                </div>
 
                <!-- 管理メニュー -->
                <div class="operation-menu">
 
                    <!-- 投稿 -->
                    <a href="PostList.action"
                       class="operation-button">
                        投稿
                    </a>
 
                    <!-- 通報履歴 -->
                    <a href="/papatalk/scoremanager/main/Acquisition.action"
                       class="operation-button">
                        通報履歴
                    </a>
 
                    <!-- 通報一覧 -->
                    <a href="/papatalk/scoremanager/main/SingleScreenDisplay.action"
                       class="operation-button">
                        通報一覧
                    </a>
 
                    <!-- イベント -->
                    <a href="/papatalk/scoremanager/main/RetrieveListOrganizers.action"
                       class="operation-button">
                        イベント
                    </a>
 
                </div>
 
                <!-- 一番下のログアウトボタン -->
                <div class="logout-area">
                    <a href="/papatalk/scoremanager/main/Logout.action"
                       class="logout-button">
                        ログアウト
                    </a>
                </div>
 
            </div>
 
        </div>
 
    </c:param>
 
</c:import>
 