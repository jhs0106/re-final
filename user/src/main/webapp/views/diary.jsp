<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <link rel="stylesheet" href="<c:url value='/css/diary.css'/>">
        <!-- FullCalendar CSS -->
        <link href='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.10/index.global.min.css' rel='stylesheet' />

        <div class="diary-container">
            <div class="container">
                <!-- Page Header -->
                <div class="diary-header">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h1>
                                <i class="fas fa-book" style="color: var(--primary-color);"></i>
                                펫 다이어리
                            </h1>
                            <p class="subtitle">
                                우리 아이의 특별한 순간을 기록하고, 자동으로 저장되는 활동들을 확인하세요
                            </p>
                        </div>
                        <button class="btn btn-pet-primary btn-lg" onclick="openAddDiaryModal()">
                            <i class="fas fa-plus-circle mr-2"></i>
                            메모 추가하기
                        </button>
                    </div>
                </div>

                <!-- Summary Statistics -->
                <div class="diary-summary-section mb-4">
                    <div class="row">
                        <div class="col-md-3">
                            <div class="summary-stat-card">
                                <div class="stat-icon" style="background: linear-gradient(135deg, #9775FA, #7950F2);">
                                    <i class="fas fa-book-open"></i>
                                </div>
                                <div class="stat-content">
                                    <h4>총 기록</h4>
                                    <p class="stat-number" id="totalRecords">0</p>
                                    <span class="stat-detail">전체 활동</span>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="summary-stat-card">
                                <div class="stat-icon" style="background: linear-gradient(135deg, #FF6B6B, #FA5252);">
                                    <i class="fas fa-walking"></i>
                                </div>
                                <div class="stat-content">
                                    <h4>산책 기록</h4>
                                    <p class="stat-number" id="walkRecords">0</p>
                                    <span class="stat-detail">자동 저장</span>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="summary-stat-card">
                                <div class="stat-icon" style="background: linear-gradient(135deg, #4ECDC4, #38D9A9);">
                                    <i class="fas fa-video"></i>
                                </div>
                                <div class="stat-content">
                                    <h4>홈캠 이벤트</h4>
                                    <p class="stat-number" id="homecamRecords">0</p>
                                    <span class="stat-detail">AI 감지</span>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="summary-stat-card">
                                <div class="stat-icon" style="background: linear-gradient(135deg, #FFD43B, #FF922B);">
                                    <i class="fas fa-star"></i>
                                </div>
                                <div class="stat-content">
                                    <h4>특별한 날</h4>
                                    <p class="stat-number" id="specialRecords">0</p>
                                    <span class="stat-detail">기념일</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Filter Buttons -->
                <div class="diary-filters mb-4">
                    <div class="d-flex justify-content-between align-items-center">
                        <div class="filter-tags d-flex align-items-center">
                            <select class="form-control form-control-sm mr-2" id="petFilter" style="width: auto;"
                                onchange="filterByPet()">
                                <option value="">모든 반려동물</option>
                                <!-- Dynamically populated -->
                            </select>
                            <button class="filter-tag active" data-type="all" onclick="filterDiaryType('all')">
                                <i class="fas fa-list"></i> 전체
                            </button>
                            <button class="filter-tag" data-type="walk" onclick="filterDiaryType('walk')">
                                <i class="fas fa-walking"></i> 산책
                            </button>
                            <button class="filter-tag" data-type="health" onclick="filterDiaryType('health')">
                                <i class="fas fa-heartbeat"></i> 건강
                            </button>
                            <button class="filter-tag" data-type="homecam" onclick="filterDiaryType('homecam')">
                                <i class="fas fa-video"></i> 홈캠
                            </button>
                            <button class="filter-tag" data-type="memo" onclick="filterDiaryType('memo')">
                                <i class="fas fa-pen"></i> 메모
                            </button>
                            <button class="filter-tag" data-type="special" onclick="filterDiaryType('special')">
                                <i class="fas fa-star"></i> 기념일
                            </button>
                        </div>
                        <div class="view-toggle">
                            <button class="btn btn-sm btn-pet-outline active" id="calendarViewBtn"
                                onclick="switchView('calendar')">
                                <i class="fas fa-calendar-alt"></i> 캘린더
                            </button>
                            <button class="btn btn-sm btn-pet-outline" id="listViewBtn" onclick="switchView('list')">
                                <i class="fas fa-list"></i> 리스트
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Calendar View -->
                <div id="calendarView" class="diary-calendar-section">
                    <div class="info-card">
                        <div class="calendar-header">
                            <h3 class="info-card-title">
                                <i class="fas fa-calendar-alt"></i>
                                통합 타임라인 캘린더
                            </h3>
                            <p class="text-muted">
                                <i class="fas fa-info-circle mr-1"></i>
                                산책, 홈캠 이벤트, 건강 체크 등이 자동으로 기록됩니다
                            </p>
                        </div>
                        <div id="calendar"></div>
                    </div>
                </div>

                <!-- List View -->
                <div id="listView" class="diary-list-section" style="display: none;">
                    <div class="info-card">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h3 class="info-card-title mb-0">
                                <i class="fas fa-clock"></i>
                                최근 활동 내역
                            </h3>
                            <div class="sort-options">
                                <select class="form-control form-control-sm" id="sortSelect" onchange="sortDiaryList()">
                                    <option value="date-desc">최신순</option>
                                    <option value="date-asc">오래된순</option>
                                    <option value="type">유형별</option>
                                </select>
                            </div>
                        </div>

                        <div class="diary-timeline" id="diaryTimeline">
                            <!-- Dynamically populated timeline items will appear here -->
                            <div class="empty-state" id="emptyState">
                                <i class="fas fa-book-open fa-3x text-muted mb-3"></i>
                                <h5 class="text-muted">아직 기록이 없습니다</h5>
                                <p class="text-muted">첫 메모를 추가하거나 활동을 시작해보세요!</p>
                            </div>
                        </div>

                        <!-- Load More Button -->
                        <div class="text-center mt-4" id="loadMoreContainer" style="display: none;">
                            <button class="btn btn-pet-outline" onclick="loadMoreDiaryEntries()">
                                <i class="fas fa-chevron-down mr-2"></i>
                                더보기
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Add/Edit Diary Entry Modal -->
        <div class="modal fade" id="diaryEntryModal" tabindex="-1" role="dialog">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content" style="border-radius: 1.5rem; border: none;">
                    <div class="modal-header" style="border-bottom: 2px solid #e9ecef; padding: 1.5rem 2rem;">
                        <h5 class="modal-title" style="font-size: 1.25rem; font-weight: 700; color: #212529;">
                            <i class="fas fa-pen mr-2" style="color: #9775FA;"></i>
                            <span id="modalTitle">메모 추가하기</span>
                        </h5>
                        <button type="button" class="close" data-dismiss="modal"
                            style="font-size: 1.5rem; opacity: 0.5;">
                            <span>&times;</span>
                        </button>
                    </div>

                    <div class="modal-body" style="padding: 2rem;">
                        <form id="diaryEntryForm">
                            <input type="hidden" id="entryId" name="entryId">

                            <!-- Entry Type -->
                            <div class="form-group">
                                <label>
                                    <i class="fas fa-tag mr-1"></i>
                                    기록 유형 <span class="text-danger">*</span>
                                </label>
                                <select class="form-control" id="entryType" name="entryType" required>
                                    <option value="">선택하세요</option>
                                    <option value="memo">일반 메모</option>
                                    <option value="special">특별한 날/기념일</option>
                                    <option value="health">건강 기록</option>
                                    <option value="food">식사/간식</option>
                                    <option value="grooming">미용</option>
                                    <option value="training">훈련</option>
                                    <option value="other">기타</option>
                                </select>
                            </div>

                            <!-- Title -->
                            <div class="form-group">
                                <label>
                                    <i class="fas fa-heading mr-1"></i>
                                    제목 <span class="text-danger">*</span>
                                </label>
                                <input type="text" class="form-control" id="entryTitle" name="title"
                                    placeholder="예: 우리 뭉치 생일" required maxlength="100">
                            </div>

                            <!-- Date and Time -->
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>
                                            <i class="fas fa-calendar mr-1"></i>
                                            날짜 <span class="text-danger">*</span>
                                        </label>
                                        <input type="date" class="form-control" id="entryDate" name="date" required>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>
                                            <i class="fas fa-clock mr-1"></i>
                                            시간
                                        </label>
                                        <input type="time" class="form-control" id="entryTime" name="time">
                                    </div>
                                </div>
                            </div>

                            <!-- Content -->
                            <div class="form-group">
                                <label>
                                    <i class="fas fa-comment mr-1"></i>
                                    내용 <span class="text-danger">*</span>
                                </label>
                                <textarea class="form-control" id="entryContent" name="content" rows="5"
                                    placeholder="오늘 있었던 일을 자세히 적어주세요..." required></textarea>
                            </div>

                            <!-- Image Upload -->
                            <div class="form-group">
                                <label>
                                    <i class="fas fa-image mr-1"></i>
                                    사진 첨부 (선택사항)
                                </label>
                                <div class="custom-file">
                                    <input type="file" class="custom-file-input" id="entryImages" name="images"
                                        accept="image/*" multiple onchange="previewImages(this)">
                                    <label class="custom-file-label" for="entryImages">파일 선택</label>
                                </div>
                                <small class="form-text text-muted">
                                    최대 5장까지 업로드 가능 (JPG, PNG, GIF)
                                </small>
                                <div id="imagePreviewContainer" class="mt-3 row"></div>
                            </div>

                            <!-- Tags -->
                            <div class="form-group">
                                <label>
                                    <i class="fas fa-tags mr-1"></i>
                                    태그 (선택사항)
                                </label>
                                <input type="text" class="form-control" id="entryTags" name="tags"
                                    placeholder="#행복 #건강 #생일 (스페이스로 구분)">
                                <small class="form-text text-muted">
                                    태그를 추가하면 나중에 쉽게 찾을 수 있어요
                                </small>
                            </div>

                            <!-- Pet Selection (if multiple pets) -->
                            <div class="form-group">
                                <label>
                                    <i class="fas fa-paw mr-1"></i>
                                    반려동물 선택
                                </label>
                                <select class="form-control" id="entryPet" name="petId">
                                    <option value="">전체</option>
                                    <!-- Dynamically populated pet list -->
                                </select>
                            </div>
                        </form>
                    </div>

                    <div class="modal-footer" style="border-top: 2px solid #e9ecef; padding: 1rem 2rem;">
                        <button type="button" class="btn btn-outline-secondary" data-dismiss="modal"
                            style="height: 2.75rem; border-radius: 0.75rem; font-weight: 600; padding: 0 1.5rem;">
                            <i class="fas fa-times mr-2"></i> 취소
                        </button>
                        <button type="button" class="btn btn-primary" onclick="saveDiaryEntry()"
                            style="background: linear-gradient(135deg, #9775FA, #7950F2); border: none; height: 2.75rem; border-radius: 0.75rem; font-weight: 600; padding: 0 1.5rem;">
                            <i class="fas fa-save mr-2"></i> 저장하기
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- View Detail Modal -->
        <div class="modal fade" id="diaryDetailModal" tabindex="-1" role="dialog">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content" style="border-radius: 1.5rem; border: none;">
                    <div class="modal-header" style="border-bottom: 2px solid #e9ecef; padding: 1.5rem 2rem;">
                        <h5 class="modal-title" style="font-size: 1.25rem; font-weight: 700;" id="detailTitle"></h5>
                        <button type="button" class="close" data-dismiss="modal"
                            style="font-size: 1.5rem; opacity: 0.5;">
                            <span>&times;</span>
                        </button>
                    </div>

                    <div class="modal-body" style="padding: 2rem;">
                        <div id="detailContent"></div>
                    </div>

                    <div class="modal-footer" style="border-top: 2px solid #e9ecef; padding: 1rem 2rem;">
                        <button type="button" class="btn btn-outline-danger" onclick="deleteDiaryEntry()"
                            style="height: 2.75rem; border-radius: 0.75rem; font-weight: 600; padding: 0 1.5rem;">
                            <i class="fas fa-trash mr-2"></i> 삭제
                        </button>
                        <button type="button" class="btn btn-outline-primary" onclick="editDiaryEntry()"
                            style="height: 2.75rem; border-radius: 0.75rem; font-weight: 600; padding: 0 1.5rem;">
                            <i class="fas fa-edit mr-2"></i> 수정
                        </button>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal"
                            style="height: 2.75rem; border-radius: 0.75rem; font-weight: 600; padding: 0 1.5rem;">
                            닫기
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- FullCalendar JS -->
        <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.10/index.global.min.js'></script>

        <script>
            (function () {
                let calendar;
                let currentView = 'calendar';
                let currentFilter = 'all';
                let currentPetFilter = '';
                let currentEntryId = null;
                let allEvents = []; // Store all diary events
                let pets = [];

                // Event type configurations
                const eventTypeConfig = {
                    walk: {
                        color: '#FF6B6B',
                        icon: 'fa-walking',
                        label: '산책'
                    },
                    health: {
                        color: '#4ECDC4',
                        icon: 'fa-heartbeat',
                        label: '건강'
                    },
                    homecam: {
                        color: '#FFD43B',
                        icon: 'fa-video',
                        label: '홈캠'
                    },
                    memo: {
                        color: '#9775FA',
                        icon: 'fa-pen',
                        label: '메모'
                    },
                    special: {
                        color: '#FA5252',
                        icon: 'fa-star',
                        label: '기념일'
                    },
                    food: {
                        color: '#38D9A9',
                        icon: 'fa-utensils',
                        label: '식사'
                    },
                    grooming: {
                        color: '#74C0FC',
                        icon: 'fa-cut',
                        label: '미용'
                    },
                    training: {
                        color: '#FF922B',
                        icon: 'fa-graduation-cap',
                        label: '훈련'
                    },
                    other: {
                        color: '#868E96',
                        icon: 'fa-ellipsis-h',
                        label: '기타'
                    }
                };

                // Initialize when page loads
                document.addEventListener('DOMContentLoaded', function () {
                    initializeCalendar();
                    loadPets();
                    loadDiaryData();
                    setDefaultDate();
                });

                function initializeCalendar() {
                    const calendarEl = document.getElementById('calendar');

                    calendar = new FullCalendar.Calendar(calendarEl, {
                        initialView: 'dayGridMonth',
                        locale: 'ko',
                        headerToolbar: {
                            left: 'prev,next today',
                            center: 'title',
                            right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
                        },
                        buttonText: {
                            today: '오늘',
                            month: '월',
                            week: '주',
                            day: '일',
                            list: '목록'
                        },
                        height: 'auto',
                        navLinks: true,
                        editable: false,
                        dayMaxEvents: 3,
                        eventClick: function (info) {
                            showDiaryDetail(info.event);
                        },
                        events: [] // Will be populated by loadDiaryData()
                    });

                    calendar.render();
                }

                function setDefaultDate() {
                    const today = new Date();
                    const dateStr = today.toISOString().split('T')[0];
                    document.getElementById('entryDate').value = dateStr;
                }

                function loadPets() {
                    fetch('/api/diary/pets')
                        .then(response => response.json())
                        .then(data => {
                            pets = data;
                            const petFilter = document.getElementById('petFilter');
                            const entryPet = document.getElementById('entryPet');

                            // Clear existing options except first
                            while (petFilter.options.length > 1) petFilter.remove(1);
                            while (entryPet.options.length > 1) entryPet.remove(1);

                            data.forEach(pet => {
                                // Filter dropdown
                                const option1 = new Option(pet.name, pet.petId);
                                petFilter.add(option1);

                                // Modal dropdown
                                const option2 = new Option(pet.name, pet.petId);
                                entryPet.add(option2);
                            });
                        })
                        .catch(error => console.error('Error loading pets:', error));
                }

                window.filterByPet = function () {
                    currentPetFilter = document.getElementById('petFilter').value;
                    loadDiaryData();
                };

                // Load diary data from backend
                function loadDiaryData() {
                    let url = '/api/diary/entries';
                    const params = new URLSearchParams();
                    if (currentPetFilter) {
                        params.append('petId', currentPetFilter);
                    }

                    if (params.toString()) {
                        url += '?' + params.toString();
                    }

                    fetch(url)
                        .then(response => {
                            if (!response.ok) {
                                throw new Error('Network response was not ok');
                            }
                            return response.json();
                        })
                        .then(data => {
                            allEvents = data;
                            updateCalendar();
                            updateStatistics();
                            renderListView();
                        })
                        .catch(error => {
                            console.error('Error loading diary data:', error);
                            // Show error state in UI
                            const timeline = document.getElementById('diaryTimeline');
                            if (timeline) {
                                timeline.innerHTML = `
                                    <div class="text-center py-5">
                                        <i class="fas fa-exclamation-circle fa-3x text-danger mb-3"></i>
                                        <h5 class="text-muted">데이터를 불러오는데 실패했습니다</h5>
                                        <p class="text-muted">잠시 후 다시 시도해주세요</p>
                                    </div>
                                `;
                            }
                        });
                }

                function updateCalendar() {
                    const filteredEvents = currentFilter === 'all'
                        ? allEvents
                        : allEvents.filter(evt => evt.type === currentFilter);

                    const calendarEvents = filteredEvents.map(evt => {
                        const config = eventTypeConfig[evt.type] || eventTypeConfig.other;
                        return {
                            id: evt.id,
                            title: evt.title,
                            start: evt.date,
                            backgroundColor: config.color,
                            borderColor: config.color,
                            extendedProps: evt
                        };
                    });

                    calendar.removeAllEvents();
                    calendar.addEventSource(calendarEvents);
                }

                function updateStatistics() {
                    const stats = {
                        total: allEvents.length,
                        walk: allEvents.filter(e => e.type === 'walk').length,
                        homecam: allEvents.filter(e => e.type === 'homecam').length,
                        special: allEvents.filter(e => e.type === 'special').length
                    };

                    document.getElementById('totalRecords').textContent = stats.total;
                    document.getElementById('walkRecords').textContent = stats.walk;
                    document.getElementById('homecamRecords').textContent = stats.homecam;
                    document.getElementById('specialRecords').textContent = stats.special;
                }

                function renderListView() {
                    const timeline = document.getElementById('diaryTimeline');
                    const emptyState = document.getElementById('emptyState');

                    const filteredEvents = currentFilter === 'all'
                        ? allEvents
                        : allEvents.filter(evt => evt.type === currentFilter);

                    if (filteredEvents.length === 0) {
                        emptyState.style.display = 'block';
                        return;
                    }

                    emptyState.style.display = 'none';
                    timeline.innerHTML = '';

                    filteredEvents.forEach(entry => {
                        const config = eventTypeConfig[entry.type] || eventTypeConfig.other;
                        const itemHtml = createTimelineItem(entry, config);
                        timeline.insertAdjacentHTML('beforeend', itemHtml);
                    });
                }

                function createTimelineItem(entry, config) {
                    return `
            <div class="diary-item" data-type="\${entry.type}" onclick="showDiaryDetailById('\${entry.id}')">
                <div class="diary-item-icon" style="background: linear-gradient(135deg, \${config.color}, \${config.color}dd);">
                    <i class="fas \${config.icon}"></i>
                </div>
                <div class="diary-item-content">
                    <div class="d-flex justify-content-between align-items-start">
                        <div>
                            <h5 class="diary-item-title">
                                \${entry.title}
                                \${entry.isAuto ? '<span class="badge badge-primary ml-2">자동</span>' : '<span class="badge badge-secondary ml-2">수동</span>'}
                            </h5>
                            <p class="diary-item-date">
                                <i class="fas fa-calendar"></i> \${formatDate(entry.date)}
                            </p>
                        </div>
                        <span class="badge" style="background-color: \${config.color};">\${config.label}</span>
                    </div>
                    <p class="diary-item-preview">\${entry.content || ''}</p>
                    \${entry.meta ? `< div class="diary-item-meta" >\${ entry.meta }</div > ` : ''}
                </div>
            </div>
        `;
                }

                function formatDate(dateStr) {
                    const date = new Date(dateStr);
                    return date.toLocaleDateString('ko-KR', {
                        year: 'numeric',
                        month: 'long',
                        day: 'numeric',
                        weekday: 'short'
                    });
                }

                // Switch between calendar and list view
                window.switchView = function (view) {
                    currentView = view;

                    if (view === 'calendar') {
                        document.getElementById('calendarView').style.display = 'block';
                        document.getElementById('listView').style.display = 'none';
                        document.getElementById('calendarViewBtn').classList.add('active');
                        document.getElementById('listViewBtn').classList.remove('active');
                    } else {
                        document.getElementById('calendarView').style.display = 'none';
                        document.getElementById('listView').style.display = 'block';
                        document.getElementById('calendarViewBtn').classList.remove('active');
                        document.getElementById('listViewBtn').classList.add('active');
                    }
                };

                // Filter diary by type
                window.filterDiaryType = function (type) {
                    currentFilter = type;

                    // Update active button
                    document.querySelectorAll('.filter-tag').forEach(btn => {
                        btn.classList.remove('active');
                    });
                    document.querySelector(`[data-type="\${type}"]`).classList.add('active');

                    updateCalendar();
                    renderListView();
                };

                // Open add diary modal
                window.openAddDiaryModal = function () {
                    currentEntryId = null;
                    document.getElementById('modalTitle').textContent = '메모 추가하기';
                    document.getElementById('diaryEntryForm').reset();
                    setDefaultDate();
                    $('#diaryEntryModal').modal('show');
                };

                // Show diary detail
                function showDiaryDetail(event) {
                    const entry = event.extendedProps;
                    showDiaryDetailById(event.id);
                }

                window.showDiaryDetailById = function (id) {
                    const entry = allEvents.find(e => e.id === id);
                    if (!entry) return;

                    currentEntryId = id;
                    const config = eventTypeConfig[entry.type] || eventTypeConfig.other;

                    document.getElementById('detailTitle').innerHTML = `
            <i class="fas \${config.icon} mr-2" style="color: \${config.color};"></i>
            \${entry.title}
        `;

                    document.getElementById('detailContent').innerHTML = `
            <div class="entry-detail-content">
                <div class="detail-meta mb-3">
                    <span class="badge" style="background-color: \${config.color};">\${config.label}</span>
                    \${entry.isAuto ? '<span class="badge badge-primary ml-2">자동 기록</span>' : '<span class="badge badge-secondary ml-2">수동 기록</span>'}
                </div>
                <p class="text-muted mb-3">
                    <i class="fas fa-calendar mr-2"></i>\${formatDate(entry.date)}
                    \${entry.time ? `< i class="fas fa-clock ml-3 mr-2" ></i >\${ entry.time } ` : ''}
                </p>
                <div class="entry-content">
                    \${entry.content || ''}
                </div>
                \${entry.images && entry.images.length > 0 ? `
                        < div class="entry-images mt-3" >
                            <div class="row">
                                \${entry.images.map(img => `
                                <div class="col-md-4 mb-2">
                                    <img src="\${img}" class="img-fluid rounded" alt="Diary image">
                                </div>
                            `).join('')}
                            </div>
                    </div >
                        ` : ''}
                \${entry.tags ? `
                        < div class="entry-tags mt-3" >
                    \${
                        entry.tags.split(' ').map(tag => `
                            <span class="badge badge-light">\${tag}</span>
                        `).join('')
                    }
                    </div >
                        ` : ''}
            </div>
        `;

                    $('#diaryDetailModal').modal('show');
                };

                // Save diary entry
                window.saveDiaryEntry = function () {
                    const form = document.getElementById('diaryEntryForm');
                    if (!form.checkValidity()) {
                        form.reportValidity();
                        return;
                    }

                    const formData = new FormData(form);

                    // Add dateStr and timeStr explicitly
                    formData.set('dateStr', document.getElementById('entryDate').value);
                    formData.set('timeStr', document.getElementById('entryTime').value);

                    const url = currentEntryId ? '/api/diary/entries' : '/api/diary/entries';
                    const method = currentEntryId ? 'PUT' : 'POST';

                    // If editing, add ID to formData if not present (though it should be in hidden input)
                    if (currentEntryId) {
                        formData.set('id', currentEntryId);
                    }

                    fetch(url, {
                        method: method,
                        body: formData
                    })
                        .then(response => {
                            if (response.ok) {
                                $('#diaryEntryModal').modal('hide');
                                loadDiaryData(); // Reload data
                                alert('저장되었습니다!');
                            } else {
                                return response.text().then(text => { throw new Error(text) });
                            }
                        })
                        .catch(error => {
                            console.error('Error saving diary entry:', error);
                            alert('저장 중 오류가 발생했습니다: ' + error.message);
                        });
                };

                // Edit diary entry
                window.editDiaryEntry = function () {
                    if (!currentEntryId) return;

                    const entry = allEvents.find(e => e.id === currentEntryId);
                    if (!entry) return;

                    $('#diaryDetailModal').modal('hide');

                    // Populate form with existing data
                    document.getElementById('modalTitle').textContent = '메모 수정하기';
                    document.getElementById('entryId').value = entry.id;
                    document.getElementById('entryType').value = entry.type;
                    document.getElementById('entryTitle').value = entry.title;
                    // Handle date format if needed
                    document.getElementById('entryDate').value = entry.date.split('T')[0];
                    document.getElementById('entryTime').value = entry.time || '';
                    document.getElementById('entryContent').value = entry.content || '';
                    document.getElementById('entryTags').value = entry.tags || '';
                    document.getElementById('entryPet').value = entry.petId || '';

                    $('#diaryEntryModal').modal('show');
                };

                // Delete diary entry
                window.deleteDiaryEntry = function () {
                    if (!currentEntryId) return;

                    if (!confirm('정말 삭제하시겠습니까?')) return;

                    fetch(`/api/diary/entries/\${currentEntryId}`, {
                        method: 'DELETE'
                    })
                        .then(response => {
                            if (response.ok) {
                                $('#diaryDetailModal').modal('hide');
                                loadDiaryData(); // Reload data
                                alert('삭제되었습니다!');
                            } else {
                                alert('삭제 중 오류가 발생했습니다.');
                            }
                        })
                        .catch(error => {
                            console.error('Error deleting diary entry:', error);
                            alert('삭제 중 오류가 발생했습니다.');
                        });
                };

                // Sort diary list
                window.sortDiaryList = function () {
                    const sortValue = document.getElementById('sortSelect').value;

                    if (sortValue === 'date-desc') {
                        allEvents.sort((a, b) => new Date(b.date) - new Date(a.date));
                    } else if (sortValue === 'date-asc') {
                        allEvents.sort((a, b) => new Date(a.date) - new Date(b.date));
                    } else if (sortValue === 'type') {
                        allEvents.sort((a, b) => a.type.localeCompare(b.type));
                    }

                    renderListView();
                };

                // Load more diary entries
                window.loadMoreDiaryEntries = function () {
                    // Placeholder for pagination
                    console.log('Load more entries');
                };

                // Preview images
                window.previewImages = function (input) {
                    const container = document.getElementById('imagePreviewContainer');
                    container.innerHTML = '';

                    if (input.files) {
                        Array.from(input.files).forEach((file, index) => {
                            if (index >= 5) return; // Max 5 images

                            const reader = new FileReader();
                            reader.onload = function (e) {
                                const col = document.createElement('div');
                                col.className = 'col-md-3 mb-2';
                                col.innerHTML = `
                        <div class="position-relative">
                            <img src="\${e.target.result}" class="img-fluid rounded" alt="Preview">
                            <button type="button" class="btn btn-sm btn-danger position-absolute" 
                                    style="top: 5px; right: 20px;" onclick="removePreviewImage(\${index})">
                                <i class="fas fa-times"></i>
                            </button>
                        </div>
                    `;
                                container.appendChild(col);
                            };
                            reader.readAsDataURL(file);
                        });

                        // Update file input label
                        const label = document.querySelector('.custom-file-label');
                        const fileCount = Math.min(input.files.length, 5);
                        label.textContent = `\${fileCount}개 파일 선택됨`;
                    }
                };

                window.removePreviewImage = function (index) {
                    // Placeholder for image removal
                    console.log('Remove image at index:', index);
                };
            })();
        </script>