package com.tuk.moviemaker.movie.servlet;

import com.amazonaws.auth.AWSCredentials;
import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.regions.Regions;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.PutObjectRequest;
import com.tuk.moviemaker.member.dao.MemberDao;
import com.tuk.moviemaker.member.entity.Member;
import com.tuk.moviemaker.movie.dao.MovieDao;
import com.tuk.moviemaker.movie.entity.Genre;
import com.tuk.moviemaker.movie.entity.Movie;
import io.github.cdimascio.dotenv.Dotenv;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Date;
import java.util.Optional;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@WebServlet("/register")
@MultipartConfig
public class MovieRegisterServlet extends HttpServlet {

  private MovieDao movieDao;
  private MemberDao memberDao;
  private AmazonS3 s3Client;

  @Override
  public void init(ServletConfig config) throws ServletException {
    super.init(config);
    EntityManagerFactory emf = (EntityManagerFactory) config.getServletContext()
        .getAttribute("emf");
    EntityManager em = emf.createEntityManager();
    movieDao = new MovieDao(em);
    memberDao = new MemberDao(em);
    Dotenv dotenv = Dotenv.load();
    String accessKey = dotenv.get("AWS_ACCESS_KEY_ID");
    String secretKey = dotenv.get("AWS_SECRET_ACCESS_KEY");

    AWSCredentials credentials = new BasicAWSCredentials(accessKey, secretKey);

    s3Client = AmazonS3ClientBuilder.standard()
        .withCredentials(new AWSStaticCredentialsProvider(credentials))
        .withRegion(Regions.AP_NORTHEAST_2)
        .build();
  }

  protected void doGet(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {
    request.getRequestDispatcher("/registerMovie.jsp").forward(request, response);
  }

  protected void doPost(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {
    request.setCharacterEncoding("UTF-8");
    HttpSession session = request.getSession();
    Boolean isLogin = session.getAttribute("user_name") != null;

    try {
      String userEmail = (String) session.getAttribute("user_email");
      Member loggedInUser = memberDao.findByEmail(userEmail);
      // 요청 파라미터에서 필요한 정보 읽기
      String title = request.getParameter("title");
      Genre genre = Genre.valueOf(request.getParameter("genre"));

      String releaseDateString = request.getParameter("releaseDate");
      LocalDate releaseDate = convertStringToLocalDate(releaseDateString);

      String endDateString = request.getParameter("endDate");
      LocalDate endDate = convertStringToLocalDate(endDateString);

      boolean showing = Boolean.parseBoolean(request.getParameter("showing"));

      // 현재 시각을 얻어와서 등록일로 사용
      LocalDate registrationDate = LocalDate.now();

      // Part 객체를 통해 파일 데이터 가져오기
      Part filePart = request.getPart("image"); // <input type="file" name="image">
      String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString(); // MSIE fix.

      if (filePart != null && !fileName.isEmpty()) {
        // 임시 파일 저장
        File tempFile = File.createTempFile("upload_", fileName);
        filePart.write(tempFile.getAbsolutePath());

        String bucketName = "movie-mania-2023-tuk";
        String fileKey = fileName;

        // S3에 파일 업로드
        s3Client.putObject(new PutObjectRequest(bucketName, fileKey, tempFile));
        String fileUrl = s3Client.getUrl(bucketName, fileKey).toString();

        // 파일 URL을 Movie 객체에 설정
        Movie movie = new Movie(title, genre, loggedInUser, releaseDate, endDate, showing,
            registrationDate, fileUrl);

        // MovieDao를 사용하여 데이터베이스에 저장
        movieDao.save(movie);

        // 임시 파일 삭제
        tempFile.delete();
      }

      // 영화 등록 성공 시 어떤 페이지로 이동할지 설정
      response.sendRedirect("/main");

    } catch (ParseException e) {
      // 날짜 변환 오류 처리
      request.setAttribute("error", "올바른 날짜 형식을 입력해주세요.");

      // 경고창을 사용하기 위해 JavaScript를 표시하지 않고 바로 JSP로 포워딩합니다.
      RequestDispatcher dispatcher = request.getRequestDispatcher("/registerMovie.jsp");
      dispatcher.forward(request, response);
    }
  }


  private LocalDate convertStringToLocalDate(String dateString) throws ParseException {
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    Date utilDate = dateFormat.parse(dateString);
    return utilDate.toInstant().atZone(java.time.ZoneId.systemDefault()).toLocalDate();
  }
}