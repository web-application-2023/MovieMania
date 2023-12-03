package com.tuk.moviemaker.member.dao;

import com.tuk.moviemaker.member.entity.Member;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.TypedQuery;

public class MemberDao {
    private EntityManager em;

    public MemberDao(EntityManager em) {
        this.em = em;
    }

    public Member findById(Long id) {
        return em.find(Member.class, id);
    }

    public Member findByEmail(String email) {
        TypedQuery<Member> query = em.createQuery("SELECT m FROM Member m WHERE m.email = :email", Member.class);
        query.setParameter("email", email);
        try {
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null; // 해당 이메일에 대한 Member를 찾을 수 없을 경우 null 반환
        }
    }

    public void save(Member member) {
        em.getTransaction().begin();
        em.persist(member);
        em.getTransaction().commit();
    }
}
