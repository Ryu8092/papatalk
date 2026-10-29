
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<style>
    .papa-sidebar {
        width: 100%;
        min-height: 40rem;
        padding: 24px 14px;
        box-sizing: border-box;
        background: linear-gradient(180deg, #173b60, #24476b);
        border-radius: 14px;
        font-family: sans-serif;
    }

    .papa-sidebar-brand {
        padding: 0 10px 24px;
        border-bottom: 1px solid rgba(255,255,255,.22);
        margin-bottom: 22px;
    }

    .papa-sidebar-brand h2 {
        margin: 0 0 8px;
        color: #fff;
        font-size: 23px;
        font-weight: 800;
    }

    .papa-sidebar-brand p {
        margin: 0;
        color: #d6e5f3;
        font-size: 11px;
        line-height: 1.6;
    }

    .papa-sidebar ul {
        margin: 0;
        padding: 0;
        list-style: none;
    }

    .papa-sidebar li {
        margin-bottom: 8px;
    }

    .papa-sidebar a {
        display: flex;
        align-items: center;
        gap: 12px;
        min-height: 46px;
        padding: 11px 13px;
        box-sizing: border-box;
        border-radius: 9px;
        color: #f5f8fc;
        font-size: 14px;
        font-weight: 600;
        text-decoration: none;
        transition: background .2s, color .2s, transform .2s;
    }

    .papa-sidebar a:hover,
    .papa-sidebar a:focus-visible {
        background: #fff;
        color: #24476b;
        transform: translateX(3px);
        outline: none;
    }

    .papa-sidebar .sidebar-icon {
        display: inline-flex;
        justify-content: center;
        align-items: center;
        flex-shrink: 0;
        width: 25px;
        font-size: 19px;
    }

    .papa-sidebar .sidebar-logout {
        margin-top: 25px;
        padding-top: 17px;
        border-top: 1px solid rgba(255,255,255,.25);
    }

    .papa-sidebar .sidebar-logout a:hover {
        color: #b43c3c;
    }

    @media (max-width: 768px) {
        .papa-sidebar {
            min-height: auto;
            padding: 18px 12px;
        }

        .papa-sidebar-brand {
            padding-bottom: 16px;
            margin-bottom: 14px;
        }

        .papa-sidebar a {
            min-height: 42px;
        }
    }
</style>

<nav class="papa-sidebar" aria-label="パパトークのメインメニュー">

    <!-- ブランド -->
    <div class="papa-sidebar-brand">
        <h2>🗨️ ぱぱトーク</h2>
        <p>つながる、話せる、支え合える。</p>
    </div>

    <ul>
        <!-- マッチング -->
        <li>
            <c:url value="/scoremanager/main/MatchList.action"
                var="url_match" />
            <a href="${url_match}">
                <span class="sidebar-icon">🤝</span>
                <span>マッチング</span>
            </a>
        </li>

        <!-- チャット -->
        <li>
            <c:url value="/scoremanager/main/chat_list.jsp"
                var="url_chat_list" />
            <a href="${url_chat_list}">
                <span class="sidebar-icon">💬</span>
                <span>チャット</span>
            </a>
        </li>

        <!-- イベント -->
        <li>
            <c:url value="/scoremanager/main/event_list.jsp"
                var="url_event_list" />
            <a href="${url_event_list}">
                <span class="sidebar-icon">📅</span>
                <span>掲示板</span>
            </a>
        </li>

        <!-- おさがり -->
        <li>
            <c:url value="/scoremanager/main/assignment_list.jsp"
                var="url_assignment_list" />
            <a href="${url_assignment_list}">
                <span class="sidebar-icon">🧸</span>
                <span>おさがり</span>
            </a>
        </li>

        <!-- サブスク限定 -->
        <li>
            <c:url value="/scoremanager/main/subscription_list.jsp"
                var="url_subscription_list" />
            <a href="${url_subscription_list}">
                <span class="sidebar-icon">⭐</span>
                <span>サブスク限定</span>
            </a>
        </li>

        <!-- アカウント -->
        <li>
            <c:url value="/scoremanager/main/AccountinFormation.action"
                var="url_account_list" />
            <a href="${url_account_list}">
                <span class="sidebar-icon">👤</span>
                <span>アカウント</span>
            </a>
        </li>

        <!-- ログアウト -->
        <li class="sidebar-logout">
            <c:url value="/scoremanager/main/Logout.action"
                var="url_logout_list" />
            <a href="${url_logout_list}">
                <span class="sidebar-icon">🚪</span>
                <span>ログアウト</span>
            </a>
        </li>
    </ul>

</nav>