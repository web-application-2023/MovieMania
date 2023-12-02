<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>회원 가입</title>
</head>
<body>
<h2>회원 가입</h2>
<form action="member" method="post">
  <label for="name">이름:</label>
  <input type="text" id="name" name="name" required><br>

  <label for="email">이메일:</label>
  <input type="email" id="email" name="email" required><br>

  <label for="password">비밀번호:</label>
  <input type="password" id="password" name="password" required><br>

  <button type="submit">가입하기</button>
</form>

<c:if test="${not empty param.message}">
  <p>${param.message}</p>
</c:if>
</body>
</html>
