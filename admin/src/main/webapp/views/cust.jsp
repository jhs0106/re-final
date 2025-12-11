<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<h2>사용자 목록</h2>

<table border="1" width="100%">
    <tr>
        <th>ID</th>
        <th>아이디</th>
        <th>이름</th>
        <th>이메일</th>
        <th>전화번호</th>
        <th>반려동물보기</th>
    </tr>

    <c:forEach items="${users}" var="u">
        <tr>
            <td>${u.userId}</td>
            <td>${u.username}</td>
            <td>${u.name}</td>
            <td>${u.email}</td>
            <td>${u.phone}</td>
            <td>
                <a href="/admin/pet?userId=${u.userId}">반려동물 보기</a>
            </td>
        </tr>
    </c:forEach>
</table>
