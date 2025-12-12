<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>

<html>

<head>
	<meta charset="utf-8" />
	<title>Pat n Pet</title>


	<link
			rel="apple-touch-icon"
			sizes="180x180"
			href="/vendors/images/apple-touch-icon.png"
	/>
	<link
			rel="icon"
			type="image/png"
			sizes="32x32"
			href="/vendors/images/favicon-32x32.png"
	/>
	<link
			rel="icon"
			type="image/png"
			sizes="16x16"
			href="/vendors/images/favicon-16x16.png"
	/>

	<meta
			name="viewport"
			content="width=device-width, initial-scale=1, maximum-scale=1"
	/>

	<link
			href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap"
			rel="stylesheet"
	/>
	<link rel="stylesheet" type="text/css" href="/vendors/styles/core.css" />
	<link
			rel="stylesheet"
			type="text/css"
			href="/vendors/styles/icon-font.min.css"
	/>
	<link
			rel="stylesheet"
			type="text/css"
			href="/src/plugins/datatables/css/dataTables.bootstrap4.min.css"
	/>
	<link
			rel="stylesheet"
			type="text/css"
			href="/src/plugins/datatables/css/responsive.bootstrap4.min.css"
	/>
	<link rel="stylesheet" type="text/css" href="/vendors/styles/style.css" />
	<link rel="stylesheet" type="text/css" href="/vendors/styles/custom.css" />

	<script
			async
			src="https://www.googletagmanager.com/gtag/js?id=G-GBZ3SGGX85"
	></script>
	<script
			async
			src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=ca-pub-2973766580778258"
			crossorigin="anonymous"
	></script>
	<!-- Kakao Map SDK55e3779d3a4e94654971764756e0a939 -->
	<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=SDK55e3779d3a4e94654971764756e0a939&libraries=services&autoload=false"></script>

	<script>
		window.dataLayer = window.dataLayer || [];
		function gtag() {
			dataLayer.push(arguments);
		}
		gtag("js", new Date());

		gtag("config", "G-GBZ3SGGX85");
	</script>
	<script>
		(function (w, d, s, l, i) {
			w[l] = w[l] || [];
			w[l].push({ "gtm.start": new Date().getTime(), event: "gtm.js" });
			var f = d.getElementsByTagName(s)[0],
					j = d.createElement(s),
					dl = l != "dataLayer" ? "&l=" + l : "";
			j.async = true;
			j.src = "https://www.googletagmanager.com/gtm.js?id=" + i + dl;
			f.parentNode.insertBefore(j, f);
		})(window, document, "script", "dataLayer", "GTM-NXZMQSS");
	</script>
</head>
<body>

<%--	Top var Start--%>
<div class="header">
	<div class="header-left">
		<div class="menu-icon bi bi-list"></div>
		<div
				class="search-toggle-icon bi bi-search"
				data-toggle="header_search"
		></div>
		<div class="header-search">
			<form>
				<div class="form-group mb-0">
					<i class="dw dw-search2 search-icon"></i>
					<input
							type="text"
							class="form-control search-input"
							placeholder="Search Here"
					/>
					<div class="dropdown">
						<a
								class="dropdown-toggle no-arrow"
								href="#"
								role="button"
								data-toggle="dropdown"
						>
							<i class="ion-arrow-down-c"></i>
						</a>
						<div class="dropdown-menu dropdown-menu-right">
							<div class="form-group row">
								<label class="col-sm-12 col-md-2 col-form-label"
								>From</label
								>
								<div class="col-sm-12 col-md-10">
									<input
											class="form-control form-control-sm form-control-line"
											type="text"
									/>
								</div>
							</div>
							<div class="form-group row">
								<label class="col-sm-12 col-md-2 col-form-label">To</label>
								<div class="col-sm-12 col-md-10">
									<input
											class="form-control form-control-sm form-control-line"
											type="text"
									/>
								</div>
							</div>
							<div class="form-group row">
								<label class="col-sm-12 col-md-2 col-form-label"
								>Subject</label
								>
								<div class="col-sm-12 col-md-10">
									<input
											class="form-control form-control-sm form-control-line"
											type="text"
									/>
								</div>
							</div>
							<div class="text-right">
								<button class="btn btn-primary">Search</button>
							</div>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
	<div class="header-right">
		<div class="dashboard-setting user-notification">
			<div class="dropdown">
				<a
						class="dropdown-toggle no-arrow"
						href="javascript:;"
						data-toggle="right-sidebar"
				>
					<i class="dw dw-settings2"></i>
				</a>
			</div>
		</div>
		<div class="user-notification">
			<div class="dropdown">
				<a
						class="dropdown-toggle no-arrow"
						href="#"
						role="button"
						data-toggle="dropdown"
				>
					<i class="icon-copy dw dw-notification"></i>
					<span class="badge notification-active"></span>
				</a>
				<div class="dropdown-menu dropdown-menu-right">
				</div>
			</div>
		</div>
		<%-- 예: header 오른쪽 영역에 넣기 --%>
		<c:choose>
			<%-- 로그인된 상태 --%>
			<c:when test="${not empty sessionScope.adminId}">
				<div class="admin-login-box" style="padding-top: 20px;">
            <span class="user-name">
                ${sessionScope.adminName != null ? sessionScope.adminName : sessionScope.adminId} 님
            </span>
					&nbsp;|&nbsp;
					<a href="<c:url value='/admin/mypage'/>">Super</a>
					&nbsp;|&nbsp;
					<a href="<c:url value='/admin/logout'/>">Logout</a>
				</div>
			</c:when>

			<%-- 비로그인 상태 --%>
			<c:otherwise>
				<div class="admin-login-box" style="padding-top: 20px;">
					<a href="<c:url value='/admin/login'/>">Login</a>
				</div>
			</c:otherwise>
		</c:choose>
		</div>
	</div>
</div>
<%-- 	Top Var End--%>
<div class="right-sidebar">
	<div class="sidebar-title">
		<h3 class="weight-600 font-16 text-blue">
			Layout Settings
			<span class="btn-block font-weight-400 font-12"
			>User Interface Settings</span
			>
		</h3>
		<div class="close-sidebar" data-toggle="right-sidebar-close">
			<i class="icon-copy ion-close-round"></i>
		</div>
	</div>
	<div class="right-sidebar-body customscroll">
		<div class="right-sidebar-body-content">
			<h4 class="weight-600 font-18 pb-10">Header Background</h4>
			<div class="sidebar-btn-group pb-30 mb-10">
				<a
						href="javascript:void(0);"
						class="btn btn-outline-primary header-white active"
				>White</a
				>
				<a
						href="javascript:void(0);"
						class="btn btn-outline-primary header-dark"
				>Dark</a
				>
			</div>

			<h4 class="weight-600 font-18 pb-10">Sidebar Background</h4>
			<div class="sidebar-btn-group pb-30 mb-10">
				<a
						href="javascript:void(0);"
						class="btn btn-outline-primary sidebar-light"
				>White</a
				>
				<a
						href="javascript:void(0);"
						class="btn btn-outline-primary sidebar-dark active"
				>Dark</a
				>
			</div>

			<h4 class="weight-600 font-18 pb-10">Menu Dropdown Icon</h4>
			<div class="sidebar-radio-group pb-10 mb-10">
				<div class="custom-control custom-radio custom-control-inline">
					<input
							type="radio"
							id="sidebaricon-1"
							name="menu-dropdown-icon"
							class="custom-control-input"
							value="icon-style-1"
							checked=""
					/>
					<label class="custom-control-label" for="sidebaricon-1"
					><i class="fa fa-angle-down"></i
					></label>
				</div>
				<div class="custom-control custom-radio custom-control-inline">
					<input
							type="radio"
							id="sidebaricon-2"
							name="menu-dropdown-icon"
							class="custom-control-input"
							value="icon-style-2"
					/>
					<label class="custom-control-label" for="sidebaricon-2"
					><i class="ion-plus-round"></i
					></label>
				</div>
				<div class="custom-control custom-radio custom-control-inline">
					<input
							type="radio"
							id="sidebaricon-3"
							name="menu-dropdown-icon"
							class="custom-control-input"
							value="icon-style-3"
					/>
					<label class="custom-control-label" for="sidebaricon-3"
					><i class="fa fa-angle-double-right"></i
					></label>
				</div>
			</div>

			<h4 class="weight-600 font-18 pb-10">Menu List Icon</h4>
			<div class="sidebar-radio-group pb-30 mb-10">
				<div class="custom-control custom-radio custom-control-inline">
					<input
							type="radio"
							id="sidebariconlist-1"
							name="menu-list-icon"
							class="custom-control-input"
							value="icon-list-style-1"
							checked=""
					/>
					<label class="custom-control-label" for="sidebariconlist-1"
					><i class="ion-minus-round"></i
					></label>
				</div>
				<div class="custom-control custom-radio custom-control-inline">
					<input
							type="radio"
							id="sidebariconlist-2"
							name="menu-list-icon"
							class="custom-control-input"
							value="icon-list-style-2"
					/>
					<label class="custom-control-label" for="sidebariconlist-2"
					><i class="fa fa-circle-o" aria-hidden="true"></i
					></label>
				</div>
				<div class="custom-control custom-radio custom-control-inline">
					<input
							type="radio"
							id="sidebariconlist-3"
							name="menu-list-icon"
							class="custom-control-input"
							value="icon-list-style-3"
					/>
					<label class="custom-control-label" for="sidebariconlist-3"
					><i class="dw dw-check"></i
					></label>
				</div>
				<div class="custom-control custom-radio custom-control-inline">
					<input
							type="radio"
							id="sidebariconlist-4"
							name="menu-list-icon"
							class="custom-control-input"
							value="icon-list-style-4"
							checked=""
					/>
					<label class="custom-control-label" for="sidebariconlist-4"
					><i class="icon-copy dw dw-next-2"></i
					></label>
				</div>
				<div class="custom-control custom-radio custom-control-inline">
					<input
							type="radio"
							id="sidebariconlist-5"
							name="menu-list-icon"
							class="custom-control-input"
							value="icon-list-style-5"
					/>
					<label class="custom-control-label" for="sidebariconlist-5"
					><i class="dw dw-fast-forward-1"></i
					></label>
				</div>
				<div class="custom-control custom-radio custom-control-inline">
					<input
							type="radio"
							id="sidebariconlist-6"
							name="menu-list-icon"
							class="custom-control-input"
							value="icon-list-style-6"
					/>
					<label class="custom-control-label" for="sidebariconlist-6"
					><i class="dw dw-next"></i
					></label>
				</div>
			</div>

			<div class="reset-options pt-30 text-center">
				<button class="btn btn-danger" id="reset-settings">
					Reset Settings
				</button>
			</div>
		</div>
	</div>
</div>
<%--left var start--%>
<div class="left-side-bar">
	<a href="/">
		<img src="/src/images/petlogo.png"
			 alt="로고"
			 style="display:block;width:80px;max-width:80%;height:auto;margin:16px auto 12px;object-fit:contain;">

		<div class="close-sidebar" data-toggle="left-sidebar-close">
			<i class="ion-close-round"></i>
		</div>
	</a>

	<div class="menu-block customscroll">
		<div class="sidebar-menu">
			<ul id="accordion-menu">
				<hr>
				<br>
				<li class="dropdown">
					<a href="/admin/cust" class="dropdown-toggle no-arrow">
								<span class="micon bi bi-textarea-resize"></span
								><span class="mtext">고객 확인</span>
					</a>
				</li>
				<br>
				<li class="dropdown">
					<a href="/admin/pet" class="dropdown-toggle no-arrow">
								<span class="micon bi bi-textarea-resize"></span
								><span class="mtext">반려동물 확인</span>
					</a>
				</li>
				<br>
				<%-- 고객 센터 메뉴 수정 부분 --%>
				<li>
					<a href="<c:url value='/admin/customer'/>" class="dropdown-toggle no-arrow">
						<span class="micon bi bi-headset"></span><span class="mtext">고객센터 관리</span>
					</a>
				</li>
				<%-- // 고객 센터 메뉴 수정 부분 끝 --%>

				<li>
					<div class="sidebar-small-cap"></div>
				</li>
			</ul>
		</div>

	</div>
</div>
<%--left var end--%>
<div class="mobile-menu-overlay"></div>
<%--center start--%>
<c:choose>
	<c:when test="${center == null}">
		<jsp:include page="center.jsp"/>
	</c:when>
	<c:otherwise>
		<jsp:include page="${center}.jsp"/>
	</c:otherwise>
</c:choose>

<%--center end--%>

<script src="/vendors/scripts/core.js"></script>
<script src="/vendors/scripts/script.min.js"></script>
<script src="/vendors/scripts/process.js"></script>
<script src="/vendors/scripts/layout-settings.js"></script>
<script src="/src/plugins/apexcharts/apexcharts.min.js"></script>
<script src="/src/plugins/datatables/js/jquery.dataTables.min.js"></script>
<script src="/src/plugins/datatables/js/dataTables.bootstrap4.min.js"></script>
<script src="/src/plugins/datatables/js/dataTables.responsive.min.js"></script>
<script src="/src/plugins/datatables/js/responsive.bootstrap4.min.js"></script>
<%--<script src="/vendors/scripts/dashboard3.js"></script>--%>
<noscript
><iframe
		src="https://www.googletagmanager.com/ns.html?id=GTM-NXZMQSS"
		height="0"
		width="0"
		style="display: none;
visibility: hidden"
></iframe
></noscript>
</body>
</html>