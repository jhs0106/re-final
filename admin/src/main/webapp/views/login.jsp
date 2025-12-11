<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
  /* === 로그인 페이지 전용 레이아웃 === */

  /* 메인 컨테이너 전체에 그라데이션 + 가운데 정렬 */
  .main-container.login-mode {
    padding: 0 !important;  /* 양옆 여백 제거 */
    height: 1000px;
    min-height: calc(100vh - 70px); /* 헤더 높이만큼 대충 빼줌 */
    background: linear-gradient(135deg, #fef2ff 0%, #e0f2fe 50%, #dcfce7 100%);
    display: flex;
    align-items: center;
    justify-content: center;
  }

  /* 안쪽 래퍼는 정렬만 담당 */
  .admin-login-page {
    width: 100%;
    display: flex;
    align-items: center;
    justify-content: center;
  }

  .login-wrap {
    width: 100%;
    max-width: 420px;
    padding: 16px;
  }

  .login-card {
    background-color: #ffffff;
    border-radius: 18px;
    box-shadow: 0 25px 60px rgba(15, 23, 42, 0.12);
    padding: 32px 28px 28px;
  }

  .login-title {
    font-size: 22px;
    font-weight: 700;
    color: #111827;
    margin-bottom: 4px;
  }
  .login-sub {
    font-size: 13px;
    color: #6b7280;
    margin-bottom: 20px;
  }

  .form-label {
    font-size: 13px;
    font-weight: 500;
    color: #374151;
    margin-bottom: 4px;
  }

  .login-card .form-control {
    font-size: 13px;
    border-radius: 10px;
  }

  .btn-login {
    width: 100%;
    border-radius: 999px;
    background: linear-gradient(135deg, #fb7185, #f97316);
    border: none;
    color: #fff;
    font-weight: 600;
    font-size: 14px;
    padding: 10px 0;
    margin-top: 6px;
  }
  .btn-login:hover {
    opacity: 0.9;
  }

  .demo-tip {
    margin-top: 10px;
    font-size: 12px;
    color: #6b7280;
  }
  .demo-tip strong {
    color: #ec4899;
  }

  .error-msg {
    font-size: 12px;
    color: #dc2626;
    margin-top: 6px;
  }
</style>


<div class="main-container login-mode">
  <div class="admin-login-page">
    <div class="login-wrap">
      <div class="login-card">
        <div class="mb-3">
          <div class="login-title">관리자 로그인</div>
          <div class="login-sub">Pat n Pet 관리 대시보드에 접속합니다.</div>
        </div>

        <form method="post" action="<c:url value='/admin/login'/>">
          <div class="form-group mb-3">
            <label class="form-label" for="username">아이디</label>
            <input id="username"
                   name="username"
                   type="text"
                   class="form-control"
                   placeholder="id01"
                   value="id01"/>
          </div>

          <div class="form-group mb-1">
            <label class="form-label" for="password">비밀번호</label>
            <input id="password"
                   name="password"
                   type="password"
                   class="form-control"
                   placeholder="임의 값 입력 가능"/>
          </div>

          <c:if test="${not empty loginError}">
            <div class="error-msg">${loginError}</div>
          </c:if>

          <button type="submit" class="btn btn-login">로그인</button>
        </form>

        <p class="demo-tip">
          현재는 데모용으로 <strong>아이디 id01</strong>로만 로그인 가능하며,
          비밀번호는 아무 값이나 입력해도 됩니다.
        </p>
      </div>
    </div>
  </div>
</div>
