package com.tuk.moviemaker.review.entity;

import com.tuk.moviemaker.member.entity.Member;
import com.tuk.moviemaker.movie.entity.Movie;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@Table(name = "Review")
@Getter
@NoArgsConstructor
public class Review {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "review_id")
    private Long id;

    @Column(name = "content")
    private String content;
    
    @Column(name = "rating")
    private double rating;

    @ManyToOne
    @JoinColumn(name = "movie_id")
    private Movie movie;

    @ManyToOne
    @JoinColumn(name = "member_id")
    private Member member;


    public Review(String content, Double rating, Movie movie, Member member) {
        this.content = content;
        this.rating = rating;
        this.movie = movie;
        this.member = member;
    }
}
