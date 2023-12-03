package com.tuk.moviemaker.movie.entity;

import com.tuk.moviemaker.member.entity.Member;
import java.time.LocalDate;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "Movie")
@Getter
@NoArgsConstructor
public class Movie {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "Title")
    private String title;

    @Enumerated(EnumType.STRING)
    @Column(name = "Genre")
    private Genre genre;

    @ManyToOne
    @JoinColumn(name = "Member_ID")
    private Member member;

    @Column(name = "Release_Date")
    private LocalDate releaseDate;

    @Column(name = "End_Date")
    private LocalDate endDate;

    @Column(name = "Showing")
    private boolean showing;

    @Column(name = "Registration_Date", updatable = false)
    private LocalDate registrationDate;

    @Column(name = "Image_Url", nullable = true) // null 허용
    private String imageUrl;

    public Movie(String title, Genre genre, Member member, LocalDate releaseDate, LocalDate endDate,
        boolean showing, LocalDate registrationDate, String imageUrl) {
        this.title = title;
        this.genre = genre;
        this.member = member;
        this.releaseDate = releaseDate;
        this.endDate = endDate;
        this.showing = showing;
        this.registrationDate = registrationDate;
        this.imageUrl = imageUrl;
    }
}
