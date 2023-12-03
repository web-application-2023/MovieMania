<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>영화 등록</title>
  <style>
    body {
      font-family: 'Arial', sans-serif;
      margin: 20px;
      padding: 20px;
      background-color: #f4f4f4;
    }

    h2 {
      color: #333;
      text-align: center;
    }

    form {
      max-width: 400px;
      margin: 0 auto;
      background-color: #fff;
      padding: 20px;
      border-radius: 8px;
      box-shadow: 0 0 15px rgba(0, 0, 0, 0.2);
    }

    label {
      display: block;
      margin-bottom: 8px;
      color: #555;
      font-size: 14px;
    }

    input,
    select {
      width: 100%;
      padding: 10px;
      margin-bottom: 15px;
      box-sizing: border-box;
      border: 1px solid #ccc;
      border-radius: 4px;
      font-size: 14px;
    }

    button {
      background-color: #4caf50;
      color: #fff;
      padding: 12px 20px;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      font-size: 16px;
      transition: background-color 0.3s;
    }

    button:hover {
      background-color: #45a049;
    }
  </style>
</head>
<body>
<h2>영화 등록 양식</h2>

<%-- 에러 메시지가 존재하는지 확인하고 있다면 출력 --%>
<% if (request.getAttribute("error") != null) { %>
<script>
  alert("<%= request.getAttribute("error") %>");
</script>
<% } %>

<form action="register" method="post">
  <label for="title">제목</label>
  <input type="text" id="title" name="title" required><br>

  <label for="genre">장르</label>
  <select id="genre" name="genre" required>
    <% for (com.tuk.moviemaker.movie.entity.Genre genre : com.tuk.moviemaker.movie.entity.Genre.values()) { %>
    <option value="<%= genre %>"><%= genre.getName() %></option>
    <% } %>
  </select><br>

  <label for="releaseDate">개봉일 (yyyy-MM-dd):</label>
  <input type="text" id="releaseDate" name="releaseDate" required><br>

  <label for="endDate">종료일 (yyyy-MM-dd):</label>
  <input type="text" id="endDate" name="endDate" required><br>

  <label for="showing">상영 여부</label>
  <input type="checkbox" id="showing" name="showing" value="true" checked><br>

  <button type="submit">영화 등록</button>
</form>
</body>
</html>
