<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="true" %>

<style>
  :root {
    --primary-color: #1d4ed8;
    --accent-pink: #ff4fa3;
    --bg-soft: #f9fafb;
    --card-radius: 18px;
    --shadow-soft: 0 18px 45px rgba(15, 23, 42, 0.08);
  }

  body {
    background: #f5f7fb;
  }

  /* 페이지 전체 래퍼 */
  .map-page-wrapper {
    padding: 40px 16px 80px;
    display: flex;
    justify-content: center;
  }

  .map-page-container {
    width: min(1200px, 100%);
  }

  .map-page-header {
    text-align: center;
    margin-bottom: 24px;
  }

  .map-page-header h1 {
    font-size: 26px;
    font-weight: 800;
    margin-bottom: 8px;
  }

  .map-page-header .subtitle {
    color: #555;
    font-size: 14px;
    line-height: 1.6;
  }

  .map-notice-card {
    background: #fff7e6;
    border-radius: 14px;
    padding: 14px 18px;
    border: 1px solid #ffe3a2;
    display: flex;
    align-items: flex-start;
    gap: 10px;
    font-size: 13px;
    margin-bottom: 20px;
  }

  .map-notice-icon {
    font-size: 18px;
    margin-top: 2px;
    color: #f97316;
  }

  .map-notice-text strong {
    display: block;
    margin-bottom: 2px;
  }

  .map-main-card {
    background: #ffffff;
    border-radius: var(--card-radius);
    box-shadow: var(--shadow-soft);
    padding: 18px 18px 20px;
  }

  .map-card-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 12px;
    gap: 10px;
  }

  .map-card-title {
    font-weight: 700;
    font-size: 16px;
  }

  .map-card-caption {
    font-size: 12px;
    color: #777;
  }

  /* === 기존 map-container를 카드 안에서만 쓰도록 재정의 === */
  .map-container {
    display: flex;
    flex-direction: row;
    width: 100%;
    height: 520px;
    background: transparent;
    border-top: none;
    gap: 16px;
  }

  #map {
    flex: 7;
    min-height: 260px;
    height: 100%;
    background: #e5e7eb;
    border-radius: 14px;
    overflow: hidden;
  }

  .info-panel {
    flex: 5;
    display: flex;
    flex-direction: column;
    background: #fff;
    min-width: 280px;
  }

  /* 탭 */
  .tab-head {
    display: flex;
    height: 40px;
    margin-bottom: 8px;
    border-bottom: none;
    border-radius: 999px;
    background: #eef2ff;
    padding: 3px;
    overflow: hidden;
  }

  .tab-head div {
    flex: 1;
    text-align: center;
    line-height: 34px;
    font-weight: 600;
    cursor: pointer;
    background: transparent;
    font-size: 13px;
    border-radius: 999px;
    color: #4b5563;
    transition: background 0.18s, color 0.18s, box-shadow 0.18s;
  }

  .tab-head .active {
    background: var(--primary-color);
    color: #fff;
    box-shadow: 0 6px 16px rgba(37, 99, 235, 0.35);
  }

  /* 직접 검색 영역 */
  #searchBox {
    display: none;
    padding: 8px 10px;
    border-bottom: 1px solid #eee;
    background: #fafafa;
    border-radius: 10px;
    margin-bottom: 8px;
  }

  #searchBox input {
    width: 70%;
    padding: 6px 8px;
    border-radius: 8px;
    border: 1px solid #ddd;
    font-size: 13px;
  }

  #searchBox button {
    padding: 6px 12px;
    margin-left: 6px;
    background: var(--primary-color);
    color: #fff;
    border: none;
    border-radius: 999px;
    cursor: pointer;
    font-size: 13px;
    font-weight: 600;
  }

  #infoList {
    flex: 1;
    overflow-y: auto;
    padding: 6px;
    background: #fff;
  }

  .info-card {
    padding: 12px;
    border: 2px solid #ddd;
    background: #fafafa;
    border-radius: 12px;
    margin-bottom: 10px;
    font-size: 13px;
    cursor: pointer;
    transition: border-color 0.18s, background 0.18s, transform 0.12s;
  }

  .info-card:hover {
    border-color: #c7d2fe;
    transform: translateY(-1px);
  }

  .info-card b {
    font-size: 14px;
  }

  .info-card.active-card {
    border: 3px solid var(--accent-pink);
    background: #ffe8f4;
  }

  .route-btn {
    display: inline-block;
    margin-top: 6px;
    background: var(--accent-pink);
    color: #fff;
    border: none;
    border-radius: 999px;
    padding: 6px 14px;
    font-size: 12px;
    cursor: pointer;
    font-weight: 600;
  }

  @media (max-width: 900px) {
    .map-container {
      flex-direction: column;
      height: auto;
    }
    #map {
      flex: none;
      height: 320px;
    }
    .info-panel {
      flex: 1;
      max-height: 360px;
      min-width: 100%;
    }
  }

  @media (max-width: 600px) {
    .map-page-wrapper {
      padding-top: 24px;
    }
    .map-main-card {
      padding: 14px 12px 16px;
    }
  }
</style>

<div class="map-page-wrapper">
  <div class="map-page-container">
    <!-- 상단 타이틀 / 설명 -->
    <div class="map-page-header">
      <h1>주변 펫 시설 찾기</h1>
      <p class="subtitle">
        현재 위치 기준으로 동물병원 · 애견카페 · 애견호텔을 검색합니다.<br>
        시설을 선택하면 카카오맵 길찾기로 바로 이동할 수 있어요.
      </p>
    </div>

    <!-- 안내 카드 -->
    <div class="map-notice-card">
      <div class="map-notice-icon">⚠️</div>
      <div class="map-notice-text">
        <strong>표시되는 정보는 카카오맵 데이터를 기반으로 합니다.</strong>
        실제 영업 여부·시간·휴무일 등은 방문 전 반드시 전화 등으로 재확인해주세요.
      </div>
    </div>

    <!-- 메인 카드 -->
    <div class="map-main-card">
      <div class="map-card-header">
        <div>
          <div class="map-card-title">내 주변 펫 전용 시설</div>
          <div class="map-card-caption">탭을 눌러 시설 종류를 바꾸거나, 직접 검색해보세요.</div>
        </div>
      </div>

      <!-- 여기부터는 원래 구조 그대로 (id/class 유지) -->
      <div class="map-container">
        <div id="map"></div>

        <div class="info-panel">
          <div class="tab-head">
            <div id="tab-hospital" class="active">동물병원</div>
            <div id="tab-cafe">애견카페</div>
            <div id="tab-hotel">애견호텔</div>
            <div id="tab-search">직접 검색</div>
          </div>

          <div id="searchBox">
            <input id="searchKeyword" type="text" placeholder="예: 서울 애견카페, 강남 동물병원 등">
            <button id="searchBtn" type="button">검색</button>
          </div>

          <div id="infoList"></div>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- Kakao Map SDK -->
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=55e3779d3a4e94654971764756e0a939&libraries=services"></script>

<script>
  /* ==== 여기부터는 네가 올린 '기능 코드 원본' 그대로 ==== */

  let map;
  let ps;
  let markers = [];
  let infowindow;
  let placesData = [];

  // 출발지 기본값 = 선문대
  const DEFAULT_LAT = 36.800233;
  const DEFAULT_LNG = 127.075569;

  // geolocation 위치 (기본은 선문대)
  let userLat = DEFAULT_LAT;
  let userLng = DEFAULT_LNG;

  // 출발지 이름 (역지오코딩으로 갱신)
  let originName = "선문대학교 아산캠퍼스";
  let geocoder;

  // ===== 거리 계산 =====
  function calcDistanceKm(lat1, lng1, lat2, lng2) {
    const R = 6371;
    const dLat = (lat2 - lat1) * Math.PI / 180;
    const dLng = (lng2 - lng1) * Math.PI / 180;
    const a =
            Math.sin(dLat / 2) * Math.sin(dLat / 2) +
            Math.cos(lat1 * Math.PI / 180) *
            Math.cos(lat2 * Math.PI / 180) *
            Math.sin(dLng / 2) * Math.sin(dLng / 2);
    const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    return R * c;
  }

  function formatDistance(lat1, lng1, lat2, lng2) {
    const km = calcDistanceKm(lat1, lng1, lat2, lng2);
    if (isNaN(km)) return "거리 정보 없음";
    if (km < 1) return Math.round(km * 1000) + "m";
    return km.toFixed(1) + "km";
  }

  // ===== 출발지 이름을 geolocation 기준으로 갱신 (역지오코딩) =====
  function updateOriginNameFromCurrentLocation() {
    if (!geocoder) return;

    const lng = userLng;
    const lat = userLat;

    geocoder.coord2Address(lng, lat, function (result, status) {
      if (status === kakao.maps.services.Status.OK && result[0]) {
        const addr = result[0];

        if (addr.road_address) {
          if (addr.road_address.building_name) {
            originName = addr.road_address.building_name;
          } else {
            originName = addr.road_address.address_name;
          }
        } else if (addr.address) {
          originName = addr.address.address_name;
        }

        console.log("[ORIGIN] 출발지 이름 갱신:", originName);
      } else {
        console.log("[ORIGIN] 역지오코딩 실패, 기본값 유지:", originName);
      }
    });
  }

  function closeInfoWindow() {
    if (infowindow) infowindow.close();
  }

  function deactivateCards() {
    document.querySelectorAll(".info-card").forEach(c => c.classList.remove("active-card"));
  }

  function clearMarkers() {
    markers.forEach(m => m.setMap(null));
    markers = [];
  }

  // ✅ 길찾기: 출발 이름 = originName(내 위치 기반), 도착 이름 = 선택 시설 이름
  function goRoute(index) {
    const place = placesData[index];
    if (!place) return;

    const url =
            "https://map.kakao.com/?" +
            "sName=" + encodeURIComponent(originName || "내 위치") +
            "&eName=" + encodeURIComponent(place.place_name);

    console.log("[ROUTE]", originName, "→", place.place_name);
    window.open(url, "_blank");
  }
  window.goRoute = goRoute;

  function showMarkerInfo(index) {
    const place = placesData[index];
    const marker = markers[index];
    if (!place || !marker) return;

    const address = place.address_name || "주소 정보 없음";

    const content =
            `<div style="padding:8px 10px 16px; padding-bottom:30px; max-width:220px; font-size:13px;">
         <div style="font-weight:700; margin-bottom:4px;">${place.place_name}</div>
         <div style="margin-bottom:8px;">${address}</div>
         <div style="text-align:center;">
           <button type="button"
                   style="background:#ff4fa3;color:#fff;border:none;border-radius:6px;padding:6px 14px;font-size:12px;cursor:pointer;display:inline-block;"
                   onclick="goRoute(${index})">
             길찾기
           </button>
         </div>
       </div>`;

    closeInfoWindow();
    infowindow.setContent(content);
    infowindow.open(map, marker);
    map.panTo(marker.getPosition());
  }

  function renderList(places) {
    const list = document.getElementById("infoList");
    list.innerHTML = "";

    if (!places || places.length === 0) {
      list.innerHTML = "<div style='padding:16px;'>검색 결과가 없습니다.</div>";
      return;
    }

    places.forEach((p, idx) => {
      const address = p.address_name || "주소 정보 없음";

      const card = document.createElement("div");
      card.className = "info-card";
      card.id = "place-" + idx;

      card.innerHTML = `
        <div><b>${p.place_name}</b></div>
        <div>${address}</div>
        <button type="button" class="route-btn"
                onclick="goRoute(${idx}); event.stopPropagation && event.stopPropagation();">
          길찾기
        </button>
      `;

      card.onclick = () => {
        deactivateCards();
        card.classList.add("active-card");
        showMarkerInfo(idx);
        card.scrollIntoView({ behavior: "smooth", block: "center" });
      };

      list.appendChild(card);
    });
  }

  function displayPlaces(data, status) {
    if (status !== kakao.maps.services.Status.OK) {
      clearMarkers();
      placesData = [];
      renderList([]);
      closeInfoWindow();
      return;
    }

    placesData = data;
    clearMarkers();
    deactivateCards();
    closeInfoWindow();

    data.forEach((p, idx) => {
      const marker = new kakao.maps.Marker({
        map: map,
        position: new kakao.maps.LatLng(p.y, p.x)
      });
      markers.push(marker);

      kakao.maps.event.addListener(marker, () => {
        deactivateCards();
        const card = document.getElementById("place-" + idx);
        if (card) {
          card.classList.add("active-card");
          card.scrollIntoView({ behavior: "smooth", block: "center" });
        }
        showMarkerInfo(idx);
      });
    });

    renderList(data);
  }

  // useLocal: true → 내 위치 기준 / false → 전국 검색
  function searchKeyword(keyword, useLocal) {
    if (!ps) return;

    closeInfoWindow();
    deactivateCards();

    if (useLocal) {
      const center = new kakao.maps.LatLng(userLat, userLng);
      const options = {
        location: center,
        radius: 5000,
        sort: kakao.maps.services.SortBy.DISTANCE
      };
      ps.keywordSearch(keyword, displayPlaces, options);
    } else {
      ps.keywordSearch(keyword, displayPlaces);
    }
  }

  function activateTab(tabId) {
    document.querySelectorAll(".tab-head div")
            .forEach(el => el.classList.remove("active"));
    document.getElementById("tab-" + tabId).classList.add("active");

    document.getElementById("searchBox").style.display =
            (tabId === "search" ? "block" : "none");
  }

  document.addEventListener("DOMContentLoaded", function () {

    map = new kakao.maps.Map(document.getElementById('map'), {
      center: new kakao.maps.LatLng(DEFAULT_LAT, DEFAULT_LNG),
      level: 5
    });

    ps = new kakao.maps.services.Places();
    infowindow = new kakao.maps.InfoWindow({ zIndex: 3 });
    geocoder = new kakao.maps.services.Geocoder();

    kakao.maps.event.addListener(map, "click", () => {
      closeInfoWindow();
      deactivateCards();
    });

    setTimeout(() => {
      kakao.maps.event.trigger(map, "resize");
      map.setCenter(new kakao.maps.LatLng(DEFAULT_LAT, DEFAULT_LNG));
    }, 400);

    // Geolocation 시도
    if (navigator.geolocation) {
      console.log("[GEO] 지원됨");
      navigator.geolocation.getCurrentPosition(
              (pos) => {
                console.log("[GEO] 성공", pos.coords);
                userLat = pos.coords.latitude;
                userLng = pos.coords.longitude;
                const loc = new kakao.maps.LatLng(userLat, userLng);
                map.setCenter(loc);

                // 내 위치 기준 출발지 이름 갱신
                updateOriginNameFromCurrentLocation();

                // 내 위치 주변 동물병원
                searchKeyword("동물병원", true);
              },
              (err) => {
                console.warn("[GEO] 실패:", err);
                userLat = DEFAULT_LAT;
                userLng = DEFAULT_LNG;
                map.setCenter(new kakao.maps.LatLng(DEFAULT_LAT, DEFAULT_LNG));
                // 출발지 이름은 기본값(선문대) 유지
                searchKeyword("동물병원", true);
              },
              { enableHighAccuracy: true, timeout: 5000, maximumAge: 0 }
      );
    } else {
      console.log("[GEO] 미지원");
      userLat = DEFAULT_LAT;
      userLng = DEFAULT_LNG;
      map.setCenter(new kakao.maps.LatLng(DEFAULT_LAT, DEFAULT_LNG));
      searchKeyword("동물병원", true);
    }

    // 탭 이벤트
    document.getElementById("tab-hospital").onclick = () => {
      activateTab("hospital");
      searchKeyword("동물병원", true);
    };

    document.getElementById("tab-cafe").onclick = () => {
      activateTab("cafe");
      searchKeyword("애견카페", true);
    };

    document.getElementById("tab-hotel").onclick = () => {
      activateTab("hotel");
      searchKeyword("애견호텔", true);
    };

    document.getElementById("tab-search").onclick = () => {
      activateTab("search");
      closeInfoWindow();
      deactivateCards();
      document.getElementById("infoList").innerHTML =
              "<div style='padding:16px;'>검색어를 입력한 후 검색 버튼을 눌러주세요.</div>";
    };

    // 직접 검색 → 전국 검색
    document.getElementById("searchBtn").onclick = () => {
      const keyword = document.getElementById("searchKeyword").value.trim();
      if (!keyword) {
        alert("검색어를 입력해주세요.");
        return;
      }
      searchKeyword(keyword, false);
    };
  });
</script>
