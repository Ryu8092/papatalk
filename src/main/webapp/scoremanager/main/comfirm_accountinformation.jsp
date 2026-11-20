
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:import url="/common/base.jsp">
    <c:param name="title" value="パパトーク｜変更完了" />
    <c:param name="content">

        <style>
            .complete-icon {
                width: 80px;
                height: 80px;
                border-radius: 50%;
                background: #e5f6e9;
                color: #36a653;
                font-size: 48px;
                font-weight: bold;
                display: flex;
                justify-content: center;
                align-items: center;
                margin: 0 auto 25px;
            }

            .complete-title {
                color: #24476b;
            }

            .complete-button {
                background: #ed9145;
                border: none;
                color: #fff;
                transition: background .2s;
            }

            .complete-button:hover {
                background: #d97c30;
                color: #fff;
            }
        </style>

        <div class="container py-5">

            <div class="mx-auto" style="max-width: 800px;">

                <!-- タイトル -->
                <div class="text-center mb-4">

                    <h2 class="fw-bold complete-title">
                        変更完了
                    </h2>

                    <p class="text-muted">
                        アカウント情報の変更が完了しました。
                    </p>

                </div>

                <!-- 変更完了メッセージ -->
                <div class="card shadow-sm border-0 rounded-4">

                    <div class="card-body p-4 p-md-5 text-center">

                        <!-- 完了アイコン：最初のJSPと同じデザイン -->
                        <div class="complete-icon">
                            ✓
                        </div>

                        <h4 class="fw-bold text-success mb-3">
                            アカウント情報の変更が完了しました！
                        </h4>

                        <p class="text-muted mb-4">
                            パパトークをご利用いただきありがとうございます。<br>
                            ぜひ、ほかのパパとの交流をお楽しみください。
                        </p>

                        <!-- マッチング画面へ -->
                        <form action="MatchList.action" method="get">

                            <button type="submit"
                                    class="btn complete-button rounded-pill px-5">
                                マッチング画面へ戻る
                            </button>

                        </form>

                    </div>

                </div>

            </div>

        </div>

    </c:param>
</c:import>
