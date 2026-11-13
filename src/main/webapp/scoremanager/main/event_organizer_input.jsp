<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
 
<c:import url="/common/base.jsp">
    <c:param name="title">イベント投稿</c:param>
 
    <c:param name="content">
 
        <style>
            .event-input-container {
                border: 2px solid black;
                padding: 18px 45px 20px;
                margin: 10px;
                min-height: 540px;
                box-sizing: border-box;
            }
 
            .photo-area {
                width: 150px;
                height: 60px;
                border: 2px solid black;
                margin: 0 auto 16px;
                display: flex;
                justify-content: center;
                align-items: center;
            }
 
            .input-group {
                margin-bottom: 8px;
            }
 
            .input-group label {
                display: block;
                font-size: 13px;
                margin-bottom: 5px;
            }
 
            .input-group input {
                width: 250px;
                height: 29px;
                border: 2px solid black;
                box-sizing: border-box;
            }
 
            .overview-group {
                margin-top: 20px;
            }
 
            .overview-group label {
                display: block;
                font-size: 13px;
                margin-bottom: 5px;
            }
 
            .overview-group textarea {
                width: 100%;
                height: 102px;
                border: 2px solid black;
                box-sizing: border-box;
                resize: none;
            }
 
            .button-area {
                display: flex;
                justify-content: center;
                gap: 105px;
                margin-top: 20px;
            }
 
            .button-area button {
                width: 93px;
                height: 43px;
                border: 2px solid black;
                background-color: white;
                cursor: pointer;
            }
        </style>
 
        <div class="event-input-container">
 
            <div class="photo-area">
                写真
            </div>
 
            <form action="EventOrganizerRegistration.action" method="post">
 
                <div class="input-group">
                    <label>タイトル</label>
                    <input type="text" name="title">
                </div>
 
                <div class="input-group">
                    <label>開催日時</label>
                    <input type="datetime-local" name="event_date">
                </div>
 
                <div class="input-group">
                    <label>締切日</label>
                    <input type="date" name="deadline">
                </div>
 
                <div class="input-group">
                    <label>定員</label>
                    <input type="number" name="capacity">
                </div>
 
                <div class="input-group">
                    <label>開催場所</label>
                    <input type="text" name="event_place">
                </div>
 
                <div class="overview-group">
                    <label>イベント概要</label>
                    <textarea name="event_details"></textarea>
                </div>
 
                <div class="button-area">
                    <button type="button" onclick="history.back()">
                        戻る
                    </button>
 
                    <button type="submit">
                        投稿
                    </button>
                </div>
 
            </form>
 
        </div>
 
    </c:param>
</c:import>