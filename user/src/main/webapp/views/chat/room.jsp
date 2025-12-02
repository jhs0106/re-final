<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
  .chat-wrapper { max-width: 800px; margin: 0 auto; padding: 20px; }
  .chat-container { height: 500px; overflow-y: auto; background: #f8f9fa; border: 1px solid #ddd; padding: 20px; border-radius: 10px; margin-bottom: 20px; }
  .message-box { margin-bottom: 15px; display: flex; flex-direction: column; }
  .message-box.my-msg { align-items: flex-end; }
  .message-box.other-msg { align-items: flex-start; }
  .msg-bubble { max-width: 70%; padding: 10px 15px; border-radius: 15px; font-size: 15px; position: relative; word-break: break-all;}
  .my-msg .msg-bubble { background-color: #ffe082; border-top-right-radius: 0; }
  .other-msg .msg-bubble { background-color: white; border: 1px solid #eee; border-top-left-radius: 0; }
  .msg-info { font-size: 12px; color: #888; margin-top: 5px; }

  /* [추가] 플러스 버튼 및 메뉴 스타일 */
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
  .btn-plus:hover {
    background-color: #ddd;
  }
  .btn-plus.active {
    background-color: #ccc;
    transform: rotate(45deg); /* 회전 효과 */
  }
  .plus-menu {
    display: none; /* 기본 숨김 */
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
    background-color: #fff8e1;
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
                <div class="msg-bubble">${msg.content}</div>
              </div>
            </c:when>
            <c:otherwise>
              <div class="message-box other-msg">
                <div class="msg-bubble">${msg.content}</div>
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
          <div class="menu-item" onclick="alert('앨범 기능 구현 예정')">
            <div class="menu-icon-box"><i class="fas fa-images"></i></div>
            <span>앨범</span>
          </div>
          <div class="menu-item" onclick="alert('카메라 기능 구현 예정')">
            <div class="menu-icon-box"><i class="fas fa-camera"></i></div>
            <span>카메라</span>
          </div>
          <div class="menu-item" onclick="alert('파일 전송 구현 예정')">
            <div class="menu-icon-box"><i class="fas fa-file-alt"></i></div>
            <span>파일</span>
          </div>
          <div class="menu-item" onclick="alert('위치 공유 구현 예정')">
            <div class="menu-icon-box"><i class="fas fa-map-marker-alt"></i></div>
            <span>위치</span>
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
    // [핵심] SSL(https)이면 wss, 아니면 ws 자동 선택
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
      var content = '<div class="msg-bubble">' + data.content + '</div>';

      if(data.senderId == myId) {
        msgDiv.className = "message-box my-msg";
      } else {
        msgDiv.className = "message-box other-msg";
      }

      msgDiv.innerHTML = content;
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

  // [추가] 플러스 메뉴 토글 함수
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
      // 메뉴가 열리면 스크롤을 맨 아래로 조정
      chatContainer.scrollTop = chatContainer.scrollHeight;
    }
  }
</script>