<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="auth-container">
    <div class="auth-card-simple">
        <div class="auth-form-area-full">
            <!-- 헤더 -->
            <div class="auth-form-header">
                <div class="auth-logo-center">
                    <div class="auth-logo-icon">
                        <i class="fas fa-paw"></i>
                    </div>
                    <h2>PetCare AI</h2>
                </div>
                <h3>로그인</h3>
                <p>반려동물과 함께하는 스마트한 일상</p>
            </div>

            <form id="loginForm" action="<c:url value='/login'/>" method="post">
                <!-- 아이디 -->
                <div class="form-group">
                    <label for="username">아이디</label>
                    <input type="text"
                           class="form-control-auth"
                           id="username"
                           name="username"
                           placeholder="아이디를 입력하세요"
                           required
                           autofocus>
                </div>

                <!-- 비밀번호 -->
                <div class="form-group">
                    <label for="password">비밀번호</label>
                    <div class="password-toggle">
                        <input type="password"
                               class="form-control-auth"
                               id="password"
                               name="password"
                               placeholder="비밀번호를 입력하세요"
                               required>
                        <button type="button" class="password-toggle-btn" onclick="togglePassword('password')">
                            <i class="far fa-eye" id="password-icon"></i>
                        </button>
                    </div>
                </div>

                <!-- 로그인 유지 & 비밀번호 찾기 -->
                <div class="login-options">
                    <div class="form-check">
                        <input type="checkbox" id="rememberMe" name="rememberMe">
                        <label for="rememberMe">로그인 유지</label>
                    </div>
                    <a href="<c:url value='/forgot-password'/>" class="forgot-password">비밀번호 찾기</a>
                </div>

                <!-- 로그인 버튼 -->
                <button type="submit" class="btn-auth-primary">
                    로그인
                </button>

                <!-- 에러 메시지 -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger" role="alert">
                        <i class="fas fa-exclamation-circle"></i>
                            ${error}
                    </div>
                </c:if>
            </form>

            <!-- 회원가입 링크 -->
            <div class="auth-links">
                아직 회원이 아니신가요?
                <a href="<c:url value='/register'/>">회원가입</a>
            </div>
        </div>
    </div>
</div>

<script>
    // 비밀번호 표시/숨김 토글
    function togglePassword(inputId) {
        const input = document.getElementById(inputId);
        const icon = document.getElementById(inputId + '-icon');

        if (input.type === 'password') {
            input.type = 'text';
            icon.classList.remove('fa-eye');
            icon.classList.add('fa-eye-slash');
        } else {
            input.type = 'password';
            icon.classList.remove('fa-eye-slash');
            icon.classList.add('fa-eye');
        }
    }

    // 엔터키로 로그인
    document.getElementById('loginForm').addEventListener('keypress', function(e) {
        if (e.key === 'Enter') {
            e.preventDefault();
            this.submit();
        }
    });
</script>
<div class="auth-form-header">
    <h3>로그인</h3>
    <p>반려동물과 함께하는 스마트한 일상</p>
</div>

<form id="loginForm" action="<c:url value='/login'/>" method="post">
    <!-- 아이디 -->
    <div class="form-group">
        <label for="username">아이디 <span class="required">*</span></label>
        <input type="text"
               class="form-control-auth"
               id="username"
               name="username"
               placeholder="아이디를 입력하세요"
               required>
        <div class="invalid-feedback">아이디를 입력해주세요.</div>
    </div>

    <!-- 비밀번호 -->
    <div class="form-group">
        <label for="password">비밀번호 <span class="required">*</span></label>
        <div class="password-toggle">
            <input type="password"
                   class="form-control-auth"
                   id="password"
                   name="password"
                   placeholder="비밀번호를 입력하세요"
                   required>
            <button type="button" class="password-toggle-btn" onclick="togglePassword('password')">
                <i class="far fa-eye" id="password-icon"></i>
            </button>
        </div>
        <div class="invalid-feedback">비밀번호를 입력해주세요.</div>
    </div>

    <!-- 로그인 유지 & 비밀번호 찾기 -->
    <div class="d-flex justify-content-between align-items-center">
        <div class="form-check">
            <input type="checkbox" id="rememberMe" name="rememberMe">
            <label for="rememberMe">로그인 유지</label>
        </div>
        <a href="<c:url value='/forgot-password'/>" style="color: #6c757d; font-size: 0.9rem;">비밀번호 찾기</a>
    </div>

    <!-- 로그인 버튼 -->
    <button type="submit" class="btn-auth-primary">
        <i class="fas fa-sign-in-alt mr-2"></i>
        로그인
    </button>

    <!-- 에러 메시지 -->
    <c:if test="${not empty error}">
        <div class="alert alert-danger mt-3" role="alert">
            <i class="fas fa-exclamation-circle mr-2"></i>
                ${error}
        </div>
    </c:if>
</form>

<!-- 소셜 로그인 -->
<div class="auth-divider">또는</div>
<div class="social-login">
    <button type="button" class="btn-social" onclick="socialLogin('kakao')">
        <i class="fas fa-comment" style="color: #FEE500;"></i>
        카카오 로그인
    </button>
    <button type="button" class="btn-social" onclick="socialLogin('naver')">
        <i class="fas fa-n" style="color: #03C75A;"></i>
        네이버 로그인
    </button>
</div>

<!-- 회원가입 링크 -->
<div class="auth-links">
    아직 회원이 아니신가요?
    <a href="<c:url value='/register'/>">회원가입</a>
</div>
</div>
</div>
</div>
</div>

<script>
    // 비밀번호 표시/숨김 토글
    function togglePassword(inputId) {
        const input = document.getElementById(inputId);
        const icon = document.getElementById(inputId + '-icon');

        if (input.type === 'password') {
            input.type = 'text';
            icon.classList.remove('fa-eye');
            icon.classList.add('fa-eye-slash');
        } else {
            input.type = 'password';
            icon.classList.remove('fa-eye-slash');
            icon.classList.add('fa-eye');
        }
    }

    // 소셜 로그인
    function socialLogin(provider) {
        alert(provider + ' 소셜 로그인 기능은 준비중입니다.');
        // 향후 OAuth 연동 시 구현
    }

    // 폼 유효성 검사
    document.getElementById('loginForm').addEventListener('submit', function(e) {
        const username = document.getElementById('username');
        const password = document.getElementById('password');
        let isValid = true;

        // 아이디 검증
        if (!username.value.trim()) {
            username.classList.add('is-invalid');
            isValid = false;
        } else {
            username.classList.remove('is-invalid');
        }

        // 비밀번호 검증
        if (!password.value.trim()) {
            password.classList.add('is-invalid');
            isValid = false;
        } else {
            password.classList.remove('is-invalid');
        }

        if (!isValid) {
            e.preventDefault();
        }
    });

    // 입력 시 에러 상태 제거
    document.querySelectorAll('.form-control-auth').forEach(input => {
        input.addEventListener('input', function() {
            this.classList.remove('is-invalid');
        });
    });
</script>
