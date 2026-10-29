<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>情報入力</title>

<style>
/* 進捗バー */
.step-container {
    display: flex;
    justify-content: space-between;
    width: 600px;
    max-width: 95%;
    margin: 40px auto;
    font-family: sans-serif;
}
.step-box {
    text-align: center;
    width: 120px;
}
.step-number {
    width: 40px;
    height: 40px;
    line-height: 40px;
    border-radius: 50%;
    margin: 0 auto 10px;
    font-weight: bold;
    color: white;
}
.step-active {
    background-color: #4CAF50;
}
.step-inactive {
    background-color: #BDBDBD;
}
.step-label {
    font-size: 14px;
}

/* 入力フォーム */
.form-container {
    width: 400px;
    max-width: 95%;
    margin: 30px auto;
    font-family: sans-serif;
}
.form-container input[type="text"],
.form-container input[type="password"],
.form-container input[type="email"],
.form-container input[type="number"],
.form-container select {
    width: 100%;
    padding: 10px;
    font-size: 16px;
    margin-bottom: 15px;
    box-sizing: border-box;
}
.form-container label {
    display: block;
    margin-bottom: 5px;
}
.error-message {
    color: red;
    font-size: 11px;
    margin-top: -10px;
    margin-bottom: 10px;
}
.message {
    color: red;
    font-size: 13px;
    text-align: center;
}
button {
    display: block;
    margin: 0 auto;
    width: 200px;
    padding: 12px;
    background-color: #2196F3;
    color: #000;
    border: none;
    border-radius: 4px;
    font-size: 18px;
    cursor: pointer;
}
button:hover {
    background-color: #1976D2;
}
</style>
</head>

<body>

<!-- 進捗バー -->
<div class="step-container">
    <div class="step-box">
        <div class="step-number step-inactive">1</div>
        <div class="step-label">登録</div>
    </div>
    <div class="step-box">
        <div class="step-number step-inactive">2</div>
        <div class="step-label">メール認証</div>
    </div>
    <div class="step-box">
        <div class="step-number step-active">3</div>
        <div class="step-label">情報を入力</div>
    </div>
    <div class="step-box">
        <div class="step-number step-inactive">4</div>
        <div class="step-label">完了</div>
    </div>
</div>

<!-- 情報入力フォーム -->
<div class="form-container">

    <c:if test="${not empty message}">
        <p class="message"><c:out value="${message}" /></p>
    </c:if>

    <form action="/papatalk/scoremanager/main/Registration.action" method="post">

        <label>名前</label>
        <input type="text" name="username"
               value="<c:out value='${param.username}'/>" required>
        <c:if test="${not empty usernameError}">
            <p class="error-message"><c:out value="${usernameError}"/></p>
        </c:if>
        
		<label>メールアドレス</label>
		<input type="email" name="email"
		       value="<c:out value='${email}'/>" readonly>
		
		<c:if test="${not empty emailError}">
		    <p class="error-message">
		        <c:out value="${emailError}"/>
		    </p>
		</c:if>

        <label>パスワード</label>
        <input type="password" name="password"
               autocomplete="new-password" required>
        <c:if test="${not empty passwordError}">
            <p class="error-message"><c:out value="${passwordError}"/></p>
        </c:if>

        <label>年齢</label>
        <input type="number" name="age" min="0" max="150"
               value="<c:out value='${param.age}'/>" required>
        <c:if test="${not empty ageError}">
            <p class="error-message"><c:out value="${ageError}"/></p>
        </c:if>

        <label>ニックネーム</label>
        <input type="text" name="nickname"
               value="<c:out value='${param.nickname}'/>">

        <label>電話番号</label>
        <input type="text" name="phone"
               value="<c:out value='${param.phone}'/>" required>
        <c:if test="${not empty phoneError}">
            <p class="error-message"><c:out value="${phoneError}"/></p>
        </c:if>

        <label>郵便番号</label>
        <input type="text" name="zipcode"
               value="<c:out value='${param.zipcode}'/>" required>
        <c:if test="${not empty zipcodeError}">
            <p class="error-message"><c:out value="${zipcodeError}"/></p>
        </c:if>

        <label>都道府県</label>
        <input type="text" name="prefecture"
               value="<c:out value='${param.prefecture}'/>" required>
        <c:if test="${not empty prefectureError}">
            <p class="error-message"><c:out value="${prefectureError}"/></p>
        </c:if>

        <label>市区町村</label>
        <input type="text" name="city"
               value="<c:out value='${param.city}'/>" required>
        <c:if test="${not empty cityError}">
            <p class="error-message"><c:out value="${cityError}"/></p>
        </c:if>

        <label>番地</label>
        <input type="text" name="address"
               value="<c:out value='${param.address}'/>" required>
        <c:if test="${not empty addressError}">
            <p class="error-message"><c:out value="${addressError}"/></p>
        </c:if>

        <label>建物名・部屋番号</label>
        <input type="text" name="building"
               value="<c:out value='${param.building}'/>">

        <label>お子さんの年齢</label>
        <input type="number" name="child_age" min="0" max="150"
               value="<c:out value='${param.child_age}'/>" required>
        <c:if test="${not empty childAgeError}">
            <p class="error-message"><c:out value="${childAgeError}"/></p>
        </c:if>

        <label>お子さんの性別</label>
        <select name="child_gender" required>
            <option value="">選択してください</option>
            <option value="男子"
                ${param.child_gender == 'male' ? 'selected' : ''}>男の子</option>
            <option value="女子"
                ${param.child_gender == 'female' ? 'selected' : ''}>女の子</option>
        </select>
        <c:if test="${not empty childGenderError}">
            <p class="error-message"><c:out value="${childGenderError}"/></p>
        </c:if>

        <button type="submit">送信</button>
    </form>
</div>

</body>
</html>
