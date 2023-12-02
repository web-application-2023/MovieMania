package com.tuk.moviemaker.member.dao;

import com.tuk.moviemaker.member.entity.Member;
import javax.persistence.EntityManager;

public class MemberDao {
    private EntityManager em;

    public MemberDao(EntityManager em) {
        this.em = em;
    }

    public Member findById(Long id) {
        return em.find(Member.class, id);
    }

    public void save(Member member) {
        em.getTransaction().begin();
        em.persist(member);
        em.getTransaction().commit();
    }
}
