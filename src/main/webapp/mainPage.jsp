<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="css/mainPage.css">
</head>
<body>
<div class="container">
    <div class="header">
        <h2>&#127902; Movie Mania</h2>
        <div class="header-buttons">
            <c:choose>
                <c:when test="${isLogin}">
                    <a href="/logout" onclick="logout()" class="button">&#128682; 로그아웃</a>
                    <script>
                      function logout() {
                        fetch('/logout', { method: 'GET' })
                        .then(response => {
                          alert("로그아웃에 성공했습니다.");
                          window.location.href = '/main';
                        })
                        .catch(error => console.error('Error:', error));
                      }
                    </script>
                    <a href="/register" class="button">&#127902; 영화 등록하기</a>
                </c:when>
                <c:otherwise>
                    <a href="/login" class="button">&#128273; 로그인</a>
                    <a href="/signup" class="button">&#128100; 회원가입</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- 영화 목록 섹션 제목 -->
    <div class="section-title">
        <h3>&#127909; 영화 목록</h3>
    </div>

    <c:forEach items="${movies}" var="movie">
        <div class="movie-info">
            <div>
                <div class="movie-title">&#127909; ${movie.title}</div>
                <div class="movie-detail">&#127902; 장르: ${movie.genre.name}</div>
                <div class="movie-detail">&#128197; 개봉일: ${movie.releaseDate}</div>
                <div class="movie-detail">&#128197; 상영 종료일: ${movie.endDate}</div>
                <div class="movie-detail">&#9989; 상영 중 여부: ${movie.showing ? 'O' : 'X'}</div>
                <div class="movie-detail">&#128198; 등록일: ${movie.registrationDate}</div>
            </div>
            <a href="/info?movie_id=${movie.id}" class="detail-button">&#128270; 상세보기</a>
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
