package com.tuk.moviemaker.movie.servlet;

import com.tuk.moviemaker.movie.dao.MovieDao;
import com.tuk.moviemaker.movie.entity.Movie;
import com.tuk.moviemaker.review.dao.ReviewDao;


import com.tuk.moviemaker.review.entity.Review;
import java.util.List;
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

@WebServlet("/info")
public class MovieInfoServlet extends HttpServlet {

    private ReviewDao reviewDao;
    private MovieDao movieDao;

    // ServletConfig를 사용하여 EntityManagerFactory를 초기화합니다.
    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        EntityManagerFactory emf = (EntityManagerFactory) config.getServletContext()
            .getAttribute("emf");
        EntityManager em = emf.createEntityManager();
        reviewDao = new ReviewDao(em);
        movieDao = new MovieDao(em);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        int movie_id = 1;
        int page = 1; // 기본 페이지 번호
        int pageSize = 4; // 페이지 당 리 수

        movie_id = Integer.parseInt(request.getParameter("movie_id"));
        try {
            page = Integer.parseInt(request.getParameter("page"));
            pageSize = Integer.parseInt(request.getParameter("pageSize"));
            // 특정 영화 정보 가져오기
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }

        Movie movie = movieDao.findById(Long.valueOf(movie_id));
        List<Review> reviews = reviewDao.findReviewsWithPagination(page, pageSize, Long.valueOf(movie_id));
        long totalMovies = reviewDao.countReviews();
        int totalPages = (int) Math.ceil((double) totalMovies / pageSize);

        // 영화 정보를 JSP로 전달
        request.setAttribute("movie", movie);
        request.setAttribute("reviews", reviews);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        // JSP 페이지로 포워딩
        RequestDispatcher dispatcher = request.getRequestDispatcher("/movieInfo.jsp");
        dispatcher.forward(request, response);
    }
}
