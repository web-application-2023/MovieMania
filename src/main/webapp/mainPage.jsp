<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="css/mainPage.css">
</head>
<body>
<div class="container">
    <div class="header">Movie Mania</div>
    <div>
        <c:forEach items="${movies}" var="movie">
            <div class="movie-info">
                <div class="movie-title">${movie.title}</div>
                <div class="movie-detail">장르: ${movie.genre.name}</div>
                <div class="movie-detail">개봉일: ${movie.releaseDate}</div>
                <div class="movie-detail">상영 종료일: ${movie.endDate}</div>
                <div class="movie-detail">상영 중 여부: ${movie.showing ? 'O' : 'X'}</div>
                <div class="movie-detail">등록일: ${movie.registrationDate}</div>
            </div>
        </c:forEach>
    </div>
    <div class="pagination">
        <div class="pagination-link">
            <c:if test="${currentPage > 1}">
                <a href="?page=${currentPage - 1}&pageSize=${pageSize}">이전 페이지</a>
            </c:if>
            <c:if test="${currentPage <= 1}">
                <span class="empty-space"></span>
            </c:if>
        </div>
        <span>${currentPage}</span>
        <div class="pagination-link">
            <c:if test="${currentPage < totalPages}">
                <a href="?page=${currentPage + 1}&pageSize=${pageSize}">다음 페이지</a>
            </c:if>
            <c:if test="${currentPage >= totalPages}">
                <span class="empty-space"></span>
            </c:if>
        </div>
    </div>

</div>
</body>
</html>
