<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
  .chat-wrapper { max-width: 800px; margin: 0 auto; padding: 20px; }
  .chat-container { height: 500px; overflow-y: auto; background: #f8f9fa; border: 1px solid #ddd; padding: 20px; border-radius: 10px; margin-bottom: 20px; }
  .message-box { margin-bottom: 15px; display: flex; flex-direction: column; }
  .message-box.my-msg { align-items: flex-end; }
  .message-box.other-msg { align-items: flex-start; }

  /* 일반 말풍선 스타일 */
  .msg-bubble { max-width: 70%; padding: 10px 15px; border-radius: 15px; font-size: 15px; position: relative; word-break: break-all;}
  .my-msg .msg-bubble { background-color: #ffe082; border-top-right-radius: 0; }
  .other-msg .msg-bubble { background-color: white; border: 1px solid #eee; border-top-left-radius: 0; }

  .msg-info { font-size: 12px; color: #888; margin-top: 5px; }

  /* 플러스 버튼 및 메뉴 스타일 */
  .chat-input-area {
    display: flex;
    align-items: center;
    gap: 10px;
    padding-top: 10px;
  }
  .btn-plus {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    border: none;
    background-color: #eee;
    color: #555;
    font-size: 20px;
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
    transition: background 0.2s;
  }
  .btn-plus:hover { background-color: #ddd; }
  .btn-plus.active { background-color: #ccc; transform: rotate(45deg); }

  /* 확장 메뉴 스타일 */
  .plus-menu {
    display: none;
    padding: 20px 10px;
    background-color: #f8f9fa;
    border-top: 1px solid #ddd;
    margin-top: 15px;
    border-radius: 10px;
  }
  .plus-menu-grid {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 15px;
    text-align: center;
  }
  .menu-item {
    cursor: pointer;
    display: flex;
    flex-direction: column;
    align-items: center;
    color: #333;
    font-size: 13px;
  }
  .menu-icon-box {
    width: 50px;
    height: 50px;
    background-color: white;
    border-radius: 20px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 24px;
    margin-bottom: 8px;
    box-shadow: 0 2px 5px rgba(0,0,0,0.05);
    transition: transform 0.1s;
    color: #555;
  }
  .menu-item:hover .menu-icon-box {
    transform: scale(1.05);
    background-color: #e3f2fd;
    color: #1565c0;
  }

  /* [추가] 산책 신청 카드(선물하기 스타일) CSS */
  .walk-card {
    width: 240px;
    background-color: white;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 4px 10px rgba(0,0,0,0.1);
    border: 1px solid #eee;
    margin-top: 5px;
  }
  .walk-card-content {
    padding: 20px;
    text-align: center;
    background: #fff;
  }
  .walk-card-icon {
    font-size: 40px;
    color: #ffc107; /* 노란색 포인트 */
    margin-bottom: 12px;
  }
  .walk-card-title {
    font-weight: bold;
    font-size: 16px;
    margin-bottom: 5px;
    color: #333;
  }
  .walk-card-desc {
    font-size: 13px;
    color: #888;
    margin-bottom: 0;
  }
  .btn-start-walk {
    width: 100%;
    border: none;
    background-color: #f8f9fa;
    padding: 12px 0;
    font-size: 14px;
    color: #333;
    cursor: pointer;
    border-top: 1px solid #eee;
    font-weight: bold;
    transition: background 0.2s;
  }
  .btn-start-walk:hover {
    background-color: #ffe082; /* 버튼 호버시 노란색 */
  }
</style>

<div class="chat-wrapper">
  <div class="card">
    <div class="card-header bg-white">
      <h5 class="mb-0"><i class="fas fa-comments"></i> ${room.postTitle}</h5>
    </div>
    <div class="card-body">
      <div id="chatContainer" class="chat-container">
        <c:forEach var="msg" items="${msgs}">
          <c:choose>
            <c:when test="${msg.senderId == user.userId}">
              <div class="message-box my-msg">
                <c:choose>
                  <c:when test="${msg.content eq '[[WALK_REQUEST]]'}">
                    <div class="walk-card">
                      <div class="walk-card-content">
                        <div class="walk-card-icon"><i class="fas fa-dog"></i></div>
                        <div class="walk-card-title">산책해요!</div>
                        <p class="walk-card-desc">산책 알바 신청이 들어왔어요!</p>
                      </div>
                      <button class="btn-start-walk" onclick="startWalk()">산책 시작하기</button>
                    </div>
                  </c:when>
                  <c:otherwise>
                    <div class="msg-bubble">${msg.content}</div>
                  </c:otherwise>
                </c:choose>
              </div>
            </c:when>
            <c:otherwise>
              <div class="message-box other-msg">
                <c:choose>
                  <c:when test="${msg.content eq '[[WALK_REQUEST]]'}">
                    <div class="walk-card">
                      <div class="walk-card-content">
                        <div class="walk-card-icon"><i class="fas fa-dog"></i></div>
                        <div class="walk-card-title">산책해요!</div>
                        <p class="walk-card-desc">함께 산책하시겠습니까?</p>
                      </div>
                      <button class="btn-start-walk" onclick="startWalk()">산책 시작하기</button>
                    </div>
                  </c:when>
                  <c:otherwise>
                    <div class="msg-bubble">${msg.content}</div>
                  </c:otherwise>
                </c:choose>
              </div>
            </c:otherwise>
          </c:choose>
        </c:forEach>
      </div>

      <div class="chat-input-area">
        <button type="button" id="plusBtn" class="btn-plus" onclick="togglePlusMenu()">
          <i class="fas fa-plus"></i>
        </button>

        <div class="input-group" style="flex: 1;">
          <input type="text" id="msgInput" class="form-control" placeholder="메시지 입력..." onkeypress="if(event.keyCode==13) sendMessage();">
          <div class="input-group-append">
            <button class="btn btn-warning" onclick="sendMessage()">전송</button>
          </div>
        </div>
      </div>

      <div id="plusMenu" class="plus-menu">
        <div class="plus-menu-grid">
          <div class="menu-item" onclick="requestVideoCall()">
            <div class="menu-icon-box"><i class="fas fa-video"></i></div>
            <span>영상통화</span>
          </div>

          <div class="menu-item" onclick="requestWalk()">
            <div class="menu-icon-box"><i class="fas fa-walking"></i></div>
            <span>산책하기</span>
          </div>
        </div>
      </div>

    </div>
  </div>
</div>

<script>
  var ws;
  var roomId = "${room.roomId}";
  var myId = "${user.userId}";
  var chatContainer = document.getElementById("chatContainer");

  // 스크롤 맨 아래로
  chatContainer.scrollTop = chatContainer.scrollHeight;

  window.onload = function() {
    connect();
  };

  function connect() {
    var protocol = location.protocol === 'https:' ? 'wss://' : 'ws://';
    var wsUrl = protocol + location.host + "/ws/chat";

    console.log("Connecting to: " + wsUrl);

    ws = new WebSocket(wsUrl);

    ws.onopen = function() {
      console.log("Connected!");
      var msg = {
        roomId: roomId,
        senderId: myId,
        content: "ENTER"
      };
      ws.send(JSON.stringify(msg));
    };

    ws.onmessage = function(event) {
      var data = JSON.parse(event.data);
      if(data.content === "ENTER") return;

      var msgDiv = document.createElement("div");

      // [수정] 산책 요청 메시지인지 확인하여 다르게 렌더링
      if (data.content === "[[WALK_REQUEST]]") {
        // 카드형 메시지 HTML 생성
        var cardHtml =
                '<div class="walk-card">' +
                '<div class="walk-card-content">' +
                '<div class="walk-card-icon"><i class="fas fa-dog"></i></div>' +
                '<div class="walk-card-title">산책해요!</div>' +
                '<p class="walk-card-desc">산책 메이트 신청이 도착했습니다.</p>' +
                '</div>' +
                '<button class="btn-start-walk" onclick="startWalk()">산책 시작하기</button>' +
                '</div>';

        msgDiv.innerHTML = cardHtml;
      } else {
        // 일반 텍스트 메시지
        var content = '<div class="msg-bubble">' + data.content + '</div>';
        msgDiv.innerHTML = content;
      }

      // 내 메시지인지 상대방 메시지인지 구분
      if(data.senderId == myId) {
        msgDiv.className = "message-box my-msg";
      } else {
        msgDiv.className = "message-box other-msg";
      }

      chatContainer.appendChild(msgDiv);
      chatContainer.scrollTop = chatContainer.scrollHeight;
    };
  }

  function sendMessage() {
    var input = document.getElementById("msgInput");
    var text = input.value;
    if(!text.trim()) return;

    var msg = {
      roomId: roomId,
      senderId: myId,
      content: text
    };

    ws.send(JSON.stringify(msg));
    input.value = "";
  }

  function togglePlusMenu() {
    var menu = document.getElementById("plusMenu");
    var btn = document.getElementById("plusBtn");
    var chatContainer = document.getElementById("chatContainer");

    if (menu.style.display === "block") {
      menu.style.display = "none";
      btn.classList.remove("active");
    } else {
      menu.style.display = "block";
      btn.classList.add("active");
      chatContainer.scrollTop = chatContainer.scrollHeight;
    }
  }

  // [기능 구현] 영상통화 요청 (기존 유지)
  function requestVideoCall() {
    alert("영상통화 요청을 보냅니다.");
    // 여기에 WebRTC 연결 로직 등을 추가
  }

  // [기능 구현] 산책하기 카드 전송
  function requestWalk() {
    // 메뉴 닫기
    togglePlusMenu();

    // 특수 메시지 전송
    var msg = {
      roomId: roomId,
      senderId: myId,
      content: "[[WALK_REQUEST]]" // 약속된 산책 요청 코드
    };
    ws.send(JSON.stringify(msg));
  }

  // [기능 구현] 산책 시작하기 버튼 클릭 시 동작
  function startWalk() {
    if(confirm("산책을 시작하시겠습니까?")) {
      // 여기에 실제 산책 모드 시작 로직 (예: 페이지 이동, 지도 표시 등)
      alert("산책 모드로 진입합니다! (구현 예정)");
      // location.href = '/walk/start?roomId=' + roomId; // 예시
    }
  }
</script>