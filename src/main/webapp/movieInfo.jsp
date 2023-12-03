<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <style>
      body {
        font-family: 'Arial', sans-serif;
        background-color: #f8f9fa;
        color: #495057;
        line-height: 1.6;
        margin: 0 auto;
        padding: 0;
        text-align: center;
        width: 80%;
      }

      h1, h2, h3 {
        color: #343a40;
      }

      /* 영화 정보 출력 스타일 */
      .movie-info {
        background-color: #ffffff;
        padding: 20px;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        margin-bottom: 20px;
        border-radius: 10px;
      }

      /* 리뷰 목록 스타일 */
      h2 {
        margin-bottom: 20px;
        color: #343a40;
      }
      .header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        background-color: #333;
        margin: 0 auto;
        height: 100px;
      }

      .header > .left, .header > .right {
        flex: 2;
        text-align: left; /* 왼쪽 부분은 왼쪽 정렬 */
      }

      .header > h2 {
        flex: 3; /* 중앙 부분을 더 넓게 설정 */
        font-size: 32px;
        color: white;
        margin: 0;
        text-align: center;
        font-weight: bold;
      }

      .header > .right {
        text-align: right; /* 오른쪽 부분은 오른쪽 정렬 */
      }

      .header > .left > a {
        font-size: 32px;
        color: white;
        text-decoration: none;
        margin-left: 20px;
        font-weight: bold;
      }


      p {
        margin: 10px 0;
      }

      ul {
        list-style: none;
        padding: 0;
      }

      li {
        margin-bottom: 20px;
        border-bottom: 1px solid #dee2e6;
        padding-bottom: 15px;
      }

      .pagination {
        display: flex;
        justify-content: center;
        align-items: center;
        margin-top: 20px;
        font-size: 16px;
      }

      .pagination a, .pagination span {
        margin: 0 10px;
        padding: 10px 20px;
        border-radius: 5px;
        cursor: pointer;
      }

      .pagination a {
        background-color: #007bff;
        color: #ffffff;
        text-decoration: none;
        transition: background-color 0.3s;
      }

      .pagination a:hover {
        background-color: #0056b3;
      }

      .pagination span {
        background-color: #f2f2f2;
        border: 1px solid #dee2e6;
        flex-grow: 1;
        text-align: center;
      }

      .pagination-link, .empty-space {
        min-width: 100px;
      }

      .empty-space {
        display: inline-block;
      }

      /* 리뷰 등록 폼 스타일 */
      form {
        max-width: 500px;
        margin: 0 auto;
        background-color: #ffffff;
        padding: 20px;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        border-radius: 10px;
        text-align: left;
      }

      label {
        display: block;
        margin-bottom: 10px;
        font-weight: bold;
        color: #343a40;
      }

      input, textarea {
        width: 100%;
        padding: 10px;
        margin-bottom: 15px;
        box-sizing: border-box;
        border: 1px solid #ced4da;
        border-radius: 5px;
      }

      button {
        background-color: #28a745;
        color: #ffffff;
        padding: 15px 20px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        transition: background-color 0.3s;
      }

      button:hover {
        background-color: #218838;
      }
    </style>
</head>


<body>

<div class="header">
    <div class="left">
        <a href="/main">Movie Mania</a>
    </div>
    <h2>${movie.title}</h2>
    <div class="right"></div>
</div>


<!-- 영화 정보 출력 -->
<div class="movie-info">
    <p><strong>제목:</strong> ${movie.title}</p>
    <p><strong>장르:</strong> ${movie.genre}</p>
    <p><strong>상영 여부:</strong> ${movie.showing ? '상영 중' : '상영 종료'}</p>
    <p><strong>개봉일:</strong> ${movie.releaseDate}</p>
    <p><strong>종료일:</strong> ${movie.endDate}</p>
    <p><strong>등록일:</strong> ${movie.registrationDate}</p>
    <p><strong>등록 회원:</strong> ${movie.member.name}</p>
</div>


<!-- 여기에 리뷰 작성 폼을 추가할 수 있습니다. -->
<!-- 리뷰 등록 폼 -->
<h3>리뷰 등록</h3>

<!-- action을 원하는 URL로 변경 -->
<form action="/review" method="post">
    <!-- 나머지 폼 요소들은 그대로 유지 -->
    <input type="hidden" id="movie_id" name="movie_id" value="${movie.id}">
    <label for="content">리뷰 내용:</label>
    <textarea name="content" id="content" required></textarea><br>
    <label for="rating">평점:</label>
    <input type="number" name="rating" id="rating" min="0" max="10" step="0.1" required><br>
    <button type="submit" value="리뷰 등록">Register Review</button>
</form>

<!-- 리뷰 출력 -->
<h2>리뷰 목록</h2>
<c:if test="${not empty reviews}">
    <ul>
        <c:forEach var="reviews" items="${reviews}">
            <li>
<%--                <p><strong>작성자:</strong> ${review.author}</p>--%>
                <p><strong>평점:</strong> ${reviews.rating}</p>
                <p><strong>내용:</strong> ${reviews.content}</p>
                <p><strong>작성자:</strong> ${reviews.member.name}</p>
            </li>
        </c:forEach>
    </ul>
    <div class="pagination">
        <div class="pagination-link">
            <c:if test="${currentPage > 1}">
                <a href="?movie_id=${movie.id}&page=${currentPage - 1}&pageSize=${pageSize}">이전 페이지</a>
            </c:if>
            <c:if test="${currentPage <= 1}">
                <span class="empty-space"></span>
            </c:if>
        </div>
        <span>${currentPage}</span>
        <div class="pagination-link">
            <c:if test="${currentPage < totalPages}">
                <a href="?movie_id=${movie.id}&page=${currentPage + 1}&pageSize=${pageSize}">다음 페이지</a>
            </c:if>
            <c:if test="${currentPage >= totalPages}">
                <span class="empty-space"></span>
            </c:if>
        </div>
    </div>
</c:if>
<c:if test="${empty reviews}">
    <p>등록된 리뷰가 없습니다.</p>
</c:if>

</body>
</html>
