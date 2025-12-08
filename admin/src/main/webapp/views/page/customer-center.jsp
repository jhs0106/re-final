<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="pd-ltr-20 xs-pd-20-10">
    <div class="min-height-200px">
        <div class="page-header">
            <div class="row">
                <div class="col-md-6 col-sm-12">
                    <div class="title">
                        <h4>고객센터 관리</h4>
                    </div>
                    <nav aria-label="breadcrumb" role="navigation">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="/index">Home</a></li>
                            <li class="breadcrumb-item active" aria-current="page">고객센터</li>
                        </ol>
                    </nav>
                </div>
            </div>
        </div>

        <div class="card-box mb-30">
            <div class="pd-20">
                <h4 class="text-blue h4">1:1 문의 내역</h4>
            </div>
            <div class="pb-20">
                <table class="data-table table stripe hover nowrap">
                    <thead>
                    <tr>
                        <th class="table-plus datatable-nosort">번호</th>
                        <th>제목</th>
                        <th>작성자</th>
                        <th>등록일</th>
                        <th>상태</th>
                        <th class="datatable-nosort">관리</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:choose>
                        <c:when test="${empty inquiries}">
                            <tr>
                                <td colspan="6" class="text-center text-muted">등록된 문의가 없습니다.</td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="inquiry" items="${inquiries}">
                                <tr>
                                    <td class="table-plus">${inquiry.id}</td>
                                    <td>${inquiry.title}</td>
                                    <td>${inquiry.username}</td>
                                    <td>${inquiry.formattedCreatedAt}</td>
                                    <td><span class="badge ${inquiry.statusBadge}">${inquiry.statusLabel}</span></td>
                                    <td>
                                        <a class="btn btn-sm btn-primary" href="/admin/customer/detail?id=${inquiry.id}"><i class="dw dw-eye"></i> 상세보기</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
