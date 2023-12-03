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

      /* 영화 정보 출력 스타일 */
      .movie-info {
        display: flex;
        background-color: #ffffff;
        padding: 20px;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        margin-bottom: 20px;
        border-radius: 10px;
      }

      .movie-image {
        flex: 1; /* 이미지 컬럼에 비중을 설정 */
        max-width: 50%; /* 최대 너비 제한 */
        padding-right: 20px; /* 오른쪽 패딩 추가 */
      }

      .movie-details {
        flex: 1; /* 상세 정보 컬럼에 비중을 설정 */
        padding-left: 20px; /* 왼쪽 패딩 추가 */
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

      /* 페이지네이션 스타일 조정 */
      .pagination-container {
        max-width: 600px; /* 리뷰 목록과 동일한 최대 너비 */
        margin: 20px auto; /* 중앙 정렬 및 상하 마진 추가 */
        text-align: center; /* 텍스트 중앙 정렬 */
      }

      .pagination {
        display: flex; /* Flexbox 사용 */
        justify-content: center; /* 가운데 정렬 */
        list-style: none; /* 리스트 스타일 제거 */
        padding: 0; /* 기본 패딩 제거 */
      }

      .pagination li {
        margin: 0 5px; /* 좌우 마진 추가 */
      }

      .pagination a, .pagination span {
        margin: 0 5px;
        padding: 8px 12px;
        border-radius: 5px;
        display: inline-block; /* 인라인 블록 요소로 변경 */
      }

      .pagination a {
        background-color: #007bff;
        color: #ffffff;
        text-decoration: none;
      }

      .pagination span {
        background-color: #f2f2f2;
        color: #495057;
      }

      .pagination a:hover {
        background-color: #0056b3;
      }

      /* 리뷰 등록 폼 스타일 개선 */
      form {
        background-color: #ffffff;
        box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        border-radius: 15px;
        padding: 30px;
        max-width: 600px;
        margin: 30px auto;
        border: 1px solid #ddd;
      }

      .form-row {
        display: flex;
        align-items: center;
        margin-bottom: 20px;
      }

      .form-row label {
        margin-right: 10px;
      }

      textarea {
        width: 100%;
        padding: 12px;
        margin-bottom: 20px;
        border: 1px solid #ced4da;
        border-radius: 8px;
        box-sizing: border-box;
        font-size: 14px;
        height: 150px; /* 높이를 설정하여 더 많은 텍스트가 보이도록 합니다. */
      }


      label {
        display: block;
        font-size: 20px;
        color: #333;
      }

      input[type="number"], textarea {
        padding: 10px;
        border: 1px solid #ced4da;
        border-radius: 8px;
        box-sizing: border-box;
        font-size: 14px;
      }

      button {
        width: 100%;
        background-color: #007bff;
        color: #fff;
        padding: 15px 20px;
        border: none;
        border-radius: 8px;
        font-size: 16px;
        cursor: pointer;
        transition: background-color 0.3s ease;
      }

      button:hover {
        background-color: #004085;
      }


      /* 리뷰 목록 스타일 */
      ul.review-list {
        max-width: 600px; /* 최대 너비 설정 */
        margin: 0 auto; /* 중앙 정렬 */
        padding: 0;
      }

      /* 리뷰 카드 스타일 */
      .review-card {
        background-color: #ffffff;
        padding: 15px;
        margin-bottom: 20px;
        box-shadow: 0 3px 6px rgba(0, 0, 0, 0.1);
        border-radius: 10px;
        transition: box-shadow 0.3s, transform 0.3s;
      }

      .review-card:hover {
        box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);
        transform: translateY(-5px);
      }

      /* 리뷰 헤더 스타일 */
      .review-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 12px;
      }

      .review-author {
        font-weight: bold;
        color: #007bff;
      }

      /* 리뷰 본문 스타일 */
      .review-content {
        font-size: 16px;
        color: #495057;
        margin-bottom: 12px;
        text-align: left;
      }

      /* 별점 스타일 */
      .star-rating {
        color: #ffc107;
        font-size: 20px;
      }

      .full-star, .half-star {
        color: #ffc107;
      }

      /* 페이지네이션 스타일 개선 */
      .pagination {
        padding: 20px 0;
      }

      .pagination a, .pagination span {
        margin: 0 5px;
        padding: 10px 15px;
        border-radius: 5px;
      }

      .pagination a {
        background-color: #007bff;
        color: #ffffff;
      }

      .pagination span {
        background-color: #f2f2f2;
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
    <div class="movie-image">
        <img src="${movie.imageUrl}" alt="${movie.title}" style="max-width: 100%; height: auto;">
    </div>
    <div class="movie-details">
        <p><strong>&#128249; 제목:</strong> ${movie.title}</p>
        <p><strong>&#127902; 장르:</strong> ${movie.genre.name}</p>
        <p><strong>&#128197; 상영 여부:</strong> ${movie.showing ? '상영 중' : '상영 종료'}</p>
        <p><strong>&#128197; 개봉일:</strong> ${movie.releaseDate}</p>
        <p><strong>&#128197; 종료일:</strong> ${movie.endDate}</p>
        <p><strong>&#128221; 등록일:</strong> ${movie.registrationDate}</p>
        <p><strong>&#128100; 등록 회원:</strong> ${movie.member.name}</p>
    </div>
</div>


<!-- 리뷰 등록 -->
<h2>리뷰 등록</h2>

<form action="/review" method="post">
    <input type="hidden" id="movie_id" name="movie_id" value="${movie.id}">

    <div class="form-row">
        <label for="rating">평점</label>
        <input type="number" name="rating" id="rating" min="0" max="5" step="0.5" required>
    </div>

    <textarea name="content" id="content" placeholder="리뷰 내용을 입력하세요" required></textarea>

    <button type="submit" value="리뷰 등록">리뷰 등록</button>
</form>

<!-- 리뷰 출력 -->
<h2>리뷰 목록</h2>
<c:if test="${not empty reviews}">
    <ul class="review-list">
        <c:forEach var="review" items="${reviews}">
            <li class="review-card">
                <div class="review-header">
                    <div class="review-author">&#128100; ${review.member.name}</div>
                    <div class="star-rating">
                        <c:forEach begin="1" end="${review.rating}" step="1" var="star">
                            <span class="full-star">&#9733;</span> <!-- 풀 스타 -->
                        </c:forEach>
                        <c:if test="${review.rating % 1 != 0}">
                            <span class="half-star">&#9734;</span> <!-- 하프 스타 -->
                        </c:if>
                    </div>
                </div>
                <p class="review-content">${review.content}</p>
            </li>
        </c:forEach>
    </ul>
</c:if>

<c:if test="${empty reviews}">
    <p>등록된 리뷰가 없습니다.</p>
</c:if>

<!-- 페이지네이션 -->
<div class="pagination-container">
    <c:if test="${not empty reviews}">
        <ul class="pagination">
            <!-- 이전 페이지 -->
            <c:if test="${currentPage > 1}">
                <li><a href="?movie_id=${movie.id}&page=${currentPage - 1}&pageSize=${pageSize}">이전 페이지</a></li>
            </c:if>

            <!-- 현재 페이지 -->
            <li><span>${currentPage}</span></li>

            <!-- 다음 페이지 -->
            <c:if test="${currentPage < totalPages}">
                <li><a href="?movie_id=${movie.id}&page=${currentPage + 1}&pageSize=${pageSize}">다음 페이지</a></li>
            </c:if>
        </ul>
    </c:if>
</div>

</body>
</html>
