<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Movie Registration</title>
  <style>
    body {
      font-family: 'Arial', sans-serif;
      margin: 20px;
      padding: 20px;
      background-color: #f4f4f4;
    }

    h2 {
      color: #333;
    }

    form {
      max-width: 400px;
      margin: 0 auto;
      background-color: #fff;
      padding: 20px;
      border-radius: 5px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    label {
      display: block;
      margin-bottom: 8px;
      color: #555;
    }

    input,
    select {
      width: 100%;
      padding: 10px;
      margin-bottom: 15px;
      box-sizing: border-box;
      border: 1px solid #ccc;
      border-radius: 4px;
    }

    button {
      background-color: #4caf50;
      color: #fff;
      padding: 10px 15px;
      border: none;
      border-radius: 4px;
      cursor: pointer;
    }

    button:hover {
      background-color: #45a049;
    }
  </style>
</head>
<body>
<h2>Movie Registration Form</h2>
<form action="register" method="post">
  <label for="title">Title:</label>
  <input type="text" id="title" name="title" required><br>

  <label for="genre">Genre:</label>
  <select id="genre" name="genre" required>
    <option value="ACTION">ACTION</option>
    <option value="COMEDY">COMEDY</option>
    <option value="DRAMA">DRAMA</option>
  </select><br>

  <label for="memberId">Member ID:</label>
  <input type="text" id="memberId" name="memberId" required><br>

  <label for="releaseDate">Release Date (yyyy-MM-dd):</label>
  <input type="text" id="releaseDate" name="releaseDate" required><br>

  <label for="endDate">End Date (yyyy-MM-dd):</label>
  <input type="text" id="endDate" name="endDate" required><br>

  <label for="showing">Is Showing:</label>
  <input type="checkbox" id="showing" name="showing" checked><br>

  <button type="submit">Register Movie</button>
</form>
</body>
</html>
