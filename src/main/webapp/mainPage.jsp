<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <style>
      body {
        font-family: 'Arial', sans-serif;
        background-color: #f4f4f4;
        color: #333;
        line-height: 1.6;
        margin: 0;
        padding: 0;
      }
      .container {
        width: 80%;
        margin: auto;
        overflow: hidden;
      }
      .header {
        background-color: #333;
        color: white;
        padding: 10px 0;
        text-align: center;
        font-size: 24px;
        font-weight: bold;
        margin-bottom: 20px;
      }
      .movie-info {
        border-bottom: 1px solid #ddd;
        margin-bottom: 10px;
        background: #fff;
        padding: 10px;
        box-shadow: 0 5px 10px rgba(0, 0, 0, 0.1);
      }
      .movie-info:last-child {
        border-bottom: none;
      }
      .movie-title {
        font-size: 18px;
        font-weight: bold;
      }
      .movie-detail {
        font-size: 14px;
        color: #666;
      }
      /*.pagination {*/
      /*  display: flex;*/
      /*  justify-content: space-between; !* 각 요소를 양 끝과 중앙에 배치 *!*/
      /*  align-items: center; !* 세로축에서 중앙 정렬 *!*/
      /*  margin-top: 20px;*/
      /*  font-size: 16px;*/
      /*}*/
      .pagination {
        display: flex;
        justify-content: center;
        align-items: center;
        margin-top: 20px;
        font-size: 16px;
      }
      .pagination a, .pagination span {
        margin: 0 10px;
        padding: 8px 15px;
        border-radius: 5px;
      }
      .pagination a {
        background-color: #4CAF50;
        color: white;
        text-decoration: none;
      }
      .pagination a:hover {
        background-color: #45a049;
      }
      .pagination span {
        background-color: #f2f2f2;
        border: 1px solid #ddd;
        flex-grow: 1; /* 유연한 성장을 통해 공간 채우기 */
        text-align: center;
      }
      .pagination-link, .empty-space {
        min-width: 100px; /* 이전/다음 링크와 빈 공간의 최소 너비 */
      }
      .empty-space {
        display: inline-block; /* 빈 공간을 위한 블록 */
      }
    </style>
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
