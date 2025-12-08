<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
    /* [디자인 테마 설정] */
    :root {
        --primary-color: #FF6B6B;       /* 포인트 컬러 (Red) */
        --primary-light: #FFF0F0;
        --secondary-color: #4ECDC4;     /* 서브 컬러 (Mint) */
        --secondary-light: #E0F2F1;
        --purple-color: #845EF7;        /* 리포트 컬러 (Purple) */
        --purple-light: #F3F0FF;
        --resume-color: #FFD43B;        /* 이력서 컬러 (Yellow) */
        --resume-light: #FFF9DB;
        --bg-color: #F2F4F7;
        --my-bubble-bg: #FF6B6B;
        --my-bubble-text: #FFFFFF;
        --other-bubble: #FFFFFF;
        --shadow-sm: 0 2px 5px rgba(0,0,0,0.05);
    }

    body { background-color: var(--bg-color); margin: 0; padding: 0; }

    .chat-wrapper {
        max-width: 600px;
        margin: 0 auto;
        height: 100vh;
        background-color: var(--bg-color);
        display: flex;
        flex-direction: column;
        position: relative;
    }

    /* 헤더 스타일 */
    .chat-header {
        background: #fff;
        padding: 15px 20px;
        display: flex;
        align-items: center;
        justify-content: center;
        box-shadow: 0 1px 10px rgba(0,0,0,0.05);
        z-index: 100;
        position: sticky;
        top: 0;
    }
    .chat-header-title {
        font-weight: 700;
        font-size: 1.1rem;
        color: #333;
        display: flex;
        align-items: center;
        gap: 8px;
    }
    .chat-header-title i { color: var(--primary-color); font-size: 1.3rem; }

    /* 채팅 영역 스타일 */
    .chat-container {
        flex: 1;
        overflow-y: auto;
        padding: 20px;
        background-color: var(--bg-color);
        display: flex;
        flex-direction: column;
        gap: 15px;
        padding-bottom: 20px;
    }

    .message-box {
        display: flex;
        flex-direction: column;
        max-width: 85%;
    }

    /* 내 메시지 (오른쪽) */
    .message-box.my-msg {
        align-self: flex-end;
        align-items: flex-end;
    }
    .message-box.my-msg .msg-bubble {
        background-color: var(--my-bubble-bg);
        color: var(--my-bubble-text);
        border-top-right-radius: 2px;
        box-shadow: 0 2px 5px rgba(255, 107, 107, 0.3);
    }

    /* 상대방 메시지 (왼쪽) */
    .message-box.other-msg {
        align-self: flex-start;
        align-items: flex-start;
    }
    .message-box.other-msg .msg-bubble {
        background-color: var(--other-bubble);
        border: 1px solid #eee;
        border-top-left-radius: 2px;
        color: #333;
    }

    /* 공통 말풍선 */
    .msg-bubble {
        padding: 12px 18px;
        border-radius: 18px;
        font-size: 15px;
        line-height: 1.5;
        position: relative;
        word-break: break-all;
        box-shadow: var(--shadow-sm);
    }

    /* --- [이벤트 카드 공통 스타일] --- */
    .event-card {
        background: #fff;
        border-radius: 15px;
        overflow: hidden;
        box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        width: 260px;
        text-align: center;
        margin-top: 5px;
        border: 1px solid rgba(0,0,0,0.05);
    }
    .event-card-content { padding: 25px 20px; }

    .event-icon-circle {
        width: 60px; height: 60px;
        border-radius: 50%;
        display: flex; align-items: center; justify-content: center;
        margin: 0 auto 15px;
        font-size: 28px;
    }

    .event-title { font-weight: bold; font-size: 16px; margin-bottom: 5px; color: #333; }
    .event-desc { font-size: 13px; color: #888; margin: 0; line-height: 1.4; }

    .btn-event-action {
        width: 100%; padding: 15px 0;
        border: none;
        background: #f9f9f9;
        font-weight: 600;
        font-size: 14px;
        color: #333;
        border-top: 1px solid #eee;
        cursor: pointer; transition: 0.2s;
    }
    .btn-event-action:disabled { background: #eee; color: #aaa; cursor: default; }

    /* 테마별 스타일 (산책: Default Red) */
    .walk-style .event-icon-circle { background: var(--primary-light); color: var(--primary-color); }
    .walk-style .btn-event-action:hover:not(:disabled) { background: var(--primary-light); color: var(--primary-color); }

    /* 영상통화 스타일 (Mint) */
    .video-style .event-icon-circle { background: var(--secondary-light); color: var(--secondary-color); }
    .video-style .btn-event-action:hover:not(:disabled) { background: var(--secondary-light); color: var(--secondary-color); }

    /* 이력서 스타일 (Yellow) */
    .resume-style .event-icon-circle { background: var(--resume-light); color: #F08C00; }
    .resume-style .btn-event-action { background: #FFD43B; color: #333; }
    .resume-style .btn-event-action:hover:not(:disabled) { opacity: 0.9; }

    /* 리포트 스타일 (Purple) */
    .report-style .event-icon-circle { background: var(--purple-light); color: var(--purple-color); }
    .report-style .btn-event-action { background: var(--purple-color); color: #fff; }
    .report-style .btn-event-action:hover:not(:disabled) { opacity: 0.9; }

    /* 하단 입력창 영역 */
    .chat-input-area {
        background: #fff;
        padding: 15px;
        display: flex;
        align-items: center;
        gap: 12px;
        border-top: 1px solid #eee;
        position: sticky;
        bottom: 0;
    }

    .btn-plus {
        width: 40px; height: 40px;
        border-radius: 50%;
        border: none;
        background-color: #F0F0F0;
        color: #666;
        font-size: 18px;
        display: flex; align-items: center; justify-content: center;
        cursor: pointer; transition: 0.3s;
    }
    .btn-plus:hover { background-color: #e0e0e0; }
    .btn-plus.active { background-color: var(--primary-color); color: #fff; transform: rotate(45deg); }

    .input-wrapper { flex: 1; position: relative; display: flex; }
    .chat-input {
        width: 100%;
        padding: 12px 50px 12px 20px;
        border: 1px solid #ddd;
        border-radius: 25px;
        background-color: #FAFAFA;
        outline: none;
        font-size: 15px;
        transition: 0.2s;
    }
    .chat-input:focus {
        background-color: #fff;
        border-color: var(--primary-color);
        box-shadow: 0 0 0 3px rgba(255, 107, 107, 0.1);
    }

    .btn-send {
        position: absolute;
        right: 5px; top: 50%;
        transform: translateY(-50%);
        border: none;
        background: var(--primary-color);
        color: white;
        width: 36px; height: 36px;
        border-radius: 50%;
        display: flex;
        align-items: center; justify-content: center;
        cursor: pointer;
        font-size: 14px;
        box-shadow: 0 2px 5px rgba(255, 107, 107, 0.3);
    }
    .btn-send:hover { opacity: 0.9; transform: translateY(-50%) scale(1.05); }

    /* 확장 메뉴 */
    .plus-menu {
        display: none;
        background-color: #fff;
        border-top: 1px solid #eee;
        padding: 20px;
    }
    .plus-menu-grid {
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        gap: 15px;
    }
    .menu-item {
        display: flex; flex-direction: column; align-items: center;
        cursor: pointer; color: #555;
        font-size: 12px;
    }
    .menu-icon-box {
        width: 55px; height: 55px;
        background-color: #F8F9FA;
        border-radius: 18px;
        display: flex;
        align-items: center; justify-content: center;
        font-size: 24px;
        color: #555;
        margin-bottom: 8px;
        transition: 0.2s;
    }
    .menu-item:hover .menu-icon-box { transform: scale(1.05); }
    .menu-item.video-type:hover .menu-icon-box { background: var(--secondary-light); color: var(--secondary-color); }
    .menu-item.walk-type:hover .menu-icon-box { background: var(--primary-light); color: var(--primary-color); }
    .menu-item.resume-type:hover .menu-icon-box { background: var(--resume-light); color: #F08C00; }
    .menu-item.report-type:hover .menu-icon-box { background: var(--purple-light); color: var(--purple-color); }

    /* --- [모달 공통] --- */
    .modal {
        display: none; position: fixed; z-index: 9999;
        left: 0; top: 0; width: 100%; height: 100%;
        background-color: rgba(0,0,0,0.6);
        backdrop-filter: blur(2px);
    }
    .modal-content {
        background-color: #fff;
        margin: 5% auto; padding: 25px;
        border-radius: 20px;
        width: 90%; max-width: 500px;
        position: relative;
        animation: slideIn 0.3s;
        max-height: 90vh; overflow-y: auto;
    }
    @keyframes slideIn { from { transform: translateY(20px); opacity: 0; } to { transform: translateY(0); opacity: 1; } }

    .close-modal {
        position: absolute; top: 15px; right: 20px;
        font-size: 24px; color: #aaa; cursor: pointer;
    }

    /* === [수정] 영상통화 모달 (화면 꽉 채우기 & 짤림 방지) === */
    #videoModal {
        display: none;
        position: fixed;
        top: 0; left: 0; width: 100%; height: 100%;
        background-color: #000; /* 배경 검정 */
        z-index: 99999; /* 채팅방 헤더보다 위 */
        flex-direction: column;
        align-items: center;
        justify-content: center;
        overflow: hidden;
    }

    /* 상대방 화면 (메인) */
    #remoteVideo {
        width: 100%; height: 100%;
        object-fit: contain; /* [핵심] 비율 유지하며 화면에 다 들어오게 */
        background: #000;
    }

    /* 내 화면 (우측 하단 PIP) */
    #localVideo {
        position: absolute;
        bottom: 100px; right: 20px;
        width: 100px; height: 140px;
        background: #222;
        border: 2px solid rgba(255, 255, 255, 0.5);
        border-radius: 10px;
        object-fit: cover;
        z-index: 10000;
        box-shadow: 0 4px 10px rgba(0,0,0,0.5);
        transition: 0.3s;
    }

    /* 컨트롤 버튼 (화면 하단 중앙 고정) */
    .video-controls {
        position: absolute;
        bottom: 30px;
        left: 50%;
        transform: translateX(-50%);
        width: 100%;
        display: flex; justify-content: center;
        gap: 20px; z-index: 10001;
    }

    .btn-close-video {
        background: #ff4b4b; color: white; border: none;
        padding: 12px 30px; border-radius: 30px;
        font-weight: bold; cursor: pointer; font-size: 16px;
        box-shadow: 0 4px 10px rgba(0,0,0,0.3);
    }
    .btn-close-video:hover { background: #ff3333; }

    /* 이력서 & 리포트 스타일 */
    .resume-header { text-align: center; border-bottom: 2px dashed #eee; padding-bottom: 20px; margin-bottom: 20px; }
    .resume-avatar {
        width: 80px; height: 80px; background: var(--primary-light); border-radius: 50%;
        margin: 0 auto 15px; display: flex; align-items: center; justify-content: center;
        font-size: 40px; color: var(--primary-color);
    }
    .resume-section h4 {
        font-size: 1.1rem; border-left: 4px solid var(--secondary-color);
        padding-left: 10px; margin-bottom: 12px;
    }
    .resume-table { width: 100%; margin-bottom: 15px; }
    .resume-table td { padding: 5px 0; vertical-align: top; }
    .resume-label { width: 30%; color: #888; }
    .modal-footer-btn {
        width: 100%; padding: 15px; border: none; border-radius: 12px;
        color: white; font-weight: bold; cursor: pointer; margin-top: 15px;
    }
</style>

<div class="chat-wrapper">
    <div class="chat-header">
        <div class="chat-header-title">
            <i class="fas fa-paw"></i>
            <c:choose>
                <c:when test="${room.ownerId == user.userId}">
                    ${room.workerName} <span style="font-size:0.8em; font-weight:normal; color:#888;">(알바생)</span>
                </c:when>
                <c:otherwise>
                    ${room.ownerName} <span style="font-size:0.8em; font-weight:normal; color:#888;">(견주)</span>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <div id="chatContainer" class="chat-container">
        <c:forEach var="msg" items="${msgs}">
            <c:choose>
                <%-- 내가 보낸 메시지 --%>
                <c:when test="${msg.senderId == user.userId}">
                    <div class="message-box my-msg">
                        <c:choose>
                            <%-- 1. 산책 요청 --%>
                            <c:when test="${msg.content eq '[[WALK_REQUEST]]'}">
                                <div class="event-card walk-style">
                                    <div class="event-card-content">
                                        <div class="event-icon-circle"><i class="fas fa-dog"></i></div>
                                        <div class="event-title">산책해요!</div>
                                        <p class="event-desc">산책 알바 신청을 보냈습니다.</p>
                                    </div>
                                    <button class="btn-event-action" disabled>수락 대기중</button>
                                </div>
                            </c:when>
                            <%-- 2. 산책 시작 (내가 보냄 = 나는 알바생) --%>
                            <c:when test="${msg.content eq '[[WALK_STARTED]]'}">
                                <div class="event-card video-style">
                                    <div class="event-card-content">
                                        <div class="event-icon-circle"><i class="fas fa-running"></i></div>
                                        <div class="event-title">산책 현황</div>
                                        <p class="event-desc">산책이 시작되었습니다.</p>
                                    </div>
                                    <button class="btn-event-action" onclick="location.href='/walkjob/worker'">산책 현황 보기</button>
                                </div>
                            </c:when>
                            <%-- 3. 영상통화 요청 --%>
                            <c:when test="${msg.content eq '[[VIDEO_REQUEST]]'}">
                                <div class="event-card video-style">
                                    <div class="event-card-content">
                                        <div class="event-icon-circle"><i class="fas fa-video"></i></div>
                                        <div class="event-title">영상통화</div>
                                        <p class="event-desc">영상통화를 요청했습니다.</p>
                                    </div>
                                    <button class="btn-event-action" disabled>응답 대기중</button>
                                </div>
                            </c:when>
                            <%-- 4. 이력서 전송 --%>
                            <c:when test="${msg.content eq '[[RESUME_SEND]]'}">
                                <div class="event-card resume-style">
                                    <div class="event-card-content">
                                        <div class="event-icon-circle"><i class="fas fa-id-card-alt"></i></div>
                                        <div class="event-title">이력서 전송 완료</div>
                                        <p class="event-desc">나의 이력서를 전송했습니다.</p>
                                    </div>
                                    <button class="btn-event-action" disabled>전송됨</button>
                                </div>
                            </c:when>
                            <%-- 5. 리포트 전송 --%>
                            <c:when test="${msg.content eq '[[REPORT_SEND]]'}">
                                <div class="event-card report-style">
                                    <div class="event-card-content">
                                        <div class="event-icon-circle"><i class="fas fa-brain"></i></div>
                                        <div class="event-title">리포트 전송 완료</div>
                                        <p class="event-desc">AI 종합 분석 리포트</p>
                                    </div>
                                    <button class="btn-event-action" disabled>전송됨</button>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="msg-bubble">${msg.content}</div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </c:when>

                <%-- 상대방이 보낸 메시지 --%>
                <c:otherwise>
                    <div class="message-box other-msg">
                        <c:choose>
                            <%-- 1. 산책 요청 수락 --%>
                            <c:when test="${msg.content eq '[[WALK_REQUEST]]'}">
                                <div class="event-card walk-style">
                                    <div class="event-card-content">
                                        <div class="event-icon-circle"><i class="fas fa-dog"></i></div>
                                        <div class="event-title">산책해요!</div>
                                        <p class="event-desc">함께 산책하시겠습니까?</p>
                                    </div>
                                    <button class="btn-event-action" onclick="startWalk()">산책 시작하기</button>
                                </div>
                            </c:when>
                            <%-- 2. 산책 현황 (상대가 보냄 = 나는 견주) --%>
                            <c:when test="${msg.content eq '[[WALK_STARTED]]'}">
                                <div class="event-card video-style">
                                    <div class="event-card-content">
                                        <div class="event-icon-circle"><i class="fas fa-running"></i></div>
                                        <div class="event-title">산책 현황</div>
                                        <p class="event-desc">산책이 시작되었습니다.</p>
                                    </div>
                                    <button class="btn-event-action" onclick="location.href='/walkjob/owner'">산책 현황 보기</button>
                                </div>
                            </c:when>
                            <%-- 3. 영상통화 수락 --%>
                            <c:when test="${msg.content eq '[[VIDEO_REQUEST]]'}">
                                <div class="event-card video-style">
                                    <div class="event-card-content">
                                        <div class="event-icon-circle"><i class="fas fa-video"></i></div>
                                        <div class="event-title">영상통화</div>
                                        <p class="event-desc">영상통화를 시작하시겠습니까?</p>
                                    </div>
                                    <button class="btn-event-action" onclick="startVideoCall()">영상통화 시작하기</button>
                                </div>
                            </c:when>
                            <%-- 4. 이력서 도착 --%>
                            <c:when test="${msg.content eq '[[RESUME_SEND]]'}">
                                <div class="event-card resume-style">
                                    <div class="event-card-content">
                                        <div class="event-icon-circle"><i class="fas fa-id-card-alt"></i></div>
                                        <div class="event-title">이력서 도착</div>
                                        <p class="event-desc">상세 내용을 확인해보세요.</p>
                                    </div>
                                    <c:set var="targetName" value="${room.ownerId == user.userId ? room.workerName : room.ownerName}" />
                                    <button class="btn-event-action" onclick="openResumeModal('${targetName}')">상세보기</button>
                                </div>
                            </c:when>
                            <%-- 5. 리포트 도착 --%>
                            <c:when test="${msg.content eq '[[REPORT_SEND]]'}">
                                <div class="event-card report-style">
                                    <div class="event-card-content">
                                        <div class="event-icon-circle"><i class="fas fa-brain"></i></div>
                                        <div class="event-title">AI 분석 리포트</div>
                                        <p class="event-desc">반려동물 종합 분석 리포트</p>
                                    </div>
                                    <button class="btn-event-action" onclick="openReportModal()">상세보기</button>
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

        <div class="input-wrapper">
            <input type="text" id="msgInput" class="chat-input" placeholder="메시지를 입력하세요..." onkeypress="if(event.keyCode==13) sendMessage();">
            <button class="btn-send" onclick="sendMessage()"><i class="fas fa-paper-plane"></i></button>
        </div>
    </div>

    <div id="plusMenu" class="plus-menu">
        <div class="plus-menu-grid">
            <div class="menu-item video-type" onclick="requestVideoCall()">
                <div class="menu-icon-box"><i class="fas fa-video"></i></div>
                <span>영상통화</span>
            </div>
            <div class="menu-item walk-type" onclick="requestWalk()">
                <div class="menu-icon-box"><i class="fas fa-walking"></i></div>
                <span>산책하기</span>
            </div>

            <c:if test="${room.ownerId != user.userId}">
                <div class="menu-item resume-type" onclick="sendResume()">
                    <div class="menu-icon-box"><i class="fas fa-id-card"></i></div>
                    <span>이력서</span>
                </div>
            </c:if>

            <c:if test="${room.ownerId == user.userId}">
                <div class="menu-item report-type" onclick="sendReport()">
                    <div class="menu-icon-box"><i class="fas fa-clipboard-list"></i></div>
                    <span>리포트</span>
                </div>
            </c:if>
        </div>
    </div>
</div>

<div id="videoModal">
    <video id="remoteVideo" autoplay playsinline></video>
    <video id="localVideo" autoplay playsinline muted></video>
    <div class="video-controls">
        <button class="btn-close-video" onclick="endCall()">통화 종료</button>
    </div>
</div>

<div id="resumeModal" class="modal">
    <div class="modal-content">
        <span class="close-modal" onclick="closeModal('resumeModal')">&times;</span>
        <div class="resume-header">
            <div class="resume-avatar"><i class="fas fa-user"></i></div>
            <div class="resume-name" id="modalResumeName">이름 없음</div>
            <div class="event-desc">24세 / 서울시 강남구</div>
        </div>
        <div class="resume-section">
            <h4><i class="fas fa-history"></i> 경력사항</h4>
            <table class="resume-table">
                <tr><td class="resume-label">반려견 산책</td><td>3회</td></tr>
                <tr><td class="resume-label">반려묘 미용</td><td>1회</td></tr>
            </table>
        </div>
        <div class="resume-section">
            <h4><i class="fas fa-comment-dots"></i> 각오 한마디</h4>
            <p style="color: #555; line-height: 1.5;">
                강아지를 너무 좋아해서 시작하게 되었습니다.<br>
                내 가족처럼 책임감 있게, 사랑으로 돌봐드리겠습니다!
            </p>
        </div>
        <button class="modal-footer-btn" style="background:var(--secondary-color);" onclick="closeModal('resumeModal')">닫기</button>
    </div>
</div>

<div id="reportModal" class="modal">
    <div class="modal-content" style="max-width: 600px;">
        <span class="close-modal" onclick="closeModal('reportModal')">&times;</span>
        <div class="resume-header" style="border-bottom: 2px solid #eee;">
            <div class="resume-avatar" style="color: #FF6B6B; background-color: #FFF0F0;">
                <i class="fas fa-brain"></i>
            </div>
            <div class="resume-name" style="font-size: 1.3rem;">AI 종합 분석 리포트</div>
            <div class="event-desc">2025.12.01 - 2025.12.05 주간 분석</div>
        </div>

        <jsp:include page="../common/ai_report_content.jsp" />

        <button class="modal-footer-btn" style="background-color: #845EF7;" onclick="closeModal('reportModal')">닫기</button>
    </div>
</div>

<script>
    var ws;    // 채팅 소켓
    var sigWs; // 시그널링 소켓 (WebRTC용)

    var roomId = "${room.roomId}";
    var myId = "${user.userId}";
    var chatContainer = document.getElementById("chatContainer");

    // [WebRTC 변수]
    var localStream = null;
    var peerConnection = null;
    var candidateQueue = [];

    var peerConnectionConfig = {
        'iceServers': [
            {'urls': 'stun:stun.l.google.com:19302'}
        ]
    };

    // 스크롤 초기화
    chatContainer.scrollTop = chatContainer.scrollHeight;

    window.onload = function() {
        connectChat();   // 채팅 연결
        connectSignal(); // 시그널링 연결
    };

    // 1. 채팅 소켓 연결
    function connectChat() {
        var protocol = location.protocol === 'https:' ? 'wss://' : 'ws://';
        var wsUrl = protocol + location.host + "/ws/chat";

        ws = new WebSocket(wsUrl);
        ws.onopen = function() {
            console.log("Chat Connected!");
            var msg = { roomId: roomId, senderId: myId, content: "ENTER" };
            ws.send(JSON.stringify(msg));
        };
        ws.onmessage = function(event) {
            var data = JSON.parse(event.data);
            if(data.type === "NOTIFICATION" || data.content === "ENTER") return;

            var msgDiv = document.createElement("div");
            var isMine = (data.senderId == myId);

            // --------------------------------------------------
            // [통합된 메시지 처리 로직]
            // --------------------------------------------------

            // 1. 산책 요청
            if (data.content === "[[WALK_REQUEST]]") {
                var btnAttr = isMine ? 'disabled' : 'onclick="startWalk()"';
                var btnText = isMine ? '수락 대기중' : '산책 시작하기';
                var descText = isMine ? '산책 메이트 신청을 보냈습니다.' : '산책 요청이 도착했습니다.';
                msgDiv.innerHTML = createCardHtml('walk-style', 'fa-dog', '산책해요!', descText, btnText, btnAttr);

                // 2. 산책 시작 (리다이렉트)
            } else if (data.content === "[[WALK_STARTED]]") {
                var targetUrl = isMine ? "/walkjob/worker" : "/walkjob/owner"; // 내가 Worker면 Worker페이지로
                msgDiv.innerHTML = createCardHtml('video-style', 'fa-running', '산책 현황', '산책이 시작되었습니다.<br>현황을 확인하세요.', '산책 현황 보기', 'onclick="location.href=\'' + targetUrl + '\'"');

                // 3. 영상통화 요청
            } else if (data.content === "[[VIDEO_REQUEST]]") {
                var btnAttr = isMine ? 'disabled' : 'onclick="startVideoCall()"';
                var btnText = isMine ? '응답 대기중' : '영상통화 시작하기';
                var descText = isMine ? '영상통화를 요청했습니다.' : '영상통화를 시작하시겠습니까?';
                msgDiv.innerHTML = createCardHtml('video-style', 'fa-video', '영상통화', descText, btnText, btnAttr);

                // 4. 이력서 전송
            } else if (data.content === "[[RESUME_SEND]]") {
                var btnAttr = isMine ? 'disabled' : 'onclick="openResumeModal(\'상대방\')"';
                var btnText = isMine ? '전송됨' : '상세보기';
                var descText = isMine ? '나의 이력서를 전송했습니다.' : '이력서가 도착했습니다.';
                msgDiv.innerHTML = createCardHtml('resume-style', 'fa-id-card-alt', '이력서', descText, btnText, btnAttr);

                // 5. 리포트 전송
            } else if (data.content === "[[REPORT_SEND]]") {
                var btnAttr = isMine ? 'disabled' : 'onclick="openReportModal()"';
                var btnText = isMine ? '전송됨' : '상세보기';
                var descText = isMine ? 'AI 종합 분석 리포트' : '반려동물 종합 분석 리포트가 도착했습니다.';
                msgDiv.innerHTML = createCardHtml('report-style', 'fa-brain', 'AI 분석 리포트', descText, btnText, btnAttr);

                // 6. 일반 메시지
            } else {
                msgDiv.innerHTML = '<div class="msg-bubble">' + data.content + '</div>';
            }

            msgDiv.className = isMine ? "message-box my-msg" : "message-box other-msg";
            chatContainer.appendChild(msgDiv);
            chatContainer.scrollTop = chatContainer.scrollHeight;
        };
    }

    // 카드 HTML 생성 헬퍼 함수
    function createCardHtml(styleClass, iconClass, title, desc, btnText, btnAttr) {
        return '<div class="event-card ' + styleClass + '">' +
            '<div class="event-card-content">' +
            '<div class="event-icon-circle"><i class="fas ' + iconClass + '"></i></div>' +
            '<div class="event-title">' + title + '</div>' +
            '<p class="event-desc">' + desc + '</p>' +
            '</div>' +
            '<button class="btn-event-action" ' + btnAttr + '>' + btnText + '</button>' +
            '</div>';
    }

    // 2. 시그널링 소켓 연결 (WebRTC)
    function connectSignal() {
        var protocol = location.protocol === 'https:' ? 'wss://' : 'ws://';
        var sigUrl = protocol + location.host + "/signal";
        sigWs = new WebSocket(sigUrl);

        sigWs.onopen = function() { console.log("Signaling Server Connected"); };

        sigWs.onmessage = function(event) {
            var message = JSON.parse(event.data);
            if(message.roomId && message.roomId !== roomId) return;
            if(message.senderId === myId) return;
            handleSignalMessage(message);
        };
    }

    // [WebRTC 시그널링 핸들러]
    async function handleSignalMessage(message) {
        try {
            if (message.type === 'offer') {
                if (!localStream) {
                    localStream = await navigator.mediaDevices.getUserMedia({ video: true, audio: true });
                    document.getElementById('localVideo').srcObject = localStream;
                    document.getElementById('videoModal').style.display = 'flex';
                }
                createPeerConnection();
                await peerConnection.setRemoteDescription(new RTCSessionDescription(message.sdp));
                processCandidateQueue();
                var answer = await peerConnection.createAnswer();
                await peerConnection.setLocalDescription(answer);
                sendSignal({ type: 'answer', sdp: answer, roomId: roomId, senderId: myId });

            } else if (message.type === 'answer') {
                if(peerConnection) {
                    await peerConnection.setRemoteDescription(new RTCSessionDescription(message.sdp));
                    processCandidateQueue();
                }

            } else if (message.type === 'candidate') {
                if (peerConnection && peerConnection.remoteDescription) {
                    await peerConnection.addIceCandidate(new RTCIceCandidate(message.candidate));
                } else {
                    candidateQueue.push(message.candidate);
                }
            }
        } catch (e) { console.error("Signal Handling Error:", e); }
    }

    async function processCandidateQueue() {
        while (candidateQueue.length > 0) {
            var candidate = candidateQueue.shift();
            if(peerConnection) await peerConnection.addIceCandidate(new RTCIceCandidate(candidate));
        }
    }

    function createPeerConnection() {
        if(peerConnection) return;
        peerConnection = new RTCPeerConnection(peerConnectionConfig);
        peerConnection.onicecandidate = function(event) {
            if (event.candidate) {
                sendSignal({ type: 'candidate', candidate: event.candidate, roomId: roomId, senderId: myId });
            }
        };
        peerConnection.ontrack = function(event) {
            var remoteVideo = document.getElementById('remoteVideo');
            if (remoteVideo.srcObject !== event.streams[0]) remoteVideo.srcObject = event.streams[0];
        };
        if(localStream) localStream.getTracks().forEach(track => peerConnection.addTrack(track, localStream));
    }

    function sendSignal(data) {
        if(sigWs && sigWs.readyState === WebSocket.OPEN) sigWs.send(JSON.stringify(data));
    }

    // -------------------------
    // UI 이벤트 핸들러
    // -------------------------

    function sendMessage() {
        var input = document.getElementById("msgInput");
        var text = input.value;
        if(!text.trim()) return;
        ws.send(JSON.stringify({ roomId: roomId, senderId: myId, content: text }));
        input.value = "";
    }

    function togglePlusMenu() {
        var menu = document.getElementById("plusMenu");
        var btn = document.getElementById("plusBtn");
        if (menu.style.display === "block") {
            menu.style.display = "none";
            btn.classList.remove("active");
        } else {
            menu.style.display = "block";
            btn.classList.add("active");
            chatContainer.scrollTop = chatContainer.scrollHeight;
        }
    }

    function requestVideoCall() {
        togglePlusMenu();
        ws.send(JSON.stringify({ roomId: roomId, senderId: myId, content: "[[VIDEO_REQUEST]]" }));
    }

    function requestWalk() {
        togglePlusMenu();
        ws.send(JSON.stringify({ roomId: roomId, senderId: myId, content: "[[WALK_REQUEST]]" }));
    }

    function sendResume() {
        togglePlusMenu();
        ws.send(JSON.stringify({ roomId: roomId, senderId: myId, content: "[[RESUME_SEND]]" }));
    }

    function sendReport() {
        togglePlusMenu();
        ws.send(JSON.stringify({ roomId: roomId, senderId: myId, content: "[[REPORT_SEND]]" }));
    }

    function startWalk() {
        if(!confirm("산책을 시작하시겠습니까?")) return;
        ws.send(JSON.stringify({ roomId: roomId, senderId: myId, content: "[[WALK_STARTED]]" }));
    }

    async function startVideoCall() {
        if(!confirm("영상통화를 연결하시겠습니까?")) return;
        document.getElementById('videoModal').style.display = 'flex';
        try {
            localStream = await navigator.mediaDevices.getUserMedia({ video: true, audio: true });
            document.getElementById('localVideo').srcObject = localStream;
            createPeerConnection();
            var offer = await peerConnection.createOffer();
            await peerConnection.setLocalDescription(offer);
            sendSignal({ type: 'offer', sdp: offer, roomId: roomId, senderId: myId });
        } catch(e) {
            console.error("Camera Error:", e);
            alert("카메라 권한이 필요합니다.");
            document.getElementById('videoModal').style.display = 'none';
        }
    }

    function endCall() {
        document.getElementById('videoModal').style.display = 'none';
        if(peerConnection) { peerConnection.close(); peerConnection = null; }
        if(localStream) { localStream.getTracks().forEach(track => track.stop()); localStream = null; }
        candidateQueue = [];
        location.reload();
    }

    // 모달 제어
    function openResumeModal(name) {
        document.getElementById('modalResumeName').innerText = name || "이름 없음";
        document.getElementById('resumeModal').style.display = 'block';
    }

    function openReportModal() {
        document.getElementById('reportModal').style.display = 'block';
    }

    function closeModal(modalId) {
        document.getElementById(modalId).style.display = 'none';
    }

    // 모달 배경 클릭 시 닫기
    window.onclick = function(event) {
        if (event.target.className === 'modal') {
            event.target.style.display = "none";
        }
    }
</script>