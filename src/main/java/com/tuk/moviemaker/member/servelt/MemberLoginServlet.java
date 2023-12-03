package com.tuk.moviemaker.member.servelt;

import com.tuk.moviemaker.member.dao.MemberDao;
import com.tuk.moviemaker.member.entity.Member;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/login")
public class MemberLoginServlet extends HttpServlet {
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
    request.getRequestDispatcher("/login.jsp").forward(request, response);
  }

  protected void doPost(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {

    try {
      request.setCharacterEncoding("utf-8");
    }
    catch (UnsupportedEncodingException e) {
      e.printStackTrace();
    }

    // 요청으로부터 사용자 정보를 받습니다.
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    Member member = memberDao.findByEmail(email);

    HttpSession session = request.getSession();

    if (member != null) {
      if(email.equals(member.getEmail()) && password.equals(member.getPassword()) ) {
        session.setAttribute("user_email", member.getEmail());
        session.setAttribute("user_name", member.getName());

        response.sendRedirect("/register");
      }
      else {
        response.sendRedirect("login_fail.jsp");
      }
    }
    else {
      response.sendRedirect("login_fail.jsp");
    }
  }
}
