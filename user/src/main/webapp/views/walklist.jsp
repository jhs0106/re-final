<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="view" value="${walkListView}" />

<style>
  /* ===== 공통 팔레트 (owner.jsp / walkdetail.jsp 톤 맞추기) ===== */
  .walk-shell {
    padding: 40px 16px 80px;
    display: flex;
    justify-content: center;

    /* ✅ 바깥 배경: 좌 → 우 그라데이션 */
    background:
            linear-gradient(
                    90deg,
                    #fde2ea 0%,
                    #eef5ff 45%,
                    #e6f9f1 100%
            ),
            radial-gradient(
                    circle at right center,
                    rgba(139, 92, 246, 0.06),
                    transparent 60%
            );
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

    /* ✅ 안쪽 전체 영역도 좌 → 우 그라데이션 */
    background:
            linear-gradient(
                    90deg,
                    #fef5f8 0%,
                    #f3f7ff 45%,
                    #ecfff7 100%
            );

    box-shadow: var(--wj-shadow-soft);
    border: 1px solid var(--wj-border-soft);
    font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
  }

  /* 안쪽에 덮는 before 효과 제거 */
  .walk-page::before {
    display: none;
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
    content: "📋";
    font-size: 0.95rem;
  }

  .walk-sublabel {
    font-size: 0.8rem;
    color: var(--wj-muted);
    padding: 4px 10px;
    border-radius: 999px;
    background: rgba(255, 255, 255, 0.8);
    border: 1px dashed #d1d5db;
    display: inline-block;
    margin-top: 4px;
    backdrop-filter: blur(4px);
  }

  /* ===== 상단 요약 칩 ===== */
  .walk-summary-row {
    display: flex;
    flex-wrap: wrap;
    gap: 10px;
    margin-bottom: 16px;
  }

  .walk-summary-chip {
    background: #f9fafb;
    border-radius: 999px;
    padding: 8px 14px;
    border: 1px solid var(--wj-border-soft);
    font-size: 0.8rem;
    color: var(--wj-muted);
    box-shadow: 0 8px 18px rgba(15, 23, 42, 0.04);
  }

  .walk-summary-chip strong {
    color: var(--wj-title);
    margin-right: 4px;
  }

  /* ===== 필터 탭 ===== */
  .walk-filter-tabs {
    display: flex;
    flex-wrap: wrap;
    gap: 8px;
    margin: 4px 0 12px;
  }

  .walk-filter-btn {
    padding: 6px 12px;
    border-radius: 999px;
    border: 1px solid #e5e7eb;
    background: #ffffff;
    font-size: 0.78rem;
    color: var(--wj-muted);
    cursor: pointer;
  }

  .walk-filter-btn.active {
    background: var(--wj-primary-soft);
    color: #166534;
    border-color: #bbf7d0;
    font-weight: 600;
  }

  /* ===== 리스트 타이틀 ===== */
  .walk-list-title-row {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin: 8px 0 10px;
    font-size: 0.85rem;
    color: var(--wj-muted);
  }

  .walk-list-title-row span:first-child {
    font-weight: 600;
  }

  /* ===== 산책 카드 리스트 ===== */
  .walk-list {
    display: flex;
    flex-direction: column;
    gap: 12px;
  }

  .walk-card-link {
    text-decoration: none;
    color: inherit;
  }

  .walk-card {
    display: flex;
    gap: 16px;
    padding: 16px 18px;
    border-radius: 20px;
    background: #ffffff; /* 카드만 완전 흰색 */
    border: 1px solid #e5e7eb;
    box-shadow: 0 12px 30px rgba(15, 23, 42, 0.06);
    transition: transform 0.15s ease, box-shadow 0.15s ease, border-color 0.15s ease;
    cursor: pointer;
  }

  .walk-card:hover {
    transform: translateY(-2px);
    border-color: #bfdbfe;
    box-shadow: 0 16px 40px rgba(15, 23, 42, 0.11);
  }

  .walk-card-tag {
    min-width: 80px;
    align-self: center;
    text-align: center;
    padding: 6px 10px;
    border-radius: 999px;
    font-size: 0.7rem;
    font-weight: 600;
    background: var(--wj-primary-soft);
    color: #166534;
  }

  .walk-card-tag.normal {
    background: #e0f2fe;
    color: #1d4ed8;
  }

  .walk-card-tag.job {
    background: #fef9c3;
    color: #854d0e;
  }

  .walk-card-main {
    flex: 1;
  }

  .walk-card-main-top {
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 10px;
    margin-bottom: 6px;
  }

  .walk-card-title {
    font-size: 1rem;
    font-weight: 700;
    color: var(--wj-title);
  }

  .walk-card-date {
    font-size: 0.78rem;
    color: var(--wj-muted);
  }

  /* ===== 카드 내 메트릭 (실제 km / 시간 / 속도 강조) ===== */
  .walk-card-metrics {
    display: grid;
    grid-template-columns: repeat(3, minmax(0, 1fr));
    gap: 8px;
    margin-bottom: 6px;
  }

  .walk-metric-chip {
    padding: 8px 10px 6px;
    border-radius: 14px;
    background: #f9fafb;
    border: 1px solid #e5e7eb;
  }

  .walk-metric-label {
    font-size: 0.72rem;
    color: var(--wj-muted);
    margin-bottom: 2px;
  }

  .walk-metric-value {
    font-size: 0.92rem;
    font-weight: 700;
    color: var(--wj-title);
    white-space: nowrap;
  }

  .walk-metric-value.dist { color: var(--wj-primary); }
  .walk-metric-value.time { color: var(--wj-info); }
  .walk-metric-value.pace { color: #ec4899; }

  .walk-card-pet {
    font-size: 0.78rem;
    color: var(--wj-muted);
    margin-top: 4px;
  }

  .walk-card-pet strong {
    color: var(--wj-title);
  }

  .walk-card-right {
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    align-items: flex-end;
    gap: 6px;
    min-width: 90px;
  }

  .walk-card-status {
    font-size: 0.78rem;
    padding: 6px 12px;
    border-radius: 999px;
    background: #ecfeff;
    color: #0369a1;
    border: 1px solid #a5f3fc;
    font-weight: 600;
  }

  .walk-card-arrow {
    font-size: 0.7rem;
    color: var(--wj-muted);
  }

  @media (max-width: 768px) {
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
    }
    .walk-card {
      align-items: flex-start;
    }
    .walk-card-right {
      align-items: flex-start;
    }
    .walk-card-metrics {
      grid-template-columns: repeat(2, minmax(0, 1fr));
    }
    /* ===== 모바일 반응형 강화 (기능 영향 X) ===== */

    @media (max-width: 480px) {

      /* 모바일에서는 카드가 세로로 재배치되도록 */
      .walk-card {
        flex-direction: column;
        gap: 12px;
      }

      /* 모바일에서 태그가 좌측 고정되지 않도록 */
      .walk-card-tag {
        min-width: auto;
        align-self: flex-start;
      }

      /* 제목 + 날짜를 여러 줄 표현 가능하게 */
      .walk-card-main-top {
        flex-direction: column;
        align-items: flex-start;
        gap: 4px;
      }

      /* 카드 우측 영역 강제 폭 축소 */
      .walk-card-right {
        min-width: auto;
        width: 100%;
        align-items: flex-start;
      }

      /* 카드 메트릭 줄바꿈 개선 */
      .walk-card-metrics {
        grid-template-columns: 1fr;
      }

      /* 글자가 화면 밖으로 튀어나가지 않도록 */
      .walk-card-title,
      .walk-card-date,
      .walk-metric-value,
      .walk-metric-label,
      .walk-card-pet,
      .walk-card-status {
        white-space: normal;
        word-break: break-word;
      }

      /* 상단 요약 칩 줄바꿈 안정화 */
      .walk-summary-row {
        flex-direction: column;
        align-items: flex-start;
      }

      /* 필터 버튼 자동 줄바꿈 */
      .walk-filter-tabs {
        width: 100%;
      }
      .walk-filter-btn {
        flex: 1 1 calc(33% - 8px);
        text-align: center;
      }
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
            <div class="walk-badge">산책 기록</div>
            <h1>나의 산책 목록</h1>
            <p>
              그동안 진행한 산책 기록들을 한 눈에 확인하고,<br>
              상세 페이지에서 거리·시간·경로를 다시 살펴볼 수 있습니다.
            </p>
          </div>
          <div class="walk-header-right">
            <div class="walk-sublabel">
              산책 유형별(모양·일반·알바)로 필터링해서 확인할 수 있습니다.
            </div>
          </div>
        </header>

        <!-- 상단 요약 -->
        <section class="walk-summary-row">
          <div class="walk-summary-chip">
            <strong>총 ${view.totalCount}회</strong> 산책 완료
          </div>
          <div class="walk-summary-chip">
            <strong>누적 거리</strong>
            <fmt:formatNumber value="${view.totalDistanceKm}" type="number" maxFractionDigits="1"/> km
          </div>
          <div class="walk-summary-chip">
            <strong>누적 시간</strong> 약 ${view.totalMinutes}분
          </div>
        </section>

        <!-- 필터 탭 -->
        <section class="walk-filter-tabs">
          <c:set var="filter" value="${view.filterType}" />
          <button class="walk-filter-btn ${filter == 'all' ? 'active' : ''}" onclick="filterWalk('all')">전체</button>
          <button class="walk-filter-btn ${filter == 'heart' ? 'active' : ''}" onclick="filterWalk('heart')">하트</button>
          <button class="walk-filter-btn ${filter == 'circle' ? 'active' : ''}" onclick="filterWalk('circle')">원</button>
          <button class="walk-filter-btn ${filter == 'sqere' ? 'active' : ''}" onclick="filterWalk('sqere')">사각형</button>
          <button class="walk-filter-btn ${filter == 'triangle' ? 'active' : ''}" onclick="filterWalk('triangle')">삼각형</button>
          <button class="walk-filter-btn ${filter == 'normal' ? 'active' : ''}" onclick="filterWalk('normal')">일반</button>
          <button class="walk-filter-btn ${filter == 'job' ? 'active' : ''}" onclick="filterWalk('job')">산책 알바</button>
        </section>

        <div class="walk-list-title-row">
          <span>최근 산책 목록</span>
          <span>가장 최신 순 정렬</span>
        </div>

        <!-- 산책 카드 리스트 -->
        <section class="walk-list">
          <c:forEach var="item" items="${view.items}">
            <c:url var="detailUrl" value="/walkdetail/${item.id}"/>
            <a href="${detailUrl}" class="walk-card-link">
              <article class="walk-card">
                <c:set var="tagClass" value=""/>
                <c:if test="${item.typeKey == 'normal'}">
                  <c:set var="tagClass" value="normal"/>
                </c:if>
                <c:if test="${item.typeKey == 'job'}">
                  <c:set var="tagClass" value="job"/>
                </c:if>

                <div class="walk-card-tag ${tagClass}">
                    ${item.badgeLabel}
                </div>

                <div class="walk-card-main">
                  <div class="walk-card-main-top">
                    <div class="walk-card-title">${item.title}</div>
                    <div class="walk-card-date">${item.dateLabel}</div>
                  </div>

                  <!-- 강조 메트릭 -->
                  <div class="walk-card-metrics">
                    <div class="walk-metric-chip">
                      <div class="walk-metric-label">실제 거리</div>
                      <div class="walk-metric-value dist">${item.distanceLabel}</div>
                    </div>
                    <div class="walk-metric-chip">
                      <div class="walk-metric-label">산책 시간</div>
                      <div class="walk-metric-value time">${item.timeLabel}</div>
                    </div>
                    <div class="walk-metric-chip">
                      <div class="walk-metric-label">평균 속도</div>
                      <div class="walk-metric-value pace">${item.paceLabel}</div>
                    </div>
                  </div>

                  <div class="walk-card-pet">
                    반려동물 <strong>${item.petSummary}</strong>
                  </div>
                </div>

                <div class="walk-card-right">
                  <div class="walk-card-status">${item.statusLabel}</div>
                  <div class="walk-card-arrow">클릭하여 상세 페이지 이동</div>
                </div>
              </article>
            </a>
          </c:forEach>

          <c:if test="${empty view.items}">
            <p style="font-size:0.85rem; color:#9ca3af; margin-top:8px;">
              아직 해당 조건의 산책 기록이 없습니다. 오늘 한 번 산책을 시작해볼까요?
            </p>
          </c:if>
        </section>

      </div>
    </div>
  </div>
</div>

<script>
  function filterWalk(type) {
    const base = '<c:url value="/walklist"/>';
    window.location.href = base + '?type=' + type;
  }
</script>
