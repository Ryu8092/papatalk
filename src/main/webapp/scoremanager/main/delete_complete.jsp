
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:import url="/common/base.jsp">

    <c:param name="title" value="パパトークシステム｜アカウント削除完了" />

    <c:param name="content">

        <style>
            /* 完了アイコン */
   /* 完了アイコン */
.complete-icon {
    width: 85px;
    height: 85px;
    margin: 0 auto 25px;
    border-radius: 50%;
    background-color: #eaf6e6;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #79bd62;
    font-size: 75px;
    font-weight: bold;
    line-height: 1;
}


            /* タイトル */
            .complete-title {
                color: #24476b;
            }

            /* 手順 */
            .steps {
                margin: 20px 0 30px;
                font-size: 14px;
            }

            /* 戻るボタン */
            .complete-button {
                background: #ed9145;
                border: none;
                color: #ffffff;
                transition: background .2s;
            }

            .complete-button:hover {
                background: #d97c30;
                color: #ffffff;
            }
        </style>

        <div class="container py-5">
            <div class="mx-auto" style="max-width: 800px;">

                <!-- タイトル -->
                <div class="text-center mb-4">

                    <h2 class="fw-bold complete-title">
                        アカウント削除完了
                    </h2>

                    <p class="text-muted">
                        アカウントの削除が完了しました。
                    </p>

                </div>

                <!-- 削除手順 -->
                <div class="steps text-center">
                    <span style="color: #cccccc;">
                        ①削除確認
                    </span>

                    <span style="color: #79bd62; margin-left: 15px;">
                        ②削除完了
                    </span>
                </div>

                <!-- 削除完了カード -->
                <div class="card shadow-sm border-0 rounded-4">

                    <div class="card-body p-4 p-md-5 text-center">

                        <!-- 完了アイコン -->
                        <div class="complete-icon">
                        ✓
                        </div>

                        <h4 class="fw-bold text-success mb-3">
                            退会処理が完了しました！
                        </h4>

                        <p class="text-muted mb-4">
                            パパトークをご利用いただき、ありがとうございました。
                        </p>

                        <!-- ログイン画面へ戻る -->
                        <form action="../Login.action" method="get">

                            <button type="submit"
                                    class="btn complete-button rounded-pill px-5">
                                ログイン画面へ戻る
                            </button>

                        </form>

                    </div>

                </div>

            </div>
        </div>

    </c:param>

</c:import>
