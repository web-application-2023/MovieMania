package com.tuk.moviemaker.review.dao;

import com.tuk.moviemaker.review.entity.Review;

import javax.persistence.EntityManager;

public class ReviewDao {

    private EntityManager em;

    public ReviewDao(EntityManager em) {
        this.em = em;
    }

    public Review findById(Long id) {
        return em.find(Review.class, id);
    }

    public void save(Review review) {
        em.getTransaction().begin();
        em.persist(review);
        em.getTransaction().commit();
    }
}
