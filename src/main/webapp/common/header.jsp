<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<header class="d-flex flex-wrap justify-content-between align-items-center
               gap-3 px-4 px-md-5 py-3 mb-4
               border-bottom border-2 shadow-sm"
        style="background: linear-gradient(120deg, #eef6ff, #ffffff);">

    <!-- ロゴ・タイトル -->
    <div class="d-flex align-items-center gap-3">
        <div class="d-flex align-items-center justify-content-center rounded-3"
             style="width: 52px; height: 52px; background-color: #dbeafe;">
            <i class="bi bi-chat-heart-fill"
               style="font-size: 1.8rem; color: #2563eb;"></i>
        </div>

        <div>
            <h1 class="h3 fw-bold mb-1" style="color: #1e3a5f;">
                ぱぱとーく。
            </h1>
            <p class="small mb-0 text-secondary">
                つながる毎日、広がる会話。
            </p>
        </div>
    </div>

    <!-- ログインユーザー情報 -->
    <c:if test="${not empty user}">
        <div class="d-flex align-items-center gap-2
                    rounded-pill px-3 py-2"
             style="background-color: #ffffff;
                    border: 1px solid #dbeafe;">

            <i class="bi bi-person-circle"
               style="font-size: 1.5rem; color: #2563eb;"></i>

            <div>
                <div class="small text-secondary">ログイン中</div>
                <div class="fw-semibold" style="color: #1e3a5f;">
                    こんにちは！${user.user_name} さん
                </div>
            </div>
        </div>
    </c:if>

</header>