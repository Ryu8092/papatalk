<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
 
<c:import url="/common/base.jsp">
    <c:param name="title">イベント投稿完了</c:param>
 
    <c:param name="content">
 
        <style>
            .complete-container {
                border: 2px solid black;
                height: 400px;
                margin: 10px;
                position: relative;
                display: flex;
                justify-content: center;
                align-items: center;
                box-sizing: border-box;
            }
 
            .complete-message {
                font-size: 36px;
                font-weight: normal;
            }
 
            .button-area {
                position: absolute;
                bottom: 12px;
                left: 50%;
                transform: translateX(-50%);
            }
 
            .button-area button {
                width: 93px;
                height: 43px;
                border: 2px solid black;
                background-color: white;
                cursor: pointer;
            }
        </style>
 
        <div class="complete-container">
 
            <div class="complete-message">
                投稿が完了しました
            </div>
 
            <div class="button-area">
                <button type="button"
                    onclick="location.href='/papatalk/scoremanager/main/RetrieveListOrganizers.action'">
                    戻る
                </button>
            </div>
 
        </div>
 
    </c:param>
</c:import>