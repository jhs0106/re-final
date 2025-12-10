<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="main-container">
  <div class="xs-pd-20-10 pd-ltr-20">
    <!-- 제목 -->
    <div class="title pb-20">
      <h2 class="h3 mb-0">관리자 대시보드</h2>
      <p class="mb-0 text-muted">서비스 전체 현황을 한 눈에 확인하세요.</p>
    </div>

    <!-- 1. 상단 요약 카드 4개 -->
    <div class="row pb-10">
      <!-- 전체 회원 수 -->
      <div class="col-md-3 mb-20">
        <div class="card-box min-height-100px pd-20">
          <div class="d-flex justify-content-between align-items-center">
            <div>
              <div class="font-14 text-muted">전체 회원 수</div>
              <div class="h3 mb-0 weight-600">
                <c:out value="${userSummary.totalUsers != null ? userSummary.totalUsers : 12}"/>
              </div>
            </div>
            <div class="icon h1 text-blue">
              <i class="bi bi-people"></i>
            </div>
          </div>
          <div class="font-12 mt-5 text-muted">
            오늘 신규 가입
            <span class="text-green weight-600">
              +<c:out value="${userSummary.newUsersToday != null ? userSummary.newUsersToday : 5}"/>
            </span>
          </div>
        </div>
      </div>

      <!-- 활성 회원 수 -->
      <div class="col-md-3 mb-20">
        <div class="card-box min-height-100px pd-20">
          <div class="d-flex justify-content-between align-items-center">
            <div>
              <div class="font-14 text-muted">활성 회원 수 (ACTIVE)</div>
              <div class="h3 mb-0 weight-600">
                <c:out value="${userSummary.activeUsers != null ? userSummary.activeUsers : 5}"/>
              </div>
            </div>
            <div class="icon h1 text-green">
              <i class="bi bi-person-check"></i>
            </div>
          </div>
          <div class="font-12 mt-5 text-muted">
            지난 7일 접속
            <span class="text-green weight-600">
              <c:out value="${userSummary.activeLastWeek != null ? userSummary.activeLastWeek : 31}"/> 명
            </span>
          </div>
        </div>
      </div>

      <!-- 전체 반려동물 수 -->
      <div class="col-md-3 mb-20">
        <div class="card-box min-height-100px pd-20">
          <div class="d-flex justify-content-between align-items-center">
            <div>
              <div class="font-14 text-muted">등록된 반려동물</div>
              <div class="h3 mb-0 weight-600">
                <c:out value="${petSummary.totalPets != null ? petSummary.totalPets : 5}"/>
              </div>
            </div>
            <div class="icon h1 text-orange">
              <i class="bi bi-heart-fill"></i>
            </div>
          </div>
          <div class="font-12 mt-5 text-muted">
            1인당 평균
            <span class="text-blue weight-600">
              <c:out value="${petSummary.avgPetsPerOwner != null ? petSummary.avgPetsPerOwner : '0.8'}"/> 마리
            </span>
          </div>
        </div>
      </div>

      <!-- 전체 채팅방 수 -->
      <div class="col-md-3 mb-20">
        <div class="card-box min-height-100px pd-20">
          <div class="d-flex justify-content-between align-items-center">
            <div>
              <div class="font-14 text-muted">전체 채팅방 수</div>
              <div class="h3 mb-0 weight-600">
                <c:out value="${serviceSummary.totalChatRooms != null ? serviceSummary.totalChatRooms : 10}"/>
              </div>
            </div>
            <div class="icon h1 text-purple">
              <i class="bi bi-chat-dots"></i>
            </div>
          </div>
          <div class="font-12 mt-5 text-muted">
            오늘 생성 채팅방
            <span class="text-green weight-600">
              +<c:out value="${serviceSummary.chatRoomsToday != null ? serviceSummary.chatRoomsToday : 4}"/>
            </span>
          </div>
        </div>
      </div>
    </div>

    <!-- 2. 중앙 차트 + 우측 요약 차트들 -->
    <div class="row pb-10">
      <!-- 일별 방문자 / 채팅방 생성 수 -->
      <div class="col-md-8 mb-20">
        <div class="card-box height-100-p pd-20">
          <div class="d-flex flex-wrap justify-content-between align-items-center pb-0 pb-md-3">

            <div class="h5 mb-md-0">일별 방문 & 채팅 생성 추이</div>
            <div class="form-group mb-md-0">
              <select class="form-control form-control-sm selectpicker">
                <option value="">최근 7일</option>
                <option value="">최근 30일 (샘플)</option>
              </select>
            </div>
          </div>
          <br>
          <br>
          <br>
          <div id="admin-traffic-chart" style="height: 300px;"></div>
        </div>
      </div>

      <!-- 역할 비율 / 펫 타입 분포 -->
      <div class="col-md-4 mb-20">
        <!-- 역할 비율 -->
        <div class="card-box min-height-200px pd-20 mb-20" data-bgcolor="#ffffff">
          <div class="d-flex justify-content-between pb-10 text-white">
            <div class="h5 mb-0">회원 역할 비율</div>
          </div>
          <div id="role-pie-chart" style="height: 180px;"></div>
        </div>

        <!-- 펫 타입 분포 -->
        <div class="card-box min-height-200px pd-20" data-bgcolor="#ffffff">
          <div class="d-flex justify-content-between pb-10 text-white">
            <div class="h5 mb-0">반려동물 타입 분포</div>
          </div>
          <div id="pet-type-chart" style="height: 180px;"></div>
        </div>
      </div>
    </div>


    <!-- 3. 최근 가입 회원 / 최근 등록 펫 -->
    <div class="row">
      <!-- 최근 가입 회원 -->
      <div class="col-lg-6 col-md-12 mb-20">
        <div class="card-box height-100-p pd-20 min-height-200px">
          <div class="d-flex justify-content-between pb-10">
            <div class="h5 mb-0">최근 가입 회원</div>
            <a href="<c:url value='/admin/users'/>" class="font-12 text-primary">자세히 보기</a>
          </div>
          <div class="user-list">
            <ul>
              <c:choose>
                <c:when test="${not empty recentUsers}">
                  <c:forEach var="u" items="${recentUsers}">
                    <li class="d-flex align-items-center justify-content-between">
                      <div class="name-avatar d-flex align-items-center pr-2">
                        <div class="avatar mr-2 flex-shrink-0">
                          <!-- 프로필 이미지가 있다면 -->
                          <c:if test="${not empty u.profileImage}">
                            <img src="<c:url value='${u.profileImage}'/>" alt="" style="width:40px;height:40px;border-radius:50%;object-fit:cover;">
                          </c:if>
                          <c:if test="${empty u.profileImage}">
                            <div style="width:40px;height:40px;border-radius:50%;background:#e5e7eb;display:flex;align-items:center;justify-content:center;font-size:20px;">
                              <i class="bi bi-person"></i>
                            </div>
                          </c:if>
                        </div>
                        <div class="txt">
                          <div class="font-14 weight-600">
                            <c:out value="${u.username}"/>
                          </div>
                          <div class="font-12 weight-500" data-color="#b2b1b6">
                            <c:out value="${u.role}"/> · 가입일
                            <c:out value="${u.joinDate}"/>
                          </div>
                        </div>
                      </div>
                      <div class="cta flex-shrink-0 text-right">
                        <div class="font-14 weight-600">
                          반려동물:
                          <c:out value="${u.petCount}"/>마리
                        </div>
                        <div class="font-12 weight-500" data-color="#b2b1b6">
                          마지막 로그인:
                          <c:out value="${u.lastLogin}"/>
                        </div>
                      </div>
                    </li>
                    <hr/>
                  </c:forEach>
                </c:when>
                <c:otherwise>
                  <!-- 샘플 데이터 (recentUsers 없을 때) -->
                  <li class="d-flex align-items-center justify-content-between">
                    <div class="name-avatar d-flex align-items-center pr-2">
                      <div class="avatar mr-2 flex-shrink-0">
                        <div style="width:40px;height:40px;border-radius:50%;background:#e5e7eb;display:flex;align-items:center;justify-content:center;font-size:20px;">
                          <i class="bi bi-person"></i>
                        </div>
                      </div>
                      <div class="txt">
                        <div class="font-14 weight-600">id01</div>
                        <div class="font-12 weight-500" data-color="#b2b1b6">
                          반려인 · 가입일 2025-12-01
                        </div>
                      </div>
                    </div>
                    <div class="cta flex-shrink-0 text-right">
                      <div class="font-14 weight-600">반려동물: 1마리</div>
                      <div class="font-12 weight-500" data-color="#b2b1b6">강아지(말티즈)</div>
                    </div>
                  </li>
                  <hr/>
                  <li class="d-flex align-items-center justify-content-between">
                    <div class="name-avatar d-flex align-items-center pr-2">
                      <div class="avatar mr-2 flex-shrink-0">
                        <div style="width:40px;height:40px;border-radius:50%;background:#e5e7eb;display:flex;align-items:center;justify-content:center;font-size:20px;">
                          <i class="bi bi-person"></i>
                        </div>
                      </div>
                      <div class="txt">
                        <div class="font-14 weight-600">shlee</div>
                        <div class="font-12 weight-500" data-color="#b2b1b6">
                          반려인 · 가입일 2025-12-02
                        </div>
                      </div>
                    </div>
                    <div class="cta flex-shrink-0 text-right">
                      <div class="font-14 weight-600">반려동물: 1마리</div>
                      <div class="font-12 weight-500" data-color="#b2b1b6">춘복이</div>
                    </div>
                  </li>
                  <hr/>
                  <li class="d-flex align-items-center justify-content-between">
                    <div class="name-avatar d-flex align-items-center pr-2">
                      <div class="avatar mr-2 flex-shrink-0">
                        <div style="width:40px;height:40px;border-radius:50%;background:#e5e7eb;display:flex;align-items:center;justify-content:center;font-size:20px;">
                          <i class="bi bi-person"></i>
                        </div>
                      </div>
                      <div class="txt">
                        <div class="font-14 weight-600">guest1234</div>
                        <div class="font-12 weight-500" data-color="#b2b1b6">
                          일반 사용자 · 가입일 2025-12-03
                        </div>
                      </div>
                    </div>
                    <div class="cta flex-shrink-0 text-right">
                      <div class="font-14 weight-600">반려동물: 0마리</div>
                      <div class="font-12 weight-500" data-color="#b2b1b6">-</div>
                    </div>
                  </li>
                </c:otherwise>
              </c:choose>
            </ul>
          </div>
        </div>
      </div>

      <!-- 최근 등록 반려동물 -->
      <div class="col-lg-6 col-md-12 mb-20">
        <div class="card-box height-100-p pd-20 min-height-200px">
          <div class="d-flex justify-content-between pb-10">
            <div class="h5 mb-0">최근 등록 반려동물</div>
            <a href="<c:url value='/admin/pets'/>" class="font-12 text-primary">자세히 보기</a>
          </div>
          <div class="user-list">
            <ul>
              <c:choose>
                <c:when test="${not empty recentPets}">
                  <c:forEach var="p" items="${recentPets}">
                    <li class="d-flex align-items-center justify-content-between">
                      <div class="name-avatar d-flex align-items-center pr-2">
                        <div class="avatar mr-2 flex-shrink-0">
                          <c:if test="${not empty p.photo}">
                            <img src="<c:url value='${p.photo}'/>" alt="" style="width:40px;height:40px;border-radius:50%;object-fit:cover;">
                          </c:if>
                          <c:if test="${empty p.photo}">
                            <div style="width:40px;height:40px;border-radius:50%;background:#fee2e2;display:flex;align-items:center;justify-content:center;font-size:20px;">
                              <i class="bi bi-heart"></i>
                            </div>
                          </c:if>
                        </div>
                        <div class="txt">
                          <div class="font-14 weight-600">
                            <c:out value="${p.name}"/>
                          </div>
                          <div class="font-12 weight-500" data-color="#b2b1b6">
                            <c:out value="${p.type}"/>
                            (<c:out value="${p.breed}"/>) ·
                            <c:out value="${p.gender}"/> /
                            <c:out value="${p.age}"/>살
                          </div>
                        </div>
                      </div>
                      <div class="cta flex-shrink-0 text-right">
                        <div class="font-14 weight-600">
                          보호자:
                          <c:out value="${p.ownerName}"/>
                        </div>
                        <div class="font-12 weight-500" data-color="#b2b1b6">
                          등록일:
                          <c:out value="${p.createdAt}"/>
                        </div>
                      </div>
                    </li>
                    <hr/>
                  </c:forEach>
                </c:when>
                <c:otherwise>
                  <!-- 샘플 데이터 (recentPets 없을 때) -->
                  <li class="d-flex align-items-center justify-content-between">
                    <div class="name-avatar d-flex align-items-center pr-2">
                      <div class="avatar mr-2 flex-shrink-0">
                        <div style="width:40px;height:40px;border-radius:50%;background:#fee2e2;display:flex;align-items:center;justify-content:center;font-size:20px;">
                          <i class="bi bi-heart"></i>
                        </div>
                      </div>
                      <div class="txt">
                        <div class="font-14 weight-600">춘복이</div>
                        <div class="font-12 weight-500" data-color="#b2b1b6">
                          개(시츄) · 수컷 / 3살
                        </div>
                      </div>
                    </div>
                    <div class="cta flex-shrink-0 text-right">
                      <div class="font-14 weight-600">보호자: shlee</div>
                      <div class="font-12 weight-500" data-color="#b2b1b6">등록일: 2025-12-02</div>
                    </div>
                  </li>
                  <hr/>
                  <li class="d-flex align-items-center justify-content-between">
                    <div class="name-avatar d-flex align-items-center pr-2">
                      <div class="avatar mr-2 flex-shrink-0">
                        <div style="width:40px;height:40px;border-radius:50%;background:#fee2e2;display:flex;align-items:center;justify-content:center;font-size:20px;">
                          <i class="bi bi-heart"></i>
                        </div>
                      </div>
                      <div class="txt">
                        <div class="font-14 weight-600">옹심이</div>
                        <div class="font-12 weight-500" data-color="#b2b1b6">
                          고양이(코숏) · 암컷 / 2살
                        </div>
                      </div>
                    </div>
                    <div class="cta flex-shrink-0 text-right">
                      <div class="font-14 weight-600">보호자: qwer</div>
                      <div class="font-12 weight-500" data-color="#b2b1b6">등록일: 2025-12-01</div>
                    </div>
                  </li>
                </c:otherwise>
              </c:choose>
            </ul>
          </div>
        </div>
      </div>
    </div>

    <!-- 4. 바로가기 카드 -->
    <div class="title pb-20 pt-20">
      <h2 class="h3 mb-0">지금 바로 관리 시작하기</h2>
    </div>

    <div class="row">
      <div class="col-md-4 mb-20">
        <a href="<c:url value='/pet'/>" class="card-box d-block mx-auto pd-20 text-secondary">
          <div class="img pb-30">
            <img src="/vendors/images/pet.png" alt="" />
          </div>
          <div class="content">
            <h3 class="h4">반려동물 관리</h3>
            <p class="max-width-200">
              반려동물 정보를 관리하세요.
            </p>
          </div>
        </a>
      </div>
      <div class="col-md-4 mb-20">
        <a href="<c:url value='/cust'/>" class="card-box d-block mx-auto pd-20 text-secondary">
          <div class="img pb-30">
            <img src="/vendors/images/customer1.png" alt="" />
          </div>
          <div class="content">
            <h3 class="h4">고객 관리</h3>
            <p class="max-width-200">
              회원 정보를 관리하세요.
            </p>
          </div>
        </a>
      </div>
      <div class="col-md-4 mb-20">
        <a href="<c:url value='/admin/customer'/>" class="card-box d-block mx-auto pd-20 text-secondary">
          <div class="img pb-30">
            <img src="/vendors/images/cust.jpg" alt="" />
          </div>
          <div class="content">
            <h3 class="h4">고객센터 관리</h3>
            <p class="max-width-200">
              고객과 상담하고 관리하세요.
            </p>
          </div>
        </a>
      </div>
    </div>

    <!-- ffffff푸터 eae7e7-->
    <div class="footer-wrap pd-20 mb-20 card-box" style="background-color: #eae7e7">
      © 2025 Pat n Pet Admin. All rights reserved.
    </div>
  </div>
</div>

<!-- Highcharts 스크립트 & 차트 초기화 -->
<script src="https://code.highcharts.com/highcharts.js"></script>
<script>
  document.addEventListener("DOMContentLoaded", function () {

    /* =========================
     * 1. 일별 방문 & 채팅 생성 추이
     * ========================= */
    var trafficEl = document.querySelector("#admin-traffic-chart");
    if (trafficEl) {
      var trafficOptions = {
        series: [
          { name: "일일 방문자 수", type: "column", data: [1, 1, 2, 8, 6, 1, 8] },
          { name: "채팅방 생성 수", type: "line",   data: [1,   1,   1,   3,   2,  1,  3] }
        ],
        chart: {
          height: 300,
          type: "line",
          background: "#ffffff",         // ▶ 흰 배경
          toolbar: { show: false }
        },
        stroke: {
          width: [0, 3],
          curve: "smooth"
        },
        colors: ["#60a5fa", "#fb7185"],  // 블루 + 핑크
        dataLabels: {
          enabled: true,
          enabledOnSeries: [1],
          style: { fontSize: "11px", colors: ["#374151"] }
        },
        grid: {
          borderColor: "rgba(148,163,184,0.3)",
          strokeDashArray: 4
        },
        labels: ["월", "화", "수", "목", "금", "토", "일"],
        xaxis: {
          type: "category",
          labels: {
            style: { colors: "#6b7280", fontSize: "11px" }
          },
          axisBorder: { show: false },
          axisTicks: { show: false }
        },
        yaxis: [
          {
            title: { text: "방문자 수", style: { color: "#4b5563", fontSize: "11px" } },
            labels: { style: { colors: "#6b7280", fontSize: "11px" } }
          },
          {
            opposite: true,
            title: { text: "채팅방 생성 수", style: { color: "#4b5563", fontSize: "11px" } },
            labels: { style: { colors: "#6b7280", fontSize: "11px" } }
          }
        ],
        legend: {
          position: "top",
          horizontalAlign: "right",
          fontSize: "11px",
          labels: { colors: "#4b5563" }
        },
        tooltip: {
          theme: "light",
          y: {
            formatter: function (val, opts) {
              return (opts.seriesIndex === 0 ? val + " 명" : val + " 개");
            }
          }
        }
      };
      new ApexCharts(trafficEl, trafficOptions).render();
    }


    /* =========================
     * 2. 회원 역할 비율 (도넛)
     *    흰 카드 + 파스텔 핑크/민트/라일락
     * ========================= */
    var roleEl = document.querySelector("#role-pie-chart");
    if (roleEl) {
      var total = 5 + 4;   // 샘플: 일반/반려인/알바/관리자

      var roleOptions = {
        series: [5, 4, ],
        chart: {
          height: 230,
          type: "donut",
          background: "#ffffff"
        },
        labels: ["일반 사용자", "반려인"],
        colors: ["#f9a8d4", "#6ee7b7"], // 핑크 + 민트 + 라일락
        dataLabels: {
          enabled: true,
          style: {
            fontSize: "11px",
            colors: ["#111827"]
          },
          dropShadow: { enabled: false }
        },
        stroke: {
          width: 3,
          colors: ["#ffffff"]
        },
        legend: {
          show: true,
          position: "bottom",
          fontSize: "11px",
          labels: { colors: "#374151" },
          markers: {
            width: 10,
            height: 10,
            radius: 12
          }
        },
        plotOptions: {
          pie: {
            donut: {
              size: "70%",
              labels: {
                show: true,
                name: {
                  show: true,
                  offsetY: 12,
                  color: "#6b7280",
                  fontSize: "11px"
                },
                value: {
                  show: true,
                  offsetY: -6,
                  fontSize: "20px",
                  fontWeight: 700,
                  color: "#111827",
                  formatter: function (val) {
                    return val + "명";
                  }
                },
                total: {
                  show: true,
                  label: "총 회원",
                  color: "#9ca3af",
                  fontSize: "11px",
                  formatter: function () {
                    return total + "명";
                  }
                }
              }
            }
          }
        },
        tooltip: {
          theme: "light",
          y: {
            formatter: function (val) { return val + "명"; }
          }
        }
      };

      new ApexCharts(roleEl, roleOptions).render();
    }


    /* =========================
     * 3. 반려동물 타입 분포 (막대)
     *    흰 배경 + 핑크 그라데이션 느낌
     * ========================= */
    var petTypeEl = document.querySelector("#pet-type-chart");
    if (petTypeEl) {
      var petTypeOptions = {
        series: [{
          name: "등록 수",
          data: [3, 2, 0]   // 개, 고양이, 기타 (샘플)
        }],
        chart: {
          height: 220,
          type: "bar",
          background: "#ffffff",
          toolbar: { show: false }
        },
        colors: ["#fca5a5", "#f9a8d4", "#bfdbfe"],
        plotOptions: {
          bar: {
            horizontal: false,
            columnWidth: "40%",
            borderRadius: 10,
            distributed: true
          }
        },
        dataLabels: {
          enabled: true,
          style: {
            colors: ["#111827"],
            fontSize: "11px",
            fontWeight: 600
          },
          formatter: function (val) { return val + " 마리"; }
        },
        grid: {
          borderColor: "rgba(148,163,184,0.3)",
          strokeDashArray: 4
        },
        xaxis: {
          categories: ["개", "고양이", "기타"],
          type: "category",
          axisBorder: { show: false },
          axisTicks: { show: false },
          labels: {
            style: { colors: "#4b5563", fontSize: "11px" }
          }
        },
        yaxis: {
          title: {
            text: "마리 수",
            style: { color: "#4b5563", fontSize: "11px" }
          },
          labels: {
            style: { colors: "#6b7280", fontSize: "11px" }
          },
          min: 0,
          tickAmount: 3
        },
        tooltip: {
          theme: "light",
          y: {
            formatter: function (val) { return val + " 마리"; }
          }
        }
      };

      new ApexCharts(petTypeEl, petTypeOptions).render();
    }


    /* =========================
     * 4. 시스템 상태 Mixed Chart (chart5 – 예제 그대로 약간만 다듬음)
     * ========================= */
    var sysEl = document.querySelector("#chart5");
    if (sysEl) {
      var sysOptions = {
        series: [
          { name: "매출",   type: "column", data: [10, 41, 35, 51, 49, 62, 69] },
          { name: "방문자", type: "line",   data: [23, 42, 35, 27, 43, 22, 17] }
        ],
        chart: {
          height: 260,
          type: "line",
          background: "#ffffff"
        },
        colors: ["#a5b4fc", "#fb7185"],
        stroke: { width: [0, 3], curve: "smooth" },
        dataLabels: {
          enabled: true,
          enabledOnSeries: [1],
          style: { colors: ["#111827"], fontSize: "11px" }
        },
        labels: ["월", "화", "수", "목", "금", "토", "일"],
        xaxis: {
          type: "category",
          labels: { style: { colors: "#6b7280", fontSize: "11px" } },
          axisBorder: { show: false },
          axisTicks: { show: false }
        },
        yaxis: [
          {
            title: { text: "매출", style: { color: "#4b5563", fontSize: "11px" } },
            labels: { style: { colors: "#6b7280", fontSize: "11px" } }
          },
          {
            opposite: true,
            title: { text: "방문자", style: { color: "#4b5563", fontSize: "11px" } },
            labels: { style: { colors: "#6b7280", fontSize: "11px" } }
          }
        ],
        grid: {
          borderColor: "rgba(148,163,184,0.3)",
          strokeDashArray: 4
        },
        legend: {
          position: "top",
          horizontalAlign: "right",
          labels: { colors: "#374151" },
          fontSize: "11px"
        },
        tooltip: { theme: "light" }
      };
      new ApexCharts(sysEl, sysOptions).render();
    }

  });
</script>




