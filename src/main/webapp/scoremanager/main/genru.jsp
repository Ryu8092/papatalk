<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<c:import url="/common/base.jsp">
	<c:param name="title">マッチング設定 - パパトーク</c:param>
	<c:param name="scripts"></c:param>
	<c:param name="content">

		<style>
.setting-layout {
	display: flex;
	gap: 24px;
	align-items: flex-start;
	min-height: 70vh;
}

.setting-sidebar {
	flex: 0 0 240px;
	background: #fff;
	border-radius: 14px;
	box-shadow: 0 4px 16px rgba(31, 55, 85, .08);
	padding: 20px;
}

.setting-main {
	flex: 1;
	min-width: 0;
	padding: 28px;
	background: #fff;
	border-radius: 14px;
	box-shadow: 0 4px 16px rgba(31, 55, 85, .08);
}

.setting-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	gap: 16px;
	margin-bottom: 35px;
}

.setting-title {
	color: #24476b;
	font-size: 26px;
	font-weight: 700;
	padding-bottom: 12px;
	border-bottom: 3px solid #ed9145;
	margin: 0;
}

.header-buttons {
	display: flex;
	gap: 10px;
}

.header-buttons a {
	padding: 10px 16px;
	border: 1px solid #cbd5e1;
	border-radius: 7px;
	color: #24476b;
	text-decoration: none;
	font-size: 13px;
	white-space: nowrap;
}

.setting-grid {
	display: grid;
	grid-template-columns: repeat(2, minmax(0, 1fr));
	gap: 24px 28px;
}

.form-group label, .hobby-label {
	display: block;
	margin-bottom: 9px;
	color: #24476b;
	font-weight: 600;
}

.form-group select, .hobby-search select {
	width: 100%;
	padding: 12px;
	border: 1px solid #d5e0ee;
	border-radius: 8px;
	background: #fff;
	color: #24476b;
	font-size: 14px;
	box-sizing: border-box;
}

.hobby-section {
	margin-top: 32px;
}

.hobby-search {
	display: flex;
	gap: 8px;
}

.hobby-search select {
	flex: 1;
	min-width: 0;
}

.hobby-search button, .clear-button {
	padding: 10px 16px;
	border: 1px solid #cbd5e1;
	border-radius: 7px;
	background: #fff;
	color: #24476b;
	cursor: pointer;
}

.selected-hobbies {
	min-height: 100px;
	margin-top: 18px;
	padding: 18px;
	border: 1px solid #dce6f3;
	border-radius: 10px;
}

.selected-hobbies h3 {
	margin: 0 0 16px;
	color: #24476b;
	font-size: 16px;
}

.hobby-tags {
	display: flex;
	flex-wrap: wrap;
	gap: 10px;
}

.hobby-tag {
	display: inline-flex;
	align-items: center;
	gap: 8px;
	padding: 8px 12px;
	border-radius: 20px;
	background: #edf3fa;
	color: #24476b;
	font-size: 14px;
}

.hobby-tag button {
	border: none;
	background: transparent;
	color: #718096;
	cursor: pointer;
	font-size: 16px;
}

.setting-actions {
	display: flex;
	justify-content: center;
	margin-top: 36px;
}

.filter-button {
	padding: 17px 42px;
	border: none;
	border-radius: 9px;
	background: #ed9145;
	color: #fff;
	font-size: 16px;
	font-weight: 700;
	cursor: pointer;
}

.filter-button:hover {
	background: #dc7f32;
}

@media ( max-width : 900px) {
	.setting-layout {
		flex-direction: column;
	}
	.setting-sidebar {
		width: 100%;
		box-sizing: border-box;
		flex-basis: auto;
	}
	.setting-main {
		width: 100%;
		box-sizing: border-box;
	}
}

@media ( max-width : 600px) {
	.setting-main {
		padding: 18px;
	}
	.setting-header {
		align-items: flex-start;
		flex-direction: column;
	}
	.setting-grid {
		grid-template-columns: 1fr;
	}
	.header-buttons {
		flex-wrap: wrap;
	}
}
</style>

		<div class="setting-layout">

			<aside class="setting-sidebar">
				<jsp:include page="/common/sidebar.jsp" />
			</aside>

			<main class="setting-main">

				<div class="setting-header">
					<h2 class="setting-title">マッチング設定</h2>

					<div class="header-buttons">
						<a href="#hobby">こだわり条件</a> <a
							href="${pageContext.request.contextPath}/scoremanager/main/match_list.jsp">戻る</a>
					</div>
				</div>

				<form
					action="${pageContext.request.contextPath}/scoremanager/main/GetUser.action"
					method="post">

					<div class="setting-grid">

						<div class="form-group">
							<label for="childAge">子供の年齢</label> <select id="childAge"
								name="child_age">
								<option value="">なし</option>
								<option value="0">0歳</option>
								<option value="1">1歳</option>
								<option value="2">2歳</option>
								<option value="3">3歳</option>
								<option value="4">4歳</option>
								<option value="5">5歳</option>
								<option value="6">6歳</option>
								<option value="小学生">小学生</option>
								<option value="中学生以上">中学生以上</option>
							</select>
						</div>

						<div class="form-group">
							<label for="fatherAge">パパの年齢</label> <select id="fatherAge"
								name="father_age">
								<option value="">なし</option>
								<option value="20代">20代</option>
								<option value="30代">30代</option>
								<option value="40代">40代</option>
								<option value="50代以上">50代以上</option>
							</select>
						</div>

						<div class="form-group">
							<label for="region">お住まいの地域</label> <select id="region"
								name="region">
								<option value="">指定なし</option>
								<option>北海道</option>
								<option>東北</option>
								<option>関東</option>
								<option>中部</option>
								<option>近畿</option>
								<option>中国</option>
								<option>四国</option>
								<option>九州・沖縄</option>
							</select>
						</div>

						<div class="form-group">
							<label for="destination">移住地</label> <select id="destination"
								name="destination">
								<option value="">なし</option>
								<option>北海道</option>
								<option>青森県</option>
								<option>岩手県</option>
								<option>宮城県</option>
								<option>秋田県</option>
								<option>山形県</option>
								<option>福島県</option>
								<option>東京都</option>
								<option>神奈川県</option>
								<option>埼玉県</option>
								<option>千葉県</option>
								<option>指定なし</option>
							</select>
						</div>

					</div>

					<div class="hobby-section" id="hobby">
						<label class="hobby-label" for="hobbySelect">
							趣味（スポーツ・野球など） </label>

						<div class="hobby-search">
							<select id="hobbySelect">
								<option value="">趣味を選択してください</option>

								<c:forEach var="hobby" items="${hobbyList}">
									<option value="${hobby}">${hobby}</option>
								</c:forEach>
							</select>

							<button type="button" id="addHobby">追加</button>
						</div>

						<div class="selected-hobbies">
							<h3>選択した趣味</h3>
							<div class="hobby-tags" id="hobbyTags"></div>
						</div>

						<input type="hidden" name="hobbies" id="hobbiesInput">

					</div>

					<div class="setting-actions">
						<button type="submit" class="filter-button">この条件で絞り込む</button>
					</div>

				</form>

			</main>
		</div>

		<script>
(function () {
    const select = document.getElementById("hobbySelect");
    const addButton = document.getElementById("addHobby");
    const tags = document.getElementById("hobbyTags");
    const hiddenInput = document.getElementById("hobbiesInput");
    const selected = [];
 
    function updateHobbies() {
        tags.innerHTML = "";
 
        selected.forEach(function (hobby) {
            const tag = document.createElement("span");
            tag.className = "hobby-tag";
 
            const name = document.createElement("span");
            name.textContent = hobby;
 
            const remove = document.createElement("button");
            remove.type = "button";
            remove.textContent = "×";
            remove.setAttribute("aria-label", hobby + "を削除");
 
            remove.addEventListener("click", function () {
                const index = selected.indexOf(hobby);
 
                if (index !== -1) {
                    selected.splice(index, 1);
                }
 
                updateHobbies();
            });
 
            tag.appendChild(name);
            tag.appendChild(remove);
            tags.appendChild(tag);
        });
 
        hiddenInput.value = selected.join(",");
    }
 
    addButton.addEventListener("click", function () {
        const hobby = select.value;
 
        if (hobby && !selected.includes(hobby)) {
            selected.push(hobby);
            updateHobbies();
        }
 
        select.value = "";
    });
})();
</script>

	</c:param>
</c:import>