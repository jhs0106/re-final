/**
 * 회원가입 페이지 JavaScript
 * PetCare AI - 반려동물 케어 시스템
 */

let currentStep = 1;
let petFormCount = 1;
const isOwner = () => document.getElementById('role-owner').checked;

// ==================== 단계 관리 ====================

/**
 * 다음 단계로 이동
 */
function nextStep(step) {
    // 일반 사용자는 3단계(반려동물) 건너뛰기
    if (step === 3 && !isOwner()) {
        step = 4;
    }

    if (!validateStep(currentStep)) return;

    document.getElementById('step-' + currentStep).classList.remove('active');
    document.getElementById('step-indicator-' + currentStep).classList.remove('active');
    document.getElementById('step-indicator-' + currentStep).classList.add('completed');

    currentStep = step;
    document.getElementById('step-' + currentStep).classList.add('active');
    document.getElementById('step-indicator-' + currentStep).classList.add('active');

    // 3단계 인디케이터 처리 (일반 사용자는 회색 유지)
    if (!isOwner() && currentStep === 4) {
        document.getElementById('step-indicator-3').style.opacity = '0.3';
    }

    window.scrollTo(0, 0);
}

/**
 * 이전 단계로 이동
 */
function prevStep(step) {
    // 일반 사용자가 4단계에서 뒤로 가면 2단계로
    if (currentStep === 4 && !isOwner()) {
        step = 2;
    }

    document.getElementById('step-' + currentStep).classList.remove('active');
    document.getElementById('step-indicator-' + currentStep).classList.remove('active');

    currentStep = step;
    document.getElementById('step-' + currentStep).classList.add('active');
    document.getElementById('step-indicator-' + currentStep).classList.add('active');
    document.getElementById('step-indicator-' + currentStep).classList.remove('completed');
    window.scrollTo(0, 0);
}

// ==================== 입력 검증 ====================

/**
 * 단계별 입력 검증
 */
function validateStep(step) {
    if (step === 1) {
        return validateRole();
    }

    if (step === 2) {
        return validateUserInfo();
    }

    if (step === 3 && isOwner()) {
        return validatePetInfo();
    }

    return true;
}

/**
 * 역할 선택 검증
 */
function validateRole() {
    const roleSelected = document.querySelector('input[name="userRole"]:checked');
    if (!roleSelected) {
        alert('역할을 선택해주세요.');
        return false;
    }
    return true;
}

/**
 * 사용자 기본 정보 검증
 */
function validateUserInfo() {
    // 아이디 검증
    const username = document.getElementById('username').value;
    if (!username) {
        alert('아이디를 입력해주세요.');
        return false;
    }
    if (username.length < 4 || username.length > 20) {
        alert('아이디는 4-20자로 입력해주세요.');
        return false;
    }
    if (!/^[a-zA-Z0-9]+$/.test(username)) {
        alert('아이디는 영문과 숫자만 사용 가능합니다.');
        return false;
    }

    // 비밀번호 검증
    const password = document.getElementById('password').value;
    if (!password) {
        alert('비밀번호를 입력해주세요.');
        return false;
    }
    if (password.length < 8) {
        alert('비밀번호는 8자 이상 입력해주세요.');
        return false;
    }
    if (!/(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*])/.test(password)) {
        alert('비밀번호는 영문, 숫자, 특수문자를 모두 포함해야 합니다.');
        return false;
    }

    // 비밀번호 확인 검증
    const passwordConfirm = document.getElementById('passwordConfirm').value;
    if (password !== passwordConfirm) {
        alert('비밀번호가 일치하지 않습니다.');
        return false;
    }

    // 이름 검증
    const name = document.getElementById('name').value;
    if (!name) {
        alert('이름을 입력해주세요.');
        return false;
    }
    if (name.length < 2) {
        alert('이름은 2자 이상 입력해주세요.');
        return false;
    }

    // 이메일 검증
    const email = document.getElementById('email').value;
    if (!email) {
        alert('이메일을 입력해주세요.');
        return false;
    }
    if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
        alert('올바른 이메일 형식을 입력해주세요.');
        return false;
    }

    // 전화번호 검증
    const phone = document.getElementById('phone').value;
    if (!phone) {
        alert('전화번호를 입력해주세요.');
        return false;
    }
    if (!/^010-\d{4}-\d{4}$/.test(phone)) {
        alert('올바른 전화번호 형식을 입력해주세요. (010-1234-5678)');
        return false;
    }

    return true;
}

/**
 * 반려동물 정보 검증
 */
function validatePetInfo() {
    const firstPetName = document.querySelector('[name="petName_0"]');
    const firstPetType = document.querySelector('[name="petType_0"]');
    const firstPetGender = document.querySelector('[name="petGender_0"]');
    const firstPetAge = document.querySelector('[name="petAge_0"]');
    const firstPetWeight = document.querySelector('[name="petWeight_0"]');

    if (!firstPetName || !firstPetName.value) {
        alert('반려동물 이름을 입력해주세요.');
        return false;
    }
    if (!firstPetType || !firstPetType.value) {
        alert('반려동물 종류를 선택해주세요.');
        return false;
    }
    if (!firstPetGender || !firstPetGender.value) {
        alert('반려동물 성별을 선택해주세요.');
        return false;
    }
    if (!firstPetAge || !firstPetAge.value) {
        alert('반려동물 나이를 입력해주세요.');
        return false;
    }
    if (!firstPetWeight || !firstPetWeight.value) {
        alert('반려동물 몸무게를 입력해주세요.');
        return false;
    }

    // 나이 범위 검증
    const age = parseInt(firstPetAge.value);
    if (age < 0 || age > 30) {
        alert('반려동물 나이는 0-30세 사이로 입력해주세요.');
        return false;
    }

    // 몸무게 범위 검증
    const weight = parseFloat(firstPetWeight.value);
    if (weight <= 0 || weight > 200) {
        alert('반려동물 몸무게를 올바르게 입력해주세요. (0-200kg)');
        return false;
    }

    return true;
}

// ==================== 반려동물 관리 ====================

/**
 * 반려동물 폼 추가
 */
function addPetForm() {
    const container = document.getElementById('petFormsContainer');
    const newIndex = petFormCount;
    const displayNumber = newIndex + 1;

    console.log('Adding pet form - Index:', newIndex, 'Display Number:', displayNumber);

    const newForm = `
        <div class="pet-form-container" data-pet-index="${newIndex}">
            <div class="pet-form-header">
                <div class="pet-form-title">
                    <i class="fas fa-paw"></i>
                    반려동물 #${displayNumber}
                </div>
                <button type="button" class="pet-remove-btn" onclick="removePetForm(${newIndex})">
                    <i class="fas fa-trash-alt mr-1"></i> 삭제
                </button>
            </div>

            <div class="pet-photo-upload">
                <div class="pet-photo-preview" id="pet-photo-preview-${newIndex}">
                    <i class="fas fa-camera"></i>
                </div>
                <label class="photo-upload-label">
                    <i class="fas fa-upload mr-2"></i> 사진 업로드
                    <input type="file" name="petPhoto_${newIndex}" accept="image/*" onchange="previewPetPhoto(${newIndex}, this)">
                </label>
            </div>

            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem; margin-bottom: 1rem;">
                <div class="form-group" style="margin-bottom: 0;">
                    <label style="font-weight: 600; color: #212529;">이름 <span style="color: #dc3545;">*</span></label>
                    <input type="text" class="form-control" name="petName_${newIndex}" placeholder="반려동물 이름"
                           style="height: 2.75rem; border-radius: 0.75rem; border: 2px solid #e9ecef;">
                </div>
                <div class="form-group" style="margin-bottom: 0;">
                    <label style="font-weight: 600; color: #212529;">종류 <span style="color: #dc3545;">*</span></label>
                    <select class="form-control" name="petType_${newIndex}"
                            style="height: 2.75rem; border-radius: 0.75rem; border: 2px solid #e9ecef;">
                        <option value="">선택하세요</option>
                        <option value="DOG">강아지</option>
                        <option value="CAT">고양이</option>
                        <option value="ETC">기타</option>
                    </select>
                </div>
            </div>

            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem; margin-bottom: 1rem;">
                <div class="form-group" style="margin-bottom: 0;">
                    <label style="font-weight: 600; color: #212529;">품종</label>
                    <input type="text" class="form-control" name="petBreed_${newIndex}" placeholder="예: 골든 리트리버"
                           style="height: 2.75rem; border-radius: 0.75rem; border: 2px solid #e9ecef;">
                </div>
                <div class="form-group" style="margin-bottom: 0;">
                    <label style="font-weight: 600; color: #212529;">성별 <span style="color: #dc3545;">*</span></label>
                    <select class="form-control" name="petGender_${newIndex}"
                            style="height: 2.75rem; border-radius: 0.75rem; border: 2px solid #e9ecef;">
                        <option value="">선택하세요</option>
                        <option value="MALE">수컷</option>
                        <option value="FEMALE">암컷</option>
                    </select>
                </div>
            </div>

            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem;">
                <div class="form-group" style="margin-bottom: 0;">
                    <label style="font-weight: 600; color: #212529;">나이 <span style="color: #dc3545;">*</span></label>
                    <input type="number" class="form-control" name="petAge_${newIndex}" placeholder="나이 (년)" min="0" max="30"
                           style="height: 2.75rem; border-radius: 0.75rem; border: 2px solid #e9ecef;">
                </div>
                <div class="form-group" style="margin-bottom: 0;">
                    <label style="font-weight: 600; color: #212529;">몸무게 <span style="color: #dc3545;">*</span></label>
                    <input type="number" class="form-control" name="petWeight_${newIndex}" placeholder="몸무게 (kg)" step="0.1" min="0"
                           style="height: 2.75rem; border-radius: 0.75rem; border: 2px solid #e9ecef;">
                </div>
            </div>
        </div>
    `;

    container.insertAdjacentHTML('beforeend', newForm);
    petFormCount++;
    console.log('Pet form added. New count:', petFormCount);
}

/**
 * 반려동물 폼 삭제
 */
function removePetForm(index) {
    if (confirm('이 반려동물 정보를 삭제하시겠습니까?')) {
        const form = document.querySelector(`[data-pet-index="${index}"]`);
        form.remove();
    }
}

/**
 * 반려동물 사진 미리보기
 */
function previewPetPhoto(index, input) {
    const preview = document.getElementById(`pet-photo-preview-${index}`);

    if (input.files && input.files[0]) {
        const reader = new FileReader();

        reader.onload = function(e) {
            preview.innerHTML = `<img src="${e.target.result}" alt="Pet Photo">`;
        };

        reader.readAsDataURL(input.files[0]);
    }
}

// ==================== UI 인터랙션 ====================

/**
 * 비밀번호 표시/숨김 토글
 */
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

/**
 * 아이디 중복 확인
 */
function checkUsername() {
    const username = document.getElementById('username').value;
    if (!username) {
        alert('아이디를 입력해주세요.');
        return;
    }
    // TODO: 실제 중복 확인 API 호출
    alert('사용 가능한 아이디입니다.');
}

/**
 * 전체 약관 동의 토글
 */
function toggleAllTerms() {
    const agreeAll = document.getElementById('agreeAll').checked;
    document.querySelectorAll('.term-checkbox').forEach(cb => cb.checked = agreeAll);
}

// ==================== 이벤트 리스너 초기화 ====================

document.addEventListener('DOMContentLoaded', function() {

    // 역할 카드 선택
    document.querySelectorAll('.role-card').forEach(card => {
        card.addEventListener('click', function() {
            document.querySelectorAll('.role-card').forEach(c => c.classList.remove('selected'));
            this.classList.add('selected');
        });
    });

    // 아이디 실시간 검증
    document.getElementById('username').addEventListener('input', function() {
        const username = this.value;

        if (username.length > 0 && username.length < 4) {
            this.style.borderColor = '#dc3545';
        } else if (username.length > 20) {
            this.style.borderColor = '#dc3545';
        } else if (username.length >= 4 && !/^[a-zA-Z0-9]+$/.test(username)) {
            this.style.borderColor = '#dc3545';
        } else if (username.length >= 4) {
            this.style.borderColor = '#28a745';
        } else {
            this.style.borderColor = '#e9ecef';
        }
    });

    // 비밀번호 실시간 검증
    document.getElementById('password').addEventListener('input', function() {
        const password = this.value;

        if (password.length >= 8 && /(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*])/.test(password)) {
            this.style.borderColor = '#28a745';
        } else if (password.length > 0) {
            this.style.borderColor = '#dc3545';
        } else {
            this.style.borderColor = '#e9ecef';
        }
    });

    // 비밀번호 확인 검증
    document.getElementById('passwordConfirm').addEventListener('input', function() {
        const password = document.getElementById('password').value;
        if (this.value && password !== this.value) {
            this.style.borderColor = '#dc3545';
        } else {
            this.style.borderColor = '#e9ecef';
        }
    });

    // 이메일 실시간 검증
    document.getElementById('email').addEventListener('input', function() {
        const email = this.value;

        if (email.length > 0 && /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
            this.style.borderColor = '#28a745';
        } else if (email.length > 0) {
            this.style.borderColor = '#dc3545';
        } else {
            this.style.borderColor = '#e9ecef';
        }
    });

    // 전화번호 자동 하이픈
    document.getElementById('phone').addEventListener('input', function(e) {
        let value = e.target.value.replace(/[^0-9]/g, '');
        if (value.length > 0) {
            if (value.length <= 3) {
                e.target.value = value;
            } else if (value.length <= 7) {
                e.target.value = value.slice(0, 3) + '-' + value.slice(3);
            } else {
                e.target.value = value.slice(0, 3) + '-' + value.slice(3, 7) + '-' + value.slice(7, 11);
            }
        }
    });

    // 전화번호 실시간 검증
    document.getElementById('phone').addEventListener('blur', function() {
        const phone = this.value;

        if (phone && /^010-\d{4}-\d{4}$/.test(phone)) {
            this.style.borderColor = '#28a745';
        } else if (phone) {
            this.style.borderColor = '#dc3545';
        } else {
            this.style.borderColor = '#e9ecef';
        }
    });

    // 역할 선택 시 3단계 인디케이터 처리
    document.querySelectorAll('input[name="userRole"]').forEach(radio => {
        radio.addEventListener('change', function() {
            const step3Indicator = document.getElementById('step-indicator-3');
            if (isOwner()) {
                step3Indicator.style.opacity = '1';
            } else {
                step3Indicator.style.opacity = '0.3';
            }
        });
    });

    // 폼 제출
    document.getElementById('registerForm').addEventListener('submit', function(e) {
        if (!document.getElementById('agreeTerms').checked || !document.getElementById('agreePrivacy').checked) {
            e.preventDefault();
            alert('필수 약관에 동의해주세요.');
            return;
        }

        // 일반 사용자는 반려동물 정보 제출하지 않음
        if (!isOwner()) {
            document.querySelectorAll('[name^="pet"]').forEach(input => {
                input.disabled = true;
            });
        }
    });
});