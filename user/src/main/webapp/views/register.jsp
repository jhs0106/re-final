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
                <h3>회원가입</h3>
                <p>빠르고 간편한 가입으로 시작하세요</p>
            </div>

            <!-- 진행 단계 표시 -->
            <div class="register-steps">
                <div class="step active" id="step-indicator-1">
                    <div class="step-number">1</div>
                    <div class="step-label">역할 선택</div>
                </div>
                <div class="step-line"></div>
                <div class="step" id="step-indicator-2">
                    <div class="step-number">2</div>
                    <div class="step-label">기본 정보</div>
                </div>
                <div class="step-line"></div>
                <div class="step" id="step-indicator-3">
                    <div class="step-number">3</div>
                    <div class="step-label">추가 정보</div>
                </div>
            </div>

            <form id="registerForm" action="<c:url value='/register'/>" method="post">

                <!-- ========== STEP 1: 역할 선택 ========== -->
                <div class="register-step-content active" id="step-1">
                    <h4 class="step-title">어떤 서비스를 이용하시나요?</h4>

                    <div class="role-selection">
                        <div class="role-card" onclick="selectRole('user')">
                            <input type="radio" name="userRole" value="user" id="role-user" required>
                            <label for="role-user">
                                <div class="role-icon">
                                    <i class="fas fa-user"></i>
                                </div>
                                <div class="role-title">일반 사용자</div>
                                <div class="role-desc">
                                    산책 알바 등록, 펫 다이어리,<br>
                                    커뮤니티 이용
                                </div>
                            </label>
                        </div>

                        <div class="role-card" onclick="selectRole('owner')">
                            <input type="radio" name="userRole" value="owner" id="role-owner" required>
                            <label for="role-owner">
                                <div class="role-icon">
                                    <i class="fas fa-dog"></i>
                                </div>
                                <div class="role-title">반려인</div>
                                <div class="role-desc">
                                    AI 산책, 홈캠 분석,<br>
                                    건강 진단 등 모든 서비스 이용
                                </div>
                            </label>
                        </div>
                    </div>

                    <button type="button" class="btn-auth-primary" onclick="nextStep(2)">
                        다음 <i class="fas fa-arrow-right ml-2"></i>
                    </button>
                </div>

                <!-- ========== STEP 2: 기본 정보 입력 ========== -->
                <div class="register-step-content" id="step-2">
                    <h4 class="step-title">기본 정보를 입력해주세요</h4>

                    <div class="form-row-group">
                        <!-- 아이디 -->
                        <div class="form-group">
                            <label for="username">아이디 <span class="required">*</span></label>
                            <div class="input-with-button">
                                <input type="text"
                                       class="form-control-auth"
                                       id="username"
                                       name="username"
                                       placeholder="4-20자 영문, 숫자"
                                       pattern="^[a-zA-Z0-9]{4,20}$">
                                <button type="button" class="btn-check" onclick="checkUsername()">
                                    중복확인
                                </button>
                            </div>
                            <div class="invalid-feedback">4-20자의 영문, 숫자만 사용 가능합니다.</div>
                            <div class="valid-feedback" id="username-available" style="display:none;">
                                <i class="fas fa-check-circle"></i> 사용 가능한 아이디입니다.
                            </div>
                        </div>

                        <!-- 비밀번호 -->
                        <div class="form-group">
                            <label for="password">비밀번호 <span class="required">*</span></label>
                            <div class="password-toggle">
                                <input type="password"
                                       class="form-control-auth"
                                       id="password"
                                       name="password"
                                       placeholder="8자 이상, 영문+숫자+특수문자"
                                       pattern="^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$">
                                <button type="button" class="password-toggle-btn" onclick="togglePassword('password')">
                                    <i class="far fa-eye" id="password-icon"></i>
                                </button>
                            </div>
                            <div class="password-strength" id="password-strength"></div>
                            <div class="invalid-feedback">8자 이상, 영문+숫자+특수문자를 포함해야 합니다.</div>
                        </div>

                        <!-- 비밀번호 확인 -->
                        <div class="form-group">
                            <label for="passwordConfirm">비밀번호 확인 <span class="required">*</span></label>
                            <div class="password-toggle">
                                <input type="password"
                                       class="form-control-auth"
                                       id="passwordConfirm"
                                       placeholder="비밀번호를 다시 입력하세요">
                                <button type="button" class="password-toggle-btn" onclick="togglePassword('passwordConfirm')">
                                    <i class="far fa-eye" id="passwordConfirm-icon"></i>
                                </button>
                            </div>
                            <div class="invalid-feedback">비밀번호가 일치하지 않습니다.</div>
                            <div class="valid-feedback">비밀번호가 일치합니다.</div>
                        </div>
                    </div>

                    <div class="form-row-group">
                        <!-- 이름 -->
                        <div class="form-group">
                            <label for="name">이름 <span class="required">*</span></label>
                            <input type="text"
                                   class="form-control-auth"
                                   id="name"
                                   name="name"
                                   placeholder="실명을 입력하세요">
                        </div>

                        <!-- 전화번호 -->
                        <div class="form-group">
                            <label for="phone">전화번호 <span class="required">*</span></label>
                            <input type="tel"
                                   class="form-control-auth"
                                   id="phone"
                                   name="phone"
                                   placeholder="010-1234-5678"
                                   pattern="^01[0-9]-\d{3,4}-\d{4}$">
                        </div>

                        <!-- 이메일 -->
                        <div class="form-group">
                            <label for="email">이메일 <span class="required">*</span></label>
                            <input type="email"
                                   class="form-control-auth"
                                   id="email"
                                   name="email"
                                   placeholder="example@email.com">
                        </div>
                    </div>

                    <div class="button-group">
                        <button type="button" class="btn-auth-secondary" onclick="prevStep(1)">
                            <i class="fas fa-arrow-left mr-2"></i> 이전
                        </button>
                        <button type="button" class="btn-auth-primary" onclick="nextStep(3)">
                            다음 <i class="fas fa-arrow-right ml-2"></i>
                        </button>
                    </div>
                </div>

                <!-- ========== STEP 3: 추가 정보 (반려인만) ========== -->
                <div class="register-step-content" id="step-3">
                    <div id="owner-info" style="display:none;">
                        <h4 class="step-title">
                            <i class="fas fa-dog mr-2"></i>
                            반려동물 정보를 입력해주세요
                        </h4>
                        <p class="step-subtitle">더 나은 서비스를 위해 반려동물 정보가 필요합니다</p>

                        <div class="form-row-group">
                            <!-- 반려동물 종류 -->
                            <div class="form-group">
                                <label for="petType">반려동물 종류 <span class="required">*</span></label>
                                <select class="form-control-auth" id="petType" name="petType">
                                    <option value="">선택해주세요</option>
                                    <option value="dog">강아지</option>
                                    <option value="cat">고양이</option>
                                    <option value="other">기타</option>
                                </select>
                            </div>

                            <!-- 반려동물 이름 -->
                            <div class="form-group">
                                <label for="petName">이름 <span class="required">*</span></label>
                                <input type="text"
                                       class="form-control-auth"
                                       id="petName"
                                       name="petName"
                                       placeholder="반려동물 이름">
                            </div>
                        </div>

                        <div class="form-row-group">
                            <!-- 나이 -->
                            <div class="form-group">
                                <label for="petAge">나이 <span class="required">*</span></label>
                                <input type="number"
                                       class="form-control-auth"
                                       id="petAge"
                                       name="petAge"
                                       placeholder="0"
                                       min="0"
                                       max="30">
                            </div>

                            <!-- 몸무게 -->
                            <div class="form-group">
                                <label for="petWeight">몸무게 (kg) <span class="required">*</span></label>
                                <input type="number"
                                       class="form-control-auth"
                                       id="petWeight"
                                       name="petWeight"
                                       placeholder="0.0"
                                       min="0"
                                       step="0.1">
                            </div>
                        </div>
                    </div>

                    <div id="user-info" style="display:none;">
                        <h4 class="step-title">
                            <i class="fas fa-check-circle mr-2"></i>
                            거의 다 끝났습니다!
                        </h4>
                        <p class="step-subtitle">아래 약관에 동의하고 가입을 완료하세요</p>
                    </div>

                    <!-- 약관 동의 -->
                    <div class="terms-section">
                        <div class="form-check">
                            <input type="checkbox" id="agreeAll" onclick="toggleAllTerms()">
                            <label for="agreeAll" class="font-weight-bold">
                                전체 약관에 동의합니다
                            </label>
                        </div>
                        <hr>
                        <div class="form-check">
                            <input type="checkbox" id="agreeTerms" name="agreeTerms" class="term-checkbox" required>
                            <label for="agreeTerms">
                                <a href="#" onclick="showTerms(); return false;">[필수] 이용약관</a>에 동의합니다
                            </label>
                        </div>
                        <div class="form-check">
                            <input type="checkbox" id="agreePrivacy" name="agreePrivacy" class="term-checkbox" required>
                            <label for="agreePrivacy">
                                <a href="#" onclick="showPrivacy(); return false;">[필수] 개인정보처리방침</a>에 동의합니다
                            </label>
                        </div>
                        <div class="form-check">
                            <input type="checkbox" id="agreeMarketing" name="agreeMarketing" class="term-checkbox">
                            <label for="agreeMarketing">
                                [선택] 마케팅 정보 수신에 동의합니다
                            </label>
                        </div>
                    </div>

                    <div class="button-group">
                        <button type="button" class="btn-auth-secondary" onclick="prevStep(2)">
                            <i class="fas fa-arrow-left mr-2"></i> 이전
                        </button>
                        <button type="submit" class="btn-auth-primary">
                            <i class="fas fa-user-plus mr-2"></i> 회원가입 완료
                        </button>
                    </div>
                </div>

            </form>

            <!-- 로그인 링크 -->
            <div class="auth-links">
                이미 계정이 있으신가요?
                <a href="<c:url value='/login'/>">로그인</a>
            </div>
        </div>
    </div>
</div>

<script>
    let currentStep = 1;
    let selectedRole = '';
    let usernameChecked = false;

    // 역할 선택
    function selectRole(role) {
        selectedRole = role;
        document.getElementById('role-' + role).checked = true;

        // 모든 카드에서 selected 제거
        document.querySelectorAll('.role-card').forEach(card => {
            card.classList.remove('selected');
        });

        // 선택된 카드에 selected 추가
        event.currentTarget.classList.add('selected');
    }

    // 다음 단계로
    function nextStep(step) {
        // 현재 단계 유효성 검사
        if (!validateStep(currentStep)) {
            return;
        }

        // 단계 전환
        document.getElementById('step-' + currentStep).classList.remove('active');
        document.getElementById('step-indicator-' + currentStep).classList.remove('active');
        document.getElementById('step-indicator-' + currentStep).classList.add('completed');

        currentStep = step;

        document.getElementById('step-' + currentStep).classList.add('active');
        document.getElementById('step-indicator-' + currentStep).classList.add('active');

        // STEP 3에서 역할에 따라 다른 화면 표시
        if (currentStep === 3) {
            if (selectedRole === 'owner') {
                document.getElementById('owner-info').style.display = 'block';
                document.getElementById('user-info').style.display = 'none';
                // 반려동물 정보 필수로 설정
                document.getElementById('petType').required = true;
                document.getElementById('petName').required = true;
                document.getElementById('petAge').required = true;
                document.getElementById('petWeight').required = true;
            } else {
                document.getElementById('owner-info').style.display = 'none';
                document.getElementById('user-info').style.display = 'block';
                // 반려동물 정보 선택사항으로 설정
                document.getElementById('petType').required = false;
                document.getElementById('petName').required = false;
                document.getElementById('petAge').required = false;
                document.getElementById('petWeight').required = false;
            }
        }

        // 스크롤 최상단으로
        window.scrollTo(0, 0);
    }

    // 이전 단계로
    function prevStep(step) {
        document.getElementById('step-' + currentStep).classList.remove('active');
        document.getElementById('step-indicator-' + currentStep).classList.remove('active');
        document.getElementById('step-indicator-' + currentStep).classList.remove('completed');

        currentStep = step;

        document.getElementById('step-' + currentStep).classList.add('active');
        document.getElementById('step-indicator-' + step).classList.remove('completed');

        window.scrollTo(0, 0);
    }

    // 단계별 유효성 검사
    function validateStep(step) {
        if (step === 1) {
            if (!selectedRole) {
                alert('역할을 선택해주세요.');
                return false;
            }
            return true;
        }

        if (step === 2) {
            const username = document.getElementById('username').value;
            const password = document.getElementById('password').value;
            const passwordConfirm = document.getElementById('passwordConfirm').value;
            const name = document.getElementById('name').value;
            const phone = document.getElementById('phone').value;
            const email = document.getElementById('email').value;

            if (!username || !password || !passwordConfirm || !name || !phone || !email) {
                alert('모든 필수 항목을 입력해주세요.');
                return false;
            }

            if (!usernameChecked) {
                alert('아이디 중복확인을 해주세요.');
                return false;
            }

            if (password !== passwordConfirm) {
                alert('비밀번호가 일치하지 않습니다.');
                return false;
            }

            // 비밀번호 패턴 검사
            const passwordPattern = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/;
            if (!passwordPattern.test(password)) {
                alert('비밀번호는 8자 이상, 영문+숫자+특수문자를 포함해야 합니다.');
                return false;
            }

            return true;
        }

        return true;
    }

    // 아이디 중복 확인
    function checkUsername() {
        const username = document.getElementById('username').value;

        if (!username) {
            alert('아이디를 입력해주세요.');
            return;
        }

        const usernamePattern = /^[a-zA-Z0-9]{4,20}$/;
        if (!usernamePattern.test(username)) {
            alert('아이디는 4-20자의 영문, 숫자만 사용 가능합니다.');
            return;
        }

        // TODO: 실제로는 서버에 AJAX 요청
        // 여기서는 시뮬레이션
        setTimeout(() => {
            const isAvailable = true; // 실제로는 서버 응답

            if (isAvailable) {
                usernameChecked = true;
                document.getElementById('username-available').style.display = 'block';
                document.getElementById('username').classList.add('is-valid');
                document.getElementById('username').classList.remove('is-invalid');
                alert('사용 가능한 아이디입니다.');
            } else {
                usernameChecked = false;
                document.getElementById('username').classList.add('is-invalid');
                document.getElementById('username').classList.remove('is-valid');
                alert('이미 사용중인 아이디입니다.');
            }
        }, 300);
    }

    // 아이디 변경 시 중복확인 초기화
    document.getElementById('username').addEventListener('input', function() {
        usernameChecked = false;
        document.getElementById('username-available').style.display = 'none';
        this.classList.remove('is-valid', 'is-invalid');
    });

    // 비밀번호 강도 표시
    document.getElementById('password').addEventListener('input', function() {
        const password = this.value;
        const strengthDiv = document.getElementById('password-strength');

        if (password.length === 0) {
            strengthDiv.innerHTML = '';
            return;
        }

        let strength = 0;
        if (password.length >= 8) strength++;
        if (/[A-Za-z]/.test(password)) strength++;
        if (/\d/.test(password)) strength++;
        if (/[@$!%*#?&]/.test(password)) strength++;

        const labels = ['', '약함', '보통', '강함', '매우 강함'];
        const colors = ['', '#dc3545', '#ffc107', '#28a745', '#007bff'];

        strengthDiv.innerHTML = `<span style="color: ${colors[strength]}">비밀번호 강도: ${labels[strength]}</span>`;
    });

    // 비밀번호 확인 실시간 검증
    document.getElementById('passwordConfirm').addEventListener('input', function() {
        const password = document.getElementById('password').value;
        const passwordConfirm = this.value;

        if (passwordConfirm === '') {
            this.classList.remove('is-valid', 'is-invalid');
        } else if (password === passwordConfirm) {
            this.classList.remove('is-invalid');
            this.classList.add('is-valid');
        } else {
            this.classList.remove('is-valid');
            this.classList.add('is-invalid');
        }
    });

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

    // 전화번호 자동 하이픈
    document.getElementById('phone').addEventListener('input', function(e) {
        let value = e.target.value.replace(/[^0-9]/g, '');
        let result = '';

        if (value.length > 0) {
            if (value.length <= 3) {
                result = value;
            } else if (value.length <= 7) {
                result = value.slice(0, 3) + '-' + value.slice(3);
            } else {
                result = value.slice(0, 3) + '-' + value.slice(3, 7) + '-' + value.slice(7, 11);
            }
        }

        e.target.value = result;
    });

    // 전체 약관 동의
    function toggleAllTerms() {
        const agreeAll = document.getElementById('agreeAll').checked;
        document.querySelectorAll('.term-checkbox').forEach(checkbox => {
            checkbox.checked = agreeAll;
        });
    }

    // 개별 약관 체크 시 전체 동의 업데이트
    document.querySelectorAll('.term-checkbox').forEach(checkbox => {
        checkbox.addEventListener('change', function() {
            const allChecked = Array.from(document.querySelectorAll('.term-checkbox'))
                    .every(cb => cb.checked);
            document.getElementById('agreeAll').checked = allChecked;
        });
    });

    // 폼 제출
    document.getElementById('registerForm').addEventListener('submit', function(e) {
        e.preventDefault();

        // 약관 동의 확인
        if (!document.getElementById('agreeTerms').checked || !document.getElementById('agreePrivacy').checked) {
            alert('필수 약관에 동의해주세요.');
            return;
        }

        // 반려인인 경우 반려동물 정보 확인
        if (selectedRole === 'owner') {
            const petType = document.getElementById('petType').value;
            const petName = document.getElementById('petName').value;
            const petAge = document.getElementById('petAge').value;
            const petWeight = document.getElementById('petWeight').value;

            if (!petType || !petName || !petAge || !petWeight) {
                alert('반려동물 정보를 모두 입력해주세요.');
                return;
            }
        }

        // 실제로는 여기서 폼 제출
        alert('회원가입이 완료되었습니다!');
        // this.submit();
    });

    // 약관 보기
    function showTerms() {
        alert('이용약관 내용이 표시됩니다.\n\n향후 실제 약관 내용으로 대체됩니다.');
    }

    function showPrivacy() {
        alert('개인정보처리방침 내용이 표시됩니다.\n\n향후 실제 개인정보처리방침 내용으로 대체됩니다.');
    }
</script>
<div class="auth-form-header">
    <h3>회원가입</h3>
    <p>빠르고 간편한 가입으로 시작하세요</p>
</div>

<form id="registerForm" action="<c:url value='/register'/>" method="post">
    <!-- 아이디 -->
    <div class="form-group">
        <label for="username">아이디 <span class="required">*</span></label>
        <input type="text"
               class="form-control-auth"
               id="username"
               name="username"
               placeholder="4-20자 영문, 숫자"
               required
               pattern="^[a-zA-Z0-9]{4,20}$">
        <div class="invalid-feedback">4-20자의 영문, 숫자만 사용 가능합니다.</div>
        <div class="valid-feedback">사용 가능한 아이디입니다.</div>
    </div>

    <!-- 비밀번호 -->
    <div class="form-group">
        <label for="password">비밀번호 <span class="required">*</span></label>
        <div class="password-toggle">
            <input type="password"
                   class="form-control-auth"
                   id="password"
                   name="password"
                   placeholder="8자 이상, 영문+숫자+특수문자"
                   required
                   pattern="^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$">
            <button type="button" class="password-toggle-btn" onclick="togglePassword('password')">
                <i class="far fa-eye" id="password-icon"></i>
            </button>
        </div>
        <div class="invalid-feedback">8자 이상, 영문+숫자+특수문자를 포함해야 합니다.</div>
    </div>

    <!-- 비밀번호 확인 -->
    <div class="form-group">
        <label for="passwordConfirm">비밀번호 확인 <span class="required">*</span></label>
        <div class="password-toggle">
            <input type="password"
                   class="form-control-auth"
                   id="passwordConfirm"
                   name="passwordConfirm"
                   placeholder="비밀번호를 다시 입력하세요"
                   required>
            <button type="button" class="password-toggle-btn" onclick="togglePassword('passwordConfirm')">
                <i class="far fa-eye" id="passwordConfirm-icon"></i>
            </button>
        </div>
        <div class="invalid-feedback">비밀번호가 일치하지 않습니다.</div>
        <div class="valid-feedback">비밀번호가 일치합니다.</div>
    </div>

    <!-- 이름 -->
    <div class="form-group">
        <label for="name">이름 <span class="required">*</span></label>
        <input type="text"
               class="form-control-auth"
               id="name"
               name="name"
               placeholder="실명을 입력하세요"
               required>
        <div class="invalid-feedback">이름을 입력해주세요.</div>
    </div>

    <!-- 전화번호 -->
    <div class="form-group">
        <label for="phone">전화번호 <span class="required">*</span></label>
        <input type="tel"
               class="form-control-auth"
               id="phone"
               name="phone"
               placeholder="010-1234-5678"
               required
               pattern="^01[0-9]-\d{3,4}-\d{4}$">
        <div class="invalid-feedback">올바른 전화번호 형식을 입력해주세요. (예: 010-1234-5678)</div>
    </div>

    <!-- 이메일 -->
    <div class="form-group">
        <label for="email">이메일 <span class="required">*</span></label>
        <input type="email"
               class="form-control-auth"
               id="email"
               name="email"
               placeholder="example@email.com"
               required>
        <div class="invalid-feedback">올바른 이메일 형식을 입력해주세요.</div>
    </div>

    <!-- 반려동물 정보 (선택사항) -->
    <div class="pet-info-section">
        <h4>
            <i class="fas fa-dog"></i>
            반려동물 정보
        </h4>
        <small>지금 등록하지 않아도 나중에 마이페이지에서 추가할 수 있습니다.</small>

        <!-- 반려동물 종류 -->
        <div class="form-group">
            <label for="petType">반려동물 종류</label>
            <select class="form-control-auth" id="petType" name="petType">
                <option value="">선택 안함</option>
                <option value="dog">강아지</option>
                <option value="cat">고양이</option>
                <option value="other">기타</option>
            </select>
        </div>

        <!-- 반려동물 이름 -->
        <div class="form-group">
            <label for="petName">이름</label>
            <input type="text"
                   class="form-control-auth"
                   id="petName"
                   name="petName"
                   placeholder="반려동물 이름">
        </div>

        <!-- 나이 -->
        <div class="form-group">
            <label for="petAge">나이 (년)</label>
            <input type="number"
                   class="form-control-auth"
                   id="petAge"
                   name="petAge"
                   placeholder="0"
                   min="0"
                   max="30">
        </div>

        <!-- 몸무게 -->
        <div class="form-group">
            <label for="petWeight">몸무게 (kg)</label>
            <input type="number"
                   class="form-control-auth"
                   id="petWeight"
                   name="petWeight"
                   placeholder="0.0"
                   min="0"
                   step="0.1">
        </div>
    </div>

    <!-- 약관 동의 -->
    <div class="form-check">
        <input type="checkbox" id="agreeTerms" name="agreeTerms" required>
        <label for="agreeTerms">
            <a href="#" onclick="showTerms(); return false;">이용약관</a> 및
            <a href="#" onclick="showPrivacy(); return false;">개인정보처리방침</a>에 동의합니다. <span class="required">*</span>
        </label>
    </div>

    <!-- 회원가입 버튼 -->
    <button type="submit" class="btn-auth-primary">
        <i class="fas fa-user-plus mr-2"></i>
        회원가입
    </button>
</form>

<!-- 로그인 링크 -->
<div class="auth-links">
    이미 계정이 있으신가요?
    <a href="<c:url value='/login'/>">로그인</a>
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

    // 전화번호 자동 하이픈 입력
    document.getElementById('phone').addEventListener('input', function(e) {
        let value = e.target.value.replace(/[^0-9]/g, '');
        let result = '';

        if (value.length > 0) {
            if (value.length <= 3) {
                result = value;
            } else if (value.length <= 7) {
                result = value.slice(0, 3) + '-' + value.slice(3);
            } else {
                result = value.slice(0, 3) + '-' + value.slice(3, 7) + '-' + value.slice(7, 11);
            }
        }

        e.target.value = result;
    });

    // 비밀번호 확인 실시간 검증
    document.getElementById('passwordConfirm').addEventListener('input', function() {
        const password = document.getElementById('password').value;
        const passwordConfirm = this.value;

        if (passwordConfirm === '') {
            this.classList.remove('is-valid', 'is-invalid');
        } else if (password === passwordConfirm) {
            this.classList.remove('is-invalid');
            this.classList.add('is-valid');
        } else {
            this.classList.remove('is-valid');
            this.classList.add('is-invalid');
        }
    });

    // 폼 제출 시 유효성 검사
    document.getElementById('registerForm').addEventListener('submit', function(e) {
        e.preventDefault();

        const password = document.getElementById('password').value;
        const passwordConfirm = document.getElementById('passwordConfirm').value;
        const agreeTerms = document.getElementById('agreeTerms').checked;

        // 비밀번호 일치 확인
        if (password !== passwordConfirm) {
            document.getElementById('passwordConfirm').classList.add('is-invalid');
            return false;
        }

        // 약관 동의 확인
        if (!agreeTerms) {
            alert('이용약관 및 개인정보처리방침에 동의해주세요.');
            return false;
        }

        // 모든 검증 통과 시 폼 제출
        this.submit();
    });

    // 입력 시 에러 상태 제거
    document.querySelectorAll('.form-control-auth').forEach(input => {
        input.addEventListener('input', function() {
            if (this.id !== 'passwordConfirm') {
                this.classList.remove('is-invalid');
            }
        });
    });

    // 약관 보기
    function showTerms() {
        alert('이용약관 내용이 표시됩니다.\n\n향후 실제 약관 내용으로 대체됩니다.');
    }

    function showPrivacy() {
        alert('개인정보처리방침 내용이 표시됩니다.\n\n향후 실제 개인정보처리방침 내용으로 대체됩니다.');
    }
</script>
