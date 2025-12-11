<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    /* ===== 전체 레이아웃 (공통 로그인 페이지 느낌) ===== */
    .main-container.user-mode {
        padding: 0 !important;
        min-height: calc(100vh - 70px);
        background: linear-gradient(135deg, #fef2ff 0%, #e0f2fe 50%, #dcfce7 100%);
        display: flex;
        align-items: center;
        justify-content: center;
        padding-bottom: 60px;
    }

    .user-page {
        width: 100%;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .user-wrap {
        width: 100%;
        max-width: 1200px;
        padding: 16px;
        margin: 0 auto;
    }

    /* ===== 카드 영역 ===== */
    .user-card {
        background-color: #ffffff;
        border-radius: 18px;
        box-shadow: 0 25px 60px rgba(15, 23, 42, 0.12);
        padding: 32px 28px 28px;

        /* 살짝 오른쪽 이동 (pets와 동일 톤) */
        margin-left: 100px;
    }

    .user-title {
        font-size: 24px;
        font-weight: 700;
        color: #111827;
        margin-bottom: 16px;
    }

    /* ===== 테이블 공통 스타일 ===== */
    .user-table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
        background: #fafafa;
        border-radius: 12px;
        overflow: hidden;
    }

    .user-table th {
        background: #f3f4f6;
        padding: 12px;
        font-size: 14px;
        font-weight: 600;
        color: #374151;
        border-bottom: 1px solid #e5e7eb;
        text-align: center;
    }

    .user-table td {
        padding: 12px;
        font-size: 14px;
        color: #111827;
        border-bottom: 1px solid #e5e7eb;
        text-align: center;
    }

    tr:hover {
        background: #fef3f3;
    }

    /* 링크 버튼 같은 스타일 */
    .btn-link {
        color: #2563eb;
        font-weight: 600;
        text-decoration: underline;
        cursor: pointer;
    }
</style>

<div class="main-container user-mode">
    <div class="user-page">
        <div class="user-wrap">

            <div class="user-card">

                <div class="user-title">사용자 목록</div>

                <table class="user-table">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>아이디</th>
                        <th>이름</th>
                        <th>이메일</th>
                        <th>전화번호</th>
                    </tr>
                    </thead>

                    <tbody>
                    <c:forEach items="${users}" var="u">
                        <tr>
                            <td>${u.userId}</td>
                            <td>${u.username}</td>
                            <td>${u.name}</td>
                            <td>${u.email}</td>
                            <td>${u.phone}</td>
                        </tr>
                    </c:forEach>
                    </tbody>

                </table>

            </div>

        </div>
    </div>
</div>
