<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="detail" value="${walkDetail}"/>

<!-- Leaflet -->
<link rel="stylesheet"
      href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css"
      integrity="sha256-p4NxAoJBhIIN+hmNHrzRCf9tD/miZyoHS5obTRR9BMY="
      crossorigin=""/>


<style>
    /* ===== 공통 팔레트 (owner.jsp 톤 그대로) ===== */
    .walk-shell {
        padding: 40px 16px 80px;
        display: flex;
        justify-content: center;
        background:
                radial-gradient(circle at top left, #ffe4f3 0, transparent 55%),
                radial-gradient(circle at top right, #e0f2fe 0, transparent 55%),
                #f5f7fb;
    }

    .walk-inner {
        width: min(1100px, 100%);
    }

    .walk-page {
        --wj-bg: #f3f4f6;
        --wj-card: #ffffff;
        --wj-border-soft: #e5e7eb;
        --wj-shadow-soft: 0 22px 50px rgba(15, 23, 42, 0.08);

        --wj-primary: #10b981;
        --wj-primary-soft: #dcfce7;
        --wj-accent: #f97373;
        --wj-accent-soft: #fee2e2;
        --wj-info: #2563eb;
        --wj-muted: #6b7280;
        --wj-title: #111827;

        position: relative;
        width: 100%;
        max-width: 960px;
        margin: 0 auto;
        padding: 24px 26px 28px;
        border-radius: 28px;
        background: var(--wj-card);
        box-shadow: var(--wj-shadow-soft);
        border: 1px solid var(--wj-border-soft);
        font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
    }

    .walk-page::before {
        content: "";
        position: absolute;
        inset: 0;
        background:
                radial-gradient(circle at top right,
                rgba(219, 234, 254, 0.9) 0,
                transparent 60%);
        opacity: 0.9;
        pointer-events: none;
        border-radius: inherit;
    }

    .walk-page-inner {
        position: relative;
    }

    /* ===== 헤더 ===== */
    .walk-header {
        display: flex;
        justify-content: space-between;
        gap: 16px;
        align-items: center;
        margin-bottom: 18px;
    }

    .walk-header-left h1 {
        font-size: 1.8rem;
        font-weight: 800;
        color: var(--wj-title);
        margin: 4px 0 6px;
    }

    .walk-header-left p {
        margin: 0;
        font-size: 0.9rem;
        color: var(--wj-muted);
        line-height: 1.6;
    }

    .walk-header-right {
        text-align: right;
    }

    .walk-badge {
        display: inline-flex;
        align-items: center;
        gap: 6px;
        padding: 6px 12px;
        border-radius: 999px;
        font-size: 0.75rem;
        background: var(--wj-primary-soft);
        color: var(--wj-primary);
        font-weight: 600;
    }

    .walk-badge::before {
        content: "📍";
        font-size: 0.95rem;
    }

    .walk-sublabel {
        font-size: 0.8rem;
        color: var(--wj-muted);
        padding: 4px 10px;
        border-radius: 999px;
        background: #f9fafb;
        border: 1px dashed #d1d5db;
        display: inline-block;
        margin-top: 4px;
    }

    .walk-back-btn {
        padding: 8px 14px;
        border-radius: 999px;
        border: 1px solid var(--wj-border-soft);
        background: #ffffff;
        font-size: 0.8rem;
        color: var(--wj-muted);
        cursor: pointer;
        box-shadow: 0 8px 18px rgba(15, 23, 42, 0.05);
    }

    .walk-back-btn:hover {
        border-color: #bfdbfe;
        color: #2563eb;
    }

    /* ===== 레이아웃 ===== */
    .walk-detail-grid {
        display: grid;
        grid-template-columns: minmax(0, 2fr) minmax(0, 1.4fr);
        gap: 18px;
    }

    .walk-card {
        background: #ffffff;
        border-radius: 22px;
        padding: 16px 18px 14px;
        border: 1px solid #e5e7eb;
        box-shadow: 0 12px 30px rgba(15, 23, 42, 0.06);
    }

    .walk-card-title {
        font-size: 0.9rem;
        font-weight: 600;
        color: var(--wj-title);
        margin-bottom: 10px;
    }

    /* ===== 지도 ===== */
    #walkMap {
        width: 100%;
        height: 360px;
        border-radius: 18px;
        border: 1px solid #cbd5f5;
        overflow: hidden;
    }

    /* ===== 주요 수치 ===== */
    .walk-metrics {
        display: grid;
        grid-template-columns: repeat(4, minmax(0, 1fr));
        gap: 10px;
        margin-top: 12px;
    }

    .metric {
        padding: 10px 10px 8px;
        border-radius: 14px;
        background: #f9fafb;
        border: 1px solid #e5e7eb;
    }

    .metric-label {
        font-size: 0.75rem;
        color: var(--wj-muted);
        margin-bottom: 4px;
    }

    .metric-value {
        font-size: 1rem;
        font-weight: 700;
        color: var(--wj-title);
    }

    .metric-sub {
        font-size: 0.72rem;
        color: var(--wj-muted);
        margin-top: 2px;
    }

    .metric.dist .metric-value { color: var(--wj-primary); }
    .metric.time .metric-value { color: var(--wj-info); }
    .metric.kcal .metric-value { color: #f97316; }
    .metric.pace .metric-value { color: #ec4899; }

    /* ===== 상세 정보 ===== */
    .walk-info-grid {
        display: grid;
        grid-template-columns: 100px minmax(0, 1fr);
        row-gap: 6px;
        column-gap: 10px;
        font-size: 0.8rem;
    }

    .walk-info-label {
        color: var(--wj-muted);
    }

    .walk-info-value {
        color: var(--wj-title);
    }

    .walk-timeline {
        margin-top: 10px;
        font-size: 0.8rem;
        color: var(--wj-muted);
    }

    .walk-timeline ul {
        margin: 6px 0 0;
        padding-left: 18px;
    }

    .walk-timeline li {
        margin-bottom: 3px;
    }

    /* ===== 메모 카드 ===== */
    .walk-memo-text {
        font-size: 0.8rem;
        color: var(--wj-muted);
        line-height: 1.6;
    }

    @media (max-width: 900px) {
        .walk-page {
            padding: 18px 16px 22px;
            border-radius: 22px;
        }
        .walk-header {
            flex-direction: column;
            align-items: flex-start;
        }
        .walk-header-right {
            text-align: left;
            margin-top: 4px;
        }
        .walk-detail-grid {
            grid-template-columns: minmax(0, 1fr);
        }
    }
</style>

<div class="walk-shell">
    <div class="walk-inner">
        <div class="walk-page">
            <div class="walk-page-inner">

                <!-- 헤더 -->
                <header class="walk-header">
                    <div class="walk-header-left">
                        <div class="walk-badge">${detail.typeLabel}</div>
                        <h1>${detail.title}</h1>
                        <p>
                            ${detail.subtitle}<br>
                            ${detail.dateLabel} · ${detail.timeLabel}
                        </p>
                    </div>
                    <div class="walk-header-right">
                        <button class="walk-back-btn"
                                type="button"
                                onclick="location.href='<c:url value="/walklist"/>'">
                            ← 산책 목록으로 돌아가기
                        </button>
                        <div class="walk-sublabel">
                            지도는 OSM(Leaflet)으로 경로와 마지막 지점 사진을 표시합니다.
                        </div>
                    </div>
                </header>

                <!-- 본문 레이아웃 -->
                <section class="walk-detail-grid">

                    <!-- 왼쪽: 지도 + 주요 지표 -->
                    <article class="walk-card">
                        <div class="walk-card-title">산책 경로 (지도)</div>

                        <div id="walkMap"></div>

                        <!-- 주요 지표 -->
                        <div class="walk-metrics">
                            <div class="metric dist">
                                <div class="metric-label">실제 거리</div>
                                <div class="metric-value">
                                    <fmt:formatNumber value="${detail.distanceKm}" type="number" maxFractionDigits="2"/> km
                                </div>
                                <div class="metric-sub">shape/일반/알바 모두 공통 기준</div>
                            </div>
                            <div class="metric time">
                                <div class="metric-label">산책 시간</div>
                                <div class="metric-value">${detail.durationLabel}</div>
                                <div class="metric-sub">${detail.timeLabel}</div>
                            </div>
                            <div class="metric kcal">
                                <div class="metric-label">소모 칼로리 (추정)</div>
                                <div class="metric-value">
                                    <fmt:formatNumber value="${detail.kcal}" type="number" maxFractionDigits="0"/> kcal
                                </div>
                                <div class="metric-sub">반려동물 체중 기반 단순 추정</div>
                            </div>
                            <div class="metric pace">
                                <div class="metric-label">평균 속도</div>
                                <div class="metric-value">
                                    <c:choose>
                                        <c:when test="${detail.avgSpeedKmh > 0}">
                                            <fmt:formatNumber value="${detail.avgSpeedKmh}" type="number" maxFractionDigits="1"/> km/h
                                        </c:when>
                                        <c:otherwise>-</c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="metric-sub">실제 기록 기준</div>
                            </div>
                        </div>
                    </article>

                    <!-- 오른쪽: 상세 정보 -->
                    <article class="walk-card">
                        <div class="walk-card-title">산책 정보</div>

                        <div class="walk-info-grid">
                            <div class="walk-info-label">산책 제목</div>
                            <div class="walk-info-value">${detail.title}</div>

                            <div class="walk-info-label">산책 유형</div>
                            <div class="walk-info-value">${detail.typeLabel}</div>

                            <div class="walk-info-label">산책 상태</div>
                            <div class="walk-info-value">정상 종료 · 자동 저장</div>

                            <div class="walk-info-label">반려동물</div>
                            <div class="walk-info-value">${detail.petSummary}</div>

                            <div class="walk-info-label">날짜</div>
                            <div class="walk-info-value">${detail.dateLabel}</div>

                            <div class="walk-info-label">시간</div>
                            <div class="walk-info-value">${detail.timeLabel}</div>
                        </div>

                        <div class="walk-timeline">
                            <strong>산책 흐름</strong>
                            <ul>
                                <li>산책 시작 버튼 클릭 시 위치·거리·시간 자동 기록</li>
                                <li>산책 중 기록된 경로를 지도에 초록색 선으로 표시</li>
                                <li>산책 종료 시 마지막 위치에 사진 마커와 함께 저장</li>
                                <li>이 화면에서 거리, 시간, 경로 및 메모를 다시 확인 가능</li>
                            </ul>
                        </div>
                    </article>

                </section>

                <!-- 아래 메모 카드 -->
                <section style="margin-top:18px;">
                    <article class="walk-card">
                        <div class="walk-card-title">산책 메모</div>
                        <p class="walk-memo-text">
                            · 날씨, 반려동물 컨디션, 특별했던 순간 등을 자유롭게 기록해두면<br>
                            &nbsp;&nbsp;나중에 산책 데이터를 되돌아볼 때 도움이 됩니다.<br>
                            · 산책 알바의 경우, 어떤 코스를 걸었는지, 반려견 반응은 어땠는지 등도 기록할 수 있습니다.<br>
                            · 모양 산책(하트·원·네모·세모)은 코스의 특성을 메모로 남겨두면 다음에 선택하기 편합니다.
                        </p>
                    </article>
                </section>

            </div>
        </div>
    </div>
</div>

<c:url var="routeApiUrl" value="/api/walk/logs/${detail.id}"/>
<c:url var="photoUrl" value="/images/${detail.photoFile}"/>

<script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"
        integrity="sha256-20nQCchB9co0qIjJZRGuk2/Z9VM+kNiyxNV1lvTlZBo="
        crossorigin=""></script>

<script>
    (function () {
        const map = L.map('walkMap');
        const tile = L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            maxZoom: 19
        });
        tile.addTo(map);

        fetch('${routeApiUrl}')
            .then(res => res.json())
            .then(data => {
                if (!data.points || data.points.length === 0) {
                    map.setView([37.5665, 126.9780], 13); // fallback: 서울
                    return;
                }

                // ★ lng / lon 둘 다 지원하도록 처리
                const latlngs = data.points
                    .map(p => {
                        const lat = p.lat;
                        const lng = (p.lng !== undefined && p.lng !== null)
                            ? p.lng           // 새 형식: lat / lng
                            : p.lon;          // 옛 형식: lat / lon

                        if (typeof lat !== 'number' || typeof lng !== 'number' || isNaN(lat) || isNaN(lng)) {
                            return null;
                        }
                        return [lat, lng];
                    })
                    .filter(p => p !== null);

                if (latlngs.length === 0) {
                    map.setView([37.5665, 126.9780], 13);
                    return;
                }

                const poly = L.polyline(latlngs, {color: 'green', weight: 5});
                poly.addTo(map);
                map.fitBounds(poly.getBounds(), {padding: [20, 20]});

                const last = latlngs[latlngs.length - 1];

                const popupHtml =
                    '<div style="text-align:center;">' +
                    '<div style="margin-bottom:4px; font-size:0.8rem;">산책중에 직접 촬영한 사진입니다.</div>' +
                    '<img src="${photoUrl}" alt="walk-photo" style="max-width:160px; border-radius:12px; box-shadow:0 8px 20px rgba(0,0,0,0.15);" />' +
                    '</div>';

                L.marker(last).addTo(map).bindPopup(popupHtml).openPopup();
            })
            .catch(err => {
                console.error('경로 로드 실패', err);
                map.setView([37.5665, 126.9780], 13);
            });
    })();
</script>
