package com.tuk.moviemaker.review.servlet;

import com.tuk.moviemaker.member.dao.MemberDao;
import com.tuk.moviemaker.member.entity.Member;
import com.tuk.moviemaker.movie.dao.MovieDao;
import com.tuk.moviemaker.movie.entity.Movie;
import com.tuk.moviemaker.review.dao.ReviewDao;
import com.tuk.moviemaker.review.entity.Review;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/review")
public class ReviewServlet extends HttpServlet {

    private ReviewDao reviewDao;
    private MemberDao memberDao;
    private MovieDao movieDao;

    // ServletConfig를 사용하여 EntityManagerFactory를 초기화합니다.
    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        EntityManagerFactory emf = (EntityManagerFactory) config.getServletContext().getAttribute("emf");
        EntityManager em = emf.createEntityManager();
        reviewDao = new ReviewDao(em);
        memberDao = new MemberDao(em);
        movieDao = new MovieDao(em);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        try {
            // 요청으로부터 사용자 정보를 받습니다.
            String content = request.getParameter("content");
            Double rating = Double.valueOf(request.getParameter("rating"));
            Long movie_id = Long.valueOf(request.getParameter("movie_id"));
            Long member_id = Long.valueOf(request.getParameter("member_id"));

            // id로 영화와 멤버를 찾는다.
            Movie movie = movieDao.findById(movie_id);
            Member member = memberDao.findById(member_id);

            // 새 Member 객체를 생성하고 값을 설정합니다.
            Review review = new Review(content, rating, movie, member);

            // MemberDao를 사용하여 데이터베이스에 저장합니다.
            reviewDao.save(review);

            // 처리 결과를 클라이언트에게 응답합니다.
            response.getWriter().print("Review created with ID: " + review.getId());

            // 리뷰 등록 후에 지정된 URL로 리다이렉트합니다.
            response.sendRedirect("/info?movie_id=" + movie_id);

        } catch (Exception e) {
            // 날짜 변환 오류 처리
            e.printStackTrace();
        }
    }
}
