package com.tuk.moviemaker;

import com.tuk.moviemaker.movie.dao.MovieDao;
import com.tuk.moviemaker.movie.entity.Movie;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/main")
public class MainServlet extends HttpServlet {

    private MovieDao movieDao;

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        EntityManagerFactory emf = (EntityManagerFactory) config.getServletContext()
            .getAttribute("emf");
        EntityManager em = emf.createEntityManager();
        movieDao = new MovieDao(em);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        int page = 1; // 기본 페이지 번호
        int pageSize = 4; // 페이지 당 영화 수

        try {
            page = Integer.parseInt(request.getParameter("page"));
            pageSize = Integer.parseInt(request.getParameter("pageSize"));
        } catch (NumberFormatException e) {
            // 페이지 번호나 페이지 크기가 제공되지 않았거나 잘못된 경우, 기본값 사용
        }

        List<Movie> movies = movieDao.findMoviesWithPagination(page, pageSize);

        long totalMovies = movieDao.countMovies();
        int totalPages = (int) Math.ceil((double) totalMovies / pageSize);

        request.setAttribute("movies", movies);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        request.getRequestDispatcher("/mainPage.jsp").forward(request, response);
    }
}
