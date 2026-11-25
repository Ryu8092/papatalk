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
			    width: 100%;
			    border: 2px solid black;
			    margin: 0 auto 16px;
			    padding: 15px;
			    box-sizing: border-box;
			    text-align: center;
			}
			
			#addPhotoButton {
			    padding: 8px 18px;
			    margin-top: 10px;
			    background-color: white;
			    border: 1px solid black;
			    cursor: pointer;
			}
			
			.preview-area {
			    display: flex;
			    flex-wrap: wrap;
			    justify-content: center;
			    gap: 15px;
			    margin-top: 15px;
			}
			
			.preview-item {
			    width: 120px;
			    position: relative;
			}
			
			.preview-item img {
			    width: 120px;
			    height: 100px;
			    object-fit: cover;
			    border: 1px solid #ccc;
			}
			
			.delete-photo {
			    width: 100%;
			    padding: 5px;
			    background-color: #e53935;
			    color: white;
			    border: none;
			    cursor: pointer;
			}
			
			.photo-count {
			    font-size: 13px;
			    margin-top: 8px;
			}
			
			.photo-count {
			    font-size: 13px;
			    margin-top: 8px;
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

			    <label>イベント写真（1〜6枚）</label>
			
			    <div>
			        <button type="button" id="addPhotoButton">
			            ＋ 写真を追加
			        </button>
			
			        <input
			            type="file"
			            id="eventImages"
			            accept="image/jpeg,image/png,image/gif"
			            multiple
			            hidden
			        >
			    </div>
			
			    <div class="photo-count" id="photoCount">
			        0 / 6 枚選択中
			    </div>
			
			    <div class="preview-area" id="previewArea"></div>
			
			</div>
 
			<form
			    action="EventOrganizerRegistration.action"
			    method="post"
			    enctype="multipart/form-data"
			    onsubmit="return validateImages()">
 
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
        <script>
		    // 選択した画像を管理する配列
		    let selectedImages = [];
		
		    const imageInput =
		        document.getElementById("eventImages");
		
		    const addPhotoButton =
		        document.getElementById("addPhotoButton");
		
		    const previewArea =
		        document.getElementById("previewArea");
		
		    const photoCount =
		        document.getElementById("photoCount");
		
		
		    // 写真追加ボタン
		    addPhotoButton.addEventListener("click", function() {
		        imageInput.click();
		    });
		
		
		    // 画像選択
		    imageInput.addEventListener("change", function() {
		
		        const files = Array.from(this.files);
		
		        for (const file of files) {
		
		            if (selectedImages.length >= 6) {
		                alert("写真は最大6枚までです。");
		                break;
		            }
		
		            // 画像形式チェック
		            if (!["image/jpeg", "image/png", "image/gif"]
		                    .includes(file.type)) {
		                alert("JPEG・PNG・GIF形式の画像を選択してください。");
		                continue;
		            }
		
		            selectedImages.push(file);
		        }
		
		        // 同じ画像を再度選択できるようにする
		        this.value = "";
		
		        displayPreviews();
		    });
		
		
		    // プレビュー表示
		    function displayPreviews() {
		
		        previewArea.innerHTML = "";
		
		        photoCount.textContent =
		            selectedImages.length + " / 6 枚選択中";
		
		        selectedImages.forEach((file, index) => {
		
		            const item = document.createElement("div");
		            item.className = "preview-item";
		
		            const img = document.createElement("img");
		
		            const imageUrl = URL.createObjectURL(file);
		            img.src = imageUrl;
		
		            img.onload = function() {
		                URL.revokeObjectURL(imageUrl);
		            };
		
		            const deleteButton =
		                document.createElement("button");
		
		            deleteButton.type = "button";
		            deleteButton.className = "delete-photo";
		            deleteButton.textContent = "削除";
		
		            // 個別削除
		            deleteButton.addEventListener("click", function() {
		
		                selectedImages.splice(index, 1);
		
		                displayPreviews();
		            });
		
		            item.appendChild(img);
		            item.appendChild(deleteButton);
		
		            previewArea.appendChild(item);
		        });
		    }
		
		
		    // フォーム送信前チェック
		    function validateImages() {
		
		        if (selectedImages.length < 1) {
		            alert("写真を最低1枚選択してください。");
		            return false;
		        }
		
		        // 選択した画像を送信用FormDataに追加
		        const form = document.querySelector("form");
		        const formData = new FormData(form);
		
		        selectedImages.forEach(file => {
		            formData.append("images", file);
		        });
		
		        // FormDataを使って送信
		        fetch(form.action, {
		            method: "POST",
		            body: formData
		        })
		        .then(response => {
		            if (response.redirected) {
		                window.location.href = response.url;
		            } else {
		                return response.text().then(html => {
		                    document.open();
		                    document.write(html);
		                    document.close();
		                });
		            }
		        })
		        .catch(error => {
		            alert("送信に失敗しました。");
		            console.error(error);
		        });
		
		        return false;
		    }
		</script>
 
    </c:param>
</c:import>