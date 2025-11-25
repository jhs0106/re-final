<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>PetCare AI - 스마트한 반려동물 케어</title>

    <!-- SEO Meta Tags -->
    <meta name="description" content="AI 기술로 더 안전하고 건강한 반려동물 케어 서비스">
    <meta name="keywords" content="반려동물, AI 산책, 펫케어, 홈캠, 건강진단, 산책알바, 펫다이어리">

    <!-- Favicon -->
    <link rel="icon" type="image/x-icon" href="<c:url value='/images/favicon.ico'/>">

    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&family=Quicksand:wght@400;600;700&display=swap" rel="stylesheet">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <!-- Bootstrap 4 CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

    <!-- Custom CSS -->
    <link rel="stylesheet" href="<c:url value='/css/variables.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/common.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/layout.css'/>">

    <!-- 페이지별 CSS -->
    <c:if test="${center == null || center == 'center'}">
        <link rel="stylesheet" href="<c:url value='/css/center.css'/>">
    </c:if>
    <c:if test="${center == 'login' || center == 'register'}">
        <link rel="stylesheet" href="<c:url value='/css/auth.css'/>">
    </c:if>
</head>
<body>

<!-- ✅ 이미지 시퀀스 백그라운드 (center 페이지에만) -->
<c:if test="${center == null || center == 'center'}">
    <div id="sequence-container"></div>
</c:if>

<!-- 헤더 -->
<header class="pet-header">
    <nav class="navbar navbar-expand-lg navbar-light">
        <div class="container">
            <!-- 로고 -->
            <a class="pet-logo" href="<c:url value='/'/>">
                <div class="pet-logo-icon">
                    <i class="fas fa-paw"></i>
                </div>
                <div class="pet-logo-text">
                    <span class="pet-logo-title">PetCare AI</span>
                    <span class="pet-logo-subtitle">스마트 반려 케어</span>
                </div>
            </a>

            <!-- 모바일 토글 -->
            <button class="navbar-toggler" type="button" data-toggle="collapse"
                    data-target="#petNavbar" aria-controls="petNavbar"
                    aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <!-- 네비게이션 메뉴 (요구사항 반영) -->
            <div class="collapse navbar-collapse pet-nav" id="petNavbar">
                <ul class="navbar-nav ml-auto">
                    <!-- 산책 드롭다운 -->
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="walkMenu" role="button"
                           data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <i class="fas fa-walking"></i> 산책
                        </a>
                        <div class="dropdown-menu" aria-labelledby="walkMenu">
                            <a class="dropdown-item" href="<c:url value='/map'/>">
                                <i class="fas fa-map-marked-alt"></i> 지도 기반 산책
                            </a>
                            <a class="dropdown-item" href="<c:url value='/ai-walk'/>">
                                <i class="fas fa-route"></i> AI 산책 추천
                            </a>
                            <a class="dropdown-item" href="<c:url value='/walk-helper'/>">
                                <i class="fas fa-people-carry"></i> 산책 알바
                            </a>
                            <a class="dropdown-item" href="<c:url value='/walk-together'/>">
                                <i class="fas fa-users"></i> 함께 산책
                            </a>
                        </div>
                    </li>

                    <!-- AI 서비스 드롭다운 -->
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="aiMenu" role="button"
                           data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <i class="fas fa-brain"></i> AI 서비스
                        </a>
                        <div class="dropdown-menu" aria-labelledby="aiMenu">
                            <a class="dropdown-item" href="<c:url value='/homecam'/>">
                                <i class="fas fa-video"></i> AI 홈캠 분석
                            </a>
                            <a class="dropdown-item" href="<c:url value='/health-check'/>">
                                <i class="fas fa-heartbeat"></i> AI 가상 진단
                            </a>
                            <a class="dropdown-item" href="<c:url value='/behavior-report'/>">
                                <i class="fas fa-chart-line"></i> 행동 리포트
                            </a>
                            <a class="dropdown-item" href="<c:url value='/clothes-recommend'/>">
                                <i class="fas fa-tshirt"></i> 옷 사이즈 추천
                            </a>
                        </div>
                    </li>

                    <!-- 다이어리 -->
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value='/diary'/>">
                            <i class="fas fa-book"></i> 펫 다이어리
                        </a>
                    </li>

                    <!-- 공지사항 -->
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value='/notice'/>">
                            <i class="fas fa-bell"></i> 공지사항
                        </a>
                    </li>
                </ul>

                <!-- 헤더 액션 버튼 (로그인 상태별) -->
                <div class="header-actions ml-3">
                    <c:choose>
                        <c:when test="${not empty sessionScope.user}">
                            <!-- 로그인 상태 -->
                            <button class="btn btn-pet-outline header-btn"
                                    onclick="location.href='<c:url value='/support'/>'">
                                <i class="fas fa-comments"></i> 고객센터
                            </button>
                            <button class="btn btn-pet-outline header-btn"
                                    onclick="location.href='<c:url value='/mypage'/>'">
                                <i class="fas fa-user-circle"></i> 마이페이지
                            </button>
                            <button class="btn btn-pet-primary header-btn"
                                    onclick="location.href='<c:url value='/logout'/>'">
                                로그아웃
                            </button>
                        </c:when>
                        <c:otherwise>
                            <!-- 비로그인 상태 -->
                            <button class="btn btn-pet-outline header-btn"
                                    onclick="location.href='<c:url value='/login'/>'">
                                로그인
                            </button>
                            <button class="btn btn-pet-primary header-btn"
                                    onclick="location.href='<c:url value='/register'/>'">
                                회원가입
                            </button>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </nav>
</header>

<!-- 메인 컨텐츠 -->
<main>
    <c:choose>
        <c:when test="${center == null}">
            <jsp:include page="center.jsp"/>
        </c:when>
        <c:otherwise>
            <jsp:include page="${center}.jsp"/>
        </c:otherwise>
    </c:choose>
</main>

<!-- 푸터 -->
<footer class="pet-footer">
    <div class="container">
        <div class="footer-content">
            <!-- 회사 정보 -->
            <div class="footer-section">
                <h4><i class="fas fa-paw"></i> PetCare AI</h4>
                <p>AI 기술로 더 안전하고 건강한<br>반려동물 케어 서비스를 제공합니다.</p>
                <div class="footer-social">
                    <a href="#" class="social-icon"><i class="fab fa-facebook-f"></i></a>
                    <a href="#" class="social-icon"><i class="fab fa-instagram"></i></a>
                    <a href="#" class="social-icon"><i class="fab fa-youtube"></i></a>
                    <a href="#" class="social-icon"><i class="fab fa-twitter"></i></a>
                </div>
            </div>

            <!-- 주요 서비스 -->
            <div class="footer-section">
                <h4>주요 서비스</h4>
                <ul class="footer-links">
                    <li><a href="<c:url value='/map'/>"><i class="fas fa-chevron-right"></i> 지도 기반 산책</a></li>
                    <li><a href="<c:url value='/ai-walk'/>"><i class="fas fa-chevron-right"></i> AI 산책 추천</a></li>
                    <li><a href="<c:url value='/walk-helper'/>"><i class="fas fa-chevron-right"></i> 산책 알바</a></li>
                    <li><a href="<c:url value='/homecam'/>"><i class="fas fa-chevron-right"></i> AI 홈캠</a></li>
                </ul>
            </div>

            <!-- 고객 지원 -->
            <div class="footer-section">
                <h4>고객 지원</h4>
                <ul class="footer-links">
                    <li><a href="<c:url value='/notice'/>"><i class="fas fa-bell"></i> 공지사항</a></li>
                    <li><a href="<c:url value='/support'/>"><i class="fas fa-headset"></i> 고객센터/챗봇</a></li>
                    <li><a href="#"><i class="fas fa-file-contract"></i> 이용약관</a></li>
                    <li><a href="#"><i class="fas fa-shield-alt"></i> 개인정보처리방침</a></li>
                </ul>
            </div>

            <!-- 연락처 -->
            <div class="footer-section">
                <h4>연락처</h4>
                <ul class="footer-links">
                    <li><i class="fas fa-phone"></i> 1577-0000 (24시간)</li>
                    <li><i class="fas fa-envelope"></i> support@petcare-ai.kr</li>
                    <li><i class="fas fa-map-marker-alt"></i> 서울시 강남구 테헤란로 123</li>
                    <li><i class="fas fa-clock"></i> 평일 09:00 - 18:00</li>
                </ul>
            </div>
        </div>

        <!-- 카피라이트 -->
        <div class="footer-bottom">
            <p>&copy; 2025 PetCare AI. All rights reserved. | 사업자등록번호: 123-45-67890</p>
        </div>
    </div>
</footer>

<!-- Scripts -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js"></script>

<!-- ✅ 이미지 시퀀스 스크립트 (center 페이지에만) -->
<c:if test="${center == null || center == 'center'}">
    <script src="<c:url value='/js/scroll-video.js'/>"></script>
</c:if>

<!-- 메인 스크립트 -->
<script src="<c:url value='/js/main.js'/>"></script>

</body>
</html>
