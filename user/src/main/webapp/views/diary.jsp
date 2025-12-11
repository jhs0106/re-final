<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!-- 펫 다이어리 컨테이너 -->
        <div class="diary-container">
            <div class="diary-wrapper">

                <!-- 헤더 섹션 -->
                <div class="diary-header">
                    <div class="diary-header-content">
                        <h1 class="diary-title">
                            <i class="fas fa-book-open"></i>
                            펫 다이어리
                        </h1>
                        <p class="diary-subtitle">AI가 반려동물 입장에서 작성하는 특별한 하루</p>
                    </div>
                    <div class="diary-legend">
                        <span class="legend-item walk">
                            <i class="fas fa-walking"></i> 산책일기
                        </span>
                        <span class="legend-item behavior">
                            <i class="fas fa-camera"></i> 행동일기
                        </span>
                        <span class="legend-item health">
                            <i class="fas fa-heartbeat"></i> 건강일기
                        </span>
                        <span class="legend-item daily">
                            <i class="fas fa-heart"></i> 하루일기
                        </span>
                    </div>
                </div>

                <!-- AI 시뮬레이션 컨트롤 패널 (데모용) -->
                <div class="ai-simulation-controls mb-4">
                    <div class="card border-0 shadow-sm"
                        style="background: linear-gradient(135deg, #ffffff 0%, #f8f9fa 100%);">
                        <div class="card-body p-3 d-flex align-items-center justify-content-between flex-wrap gap-3">
                            <span class="badge badge-pill badge-light text-dark p-2" style="font-size: 0.9rem;">
                                <i class="fas fa-cogs"></i> 데이터 수신 후 일기 생성
                            </span>
                            <div class="btn-group" role="group">
                                <button type="button" class="btn btn-outline-info rounded-pill mr-2"
                                    onclick="addPendingEvent('walk')">
                                    <i class="fas fa-walking"></i> 산책 데이터 수신
                                </button>
                                <button type="button" class="btn btn-outline-success rounded-pill mr-2"
                                    onclick="addPendingEvent('behavior')">
                                    <i class="fas fa-video"></i> 홈캠 분석 완료
                                </button>
                                <button type="button" class="btn btn-outline-danger rounded-pill mr-2"
                                    onclick="addPendingEvent('health')">
                                    <i class="fas fa-notes-medical"></i> 건강 검진 결과
                                </button>
                                <button type="button" class="btn btn-outline-primary rounded-pill"
                                    onclick="addPendingEvent('daily')">
                                    <i class="fas fa-star"></i> 하루 일기 생성
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 캘린더 섹션 -->
                <div class="diary-calendar-card">
                    <div id="diaryCalendar"></div>
                </div>

                <!-- 로딩 오버레이 -->
                <div id="simulationLoading"
                    style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); z-index: 9999; text-align: center; padding-top: 20%;">
                    <div class="spinner-border text-light" style="width: 3rem; height: 3rem;" role="status">
                        <span class="sr-only">Loading...</span>
                    </div>
                    <h4 class="text-light mt-3" id="loadingText">데이터 수신 중...</h4>
                </div>
            </div>
        </div>

        <!-- 산책일기 모달 -->
        <div class="modal fade" id="walkDiaryModal" tabindex="-1" role="dialog">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content diary-modal-content walk-modal">
                    <div class="modal-header diary-modal-header walk-header">
                        <h5 class="modal-title">
                            <i class="fas fa-walking"></i>
                            <span id="walkDiaryTitle">산책일기</span>
                        </h5>
                        <button type="button" class="close" data-dismiss="modal" style="color: white;">
                            <span>&times;</span>
                        </button>
                    </div>
                    <div class="modal-body diary-modal-body">
                        <div class="diary-meta">
                            <span class="diary-date" id="walkDiaryDate"></span>
                            <span class="diary-pet" id="walkDiaryPet"></span>
                        </div>
                        <div class="diary-content" id="walkDiaryContent"></div>
                        <div class="diary-metadata">
                            <h6><i class="fas fa-map-marked-alt"></i> 산책 정보</h6>
                            <div class="metadata-grid">
                                <div class="metadata-item">
                                    <span class="metadata-label">거리</span>
                                    <span class="metadata-value" id="walkDistance"></span>
                                </div>
                                <div class="metadata-item">
                                    <span class="metadata-label">시간</span>
                                    <span class="metadata-value" id="walkDuration"></span>
                                </div>
                                <div class="metadata-item">
                                    <span class="metadata-label">경로</span>
                                    <span class="metadata-value" id="walkRoute"></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 행동일기 모달 -->
        <div class="modal fade" id="behaviorDiaryModal" tabindex="-1" role="dialog">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content diary-modal-content behavior-modal">
                    <div class="modal-header diary-modal-header behavior-header">
                        <h5 class="modal-title">
                            <i class="fas fa-camera"></i>
                            <span id="behaviorDiaryTitle">행동일기</span>
                        </h5>
                        <button type="button" class="close" data-dismiss="modal" style="color: white;">
                            <span>&times;</span>
                        </button>
                    </div>
                    <div class="modal-body diary-modal-body">
                        <div class="diary-meta">
                            <span class="diary-date" id="behaviorDiaryDate"></span>
                            <span class="diary-pet" id="behaviorDiaryPet"></span>
                        </div>
                        <div class="diary-content" id="behaviorDiaryContent"></div>
                        <div class="diary-metadata">
                            <h6><i class="fas fa-video"></i> 홈캠 이벤트</h6>
                            <div class="event-list" id="behaviorEvents"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 건강일기 모달 -->
        <div class="modal fade" id="healthDiaryModal" tabindex="-1" role="dialog">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content diary-modal-content health-modal">
                    <div class="modal-header diary-modal-header health-header">
                        <h5 class="modal-title">
                            <i class="fas fa-heartbeat"></i>
                            <span id="healthDiaryTitle">건강일기</span>
                        </h5>
                        <button type="button" class="close" data-dismiss="modal" style="color: white;">
                            <span>&times;</span>
                        </button>
                    </div>
                    <div class="modal-body diary-modal-body">
                        <div class="diary-meta">
                            <span class="diary-date" id="healthDiaryDate"></span>
                            <span class="diary-pet" id="healthDiaryPet"></span>
                        </div>
                        <div class="diary-content" id="healthDiaryContent"></div>
                        <div class="diary-metadata">
                            <h6><i class="fas fa-stethoscope"></i> 진단 정보</h6>
                            <div style="display: flex; flex-direction: column; gap: 1rem;">
                                <div class="metadata-item">
                                    <span class="metadata-label">심각도</span>
                                    <span class="metadata-value" id="healthSeverity" style="font-weight: 700;"></span>
                                </div>
                                <div class="metadata-item">
                                    <span class="metadata-label">진단 소견</span>
                                    <div id="healthFindings"
                                        style="margin-top: 0.5rem; color: #495057; line-height: 1.6;"></div>
                                </div>
                                <div class="metadata-item">
                                    <span class="metadata-label">권장 조치</span>
                                    <div id="healthRecommendations"
                                        style="margin-top: 0.5rem; color: #495057; line-height: 1.6;"></div>
                                </div>
                                <div class="metadata-item">
                                    <span class="metadata-label">응급처치</span>
                                    <div id="healthFirstAid"
                                        style="margin-top: 0.5rem; color: #d63384; line-height: 1.6;"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 하루일기 모달 -->
        <div class="modal fade" id="dailyDiaryModal" tabindex="-1" role="dialog">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content diary-modal-content daily-modal">
                    <div class="modal-header diary-modal-header daily-header">
                        <h5 class="modal-title">
                            <i class="fas fa-heart"></i>
                            <span id="dailyDiaryTitle">하루일기</span>
                        </h5>
                        <button type="button" class="close" data-dismiss="modal" style="color: white;">
                            <span>&times;</span>
                        </button>
                    </div>
                    <div class="modal-body diary-modal-body">
                        <div class="diary-meta">
                            <span class="diary-date" id="dailyDiaryDate"></span>
                            <span class="diary-pet" id="dailyDiaryPet"></span>
                        </div>
                        <div class="diary-content" id="dailyDiaryContent"></div>
                        <div class="diary-metadata">
                            <h6><i class="fas fa-clipboard-list"></i> 하루 요약</h6>
                            <div class="summary-grid">
                                <div class="summary-item">
                                    <i class="fas fa-walking"></i>
                                    <span id="dailySummaryWalk"></span>
                                </div>
                                <div class="summary-item">
                                    <i class="fas fa-camera"></i>
                                    <span id="dailySummaryBehavior"></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- FullCalendar CSS -->
        <link href='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.10/index.global.min.css' rel='stylesheet' />

        <!-- FullCalendar JS -->
        <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.10/index.global.min.js'></script>
        <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.10/locales/ko.global.min.js'></script>

        <script>
            let calendar; // 전역 변수

            document.addEventListener('DOMContentLoaded', function () {

                // ============ 1. Historical Data (과거 데이터 - 12월 10일 이전) ============
                const existingDiaries = [
                    // ========== 12월 9일 Homecam ==========
                    {
                        id: 3,
                        type: 'behavior',
                        date: '2025-12-09',
                        title: '혼자서도 잘 있어요',
                        petName: 'qwer',
                        content: '주인님 잠깐 나갔을 때 외로워서 하울링 했어요... 📢\\n하지만 금방 장난감 가지고 놀면서 씩씩하게 기다렸답니다!\\n주인님이 오셔서 칭찬해주셨어요. 🐶',
                        events: [
                            { time: '14:30:15', event: '강아지가 분리불안 증상을 보이며 하울링을 하고 있습니다. 불안해 보입니다.', analysis: '🔴 위험 (분리불안)' },
                            { time: '14:15:22', event: '강아지가 장난감을 가지고 활발하게 놀고 있습니다. 심리적으로 안정된 상태입니다.', analysis: '🟢 정상 (놀이 활동)' }
                        ]
                    },
                    // ========== 12월 10일 Walk (어제 - 가벼운 산책) ==========
                    {
                        id: 10,
                        type: 'walk',
                        date: '2025-12-10',
                        title: '밤 산책 다녀왔어요',
                        petName: 'qwer',
                        content: '밤늦게 잠깐 동네 마실 다녀왔어요. 🌙\\n짧게 "0.4km" 걸었지만 밤바람이 시원했어요.\\n내일은 더 많이 걷고 싶어요!',
                        distance: '0.4km',
                        duration: '15분',
                        route: '동네 마실'
                    },
                    // ========== 12월 10일 Health (어제 - 농피증 발견) ==========
                    {
                        id: 11,
                        type: 'health',
                        date: '2025-12-10',
                        title: '발바닥이 이상해요',
                        petName: 'qwer',
                        content: '발바닥이 따끔거려서 검사했더니 "농피증 초기"래요. 😢\\n병원 가보라고 해서 내일 가기로 했어요. 아픈건 싫은데... 얼른 낫고 싶어요!',
                        severity: '🏥 병원 방문 권장 (신뢰도 98%)',
                        findings: '발바닥 패드 사이에서 발적 및 부종이 관찰됩니다.\\n가려움증을 동반한 농피증 초기 증상으로 보입니다.',
                        recommendations: '동물병원을 방문하여 소독 및 처방을 받으세요. 습기를 피하고 통풍을 유지해야 합니다.',
                        firstAid: '환부를 핥지 못하게 넥카라를 씌우고, 시원한 물로 씻겨 진정시켜 주세요. 사람이 쓰는 연고는 절대 바르지 마세요.'
                    }
                ];

                // ============ 2. Pending Data (12월 11일 오늘 - 시연용) ============
                const pendingDiaries = {
                    'walk': {
                        id: 1,
                        type: 'walk',
                        date: '2025-12-11',
                        title: '오늘의 엄청난 산책량!',
                        petName: 'qwer',
                        content: '오늘 무려 "6번"이나 산책을 나갔어요! 🐾\\n\\n 주인님 말고도 다른 분이 산책을 시켜주기도 한 날이었어요\\n\\n동네 마실부터, 하트 코스까지 다양하게 다녔답니다.\\n\\n총 "3.2km"를 걷고 "41분" 동안 신나게 뛰어놀았어요. 친구들도 많이 만나고 정말 알찬 하루였어요! 🐶',
                        distance: '3.2km (총 6회)',
                        duration: '41분',
                        route: '평균 4.5km/h'
                    },
                    'health': {
                        id: 4,
                        type: 'health',
                        date: '2025-12-11',
                        title: '눈이 너무 아파요 😢',
                        petName: 'qwer',
                        content: '눈 주위가 너무 따갑고 아파요. 거울을 봤더니 상처가 나고 퉁퉁 부었어요... 😭\\n\\n주인님이 보시고 깜짝 놀라서 빨리 병원 가자고 하셨어요.\\n\\n너무 아프지만 씩씩하게 치료받고 올게요!',
                        severity: '🏥 병원 방문 권장 (신뢰도 90%)',
                        findings: '눈 주위에 심각한 상처와 딱지가 관찰됩니다.\\n눈이 부어있고 염증이 있는 것으로 보입니다.',
                        recommendations: '즉시 동물병원을 방문하여 전문적인 진료를 받으세요. 감염이나 더 심각한 상태로 진행될 수 있습니다.',
                        firstAid: '상처 부위를 깨끗한 물로 부드럽게 세척하고, 감염 방지를 위해 항생제 연고를 바르세요. 그러나 전문적인 치료가 필요합니다.'
                    },
                    'daily': {
                        id: 4,
                        type: 'daily',
                        date: '2025-12-11',
                        title: '다사다난한 하루 🐶',
                        petName: 'qwer',
                        content: '오늘은 정말 많은 일이 있었어요. 🐾\\n\\n산책은 무려 "6번"이나 나가서 "3.2km"나 걸으며 신나게 뛰어놀았답니다!\\n\\n하지만 점심때 "테이블 위"에 올라갔다가 위험할 뻔했어요... 😅 밥은 맛있게 먹었지만요.\\n\\n그리고 "눈이 너무 아파서" 병원에 가야 한대요. 🏥 얼른 나아서 내일은 더 씩씩하게 놀고 싶어요!',
                        walkSummary: '3.2km / 41분 (6회)',
                        behaviorSummary: '홈캠: 테이블 등반 (위험)'
                    },
                    'behavior': {
                        id: 2,
                        type: 'behavior',
                        date: '2025-12-11',
                        title: '활발함이 저죠! 😄',
                        petName: 'qwer',
                        content: '오늘 주인님 없을 때도 저는 아주 바빴어요! 😄\\n\\n밥도 냠냠 맛있게 한 그릇 뚝딱 비웠고요. 🥣\\n\\n식탁 위에 뭐가 있는지 너무 궁금해서 살짝(?) 올라가 봤는데... 조금 높아서 무서웠지만 신기했어요! 😮\\n\\n그래도 다치면 안 되니까 다음부터는 조심할게요. 헤헤. 🐕',
                        events: [
                            { time: '14:46:35', event: '강아지가 테이블 위에 올라가 있습니다. 호기심이 많고 활발해 보입니다. 다만, 테이블 위에 올라가는 것은 위험할 수 있으니 주의가 필요합니다.', analysis: '🔴 위험 (낙상 주의)' },
                            { time: '13:53:12', event: '반려동물이 사료를 먹고 있으며 건강하고 안전해 보입니다.', analysis: '🟢 정상 (식사 활동)' },
                            { time: '13:52:55', event: '강아지가 사료를 먹고 있는 모습입니다. 건강하고 기분도 좋아 보입니다.', analysis: '🟢 정상 (식사 활동)' }
                        ]
                    }
                };


                // ============ FullCalendar 초기화 ============
                const calendarEl = document.getElementById('diaryCalendar');
                calendar = new FullCalendar.Calendar(calendarEl, {
                    initialView: 'dayGridMonth',
                    locale: 'ko',
                    height: 'auto',
                    headerToolbar: {
                        left: 'prev,next today',
                        center: 'title',
                        right: 'dayGridMonth'
                    },
                    events: existingDiaries.map(diary => formatEvent(diary)),
                    eventClick: function (info) {
                        showDiaryModal(info.event);
                    }
                });

                calendar.render();

                // ============ Simulataion Logic ============
                window.addPendingEvent = function (type) {
                    const data = pendingDiaries[type];
                    if (!data) {
                        alert("해당 타입의 시연 데이터가 없습니다.");
                        return;
                    }

                    // 로딩 표시
                    const loadingText = document.getElementById('loadingText');
                    const loading = document.getElementById('simulationLoading');

                    const emojis = ['🐶', '🐱', '🐾', '🐕', '🐈'];
                    const randomEmoji = emojis[Math.floor(Math.random() * emojis.length)];
                    loadingText.innerText = `${randomEmoji} 열심히 일기를 적고 있어요...`;

                    loading.style.display = 'block';

                    setTimeout(() => {
                        loading.style.display = 'none';

                        // 캘린더에 이벤트 추가
                        calendar.addEvent(formatEvent(data));

                        // 사용하지 않은 데이터 처리 (중복 추가 방지하려면 delete pendingDiaries[type] 등 가능)
                    }, 1500);
                };

                // Helper: Raw Diary Data -> Calendar Event Object
                function formatEvent(diary) {
                    return {
                        id: diary.id,
                        title: diary.title,
                        date: diary.date,
                        backgroundColor: getEventColor(diary.type),
                        borderColor: getEventColor(diary.type),
                        extendedProps: {
                            type: diary.type,
                            petName: diary.petName,
                            content: diary.content,
                            distance: diary.distance,
                            duration: diary.duration,
                            route: diary.route,
                            events: diary.events,
                            severity: diary.severity,
                            findings: diary.findings,
                            recommendations: diary.recommendations,
                            walkSummary: diary.walkSummary,
                            behaviorSummary: diary.behaviorSummary
                        }
                    };
                }

                function getEventColor(type) {
                    switch (type) {
                        case 'walk': return '#4ECDC4';
                        case 'behavior': return '#51CF66';
                        case 'health': return '#FF8787';
                        case 'daily': return '#B197FC';
                        default: return '#868e96';
                    }
                }

                function showDiaryModal(event) {
                    const type = event.extendedProps.type;
                    const props = event.extendedProps;

                    // 더 이상 "AI 생성 버튼"이 필요 없음. 바로 내용 표시.
                    if (type === 'walk') {
                        $('#walkDiaryTitle').text(event.title);
                        $('#walkDiaryDate').text(event.start.toLocaleDateString('ko-KR'));
                        $('#walkDiaryPet').text(props.petName);
                        $('#walkDiaryContent').html(props.content.replace(/\\n/g, '<br>'));
                        $('#walkDistance').text(props.distance);
                        $('#walkDuration').text(props.duration);
                        $('#walkRoute').text(props.route);
                        $('#walkDiaryModal').modal('show');
                    } else if (type === 'behavior') {
                        $('#behaviorDiaryTitle').text(event.title);
                        $('#behaviorDiaryDate').text(event.start.toLocaleDateString('ko-KR'));
                        $('#behaviorDiaryPet').text(props.petName);
                        $('#behaviorDiaryContent').html(props.content.replace(/\\n/g, '<br>'));

                        let eventsHtml = '';
                        if (props.events) {
                            props.events.forEach(evt => {
                                eventsHtml += `
                                    <div class="event-item">
                                        <span class="event-time">\${evt.time}</span>
                                        <span class="event-desc">\${evt.event}</span>
                                        <span class="event-analysis">\${evt.analysis}</span>
                                    </div>
                                `;
                            });
                        }
                        $('#behaviorEvents').html(eventsHtml);
                        $('#behaviorDiaryModal').modal('show');
                    } else if (type === 'health') {
                        $('#healthDiaryTitle').text(event.title);
                        $('#healthDiaryDate').text(event.start.toLocaleDateString('ko-KR'));
                        $('#healthDiaryPet').text(props.petName);
                        $('#healthDiaryContent').html(props.content.replace(/\\n/g, '<br>'));
                        $('#healthSeverity').text(props.severity);
                        $('#healthFindings').html(props.findings.replace(/\\n/g, '<br>'));
                        $('#healthRecommendations').html(props.recommendations.replace(/\\n/g, '<br>'));
                        $('#healthFirstAid').html(props.firstAid ? props.firstAid.replace(/\\n/g, '<br>') : '정보 없음');
                        $('#healthDiaryModal').modal('show');
                    } else if (type === 'daily') {
                        $('#dailyDiaryTitle').text(event.title);
                        $('#dailyDiaryDate').text(event.start.toLocaleDateString('ko-KR'));
                        $('#dailyDiaryPet').text(props.petName);
                        $('#dailyDiaryContent').html(props.content.replace(/\\n/g, '<br>'));
                        $('#dailySummaryWalk').text(props.walkSummary);
                        $('#dailySummaryBehavior').text(props.behaviorSummary);
                        $('#dailyDiaryModal').modal('show');
                    }
                }

                // ============ Backend Integration Guide ============
                /*
                 * TODO: Backend API integration
                 * ... (Rest of comments)
                 */
            });
        </script>