<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>영화 정보</title>
    <!-- 여기에 필요한 스타일 시트 등을 추가할 수 있습니다. -->
</head>
<body>
<h2>영화 정보</h2>

<c:if test="${not empty movie}">
    <div class="movie-info">
        <div class="movie-title">${movie.title}</div>
        <div class="movie-detail">장르: ${movie.genre.name}</div>
        <div class="movie-detail">개봉일: ${movie.releaseDate}</div>
        <div class="movie-detail">상영 종료일: ${movie.endDate}</div>
        <div class="movie-detail">상영 중 여부: ${movie.showing ? 'O' : 'X'}</div>
        <div class="movie-detail">등록일: ${movie.registrationDate}</div>
    </div>
    <!-- 기타 필요한 영화 정보를 표시할 수 있습니다. -->

    <!-- 리뷰 정보를 표시할 예시 -->
    <h3>리뷰</h3>
    <c:forEach var="review" items="${movie.reviews}">
        <div class="reviews">
            <div class="review-writer">${review.member.name}</div>
            <div class="review-content">${review.content}</div>
        </div>
    </c:forEach>
</c:if>

<c:if test="${empty movie}">
    <p>영화 정보를 찾을 수 없습니다.</p>
</c:if>
</body>
</html>

<%--<h1>Movie Information</h1>--%>
<%--<% Movie movie = (Movie) request.getAttribute("movie"); %>--%>
<%--<p>Title: <%= movie.getTitle() %></p>--%>
<%--<p>Genre: <%= movie.getGenre() %></p>--%>
<%--<p>Release Date: <%= movie.getReleaseDate() %></p>--%>
<!-- 기타 영화 정보들을 표시 -->
