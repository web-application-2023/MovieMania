package com.tuk.moviemaker.member.servelt;

import com.tuk.moviemaker.member.dao.MemberDao;
import com.tuk.moviemaker.member.entity.Member;
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

@WebServlet("/signup")
public class MemberRegisterServlet extends HttpServlet {

    private MemberDao memberDao;

    // ServletConfig를 사용하여 EntityManagerFactory를 초기화합니다.
    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        EntityManagerFactory emf = (EntityManagerFactory) config.getServletContext().getAttribute("emf");
        EntityManager em = emf.createEntityManager();
        memberDao = new MemberDao(em);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        request.getRequestDispatcher("/signup.jsp").forward(request, response);
    }


    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        // 요청으로부터 사용자 정보를 받습니다.
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // 새 Member 객체를 생성하고 값을 설정합니다.
        Member member = new Member(name, email, password);

        // MemberDao를 사용하여 데이터베이스에 저장합니다.
        memberDao.save(member);

        response.sendRedirect("/login");
    }
}
