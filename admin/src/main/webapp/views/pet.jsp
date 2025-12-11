<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<h2>${user.name} 님의 반려동물 정보</h2>

<table border="1" width="100%">
    <tr>
        <th>펫 ID</th>
        <th>이름</th>
        <th>타입</th>
        <th>품종</th>
        <th>성별</th>
        <th>나이</th>
        <th>몸무게</th>
        <th>사진</th>
    </tr>

    <c:forEach items="${pets}" var="p">
        <tr>
            <td>${p.petId}</td>
            <td>${p.name}</td>
            <td>${p.type}</td>
            <td>${p.breed}</td>
            <td>${p.gender}</td>
            <td>${p.age}</td>
            <td>${p.weight}</td>
            <td>
                <c:if test="${not empty p.photo}">
                    <img src="${p.photo}" width="80" height="80">
                </c:if>
            </td>
        </tr>
    </c:forEach>
</table>
