package com.tuk.moviemaker.movie.servlet;

import com.tuk.moviemaker.member.dao.MemberDao;
import com.tuk.moviemaker.movie.dao.MovieDao;
import com.tuk.moviemaker.movie.entity.Movie;
import com.tuk.moviemaker.review.dao.ReviewDao;


import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/movie/info")
public class MovieInfoServlet extends HttpServlet {

    private ReviewDao reviewDao;
    private MemberDao memberDao;
    private MovieDao movieDao;

    // ServletConfig를 사용하여 EntityManagerFactory를 초기화합니다.
    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        EntityManagerFactory emf = (EntityManagerFactory) config.getServletContext()
            .getAttribute("emf");
        EntityManager em = emf.createEntityManager();
        reviewDao = new ReviewDao(em);
        memberDao = new MemberDao(em);
        movieDao = new MovieDao(em);
    }


    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try {
            Long movie_id = Long.parseLong(request.getParameter("movie_id"));
            // 특정 영화 정보 가져오기
            Movie movie = movieDao.findById(movie_id);
            // 영화 정보를 JSP로 전달
            request.setAttribute("movie", movie);
            // JSP 페이지로 포워딩
            RequestDispatcher dispatcher = request.getRequestDispatcher("/movieInfo.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
