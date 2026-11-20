<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
 
<!DOCTYPE html>
<html lang="ja">
 
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
 
<title>お問い合わせ一覧</title>
 
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
      rel="stylesheet">
 
<style>
body {
    background-color: #f5f7fa;
    font-family: sans-serif;
}
 
.main-container {
    max-width: 950px;
    margin: 40px auto;
    padding: 0 20px;
}
 
.page-title {
    color: #24476b;
    font-size: 25px;
    font-weight: bold;
    margin-bottom: 25px;
}
 
.product-card {
    background: white;
    border-radius: 12px;
    padding: 22px;
    margin-bottom: 25px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.06);
}
 
.product-name {
    color: #24476b;
    font-size: 19px;
    font-weight: bold;
    margin-bottom: 15px;
}
 
.contact-item {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 15px;
    border-top: 1px solid #eee;
    gap: 15px;
}
 
.buyer-name {
    font-weight: bold;
    color: #333;
}
 
.message-btn {
    background: #ed9145;
    color: white;
    border: none;
    border-radius: 20px;
    padding: 8px 18px;
    text-decoration: none;
    font-size: 14px;
}
 
.message-btn:hover {
    background: #d87d32;
    color: white;
}
 
.empty-message {
    background: white;
    padding: 40px;
    text-align: center;
    border-radius: 12px;
    color: #777;
}
 
.back-btn {
    display: inline-block;
    background: #24476b;
    color: white;
    padding: 9px 25px;
    border-radius: 20px;
    text-decoration: none;
}
 
.back-btn:hover {
    background: #193550;
    color: white;
}
 
@media (max-width: 600px) {
    .contact-item {
        align-items: flex-start;
        flex-direction: column;
    }
}
</style>
 
</head>
 
<body>
 
<div class="main-container">
 
    <h2 class="page-title">お問い合わせ一覧</h2>
 
    <c:choose>
 
        <%-- お問い合わせがない場合 --%>
        <c:when test="${empty chatList}">
 
            <div class="empty-message">
                現在、お問い合わせはありません。
            </div>
 
        </c:when>
 
        <%-- お問い合わせがある場合 --%>
        <c:otherwise>
 
            <div class="product-card">
 
                <div class="product-name">
                    商品ID：${productId}
                </div>
 
                <c:forEach var="chat" items="${chatList}">
 
                    <div class="contact-item">
 
                        <div>
                            <div class="buyer-name">
                                <c:out value="${chat.user_name}"/>さん
                            </div>
                        </div>
 
                        <c:url var="chatUrl"
                               value="/scoremanager/main/AssignmentChat.action">
 
                            <c:param name="product_id"
                                     value="${productId}"/>
 
                            <c:param name="buyer_id"
                                     value="${chat.buyer_id}"/>
 
                        </c:url>
 
                        <a class="message-btn" href="${chatUrl}">
                            メッセージを見る
                        </a>
 
                    </div>
 
                </c:forEach>
 
            </div>
 
        </c:otherwise>
 
    </c:choose>
 
    <div class="text-center mt-4">
 
        <a href="javascript:history.back()" class="back-btn">
            戻る
        </a>
 
    </div>
 
</div>
 
</body>
</html>