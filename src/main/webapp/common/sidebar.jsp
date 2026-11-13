
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

    
	.papa-sidebar form {
	    margin: 0;
	}
	
	.papa-sidebar button {
	    display: flex;
	    align-items: center;
	    gap: 12px;
	    width: 100%;
	    min-height: 46px;
	    padding: 11px 13px;
	    box-sizing: border-box;
	    border: none;
	    border-radius: 9px;
	    background: transparent;
	    color: #f5f8fc;
	    font-size: 14px;
	    font-weight: 600;
	    font-family: inherit;
	    text-align: left;
	    cursor: pointer;
	    transition: background .2s, color .2s, transform .2s;
	}
	
	.papa-sidebar button:hover,
	.papa-sidebar button:focus-visible {
	    background: #fff;
	    color: #24476b;
	    transform: translateX(3px);
	    outline: none;
	}
	
	.papa-sidebar .sidebar-logout button:hover {
	    color: #b43c3c;
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

    <div class="papa-sidebar-brand">
        <h2>🗨️ ぱぱトーク</h2>
        <p>つながる、話せる、支え合える。</p>
    </div>

    <ul>
        <!-- マッチング -->
        <li>
            <form action="${pageContext.request.contextPath}/scoremanager/main/MatchList.action" method="get">
                <button type="submit">
                    <span class="sidebar-icon">🤝</span>
                    <span>マッチング</span>
                </button>
            </form>
        </li>

        <!-- 掲示板 -->
        <li>
            <form action="${pageContext.request.contextPath}/scoremanager/main/RetrievePosts.action" method="get">
                <button type="submit">
                    <span class="sidebar-icon">📋</span>
                    <span>掲示板</span>
                </button>
            </form>
        </li>

        <!-- イベント -->
        <li>
            <form action="${pageContext.request.contextPath}/scoremanager/main/RetrieveEvents.action" method="get">
                <button type="submit">
                    <span class="sidebar-icon">📅</span>
                    <span>イベント</span>
                </button>
            </form>
        </li>

        <!-- おさがり -->
        <li>
            <form action="${pageContext.request.contextPath}/scoremanager/main/assignment_list.jsp" method="get">
                <button type="submit">
                    <span class="sidebar-icon">🧸</span>
                    <span>おさがり</span>
                </button>
            </form>
        </li>

        <!-- サブスク限定 -->
        <li>
            <form action="${pageContext.request.contextPath}/scoremanager/main/subscription_list.jsp" method="get">
                <button type="submit">
                    <span class="sidebar-icon">⭐</span>
                    <span>サブスク限定</span>
                </button>
            </form>
        </li>

        <!-- アカウント -->
        <li>
            <form action="${pageContext.request.contextPath}/scoremanager/main/AccountinFormation.action" method="get">
                <button type="submit">
                    <span class="sidebar-icon">👤</span>
                    <span>アカウント</span>
                </button>
            </form>
        </li>

        <!-- ログアウト -->
        <li class="sidebar-logout">
            <form action="${pageContext.request.contextPath}/scoremanager/main/Logout.action" method="get">
                <button type="submit">
                    <span class="sidebar-icon">🚪</span>
                    <span>ログアウト</span>
                </button>
            </form>
        </li>
    </ul>
</nav>
