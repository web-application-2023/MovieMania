package com.tuk.moviemaker.review.dao;

import com.tuk.moviemaker.review.entity.Review;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;

public class ReviewDao {

    private final EntityManager em;

    public ReviewDao(EntityManager em) {
        this.em = em;
    }

    public Review findById(Long id) {
        return em.find(Review.class, id);
    }
    public List<Review> findReviewsWithPagination(int page, int pageSize, Long movie_id) {
        TypedQuery<Review> query = em.createQuery("SELECT m FROM Review m WHERE m.movie.id = :movieId", Review.class);
        query.setParameter("movieId", movie_id);
        query.setFirstResult((page - 1) * pageSize);
        query.setMaxResults(pageSize);
        return query.getResultList();
    }

    public void save(Review review) {
        em.getTransaction().begin();
        em.persist(review);
        em.getTransaction().commit();
    }

    public long countReviews() {
        return em.createQuery("SELECT COUNT(m) FROM Review m", Long.class)
            .getSingleResult();
    }
}
