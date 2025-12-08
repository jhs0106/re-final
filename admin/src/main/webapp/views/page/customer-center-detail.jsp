<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="pd-ltr-20 xs-pd-20-10">
    <div class="min-height-200px">
        <div class="page-header">
            <div class="row">
                <div class="col-md-6 col-sm-12">
                    <div class="title">
                        <h4>문의 상세</h4>
                    </div>
                    <nav aria-label="breadcrumb" role="navigation">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="/index">Home</a></li>
                            <li class="breadcrumb-item"><a href="/admin/customer">고객센터</a></li>
                            <li class="breadcrumb-item active" aria-current="page">문의 상세</li>
                        </ol>
                    </nav>
                </div>
            </div>
        </div>

        <div class="card-box mb-30">
            <div class="pd-20">
                <div class="row">
                    <div class="col-md-8">
                        <h4 class="text-blue h4">${inquiry.title}</h4>
                        <p class="mb-1">작성자: <strong>${inquiry.username}</strong></p>
                        <p class="mb-1">문의 유형: <strong>${inquiry.category}</strong></p>
                        <p class="mb-1">등록일: <strong>${inquiry.formattedCreatedAt}</strong></p>
                        <p class="mb-1">상태: <span class="badge ${inquiry.statusBadge}">${inquiry.statusLabel}</span></p>
                    </div>
                    <div class="col-md-4 text-right">
                        <a class="btn btn-outline-secondary" href="/admin/customer">목록으로</a>
                    </div>
                </div>
            </div>
            <div class="pb-20">
                <div class="p-4">
                    <h5 class="mb-3">문의 내용</h5>
                    <div class="border rounded p-3 bg-light">${inquiry.content}</div>
                </div>
                <div class="p-4">
                    <h5 class="mb-3">답변</h5>
                    <c:if test="${not empty message}">
                        <div class="alert alert-success">${message}</div>
                    </c:if>
                    <c:choose>
                        <c:when test="${not empty inquiry.answer}">
                            <div class="border rounded p-3 mb-2">${inquiry.answer}</div>
                            <p class="text-muted mb-0">답변자: ${inquiry.responder} · 답변일: ${inquiry.formattedAnsweredAt}</p>
                        </c:when>
                        <c:otherwise>
                            <form action="/admin/customer/answer" method="post">
                                <input type="hidden" name="id" value="${inquiry.id}" />
                                <div class="form-group">
                                    <label for="responder">답변자</label>
                                    <input type="text" class="form-control" id="responder" name="responder" placeholder="관리자" value="관리자" />
                                </div>
                                <div class="form-group">
                                    <label for="answer">답변 내용</label>
                                    <textarea class="form-control" id="answer" name="answer" rows="5" required></textarea>
                                </div>
                                <button type="submit" class="btn btn-primary">답변 등록</button>
                            </form>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
</div>
