<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <link rel="stylesheet" href="<c:url value='/css/mypage.css'/>">

        <div class="mypage-container">
            <div class="mypage-wrapper">

                <h2 class="section-title">
                    <i class="fas fa-chart-line"></i>
                    펫 분석 리포트
                </h2>
                <p class="text-muted mb-4">AI가 반려동물의 활동, 건강, 행동 데이터를 종합 분석한 리포트입니다</p>

                <div class="report-controls mb-4">
                    <div class="d-flex justify-content-between align-items-center flex-wrap">
                        <div class="btn-group mb-2" role="group">
                            <button type="button" class="btn btn-pet-outline" id="dailyBtn"
                                onclick="changeReportPeriod('daily')">
                                <i class="fas fa-calendar-day"></i> 일간
                            </button>
                            <button type="button" class="btn btn-pet-outline active" id="weeklyBtn"
                                onclick="changeReportPeriod('weekly')">
                                <i class="fas fa-calendar-week"></i> 주간
                            </button>
                            <button type="button" class="btn btn-pet-outline" id="monthlyBtn"
                                onclick="changeReportPeriod('monthly')">
                                <i class="fas fa-calendar-alt"></i> 월간
                            </button>
                        </div>
                        <div class="text-muted mb-2">
                            <small id="reportPeriodText">2025.12.01 - 2025.12.05 (5일간)</small>
                        </div>
                    </div>
                </div>

                <div class="row mb-4" id="stats Cards">
                    <div class="col-md-3 col-sm-6 mb-3">
                        <div class="report-stat-card">
                            <div class="report-stat-icon"
                                style="background: linear-gradient(135deg, #4ECDC4, #38D9A9);">
                                <i class="fas fa-walking"></i>
                            </div>
                            <div class="report-stat-content">
                                <h5>평균 산책 시간</h5>
                                <p class="report-stat-value" id="avgWalkTime">38분</p>
                                <span class="report-stat-change positive">
                                    <i class="fas fa-arrow-up"></i> 전주대비 15% 증가
                                </span>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6 mb-3">
                        <div class="report-stat-card">
                            <div class="report-stat-icon"
                                style="background: linear-gradient(135deg, #FF6B6B, #FA5252);">
                                <i class="fas fa-route"></i>
                            </div>
                            <div class="report-stat-content">
                                <h5>평균 산책 거리</h5>
                                <p class="report-stat-value" id="avgWalkDistance">1.97km</p>
                                <span class="report-stat-change positive">
                                    <i class="fas fa-arrow-up"></i> 전주대비 10% 증가
                                </span>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6 mb-3">
                        <div class="report-stat-card">
                            <div class="report-stat-icon"
                                style="background: linear-gradient(135deg, #FF8787, #FF6B9D);">
                                <i class="fas fa-heartbeat"></i>
                            </div>
                            <div class="report-stat-content">
                                <h5>건강 체크</h5>
                                <p class="report-stat-value" id="healthCheckCount">2회</p>
                                <span class="report-stat-change neutral">
                                    <i class="fas fa-check-circle"></i> 전체 양호
                                </span>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6 mb-3">
                        <div class="report-stat-card">
                            <div class="report-stat-icon"
                                style="background: linear-gradient(135deg, #51CF66, #37B24D);">
                                <i class="fas fa-camera"></i>
                            </div>
                            <div class="report-stat-content">
                                <h5>홈캠 분석</h5>
                                <p class="report-stat-value" id="homecamEvents">8건</p>
                                <span class="report-stat-change positive">
                                    <i class="fas fa-smile"></i> 활동적
                                </span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="info-card mb-4">
                    <h3 class="info-card-title">
                        <i class="fas fa-brain"></i>
                        AI 종합 분석 리포트
                    </h3>
                    <div id="llmReportControl" style="text-align: center; padding: 3rem;">
                        <button class="btn btn-primary btn-lg ai-gen-btn" onclick="simulateReportGeneration()">
                            <i class="fas fa-magic"></i> AI 종합 분석 리포트 생성
                        </button>
                        <div class="ai-loading" style="display: none;">
                            <div class="spinner-border text-primary" role="status" style="width: 3rem; height: 3rem;">
                                <span class="sr-only">Loading...</span>
                            </div>
                            <h5 class="mt-3">AI가 뽀삐의 일주일 데이터를 정밀 분석 중입니다...</h5>
                            <p class="text-muted">산책 통계 · 영양 상태 · 행동 패턴 분석 중</p>
                        </div>
                    </div>

                    <div id="llmReport" style="display: none;">
                        <jsp:include page="common/ai_report_content.jsp" />
                    </div>
                </div>

                <div class="row mb-4">
                    <div class="col-md-6 mb-4">
                        <div class="info-card">
                            <h3 class="info-card-title">
                                <i class="fas fa-chart-line"></i>
                                주간 산책 기록
                            </h3>
                            <div style="height: 250px; display: flex; align-items: center; justify-content: center;">
                                <canvas id="walkChart"></canvas>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6 mb-4">
                        <div class="info-card">
                            <h3 class="info-card-title">
                                <i class="fas fa-chart-pie"></i>
                                행동 유형 분포
                            </h3>
                            <div style="height: 250px; display: flex; align-items: center; justify-content: center;">
                                <canvas id="behaviorChart"></canvas>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="info-card">
                    <h3 class="info-card-title">
                        <i class="fas fa-list"></i>
                        상세 활동 기록
                    </h3>
                    <div class="table-responsive">
                        <table class="table table-hover" id="activityTable">
                            <thead>
                                <tr>
                                    <th>날짜</th>
                                    <th>활동 유형</th>
                                    <th>상세 정보</th>
                                    <th>상태</th>
                                </tr>
                            </thead>
                            <tbody id="activityTableBody">
                                <tr>
                                    <td>2025-12-05</td>
                                    <td><span class="badge badge-info">산책</span></td>
                                    <td>공원 산책 2.3km / 45분</td>
                                    <td><span class="text-success"><i class="fas fa-check-circle"></i> 완료</span></td>
                                </tr>
                                <tr>
                                    <td>2025-12-04</td>
                                    <td><span class="badge badge-warning">건강</span></td>
                                    <td>AI 건강체크 - 지속 관찰 필요</td>
                                    <td><span class="text-info"><i class="fas fa-eye"></i> 관찰중</span></td>
                                </tr>
                                <tr>
                                    <td>2025-12-04</td>
                                    <td><span class="badge badge-success">행동</span></td>
                                    <td>홈캠 이벤트 4건 기록</td>
                                    <td><span class="text-success"><i class="fas fa-check-circle"></i> 정상</span></td>
                                </tr>
                                <tr>
                                    <td>2025-12-03</td>
                                    <td><span class="badge badge-info">산책</span></td>
                                    <td>비 오는 날 산책 1.1km / 20분</td>
                                    <td><span class="text-success"><i class="fas fa-check-circle"></i> 완료</span></td>
                                </tr>
                                <tr>
                                    <td>2025-12-02</td>
                                    <td><span class="badge badge-warning">건강</span></td>
                                    <td>AI 건강체크 - 주의 관찰</td>
                                    <td><span class="text-warning"><i class="fas fa-exclamation-circle"></i> 주의</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>2025-12-02</td>
                                    <td><span class="badge badge-success">행동</span></td>
                                    <td>홈캠 이벤트 4건 기록</td>
                                    <td><span class="text-success"><i class="fas fa-check-circle"></i> 정상</span></td>
                                </tr>
                                <tr>
                                    <td>2025-12-01</td>
                                    <td><span class="badge badge-info">산책</span></td>
                                    <td>공원 산책 2.5km / 50분</td>
                                    <td><span class="text-success"><i class="fas fa-check-circle"></i> 완료</span></td>
                                </tr>
                                <tr>
                                    <td>2025-12-01</td>
                                    <td><span class="badge badge-success">행동</span></td>
                                    <td>홈캠 이벤트 4건 기록</td>
                                    <td><span class="text-success"><i class="fas fa-check-circle"></i> 정상</span></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/chart.js@3.9.1/dist/chart.min.js"></script>

        <script>
            // ============ Mock Data (diary.jsp 데이터와 연동) ============
            const reportData = {
                weekly: {
                    period: '2025.12.05 - 2025.12.11 (7일간)',
                    walks: [
                        { date: '2025-12-05', distance: 2.3, duration: 45, route: '산책 통계 저장' },
                        { date: '2025-12-08', distance: 2.1, duration: 40, route: '산책 통계 저장' },
                        { date: '2025-12-10', distance: 0.4, duration: 15, route: '밤 산책' },
                        { date: '2025-12-11', distance: 3.2, duration: 41, route: '일일 합계' }
                    ],
                    healthChecks: [
                        { date: '2025-12-10', severity: '병원권장', findings: '농피증 의심 (신뢰도 98%)' }
                    ],
                    behaviors: [
                        { date: '2025-12-09', eventCount: 3, type: '분리불안 감지 (위험)' }
                    ]
                },
                daily: {
                    period: '2025-12-11 (오늘)',
                    walks: [
                        { date: '2025-12-11', distance: 3.2, duration: 41, route: '총 6회 산책' }
                    ],
                    healthChecks: [
                        { date: '2025-12-11', severity: '주의', findings: '호전 중 (신뢰도 85%)' }
                    ],
                    behaviors: []
                },
                monthly: {
                    period: '2025.12.01 - 2025.12.31 (31일간)',
                    walks: [
                        { date: '2025-12-01', distance: 2.5, duration: 50, route: '산책 통계 저장' },
                        { date: '2025-12-05', distance: 2.3, duration: 45, route: '산책 통계 저장' },
                        { date: '2025-12-10', distance: 0.4, duration: 15, route: '밤 산책' },
                        { date: '2025-12-11', distance: 3.2, duration: 41, route: '일일 합계' }
                    ],
                    healthChecks: [
                        { date: '2025-12-10', severity: '병원권장', findings: '농피증 의심 (신뢰도 98%)' }
                    ],
                    behaviors: [
                        { date: '2025-12-09', eventCount: 3, type: '분리불안 감지 (위험)' }
                    ]
                }
            };
            let currentPeriod = 'daily'; // 기본값을 Daily로 변경하여 바로 보이게 함

            let walkChart = null;
            let behaviorChart = null;

            function changeReportPeriod(period) {
                currentPeriod = period;
                document.querySelectorAll('.btn-group .btn').forEach(btn => btn.classList.remove('active'));
                document.getElementById(period + 'Btn').classList.add('active');
                updateStats(period);
                updateCharts(period);
            }

            function updateStats(period) {
                const data = reportData[period];
                document.getElementById('reportPeriodText').innerText = data.period;

                const walks = data.walks || [];
                let totalDist = 0;
                let totalTime = 0;
                walks.forEach(w => {
                    totalDist += w.distance;
                    totalTime += w.duration;
                });

                // 일간, 주간, 월간에 따라 평균 계산 방식 조정
                // 예: 일간은 합계(=평균), 주간/월간은 산책 횟수로 나눈 평균
                const count = walks.length;
                const avgDist = count ? (totalDist / count).toFixed(2) : 0;
                const avgTime = count ? Math.round(totalTime / count) : 0;

                document.getElementById('avgWalkDistance').innerText = avgDist + 'km';
                document.getElementById('avgWalkTime').innerText = avgTime + '분';

                const healthCount = data.healthChecks ? data.healthChecks.length : 0;
                document.getElementById('healthCheckCount').innerText = healthCount + '회';

                let behaviorCount = 0;
                if (data.behaviors) data.behaviors.forEach(b => behaviorCount += (b.eventCount || 1));
                document.getElementById('homecamEvents').innerText = behaviorCount + '건';
            }

            function updateCharts(period) {
                const data = reportData[period];
                const walks = data.walks || [];

                const ctx = document.getElementById('walkChart').getContext('2d');
                const labels = walks.map(w => w.date.substring(5)); // MM-DD format
                const distances = walks.map(w => w.distance);
                const durations = walks.map(w => w.duration);

                if (walkChart) walkChart.destroy();
                walkChart = new Chart(ctx, {
                    type: 'bar',
                    data: {
                        labels: labels,
                        datasets: [
                            {
                                label: '거리 (km)',
                                data: distances,
                                backgroundColor: '#4ECDC4',
                                borderRadius: 5,
                                yAxisID: 'y'
                            },
                            {
                                label: '시간 (분)',
                                data: durations,
                                backgroundColor: '#FF6B6B',
                                borderRadius: 5,
                                yAxisID: 'y1'
                            }
                        ]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        interaction: {
                            mode: 'index',
                            intersect: false,
                        },
                        plugins: {
                            legend: { position: 'bottom' }
                        },
                        scales: {
                            y: {
                                type: 'linear',
                                display: true,
                                position: 'left',
                                title: { display: true, text: '거리(km)' }
                            },
                            y1: {
                                type: 'linear',
                                display: true,
                                position: 'right',
                                grid: { drawOnChartArea: false },
                                title: { display: true, text: '시간(분)' }
                            },
                        }
                    }
                });

                const bCtx = document.getElementById('behaviorChart').getContext('2d');
                let bLabels = [];
                let bData = [];

                if (data.behaviors && data.behaviors.length > 0) {
                    bLabels = data.behaviors.map(b => b.type);
                    bData = data.behaviors.map(b => b.eventCount || 1);
                } else {
                    bLabels = ['특이사항 없음'];
                    bData = [1]; // dummy
                }

                if (behaviorChart) behaviorChart.destroy();
                behaviorChart = new Chart(bCtx, {
                    type: 'doughnut',
                    data: {
                        labels: bLabels,
                        datasets: [{
                            data: bData,
                            backgroundColor: data.behaviors && data.behaviors.length > 0
                                ? ['#FF6B6B', '#FFD93D', '#4ECDC4']
                                : ['#e9ecef']
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {
                            legend: { position: 'bottom' }
                        }
                    }
                });
            }


            // 페이지 로드 시 테이블 업데이트용 (하드코딩 수정)
            document.addEventListener('DOMContentLoaded', function () {
                // ... (Existing Table Code) ...
                const tableBody = document.getElementById('activityTableBody');
                tableBody.innerHTML = `
            <tr>
                <td>2025-12-11 18:10</td>
                <td><span class="badge badge-info">산책</span></td>
                <td>동네 마실 (0.8km / 10분)</td>
                <td><span class="text-success"><i class="fas fa-check-circle"></i> 완료</span></td>
            </tr>
            <tr>
                <td>2025-12-11 15:00</td>
                <td><span class="badge badge-primary">산책 알바</span></td>
                <td>새로운 산책 (1.2km / 15분)</td>
                <td><span class="text-success"><i class="fas fa-check-circle"></i> 완료</span></td>
            </tr>
            <tr>
                <td>2025-12-11 11:20</td>
                <td><span class="badge badge-info">산책</span></td>
                <td>하트 코스 (0.6km / 8분)</td>
                <td><span class="text-success"><i class="fas fa-check-circle"></i> 완료</span></td>
            </tr>
            <tr>
                <td>2025-12-11 10:00</td>
                <td><span class="badge badge-primary">산책 알바</span></td>
                <td>새로운 산책 (0.3km / 5분)</td>
                <td><span class="text-success"><i class="fas fa-check-circle"></i> 완료</span></td>
            </tr>
             <tr>
                <td>2025-12-11 09:10</td>
                <td><span class="badge badge-primary">산책 알바</span></td>
                <td>새로운 산책 (0.2km / 2분)</td>
                <td><span class="text-success"><i class="fas fa-check-circle"></i> 완료</span></td>
            </tr>
             <tr>
                <td>2025-12-11 00:31</td>
                <td><span class="badge badge-primary">산책 알바</span></td>
                <td>새로운 산책 (0.1km / 1분)</td>
                <td><span class="text-success"><i class="fas fa-check-circle"></i> 완료</span></td>
            </tr>
            <tr>
                <td>2025-12-10</td>
                <td><span class="badge badge-warning">건강</span></td>
                <td>AI 진단 - 농피증 의심 (98%)</td>
                <td><span class="text-danger"><i class="fas fa-hospital"></i> 병원권장</span></td>
            </tr>
            <tr>
                <td>2025-12-10</td>
                <td><span class="badge badge-info">산책</span></td>
                <td>밤 산책 (0.4km / 15분)</td>
                <td><span class="text-success"><i class="fas fa-check-circle"></i> 완료</span></td>
            </tr>
             <tr>
                <td>2025-12-09</td>
                <td><span class="badge badge-success">행동</span></td>
                <td>홈캠 분리불안 감지 (위험 이벤트)</td>
                <td><span class="text-success"><i class="fas fa-check-circle"></i> 기록됨</span></td>
            </tr>
        `; // 기존 하드코딩 테이블 덮어쓰기

                updateStats(currentPeriod);
                updateCharts(currentPeriod);
            });

            // AI 리포트 생성 시뮬레이션
            function simulateReportGeneration() {
                const controlDiv = document.getElementById('llmReportControl');
                const btn = controlDiv.querySelector('button');
                const loading = controlDiv.querySelector('.ai-loading');
                const reportDiv = document.getElementById('llmReport');

                btn.style.display = 'none';
                loading.style.display = 'block';

                setTimeout(() => {
                    controlDiv.style.display = 'none';
                    reportDiv.style.display = 'block';
                    // 간단한 페이드인 효과 (CSS transition을 활용하거나, jQuery 사용 시 fadeIn)
                    reportDiv.style.opacity = 0;
                    let op = 0.1;
                    const timer = setInterval(function () {
                        if (op >= 1) {
                            clearInterval(timer);
                        }
                        reportDiv.style.opacity = op;
                        reportDiv.style.filter = 'alpha(opacity=' + op * 100 + ")";
                        op += op * 0.1;
                    }, 10);
                }, 2000); // 2초 딜레이
            }
        </script>

        <style>
            /* 리포트 전용 스타일 */
            .report-stat-card {
                background: white;
                border-radius: 1rem;
                padding: 1.5rem;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
                transition: transform 0.3s ease, box-shadow 0.3s ease;
                display: flex;
                gap: 1rem;
                align-items: center;
            }

            .report-stat-card:hover {
                transform: translateY(-4px);
                box-shadow: 0 8px 20px rgba(0, 0, 0, 0.12);
            }

            .report-stat-icon {
                width: 60px;
                height: 60px;
                border-radius: 1rem;
                display: flex;
                align-items: center;
                justify-content: center;
                color: white;
                font-size: 1.5rem;
                flex-shrink: 0;
            }

            .report-stat-content {
                flex: 1;
            }

            .report-stat-content h5 {
                font-size: 0.875rem;
                color: #6c757d;
                margin-bottom: 0.5rem;
                font-weight: 600;
            }

            .report-stat-value {
                font-size: 1.75rem;
                font-weight: 700;
                color: #212529;
                margin: 0;
            }

            .report-stat-change {
                font-size: 0.75rem;
                font-weight: 600;
            }

            .report-stat-change.positive {
                color: #51CF66;
            }

            .report-stat-change.neutral {
                color: #868e96;
            }

            /* LLM 리포트 스타일 */
            .llm-report-content {
                padding: 1rem 0;
            }

            .llm-report-section {
                margin-bottom: 2rem;
                padding-bottom: 1.5rem;
                border-bottom: 1px solid #e9ecef;
            }

            .llm-report-section:last-child {
                border-bottom: none;
            }

            .llm-section-title {
                font-size: 1.1rem;
                font-weight: 700;
                color: #212529;
                margin-bottom: 1rem;
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            .llm-section-title i {
                color: #FF6B6B;
            }

            .llm-report-text {
                font-size: 1rem;
                line-height: 1.8;
                color: #495057;
                margin: 0;
            }

            .llm-recommendations {
                background: #f8f9fa;
                padding: 1.5rem;
                border-radius: 1rem;
            }

            .llm-recommendation-list {
                list-style: none;
                padding: 0;
                margin: 0;
            }

            .llm-recommendation-list li {
                padding: 0.75rem 0;
                border-bottom: 1px solid #dee2e6;
                display: flex;
                align-items: flex-start;
                gap: 0.75rem;
            }

            .llm-recommendation-list li:last-child {
                border-bottom: none;
            }

            .llm-recommendation-list li i {
                margin-top: 0.25rem;
                font-size: 1.1rem;
            }

            .llm-recommendation-list li strong {
                color: #212529;
            }
        </style>