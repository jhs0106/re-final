<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="<c:url value='/css/mypage.css'/>">

<!-- 다이어리 컨테이너 -->
<div class="mypage-container">
    <div class="mypage-wrapper">

        <h2 class="section-title">
            <i class="fas fa-book"></i>
            펫 다이어리
        </h2>

        <!-- 안내 메시지 -->
        <div class="alert alert-info mb-4">
            <i class="fas fa-info-circle mr-2"></i>
            <strong>자동 기록 시스템:</strong> 산책, 홈캠 이벤트, 건강 체크 등 모든 활동이 자동으로 다이어리에 저장됩니다.
        </div>

        <!-- 다이어리 요약 통계 -->
        <div class="diary-summary-section mb-4">
            <div class="row">
                <div class="col-md-3">
                    <div class="summary-stat-card">
                        <div class="stat-icon" style="background: linear-gradient(135deg, #9775FA, #7950F2);">
                            <i class="fas fa-book-open"></i>
                        </div>
                        <div class="stat-content">
                            <h4>총 기록</h4>
                            <p class="stat-number">156개</p>
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
                            <p class="stat-number">89회</p>
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
                            <p class="stat-number">43건</p>
                            <span class="stat-detail">자동 감지</span>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="summary-stat-card">
                        <div class="stat-icon" style="background: linear-gradient(135deg, #FFD43B, #FF922B);">
                            <i class="fas fa-camera"></i>
                        </div>
                        <div class="stat-content">
                            <h4>사진/영상</h4>
                            <p class="stat-number">342장</p>
                            <span class="stat-detail">수동 + 자동</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 필터 및 검색 -->
        <div class="diary-filters mb-4">
            <div class="d-flex justify-content-between align-items-center">
                <div class="filter-tags">
                    <button class="filter-tag active" data-tag="all">
                        <i class="fas fa-list"></i> 전체
                    </button>
                    <button class="filter-tag" data-tag="walk">
                        <i class="fas fa-walking"></i> 산책
                    </button>
                    <button class="filter-tag" data-tag="health">
                        <i class="fas fa-heartbeat"></i> 건강
                    </button>
                    <button class="filter-tag" data-tag="homecam">
                        <i class="fas fa-video"></i> 홈캠
                    </button>
                    <button class="filter-tag" data-tag="memo">
                        <i class="fas fa-pen"></i> 메모
                    </button>
                    <button class="filter-tag" data-tag="special">
                        <i class="fas fa-star"></i> 기념일
                    </button>
                </div>
                <button class="btn btn-pet-primary" onclick="openAddMemoModal()">
                    <i class="fas fa-plus-circle mr-2"></i>
                    메모 추가하기
                </button>
            </div>
        </div>

        <!-- 다이어리 캘린더 (FullCalendar) -->
        <div class="info-card mb-4">
            <h3 class="info-card-title">
                <i class="fas fa-calendar-alt"></i>
                통합 타임라인 캘린더
            </h3>
            <div id="diary-calendar-container" style="min-height: 600px;">
                <div class="text-center py-5">
                    <i class="fas fa-spinner fa-spin fa-3x text-primary mb-3"></i>
                    <p class="text-muted">캘린더를 불러오는 중...</p>
                </div>
            </div>
        </div>

        <!-- 최근 활동 타임라인 -->
        <div class="info-card">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h3 class="info-card-title mb-0">
                    <i class="fas fa-clock"></i>
                    최근 활동 내역
                </h3>
                <div class="view-options">
                    <button class="btn btn-sm btn-pet-outline" onclick="changeView('timeline')">
                        <i class="fas fa-stream"></i> 타임라인
                    </button>
                    <button class="btn btn-sm btn-pet-outline active" onclick="changeView('list')">
                        <i class="fas fa-list"></i> 리스트
                    </button>
                </div>
            </div>

            <div class="diary-timeline" id="diaryTimeline">
                <!-- 자동 기록: 산책 -->
                <div class="diary-item" data-type="walk">
                    <div class="diary-item-icon">
                        <i class="fas fa-walking"></i>
                    </div>
                    <div class="diary-item-content">
                        <div class="d-flex justify-content-between align-items-start">
                            <div>
                                <h5 class="diary-item-title">
                                    한강공원 산책
                                    <span class="badge badge-primary ml-2">자동</span>
                                </h5>
                                <p class="diary-item-date">
                                    <i class="fas fa-calendar"></i> 2024년 12월 2일 오후 3:20
                                </p>
                            </div>
                            <span class="badge badge-success">산책</span>
                        </div>
                        <p class="diary-item-preview">
                            오늘 산책을 완료했습니다. 날씨가 좋았어요! 🐕
                        </p>
                        <div class="diary-item-meta">
                            <span><i class="fas fa-route"></i> 2.3km</span>
                            <span><i class="fas fa-clock"></i> 45분</span>
                            <span><i class="fas fa-image"></i> 사진 5장</span>
                        </div>
                    </div>
                </div>

                <!-- 자동 기록: 홈캠 이벤트 -->
                <div class="diary-item" data-type="homecam">
                    <div class="diary-item-icon" style="background: linear-gradient(135deg, #FFD43B, #FF922B);">
                        <i class="fas fa-video"></i>
                    </div>
                    <div class="diary-item-content">
                        <div class="d-flex justify-content-between align-items-start">
                            <div>
                                <h5 class="diary-item-title">
                                    귀여운 행동 감지
                                    <span class="badge badge-primary ml-2">자동</span>
                                </h5>
                                <p class="diary-item-date">
                                    <i class="fas fa-calendar"></i> 2024년 12월 2일 오전 10:15
                                </p>
                            </div>
                            <span class="badge badge-warning">홈캠</span>
                        </div>
                        <p class="diary-item-preview">
                            AI가 감지한 특별한 순간: 뭉치가 장난감과 놀고 있어요 🎾
                        </p>
                        <div class="diary-item-meta">
                            <span><i class="fas fa-robot"></i> AI 감지</span>
                            <span><i class="fas fa-video"></i> 영상 1개</span>
                        </div>
                    </div>
                </div>

                <!-- 자동 기록: 건강 체크 -->
                <div class="diary-item" data-type="health">
                    <div class="diary-item-icon" style="background: linear-gradient(135deg, #4ECDC4, #38D9A9);">
                        <i class="fas fa-heartbeat"></i>
                    </div>
                    <div class="diary-item-content">
                        <div class="d-flex justify-content-between align-items-start">
                            <div>
                                <h5 class="diary-item-title">
                                    동물병원 방문
                                    <span class="badge badge-primary ml-2">자동</span>
                                </h5>
                                <p class="diary-item-date">
                                    <i class="fas fa-calendar"></i> 2024년 11월 30일 오후 2:00
                                </p>
                            </div>
                            <span class="badge badge-info">건강</span>
                        </div>
                        <p class="diary-item-preview">
                            정기 검진차 병원 다녀왔어요. 건강 상태 양호! 💪
                        </p>
                        <div class="diary-item-meta">
                            <span><i class="fas fa-user-md"></i> 김수의 수의사</span>
                            <span><i class="fas fa-won-sign"></i> 50,000원</span>
                            <span><i class="fas fa-check-circle"></i> 양호</span>
                        </div>
                    </div>
                </div>

                <!-- 수동 기록: 사용자 메모 -->
                <div class="diary-item" data-type="memo">
                    <div class="diary-item-icon" style="background: linear-gradient(135deg, #9775FA, #7950F2);">
                        <i class="fas fa-pen"></i>
                    </div>
                    <div class="diary-item-content">
                        <div class="d-flex justify-content-between align-items-start">
                            <div>
                                <h5 class="diary-item-title">
                                    새로운 간식 도전
                                    <span class="badge badge-secondary ml-2">수동</span>
                                </h5>
                                <p class="diary-item-date">
                                    <i class="fas fa-calendar"></i> 2024년 11월 28일 오후 5:30
                                </p>
                            </div>
                            <span class="badge badge-dark">메모</span>
                        </div>
                        <p class="diary-item-preview">
                            오늘 새로운 간식을 줘봤는데 정말 좋아하네요! 앞으로 자주 사줘야겠어요 😋
                        </p>
                        <div class="diary-item-meta">
                            <span><i class="fas fa-tag"></i> 음식</span>
                            <span><i class="fas fa-image"></i> 사진 3장</span>
                        </div>
                    </div>
                </div>

                <!-- 특별한 날: 기념일 -->
                <div class="diary-item" data-type="special">
                    <div class="diary-item-icon" style="background: linear-gradient(135deg, #FF6B6B, #FA5252);">
                        <i class="fas fa-birthday-cake"></i>
                    </div>
                    <div class="diary-item-content">
                        <div class="d-flex justify-content-between align-items-start">
                            <div>
                                <h5 class="diary-item-title">
                                    생일 축하해요!
                                    <span class="badge badge-secondary ml-2">수동</span>
                                </h5>
                                <p class="diary-item-date">
                                    <i class="fas fa-calendar"></i> 2024년 11월 25일
                                </p>
                            </div>
                            <span class="badge badge-danger">기념일</span>
                        </div>
                        <p class="diary-item-preview">
                            우리 뭉치 3살 생일 🎉 케이크 만들어줬어요!
                        </p>
                        <div class="diary-item-meta">
                            <span><i class="fas fa-star"></i> 특별한 날</span>
                            <span><i class="fas fa-image"></i> 사진 12장</span>
                            <span><i class="fas fa-video"></i> 영상 1개</span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 더보기 버튼 -->
            <div class="text-center mt-4">
                <button class="btn btn-pet-outline" onclick="loadMoreDiary()">
                    <i class="fas fa-chevron-down mr-2"></i>
                    더보기
                </button>
            </div>
        </div>
    </div>
</div>

<script src="<c:url value='/js/mypage.js'/>"></script>
