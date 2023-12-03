<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>회원 가입</title>
  <style>
    body {
      font-family: 'Arial', sans-serif;
      background-color: #f4f4f4;
      text-align: center;
      margin: 50px;
    }

    h2 {
      color: #333;
    }

    form {
      width: 300px;
      margin: 0 auto;
      background-color: #fff;
      padding: 20px;
      border-radius: 8px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    label {
      display: block;
      margin-bottom: 8px;
      color: #333;
    }

    input {
      width: 100%;
      padding: 10px;
      margin-bottom: 15px;
      box-sizing: border-box;
      border: 1px solid #ccc;
      border-radius: 4px;
    }

    button {
      width: 100%;
      padding: 10px;
      background-color: #4caf50;
      color: white;
      cursor: pointer;
      border: none;
      border-radius: 4px;
    }

    button:hover {
      background-color: #45a049;
    }
  </style>
  <script>
    function handleRegistration() {
        alert("회원가입에 성공하였습니다!");
    }
  </script>
</head>
<body>
<h2>회원 가입</h2>
<form action="signup" method="post", accept-charset="utf-8">
  <label for="name">이름:</label>
  <input type="text" id="name" name="name" required><br>

  <label for="email">이메일:</label>
  <input type="email" id="email" name="email" required><br>

  <label for="password">비밀번호:</label>
  <input type="password" id="password" name="password" required><br>

  <button type="submit" onclick="handleRegistration()">가입하기</button>
</form>

</body>
</html>
