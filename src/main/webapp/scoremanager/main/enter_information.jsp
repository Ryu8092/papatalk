
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>パパトークシステム｜情報入力</title>

<style>
* {
    box-sizing: border-box;
}

body {
    margin: 0;
    padding: 30px 15px;
    background-color: #f4f6f9;
    font-family: sans-serif;
    color: #333;
}

/* ページタイトル */
.page-title {
    text-align: center;
    color: #24476b;
    font-size: 26px;
    margin: 20px 0 10px;
}

/* 進捗バー */
.step-container {
    display: flex;
    justify-content: space-between;
    width: 600px;
    max-width: 95%;
    margin: 35px auto;
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
    background-color: #24476b;
}

.step-inactive {
    background-color: #bdbdbd;
}

.step-label {
    font-size: 13px;
}

/* 入力フォーム */
.form-container {
    width: 500px;
    max-width: 100%;
    margin: 30px auto;
    padding: 35px;
    background-color: white;
    border-radius: 12px;
    box-shadow: 0 3px 12px rgba(0,0,0,0.08);
}

.form-title {
    text-align: center;
    color: #24476b;
    font-size: 21px;
    font-weight: bold;
    margin-bottom: 25px;
}

.form-container label {
    display: block;
    margin-bottom: 7px;
    font-weight: bold;
    font-size: 14px;
}

.form-container input[type="text"],
.form-container input[type="password"],
.form-container input[type="email"],
.form-container input[type="number"],
.form-container input[type="file"],
.form-container select {
    width: 100%;
    padding: 11px;
    font-size: 15px;
    margin-bottom: 18px;
    border: 1px solid #ccc;
    border-radius: 6px;
    background-color: #fff;
}

.form-container input:focus,
.form-container select:focus {
    outline: none;
    border-color: #24476b;
    box-shadow: 0 0 4px rgba(36,71,107,0.2);
}

.form-container input[readonly] {
    background-color: #eee;
}

/* エラーメッセージ */
.error-message {
    color: #d93025;
    font-size: 12px;
    margin-top: -12px;
    margin-bottom: 15px;
}

.message {
    color: #d93025;
    font-size: 13px;
    text-align: center;
    margin-bottom: 20px;
}

/* ボタン配置 */
.button-area {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 12px;
    margin-top: 20px;
}

button {
    width: 220px;
    padding: 12px;
    border: none;
    border-radius: 25px;
    font-size: 15px;
    font-weight: bold;
    cursor: pointer;
    transition: 0.2s;
}

/* 送信ボタン */
.submit-button {
    background-color: #ed9145;
    color: white;
}

.submit-button:hover {
    background-color: #d77c32;
}

/* 戻るボタン */
.back-button {
    background-color: #24476b;
    color: white;
}

.back-button:hover {
    background-color: #193651;
}

/* スマホ対応 */
@media (max-width: 600px) {
    .form-container {
        padding: 25px 18px;
    }

    .step-label {
        font-size: 11px;
    }

    .step-box {
        width: 25%;
    }

    .page-title {
        font-size: 22px;
    }
}
</style>
</head>

<body>

<h1 class="page-title">情報入力</h1>

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

    <div class="form-title">会員情報を入力してください</div>

    <c:if test="${not empty message}">
        <p class="message">
            <c:out value="${message}" />
        </p>
    </c:if>

    <form action="/papatalk/scoremanager/main/Registration.action"
          method="post" enctype="multipart/form-data">

        <label>名前</label>
        <input type="text" name="username"
               value="<c:out value='${param.username}'/>" required>

        <c:if test="${not empty usernameError}">
            <p class="error-message">
                <c:out value="${usernameError}"/>
            </p>
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
            <p class="error-message">
                <c:out value="${passwordError}"/>
            </p>
        </c:if>

        <label>年齢</label>
        <input type="number" name="age" min="0" max="150"
               value="<c:out value='${param.age}'/>" required>

        <c:if test="${not empty ageError}">
            <p class="error-message">
                <c:out value="${ageError}"/>
            </p>
        </c:if>

        <label>ニックネーム</label>
        <input type="text" name="nickname"
               value="<c:out value='${param.nickname}'/>">

        <label>電話番号</label>
        <input type="text" name="phone"
               value="<c:out value='${param.phone}'/>" required>

        <c:if test="${not empty phoneError}">
            <p class="error-message">
                <c:out value="${phoneError}"/>
            </p>
        </c:if>

        <label>郵便番号</label>
        <input type="text" name="zipcode"
               value="<c:out value='${param.zipcode}'/>" required>

        <c:if test="${not empty zipcodeError}">
            <p class="error-message">
                <c:out value="${zipcodeError}"/>
            </p>
        </c:if>

        <label>都道府県</label>
        <input type="text" name="prefecture"
               value="<c:out value='${param.prefecture}'/>" required>

        <c:if test="${not empty prefectureError}">
            <p class="error-message">
                <c:out value="${prefectureError}"/>
            </p>
        </c:if>

        <label>市区町村</label>
        <input type="text" name="city"
               value="<c:out value='${param.city}'/>" required>

        <c:if test="${not empty cityError}">
            <p class="error-message">
                <c:out value="${cityError}"/>
            </p>
        </c:if>

        <label>番地</label>
        <input type="text" name="address"
               value="<c:out value='${param.address}'/>" required>

        <c:if test="${not empty addressError}">
            <p class="error-message">
                <c:out value="${addressError}"/>
            </p>
        </c:if>

        <label>建物名・部屋番号</label>
        <input type="text" name="building"
               value="<c:out value='${param.building}'/>">

        <label>お子さんの年齢</label>
        <input type="number" name="child_age" min="0" max="150"
               value="<c:out value='${param.child_age}'/>" required>

        <c:if test="${not empty childAgeError}">
            <p class="error-message">
                <c:out value="${childAgeError}"/>
            </p>
        </c:if>

        <label>お子さんの性別</label>
        <select name="child_gender" required>
            <option value="">選択してください</option>

            <option value="男子"
                ${param.child_gender == '男子' ? 'selected' : ''}>
                男の子
            </option>

            <option value="女子"
                ${param.child_gender == '女子' ? 'selected' : ''}>
                女の子
            </option>
        </select>

        <c:if test="${not empty childGenderError}">
            <p class="error-message">
                <c:out value="${childGenderError}"/>
            </p>
        </c:if>

        <label>プロフィール画像</label>
        <input type="file" name="avatar"
               accept="image/jpeg,image/png,image/gif"
               required>

        <!-- 送信ボタン -->
        <div class="button-area">
            <button type="submit" class="submit-button">
                送信
            </button>
        </div>

    </form>

    

</div>

</body>
</html>
