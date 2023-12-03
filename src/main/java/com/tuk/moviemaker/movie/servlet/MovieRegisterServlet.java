package com.tuk.moviemaker.movie.servlet;

import com.tuk.moviemaker.member.dao.MemberDao;
import com.tuk.moviemaker.member.entity.Member;
import com.tuk.moviemaker.movie.dao.MovieDao;
import com.tuk.moviemaker.movie.entity.Genre;
import com.tuk.moviemaker.movie.entity.Movie;
import java.io.IOException;
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
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/register")
public class MovieRegisterServlet extends HttpServlet {

  private MovieDao movieDao;
  private MemberDao memberDao;

  @Override
  public void init(ServletConfig config) throws ServletException {
    super.init(config);
    EntityManagerFactory emf = (EntityManagerFactory) config.getServletContext()
        .getAttribute("emf");
    EntityManager em = emf.createEntityManager();
    movieDao = new MovieDao(em);
    memberDao = new MemberDao(em);
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
      System.out.println(registrationDate);
      // Movie 객체 생성
      Movie movie = new Movie(title, genre, loggedInUser, releaseDate, endDate, showing,
          registrationDate);

      // MovieDao를 사용하여 데이터베이스에 저장
      movieDao.save(movie);

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