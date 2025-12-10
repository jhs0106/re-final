<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    /* ===== 전체 레이아웃 (로그인 페이지 스타일 복사) ===== */

    .main-container.pets-mode {
        padding: 0 !important;
        height: 1000px;
        min-height: calc(100vh - 70px);
        background: linear-gradient(135deg, #fef2ff 0%, #e0f2fe 50%, #dcfce7 100%);
        display: flex;
        align-items: center;
        justify-content: center;
        padding-bottom: 60px;
    }

    .pets-page {
        width: 100%;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .pets-wrap {
        width: 100%;
        max-width: 1200px;
        padding: 16px;
        margin: 0 auto;
    }

    .pets-card {
        background-color: #ffffff;
        border-radius: 18px;
        box-shadow: 0 25px 60px rgba(15, 23, 42, 0.12);
        padding: 32px 28px 28px;
    }

    .pets-title {
        font-size: 24px;
        font-weight: 700;
        color: #111827;
        margin-bottom: 12px;
    }

    /* ===== 테이블 ===== */
    .pets-table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
        background: #fafafa;
        border-radius: 12px;
        overflow: hidden;
    }

    .pets-table th {
        background: #f3f4f6;
        padding: 12px;
        font-size: 14px;
        font-weight: 600;
        color: #374151;
        border-bottom: 1px solid #e5e7eb;
        text-align: center;
    }

    .pets-table td {
        padding: 12px;
        font-size: 14px;
        color: #111827;
        border-bottom: 1px solid #e5e7eb;
        text-align: center;
    }

    .pet-photo {
        width: 65px;
        height: 65px;
        object-fit: cover;
        border-radius: 12px;
        border: 1px solid #ddd;
    }

    tr:hover {
        background: #fef3f3;
    }
</style>
<style>
    /* 콘텐츠 영역 전체를 가운데로 모으는 래퍼 */
    .pet-page-wrap {
        width: 100%;
        min-height: calc(100vh - 120px); /* header 영역 제외 */
        display: flex;
        justify-content: center;   /* ▶ 중앙 정렬 핵심 */
        align-items: flex-start;   /* 위에서부터 시작 */
        padding: 40px 0;
        background: linear-gradient(135deg, #eef2ff 0%, #dcfce7 100%);
    }

    .pets-card {
        background-color: #ffffff;
        border-radius: 18px;
        box-shadow: 0 25px 60px rgba(15, 23, 42, 0.12);
        padding: 32px 28px 28px;

        /* ▶ 카드 살짝 오른쪽 이동 */
        margin-left: 100px;
    }
    .pet-title {
        font-size: 22px;
        font-weight: 700;
        margin-bottom: 20px;
    }
</style>

<div class="main-container pets-mode">
    <div class="pets-page">
        <div class="pets-wrap">

            <div class="pets-card">

                <div class="pets-title">전체 반려동물 정보</div>

                <table class="pets-table">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>이름</th>
                        <th>종류</th>
                        <th>품종</th>
                        <th>성별</th>
                        <th>나이</th>
                        <th>몸무게</th>
                        <th>사진</th>
                    </tr>
                    </thead>

                    <tbody>
                    <c:forEach items="${pets}" var="p">
                        <tr>
                            <td>${p.petId}</td>
                            <td>${p.name}</td>
                            <td>${p.type}</td>
                            <td>${p.breed}</td>
                            <td>${p.gender}</td>
                            <td>${p.age}</td>
                            <td>${p.weight}</td>
                            <td>
                                <c:if test="${not empty p.photo}">
                                    <img src="${p.photo}" class="pet-photo">
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>

                </table>

            </div>
        </div>
    </div>
</div>
