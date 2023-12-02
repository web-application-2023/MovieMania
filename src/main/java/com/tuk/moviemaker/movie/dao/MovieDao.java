package com.tuk.moviemaker.movie.dao;

import com.tuk.moviemaker.movie.entity.Movie;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;

public class MovieDao {
    private EntityManager em;

    public MovieDao(EntityManager em) {
        this.em = em;
    }

    public Movie findById(Long id) {
        return em.find(Movie.class, id);
    }

    public void save(Movie movie) {
        em.getTransaction().begin();
        em.persist(movie);
        em.getTransaction().commit();
    }

    public List<Movie> findMoviesWithPagination(int page, int pageSize) {
        TypedQuery<Movie> query = em.createQuery("SELECT m FROM Movie m", Movie.class);
        query.setFirstResult((page - 1) * pageSize);
        query.setMaxResults(pageSize);
        return query.getResultList();
    }

    public Long countMovies() {
        return em.createQuery("SELECT COUNT(m) FROM Movie m", Long.class)
            .getSingleResult();
    }
}
