
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html lang="ja">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title><c:out value="${param.title}" /></title>

    <!-- Bootstrap CSS -->
    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
        rel="stylesheet"
        integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
        crossorigin="anonymous">

    <!-- 共通CSS -->
    <style>
        html {
            min-height: 100%;
        }

        body {
            min-height: 100vh;
            margin: 0;
            background-color: #f4f7fb;
            color: #243b53;
            font-family: "Noto Sans JP", sans-serif;
        }

        #wrapper {
            width: 100%;
            max-width: 1200px;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            padding: 0;
            background-color: #f4f7fb;
        }

        #main-content {
            flex: 1;
            width: 100%;
            padding: 24px 16px 40px;
        }

        @media (max-width: 576px) {
            #main-content {
                padding: 16px 12px 30px;
            }
        }
    </style>

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>

    <!-- 各画面用スクリプト -->
    <c:if test="${not empty param.scripts}">
        ${param.scripts}
    </c:if>
</head>

<body>
    <div id="wrapper" class="container-fluid">

        <!-- 共通ヘッダー -->
        <jsp:include page="/common/header.jsp" />

        <!-- 各画面のコンテンツ -->
        <main id="main-content">
            ${param.content}
        </main>

        <!-- 共通フッター -->
        <jsp:include page="/common/footer.jsp" />

    </div>

    <!-- Bootstrap JavaScript -->
    <script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+Y6o9uZ2l5v5h5g5g5g5g5g5g5g5g"
        crossorigin="anonymous"></script>
</body>

</html>