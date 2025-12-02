// ============================================
// 마이페이지 전용 JavaScript
// ============================================

// ========== 탭 전환 ==========
function showTab(tabName) {
    document.querySelectorAll('.tab-panel').forEach(panel => {
        panel.classList.remove('active');
    });
    document.querySelectorAll('.mypage-tab').forEach(tab => {
        tab.classList.remove('active');
    });
    document.getElementById('tab-' + tabName).classList.add('active');
    event.currentTarget.classList.add('active');
}

// ========== 폼 리셋 ==========
function resetForm() {
    if (confirm('변경사항을 취소하시겠습니까?')) {
        location.reload();
    }
}

// ========== 비밀번호 보기/숨기기 ==========
function togglePasswordVisibility(inputId) {
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

// ========== 프로필 정보 수정 ==========
document.addEventListener('DOMContentLoaded', function () {
    const profileForm = document.getElementById('profileForm');
    if (profileForm) {
        profileForm.addEventListener('submit', function (e) {
            e.preventDefault();
            alert('프로필 수정 기능 (개발 예정)');
            // TODO: /api/mypage/profile PUT 요청
        });
    }
});

// ========== 비밀번호 변경 ==========
document.addEventListener('DOMContentLoaded', function () {
    const passwordForm = document.getElementById('passwordForm');
    if (passwordForm) {
        passwordForm.addEventListener('submit', function (e) {
            e.preventDefault();
            const newPassword = document.getElementById('newPassword').value;
            const confirmPassword = document.getElementById('confirmPassword').value;

            if (newPassword !== confirmPassword) {
                alert('새 비밀번호가 일치하지 않습니다.');
                return;
            }
            if (newPassword.length < 8) {
                alert('비밀번호는 8자 이상이어야 합니다.');
                return;
            }
            alert('비밀번호 변경 기능 (개발 예정)');
            // TODO: /api/mypage/password PUT 요청
        });
    }
});

// ========== 프로필 이미지 업로드 ==========
document.addEventListener('DOMContentLoaded', function() {
    const input = document.getElementById('profileImageInput');
    if (input) {
        input.addEventListener('change', function (e) {
            const file = e.target.files[0];
            if (!file) return;

            if (!file.type.startsWith('image/')) {
                alert('이미지 파일만 업로드 가능합니다.');
                e.target.value = '';
                return;
            }
            if (file.size > 5 * 1024 * 1024) {
                alert('파일 크기는 5MB 이하여야 합니다.');
                e.target.value = '';
                return;
            }
            alert('프로필 이미지 업로드 기능 (개발 예정)');
            // TODO: /api/mypage/profile-image POST 요청
        });
    }
});

// ========== 회원 탈퇴 ==========
function withdrawAccount() {
    if (confirm('정말 탈퇴하시겠습니까?\n모든 데이터가 삭제되며 복구할 수 없습니다.')) {
        alert('회원 탈퇴 기능 (개발 예정)');
        // TODO: /api/mypage/withdraw DELETE 요청
    }
}

// ========== 반려동물 관련 ==========
function openAddPetModal() {
    alert('반려동물 추가 기능 (개발 예정)');
}

function editPet(petId) {
    alert('반려동물 수정 기능 (개발 예정)\nID: ' + petId);
}

function deletePet(petId) {
    if (confirm('이 반려동물 정보를 삭제하시겠습니까?')) {
        alert('반려동물 삭제 기능 (개발 예정)\nID: ' + petId);
    }
}

// ========== 다이어리 필터링 ==========
document.addEventListener('DOMContentLoaded', function() {
    const filterTags = document.querySelectorAll('.filter-tag');
    filterTags.forEach(tag => {
        tag.addEventListener('click', function() {
            filterTags.forEach(t => t.classList.remove('active'));
            this.classList.add('active');
            const filterType = this.dataset.tag;
            filterDiaryItems(filterType);
        });
    });
});

function filterDiaryItems(type) {
    const items = document.querySelectorAll('.diary-item');
    items.forEach(item => {
        if (type === 'all' || item.dataset.type === type) {
            item.style.display = 'flex';
        } else {
            item.style.display = 'none';
        }
    });
}

function changeView(viewType) {
    const buttons = document.querySelectorAll('.view-options .btn');
    buttons.forEach(btn => btn.classList.remove('active'));
    event.currentTarget.classList.add('active');
    console.log('뷰 전환:', viewType);
}

function openAddMemoModal(dateStr) {
    alert('메모 추가 기능 (개발 예정)' + (dateStr ? '\n날짜: ' + dateStr : ''));
}

function loadMoreDiary() {
    alert('더보기 기능 (개발 예정)');
}

// ========== FullCalendar 초기화 (간단 버전) ==========
document.addEventListener('DOMContentLoaded', function() {
    const calendarEl = document.getElementById('diary-calendar-container');

    if (calendarEl && typeof FullCalendar !== 'undefined') {
        calendarEl.innerHTML = '';

        const calendar = new FullCalendar.Calendar(calendarEl, {
            initialView: 'dayGridMonth',
            locale: 'ko',
            height: 'auto',
            headerToolbar: {
                left: 'prev,next today',
                center: 'title',
                right: 'dayGridMonth,timeGridWeek,listWeek'
            },
            buttonText: {
                today: '오늘',
                month: '월',
                week: '주',
                list: '목록'
            },

            // 샘플 데이터 (나중에 서버에서 가져올 예정)
            events: [
                {
                    title: '한강공원 산책',
                    start: '2024-12-02',
                    backgroundColor: '#FF6B6B'
                },
                {
                    title: '홈캠 이벤트',
                    start: '2024-12-02',
                    backgroundColor: '#FFD43B'
                },
                {
                    title: '동물병원 방문',
                    start: '2024-11-30',
                    backgroundColor: '#4ECDC4'
                },
                {
                    title: '🎂 생일 축하!',
                    start: '2024-11-25',
                    backgroundColor: '#FF6B6B'
                }
            ],

            eventClick: function(info) {
                alert('이벤트 상세 기능 (개발 예정)\n\n' + info.event.title);
                // TODO: 상세 정보 모달 표시
            },

            dateClick: function(info) {
                console.log('날짜 클릭:', info.dateStr);
                // TODO: 메모 추가 기능
            }
        });

        calendar.render();
    }
});

// ========== 행동 리포트 ==========
function changeReportPeriod(period) {
    const buttons = document.querySelectorAll('.report-controls .btn-group .btn');
    buttons.forEach(btn => btn.classList.remove('active'));
    event.currentTarget.classList.add('active');
    console.log('리포트 기간:', period);
    // TODO: 서버에서 데이터 가져오기
}

function generateReport() {
    if (confirm('최신 데이터로 리포트를 생성하시겠습니까?')) {
        alert('리포트 생성 기능 (개발 예정)');
        // TODO: AI 분석 요청
    }
}

// ========== Chart.js 초기화 (나중에 구현) ==========
document.addEventListener('DOMContentLoaded', function() {
    const activityCtx = document.getElementById('activityCanvas');
    if (activityCtx) {
        // TODO: Chart.js로 활동량 차트 그리기
        // 지금은 캔버스만 있음
    }
});